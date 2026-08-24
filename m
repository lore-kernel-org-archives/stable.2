Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577F35DA79
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583041; cv=none; b=Mx3XJRBsUPQ3jDmAMJ1g4+R9exa4VZF49MH3Ej3XmGa4+C379A3zJp2aoBIenhLiZCwch0UK5i+/smPRppSmT30Wd+EyV+pUftZCdGV8HE2+yryP8dQs4MiZ3Ygx2kVgsqL++clxB4TWFr3vipCA5TfvrhH0Zr80eKNLeAaYQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583041; c=relaxed/simple;
	bh=kjb9p1QucN9g2LA4iv0SyVzsIRPipadsH7VkA/Kgj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOdOGG+wZnsyL/2fBPp5cG6HHhdnNtvTqbqZXXsKGlhRfrwFoXLrYSCA3EMgSNwWsqglvmZkYBiueTCR7gL4oRCqlf1QQbOHUxj3jD33c0auNunX5QqMbq5Zs132wjEbGtGKIkR1BvvgbThbgDzD4oQiv/7qQ8PY9agl+j2jsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+eM53wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+eM53wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDEA1F000E9;
	Mon, 24 Aug 2026 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583039;
	bh=iPDoNyX2Bm+fhas0TYGejFnd0lGEzIckX1mSOYgvBHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h+eM53wV8xkKB2TAujNHHipbQjm2QV8J/33bEUC0STp0CLxBlpMsBkhqTaSnoxLTu
	 p9v2PMHbfoSFZqDdo5rceOPUrUmIssIOTha3IyS572QVCPh4sLVV/y5+xnzDAcVoDv
	 RWcuLfkgdkQ2KRn9AVb9Lq0w7QWbUXf3AZD/DUO8SSx/nlZQOQhuNWj/GRhyjlrVcZ
	 f31RCtFOgzI6W5p3YVQ1WyAMXxPL1+bt/IWAx7gKor2cLFErZwlUxuAUMinYVvKCq3
	 P0/RTVYZukX2tsL0u4VBvXtGu4+XGzcMxrN3sx2ieQ1NFLV1RkBjBkEzQnNItrH+zU
	 yrceHWiaNbufA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 24 Aug 2026 10:50:37 -0400
Message-ID: <20260824145037.3662196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082045-around-contort-ce2c@gregkh>
References: <2026082045-around-contort-ce2c@gregkh>
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
index 221a553f45cd8..cb49f38883020 100644
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

