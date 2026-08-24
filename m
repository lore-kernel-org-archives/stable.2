Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0F459AE4
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586805; cv=none; b=eHijwWbEjwC5BW9fjJUggzwNEq3T2giCn3kq5UYMY9fapFx25EExeQ5aKU/PUzKErQQvBsJ0A3RNeTTRB9GIIWT6xRq4QEcWtMGQqme1ZDXzPkqaAWsY0gGz36PzDkLt6p/rTBqRm1jpr9zTgzQ5FoXTHMgBytLbGhV1xlW4rRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586805; c=relaxed/simple;
	bh=PlyPaS/m8qm1meheUr5l/iUJvSW25n66taXEemA+S2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBN66Npj/qx0hHfJiw+WQYshUL7EG1ZnSexNSO0St9S+orB+0luYpBBGu43cl9mtuVx3E76cihIwkH9cKT5Uww3mP5dfCeg7EkYDD1QbOe3vXWy/LhI3XH7ccpZphc//yZaOhZrXu2S86QEtDJVrxG5mGeFymOScJSTrt8dMkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcUZTY+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcUZTY+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942ED1F00A3A;
	Mon, 24 Aug 2026 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586804;
	bh=TfA7AcqpcqIC8b2H513FP+8l/JiurseK/1XHkSW1Q88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcUZTY+8OeLSb6B1wRjk7YrDZAmXwGWqesmV1EN05z0x1L/81sgIK7FMfKLplXfTI
	 IaoW4lBlIx19YZ/PSgwJvvgowIGDddmgfngvVMqfYIp+OsR9VvIh8BoSI/uzJDG/52
	 d80094gNO2wyAlV6HdpYbJZgw1E3cs2VnECwfuq+U3KL2s7t/QDVdql3RyFi9Qk+q/
	 6gh66TRaIJwruvXBoFZwDwX47YLMN9l20lLWl0pES4TJJl/wrJdXT01N+lg0YdDz8F
	 khmrKFGF4skPMqHE/R39hQBJBL6r3m/LQNbhzAdenmzv7f7N0YKr42vEAa/j+Avt6a
	 MY1g1d45lP1GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donglin Lyu <DongLin_Lyu@outlook.com>,
	Donglin Lyu <donglin_lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Mon, 24 Aug 2026 11:53:20 -0400
Message-ID: <20260824155320.3962460-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824155320.3962460-1-sashal@kernel.org>
References: <2026082023-staunch-apply-c4c5@gregkh>
 <20260824155320.3962460-1-sashal@kernel.org>
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
index 70cb19a8219b8..c639e7a2d7da2 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1942,22 +1942,30 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
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

