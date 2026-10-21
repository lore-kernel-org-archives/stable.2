Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584894;
	b=YPjiQwzaaT1rflLioMukbR+dSYaLax38RuC2Hl5Y8+zzifzlFbfhCNUFXNZ2TgWvd7g3
	 vG+hX2EPcSGQsNCWcKbRPse9I3REE1sPX3DdL08EBxUjUgloU9yrNAnPTNQgyBiPL2z8R
	 dpGc8oktItIp16hgaOgVPnvAaP9i5Hisxid+nICvJ6+XL7nNp0UZMT3hyHj5PRv0NsdPg
	 YS8RTCeZLTKd2Ruf+lMZHjP+5K7gXayfBrJ+Esj0xogCnfsDlssc2IGvmoc5iTuj3KA9K
	 BoIHEvg4P2vJAPHkJRpZq93/ajA95lvuBRjexQVmlyy9swZwtdHpky6AZULQ3OT65Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yIE4Ws0+fzmkVfBmC58B4o4iBYgCAB+97otsS2HlOmY=;
	b=ARb504YWJi3+oIow//B/qUGefg4bqO4ETpZfEwUTaBD47u3Hk6Ufi0g6ZcuS8fbIADf7
	 j3JIz1ITOuZL9rgMJI+WnfRESWLuXeyKMUiYt8QPsfKPInQF5W/+UHoHqUvP9QqQ9v1pT
	 dnKlSDlWC7FsJqke1PDrS3FVcWAG68bukCoca+HirukoZGYSBbcOQb4aXM1q6GpzOGt/a
	 uT3chQonJUYIIbefMrWi7da72+gXwN98L8N1NsD0Y42+gpKJ4g926XOvUgibUqd3fZNuA
	 VX4brSfZh4Y5LEZWf+xLttXKDv10GpzKYqkEuOkL3E4LDcFoQtMeWIeOecI89Vc1sZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT16dIF5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD4606A334;
	Wed, 21 Oct 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT16dIF5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECD41F000C5;
	Wed, 21 Oct 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584893;
	bh=yIE4Ws0+fzmkVfBmC58B4o4iBYgCAB+97otsS2HlOmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MT16dIF5R3rm5ttv3iWHGZfQKfnLzunO0QTri6bfKhnQfJbfnFVRsRebPLx5naONA
	 6cbT8oJkh4F6TdYpQAZWCpUzwpLeVeQEqvKEbHsQjQ2UK+Sz73DHdPdKiYUxk/7e47
	 KD7bpCJHs5yTOtp0J6AFt0Ha0gH7hijjKUJqxv17lmi7E2DFj3jVvj6n0uSGdNwRjK
	 0wHluVC/XZ3X9b3ztMeRdBILVmQ/KA70BrZANnPW9QaR1r90PNjRsiWDzw1sqXkh8W
	 61UccBQtqgI+DAt91v8rPyjb60InjYMA6rNHXv2DBMHg2YdOCTAAZyDt2A5AiN69Hy
	 RhvQmiBgHxSlA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/28] mfd: cgbc: Zero-initialise version buffer in cgbc_get_version()
Date: Wed, 21 Oct 2026 12:09:31 +0000
Message-ID: <20261021121245.3111563-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the Board Controller returns a short response to the firmware
revision query in cgbc_get_version(), cgbc_command() can succeed
without populating all bytes of the stack-allocated data buffer.
Those uninitialised stack bytes are then copied into cgbc->version
and exposed to userspace via the cgbc_version sysfs attribute.

Zero-initialise the data buffer on the stack to prevent leaking
uninitialised kernel stack memory.

Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
Closes: https://sashiko.dev/#/bug/linux-8c473713-527e-4619-8404-689f28c7654d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/cgbc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 2becaf797646..f2615c783bc8 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -299,7 +299,7 @@ ATTRIBUTE_GROUPS(cgbc);
 static int cgbc_get_version(struct cgbc_device_data *cgbc)
 {
 	u8 cmd = CGBC_CMD_GET_FW_REV;
-	u8 data[4];
+	u8 data[4] = {};
 	int ret;
 
 	ret = cgbc_command(cgbc, &cmd, 1, &data, sizeof(data), NULL);
-- 
2.56.0.218.g1ec904b173-goog

