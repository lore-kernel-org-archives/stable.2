Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709642;
	b=U58kXIUa0h4RVuZP9cU3jCWqgNzVE+YUdAKZSewHo8+Jkl0c3CQG32Te8T3DLpOdydFk
	 sK/kZcse/wgboju1YZD1J8TfR+k1TnFOcixkL9JcGxOxXLQUjpWODPJr0a1UZLc9TdZU8
	 EX5w2kAbzaAysHOr5ec31zhGIGCesohLSOYLD6GcQAUf0l76WKPl4ibHKLVn34TbcA4bd
	 4WcjSJtueCGVulz6eWXo0dNtyvXOfXr0/iZr2MQItngK8GRMg4NrboXO46DwfkYq0Fcn7
	 Ijhm7FP9pY7wJLprAMAE8Qm8CdXGNYWlKz4x7COM/j0ptZBQv0Em0ZafZ8LDQ+kBeuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709642;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YB3FOJ+gRSJ3MX0qWZZc5Mi4TxWLs6ApSSKDzuinJY0=;
	b=GikGhiFA7c2dwG/Oa5q41k3McoqGo82BqRiRXXs/1XpOt6+Lm+oFk7piD1qEjJBSWG1b
	 q0waIusr1yklxItOBqQsHKVxJhuCy9DeYOcq5Zth2Q66UUKdgvkULCWw6ClLTfKJi+RIx
	 yj+f+PZUwHd4Vg/gXZ8fDnU5tAxsMHmJjpUVs1/TNsTrMoQm9o/MWu7eRBFy4ob1DyoJ5
	 D9GLTY++5DbvoWVQy3D1KufDI1JJmqgb1w8VXnPh1SMhBqsY2txol8ECoY0MSxH8RLnGn
	 f6FnyOnyEE9+Icc28VdHRV/djW351X3ayeNYjCFz8I/LjIIKSKvEvNDU8dwY8kMAqCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hYhHbtXG;
	arc=none smtp.remote-ip=91.218.175.197
Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67341606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67341606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hYhHbtXG
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k0KgbZ8KIRqFXobVQdI1EpDgbojxN/wJ2vGB/cIrI4w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794709639; v=1; x=1795314439;
 b=hYhHbtXGQBgGyveJ8DF55Zw/ijGjlZIQF5bQC44up7raecVZay06htxz9LLpw48euJmnP67J
 PolrGxRyNjnOG8EoWENbN6cDyxJHx8FodDrrgFd/tQc0GApzsTVYpqbhz2bFFvdv2OMJRYPmMbG
 IilbMPBZlB9UL1ydVSkkap4g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e138b811e0af93e6;
	Sun, 15 Nov 2026 02:27:19 +0000
X-Mizu-Trace-ID: e138b811e0af93e6
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
	Qiliang Yuan <odys.yuan@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	yukuai3@huawei.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged scheduler inserts
Date: Sat, 14 Nov 2026 21:27:13 -0500
Message-ID: <20261115022713.391768-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dfa3f8d1-fa82-4c4b-91bc-e2529fbb5ddc@linux.dev>
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com> <dfa3f8d1-fa82-4c4b-91bc-e2529fbb5ddc@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kaitao,

On Thu, Oct 29, 2026 at 09:09:19PM +0800, Kaitao Cheng wrote:
> Our customer ran fio tests with --bs=4K --rw=randwrite --iodepth=1 --numjobs=1
> and confirmed that adding bio plugging to __submit_bio() improves performance.
>
> Without bio plugging in __submit_bio():
> fio:
> __submit_bio                              (17.16%)
>   → blk_mq_submit_bio                     (16.80%)
>     → blk_mq_run_hw_queue                 (9.97%)
>       → blk_mq_delay_run_hw_queue         (9.41%)
>         → kblockd_mod_delayed_work_on     (9.13%)
[...]
> With bio plugging in __submit_bio():
> __submit_bio                                (26.94%)
>   → __blk_flush_plug                        (21.36%)
>     → blk_mq_flush_plug_list                (21.24%)
>       → blk_mq_flush_plug_list.part.0       (18.38%)
>         → blk_mq_run_hw_queue               (15.34%)
>           → blk_mq_sched_dispatch_requests  (14.55%)
[...]
> Adding bio plugging increased IOPS from 60,000 to 74,000 and reduced latency
> from 12.4 µs to 9.5 µs.

Thanks, this is the same pattern on NVMe with an I/O scheduler. Without
the plug every request is dispatched by kblockd, with it the submitter
dispatches the request itself through blk_mq_run_hw_queue(). This patch
leaves __submit_bio() unplugged and runs the queue from the submitter
for scheduler inserts, which should give the plugged profile without
the plug.

Could you run the same fio job on the unplugged kernel with this patch
applied? Ming asked earlier whether real devices see a difference, so a
Tested-by from an NVMe setup would help if it gets back to about 74K
IOPS.

Thanks,
Qiliang
