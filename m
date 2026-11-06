Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929789;
	b=kytNzABiHJNKj0xsJEWexRSn3+0ekw9kTcKrQwtmPFAudl4N5Bnj50RPSUe4i6LuQ0T1
	 q9zFCKNn0blULba0IHh8DS35SL3YGxL83lSAWvDfpAUddAXM/gaugxfILAgOAqwr/0FM7
	 a6TJj6yoIwM1S3VFEOxsI3XAdHRKUVuNyJmTf9M0HY2JQ+kAT/gFy0C3SV4o2ajFDlPkJ
	 /VwYXG5Yh/RRohFCGGZbj9GUib06LT3HpdqNClWksA1YE29Jk92lxeThmg9pda9CYG3yw
	 d4TP7/K/Y0yR2OM+qDcrwqPMYWRAXgpeQeDTR2xMehZnjVTU4xhdCD/3wVMZS2E1MBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929789;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mR6JvDU5bShQhL58e08CHnSkAg5yVlzJUO6QiNEcqUA=;
	b=V4fWvmM28vNhrCVH8xNMptuysOWZZLgvmyszqVynL1ayZD/992k6ToT1jkrfiiw0Q/tL
	 MpW4VPZTSW6AzD64b0+lrNZEIL2iUCVEBGEZxVQ68lJPnmIxrQcxAKKeOUXPSV2sS/F0X
	 8KSmkykEs3pex2lBKgbdq07waBK8niLIyywxD6bVqIj4R0BbnCi7TdXI4o3Y7Ggv89fZ2
	 CWDiDgQkxvgYVjE9z0J643jZQA8ZvVJCluO/VJeUkawGn60lSXGuj59UL18rqg2CAM+TA
	 oBz3Bz75AGtuIC1t/OxZ0SC7t5QB4eVxbMYGDNGHKaLxF6wMigu5CvcgY8TrXqS5GoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=snNjDNv6;
	arc=none smtp.remote-ip=115.124.28.124
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA6606A32D;
	Fri,  6 Nov 2026 01:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFA6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=snNjDNv6
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929779; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mR6JvDU5bShQhL58e08CHnSkAg5yVlzJUO6QiNEcqUA=;
	b=snNjDNv6LAGiqoKYpFAMw85B6R9vTXukd52MkwjD/IOL3e3GbnLnox6Kd8XTLk47ew4HTjgxnD+qyRxgFPRcd8cZfg1GmHwyxP7ZN9h1GFvMh0EuU+eIvkpnGvW4EE2c2Xb3xBMpEmGJKPFDfhehgCc+K6dyQIAQW9fuZiXRvoI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1392132|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00108818-0.000913957-0.997998;FP=13218108027394602064|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jxs1n-V_1793929778;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxs1n-V_1793929778 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:38 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] tpm: sessions: bound the parameter decryption by the response size
Date: Fri,  6 Nov 2026 09:49:36 +0800
Message-ID: <20261106014937.4127650-2-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106014937.4127650-1-guozh23@xiaopeng.com>
References: <20261106014937.4127650-1-guozh23@xiaopeng.com>
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

tpm_buf_check_hmac_response() decrypts the parameter area of a
response for sessions with TPM2_SA_ENCRYPT set:

	len = tpm_buf_read_u16(buf, &offset_p);
	aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
	aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
		       &buf->data[offset_p], len,
		       auth->scratch + AES_KEY_BYTES);

The length is read from the response itself and never checked
against the buffer: every other size taken from a session response
is compared to tpm_buf_length(), but not this one. A TPM that
reports an oversized parameter area makes aescfb_decrypt() walk
past the end of the buffer, and since the decryption is done in
place, this both reads and writes whatever follows the received
data.

Check that the encrypted parameters fit in the response before
decrypting them.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/tpm/tpm2-sessions.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3524c1d50..6245a6baa 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -872,6 +872,10 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 			  auth->scratch);
 
 		len = tpm_buf_read_u16(buf, &offset_p);
+		if (offset_p + len > tpm_buf_length(buf)) {
+			rc = -EINVAL;
+			goto out;
+		}
 		aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
 		aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
 			       &buf->data[offset_p], len,
-- 
2.50.1

