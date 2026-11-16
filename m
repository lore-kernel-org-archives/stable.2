Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835012;
	b=T6T1UyevUB0+E2DhqhJBHSeQ4GvjiuGnRV70MraWg4U3LLXTj/uVu8DNUOcICgC3iBjq
	 R+6Vv3jPOnAjWp+k6wPasZJG3Lnfr4HrwhInXnILZVta7fso69e2hKySkEaZAmRF9w9m7
	 y5EAQKCSQ2rrQiX6HoRufpQCKCZc8SuTG8II7WBTpCrDyOR5Ar06YGrfFomv/9e5L7nu1
	 bI3sQ3tvovPa6WqBzNlc2BgleSTg7swByzgx4e5NMWbtFksGYn9sBl8K43qHq/y9l1J/6
	 A0d1KbBHmvFvqaQWEqs9922aB4zquF3EbbFsEFLx3XiXa9gk8yTfV6rGHYD6/MidzwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k03plxax1sqgbyh+GRdp3af22vFwjxkHs/qqHnb9320=;
	b=j5pkavWgFnau4gjUCAmyLeV5YEtFpu31RpnuraQrWYl5MYr1r5DZP4+8Hj1BCwXCLUdX
	 phuIdWGl2+Rw+rVooSyEz4BImIDJVG1w2bksZvC2YIWxZUQXQV8vMmZidiefa/0U08UTQ
	 jB/r5vBsM/fIgTggSyMw0WORExP8Gxbq04x1oz+SyYaKC2tUjKwGDh1rZAogZtKpC6IMc
	 YIWhTqoI5QPcOpeZq197Zw5v9S/pqFRfQW9v3EJmoQAOXLzLJyQllT0cSOhA4SRjsTNNp
	 rWerMMynKFwrUkTkT13I6SIJdSHXOuNeQed2NtioxmgLFss065F08QA9A1VM7OQys0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7uco0zx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E245606A323;
	Mon, 16 Nov 2026 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7uco0zx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2221F000C4;
	Mon, 16 Nov 2026 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794835012;
	bh=k03plxax1sqgbyh+GRdp3af22vFwjxkHs/qqHnb9320=;
	h=From:To:Cc:Subject:Date;
	b=M7uco0zxuI8sSccqlw/XEz7uKq0bU8EEVWie5wHNeZD8DKg5yTWCNDh6dDZHEiwQW
	 qoP3wVnbi9yFDJ0MZrpJv9SGtqYNouiouQVKp8lUqwTyZEpsfZXZxalbJZl+qUGVE8
	 j7bMh1qk2NU3ETT3qbCeJYgKf4+bgeY/PqtTzAb+KRSSCLvpSlpJJThzdOCcZwY4rJ
	 U7JaM9Ti+w6/Seixu+NAd+0Vp7snKCwJTH8Pt+OUZGg0gFOGgf8JZOumSlFw7F8whE
	 bPcs8sp5FcJGG4AE4xvmfjVMjMk4NPPrpVP1AAbHcbxSyfwVIJ3cjDCI4t76DsJ5CL
	 LDWExSmw7I8Gg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/altera: Fix Port B error injection in altr_edac_a10_device_trig
Date: Mon, 16 Nov 2026 07:16:41 -0600
Message-ID: <20261116131641.3064859-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
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

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The INTTEST register on SoCFPGA only supports 16-bit writes; a 32-bit
write triggers an SError to the CPU.  altr_edac_a10_device_trig() was
already using writew() correctly, but Port B test bits (TSERRB at
BIT(16), TDERRB at BIT(24)) live in the upper half of the 32-bit
register.  Writing them to the base address silently truncates the
value to zero, so no test interrupt is ever asserted.

Write only the 16-bit half that holds the trigger bits, and leave the
zero half untouched.

Fixes: e5ef4cd2a47f ("EDAC/altera: Use correct write width with the INTTEST register")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 16 +++++++++++++---
 drivers/edac/altera_edac.h |  3 +++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index bb95dab847b3c..37ce2a87443e2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1741,16 +1741,26 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
 	const struct edac_device_prv_data *priv = drvdata->data;
 	void __iomem *set_addr = (drvdata->base + priv->set_err_ofst);
 	unsigned long flags;
+	u32 mask;
+	u16 half;
 	u8 trig_type;
 
 	if (!user_buf || get_user(trig_type, user_buf))
 		return -EFAULT;
 
-	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR)
-		writew(priv->ue_set_mask, set_addr);
+		mask = priv->ue_set_mask;
 	else
-		writew(priv->ce_set_mask, set_addr);
+		mask = priv->ce_set_mask;
+
+	local_irq_save(flags);
+	half = lower_16_bits(mask);
+	if (half)
+		writew(half, set_addr);
+
+	half = upper_16_bits(mask);
+	if (half)
+		writew(half, set_addr + ALTR_A10_ECC_INTTEST_PORTB_OFST);
 
 	/* Ensure the interrupt test bits are set */
 	wmb();
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 9387056fd65e3..fe6d0289f5c35 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -244,6 +244,9 @@ struct altr_sdram_mc_data {
 #define ALTR_A10_ECC_TSERRB             BIT(16)
 #define ALTR_A10_ECC_TDERRB             BIT(24)
 
+/* Byte offset of bits[31:16] of INTTEST for a 16-bit write */
+#define ALTR_A10_ECC_INTTEST_PORTB_OFST  2
+
 /* ECC Manager Defines */
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
-- 
2.42.0.411.g813d9a9188

