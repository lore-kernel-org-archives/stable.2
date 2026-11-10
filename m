Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322997;
	b=S9tNv+YB6j9cBJb+Dewrb7E4Ndr5XsxMsgub+g7r2ybQutC3OMSXjbUENLepUygmaLQT
	 4PhPdYhHmDM72WmLqKRejwXEYI4arakvvb5b069BrsDfZCHZzUP28WDvArw0JlNuUQdcu
	 4XhY7yQnWEg9vbFdVCHBQdphhtIHY7JGGJylHSzG1Lg1sKUxG1IvqKgCiZHx9RHHU3WcR
	 9RHm7VdpL5TJ+Hr5s0FgKSRUO1G8JEe0d6jt6F/OuZFv9IEE4w1MPz6uUHmYuGNlbG1Nt
	 wRLYp2OLYW/DdG8DdrDD/a41zRSqeg3Hej9HDHivIh+wtEcZb30knh0p19ek39/TPEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322997;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=QZB0q+GEpidbmtHQLrBeax2DjC60l4QpR8AzTM4Nb3c=;
	b=p4nqYFs431YJI4QFhzkalGeKWNfDRM7MO8bekOIOaD2Dpm+XbFr0Ie/JuUOj7qfH14SH
	 K3igURRkYK0aysJBSkNLICz8l8xzqUV7mzdFm5iegbUs5ACMvtg3+koueE4VNXWoKgCXi
	 BJf4P+ruZ/g2laTFO1Y3/haq59PV7iNyOvs3f9TqJ0jSZsJGl3jdjVib8fzM7MPrw1RPe
	 4ZtZGlrdJLItbtfLxqXcuREBPE3CE7d8erMpydlVo3c6QLb7qDf+SVbmLV9VIbi90vG3p
	 t4kqNo+KDiyri3FSQdPWta3gsL6UryVJTjmp8V4XD/xeBXrMtOrV/m9rPfy1/X8td5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gXTUv1ES;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E256606A326;
	Tue, 10 Nov 2026 15:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E256606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gXTUv1ES
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zP5jvlz8Xrnw;
	Tue, 10 Nov 2026 23:03:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322993;
	bh=Q5o/fJZPR3UnMWbcd2NNFI+2ETviUTMVjsZraiBnuZA=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=gXTUv1ES9voehtz+xpZmiudAhL9Tg9uZP0lgp7Qvsl55en7pVNQm/GNYL7yeWRRyR
	 cuRzY5VreybII2Y35+qRQR+gioNhkYKYky6E16bLhHGsAsCaLciCUqlJ0YuP/H496c
	 fzmOcI7RcJdVJo+Q9HyFfrSlgRopHUdzuoWHMSqBAFdGUJQWusjpKwY6rKA84wkcGR
	 KrFTYvgVIiCWQWqiZS/JThzR5GB7zYvfWZ5alam75xmuFtmHeLQFgvBfnG9NBLnZMM
	 g0QHHXneLyJEkVTigX1Tr0l8dJx5oNaTjUgfAvsIdWmiwXdQKEbyF8yCEuYbnwUqZF
	 RlKSjbfoe5zbg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AAF35mh011118;
	Tue, 10 Nov 2026 23:03:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:09 +0800 (CST)
X-Zmail-TransId: 2af96af3322d603-01c47
X-Mailer: Zmail v1.0
Message-ID: <20261110230309524NeYut_cyzQcD3jcjj_beq@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:09 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNl0gbnZtZS1sb29wOiByZWxlYXNlIHRoZSB0YXJnZXQgcmVxdWVzdCB3aGVuIFNHIHNldHVwIGZhaWxz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAF35mh011118
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33231.001/4jP8zP5jvlz8Xrnw

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_loop_queue_rq() calls nvmet_req_init(), which takes a reference on
the submission queue percpu ref, pins the namespace and, for a
reservation-enabled namespace, takes a per-controller PR reference.  If
sg_alloc_table_chained() then fails under memory pressure, the function
returns BLK_STS_RESOURCE without calling nvmet_req_uninit().  blk-mq
retries the same request and nvmet_req_init() overwrites req->ns and
req->pc_ref, leaking the queue, namespace and PR references taken by the
failed attempt each time this happens.

Release the request before returning BLK_STS_RESOURCE.

Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, 8 vCPUs) with the loop
transport and a file-backed namespace on tmpfs.

The scatterlist allocation was failed with failslab, narrowed to
nvme_loop_queue_rq() using the stack-trace filter.  One request is not
enough: nvme-loop caps it at NVME_LOOP_MAX_SEGMENTS (256), i.e. two
128-entry chunks, and the sgpool mempool keeps two elements in reserve,
so the allocation only fails when several requests are in flight.
Eight concurrent 1020 KiB passthrough writes on /dev/ng0n1, with
non-contiguous pages so that every 4 KiB is its own scatterlist entry,
hit it; blk-mq then retries the same request.

  unpatched                              patched
  delete_controller write never returns  completes in about 200 ms
  blocked in nvmet_sq_destroy()          -

The blocked task is in

  nvmet_sq_destroy
  nvme_loop_destroy_io_queues
  nvme_loop_shutdown_ctrl

waiting for sq->confirm_done because the submission queue reference
was leaked.  The failed attempt also leaks its namespace and any PR
reference when the retry overwrites the request fields.

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e579a307798b..e95167a13708 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -159,6 +159,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				blk_rq_nr_phys_segments(req),
 				iod->sg_table.sgl, NVME_INLINE_SG_CNT)) {
 			nvme_cleanup_cmd(req);
+			nvmet_req_uninit(&iod->req);
 			return BLK_STS_RESOURCE;
 		}
 
-- 
2.27.0
