Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627514;
	b=I/8u77GuUxz01AARUZZH/Ezx5BywwbIUK/pnOCVdN9q7dTp+1j8Yf1PyxH3kwf/2eSdJ
	 UuhEQZoYYteHNCjHVOoER9tPNWLCq2eMa/rtlua6oNlRpwxS4aMRKEz6gDrzABSIuCuxB
	 1oBmz6pzbZAvBJQEKy4VVoIgi4mOBMN5L3j3XN94a7/MrbF0BuXqcZjdtG3rIc5+qX+Rp
	 4avg7PMMDPdleLnz5OmngFAfUXNCDVW0SuVtpb7syR6JVs0w1U2f9Tb6OXxwzu0HDvdZH
	 B5adty2GDDJ1k4VpseMDWyXVgiPPFkF+/Nm2AguQtO5VjiUkM+hIRDKA4AfWGW+bNyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R2DebVOq3WKtsewVANK6OfPbVtCvG0655Z0/I18ITcg=;
	b=BdoYg+H5675SX+mYo2r8NF+zF+aNPP00Z7Qk9onLo1F7ZSwAPml4Y0ziq+aIPQx0k5VB
	 rFr3gqhMtRojOJ21W8zhJrGyVCpIo+GuzIpNsjEQxaqePe0KXmuwIrfspc9eR8/Z7rtID
	 gg2/aILxhsGED059lb+tWt2MFrSZh3fKs5sFUPnaR1OluM1eqnNBK+Pcnq8f+asWZ9UMA
	 +RsBucQBPDVnW3lsaFgyHgEr5pI08JUuA10whMJMu5T7x6juL2+18BslGiFg5irGF4yQK
	 xAgMIF71XEE9qrXVAgGqR7cR7OYMHd1pWsIQ39q3a3sgSkls4j9U1p/CISHkJF5zVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=icxv2y08;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA60A2604
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F1CA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=icxv2y08
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd69954c755so1821365a12.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794627514; x=1795232314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2DebVOq3WKtsewVANK6OfPbVtCvG0655Z0/I18ITcg=;
        b=icxv2y08hLJXp205BMvqbTunQqbdYZ4UUtGRkBQskjMjmV6ghNSQZbwhC1QzdtCTuI
         1NQs0rz17G/dZJgNZLKirnBmXlRSw1B2lzqmxI1n1Yn/t8O4GJ3hDupL9iz8kFH3S7eD
         g7juhf2PwgJ/pt4EWcAD2BTBEcbFjSCHvvtdK6vF8Lfh/P97pLk60GFQYJ8QQEO70dxJ
         eFroTJIEgtAn+up6GfByHvMlxz8kCE4+czyGJvvn+YZW2MknxbDOfgMGeKCKCKYlNTmf
         zFldaN85oP6axExKDDB4TrVJR0VDKBOqKa6lcziXBGfZ0GdjW68VPt3QOLlKcTVoFj3I
         aiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627514; x=1795232314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2DebVOq3WKtsewVANK6OfPbVtCvG0655Z0/I18ITcg=;
        b=x57R3w7OxZeSJbYPHR//LA1Y6LnRdLl+vmQmRiOkM8Y3Egfr9TWHco66Cx5dQTW56/
         o823WhYquGvhvN1BwjTzKi9+VwJmKK6jwSQnzeAOzFmBENpQeZLy3w5YuZJeBpfCoQip
         Tcb+zWtExxkQrd7bVdxykqCDKatdkVrW2gWELVuFxfbKSMdbxpPYHOXgkDKSuePXZrMW
         D5MjYeKDwCEE1XVK58VcJ8YcxmT7y8NkGrIs6nPg3AVFL2KszNoK9hC7z+u6xQi0dgwT
         Q/2F7vhVxOd/cTWabnJSaLy/nrIGDUH17qbvFnGwWBGItWlaHmhP7Ylx1npdSKaWJTNf
         HIGA==
X-Forwarded-Encrypted: i=1; AL+hErFw9lyOl31eimwqzxy6njPLYx0bEZsuZcpwzDXJ6YGeoE6WpDfkj/dQmm3JNugh4mu29exr4FQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z84cC4fC+RxTr+OJ+ZFHEdJ4igXc9tm9soFfxenLKRtgmtwi3pJ
	Os2ZOj9J4jw20+l9n9J2ZkEMqoV45Hb4/GQ7yrR2/PfA8yA1KXUyF9LolNfjWv7LFOI=
X-Gm-Gg: AYBFou1Rt4aJ84kag4w3EyZlozYXwVXLvdeRYk/1/noAISfyvY7vf9crCzCi4QvgGpp
	09SMjrZIy3BYmibSxHWizDeQpwO0yLUrVdC1ClJsRWdRXI7traAEEIJDClllWQ7NtZMC2NaQk07
	JgjZAwExkdPQRCpxhT9dkwQB8qBl5DcVhpX+oaAH4qqK/xkkh8HCtIbubiMuuCPB0vl7wDmTV8b
	BuVq2Jm5tXMtMwTgt+ex2GFkLIApmAxzvwQi6yG5qupoW0hD0ngbudvljzHih/0j7rLm1tyr9p8
	imxoue44ibWabv2vXGxp8amvOJlKrVEXk0ogCUgg1plYlyNWy4OXEqXMuQO2AFUj1cqDlGrqMTf
	YUx/Nq66eRlzrfcbYGunicaWY7kKZfJS5h5Jp0TKtA3XyJL9DhkvwCRMTvSZSpjweFwyn78x3D4
	ATOUZJgaH1V1cnof+kYDtiYTo7ollFGlSmsLbJ9wCyL+GJ6i2k8QQ/P+a1G2UAs+Y7jp4qF0PiT
	uwSwJI2d7tndIvB9MzzCXi4x0FzsXHD6f0Tt2kb8Ag3D7P9gMtGrgN1vZKrMVD/KNVeAtuek6oP
	R/u7iBHmyaZ9HvoNvPt/V9u4aw7hcL3qFDsQoYw4UyR1n3iOtl3BS1vTV3u8m4e/3U/UVyQCewM
	NnGER9xT+gmic1hZhg51yOIZCQOvzPiaBK2CZxCP62gyelDmGCVP4NMZwbqA=
X-Received: by 2002:a17:90b:390f:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3b1b0a0fdaemr4290992a91.31.1794627513876;
        Fri, 13 Nov 2026 19:38:33 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:f861:b117:6318:c068])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3a21769sm3412380a91.4.2026.11.13.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:38:33 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	erich@areca.com.tw,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v4 3/4] scsi: arcmsr: wrap the type B completion index before using it
Date: Sat, 14 Nov 2026 12:38:09 +0900
Message-ID: <20261114033810.549787-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114033810.549787-1-yhlee@isslab.korea.ac.kr>
References: <20261114033810.549787-1-yhlee@isslab.korea.ac.kr>
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

struct MessageUnit_B lives in the dma_alloc_coherent() area shared with
the adapter, and holds the completion ring next to the index into it:

	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
	uint32_t	postq_index;
	uint32_t	doneq_index;

arcmsr_hbaB_postqueue_isr() takes doneq_index from there and subscripts
done_qbuffer[] with it, and only afterwards reduces it:

	index = reg->doneq_index;
	while ((flag_ccb = reg->done_qbuffer[index]) != 0) {
		...
		reg->done_qbuffer[index] = 0;
		index++;
		index %= ARCMSR_MAX_HBB_POSTQUEUE;
		reg->doneq_index = index;
	}

So the first iteration uses the value as it was found, unmasked.  An
index beyond ARCMSR_MAX_HBB_POSTQUEUE (264) reads past done_qbuffer[]
and, should the word it finds be non-zero, stores a zero there as well.
arcmsr_hbaB_polling_ccbdone() has the same ordering.

Reduce the index where it is read instead, which leaves the rest of the
loop unchanged.

Measured with a KASAN build.  struct MessageUnit_B is 2176 bytes with
done_qbuffer at offset 1056, so a reported index of 600 reads 3456 bytes
in:

  BUG: KASAN: slab-out-of-bounds in arcmsr_hbaB_postqueue_isr+0x1f5/0x270 [arcmsr]
  Read of size 4 at addr ffff88800c08cd80 by task init/1
  ...
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 1280 bytes to the right of

Fixes: 1c57e86d75cf ("[SCSI] arcmsr: initial driver, version 1.20.00.13")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e635b76daae9a0..d13bd0febb81ac 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2568,7 +2568,7 @@ static void arcmsr_hbaB_postqueue_isr(struct AdapterControlBlock *acb)
 	bool error;
 	unsigned long cdb_phy_addr;
 
-	index = reg->doneq_index;
+	index = reg->doneq_index % ARCMSR_MAX_HBB_POSTQUEUE;
 	while ((flag_ccb = reg->done_qbuffer[index]) != 0) {
 		cdb_phy_addr = (flag_ccb << 5) & 0xffffffff;
 		if (acb->cdb_phyadd_hipart)
@@ -3671,7 +3671,7 @@ static int arcmsr_hbaB_polling_ccbdone(struct AdapterControlBlock *acb,
 	/* clear doorbell interrupt */
 	writel(ARCMSR_DOORBELL_INT_CLEAR_PATTERN, reg->iop2drv_doorbell);
 	while(1){
-		index = reg->doneq_index;
+		index = reg->doneq_index % ARCMSR_MAX_HBB_POSTQUEUE;
 		flag_ccb = reg->done_qbuffer[index];
 		if (flag_ccb == 0) {
 			if (poll_ccb_done){
-- 
2.43.0

