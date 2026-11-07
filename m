Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047704;
	b=CX87fXKFHpgIFs58b9xlThs7dFl99O23YNGJhTWVHyqnOmFbTwUcZd+bcsmZZRTC7CeZ
	 f2CoQTp5g7sLIG/UoIq4GuqvixaJHFoJNKBFUPvWRIRmUxzkpN38jGR+Ax4wPK8qwqfF6
	 Tg6UscpmJ5fMTthSbMfEd4P/ShbEXM1Ee5w+2te0vtFWvs9T6OMIVJwML023txlz54Fop
	 5hBHqxxeeo7ZsUukPKNE2Ub2Y4tFUYqJuZZRQ3RUW80zqs02wWJZPH4SYnvsFbgDUohaw
	 ObNTgmMWTSaGj3F7lApxBWVFmv9eOof93QEQyesfBFq9ky4GGm/Pk+8FKEVBy7aubXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K/Rq3/kOwrKTylHqiFK624AWMfTgO4PGH1oB4Toakmw=;
	b=Klc6M/K3OwM0erYSGyoxo1Y9fcqDM4M8svZEOXOFvz7CSBcq3EMv0P4sATBwQh1g/5+V
	 l379WiHvLRYARCRwFGsTUP8c2yT5epe47Ixvu1Qm6pYawoIK0/nv5iGiD8mXC0hehnM0n
	 bDpaaFKGP6MC6xIajU2J1gsQULl+ZlYV4oS7xTHrXEvVb6lLhMUzKUIjLfHIEhl21ta/r
	 QNZvDlTiheKP++ARteS06FaRSnZ3puGmOBxtxXOnBZKteyvOWq9ZQOQ9tkTbyiKpidFzu
	 /GCzcZZNfXM2tMJj3TqewkqZ397bIiCoW+0CeZk6Jj3Fm6FNweI6XSGVPPlGR4+Cerw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2J6uFzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56879606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2J6uFzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85591F0089F;
	Sat,  7 Nov 2026 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047704;
	bh=K/Rq3/kOwrKTylHqiFK624AWMfTgO4PGH1oB4Toakmw=;
	h=From:To:Cc:Subject:Date;
	b=I2J6uFzvG7gndDmRjceVbtVJVX6QkQ9EVkDJTgERkn4y5tvi+aKsLPCbjz3xwdQqm
	 051ftOc8DTBRLRKgp71rcqYS/J250R48/PNkRW9f6YKZfZYFrWSU5MuWIq8aVYYdOJ
	 riERfdbipimlwr2elQ+Zh2k3O/w2kdKzH6rNv4pMnYQFuZOraLpa0Y7tF8Djj1zlQZ
	 VeCW9aFuo+k/We3V8K24vGNdaFxqffQRYEUFv7DVJ0Qx+eUTNvD78lFT13Y1vxLXx8
	 amhCTtzs2v6PZx34yvykvZ/UaZc53955c0CR4i1ZJeQ03cyNQAztx21EwfBNqUSXw1
	 a9Zx+aj7hHyjQ==
From: Sasha Levin <sashal@kernel.org>
To: francesco.orlando99@libero.it,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: xpad - add GameSir Nova Lite support" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:02 -0500
Message-ID: <20261107053502-failed-6.6-2e6f2e5799f3@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053502-failed-6.6-2e6f2e5799f3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




