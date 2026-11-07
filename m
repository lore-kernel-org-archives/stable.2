Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046953;
	b=1/VmAM8VrXau5p4P3Fxm42VVIj4jtiuaA19sTgqN5ZTm0VxVGC7MfcKVhJk3mbetnDsa
	 T4KhlSfXNaaADie9oH52gId35Ez9byim7IHbg1xXOJVP3e1yCE/c52x+q72is1uQdER8a
	 8Sdt9o7GArOIjjtto7ADu9NGaa1bQXyPi7WvjcFI80iDJPX0+T97pIetzHRUg+matpcUg
	 swMS4GsoGB1jZmtor/m6jUm/ltjpVSKsL6/0y4NCO+rRu/gFHhYDKq6A9QlYzr+Prc6UV
	 4hzD7XFnhZn26pmj5eUhyDLRjkzQ7vAwHaobw+GMaeDSIAGrc/61HXwk3TeYk/batqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zLLmZGgU52bcmJF6FKmI2eENV7zo/8f+OUWJyWaXRQk=;
	b=DWENQrHGPJKHYHtCaMabFcdoH4xagRSEcGAhSgvMOy//Tar8WXbAu7tj7ufqJ9jOF8BW
	 GPwn2tsXrakbWEp7jUJCwXQszs2++3uuu8/l1oRBBWv+1Yln2vgZR0jya7bd4KRSH3IQF
	 XZdOM66hk1LJ/8Chv5n5qhvgmPEayq9mc1A5p+TehlH4pO2hqfbmCVkB9JAhDQMNOWRP3
	 07X9t4Lp1I6P53yaJ7Qq4FzW8ZUs2AtS/hSQuTEH6Yzbjzajxa1espvz5W/qLxJkuA0CH
	 4xjRq7thtrV6wIbySDeadXfiNbx4JiVPgUfPjrJ29akvHU0v7phlCgzriOw3TKrLxEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoh9jHtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A51606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoh9jHtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D4F1F0089F;
	Sat,  7 Nov 2026 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046952;
	bh=zLLmZGgU52bcmJF6FKmI2eENV7zo/8f+OUWJyWaXRQk=;
	h=From:To:Cc:Subject:Date;
	b=eoh9jHtGNyQR5MMapS8itpuZSLFN3gztckNJVKDRSyhHHhYieiBwmyBKD4neuy9EP
	 9M61q+fJaCcVlOKuBDxGbdqdsfjGs6j9eiDll9G1aUxDwXJ8aCWfJa7AHXoagfZhAj
	 AC0lAVFU3Eiu7I3UMGo26sMrO6lowSsnwstR8ZxNaTD4vvjbJPZRsQkHSStihp8Iam
	 edhTKrKP1qR7bCdITSP40BiJSF0SfQJOeBXgXqKwt08+ZrAcTVzaInoDqLczd7XAwg
	 Q9mQYSuRKNFrf8FlP4dmashzrmaT+DWPfQc4wQxhRkqmG9+e1OXNMsV8ZA2vEZH3RZ
	 9jHu/rq9P4ywg==
From: Sasha Levin <sashal@kernel.org>
To: francesco.orlando99@libero.it,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: xpad - add GameSir Nova Lite support" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:31 -0500
Message-ID: <20261107052231-failed-6.12-2e6f2e5799f3@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052231-failed-6.12-2e6f2e5799f3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




