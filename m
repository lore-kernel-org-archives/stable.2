Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC83F12ED
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289610; cv=pass; b=bOc/7qInp1N+77l9NkTzmw1LD4Kg8rn0WiuGO1/GcTpO0aGvdZWnd9TsX6vwhcS+f+BryL+XjoAYXYEZc8BlB1E6GpFsQfANay6+rPFxn/oiBFyXtzCMC1PyY7lR+SQAwebX67soHtRaV81Z8uKPBkVemYXlCOlarcDk6WNx7dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289610; c=relaxed/simple;
	bh=k1XNn44v3qsaD0EI0G0pfPOXJSQRZQe0hXtKXACW6ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUDnIYYdURWLwJvvjyTNETWxzKSi6yxO3waWtZthCN0xVVXMqQYtdXae9Dhww7JPKtcxOSIA/vYtANJWw3CY4Fe3hcI10jgvSq58LTU3DvoOqwkXEJ2FWKv4yaYTdXbo3oduTcHsOenegc8U23AJxmtvr7uwgiknt/Fo63dhfyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhWQQWIs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2TXRwv+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhWQQWIs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2TXRwv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784289605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
	b=fhWQQWIsHLoofychuas8jvJLJyV6Cz2a/YW7Mjj0Nxos1RR/WGSgdowjInkNXsrhoXDM+X
	50dImX15TAlRNLdI/IQ+VpcbnO0or0i5xE1Pm5gu9hC2bGEYCUmOBBaWcjpGjh5yUlxnjX
	3PrNoQHFJlA+JTC5KZqdzsmfblRYewA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-8l6rlGBNP_iWnGRTf_YX9w-1; Fri, 17 Jul 2026 08:00:04 -0400
X-MC-Unique: 8l6rlGBNP_iWnGRTf_YX9w-1
X-Mimecast-MFC-AGG-ID: 8l6rlGBNP_iWnGRTf_YX9w_1784289603
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-451d80641efso8071132fac.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 05:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784289603; cv=none;
        d=google.com; s=arc-20260327;
        b=LVJrKxWV03q1J7rHXXIFV/SlYSvXxclBjWMtUHoog3DS2N9tKIcr7l4OW1qDyWMkFA
         dYsZvNHIkz1cbc9OvftVhqYpf5fsZWSvwGI4AXDGJPreoZ/7nN5qxSMq1QgvW7i5LxAn
         52hFCrCIrmbbLNV4dYEG3Kf6YesZdooDiHhvVJHsAU5InqWlugTN7eIW+vggIO95GAeq
         ZpsGv9kzEst4ERfBIKONsyifCN2IGnlZnbHE9TiY72h7tnSWzzyWyvI1mmXq1eWuD8Mh
         SnpcBRWRuRHVPrM0/5MASEEfD7N3E42XWdTiKzHh5MzTtllsO8Y/5UPk8E+JW1GvY84H
         vBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
        fh=G2HNrvwD6CF1SL+ZvwtMlTeqplrfBDE/wKSPvRn1a6o=;
        b=nybYhJvHLavIgnDT4zYMeqiioUWJtYtd5IGNoBvHdTYKkBRfrk1S6uqKpO0c2bg/S3
         kQsShdAOm18psVaFNfn0ySQP35HnPKo1tm6XzZzBCBTCNQr/NUK/4AaVN0S+Xady4ouZ
         dCxcHMLMlvqGEYZ5YwivFNuYHU8Due2ICK8+fanmz7VE1j3BN2t6sCU2FroKqU8yoX5/
         wWwEaR0Gr/xKAMc7hKNvwZe2iLDLFgLTi0uv//EQfcj4bJnOC8d8iINYAlLv+TDJ/oVT
         iTbN5P46ZIkti0OjHF5lyVOpnQGeAkGEP2ulZzBP0dc/ePv3hzLIQWI//jLvkvrENa6c
         MCUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784289603; x=1784894403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
        b=E2TXRwv+HYcSH/ojJ7lS2JmOixkMT8bTxTTqAyPOUf46fVXLLUCG63IOp3I4BcHtlQ
         lnbVgNTJLMQdkYyAuzRFw5YZZl0UHk2Wn3tjH7eesWi6vpWS6l65N4JW4wS8b3ADKO+z
         NqYCwTJiN4+Zv3Mu9Wz/RULHrX2l2jmdI0JMJlyZIQE9B4iE1Wq57RwAzcPCdW/OR7hC
         LA8oU6grGwiccRLqb13Nt1/n2AEmX35CLHFRrevSxAgi+2Dk+dU8fHrWWNlB9dpkrnTq
         YluelUOYE0EalTw9bKH/veSpw/v3iD2TO120C5NPIVhQnezxJHoBIodUcy8vuCkoVHQv
         Cipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289603; x=1784894403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
        b=eO45Sz8kOxL4K7xTlOO4E/GYb8p6dLdKbdXZofnMQe+/gJVJjUloJjHh6LpwChpiv3
         GlTmBG4M7b09fWHYqMcqrs4k8IY+L9zIyUNMNKnQIwFQ56gpTHWOizZq8TweMSR+HsSo
         nI9Tk3hisGyoxHMQ3wLYaOvzYxo8A+q3xqzhxAtAWbx+KNSjEdScbaS7czzB6Q8lCwyW
         OcOjy6m07a0BFsdeYJiTeS0Gge4chSbtou1KHlpC/qPfBybkDwx6Aoqjdd7vP62/557b
         +OUdqh+gRaPfqxCeAnx71JZ7GjrgczycfaepVwc8D1lgvSuSY5l09dXGgnHImUvv6/zs
         R60w==
X-Forwarded-Encrypted: i=1; AHgh+RqaW0VQIbv/C9tihzuYkfc5dDk1yz0tMgWfur+xNFDgfcNKtDemM2r/S1WI1WH0/H5GTUvMTXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdDAbBU6ebTQRXXRin3UqkFNuEH88/wmdMQKdpLGvUkbSUY/p
	7+L9LUeRG4Ywzryg/Gj1kHfzp9op7gF5+DfFIRs8GKzEVTNUXxm0dUG0IJP2AYdGscztXQDJWgC
	dizvum1s7DSdgfchUfdMe0ahhN50kq3lwf6isIJF67cOGRfDNilZBtZJxwYWc4f8LjMIzZdoUV0
	65dQjr8uMqXjVbUv1ZgGlR98oXwakKkG6n
X-Gm-Gg: AfdE7cl5Ej+qzcKcesS8otkWS5dTmkTZtTV7H3t/pLpNavK5hSe3eacOPndwxPqc6e/
	p3UueN8qIoz8XKmbvPwxBANzSg6cuUjg/THCob5N3vipblgoFubJ66A7dQTu7w/5Z62ufB3Uv5/
	zfYiSNndGpekvhbQ7zxg5kCNg10S7GX0CFMH6WDlzZzn7vfvEzzRvTv7vMb4FHrv3P6QxE0TlrG
	cNZftYKfvIO3oWx5g==
X-Received: by 2002:a05:6808:6902:b0:496:1009:ec5a with SMTP id 5614622812f47-4a4d0160614mr1146334b6e.1.1784289603038;
        Fri, 17 Jul 2026 05:00:03 -0700 (PDT)
X-Received: by 2002:a05:6808:6902:b0:496:1009:ec5a with SMTP id
 5614622812f47-4a4d0160614mr1146300b6e.1.1784289602009; Fri, 17 Jul 2026
 05:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629144837.3244851-1-desnesn@redhat.com>
In-Reply-To: <20260629144837.3244851-1-desnesn@redhat.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 17 Jul 2026 08:59:49 -0300
X-Gm-Features: AUfX_mzpKeLRkWyX5IJziXQww7lPcrKAFEzEkmYK5hcKf6-cJXL-hIHQkRlAgFA
Message-ID: <CACaw+eyE+Rk3NeGaWmo=Psw+aDNp4=Ggzj3DnrkL-fp04NZc+g@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Baolu,

Can I further assist with any more requests or answering any remaining
questions since the v1 review?

Best regards,

Desnes

On Mon, Jun 29, 2026 at 11:49=E2=80=AFAM Desnes Nunes <desnesn@redhat.com> =
wrote:
>
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
> In short, devices on bus 0x80 with devfn >=3D 0x80 fail DMA with fault 0x=
39,
> which will break drivers running in kernels with translation pre-enabled.
> This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>
> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000=
 [fault reason 0x39] SM: Present bit in Root Entry is clear
>
> For instance, this fault yielded to locking issues between systemd and
> xHCI, blocking a system's reboot after a vmcore was captured with kdump:
>
> [   72.987601] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=
=3D2193 is taking a long time
> [  132.237566] dracut-initqueue[277]: Timed out while waiting for udev qu=
eue to empty.
> [  202.988014] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=
=3D2193 killed
> [  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by signa=
l 9 (KILL).
> ...
> [  206.288378] kdump[569]: saving vmcore complete
> ...
> [  206.821258] systemd-shutdown[1]: Rebooting.
> [  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 second=
s.
> [  246.865319]       Not tainted 7.0.0-clean #1
> [  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11   =
 ppid:2      task_flags:0x4208160 flags:0x00080000
> [  246.888942] Workqueue: usb_hub_wq hub_event
> [  246.893202] Call Trace:
> [  246.895690]  <TASK>
> [  246.897828]  __schedule+0x299/0x5c0
> [  246.901378]  schedule+0x27/0x80
> [  246.904572]  schedule_timeout+0xbd/0x100
> [  246.908565]  __wait_for_common+0x97/0x1b0
> [  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
> [  246.917252]  xhci_alloc_dev+0x9e/0x2b0
> [  246.921068]  usb_alloc_dev+0x7a/0x3b0
> [  246.924795]  hub_port_connect+0x285/0x960
> [  246.928873]  hub_port_connect_change+0x94/0x290
> [  246.933482]  port_event+0x4bb/0x840
> [  246.937030]  hub_event+0x141/0x460
> [  246.940489]  process_one_work+0x196/0x390
> [  246.944569]  worker_thread+0x1af/0x320
> [  246.948383]  ? __pfx_worker_thread+0x10/0x10
> [  246.952724]  kthread+0xe3/0x120
> [  246.955921]  ? __pfx_kthread+0x10/0x10
> [  246.959736]  ret_from_fork+0x199/0x260
> [  246.963550]  ? __pfx_kthread+0x10/0x10
> [  246.967362]  ret_from_fork_asm+0x1a/0x30
> [  246.971355]  </TASK>
> [  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 sec=
onds.
> [  369.745593]       Not tainted 7.0.0-clean #1
> [  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1   pp=
id:0      task_flags:0x400100 flags:0x00080000
> [  369.769128] Call Trace:
> [  369.771616]  <TASK>
> [  369.773752]  __schedule+0x299/0x5c0
> [  369.777299]  schedule+0x27/0x80
> [  369.780493]  schedule_preempt_disabled+0x15/0x30
> [  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
> [  369.789974]  device_shutdown+0xac/0x1b0
> [  369.793877]  kernel_restart+0x3a/0x70
> [  369.797603]  __do_sys_reboot+0x147/0x240
> [  369.801595]  do_syscall_64+0x11b/0x6a0
> [  369.805407]  ? handle_mm_fault+0x110/0x350
> [  369.809574]  ? do_user_addr_fault+0x206/0x680
> [  369.814006]  ? irqentry_exit+0x7a/0x4d0
> [  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  369.823046] RIP: 0033:0x7fe2958da917
> [  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000a9
> [  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe29=
58da917
> [  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000f=
fffffff
> [  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 000000000=
0000000
> [  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 000000000=
0000000
> [  369.870659]  </TASK>
> [  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex likely =
owned by task kworker/0:1:11.
>
> Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel=
")
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
> V1 -> V2: Updated commit message and added xHCI stack trace as requested
>
> v1: https://lore.kernel.org/linux-iommu/ajnlKDglN6wEBBrS@google.com/T/#t
>
>  drivers/iommu/intel/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..737936f942a0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                               struct context_entry **tbl,
>                               int bus, bool ext)
>  {
> -       int tbl_idx, pos =3D 0, idx, devfn, ret =3D 0, did;
> +       int tbl_idx, tbl_slot =3D 0, idx, devfn, ret =3D 0, did;
>         struct context_entry *new_ce =3D NULL, ce;
>         struct context_entry *old_ce =3D NULL;
>         struct root_entry re;
> @@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *=
iommu,
>                 if (idx =3D=3D 0) {
>                         /* First save what we may have and clean up */
>                         if (new_ce) {
> -                               tbl[tbl_idx] =3D new_ce;
> +                               tbl[tbl_idx + tbl_slot] =3D new_ce;
>                                 __iommu_flush_cache(iommu, new_ce,
>                                                     VTD_PAGE_SIZE);
> -                               pos =3D 1;
>                         }
>
>                         if (old_ce)
> @@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                                 }
>                         }
>
> +                       /* Track if saving UCTP or LCTP entries in scalab=
le mode */
> +                       tbl_slot =3D ext && devfn >=3D 0x80 ? 1 : 0;
> +
>                         ret =3D -ENOMEM;
>                         old_ce =3D memremap(old_ce_phys, PAGE_SIZE,
>                                         MEMREMAP_WB);
> @@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                 new_ce[idx] =3D ce;
>         }
>
> -       tbl[tbl_idx + pos] =3D new_ce;
> +       tbl[tbl_idx + tbl_slot] =3D new_ce;
>
>         __iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>
> --
> 2.54.0
>

