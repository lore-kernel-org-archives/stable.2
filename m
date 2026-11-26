Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795652562;
	b=AZoqAAiilBC6+bWvuvJKW+lcT1k+XOMTyF7M4AM3ruvnnOpvgvuzgqiwDs/BDhehtmMn
	 IK5wcL2li5s9pUytP5nW0mt3v3LzYwF+U5PyGWxXzW9MHjSyovtzqnyrcyyhWHN0yENvM
	 gnvD2c/i7Oh4fTu3hXQO+hmtulnxOewYefFbKPlTXAZgZSc2466TJKCTiPHubDLoSFU9d
	 72dUhptxryX1Jwhoti2zz6zAxn5Tc7dA9w7dxCmti23Su09zpcjEfDahnbI8fJuX4uLHS
	 7XI1Gs4/1rmYhizSighSfSEFeE14SEree+JFkcPxNrPnjaj06DZE9Wm3E+0hA1IN3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RvV89/qcgojhFu+RPZnXe+UxBxtm+exO0xuVGHxO5L4=;
	b=RMfF5uD8SLOMSRt0J5oJF4zY4jCTWFu49TMwSTsUKDy/69kETTIdquIvSO6VXEo5TI+n
	 0ILVUfNmS84zIio959Vsu9iATRcWIkgCtoZlbLNznS17FeSdtlGMH+ibLqVZSpoDAYYAz
	 8sj4Ezd89iJpGbAL9NlpZof9tRw0bM+j1gvQpWRcCWStbwVmfzggOy6bTJcFcVsgOkWIo
	 nZzGYC8qnQaSKljJBQS6ebY2gTDT7HvwJIdb37T64Px3SgfScWb/Wi+PtzB9Shh65Oe1p
	 soFo+pgKf0T2K7ZnrDZRzQkcMDHqECAlByfodIoOcZS8u4315sD0PyDXIXcB0b/QIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swOLv2Po;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D71606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D71606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swOLv2Po
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385c497bf94so4173865eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652561; x=1796257361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvV89/qcgojhFu+RPZnXe+UxBxtm+exO0xuVGHxO5L4=;
        b=swOLv2PoVQfp7z0bWusZ1lYJb1ED6n6l6s0V0iFQrQ+SfblhZBYgl2eVq1PibYWMPq
         wmG5JQg6LaoHuWNcHgw9I2VpccmTMYHzbjAq7So23lsSk5gAHy5XDfmP5AoHW+o1Im12
         PFpv2+aPJytV2sA5DJREEuDBp4RwJ0cjqoj9N0j5LBWI2HEu0eSzXFwK5MsjpBwPDLyo
         U/wugmgwjip8CNjVuGbjfx6oGZaTG3KQnr0Rm5+3SZbVrxgXq5Pd9fqUiiDtYDO/s/rm
         5pAmaaSqcHMUTSGI9HCqBtOTFbfsFoDTqkOL+IlW92G/V3g8vreFdNqN9REiCRSkC2is
         BURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652561; x=1796257361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvV89/qcgojhFu+RPZnXe+UxBxtm+exO0xuVGHxO5L4=;
        b=x6bZiGUBTfYiuHrhHixbNQTwRaVn+lEOn8hkfbkvLi+cOM7oWqlQ26+rPqbf/Bo49L
         w2hC9rhXRLH9HwQFzf7/oHI8wUiA3NapVY3137xH0Y4ji0nbO5HuPWmJgBg7L843qB6s
         1ilpbmz6nON93fTeYAYJ+HYEOYMuVyWqjR8WUoHPbTbIYLiHhoIddfAsNbsYEOxzl7CM
         4tlfosNttPR0I7LYV3QRRV7wsbfJoJ9P8kcUygLF+Fc8ew84fWXbKMAJV9oDTfDEuQsq
         J4NC1DE2JECp2sKSbY0ig0wo2eOufHUS8F4/hu9fzCwhml9dOhIvGGgfqJeTQ7SfmbMn
         KY0w==
X-Forwarded-Encrypted: i=1; AL+hErFXlEIjTjww2QhRc/i7/L/LIgXN/f9OMCWq/l2IvLXqt4jltmx8hn5KCk7d2Ny11NnYXs4NANs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FlOLahxwDnRwHpQk2HYwoHD9ZgPsxn/WFVMfYqOIepnURJH3F
	gN0Zu2oVTR4j2wmj5LMILAJMI7B5KrN42chu3CmwzXj2GofMeUQtRov6
X-Gm-Gg: AZFdTZc01I/E8AFp/X9mNIjHUTF/CNM8G/Q85ajAZxHPbxg55HVVF5y1eaI0ZtNgGyE
	UePZnw5BCUp8iuLwfDbpwLolru54IAax9+hFnA4W2h6pV3i8y7LqzeQ3vyL9va2ntH6+ueEwHb2
	pcMk9pOP7qb/2x4BO1lweFlMUUybxw7qe+k66PZTI6zaUSFxQoThga3jTRAP5Yzzm13k4bccbB5
	pzyHEHVdIfXvxQwm4wkA7ylDXFsd8azNl7/w7EdkN6DJAoGN2efCDs9PkRCD5yH4OT5lAqc4bER
	QBEHEf/bEAs7u9p5wbPP4HPHHTIceOfwogAQkFz5NI1cT2TYQafyMOOSdmA5OS/SpqHSWKlbJGL
	wwwb3J+pKvKXQN0BEOvQ1rDMuXKnPfFRtgJRKSlcr6THL3xowv0A5KPyZ3se2c42dz0XuKQUVH5
	v6LHB7vXecfBRp01j9OLo+ZToPrkuD15R49gkpqpXBm8FB+2lmwYrot9a3CM6nwavuPlUeU45Ox
	uaz/Bz9WocM93DIcPQNGWOr3CNtRB4xuKBMy5AsE4dmo+M8shmA0Rb7eTx/4r+G2OYYXGGIE5xr
	Danvj+q59/fe5rRedph8jZJql9BiDMlXjPLVP62/R17j0h5VmRCYAWaHT1M2mEm586Ho
X-Received: by 2002:a05:7300:f0c2:b0:386:688:7f25 with SMTP id 5a478bee46e88-386068880f5mr19561356eec.18.1795652561111;
        Wed, 25 Nov 2026 16:22:41 -0800 (PST)
Received: from localhost.localdomain (wood.seclab.cs.ucsb.edu. [128.111.49.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm101632315eec.3.2026.11.25.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 16:22:40 -0800 (PST)
From: Praneeth Balasubramanian <praneethb2002@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praneeth Balasubramanian <praneeth@ucsb.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/srp: Reserve send queue and CQ space for ib_drain_qp()
Date: Wed, 25 Nov 2026 16:22:27 -0800
Message-Id: <20261126002227.3598226-1-praneethb2002@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <70bd9162-e9f9-4580-bfb5-cc29107a4126@acm.org>
References: <70bd9162-e9f9-4580-bfb5-cc29107a4126@acm.org>
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

From: Praneeth Balasubramanian <praneeth@ucsb.edu>

srp_destroy_qp() calls ib_drain_qp(), which also drains the send queue.
ib_drain_sq() requires the caller to "ensure there is room in the CQ and
SQ for the drain work request and completion".

SRP reserves that room on the receive side, where the queue and CQ have
queue_size + 1 entries. Commit 9294000d6d89 ("IB/srp: Drain the send
queue before destroying a QP") switched from ib_drain_rq() to
ib_drain_qp() but did not grow the send side. The send queue and send
CQ hold exactly m * queue_size entries, which is the most work requests
SRP can have outstanding. If the channel is torn down while the send
queue is full, for example during error handling after a target stops
responding, posting the drain work request can fail with "failed to
drain send queue", or its completion can find the CQ full. The QP is
then destroyed without the guarantee that ib_drain_qp() is meant to
provide.

Add one entry to the send queue and the send CQ, as nvme-rdma and iser
already do.

The missing reservation was found with an LLM-based tool that checks
callers against the rules stated in kernel comments.

Fixes: 9294000d6d89 ("IB/srp: Drain the send queue before destroying a QP")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>
---

Notes:
    v2:
    - No code change.
    - The author now matches the Signed-off-by. v1 went out with the gmail
      address as the From: header.
    - Added Bart's Reviewed-by and Cc: stable.
    
    This was found by an LLM-based static analysis (GPT-5.6) that checks
    kernel code against the rules stated in its comments, as part of research
    at UCSB SecLab. The patch and changelog were drafted with Claude Opus 5.5.
    I reviewed the patch and take responsibility for it.
    
    Testing: builds without new warnings with W=1 (x86_64). Not
    runtime-tested. I do not have an SRP target setup, and I have not
    observed the drain failure myself. The change only follows the
    ib_drain_sq() contract and matches the receive side and nvme-rdma.
    
    The patch applies to mainline 9ba46df34488 and to next-20261116.

 drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 955f36efeebd3..2cd0b728424e2 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -546,7 +546,8 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 		goto err;
 	}
 
-	send_cq = ib_alloc_cq(dev->dev, ch, m * target->queue_size,
+	/* m * queue_size + 1 for ib_drain_sq() */
+	send_cq = ib_alloc_cq(dev->dev, ch, m * target->queue_size + 1,
 				ch->comp_vector, IB_POLL_DIRECT);
 	if (IS_ERR(send_cq)) {
 		ret = PTR_ERR(send_cq);
@@ -554,7 +555,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 	}
 
 	init_attr->event_handler       = srp_qp_event;
-	init_attr->cap.max_send_wr     = m * target->queue_size;
+	init_attr->cap.max_send_wr     = m * target->queue_size + 1;
 	init_attr->cap.max_recv_wr     = target->queue_size + 1;
 	init_attr->cap.max_recv_sge    = 1;
 	init_attr->cap.max_send_sge    = min(attr->max_send_sge, SRP_MAX_SGE);
-- 
2.25.1

