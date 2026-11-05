Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881462;
	b=LFm6ontSnt/BDCYNr5mH1xLNCfsWBEf8KZhsut5dqIhn+dAveHMrHQ3sHHQiCEN4w+E9
	 nshGKr1BAT5q+jAY+5cz/+jcQ9Mb1ypeFQf8rJitZ+HxAK+Mhwy9IoPRYtMcL8c8XwwB6
	 eK2Cmu3BQy4chS7WvYoLE+bzDjfGc8el5gzgGX7N4b4LLDQ1xYyTgQjnPs3NgF2e+18Jj
	 8CHTYmjJG66+regioA41DgEcBjrCZ1xbv/jVbZ22CDDBg3yuS/ffvKpWtiCG3N/VlA4UR
	 9czXNjFuArbnzFZQkZ0aMGFyw+acs+Ucuw21a+1ztIPD/XUhWywFiAT0zj9fO+v72bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881462;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hZJeiaVH/GjKAUQoaK3P09WiycS+5a3Fe5WXL/jdsOg=;
	b=jWEb3VJNY++7vXQNVC7hdM9bF/qjF1sue0EDOE3uN477hu2MFnXaplenwNz5P/aWnTi3
	 eRMljns6WuUPBqHdFQ5+nG3TKQWxc5oPt6Ks9kRerqlvaMAwpm/SnQbiRNqiLhWWf02HR
	 mZxwm/igAq8YK3sC79PIs7veuhtP26sKti60Cd6nMvGjI5lG0JDTmT9Brgskj2Nvo2KDA
	 P5YeHFitLmd3oinr24++R8CiL+u69Rn8nGosKU6OO0gVgYdToNwHujBEzdaTI+eYlNoCM
	 azHy7yJVWIY7d61IesacnySXV8nYXeBidX5l/r02AecT+QtETi8NCxuen+i/l1++GsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fWLawPGv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WUEioGiP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A04606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A04606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fWLawPGv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WUEioGiP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793881460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZJeiaVH/GjKAUQoaK3P09WiycS+5a3Fe5WXL/jdsOg=;
	b=fWLawPGvwtzWNqtc7PV7MO2zVqNlqTs3wbKfQnklMc/HOkrCY69lD1DR/IWV7e6eZdC47Z
	C62xsu221DI8A3OtDiKliD6lyCozx0XX5ie/OGFFvfhKqgze9jC1IM8ZqjUuvL3Q19/5I+
	ACFhGUObbYibDCVR9Hm4YWAZuY57ltw=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-oiRKrI38O-2WqtCmJNgG8w-1; Thu, 05 Nov 2026 07:24:19 -0500
X-MC-Unique: oiRKrI38O-2WqtCmJNgG8w-1
X-Mimecast-MFC-AGG-ID: oiRKrI38O-2WqtCmJNgG8w_1793881458
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14373747468so3907143c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793881458; x=1794486258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZJeiaVH/GjKAUQoaK3P09WiycS+5a3Fe5WXL/jdsOg=;
        b=WUEioGiPHxZI4O9j0y3J+cdPJ0b5ZAjlJyTd6Lx0mCFlCFL2w09wpc7YehmYg1VN+O
         cwFFLm1q3mT6GbbvyJNU9X13JlcgELvx8075n53p+aqvkcuZF4eErBKkJmFYPg4ri59A
         FIgw43Iq/i5wb8CQwbVatwvo6Y4SDbVMITBO8kgQbUn8DdDTk25UJNRjKscmeeCW+0NY
         Kuf41VIGe8/oqU65i+COG4yNsz6+smfP8OGOQOJlznm11oETrvC08hSw4pQe8jINkfiq
         PYjyw61lTbXhr1HZuzG4HRnLXYtnfY3LRMb6geFHRSl++Pvl2xvm6FtlU8980ip0rXUT
         6x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881458; x=1794486258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZJeiaVH/GjKAUQoaK3P09WiycS+5a3Fe5WXL/jdsOg=;
        b=aA9IYc7X0ixAlxULtX1QP92PHGEbJ5ZXj5jHBIXRlUcdmOb/2jV5akvOy3J4jjZjwI
         H1cQnn5j64l0Nr97l8aP0er3fVqtdZ6Lbqf5jXoz51BNcAjqPB/ivvJhjTj7degoQUTv
         RET1ZJcV9WXZFaIZ21apL9/xjOphpKcX/I8ymavf63eBHk7UHPXMm4IG4W2NnIukPDVp
         h2eGHW1tWwdjHk52KZ5p5mITPujx3bnehDW0xFsCpiBK0eBNXoxklm09MiQcLQL4y6qh
         oJ4VRvj7L9IUBhZeBUno8XxWf/sUd/IAR6i4TcX/Dt5GHik2N3fV215gFUB8z0aq+IwD
         iYAw==
X-Forwarded-Encrypted: i=1; AKwUvBwNS+UsBou2y0LmfZB6z4ni2aVnpbKR7eLGBXXEq9CfB2x0H3+/Qil6YciBYmTZxeGP6OR9rIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QfPJk4z0cg/HWv18mVI28TSuFwmxnKECdWYv2a3xc6QC6kh8M
	zhdeqBFjekJL8z/vCdDn8tyWhFJAxkaQByY2XtMp/UYqCcRNbYhqVW+6dVgRXEIgy0f57SiAUu/
	AWjaFhgZ5igijMoUNdR+hKhMqAdBvnUtPxmawcfN7oHbnngMtwRZjgY7pSw==
X-Gm-Gg: AYBFou2y/JwsExSqG+Zn/Hz6L98Cc+3g3VkxDOYHLEXZwH3vk05/G/9iO1A1RMz7BfF
	udRUc9gxTXJhY+qPgzXiEQ3SEI/xQJtnvSomHneLanEsbh3FP+LKjMDC+QRgN4PKxmgh+HK1pol
	DJ1Gnz1NMLC3QkLoRD3dpOVB6lGGqC2EN6AmB1n8baCqPQdeACrRhnqh4V6tqmnAVjXURAeOPQc
	Md63JWkmLR/b4mcUJWyxA+lcvGJdWH9SDWboZ0T/yVG8c1KVCc/7CA7njQBTQwP4jGamBWxgX5W
	MaOhqjol/64YTqHHrbr1g33ly/mxcaoNzuBAGg9H+BNdCoZDI2TdscsUQOXkUp2zywNztH82GF0
	8oOX7o85zsKK4OJRt2J6jPVSvnJ4GLxtglOr3nOAePVcdvFnyspQyil6GZgp9LGU4gsxV1mTtbR
	9KDAuPfjS5uQv8Gj0bB8FYmqTQEeg+R2BkpMecsvE=
X-Received: by 2002:a05:7022:1707:b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1ac5cb19462mr26201839c88.41.1793881458068;
        Thu, 05 Nov 2026 04:24:18 -0800 (PST)
X-Received: by 2002:a05:7022:1707:b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1ac5cb19462mr26201813c88.41.1793881457405;
        Thu, 05 Nov 2026 04:24:17 -0800 (PST)
Received: from mgandhi-thinkpadp16vgen1.redhat.corp ([2401:4900:88fb:e4bc:f699:bfa1:8ae:63f7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm19713431c88.2.2026.11.05.04.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:24:16 -0800 (PST)
From: "Milan P. Gandhi" <mgandhi@redhat.com>
To: sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	sreekanth.reddy@broadcom.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	mgandhi@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: mpi3mr: Validate reply frame size bounds
Date: Thu,  5 Nov 2026 17:54:01 +0530
Message-ID: <20261105122401.266559-1-mgandhi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103123316.223917-1-mgandhi@redhat.com>
References: <20261103123316.223917-1-mgandhi@redhat.com>
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

Firmware provides reply_frame_size in dwords, which the driver multiplies
by 4 to compute facts.reply_sz (u16). If the reported size exceeds
U16_MAX / 4, the multiplication overflows u16 before assignment, causing
under-allocated DMA reply buffers.

Furthermore, several paths assume a minimal reply frame size:
- logdata_entry_sz calculations underflow or hit zero when reply_sz <= 20
  bytes, leading to zero-size allocations and divide-by-zero crashes.
- Unsolicited status descriptors and fixed replies (such as struct
  mpi3_iounit_control_reply, 64 bytes) require at least 16 dwords.

Validate reply_frame_size in mpi3mr_issue_iocfacts() to ensure it is
within [16, U16_MAX / 4] dwords before processing facts data.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
---
v2:
 - Check lower bound (16 dwords) to avoid downstream underflows.
 - Add MPI3MR_MIN_REPLY_FRAME_SZ_DWORDS define.
 - Clarify commit message and error message bounds.

 drivers/scsi/mpi3mr/mpi3mr.h    |  1 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index d6e16707fd97..e78383df619c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -83,6 +83,7 @@ extern atomic64_t event_counter;
 #define MPI3MR_ADMIN_REPLY_Q_SIZE	(8 * MPI3MR_PAGE_SIZE_4K)
 #define MPI3MR_ADMIN_REQ_FRAME_SZ	128
 #define MPI3MR_ADMIN_REPLY_FRAME_SZ	16
+#define MPI3MR_MIN_REPLY_FRAME_SZ_DWORDS	16	/* 64 bytes */
 
 /* Operational queue management definitions */
 #define MPI3MR_OP_REQ_Q_QD		512
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index f0d3cd398dd0..60a92366e590 100644
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
@@ -3318,6 +3319,23 @@ static int mpi3mr_issue_iocfacts(struct mpi3mr_ioc *mrioc,
 		goto out_unlock;
 	}
 	memcpy(facts_data, (u8 *)data, data_len);
+
+	reply_frame_size = le16_to_cpu(facts_data->reply_frame_size);
+	/*
+	 * Validate reply_frame_size:
+	 * - Must be at least 16 dwords (64 bytes) to accommodate fixed reply
+	 *   structures and avoid underflow/divide-by-zero in logdata sizing.
+	 * - Must not exceed U16_MAX / 4 to prevent integer overflow.
+	 */
+	if (reply_frame_size < MPI3MR_MIN_REPLY_FRAME_SZ_DWORDS ||
+	    reply_frame_size > (U16_MAX / 4)) {
+		ioc_err(mrioc, "Invalid reply_frame_size %u (must be %u..%u dwords)\n",
+			reply_frame_size, MPI3MR_MIN_REPLY_FRAME_SZ_DWORDS,
+			(unsigned int)(U16_MAX / 4));
+		retval = -EINVAL;
+		goto out_unlock;
+	}
+
 	mpi3mr_process_factsdata(mrioc, facts_data);
 out_unlock:
 	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
-- 
2.56.0

