Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734A369D56
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584755; cv=none; b=SORK/2p8FhonK+tL7GgwJGDZunq9hKGm/P64lM/PbRtkbu5e3isNO9GxhDOTqc4W9fBbDH+Jql6h6Dg7ir9bVnENzp2V40+Wbmj7s6LhJXrA/Ksy6rq0oXNHBkUJjt47v0jQbu07x7Hd09AfBX78Tk4gXUBd/m93EgbIvLOMueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584755; c=relaxed/simple;
	bh=sh7qBbEG9XxD9qZwHAir+0eYpVhB9rcC/JQ3U37GBrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4Jrv6/4nQkRgE6fxcuGwEKeb48DFrxC3YP2b+i93TKZmSt4UMVCM1vcVv24wGPrlFlum2lwY3wiUzSGumPv0DCY4ntHdiek1ZAfXuCM7ER2DvmINGLtaXvIR8Lqpn0nxb575PGsFG6OoIDrDE2FXZb6EG32xaYfDML8zFHAMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaQKaVjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaQKaVjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BD1F00A3E;
	Mon, 24 Aug 2026 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584754;
	bh=QrRWZd/Y9rBWbYGS3nRpDpsciWnSxbveMBFDlN0j238=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HaQKaVjDC/fPL7v9dy6Tj0Ty/C5kSnzRjiTijtqYpfkFEfxfo8eJ11134Qj8lWmB6
	 0+j7VsUd2P6IBjF5uR0xZgdi60lB+y7JyBUYqilxL4guqsFMe/dzY4hiR9QC6/VwO+
	 2CxkUtjWMdOgqrw+mRMVIllf12LjcW4QpUOhViqX8ZKzMd/Sxwqx+7pN083z8dXCdk
	 A05hdlXQHGBBpLYd6rJHrXNtfw89r0mkiqU7wxV4F+q3NG8BRFt+vG0/UmSfXDQ5Ic
	 /oNMJ4M3cjknn9oeK0sEakw2NxU/eSbIksT2LyILqrsjQBELp+z8Oq6T4Ya7j/DBWk
	 MoK2YvlNzM71w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 24 Aug 2026 11:19:12 -0400
Message-ID: <20260824151912.3764775-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082045-earthly-vengeful-03d1@gregkh>
References: <2026082045-earthly-vengeful-03d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linmao Li <lilinmao@kylinos.cn>

[ Upstream commit c83e79c0842ed29860648bcce5022ef0ba5001c6 ]

byd_disconnect() uses timer_delete() before freeing the driver's private
data.  This does not wait for a running byd_clear_touch() callback, which
dereferences the private data and its psmouse pointer.  A callback racing
with disconnect can therefore access the private data after it has been
freed.  The timer can also still be re-armed by byd_process_byte() while
the disconnect is in progress.

Use timer_shutdown_sync() before freeing the private data: it waits for
a running callback and turns any later re-arm attempt into a no-op.

Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://patch.msgid.link/20260720061259.1601281-1-lilinmao@kylinos.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ changed `del_timer()` to `timer_shutdown_sync()` since 6.12 predates the `del_timer()` → `timer_delete()` rename ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 6e0c5f5a2713d..90553efd25224 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -426,7 +426,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		del_timer(&priv->timer);
+		timer_shutdown_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
-- 
2.53.0

