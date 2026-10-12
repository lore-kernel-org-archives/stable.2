Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D348EBF3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814382; cv=none; b=r2tefWDoIt3U8G3QI4jUK1VjBYcZmFiga9sw6PmbaJ6cieKsmSaHzs1TrCboBJAYwiRl300tCw4eRJT+fEL7z3PpWobA43Wb5qvbIvwgnL0amgheqQ697eRiTuNTYFEnkEniysdUDF5k6uh3/ZgBGt4GSUneig/Ld2oDXXVqN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814382; c=relaxed/simple;
	bh=S9T9R2mHJ1HQh10YHxIzMeuzc3FLyr0Tl+qKJMjpTB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF5GJlZNos596THvLjVGno2D6EGus8we8RNovXg3TjJhaiQfGTq1Suk5Dy3X+Igk+PDz3lQ0AVy5oFw84zFrHXAYklQpAQa6aPrd+sIcRQCpE53Sm3lSkYAuv/71GbUcLBo3LOtLGKB62udEro2Rlj3tV0xpWq6QD9bcj75HzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRG/o7xJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRG/o7xJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afbd2c386so989967f8f.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814379; x=1792419179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUnD1LOeI7J0+oxZWNA094IG/xUwZAT8pRqcJaVVo9o=;
        b=KRG/o7xJyXC5BtLwyvmhuZq+0vJB0EL8WRKJDFhlLIgb1nKltT78Pc59ZgwahF6cIm
         dmf46+X+cFysU5kUpV1sCiNfyMP6gA/ZvjnRXvdOmVH5dXV0UDcGv9zt6iB/bcNN0exf
         XuodeLG5nWRL1Pnv7dsHheVgfEYUYVEvPZDeAsvrAnR2iIK4PbHWp0CeqakKha//JzD3
         icFWK2snxKj8zp3FcHOs/URv2tC0np6MbbSP9o2vgd9Ul8oCpUlgIrh7JnCVreUTTLhM
         yqsGnSc4XoqojjDGehyN/qVgmp6Gwo7RJAiPuoYh2vwRsHWo0ZkhibtpwOnRJcJlPwgs
         rvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814379; x=1792419179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUnD1LOeI7J0+oxZWNA094IG/xUwZAT8pRqcJaVVo9o=;
        b=jNn3HF1vntE4ByV2eQThWA6OQjkPtnlVipVwJN8wlkvVe25ko+F6m+MfaTwsUNFP0Z
         jTxXmBmYq+/Qv3yLmK0Lkkvc4PG1iMeUzGnN/PVBBYbnGZw2ghCmHV1B8gx402OATzhX
         KIsBPfK+gpl00zz23Z86UjUyVt9eUH6oUqJMFDvjNA8mcy8vwS7zp6nT6adgO17Ivxq4
         622mQ6ZFW8f7honeyc9qqlj5iiXM1+YQdv0rCH7LruRhGoEreTaP7F2qBwUOXMmQdvUO
         iS4j+xQlXrL+k/8QcCYNZtsIfc+fIpTEyoZg91C57lgmSz2xLFP2i2998JkOCADWCPvp
         bdzw==
X-Forwarded-Encrypted: i=1; AKwUvBxunTtOKxNwmcCekqxRyRZEnKKWabJtFfegUJzfOxn/bQv2odbUC91e3ZE7xohHdS99KXPxtCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/Dxm/mn0HxghBadPRWrsl17EiXqZ8/MKSHQOwcc1BVLAIIKPr
	QN7GvehDGHY0fSat2y1mBIYK/QqU5M1+mY9rjVzNYuO07cNcD2j1ZGKJ
X-Gm-Gg: AYBFou2xydSpVPfXms3w8KZAZy5QtVqaLzeER1C0pRiCUqFuIELMCW2zgIBvyrYtrso
	g1G4ia5ECYxpY0RLEXkKze6lr1AeTy6mT7ReMGvE5Pebo/P2gaCR0soNFIL1YSh2rACBFW1eG5a
	x12aG40H0DIX9KQSA3TzoqHHAsbJf5KzOtMteUXMjb7cOlO+mJZjT1+TESJ7HJ1HQTtFnR5+dWw
	XghLex1cxwij5QaCkhyj1IXzzB6NhS/TRiU6nZQuhxTN14mLmAbiAhsuXXyXi8yuYzMczOAqXDS
	uXNI4tt/tkX1/bjgoF2hjEeCYIMNajgHqBbAKR2f1T6wKmEROJgY4Sy5x8lOW1IT/9gUkBT4eB5
	FKhQZUT4NLN4P4/qduDWzb3CEazVjaZyGRiq9AMRBG9uLEnp1EdZES8XfLZKWRe3hyxiVaP8pfs
	4IXFzXbaab5dI0HsuO3ozhIy3z9bkodDspjQSk2LG19kNA1Z5wVdktRJZrYHi7pVN53ZpYP30Rf
	fzX/i0wdNkKPUHxCyXRcu5Xh8j/jW7+1n5mQU7WPk4K
X-Received: by 2002:a05:6000:3102:b0:48d:ca32:e90f with SMTP id ffacd0b85a97d-48dca32e9b5mr10853775f8f.55.1791814379073;
        Mon, 12 Oct 2026 07:12:59 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:12:58 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone management receive
Date: Mon, 12 Oct 2026 16:12:29 +0200
Message-ID: <20261012141239.156408-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Zone Management Receive report returns the full buffer the host asked
for, but nvmet_bdev_zone_zmgmt_recv_work() writes only the 8-byte
Number of Zones field and one 64-byte descriptor for each matching zone
that fits. The 56 reserved header bytes and every descriptor slot past
the last match keep whatever the buffer held before. A 4096-byte report
covering a single zone leaves 4024 bytes unwritten.

The tcp, rdma and fc transports allocate that buffer with sgl_alloc()
and pci-epf with kmalloc(), none with __GFP_ZERO, and on success each
sends the whole buffer to the host (nvmet_setup_c2h_data_pdu() for
tcp), so the host receives old kernel memory from the target.

nvmet_bdev_execute_zone_mgmt_recv() also never checks the transport
data length against NUMD, so on transports where the host sets that
length, the buffer sent back can be much larger than the report NUMD
describes. pci-epf derives its data length from NUMD, so the length
check below does not apply there, but the zeroing still covers the
report.

Reject a data length that does not match NUMD with
nvmet_check_transfer_len(), as nvmet_bdev_execute_zone_append() does,
and zero the report with nvmet_zero_sgl() before filling it. Zeroing
NUMD bytes is only enough because of the length check, so the two go
together.

Allocating with __GFP_ZERO in the transports would also close the leak,
but it adds a memset to every read command to fix one handler, so the
transports are left alone.

Tested over the loop, tcp, rdma and fc transports with a zoned
null_blk namespace: before this patch, zone reports carried stale bytes
and a data length larger than NUMD was accepted; with it, reports are
fully initialized and such a length fails with Data SGL Length Invalid.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
pci-epf has a separate, pre-existing problem with SGLs that describe more
than the command's data length. Patch 5/5 fixes it.

 drivers/nvme/target/zns.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 23a17c02abee2..78d82b6ff1214 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -282,6 +282,11 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 	if (status)
 		goto out;
 
+	/* Only the zone count and matching descriptors are written below. */
+	status = nvmet_zero_sgl(req, 0, out_bufsize);
+	if (status)
+		goto out;
+
 	if (!req_slba_nr_zones) {
 		status = NVME_SC_SUCCESS;
 		goto out;
@@ -317,6 +322,11 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
 {
+	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+
+	if (!nvmet_check_transfer_len(req, out_bufsize))
+		return;
+
 	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
 	queue_work(zbd_wq, &req->z.zmgmt_work);
 }
-- 
2.53.0

