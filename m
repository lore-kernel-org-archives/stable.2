Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0904248D9
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582327; cv=none; b=CYPDYRIGagH08BhdvVLhBJSIlsfajurtCdiJrmhfxanWpm45M81wOUE3P+rq6NugwoeANmMmiewTcpsR4+QUg7w6z3L4oAh8DY1GE/dZ+52klIs2gbcKhh3phGk5WWVvtjnh8ax2GbdYR3TKP9nolTTfDyrFxPlydDjTw9hMgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582327; c=relaxed/simple;
	bh=kjb9p1QucN9g2LA4iv0SyVzsIRPipadsH7VkA/Kgj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub0vU47Hz/RXWuTyKVKp9eotMLjHjABmXAYdIjwB2y85yufIvfD6sJ7+xq7s1d6agWRZne+J2VbrJNk+ek1wcNUZUxsVr7L5mBSPTZo09Da1gXnaaQptWuYNcC+cknZ/nzrHdvkuo5fSHJDREgG8LYmSK+DVXF2+KL74tYmtKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnUqJbi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnUqJbi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3603F1F000E9;
	Mon, 24 Aug 2026 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787582325;
	bh=iPDoNyX2Bm+fhas0TYGejFnd0lGEzIckX1mSOYgvBHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnUqJbi32j6B0+ULjy5KpaQ4EycdY+2Lk0GXuMZ/FXzdG52UFEulR/IsEjSXvQqAI
	 O866rQDPuWQ6fYJtO5zm77PbYpWv69xaxi/17DSzKNxRPPIZx6SgjRG+URJ0x7PhrJ
	 +12N1dIj18ak1QcVFBWUCvktRr7vYl4TidOO7YGAYaMXg5KBSEltn/Q0tjLayot3Kg
	 DVbdz9ta8uN8IzFpFAbkQu4Z2DUbSokP/JR1+CJvnn2zNrp1g8IFJHIY+9lcjHwFoe
	 C3w3CwfoSao77+QAldNRyE3+bJjGv24hG+MhmgHzaYtbMIudxY5zU51uyVi6Xjq7p/
	 JzKAMAez2hzEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 24 Aug 2026 10:38:43 -0400
Message-ID: <20260824143843.3402752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082044-recopy-rectified-0081@gregkh>
References: <2026082044-recopy-rectified-0081@gregkh>
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

