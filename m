Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050590;
	b=38PgZ9fXsm2gBslSOrAu8J2jqx7EbY1JuKlnoWEb0vX65dashrycuxltzRlgghvidJ5T
	 RH6hkjZhkX39i85kljryODB4zOkZiIHYFDF++/oVxrxNDIlvM3rWZnxnt2h6zy5Vbvpkb
	 fLobmWXivvCttMBbuBwNXr1U1XcPx9aZ+g56eyHR01JEJS68bqyDoP2UQ9A+ho8EgCHNz
	 R/XDv1ZHuG6zcOO5zm/AVHUeEB7tWfGyS/iBJsrZbpO018jVlUrzc64Et4Tz3DznS5NVx
	 VO41ttonzTqAGNiei+GNr3uZRghT+ZX5mFukyGc0VlXIktVjDnxnq15OHQrEYARSeXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/UknZtE/wVq3sBXZaTsHcyTX5clGRaOeE8h2c0gCe6k=;
	b=sCyCjK6E4w8BxVuzfyJIUU5VLCIAHz89oPEfyp63ANJy7sX4FRutJbhlnSrFybrzjily
	 LXrmtImMXTz900u1BXN3jfd12UGFssIKrdg5utC1JM5KXvIz9lNK0QhuIz88n6rgR1mR/
	 w98nmTp89TooLTrhJU6edMu3P812rCSjuMH6YzFnJguor0SbVU62fC4YPK9k/ssmL8HRk
	 uJ7rcS1GpuI4jMg6RFpuwIvpLmk8nbeQ8FxJeh30Wg4ACXVvEhVVfc1GCcdid9nw5Hd2k
	 iayktwtd6hDqYVJ448bIvSuTtdJnAD25KajzdQpdq8Gnl8Bv3V4BgmVHgp+5ExzU0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbjzRW3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbjzRW3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7751F008A1;
	Sat,  7 Nov 2026 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050589;
	bh=/UknZtE/wVq3sBXZaTsHcyTX5clGRaOeE8h2c0gCe6k=;
	h=From:To:Cc:Subject:Date;
	b=KbjzRW3OH9L5cVFe8E/9jXXCD1oDz/Fg68usZx/R5jsz7xazH+5wQWJOhP0yzYxvl
	 Ddx6KFnHxH8JcIUpYMvCU/gt7N576FcYQXvc3qZJ7OVLEJBVfFfWRH8CaU2h54AvkR
	 yJGOQR/2sQUZBepuKb7oJ2v+X0x5chmWck+etC0ec37edOrqmvZ55r706fDDEd7K/e
	 U3+LlFzKJ3OdHa1E2vaJzj+MgkERRmIXMYVOymzS5Hjiaov23Fr7mrHdfiH/CNbzif
	 YuvkCbvRC2oWfR66ciRH0MVMGKXxS5h5gB3MR63M9fHDKAPC5VKllzFq3Q4dCyQIOW
	 8XmqaV9OL05AQ==
From: Sasha Levin <sashal@kernel.org>
To: francesco.orlando99@libero.it,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: xpad - add GameSir Nova Lite support" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:08 -0500
Message-ID: <20261107062307-failed-5.10-2e6f2e5799f3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062307-failed-5.10-2e6f2e5799f3@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2e6f2e5799f328ca0879dad14d7f3709c7f7496b Mon Sep 17 00:00:00 2001
From: Francesco Orlando <francesco.orlando99@libero.it>
Date: Sun, 11 Oct 2026 18:58:21 +0200
Subject: [PATCH] Input: xpad - add GameSir Nova Lite support

Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040) in
XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
Link: https://patch.msgid.link/20261011165821.72698-1-francesco.orlando99@libero.it
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782ae89..d2eb48d98fead 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -408,6 +408,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
-- 
2.53.0




