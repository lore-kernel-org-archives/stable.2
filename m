Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F4385530
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176280; cv=pass; b=MQErjxeUL9I0kysO5OgTs8OK5k2l69eFZ4s3FiD+xG/jOkP+jCXNWL58I2RzGgVoZwv3JiK7RWAKpHGioq4PzyGASBA9wjM4hrdJFmWXfM4w6kObhO2v8853GODsdtk8lwkekNlILTHEU0UU3HdJYvQec3tXDvMUjMPcgv2t7Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176280; c=relaxed/simple;
	bh=mbOks8dakFnJZYRoZbJRZ3KGdvDDUJrls5lhq4ysFsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsx7DTQ8iwuOPjW0IVO+75KzXzebK8pNKNIUlFi1N/vquEnYc/pmTFs3EeXbp7cX13JDIn27BfznVg6+J5CD2fnh9Nmh4xoDEOTVKF1pIW0qY9h51exUzsS9knm3b+vhMPAKffSiTiZcgZ6Ds7rD/i8vNpR1bXcdnHwazMloh9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guxqGD3P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxFHnhcS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guxqGD3P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxFHnhcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782176278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSSXFctdwk5wQgLEhuA9tc5E82KOuJqVd5ooTEyEcgs=;
	b=guxqGD3PuOckb/Qa7nz1zH01l5vdDk/qEvinf+wkqV+9SP8SZxHa3agqq0g9oqV5EJLThy
	basax4SAQymAqwNqlnQqkBCI7QiE4xhnptcUmtvy0IExB8yydCpUQXtYkUPdVciNT9SB8W
	mE/l26PK+F8iT/8bF/h74cT3xHJSxLM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-6PPjM61aO16O1GlHB9ORnA-1; Mon, 22 Jun 2026 20:57:57 -0400
X-MC-Unique: 6PPjM61aO16O1GlHB9ORnA-1
X-Mimecast-MFC-AGG-ID: 6PPjM61aO16O1GlHB9ORnA_1782176276
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-48e77e6a63bso1008082b6e.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782176276; cv=none;
        d=google.com; s=arc-20260327;
        b=WQJR/m1v1HNbSCvbxVnBQQ/6zohamD9/CcPXhDKx9doFqiYBs3D1veXB2NNHFlVDEi
         TAALZkWrOsIpO/CP0Y4Oxpuk7eOz8/RhWm1MhCJ+SELqGOYfVB3R4km98HPz0diEItAI
         bFOhguEBSsgkbrbQP2RdwdXsZnyVvXy0tyU9ni3BqMvT8jlSsEcreXG9JUqpIrkynMVk
         NI+KRvaJzOfGaZCbtrXY1K6XOlOl9UA0R9MYqJibDC0kr3Du66QYjcgq7A/W+/kiZmIc
         4k3Zc9WLtUeIE7exhZBmDNF4g9DRELq8l+cdvhd8g7Vuhx8GNBZHJYYu/OfZkDtsVDm4
         woig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSSXFctdwk5wQgLEhuA9tc5E82KOuJqVd5ooTEyEcgs=;
        fh=+EUlxhBLnHrQtqOa8bc5eSXObjsBXKn9cKLHkCwq4II=;
        b=P6JLZxm6tLS7biHJWxtVKBCvX3VAbdSak+WgdUHgP32jxkY7GXoCO77CsJh1YqLT7s
         v/4v1FNvJb4f39k22NtHYUxgI+0XQPCs4PKzT2PNrsW9ldTOJssqr2PHMyemw6tTHlEN
         VoL/t7obn1bNZ3sGOP5bo9tIxeFnLN+O/sOSYLwq3eDBBAcEmQTL8QwIUh0DkE1GAaUb
         eNx9oYU+8/QIcIYJgyeSE32KapT7evbgQcS1mB4sMGS0USpZAVKxrnJIxoKxQLn1gEqF
         aFA9gAbjFlSJXcFLpt3WMrkrF4z2dPbPrFcnTNmt0/yPRZxcm2JH3JPgkt91xA6GpiN8
         zo6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782176276; x=1782781076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSSXFctdwk5wQgLEhuA9tc5E82KOuJqVd5ooTEyEcgs=;
        b=HxFHnhcSAEFmzu9CKqlwwNK10lOsWR+1rJ0CohTOcUrQZMIfh2VqMDi6kAfAH3vAMV
         WF/cv3tzrieUWqanbvF2b2/pCS+ZTxuz+eo/nvFdbPB6ipKR56HnhZ9t7SrMsQnAhjGw
         880WLnfgB2Jx88e1zpdIBuXmEriaEe+i/TWkaetAfPuw2pS69/fJAIdAhDpLb3K8ACaB
         ahEbRR0pBWH3dblddInHdQZ6lim8ZGrHpsAoEcDxPIH/gaN4eTG14uUbdy0ks3triZuJ
         JO6UHuX5NofaJlq6fPdMLfOs7oFKycrSTKK7qzwZY6ZrqHSz7swUTL0g6LTBt262C8EN
         aCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782176276; x=1782781076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSSXFctdwk5wQgLEhuA9tc5E82KOuJqVd5ooTEyEcgs=;
        b=fwlx+dzsDmggoLwR1nL0z3caehU980rnZL9BXtpITgHwo1Cgs2+8TeoZePX4syQ+ny
         P+GjRIlYdjeSWijBbZzQAMhdXuL/Vhm936CNDsBnPiSRqvUebgqc8gz8t1GItgwBAoV1
         W0Gp3uMXjVcRfrukIjkvm5+BTYC4+77Kq6qQ4yQue3R0e96b0mFdzxGd0jxhAG2hNEyv
         NH+otqNqSUWcOMMhV1LmSw4QtrxBM+13kzPCpLTGAZKuvPs+uXLa0sEfy4s+QN92reaF
         2zVqe6oUq0rV5t7ciQ8lcdVVZKTT9oJwhIWb0oLGOeAI6V9dB+bUbKaLMQ3fGBavy/LO
         uZhA==
X-Forwarded-Encrypted: i=1; AFNElJ9Yb0v/0KyXfVFdot289Eioa+DzOsnpfPkqI6jyFuCYVSFTZUjN6LjDZTN/+kbkuQKuG8bS13o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AlTLndGHrlFDZszbZvCgqHe2RQDQfX6yP94ET9+9UaXnuB2L
	w/Eg3KZoZuuFB4ugDUiCBaq7zpr+DEraCETZwWgzJaXvAzzC8rHFqMHhvrP3qpCaGNDW/Fc27B1
	fmMGb/SnUVPjy2DWYSm9B2NFAf/XLzglUZdYqHYNUjLAFLVVeB+nEwjy9HVeXacw3Ux0L5wf1Bh
	DAkpJFLmSk0XvHyMMT+vosUUvU2YNhtx87
X-Gm-Gg: AfdE7cl2RWCHUZW8sZeIlzb2Fguej1JF5N4jNP13VSU9mE7vwejfnd4k0AVqRHQibEU
	t9G8p6UW5iijkrEii1ZyuKFKGhcSpWUWb0+Ipt9ECwzQI3H+tH5eQml8gWB4r0MHrPuErj+z1Dq
	Pwz0mhSBKV0YLkSQZW1BftLfX1OyF+WUZImcHfToYHX6HzxCBKtT2DtK7ocq+JAgiDiqKNiZp2B
	lpshbg8z0v3FV5OY+ss38mMnN5g
X-Received: by 2002:a05:6808:c2bf:b0:485:43af:5de0 with SMTP id 5614622812f47-48ee45926a3mr1207594b6e.22.1782176276047;
        Mon, 22 Jun 2026 17:57:56 -0700 (PDT)
X-Received: by 2002:a05:6808:c2bf:b0:485:43af:5de0 with SMTP id
 5614622812f47-48ee45926a3mr1207577b6e.22.1782176275539; Mon, 22 Jun 2026
 17:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622133540.48591-1-desnesn@redhat.com>
In-Reply-To: <20260622133540.48591-1-desnesn@redhat.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 22 Jun 2026 21:57:43 -0300
X-Gm-Features: AVVi8CeFAnys4Rq2_V3Ekn_NohqHVEXDUFxY_VuMb9eRaWtolFZM2wXvZJ1Ohxw
Message-ID: <CACaw+ewAhmPYxnQgpzh-zL823YEuyZGDukwAzeDUOvRU9RrWcA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying root entries
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello IOMMU mailing list,

On Mon, Jun 22, 2026 at 10:37=E2=80=AFAM Desnes Nunes <desnesn@redhat.com> =
wrote:
> When translation is already enabled at boot (e.g. kdump), the vt-d driver
> copies context tables from the previous kernel's root table. In scalable
> mode, buses that only populate the upper root half (UCTP, devfn >=3D 0x80=
)
> should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
> However, the current copy path always uses tbl[tbl_idx + 0] in this situa=
-
> tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
> LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co=
-
> pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after=
-
> wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
>
> As consequence, devices on bus 0x80 with devfn >=3D 0x80 fail DMA with
> fault 0x39, which breaks drivers running in kernels with translation
> pre-enabled. This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>
> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000=
 [fault reason 0x39] SM: Present bit in Root Entry is clear

FYI, this bug can block a system from rebooting after collecting a
kdump, with a stack trace similar to:

[   72.987601] systemd-udevd[246]: usb3: Worker [255] processing
SEQNUM=3D2193 is taking a long time
[  132.237566] dracut-initqueue[277]: Timed out while waiting for udev
queue to empty.
[  202.988014] systemd-udevd[246]: usb3: Worker [255] processing
SEQNUM=3D2193 killed
[  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by
signal 9 (KILL).
...
[  206.288378] kdump[569]: saving vmcore complete
...
[  206.821258] systemd-shutdown[1]: Rebooting.
[  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 seconds.
[  246.865319]       Not tainted 7.0.0-clean #1
[  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11
   ppid:2      task_flags:0x4208160 flags:0x00080000
[  246.888942] Workqueue: usb_hub_wq hub_event
[  246.893202] Call Trace:
[  246.895690]  <TASK>
[  246.897828]  __schedule+0x299/0x5c0
[  246.901378]  schedule+0x27/0x80
[  246.904572]  schedule_timeout+0xbd/0x100
[  246.908565]  __wait_for_common+0x97/0x1b0
[  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
[  246.917252]  xhci_alloc_dev+0x9e/0x2b0
[  246.921068]  usb_alloc_dev+0x7a/0x3b0
[  246.924795]  hub_port_connect+0x285/0x960
[  246.928873]  hub_port_connect_change+0x94/0x290
[  246.933482]  port_event+0x4bb/0x840
[  246.937030]  hub_event+0x141/0x460
[  246.940489]  process_one_work+0x196/0x390
[  246.944569]  worker_thread+0x1af/0x320
[  246.948383]  ? __pfx_worker_thread+0x10/0x10
[  246.952724]  kthread+0xe3/0x120
[  246.955921]  ? __pfx_kthread+0x10/0x10
[  246.959736]  ret_from_fork+0x199/0x260
[  246.963550]  ? __pfx_kthread+0x10/0x10
[  246.967362]  ret_from_fork_asm+0x1a/0x30
[  246.971355]  </TASK>
[  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 secon=
ds.
[  369.745593]       Not tainted 7.0.0-clean #1
[  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1
  ppid:0      task_flags:0x400100 flags:0x00080000
[  369.769128] Call Trace:
[  369.771616]  <TASK>
[  369.773752]  __schedule+0x299/0x5c0
[  369.777299]  schedule+0x27/0x80
[  369.780493]  schedule_preempt_disabled+0x15/0x30
[  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
[  369.789974]  device_shutdown+0xac/0x1b0
[  369.793877]  kernel_restart+0x3a/0x70
[  369.797603]  __do_sys_reboot+0x147/0x240
[  369.801595]  do_syscall_64+0x11b/0x6a0
[  369.805407]  ? handle_mm_fault+0x110/0x350
[  369.809574]  ? do_user_addr_fault+0x206/0x680
[  369.814006]  ? irqentry_exit+0x7a/0x4d0
[  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.823046] RIP: 0033:0x7fe2958da917
[  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX:
00000000000000a9
[  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2958=
da917
[  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000fff=
fffff
[  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 00000000000=
00000
[  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 00000000000=
00000
[  369.870659]  </TASK>
[  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex
likely owned by task kworker/0:1:11.

A summary of the debugging and logic for the fix can be found in the
following RFC message, which came from the USB mailing list:
https://lore.kernel.org/linux-iommu/CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXa=
Fbd=3DySXf8E5A@mail.gmail.com/T/#mf184c20cff4dcf491deb106b6d65b80dcb58368d

Best Regards,

Desnes Nunes

