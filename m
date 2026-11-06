Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929789;
	b=c3nBvbyPh+k+DnOQQE8n2ywKCvtiGYWhVg1cInceZwp37ie6HcsV4F1bbBU+dIQ2pRHd
	 0N+oKf+IG+rgv2jsdiRZzre+JClLqp/oTYBKYEFiBo2a+LapjIs28TFaV6c1yPpTGgTYb
	 w4wpI35fwvMtML68ui2h+cI5RYTta8HkYpCpdXfmc3VHJDhms4kcIpTvsjAHAe+N11nzm
	 grp6doKD+qzCkRcQL5IGIrh5XL4LYEVx+QuG3Hk7JVnlPWuNvppjE+9UXLOjvqA6obZ9R
	 zOdXo1dPG2dmqsF96bNyk6Gw8icxdNE56DHcBT9LzaeOPiHBg3BOmnX64rTmhU83Hgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929789;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rd4gFmrl3ouZRdKDs05EYuF824vME+wyZ3SimgQQNTo=;
	b=GP8TxH0QI5nU5h3ivg68JYSzOrV1QQICEw79cUIccS2X3bppoabOBTGh4ecI6KtPW/T4
	 Q6ewj8dOJKiHhv4o5lY+cM+CrHECPELUQpvPnCDtNp4OHovDY7+bl0WcEfXKKOnPXa6sq
	 H0GflxSZu4hTUkMv4HomSpQjD9cguyEto/SRPRqZrjt/OBxtI0Sz7zn5Ubz26bJvSDU0F
	 9X24wf6vZzzvD60+xe30580aDiPHXw2p8dDycsIwuCB5WKDTrguOLx1MK4LN4QDorDRh3
	 KoKUjDtonKwpV3iQvdMiToertjYriIXU5XWcuRglDMFesVTVGKGps/bvoW3rdhXfE1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MD3cVfTf;
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1F606A32C;
	Fri,  6 Nov 2026 01:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD1F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MD3cVfTf
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929778; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rd4gFmrl3ouZRdKDs05EYuF824vME+wyZ3SimgQQNTo=;
	b=MD3cVfTfdFTCqTtLukNvDlZTJcIFv3D29ZI45YoV0EGNTe2t5hph9/cDUKoyIMwcIeuKTqHpYHNmgu+J9K2so/fAzyBP3esaa9V32hQ7i0v6rjzw7nUgQVef6SD7vTnaoVubhYj4fw1Nje3rzB0tWhzQQEkIRNDZDFrQ71Gsnto=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1907592|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00151422-0.000236071-0.99825;FP=18400911021544711315|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jxs1mzc_1793929777;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxs1mzc_1793929777 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:37 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] tpm: sessions: bound the primary public area by the response size
Date: Fri,  6 Nov 2026 09:49:35 +0800
Message-ID: <20261106014937.4127650-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

tpm2_parse_create_primary() reads the size of the TPM2B_PUBLIC area
from the response and hashes it to compute the object name:

	len = tpm_buf_read_u16(buf, &offset_r);
	offset_t = offset_r;
	if (name) {
		/*
		 * now we have the public area, compute the name of
		 * the object
		 */
		put_unaligned_be16(TPM_ALG_SHA256, name);
		sha256(&buf->data[offset_r], len, name + 2);
	}

The length is only checked against the response later, after the
hash has been taken. A TPM that reports a public area longer than
what it actually sent makes the sha256() run past the end of the
received data and hash whatever follows the response in the buffer.

Check that the public area fits in the response before hashing it.

Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/tpm/tpm2-sessions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index ca1e2bf42..3524c1d50 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1126,6 +1126,8 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 		return -EINVAL;
 	len = tpm_buf_read_u16(buf, &offset_r);
 	offset_t = offset_r;
+	if (offset_r + len > tpm_buf_length(buf))
+		return -EINVAL;
 	if (name) {
 		/*
 		 * now we have the public area, compute the name of
-- 
2.50.1

