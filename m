Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BB466B58
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588775; cv=none; b=kX8JH4DC23RviNdsZs+2olsXLaowPWuXjMRkt3zkcAWVR0nyDXuPeL6uy7hizEUC6QNhVO6+rxJXp3zX2/s0slzfrOHnSB3QwvvfyJfhU4mihSBqDh54O/WdVpC/oSF1+DsKn46Bd0DTVFrOhLE2pC4S6PqqgG8XmOY3GNtpe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588775; c=relaxed/simple;
	bh=75UltGUUgg31PnTWUUR1+sLQD5QTsGoEbNSj2VcfhQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kePIEdV78+OivqP0FNL736YhbhAz14P285SFyh2432U9IWEhUP/ugGZI9X0uB7ePppSyMDafa9vgVuymQfFzpGHYm2MVSqnQWgsLpZnWn31N7xc8YpftUVA47h8MT7+1fUlT45orQLhMhItX/yRtUQp80lu4D/FDyP3gdSnUp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfzfk62t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfzfk62t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F641F000E9;
	Mon, 24 Aug 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588773;
	bh=XesziuQr7ZO8dACYfYJJfAKCHs/gr5K2YrpiHjb5Ulk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vfzfk62tjUedsYldnazF2vZlnDoONr/f0ZQVB7nS+U7NLO8DkYBT2zSJpHlgm87zV
	 op+M5TI7ZaJip7xdpF7NqKSvOAjBFmsMkL5sw+go++rI+QBkVPEml2zvex98KUUGfY
	 9AaFBpg45YioKXarqYPxjVse352DRHPbFcWj2GWUVwcPOJZM7jVo4ZMKczlkNxuZJ+
	 xb+cf9SHn1A5Lf/3Jmc2edGp84SwuVkNTt037Mn4wlJ7yrae7FAhwbqdgmVki2sGBg
	 fbVeWCCjd6Mny9aUIs/hkPR4iudPW7i0uUFMdZULH3FsPewlTJ5EBxxKOEJatWzEjI
	 ndeFKrN1rKnTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 24 Aug 2026 12:26:11 -0400
Message-ID: <20260824162612.4144698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082046-impound-leverage-8771@gregkh>
References: <2026082046-impound-leverage-8771@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 6e0c5f5a2713d..1a0956520dcbe 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -426,7 +426,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		del_timer(&priv->timer);
+		timer_delete_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
-- 
2.53.0

