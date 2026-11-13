Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592975;
	b=SwbUD3Nh90Ry6KwbRky6XBZy52lOu4GxkGPfYvRrbHhiYsS5eftFub20kdxavLYnS9Zb
	 zFEL2x+CFTzOX1Nc4QtiBMb2rX0rk4K0SjFR1oqb+rC5V7qj6aLw7Vsju2SPGClDU6p0y
	 2albMzLdVAxJxOa7XyKz17gmg10ycw7WLXrM3B5GZ4+QuSHzy5xVAkxa66X6Zki7Mo5wM
	 6PnwzB6+DKEzEQQaoAVaaFMchsXkLtXNUjT6YdAbAjAFFGImGXbr3tmD3Efm034Ij80M4
	 dnYjnulvlvGMJgkbLP4muC8gsCauCkp6LOmp0EWEWZ4bF0n9PMj2F68EV+cwMr5f4Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=dSTt+yYVVvcyTYJVG1B816eCcEgN2CmPysK17/Qye+U=;
	b=l9xSJc8Wo6zE2aCgFBu/LsGnVDquVFutd54iWM8a4LB+NNF7nqUsSOQe3//lqNz64ycE
	 VMpmxMd7eIcrTKAdG9X/sR9WskAAWaf/lSWAf9bqeUC/Otfwog9RXxmjbPpnK7ZtHEE4z
	 aU0UJHSJEOS6/8BFnlOufcoxOKFF5zKiA2px7++ves7Ql9+YUy7IH9sbiQrdEYkDyUMMI
	 NuSYObGH+bPz+YsnmYHMkb+mPr7tViG6A6tQoFCR79YGawEPnkPLzkZSkSL4i3hRMqVcI
	 jhYzNf1ISlKMKHmBJ1NENXplmjhZuZPruB9x4l+sl3hUPyTXdMfxR8B6x6n5ovmqQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hIFxUvlq;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD2606A887;
	Fri, 13 Nov 2026 18:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0CD2606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hIFxUvlq
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4qJ5Rp4z51Sm5;
	Sat, 14 Nov 2026 02:02:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592972;
	bh=lxwUsv1YC2nH4klcuyCE5pckTO5rITg3Q/ArWKywRG0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=hIFxUvlqvJVqXUtWIjDTddpYLcA7SbhFTzPR6NiLu26pMub1LgXwcuA3l26sC2uqz
	 2HNy6m+PNRFewfBABK/IayM/j5WYtrbfQrusY5nzw9tJToN35xrT2mznoKncDalglY
	 UWbENnbprC14/8qCWYzUr1nlaVUZUpAb8Pu+hrHqewr1IAu15DGWIP7OWDgqKVA1D7
	 ReIJUu9nKz9GwDxgOuQSlyDknjKp9aSjFqaskwEY6/nowPUzF0eSnwgPS1pXMJNJ+F
	 RobXx9DMOVlZuqXFCeUloS1+Kz2zE+riOGCF9/c+kVyE0A5jJI8a4eDtB9Z+rA6pjv
	 Kj+0q49W7JVcA==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6ADI2joO073550;
	Sat, 14 Nov 2026 02:02:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:47 +0800 (CST)
X-Zmail-TransId: 2afc6af750c7f09-1be49
X-Mailer: Zmail v1.0
Message-ID: <20261114020247496vkcK7wI6GvOZ_5q-oWd_-@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:47 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNl0gbnZtZS1sb29wOiByZWxlYXNlIHRoZSB0YXJnZXQgcmVxdWVzdCB3aGVuIFNHIHNldHVwIGZhaWxz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADI2joO073550
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:02:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CC.001/4jR4qJ5Rp4z51Sm5

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261110230309524NeYut_cyzQcD3jcjj_beq@zte.com.cn/

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

 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e579a307798b9781d290936074c15b2640dfa673..e95167a137086d114d0ec83c721798b385cb87e7 100644
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
