Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217282;
	b=tloA+zby3lTi/tAK2ELJXZMud/y6kBimCrDk2ChknMwC53O3Uvh4I+Ft4G3+1be9+wNK
	 +MGmehLE/j2BCC9mrmn7OIWoImcqDteFFzaBfwpbKgdy1qTEa148kaI/TPRqjJKm2mSsC
	 V5TXntnBHnjR9IiRQ5ZfCsQCmOicgVbms9IMdH4W9ekLKcbb2UM1qEcCo88VaxPWhP/L0
	 XI07EfhM/mOU+VhTowhF2Lov9fXG9m+ZiuDbsNgaywUpsvSbavJLc5B2FOOfv1m6mabt7
	 peWPXpDMdS5yqTxgg+x2dDKn7z7q2Zsfgm7rbtNpR33gbcfEM80M+UejBKkjSTraa0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217282;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EOwhnjLJ/AbV6UB5ooR66kjvO/MNntg51ld+6sXgghg=;
	b=c84LyfsAazc6bAPYZ4Ucv1uzFHFEMWxaA9iyBroOxOrOiNFhOTSXYo5OpQ+I3J02xnk7
	 Uiuc+zkaR2MTlVsw8lnoR7I+Ilsq38mO/oFAnEEpGsyNhMpNKSk2+ZfooRieum4u9PALH
	 TqszIqIKW/9mwMEl3HlSyenRK7nzIOSAjU+YyqtElD87wN5RFByV+PSoJy4f83vUZPzvV
	 cApOnl5zYCOVkF+eGbKoxHeQ9Qhnm4/Npy/i5lbtJid9B6wvkDhTbfR696ZrrANljcYgN
	 Nqk5ZwbMys1+mzApxJ/xx9TXRjlQcQja1fpz0nYUkpIWU9egpgo0boN9Jk7H8Am1ehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bsbernd.com;
	spf=pass smtp.mailfrom=bsbernd.com;
	dkim=pass header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b="P/xgSj/s";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YsUGF+QW;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7103606A6AA
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7103606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=P/xgSj/s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YsUGF+QW
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B4F43EC0A77
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:27:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 18:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795217279;
	 x=1795303679; bh=EOwhnjLJ/AbV6UB5ooR66kjvO/MNntg51ld+6sXgghg=; b=
	P/xgSj/sQoN5wu48VDgLGzz9T12kWPThMTIF7LWywg8qKcIZxsXpDHJD/yODW9Cx
	WDD+ZebijQMtfqTKGBWYDQeobzHdOLfsxhusjikan3ZY4/Rre9YZbuivz0r6/iUw
	2MHMo+91To5P/5ih+M+RYuD/XzGl8Kdsr1fAAvnpolMe/FaM36emkCBWfdWmiezc
	zjgAgWiW0lz8dyaddGTaG5uI5zDKB8NgE21iMN7x1Vqj4k9on7aT13Moq7dPXNFB
	nYJaQ42Z0NaeIheyQ3UUEEDa2c4CTHX4HpaoYs5NFVGn6JEyT2v+h1If4VujBLmE
	zDZ9ZWMPPYBDcwYZ8ZvJMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795217279; x=
	1795303679; bh=EOwhnjLJ/AbV6UB5ooR66kjvO/MNntg51ld+6sXgghg=; b=Y
	sUGF+QWVnLG0cy7Z+gXgyz9tSuYiTzBOBkw1fbtQ0i3ibCCbHwI8F6xZdp+hb+E0
	7Ah/ywgdngx4yPcJbiKaEDb9VV5W3Qadw32Km/F8TvSwUMXYJe9d/4CRyFcJZr2s
	57e6VN/uqPCzU7N1oHZDy4IKt7PfUhxA8hMwj404hl7+A2Kj5dZ/xBo5OxTmygIK
	9fa24AZqtqC2XGkWknWD/m1C4oZA1FY/8RF9oyUHRH+0tmNkwr5HqbjLyYvUW+ii
	qaCO4MjcUSVB6+TBjr8Wlt/aMAXr8+n0GvSs9o+Lh4vVC6JWTryVoAI8YkO0ly/t
	g0BKbninIkUX3Xfy72jXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=bsbernd.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795217279; d=bsbernd.com;
	mf=PGJlcm5kQGJzYmVybmQuY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dbPRYWLdvOfxQ3y6AWfB4lEmZOYijZYzLO7dxzQUP0smSAB
	dg/Bwup1X6xOuOzFPSjoirUu0k/WpYRzBsy0QD65St8Wl6lmAKqGJWP70gM1CJL8
	Bo9pcrI6oROB6HWWphwCbLcee0t4RtyK7dXDmoShlXLdWcE6rkbW0Dwr5QwS8Nak
	kxvgz1FjANXcPjtUfvRlvfDaodp6JUR1iNPbo6Iaj4MGW6XNtLN/IkjDKpjdWpZY
	YfFl+SUcaBxyRKugDFDXZySxpeYSlnwFZF7K1dqhyrhXM096rYmSuqh8KpAPYtc9
	kcimOz641IAXEYmkYvEN5UC7aUPJhb7ZGJZoPVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2QlR3sJAQxUb6mb1sxUVLsWlPqTnVFhoT2TpAdj3hIM=:SQOWG9/Vb0XWYRyI4Mi0zJqYH+TNC0qeYHvgpyWuzQE=;
X-ME-Sender: <xms:f9cAayVLElTHdsSZnR0wizQYPEkGKx2OmSkWdKYNORj5PbXjv-PnIA>
    <xme:f9cAa9o30iXOfg2xKFiIpwenJDbkozkgUQYuzLJCIIX5fIPm4XmsRejESi2cK_-_a
    RocraNU9t77hVdzonQFK0lWLVit2nSWKUDq9a7ukJ9f9_xWME2M>
X-ME-Received: <xmr:f9cAa8lhNBVUb3F1-5WCmVjcektor726SjFOMgGhe2zCb33_lUkUOWp8Qc6PzTXEM35vAuVmVLwoHFWsC8xqOuLvOhghqbrcP-KSGaTU3edNGUXDFA>
X-ME-Proxy-Cause: dmFkZTFqxgK54Zjw7vWcpLaVQUGwSDFKYQTweJU1Ah6i8yZdAMyRsgZHff+3jnMVXagsn+
    A8dhn+bUZBL3llTy19WUH8BCwKZitzqLj1zMcb358re3S3Gx1AiKWbSZsPshDGTZRnBjbA
    ZQx/YugPOradA36VYtJvCi+AkeHBU0omNrDGwjIK8ac23hgD0g7m5WLsvU3m0uyZbXRUj1
    ybbRe4MdzBmQ1YsSBFq6nEJNvp2UPvdzuCrAREZWKpEA9q5Yiryt4J7k4AVv6/Kfk97aau
    EJv60mPhiYOopgqaySuAIEGrwr9Gt6gr9PJdfq5qSqS6Jjk87uYTuBeFnlp1O66mABrRkb
    nPsQ8cz+yHSI7qmj8ww0xECznfYCIQSbZhRws4noutbEMMOl0EayhgRKGyNStB1Zj/Rahb
    HkLebOKi/U++0JhDAbEzVbGM6n9Vzl8hPza9GfUeQxjU956y1kyuPz93ggF3qyS+IQqPI5
    DD3vW231/5j2xWdLapouL/sI5oQhd/vcl8CFcDnoR8vXaflDfgFqk/1lQZEEwRgn7xGJA6
    G1WRComMJMyaTKSqQvrCUhMiQMm5wMUR16VyHHko4xUrSCVhxelVjodHxjn6roORdO3SpM
    Jvt1D9v12BTtSEhZ4rGXpJVthcg/8bpm7pHhcYFnqYkg2qIpd0ZL1XEo1SnQ
X-ME-Proxy: <xmx:f9cAa11WXf9Ql5WM1kUh7ZMqg3Ph-2eK-OaoyqKiBapaqE_0BumC5A>
    <xmx:f9cAaxTiTwIuQzz-zNJtbvmm89NOppqFtf_TnIueR3zilnrrVrI5Kg>
    <xmx:f9cAa2w4SWSLdlBXxqThuIC9LmV86wX2Tlfi3EUVismyb8nyFL-Tcg>
    <xmx:f9cAa5BeMarKa0Lvpn8WZC_s4CCb8x8HgD6K6Qsa-JgOWrHqRHxptQ>
    <xmx:f9cAax2SopfSJEo7F66xRn1sg0MjZKUfsDzHl8fOBYo8Oa2Epiz7gZ7u>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 18:27:58 -0500 (EST)
Message-ID: <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
Date: Sat, 21 Nov 2026 00:27:56 +0100
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
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Luciano Lo Giudice <lmlogiudice@gmail.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: regressions@lists.linux.dev, axboe@kernel.dk, stable@vger.kernel.org,
 Ming Lei <tom.leiming@gmail.com>
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/26 23:55, Luciano Lo Giudice wrote:
> From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
>     stable@vger.kernel.org, regressions@lists.linux.dev
> Subject: [REGRESSION] ublk: dispatched IO intermittently never posts its
>  fetch completion (v7.0)
> 
> Hello everyone,
> 
> I'm writing a library that implements various block devices in userspace by
> utilizing the ublk framework. Every so often, I'm hitting a completion loss on
> Linux 7.0, in which an inflight request is lost forever, which leads to an
> unkillable process and a ublk block device that cannot be torn down, and so the
> machine needs to be rebooted to remedy this. I've tested the attached reproducer
> on 6.8, but found no hangs after many runs. Details of the bug are below.

Hi Luciano,

I just scanned the io-uring list and found this by accident. I have been
working on this for a couple of month.


Would you be open to test a specific branch or dkms module? I actually
wanted to send this to upstream last months already, but then found and
fixed (with a lot of AI help) more issues and also got busy with other
tasks.

https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-for-7.3

and here the backports, that also work on 7.0 (with a compat patch) and
that is used for our dkms module

https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports

The 7.3 patches are actually verified through tla+ and an ublk branch
for https://github.com/brauner/linux-formal


@Ming the patches for 7.3 include heavy ublk state changes (it is now a
bit closer to what fuse-io-uring does) and also adds debugfs that can be
used understand state issues.


Thanks,
Bernd


> 
> 1. Environment
> ==============
> 
> - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kernels that ship
>   with Ubuntu. Tested on amd64 and the ublk_drv module.
> - An identical binary was run on 6.8.0-117-generic but no hangs were reproduced.
> - This was run on virtual machines provisioned with LXD and with 4 CPUs.
> - After reading the code, I suspect the issue arises due to the 2025 rework (the
>   list batching first appeared in 6.15 and the per-IO task tracking in 6.16).
>   I have not run any kernels between 6.8 and 7.0
> 
> 2. About the attached reproducer
> ================================
> 
> - It's a single C file that requires only liburing.
> - 3 devices are loaded (2 are file-backed, the other memory-backed).
> - A fourth device is added, started, loaded (briefly), stopped and
>   deleted in a loop while the others are under loaded. This is the
>   fastest way I found to reproduce the issue.
> - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs were
>   observed after more than 10 runs. When the issue is detected, the
>   program prints what evidence it can gather (per-device inflight
>   operation numbers, the running threads' waiting channels and the
>   io_uring's pending CQE counts).
> - Bonus: 2 additional bugs where found when shrinking the workload:
>   A queue was leaking its io_uring (keeping the chardev pinned), and
>   START_DEV issued for a queued that had died before arming. Both stalled
>   the program identically on 6.8 and both were fixed in the attached version.
> 
> 3. What indicates a failure (from userspace's POV)
> ==================================================
> 
> - The issue is always connected to a READ request:
>   /sys/block/ublkb$N/inflight yields "1 0" and is never modified again.
> - The thread that handles the queue is blocked in io_cqring_wait (as seen by
>   inspecting /proc/$TID/wchan), byt the ring has no entries to consume.
> - The ublksrv_io_desc for the corresponding tag was written by the kernel
>   at dispatch. The server reads descriptors after a CQE is posted, but
>   this never happens.
> - There is no way (AFAIK) to recover the tag. The lost completion is the
>   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FETCH for
>   the tag is rejected (returns -EINVAL).
> - Something very similar also shows on the control plane, which is why I
>   suspect shared implementation details rather than something queue-specific.
> - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post their CQE
>   after the kernel provably completes. In one capture, the deleted block
>   device was already gone from /sys/block when the caller's 30 seconds
>   time bound fired. Repeated re-enters never produced the completion.
> - DEL_DEV was seen stalling 30-90 seconds on the kernel for operations that
>   should complete instantly. The io-wq worker thread was blocked in:
> 
>   ublk_ctrl_del_dev
>     del_gendisk
>       blk_mq_freeze_queue_wait
> 
>   the device was stuck half-deleted, and it reacted to ADD_DEV by returning
>   -EEXIST for minutes. In the worst instance it survivied its own server
>   exiting and stayed un-deletable (needed a reboot).
> - A START_DEV completed with -EINTR. The process was detached and arms no
>   signal sources. I didn't capture the pending signal set in that instance,
>   so I cannot rule out a spurious signal, but the same op's immediate retry
>   stalled for a full 30 seconds.
> - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, eventfd wakeups.
> 
> 4. Aftermath
> ============
> 
> - AFter the request is lost, teardown hangs and takes the control plane with
>   it. Looking at /proc/*/wchan and dmesg of a hanged instance shows that the
>   teardown uring command (running in an io-wq worker) is stucj in
> 
>   ublk_stop_dev/ublk_ctrl_del_dev
>     del_gendisk
>       blk_unregister_queue
>         elevator_set_none
>           blk_mq_freeze_queue_wait
> 
>   And the message printed by the kernel is:
> 
>     INFO: task iou-wrk-2115:2118 blocked for more than 122 seconds.
>     [...]
>      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
>      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> 
> - Subsequent control command hangs on the control mutex:
>     task iou-wrk-12720:12721 is blocked on a mutex likely owned by task
>     iou-wrk-12626:12629.
>     [...]
>      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> 
> - Killing the process doesn't help. The worker thread keeps waiting on the
>   queue and the frozen queue waits for a request whose owner (the server) is
>   gone. On 7.0, ublk_timeout(...) only takes action for unprivileged devices by
>   SIGKILL'ing the server. On privileged processes it retursn BLK_EH_RESET_TIMER
>   so a lost request is re-armed forever and never aborted, even when the
>   server is dead.
> 
> - When the process exits, the io_uring io-wq teardown warns while a worker is
>   still stuck and the process remains a zombie. The following message is
>   printed by the kernel:
> 
>     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x2e0,
>     CPU#3: live_server_ram/2115
> 
> 5. Where I suspect is the problem
> =================================
> 
> - Evidence points at the completion side of the 2025 rework.
> - per-IO task tracking ( ("ublk: require unique task per io instead of
>   unique task per queue", Pure Storage, 04/2025,
>   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5-0-9261ad7bff20@purestorage.com/):
>   our fetches are all submitted by the queue's own thread, so io->task
>   should always match at dispatch time;
> - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, task>
>   requests into one list and queues a single
>   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for the
>   whole batch. If that single task work is lost, every request in the
>   list strands - the observations are consistent with one lost request per
>   occurrence.
> 
> 6. Follow-ups
> =============
> 
> - Does this ring any bells in the 7.0 completion rework (lost task work
>   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch taking
>   a path that neither completes nor aborts)? Is a fix already in
>   flight?
> - Independently of the completion loss: should ublk_timeout() for
>   privileged daemons fail a request whose ublk server is gone? Today
>   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_gendisk
>   freeze and the control mutex - stuck forever after server's death,
>   which turns a single lost completion into a machine-level hang.
> 
> I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.0 on a
> VM, or capture the trace of a missing completion.
> 
> #regzbot introduced: v6.8..v7.0
> 
> Best regards,
> Luciano

