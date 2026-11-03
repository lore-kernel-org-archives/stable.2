Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709223;
	b=BJ0WRuxx2wDwonBV3LRXmjwBF3ge/nG/ToCRzIWmDmaAFTQpy+q5UP2Nlw3smBZWKCTS
	 8NlPPlwh1IZQ+uTyZfg3knGX2FAK/8zsw9UaXrEr/ovYoHbVdgsviSoMsp9m2kSIXQI/b
	 EOxYCZuWVQCvpAvtYwzYTodAgvKeJ7Y3SsPTlaTw/kakMTwIDBC0u0FRSwRH4eS879QXM
	 bd1q+imnhwppVX4rdDfkGrRe0Eg2YOV9w9ax/FZhfU8aZtOPbjfuDrQl9D0DtWjfuy2Hi
	 Fk1dbMioDgU65HglB5MOhF7NYw4yAnQdV9f9MRqm0bx9esCdy2eypikeKyacKC7+m8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709223;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9kjhtb4pMCtL4sI0pWrXeiyW7bmvjyE4sCW+R/9c2t8=;
	b=FHT4SIi01W8KxecNIgN4aXqf8LFfuJDesEIzxCIhFHb4cfgpdSpJB1gbw6KINbaxI381
	 Ty7loHyOvulGnDsRqR/+A2K6yicWnrws8qGJ4QnF011jbh20t03ThnwqAVPLBHJ9gn19M
	 fPxVq/Pk7jeOQLKqm5elF9wl5n4Z6rEkt774uptz51mQ39R3gQmkpsm/oOudIofIaWhHw
	 J+48zp6UmKGUE4DOGNky1KSV7TQdiYxXB0adqbvQMZ0EdK7j+Nr/E+iyAz/ultR0Zf450
	 yvHvm5tCBpPQS/In5hZ8KaW1LH4YtRN19hcUl1nyt29eewzpF4cm9dZF3mPQORxnWaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BOcgH7Uw;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=N4mnIjJ0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB51606D832
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB51606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BOcgH7Uw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=N4mnIjJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793709221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9kjhtb4pMCtL4sI0pWrXeiyW7bmvjyE4sCW+R/9c2t8=;
	b=BOcgH7UwuxV78ljG5yC6qqBL/5O97h5DSz/cwhDLbu8/Vqe9pm6la9TZOEg7SkdGHk57tn
	w/rDuzZoLmHFuRdI7JMzFO43hWDtE2hUMe6/j/gaslhVDbh75k5QDoNkPOigL4/lsBTED5
	mBPtMKEC2dPB+O3b4wU7EdOM+cMHXeU=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Jz77QfS8Mn2P8JpLA2WIRQ-1; Tue, 03 Nov 2026 07:33:40 -0500
X-MC-Unique: Jz77QfS8Mn2P8JpLA2WIRQ-1
X-Mimecast-MFC-AGG-ID: Jz77QfS8Mn2P8JpLA2WIRQ_1793709219
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so5443238c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793709219; x=1794314019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9kjhtb4pMCtL4sI0pWrXeiyW7bmvjyE4sCW+R/9c2t8=;
        b=N4mnIjJ0gFZdIU/eAoQ0meISSelGwIuT51Iohh5OtxvInfHLmvly5WjlM0S6mx5KIO
         mAHM5oBDu7LxP4dEUfo4QUUqf50mTReagnA5qAVPbBcGvMpr4Uf7Qrp2lj6uWycpYX1/
         zTOWYlW0Kep63IqI9MCKC9+bc3WYcSNydgSZtOselsogavpv3Vl+MNnVdbgsbc14RM5+
         hFML+C/Dhe3DBE0DLu128RkQ0yU6u6VdWaoH6d39OVazmDFzt7fdEf+DDhjq2DFJ4JuL
         rgaVbdvgiXOq1HnI7WYnHN6sa5hu1QtOzGEt56GnaEeB6T5aOI1AiT9q7mVIkjFATwym
         bY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709219; x=1794314019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9kjhtb4pMCtL4sI0pWrXeiyW7bmvjyE4sCW+R/9c2t8=;
        b=S82wtsNoZ3O6a8c7OZmRnxaoPH2E9V7pvrPUuRGm4W4CE8d0/8cbNGUgdMZ+/oEUz4
         tiSOVCq+K1AhAOqL/i0bX4FbS7oqN9x63kYa3fxMsgUoRmNYGqGGBvDGT975ef4NlSMs
         EZ6T/n3DP7NIUmPDUCXV1bJxUD7EKPJQGnWjIf79M/5CAsENAuyJ7F9+rmA6n9o7cTDD
         jpxX0Ljzvoakk12NSWCoc7uth8/TIRyxkCPbO5XzZTE0SDgKuaqbtmyvzhBdXiWURb+B
         iA/mDjBxsxHrurAtFSzMjTOD8EQ4BlNe/tv2/8D+snhXcIeLzXU+251316BXLK5i673E
         PLQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy20lpMsn2QBKgVmp/xsOR0aY/A2w0c4gUINRgWtXTKyKr5YyXakW77KnddH5SVjR54+r8wdqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kppXTx3RMEeb38ICnO5Qh5koPvLnhhjzzzgIFnuM0ZKUEZnC/
	AK+srovbYoekG1kY/i0aKwIZou+11b8eEBKTz9g9Am3G4j3O7V/1X8Rmmux334jYbAPot80F2Cs
	4atjWPYrcsuv9XyzMhgiWXraQaUcA6hSDEFHCtu52ioUIhVn2HSOBvSiWXw==
X-Gm-Gg: AYBFou0Mf0nfVf5a9VkpWIw87jVCPEc7IG+hmogiymQGecnXQI467CyHVe+4lXM52mc
	7dTIZfll6YR2jfgZzWyF1BeZeyR6AxJakAoJq2c25M4njBo1w/2wVUgGiLy5SNYwiRWsTz6rEsF
	VeDg2cVWrSQqMARiFHxh0NpU/FTq8O+Yx+MGa/rNS2/Pgt7g05SmRgCiGD3gkmZwRSATNJhLzZ1
	6EZauFFS+eGbQHNMAxBrUgbZPLYu3qo/Ott9gAqx2n4VxIwpVkzAJL8IJEHLQwMAjB2uBeZlG3X
	oYgV82J2AAvMSUquiQUg1iMb44h5AszIpLwT5IAPI++qWAIBGlgLKRCqIiUkUZ6wESy+VcPXqTf
	D2sqe2Xa9WIdeXq9kh3RTmnTv6jekhQwxiyDc9h5Nwng3D/sSzR4wdobUlCk1iHdiPu8a5jU1aN
	9cL74vTYk1/EVb9xrOS61CuSXpy03NsIH4fPh+0saC
X-Received: by 2002:a05:701a:c907:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1ac5a2a138cmr19661585c88.12.1793709218878;
        Tue, 03 Nov 2026 04:33:38 -0800 (PST)
X-Received: by 2002:a05:701a:c907:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1ac5a2a138cmr19661556c88.12.1793709218260;
        Tue, 03 Nov 2026 04:33:38 -0800 (PST)
Received: from mgandhi-thinkpadp16vgen1.redhat.corp ([2401:4900:88f9:2014:83b2:887f:ed66:aa65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm46086298c88.12.2026.11.03.04.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:33:37 -0800 (PST)
From: "Milan P. Gandhi" <mgandhi@redhat.com>
To: sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	sreekanth.reddy@broadcom.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	mgandhi@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH] scsi: mpi3mr: Fix integer overflow in reply frame size calculation
Date: Tue,  3 Nov 2026 18:03:16 +0530
Message-ID: <20261103123316.223917-1-mgandhi@redhat.com>
X-Mailer: git-send-email 2.56.0
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

The driver reads reply_frame_size from firmware as a u16 value in dwords
and multiplies by 4 to convert to bytes. If the firmware (malicious or
buggy) provides a value greater than U16_MAX / 4, the multiplication
overflows the u16 result before assignment to mrioc->facts.reply_sz.

For example:
  reply_frame_size = 20000 dwords
  20000 * 4 = 80000 bytes (as int)
  Assigned to u16: 80000 & 0xFFFF = 14464 bytes (truncated)

This truncated value is then used to allocate DMA reply buffers via
kzalloc(). The firmware believes it can send 80000-byte replies, but
the driver only allocated 14464 bytes, causing a heap buffer overflow
when the firmware DMAs the full-sized reply.

Additionally, if firmware reports reply_frame_size == 0, facts.reply_sz
becomes 0, which can cause division-by-zero or zero-sized DMA pool
allocations downstream.

Fix by validating reply_frame_size in mpi3mr_issue_iocfacts() before
processing the facts data. Reject values that are zero or would overflow
u16 when converted to bytes.

An attacker with firmware control could exploit this to corrupt kernel
heap memory via DMA, potentially leading to privilege escalation.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index f0d3cd398dd0..2b72218e79fb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3261,6 +3261,7 @@ static int mpi3mr_issue_iocfacts(struct mpi3mr_ioc *mrioc,
 	struct mpi3_ioc_facts_data *facts_data)
 {
 	struct mpi3_ioc_facts_request iocfacts_req;
+	u16 reply_frame_size;
 	void *data = NULL;
 	dma_addr_t data_dma;
 	u32 data_len = sizeof(*facts_data);
@@ -3318,6 +3319,19 @@ static int mpi3mr_issue_iocfacts(struct mpi3mr_ioc *mrioc,
 		goto out_unlock;
 	}
 	memcpy(facts_data, (u8 *)data, data_len);
+
+	reply_frame_size = le16_to_cpu(facts_data->reply_frame_size);
+	/*
+	 * Validate reply_frame_size to prevent integer overflow when
+	 * converting dwords to bytes (reply_frame_size * 4).
+	 */
+	if (!reply_frame_size || reply_frame_size > (U16_MAX / 4)) {
+		ioc_err(mrioc, "Invalid reply_frame_size %u from firmware\n",
+			reply_frame_size);
+		retval = -EINVAL;
+		goto out_unlock;
+	}
+
 	mpi3mr_process_factsdata(mrioc, facts_data);
 out_unlock:
 	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
-- 
2.56.0

