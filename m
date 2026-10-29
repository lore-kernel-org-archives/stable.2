Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279375;
	b=m1x8ctYVh/0//detLx+NVO10C3gAX86hfXB7Lj63PZdhZWP99vEeR57UnrhUVtqQYeXc
	 xQ5KO5u8movko568JkM/80H/Tjfy53jm30tllN0VdbopPg8B2k8akES4D/x6NzCuWLL4r
	 VTvrza9V1jtG0HbxUwN8QkvrHNx6NCsTZcSB/GBX+8dJy206UeMPnny1RZWRtBLbqW7bM
	 cS+L3x/qm68a0WE+tHxGqc4ePDJS50BRqEhmGGlJX2RduiYMFzVgco0lRPn5u4C8HpAUw
	 a2zsoEdOXsPznnxMqKE+X0bup/WhCMYbUOQE2stMHFqjkUg1MB3IzB5gFmNZYNjpd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279375;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UMz+d1PJLg5h+Wtxm65zwHt8O1ssfbNLYkm9paEGB2k=;
	b=V2MZtoPaFYkSuEk2dTMc1I9YHXYvCgPKBpUNJuadbHOF/4jL8PJ2ICMpYQbMnnzkcd2S
	 j+WZl3lbkKrf1cxyAJcnn0o5QVANDgmEYDLhpnEFh93AWmjuOa6sUoT+AyQNRuDtQ5+VV
	 DHQqHiw2k3FQYYjJ2vHuHjvQekNBhLM40XGDyEnnlw5Es2GLo0ST/yplkm+S3M2Sn+Fwh
	 t5O939+Yhiir7JKsU01jco2UF+OT7CnBnEzMIrDC11w3uR1TJ3rTTMqYy+emzRKrDsWaF
	 aLV7JqJEZX2phpV6a8J1G8h6UuVzDiZ070+LGJv7uuOSran1Oc6V2nLgVWPyIYPo38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hO4SP2x2;
	arc=none smtp.remote-ip=95.215.58.193
Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126D606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5126D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hO4SP2x2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F7yOuWqfxHFz/mG7VplEXKs0bWF5sLdGW/cWLYDLPpQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793279371; v=1; x=1793884171;
 b=hO4SP2x2jRGPbqcOlM33ldS40kvt7NMghS/gYpk4Q18xhOWJ4TEprj8idzflFsVC97SieC01
 OEe+gafuBJsNtv4xxmt9qd+kDbzkjMhSr9gMtz4VVIS1B5KaHdCrUFcW06lsEuc4vXRSq9T+seL
 XDO3SpRVFwYjsOhuJ3eAF85Y=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id dff8b26f4d6af5c4;
	Thu, 29 Oct 2026 13:09:31 +0000
X-Mizu-Trace-ID: dff8b26f4d6af5c4
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfa3f8d1-fa82-4c4b-91bc-e2529fbb5ddc@linux.dev>
Date: Thu, 29 Oct 2026 21:09:19 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged
 scheduler inserts
To: Qiliang Yuan <odys.yuan@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <tom.leiming@gmail.com>, Wen Xiong <wenxiong@linux.ibm.com>,
 yukuai3@huawei.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/30 15:38, Qiliang Yuan 写道:
> When the submitter holds no plug, blk_mq_submit_bio() inserts a request
> into the I/O scheduler and runs the hardware queue asynchronously. Now
> that __submit_bio() no longer opens a plug around every bio, this path
> is taken by all unplugged I/O to devices with an elevator, such as
> io_uring submitting at most two SQEs per io_uring_enter() or synchronous
> O_DIRECT reads and writes.
> 
> Each of these requests queues hctx->run_work on kblockd. kblockd is a
> per-CPU WQ_HIGHPRI workqueue and blk_mq_hctx_next_cpu() returns
> WORK_CPU_UNBOUND for single-queue devices, so the work runs on the
> submitting CPU and the kworker preempts the submitter once per I/O.
> With fio (io_uring, 4k randread, iodepth=16, one job) the submitter
> context switches about once per I/O. A single-queue null_blk device
> with mq-deadline drops from 289K to 193K IOPS, and a single-queue ublk
> device, which defaults to mq-deadline, drops from 265K to 113K IOPS.
> 
> Run the hardware queue from the submitting context for scheduler
> inserts, as flushing the per-bio plug did. Keep the asynchronous run for
> the hctx->dispatch_busy case.
> 
> fio, io_uring, 4k randread, 16 vCPU KVM guest:
> 
>                                                   before     after
>   null_blk, 1 queue, mq-deadline, qd16              193K      289K
>   null_blk, 1 queue, none, qd16                     354K      356K
>   null_blk, 4 queues, none, qd1                     356K      358K
>   ublk (ublksrv null), 1 queue, mq-deadline, qd16   113K      265K
>   ublk (ublksrv null), 4 x 1-queue devices, qd16    290K      852K
> 
> Fixes: 9cbbac29d752 ("block: Remove redundant plug in __submit_bio()")

Commit 9cbbac29d752 does need to be reevaluated.

Our customer ran fio tests with --bs=4K --rw=randwrite --iodepth=1 --numjobs=1
and confirmed that adding bio plugging to __submit_bio() improves performance.

Without bio plugging in __submit_bio():
fio:
__submit_bio                              (17.16%)
  → blk_mq_submit_bio                     (16.80%)
    → blk_mq_run_hw_queue                 (9.97%)
      → blk_mq_delay_run_hw_queue         (9.41%)
        → kblockd_mod_delayed_work_on     (9.13%)
          → mod_delayed_work_on           (9.11%)

kworker:
process_one_work                          (12.48%)
  → blk_mq_run_work_fn                    (11.70%)
    → blk_mq_sched_dispatch_requests      (11.00%)
      → __blk_mq_sched_dispatch_requests  (10.91%)
        → __blk_mq_do_dispatch_sched      (10.26%)
          → blk_mq_dispatch_rq_list       (7.84%)
            → nvme_queue_rq               (5.85%)

With bio plugging in __submit_bio():
__submit_bio                                (26.94%)
  → __blk_flush_plug                        (21.36%)
    → blk_mq_flush_plug_list                (21.24%)
      → blk_mq_flush_plug_list.part.0       (18.38%)
        → blk_mq_run_hw_queue               (15.34%)
          → blk_mq_sched_dispatch_requests  (14.55%)
            → __blk_mq_sched_dispatch_requests (11.27%)
              → blk_mq_dispatch_rq_list      (7.41%)
                → nvme_queue_rq              (5.72%)

Adding bio plugging increased IOPS from 60,000 to 74,000 and reduced latency
from 12.4 µs to 9.5 µs.

Commit 9cbbac29d752 states that bio plugging increases CPU usage. I suspect
that plugging may allow I/O to be dispatched faster, concentrating CPU
activity into a shorter period. This could increase instantaneous CPU
utilization while reducing the total test duration.

> Cc: stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  block/blk-mq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a26a11c73ee3e..54eff3cf45fae 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3200,8 +3200,16 @@ void blk_mq_submit_bio(struct bio *bio)
>  	}
>  
>  	hctx = rq->mq_hctx;
> -	if ((rq->rq_flags & RQF_USE_SCHED) ||
> -	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
> +	if (rq->rq_flags & RQF_USE_SCHED) {
> +		/*
> +		 * Run the queue from the submitting context, as flushing a plug
> +		 * does. Punting every unplugged request to kblockd lets the
> +		 * kworker preempt the submitter once per I/O.
> +		 */
> +		blk_mq_insert_request(rq, 0);
> +		blk_mq_run_hw_queue(hctx, false);
> +	} else if (hctx->dispatch_busy &&
> +		   (q->nr_hw_queues == 1 || !is_sync)) {
>  		blk_mq_insert_request(rq, 0);
>  		blk_mq_run_hw_queue(hctx, true);
>  	} else {
> 
> ---
> base-commit: 551c722f40809618230001baccf219193e22fc5a
> change-id: 20260930-bug-blk-mq-noplug-sched-dispatch-4f19360b0bf7
> 
> Best regards,

-- 
Thanks
Kaitao Cheng

