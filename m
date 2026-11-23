Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420324;
	b=3IQRNnHl6EiOu0XzXPCpKdeKYI6Mq5tvSzUuxxG2y3tMHdwUrNBO7oyE4X+8LaUAIzS5
	 2wsgkDnkhckTYgqRNSEEb9VToNlzI4FNWgpEWGeN8PnSSTFNBIZwcTbS3PS/DM+hdPCcw
	 KHGeYJPeLZN4J0ghYrC2IoJgf7pyalFKiF8BuXrCsbZ7XTKKWlbo0bbzFtfUUXueoNWF1
	 Ll72S+XJpVc6AAh30ge8jCe1OHe10gDFQTOy+q6UiWkiPbNO5OmPSOnbH8AUTwfXO9Yjs
	 cxGJeoHGkLg/6ornbDDkZ8apSEoLGJ2yB9iFa2HpHEN9BjnYGZCfxDexbnbbVyEXOzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420324;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kXHOK/En7L8hwH9JhyjUNcV1m0hQEGZi2ggRJfit8Vk=;
	b=WR8cxi26Ntwt64/ITynurxoIt6ylTaH3H1OdKHS57rCZpvmyX7Mw+rM6MxWl9RxGXCXD
	 lNkRVRtP0sig/AvFZmMaDnI9d2hI0pfhAveUhv5AWBYGSsOak4AfR3l5RYwCKD2YhFtAy
	 lWQ4arJu6Gxu6bQ0KCi9CjJ/py0XerOmD5iAq4oA1K5/nTfjH48crbjcRKb6IRE4X6KW+
	 PFBEtZrFhD5805qJgO2ckOh7SPMCKbi89lA1sUTQDiuX8poRF7IBcRDyh4mNm6M6NpE7e
	 fwiaY8HNCHEfvHhp023q2OSbn5gBnTNFBuGfAFqEBKzy1JGgiS2hJ9uvIRjk1EHIUIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrIYDQkA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB818606A31F;
	Mon, 23 Nov 2026 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrIYDQkA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795420323;
	b=YSzek+I645Nry5UVrGOmnzWVm4ct6r4aZEJaHaLzDL2hyk/c12Z/nOb17Z5rX/bSbzuY
	 Tx13tSxZnyJQE2DdW/ArZVbYAznIrEw68YaBzuqS6rLhO7WyfPo42/HXjx17wNCFbo/Ux
	 oi5gK0NZnSBfn/gQMWXVYkLs4pOz9/fcx6lmnnvUwGGsjpa74m+ddCzjL1sK09sxgyC3i
	 mvayb9TnLvmBQTtY35RIbU4GI1D2kiNP/26CQihCfN53oJu4gPHz2P5zvjwfXLlzU8qBV
	 CtyJs8PcRq2qYzb1r8bQ+pK809BqmL01NWkhmM68dd1hK7R0t6z5owGqPMa8lF/qZEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795420323;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kXHOK/En7L8hwH9JhyjUNcV1m0hQEGZi2ggRJfit8Vk=;
	b=D2yaHw12JbKp9SnhWNxVTko744qyn3jwnSzo3iSj/kyr4K9a5TdYawIgMo/X2yAPVcXU
	 PhzG8c0AO1cbU0Ofv5ubfHJMAIMZEC2bivUsqbLbE/ERXOANMU8Gfsuz9Yi1x0hx92hSc
	 sdIATjynMF0Mdz50hM5sM+LiJPrguqZDE2LIIsbVt2hUBU0BtsZX4COtU2899kRMCfg9m
	 Wy3Ay1/ZsRjQtEPV1ntfxmQV8Kx2eY2jtYkZ3z5Eyi34NP1c3AeONCaQWdMp9fACdvZMv
	 kf7LqoWS+io5WMGUdev8DLhWyVxvBNjzGSQN4iwnvM0HMERzKlVPUgLyimPRWcZIpXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7CB7A1F000EE;
	Mon, 23 Nov 2026 07:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420323;
	bh=kXHOK/En7L8hwH9JhyjUNcV1m0hQEGZi2ggRJfit8Vk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=YrIYDQkAZiF18NI6qEawySgCq07DRjmPlKGNgsCN9CFU9FmtxeWuj1IhSR6mSanXc
	 DGE1pdnMFJQ22fCbVO5RFkAXkUKZIrBzc+6xC9WcT3pnpbW9d3fXY0wHxAQHONi6o9
	 Gqoc2t3aa4lYb12Rd+EQrtku4HlRrpAU+jpiGUOcXHWTBfSilMzO3h97dGVBuHnoPd
	 /llmEJaoAb0bKfxvaZO+gUVpfYu55BRfibQe4as3KTmCp8YNVeSOCv15ZAoD8drQ9o
	 x8HmDvIn5rewTl3MQAXc3ECX6U9kVPNxfNIXjgDx06jBPRAjPgz7Qrfvl4Xk/XOejf
	 Zkz6HBuFOJNgw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 050604C3C0;
	Mon, 23 Nov 2026 07:51:57 +0000 (UTC)
From: Xiuqi Xu via B4 Relay <devnull+cagedbird043.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 15:51:57 +0800
Subject: [PATCH] ACPI: resource: Do IRQ override on MECHREVO GM6XG0X
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-acpi-mechrevo-gm6xg0x-v1-1-8ad76455267e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXcgiZBWX0W6iOMYp+CFxJZA8
 N2NdvnBOX+GyEE4QltlCPyTKOtSoB8V0OQWzyhDMRhlrNamRkeb4Mw0lfWKfrbJq4T01MT2Nbp
 GDVC+W+BR0t3t3n/Hb/9h2q8YHMcJ1M1fAHkAAAA=
X-Change-ID: 20261123-acpi-mechrevo-gm6xg0x-c71ce68fa90d
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Chuanhong Guo <gch981213@gmail.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
 Xiuqi Xu <cagedbird043@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795420316; l=1606;
 i=cagedbird043@gmail.com; s=20261123; h=from:subject:message-id;
 bh=8TxhdXQM1wQfG6AauVLgZq58N7Egkr43PPl431dbi7Q=;
 b=PLdVr6/4Q+vkfpfYDh8TWjvWtiP+DmAxgTcCZdbEtX7dwRQ+CZUws9+pS9ttA0BOJq294IpRm
 ZtCtEza31m7BbK40DSB0P+v2BvBXm66QrChea/zJgseWpH2vxpntdiH
X-Developer-Key: i=cagedbird043@gmail.com; a=ed25519;
 pk=zdBhtz5U+dUh9MDFOitlMU0OLF4BaaSouGW7kdduQR8=
X-Endpoint-Received: by B4 Relay for cagedbird043@gmail.com/20261123 with
 auth_id=1614
X-Original-From: Xiuqi Xu <cagedbird043@gmail.com>
Reply-To: cagedbird043@gmail.com
Content-Transfer-Encoding: 7bit

From: Xiuqi Xu <cagedbird043@gmail.com>

The MECHREVO Jiaolong16S Series laptop (board name GM6XG0X) has the
same problem as the Jiaolong17KS (GM7XG0M) already listed: the DSDT
describes the keyboard IRQ as Edge, ActiveLow, Shared, so the internal
keyboard does not work.

Add it to irq1_edge_low_force_override[] to make the internal keyboard
work.

Tested on a GM6XG0X (AMD Ryzen 7 7840H, BIOS N.1.24MRO14) with a DSDT
override that changes the PS2K IRQ descriptor to Edge, ActiveHigh, which
is what this override does. The keyboard works with no other kernel
parameters.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Xiuqi Xu <cagedbird043@gmail.com>
---
I used an AI assistant to find that this board was missing from the list
and to draft this commit message. I have reviewed the change and the
message.
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56df4599d360..144173f2c272 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -553,6 +553,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
 		},
 	},
+	{
+		/* MECHREVO Jiaolong16S Series GM6XG0X */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XG0X"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-acpi-mechrevo-gm6xg0x-c71ce68fa90d

Best regards,
--  
Xiuqi Xu <cagedbird043@gmail.com>


