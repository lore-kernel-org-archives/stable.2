Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795218023;
	b=bT4p/29wPLh/ANOlvQVqqEm0ynKcF/wOGKkFcQpB9gtoJipYXgGZe3A+e79U7lNxppM0
	 k6nuGZFyZC19/KRjLyFnT3aHtj4Inr3+ML4th3hh8XJHfM5eIBRdWOsO8NbuBg0kQsMpC
	 eE1tRdzK0AV7gDEhZsukwTfDXicOzzZ6oD6hzfmqCU3kO1Ojb2yObAPMCDDMA8JIiggqP
	 fqh4+84sSE9THBb4aaW0QOMJudmLNu1l4Sq6IyQjKEphnbdvSjllTrqQ5k24Ub2NymBkq
	 YMPYTDd1eDGop9pymXqqpf8My1GiuZbeuyNQ65+BAo1mBPqd11soDqc/1J8sarZsc/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
	b=Hs2nWgWW0xmdf8BdAcLBGRnxow7Di/cdtR7LWLnk5KB9UEYnJoYRQ5RuBayC68IaJz9M
	 rBtC9UPyGP7YoRUUzzxUa0a32XUmtV+CpVPA2Uu1nGC8Q+MiSGbT1fjSYoeiT/G7QWV8X
	 HICSNiw5VBR3fIxd7NG/lpVDEMlb5vtCOfCkUsOWTodocWKBLrgvtFO1JW/FUPxvl1u3w
	 G+OWPfNircrVP5DQg9yGB1WdYsA/+PH1RJuzkvvrAFA1MdZBJbZZ1XstkAa8BrJr+pRbk
	 QWnFnSHF+nI+24gqFMBrd6AVXiIexNVj0BzsGzZZ2gOeM41Bk3FohoD8VdemUbonKrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsIrEnj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B2606A695
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA8B2606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsIrEnj
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1509541d50.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795218022; cv=none;
        d=google.com; s=arc-20260327;
        b=FyII28OzbVouUFT8YM4YWtTLOeZ//AXPSi2OZTCPcBuqGZYlAwN+nfMW+aqRxgKJHt
         Q9yRnXtG5CJQD3m3wHVNoQX7447Cu1wkxZB/W9FpGltPcMOYC6UdCAL77RP1Sz6zl211
         g3Rpn5Ip+h7EXmRaEp/kIEsEizXPVrpc4MkkeFrZPsmoEw80dDUJL/f2/Hd9RpxVjzxn
         pn59+pilPhdQRGEGZZfIEFZuOUaGvW7gKT7wbfEo4IBDaBj6DCP4WD7L1n4HutcYuIhp
         JzjrmfhqUuXQW/H+gjjpFdhhhVfxHcWSG9xNqy021pvpl3qZqjMzulY1rVP5ibQ1MXUs
         reiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        fh=btn3Iq1iY53O0jjTPpGOqnA7isBEAtgLPAJPz6f8tK4=;
        b=YHOzwfY/w7mSpmKSa5uzs8IhgAhFu+xAAt8p6e6JtWQz7Hx4Nb6VgEI15sBM5bjuGM
         dVrsPSAntpqj7e7nhPyL3ZNhN+UusF2Y6LVAc5n5Pbh2pK/RtDi+8XH7Hpi8D7iQS8n9
         eHli/wEEehzDWiAeYkbuYYatflZTfPszLvoFYWWRjaGT0LFw2Q2lIQOzVv/0HDwTZNqE
         5LrBu5ipLdf9IOgKm5mKEnVSf625cFh3lZi37MYwdW9SB1DVOF4vc4Wxl4wa3XIAomR1
         Fb7S6RKX6cNWbWMpB4szyRKfGS5b2QgmcgRleL11ieUe75PuZEEuboxPbRPupBoVahM7
         pkWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795218022; x=1795822822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        b=LTsIrEnjM1Z8Scsa2rHSnmi2P0zH2qbuHBDRFUWRw9ZO2ElAGo3z2FrSd7b92HKRDu
         dPKCdW45zD4QsSNXsPAi/rNZxAFc+k2BqoJPuOiteVkxmWFNXKgmVu6nnn+wjkXst1Yt
         EYN9Umf3jHCRB7lQIyasjUjJyshUeEjhPEId0YExsUNEKeEzVLBzwAwO/lox0tiM+oe6
         RT7FSk7LaNdAQ3zVQvN5tYsWNx9wxZzKggIYdMUe8u8wzHA9pf5ve3DKetSeYTp9fZhV
         lpq6eg+iFRZFSGzjmoclOByYKK4SgoeqIArkjPyRbvnYRfV7XYdYCtnseEmdHbE+PZ+i
         6IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795218022; x=1795822822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        b=xsIlig+CnIh4LYxpWiJYTKSHScnPy+sYmOGESsSr10pafVEvIRPltWyzdbqcbZDX5D
         D/yJ2jTJn3mU6tLCMIgnpyGoqgk/zuzXO9fB8JYJ9aBIS67H7PdQyUCpcgEl9Fso8scL
         4fRugTdhU3mVpaftkSQ+ULkhwlWndN6cyrUwEgFbk0PxObjzFkapDpo76+HG9tHRl3bv
         9Cq1ffORx94zZWlU/Uk1M4QR/G8nYi+eZJTqBmSY9qmTX/IrtGXFqce2pf5e6swCxRwY
         7mgOC2HAZV8S9boCdbt4Nsm+zGeArzgvnxT9JbnM1usztma6AvietCi4BIneoD80uxBK
         X91w==
X-Forwarded-Encrypted: i=1; AL+hErGFHHnjqPJ7blb2LD/93b7T1WVGwfqkJML10sxB6X+Enx1NDQO9rjpI2i4w7xCYi527/Utx3oQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HHhKlxYexdtj+zbSFass0YiI+VVzqT7u1VcoCD4XNmLzFV1IJ
	+t+e357CWXXmOqATihhr2vp9rLYsg20gwF2fS9m4lJ9/uTQPmxOfOBQApz2g6ZOLzlobb1UhUnj
	aJY5dPRgbyNN58ufjHa/dHOBWOuKio4I=
X-Gm-Gg: AZFdTZfNPs4ThKG6EImp4gaXq9u2j+gSoQRYMdnfTOfjGWvjeztydxgk5suRzv7tV2j
	btqxkijfPI2x31d+LYXykHc2KeCqMAIjPU/BWy1M5yOFNUPLI0h/Gn1WRbJ13hEvxNykoZPaT9E
	qM96YoYum6Xqt+KZ6J1MUIQYjYwtl4viHN5wvA+jUYKEkZc2WcxQWAReaTYSf0//ICF9QHUsp9f
	ZjRLhYkxSoO+dQKzFfuQ6JsbgzwECtnWWhrBBr1ouZKC/72PCwzQpYdrQka34UeOhxnPMO7xyQ2
	5nNiNH9a+Sxl0GsxkP1dUeWP+8WaE6GrfO2IqCZ4yg0fpXFP6JKny68Vjej6ZE3p9ZKzoIEDr2f
	4pTzel+PA7SKM3UlJC8NoV5QQ5EVPmEeutrk=
X-Received: by 2002:a05:690e:478f:10b0:67d:c046:4f74 with SMTP id
 956f58d0204a3-67df44234b3mr1082543d50.25.1795218022001; Fri, 20 Nov 2026
 15:40:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
In-Reply-To: <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
From: Luciano Lo Giudice <lmlogiudice@gmail.com>
Date: Fri, 20 Nov 2026 20:40:09 -0300
X-Gm-Features: Aa3M54rtJZ9pDNW5zIOi0412D3UCWrKeKTEw-1RlRRJd1NmXScLarnrzrZaMguk
Message-ID: <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	regressions@lists.linux.dev, axboe@kernel.dk, stable@vger.kernel.org, 
	Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bernd,

Yes, I can do that. I'll go ahead and compile ublk_drv from your repo
for the 7.0 backport and see how that goes.

All the best,
Luciano.

On Fri, Nov 20, 2026 at 8:27=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 11/20/26 23:55, Luciano Lo Giudice wrote:
> > From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> > To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> > Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
> >     stable@vger.kernel.org, regressions@lists.linux.dev
> > Subject: [REGRESSION] ublk: dispatched IO intermittently never posts it=
s
> >  fetch completion (v7.0)
> >
> > Hello everyone,
> >
> > I'm writing a library that implements various block devices in userspac=
e by
> > utilizing the ublk framework. Every so often, I'm hitting a completion =
loss on
> > Linux 7.0, in which an inflight request is lost forever, which leads to=
 an
> > unkillable process and a ublk block device that cannot be torn down, an=
d so the
> > machine needs to be rebooted to remedy this. I've tested the attached r=
eproducer
> > on 6.8, but found no hangs after many runs. Details of the bug are belo=
w.
>
> Hi Luciano,
>
> I just scanned the io-uring list and found this by accident. I have been
> working on this for a couple of month.
>
>
> Would you be open to test a specific branch or dkms module? I actually
> wanted to send this to upstream last months already, but then found and
> fixed (with a lot of AI help) more issues and also got busy with other
> tasks.
>
> https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-for-7.3
>
> and here the backports, that also work on 7.0 (with a compat patch) and
> that is used for our dkms module
>
> https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports
>
> The 7.3 patches are actually verified through tla+ and an ublk branch
> for https://github.com/brauner/linux-formal
>
>
> @Ming the patches for 7.3 include heavy ublk state changes (it is now a
> bit closer to what fuse-io-uring does) and also adds debugfs that can be
> used understand state issues.
>
>
> Thanks,
> Bernd
>
>
> >
> > 1. Environment
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kernels tha=
t ship
> >   with Ubuntu. Tested on amd64 and the ublk_drv module.
> > - An identical binary was run on 6.8.0-117-generic but no hangs were re=
produced.
> > - This was run on virtual machines provisioned with LXD and with 4 CPUs=
.
> > - After reading the code, I suspect the issue arises due to the 2025 re=
work (the
> >   list batching first appeared in 6.15 and the per-IO task tracking in =
6.16).
> >   I have not run any kernels between 6.8 and 7.0
> >
> > 2. About the attached reproducer
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - It's a single C file that requires only liburing.
> > - 3 devices are loaded (2 are file-backed, the other memory-backed).
> > - A fourth device is added, started, loaded (briefly), stopped and
> >   deleted in a loop while the others are under loaded. This is the
> >   fastest way I found to reproduce the issue.
> > - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs were
> >   observed after more than 10 runs. When the issue is detected, the
> >   program prints what evidence it can gather (per-device inflight
> >   operation numbers, the running threads' waiting channels and the
> >   io_uring's pending CQE counts).
> > - Bonus: 2 additional bugs where found when shrinking the workload:
> >   A queue was leaking its io_uring (keeping the chardev pinned), and
> >   START_DEV issued for a queued that had died before arming. Both stall=
ed
> >   the program identically on 6.8 and both were fixed in the attached ve=
rsion.
> >
> > 3. What indicates a failure (from userspace's POV)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > - The issue is always connected to a READ request:
> >   /sys/block/ublkb$N/inflight yields "1 0" and is never modified again.
> > - The thread that handles the queue is blocked in io_cqring_wait (as se=
en by
> >   inspecting /proc/$TID/wchan), byt the ring has no entries to consume.
> > - The ublksrv_io_desc for the corresponding tag was written by the kern=
el
> >   at dispatch. The server reads descriptors after a CQE is posted, but
> >   this never happens.
> > - There is no way (AFAIK) to recover the tag. The lost completion is th=
e
> >   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FETCH fo=
r
> >   the tag is rejected (returns -EINVAL).
> > - Something very similar also shows on the control plane, which is why =
I
> >   suspect shared implementation details rather than something queue-spe=
cific.
> > - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post their =
CQE
> >   after the kernel provably completes. In one capture, the deleted bloc=
k
> >   device was already gone from /sys/block when the caller's 30 seconds
> >   time bound fired. Repeated re-enters never produced the completion.
> > - DEL_DEV was seen stalling 30-90 seconds on the kernel for operations =
that
> >   should complete instantly. The io-wq worker thread was blocked in:
> >
> >   ublk_ctrl_del_dev
> >     del_gendisk
> >       blk_mq_freeze_queue_wait
> >
> >   the device was stuck half-deleted, and it reacted to ADD_DEV by retur=
ning
> >   -EEXIST for minutes. In the worst instance it survivied its own serve=
r
> >   exiting and stayed un-deletable (needed a reboot).
> > - A START_DEV completed with -EINTR. The process was detached and arms =
no
> >   signal sources. I didn't capture the pending signal set in that insta=
nce,
> >   so I cannot rule out a spurious signal, but the same op's immediate r=
etry
> >   stalled for a full 30 seconds.
> > - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, eventfd =
wakeups.
> >
> > 4. Aftermath
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - AFter the request is lost, teardown hangs and takes the control plane=
 with
> >   it. Looking at /proc/*/wchan and dmesg of a hanged instance shows tha=
t the
> >   teardown uring command (running in an io-wq worker) is stucj in
> >
> >   ublk_stop_dev/ublk_ctrl_del_dev
> >     del_gendisk
> >       blk_unregister_queue
> >         elevator_set_none
> >           blk_mq_freeze_queue_wait
> >
> >   And the message printed by the kernel is:
> >
> >     INFO: task iou-wrk-2115:2118 blocked for more than 122 seconds.
> >     [...]
> >      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
> >      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> >
> > - Subsequent control command hangs on the control mutex:
> >     task iou-wrk-12720:12721 is blocked on a mutex likely owned by task
> >     iou-wrk-12626:12629.
> >     [...]
> >      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> >
> > - Killing the process doesn't help. The worker thread keeps waiting on =
the
> >   queue and the frozen queue waits for a request whose owner (the serve=
r) is
> >   gone. On 7.0, ublk_timeout(...) only takes action for unprivileged de=
vices by
> >   SIGKILL'ing the server. On privileged processes it retursn BLK_EH_RES=
ET_TIMER
> >   so a lost request is re-armed forever and never aborted, even when th=
e
> >   server is dead.
> >
> > - When the process exits, the io_uring io-wq teardown warns while a wor=
ker is
> >   still stuck and the process remains a zombie. The following message i=
s
> >   printed by the kernel:
> >
> >     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x2e0,
> >     CPU#3: live_server_ram/2115
> >
> > 5. Where I suspect is the problem
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Evidence points at the completion side of the 2025 rework.
> > - per-IO task tracking ( ("ublk: require unique task per io instead of
> >   unique task per queue", Pure Storage, 04/2025,
> >   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5-0-926=
1ad7bff20@purestorage.com/):
> >   our fetches are all submitted by the queue's own thread, so io->task
> >   should always match at dispatch time;
> > - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, task>
> >   requests into one list and queues a single
> >   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for the
> >   whole batch. If that single task work is lost, every request in the
> >   list strands - the observations are consistent with one lost request =
per
> >   occurrence.
> >
> > 6. Follow-ups
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Does this ring any bells in the 7.0 completion rework (lost task work
> >   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch taking
> >   a path that neither completes nor aborts)? Is a fix already in
> >   flight?
> > - Independently of the completion loss: should ublk_timeout() for
> >   privileged daemons fail a request whose ublk server is gone? Today
> >   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_gendisk
> >   freeze and the control mutex - stuck forever after server's death,
> >   which turns a single lost completion into a machine-level hang.
> >
> > I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.0 on a
> > VM, or capture the trace of a missing completion.
> >
> > #regzbot introduced: v6.8..v7.0
> >
> > Best regards,
> > Luciano
>
