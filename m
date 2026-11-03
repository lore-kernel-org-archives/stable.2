Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735512;
	b=VeYHnvBVwjz9axx5ZzXewNOREXgAtsG3VUCJuDl6GU8H6wjR40iYTt1jIa7rOxLYZCu2
	 /6Huluexo60An8FIIJJNNQP3pIANBZRLhTt99A4K5a0KU2Xqn1P3mro/UU4Dzky6BWbE3
	 BChahzIWVgPfR6DP/U9qcE2lFa62sbn0i1uMji/MBzNal4a+V8X78OyCkSDSRkLfTEY5g
	 AlS16W9Xg1xr7ZTeVw6IWhj9ipVlBmXI3bwBG0mGpvhIirpE5XlCPNjLHFreBbor994N9
	 unT7x+rHncaD3VOSrahcdp3OyL5yqPkRUQwNxJByNOAWFDPoqlVste52+cdsIYrf7DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WxrrLBpL+5w882waq3Llcz01wK2qP4mY4UJBFpkoOwI=;
	b=4DZrbAiBB7CmlkdZAImuwPS8XbynXj5+5kDI8y8KrONULSz0ml6AtcbJbJEln8ZCbLOP
	 d5o2qpLre9G1fQqOaTswe4sNjyxroA8gv8mrRpJ77wN7m8RQk5daf3+YpNeB1xTglSvaV
	 AOZxnWzOZylieCYphQT9Y3RMQZRNTmiiCw0VgjsFdmFO9KWARY0+EYb7w6mYXVEdhzm1E
	 Hk3E9FStNjsRVHPZmQErwpzx9rmFRbn4Y9ufvAPXIL4xxfvOZYUgkeOdYJXFeD0f51YmL
	 a4k6X+JrBpEwNVxhX0yrxPpt/xIY/aHr2JwHCFJol7zGaGS4uXr8thCNNi49Vhn4lvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=WwSYwHPi;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574C606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1574C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=WwSYwHPi
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-369f33df08eso8716150eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793735510; x=1794340310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WxrrLBpL+5w882waq3Llcz01wK2qP4mY4UJBFpkoOwI=;
        b=WwSYwHPitFHEdjhsZkjJSH7aWMdpA2YA//1JDRcF1RwEGXr/nMaefmAdOd6dOQ/eiX
         Bi7QfWeOW3DsCYxr2DGzEpqrrcTsjf6leFK3LNZ1J0NbB4jAi0qwokTKx0sXCZ6TC+BK
         iUO9xNgvq21yma8wfdqVogCOc82bHMBBblWnwsgvOOvJWC9OGGQNHiIEo0/VSpCjdyV8
         o+FXQ5kUCmjbZ9kqx5DzijIRPUndCy54O0gm8w6yGHaGaKNUjmWXiKmaN0No6IRLw1ZB
         MUxkEvLyfuySLLaaQfvEFblT+krcv31ckRI+DkWYKsLD4IsQ4eey+jvUC1fiEoh9j7s2
         bLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735510; x=1794340310;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxrrLBpL+5w882waq3Llcz01wK2qP4mY4UJBFpkoOwI=;
        b=yxIskkB5238bqe66mXw+MmySJUTVb4SzgdImw7xSyb1WIvpcVTY/ZlOqQSr3ycSZdC
         4UFHx2UD7owtnMbGSnxB9RN6C+XreXNBWAscbKGaLD6MsZZLMCegZgMMlyOe2lJESS/i
         s5B9W3y0ZZR5rz7A1OcDMfShOIc/baD6WAfqYl+aO4XQ7/vQlMExxB4h+DMdLjvYFlI8
         SfsAM96bq4Gd5dTR0ibBrC0+P9C20xbA6NxTWctjcgaaSuRpqsy2JjukDjo7mKvCj1+M
         R8F7jXjaPOhGBS+FiWNVJwZ8tSoGWIG4q4gKHmIw2dUpUuV6/kLyHnOyFBnvUyRm1mLr
         oPUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmLqmHUeNsVLpwEad74emtgyybrN4Q3Z+w0ikuBNxNoQbmvXr3HDbsO6kJdnKjIdpF8xwyMg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IAQcmdvOXeDdrdwlY/62iret6a59GCUk0ISImQFTVbgaopQ5d
	8xYa6AU6DiVyIFv43mmyryWvnONBf880WQ1IUMy39e3hhHlppt+NngGmf0vSfd+hVVo=
X-Gm-Gg: AYBFou0jbzwH07zzqTZ24G8GemIo3e1xeU+LX8Dun/4rSX5dX3LozQqgymhJm2JO/3F
	agCWEh+WMaxROe5Pv896bo5RqRmd6aDkHljZ1oGqxn6NTHJqt7LrTFsookYD/+YqVzkHKEo8dMr
	wwfPs3zvBlkeh4zKZdag+lkfHzV9bi+ualw88I+N2vnri0zM1w2GyeL5Qbf0YkuOSTQgs0KjKxi
	vHzMMFPPi5Yd2k75dWIwb/7l9uynqhuDtlm/QSkFvv8660SKAxHlX5JwjviV558RugsgBUeG6hb
	eLs8kTGP6eD3HEt03zACFLHUX2+WQXPIUM7woiyT5U/LU6PzvVidIbWgoa/72SVg4hJLVtCCcG+
	qhYoPzr8tqLhkHmxz2lpT78YyYVfCd0Tx+v9YhrfUkY88yLb5ABbFg43EE2jkMQLpiYxDnCuSHu
	FoWkKysFqCW33sco7OSOBAn2nE9e0WV92OkHUrfhhespzu17eyoii2KYMNT8ep1HEmllF0hwuI6
	Fp54Q+LnYA3reNXMcOrnRoA0JWYWSb3CjeAF0ssbERHD3JiZsK2XLMDoRh4BR+jOxbDykeImCEi
	/HXkBKDp4YrhSkfPhvO8dAIAepTeAHE6420+6BEPYNhqaRJS
X-Received: by 2002:a05:7301:438e:b0:36a:3767:ede0 with SMTP id 5a478bee46e88-36a4240176emr20856013eec.26.1793735509795;
        Tue, 03 Nov 2026 11:51:49 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm361141eec.12.2026.11.03.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:51:49 -0800 (PST)
Date: Tue, 3 Nov 2026 11:51:48 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: mt4022@columbia.edu
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: take quiesce_lock when removing a queue from the
 tag set
Message-ID: <20261103195148.GB5019-mkhalfella@purestorage.com>
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>

On Tue 2026-11-03 14:04:10 -0500, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> Unquiescing a tag set can run the hw queues of a queue whose hctxs were
> already freed.  blk_mq_unquiesce_tagset() walks the tag set's queues
> under quiesce_lock and rcu_read_lock().  Commit 71ec3c7d6db8 ("blk-mq:
> quiesce a queue that joins a quiesced tag set") added quiesce_lock to
> the walks and to adding a queue, but blk_mq_del_queue_tag_set() still
> removes a queue without it.  The hctxs are then freed right away since
> RCU only keeps the request_queue itself alive:
> 
>   Task A (controller reset)            Task B (namespace removal)
>   blk_mq_unquiesce_tagset()
>     /* finds q */
>                                        blk_mq_del_queue_tag_set(q)
>                                        blk_mq_release(q)
>                                          /* frees the hctxs */
>     blk_mq_run_hw_queues(q)
>       /* reads freed hctxs */
> 
> The window is short.  On PREEMPT_RT quiesce_lock is a sleeping lock and
> the walk can be preempted inside it, which is how it's hit here:
> 
>   [  399.851277] BUG: KASAN: slab-use-after-free in blk_mq_run_hw_queues+0x4bd/0x550
>   [  399.851328] Read of size 8 at addr ff11000003014148 by task kworker/u9:2/116
>   [  399.851352] CPU: 1 UID: 0 PID: 116 Comm: kworker/u9:2 Not tainted 7.3.0-16299-g81cb9aa43246 #1 PREEMPT_RT
>   [  399.851425] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
>   [  399.851441] Call Trace:
>   [  399.851457]  <TASK>
>   [  399.851551]  blk_mq_run_hw_queues+0x4bd/0x550
>   [  399.851564]  blk_mq_unquiesce_tagset+0x128/0x210
>   [  399.851576]  nvme_loop_reset_ctrl_work+0x78/0x4c0
>   [  399.851600]  process_one_work+0x92b/0x16d0
>   [  399.851660]  worker_thread+0x4e6/0xd60
>   [  399.851707]  kthread+0x300/0x3e0
>   [  399.851727]  ret_from_fork+0x4f0/0x6f0
>   [  399.851776]  ret_from_fork_asm+0x1a/0x30
>   [  399.851793]  </TASK>
>   ...
>   [  399.851988] Freed by task 111:
>   [  399.852040]  kfree+0x1b3/0x4b0
>   [  399.852050]  blk_mq_release+0x400/0x550
>   [  399.852060]  blk_put_queue+0x94/0x120
>   [  399.852068]  disk_release+0x1bd/0x3f0
>   [  399.852102]  nvme_free_ns+0x39/0x270
>   [  399.852113]  nvme_remove_nsid_range+0x2d1/0x4a0
>   [  399.852123]  nvme_scan_ns_list+0x2cc/0x390
>   [  399.852134]  nvme_scan_work+0x421/0x9f0
>   ...
> 
> With BLK_CGROUP the disk's root blkg holds the queue until a grace
> period later, which hides this for NVMe namespaces.  It's still open
> without BLK_CGROUP, and from reading the code also for queues freed
> without a disk (e.g., SCSI device queues on a UFS host).
> 
> Take quiesce_lock around the list_del_rcu() as well so that the walk
> either finishes with a queue before it leaves the list or never sees
> it.  With the fix, KASAN doesn't report the use-after-free anymore.

Do we need to update the documentation of @quiesce_lock to mention that
it is now taken when a queue is deleted also?

> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it about once every 20 minutes on a PREEMPT_RT kernel.
> 
> Fixes: 59e25ef2b413 ("block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock")

Yep, my commit introduced the race by not taking set->tag_list_lock
which provided the needed serialization previously. Thank you for fixing
it.

> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
