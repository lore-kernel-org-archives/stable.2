Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049578;
	b=xvUqko4WrgEUCeXSfMpj02b/QWR1qdYaseJp5CrAwLoZy9adj1x6g0xfGeA6LS9KSKXk
	 ePLiZFUvoPrOaRx5nSYjLzPzVE397AAyPsIN28v63RbIly428S7hfQ7QQXqnK//LSv3in
	 G9n8v64TBHKloiALMXOGCbicg4z6PV6flpZxrK3rxME2AETMRKxutMZCkXwCqSoRGBF2v
	 X+Q99CMs4WDHUh4Gj5ngcgLMAwqD5GDl1Bz1uDrOx8N3IAtSvZWckmNdvaiKpsihAs2GA
	 WwXgmn5LnlnsdaXxyxWfIMW72NBQMlutxEw7/qsI0juxAc/bzEwm3kjFWqZ7TwSkiFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j++3uF2MIPJ2B9ngHDJo0GXqYd/AWVk2uCRwsvIKwx8=;
	b=F30wMhkww8F+cSjlTS8LsvayH0rx3sF8X2yGlsVuHpFoMpnYJ/BivrjBjYvzkojdo+m1
	 LlDCtpTmEppXovySW7BhK56Pl+UDCxUc4iHllsG/BjZpGAUx5n238MLzN4h5hWhu3JCsM
	 fmps0VURSeG4uO9DTF9926cGtjMwzx+BjR7NVDoiekuGGdgd7Hdksg06CaNZpEazYD3RE
	 Rj0/Gc0dYbatSi52gAu1yUuMcCZdP85KMvk6LMlu7AfwoLDWZ06ABRmokM+XfRLxldO7h
	 cDK8SQB080CjYOwyPcN/nu+CIhGb0hpt5tmp22KGBV2y1nDiQd6qDXZXCnediE8qaqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5vtwLu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5vtwLu8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9081C1F0089F;
	Sat,  7 Nov 2026 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049578;
	bh=j++3uF2MIPJ2B9ngHDJo0GXqYd/AWVk2uCRwsvIKwx8=;
	h=From:To:Cc:Subject:Date;
	b=b5vtwLu8wCDnX7EKOqR8OhhN/b9WEyHC63WUUn+7Rc1hTvM20V0jbcnr+d4x94Gbc
	 5qHJWNmlR31gni0CwzBk9Na9W7UFWfr7IsTA64gjouw6u9vzTCmTwlsSbnukPjqph3
	 w4dRlPzEEdIOIbE5iThrMgck0UnEe4pwmL9OzeVE6ZxDGPb+X0URrDDj2JgCG1JSU6
	 iV0ai2v4LaOkCwMrB/U79W9ZZ9uElDiMMjBEhAScv6npLpSz5M9PRr9Wq7EaMiiocg
	 4iEkCGTEabmvs7FYM2rw/J/ON+mxRi4tSK4DXGEAtpFw/NH8bjFk+WpjnqsDn4VcOI
	 LqMzpeuMGnhqw==
From: Sasha Levin <sashal@kernel.org>
To: francesco.orlando99@libero.it,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: xpad - add GameSir Nova Lite support" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:16 -0500
Message-ID: <20261107060616-failed-5.15-2e6f2e5799f3@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060616-failed-5.15-2e6f2e5799f3@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




