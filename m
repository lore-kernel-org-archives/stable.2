Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C029361957
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585680; cv=none; b=kQppNXL+t2UghTrklSwMzOxC962EUQm9AXUTpLVMpSTKuNDoX3KYMJ2p8IwjtJHeNRubATQqF4TNejmw8GPblpMSCPN5jO/uNVc2QvS02qF/no+pV+xv/k9s3OFYUVFOvczJ3sgKVPn5EOSoyC0k1J7RDfsdwYe8tkbGG+sjQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585680; c=relaxed/simple;
	bh=AqseX1vvhgGcihR9RcOwXv6rmSkDHNZSwbupT5RrzBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp77DGA7la646lT/RZjPFunlZ40MBal6qse/o8hV/msk5tW9xqHvilwO34yJxYKPTTmMu40MA1QD0bioQU6ASSsXQGVBxK8zL+A078B6pkgqewKdonJVkGLauehYthTeIU0BmxCrXQnkHOFSy8Qu4URgOVSd8ode+2ZqTjdXo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A++L55vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A++L55vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740E1F00A3E;
	Mon, 24 Aug 2026 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585679;
	bh=1/F5+K31EpX73aCnzh8ZJjdkOxnBeEirJHTPL1QK8Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A++L55vjnzw8kveVO5zi5M8SyVwYjgSfoLzi80KUjYBDBWR7QvG2kOkydqdA3VFCT
	 LQ4ByvcxSdil4lU6xl6L6AsEypZWAu5wFXDogIdKvlYjDBWu3JPe0jPbcLISZtN03v
	 P2X4Pcwbpma5JfWU2x2CfhwxLUWYln43qbyzfrfDQYDM1AA3pqRAX8Hy7iH0SaQ+ER
	 WkIE1oqd8/AiyLW8XBpSOnDZB3+wUmQYPn8acklyCsjQU721Bid3CqO7qN5W1oxKME
	 4yImjsfpxY3hU9Td+ha+1oS+ENnTtwdKZB3Qwf5c71d3ZJGruJnAIxSAKTur+7NcoY
	 c3InvvENMqJeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donglin Lyu <DongLin_Lyu@outlook.com>,
	Donglin Lyu <donglin_lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Mon, 24 Aug 2026 11:34:35 -0400
Message-ID: <20260824153435.3850535-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824153435.3850535-1-sashal@kernel.org>
References: <2026082022-arbitrate-hunchback-c487@gregkh>
 <20260824153435.3850535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Lyu <DongLin_Lyu@outlook.com>

[ Upstream commit 410c44b1096789d0c40fbee706520e981dba7bc1 ]

The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026)
does not work after boot.

Using the kernel command line 'i8042.dumbkbd=1' makes the keyboard
functional, but the CapsLock LED does not work. Adding the
'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED
natively without requiring boot parameters.

DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>
Tested-by: Ruslan Shevchenko <adefka@gmail.com>
Link: https://patch.msgid.link/20260801151115.52709-1-donglin_lyu@outlook.com
Cc: stable@vger.kernel.org
[dtor: keep all HONOR entries together]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c3cdb5933e94b..be093721668ed 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1927,22 +1927,30 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
-		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
+		/* HONOR MagicBook Pro 14 2026 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
-- 
2.53.0

