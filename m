Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DE36A35E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209286; cv=pass; b=ALrGsPtcW3wWM2np++3XLDixUvrz4usHwtXkfcXA++Ag1buDBGiEoyhOQdTJto0TsxXCSr9ur9qsTPTGAFall/32r0ZMIGpbGYJsWpQtaAZnxMG3e86TdKy1BUxnyRhltkVj2jBi+HppTE2usZ1o/Fyu7Ysy4hHrjFOa9b3lZ1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209286; c=relaxed/simple;
	bh=EepGMJPmx2sUPUYENAOYnYwb7PS2xaiv2Phkk0I971A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmNojfZ6AurZ0M45q/XHeNVy08Xld+XK7EzZplRqtkVfvQjh0ePWHKsNmfjgEig3xyX5tqE7xNGV+jvfrKqd4yTW7n0kV/FBceJ/u1rV/KdCyvgKXHaabkS1m1GExLtnYNYlQLpiTVinrgrLp/w47tD5rCGvGNR+e0Yq52Ep2C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qs5zNfQa; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qs5zNfQa"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so2365049b3a.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784209282; cv=none;
        d=google.com; s=arc-20260327;
        b=PK185bCFHDhpDcybwqyYYEUw/D5z/VeomX7Ygqt8ILLObARo1zqL2SnAKYtjQ511aI
         rRhC1CH0UpDoVj+944OhwAt/ofHrpWSYQ7WRJnmGZVr4IA9/4R0ODzKJjH2FORxojgqB
         SjXeacUw3TuAM6YA/3jDWWTYaauLqf8IJQvDgq6tIJ37AH/uGlsEEbLqgwOrb+JKqEPO
         29OjhZIa4f1HSZTJYEUVCMMq8kZJP8CLnZRB3bwVFI77aJD3ZCgz9ugRKWh7vVT34SsX
         +Xupytd3IOQ5Y2PVyilwUnK026pza/3xai1ZS2Zs9+zf7PibR4MMf0a3K14B9U42SoMz
         ICcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UO+1Ub2gEDTvSkINUm04pmTYANpmfVUv5kODIL+G7n4=;
        fh=2fb60+7ZvnazIDc+Yi47mAhiLd6Zy4Q+ECsYizsEpkc=;
        b=HYbJPR4eIZaMVP0IptbEyl2T5rnnoW6MFXaQ2Qaf7Z3bVPwlcLRSVmQKNeXp6gFEvy
         ybIs/70AYBu+wqAVOTcJloObsw02mFCR8TCR9oJGF9Jww0MoBmmhg4fDyUdFyj5mviDK
         J2QNOuTBVbMLtZYrsKLE6xjrn1CEhS2cLQsQe9gfL4wL51+CNDA6o5FSuN81eIEfJdEM
         2AeXlUPeEFmfwEjKZeIG+mXXnKOj8MsRQLw08ww+8bemopDsaUjmkgtBAYWpEV/x0l+i
         wthQKI1zIKDL5nAftfgz7UJ7Kn4pZykfD0Md7tHMmAnOQKBnWvcFM2T1er3MBn/QYD7h
         OOJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784209282; x=1784814082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UO+1Ub2gEDTvSkINUm04pmTYANpmfVUv5kODIL+G7n4=;
        b=Qs5zNfQa/aJdjKM2vl83FcFMCOG3Mnlr8RRhmRWVdfnl7C59V4RrKbVrmp3r2kgQFd
         VaDdbYAQL4rfuc2u1X4eNrgJj5D81Zyh6hPUS0ClL7sBEhqWVQKubod8fAk37BgCxiRr
         lWJlueNZq/MLsGoWEut2VG/t2BbV2ABjvMTAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209282; x=1784814082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UO+1Ub2gEDTvSkINUm04pmTYANpmfVUv5kODIL+G7n4=;
        b=VXapU2BVMnB0BLs51TIj+cZ8MdIVaI3WJ/fkWo2/LI2E/ojS27xn12vmJTDBFwa2oP
         E5FGH22IpJdKKeFP/WfULdpnRQukZJN+du4n3lGT1G09SnzeAzC1B8z65eMCsbhRIAyy
         aLNGaXNXtdejlrm0D5f0SJmyugqkjbTTejQuOhGpSzM1sZqt4cW9ue/g98RaLP6VQupd
         adflQDcIuN61tcrI3OCPOeL7M3O7qo1Q//Zza6r2avfocVmoUMGr5uSi+panqZXVf4t1
         BWq1eTIilgULiKF8wBVL5PonoVQbDI4ddctLwYQZ+8MRbUb90CSxvlJN0228zoTo7lmn
         3LJA==
X-Forwarded-Encrypted: i=1; AHgh+RrG0Old7dl8cBWph2+Nv7t2hLTgLirt86VIK/WG1TYG38Sy+OiIVR3Amzab7vYe+C2kBD5Pxbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFIH24Bl2Vxfv9JdnsiFZH2nUV7jZgdl7FnIu0whDvXZIBKCj
	kgeP+Jyizadyts3IKrubh44UvTiX6E2AnEvpiM1/oXyLWX1G2jbJNuhorob4JnODYNapqZBP81o
	f+q0miV6syCFLAPKexpkp3MnrUnqxbZWzI9ODiM4x
X-Gm-Gg: AfdE7cnRQUpzswY4BecayChwQuytw1AEuKu4yjaLVBkuzmcyHEvO8s40ZDOmahckeaD
	4qm3RrLPq08+FrC0fYzb+dHVvtLleIjjgsLtddvLx8issmfNHe9Jn8dKQHKtAjKHtLbCNOg/9Dx
	OocSOkI8gHS/Rc1YCetVTQbFzv+UC3XkDEljlTjMW57jSTf+vKFSGNje4Sn/bj6yhYFFmgNObSK
	5ZQ886fXyZH2NzDWy/Fe305fyiOSrteptlRClRpIDA2cmFci0fMJMRs+iHUDmqSZK2MsxNO7AUl
	niKlfieQYClvPQGD0husLZbpqeM=
X-Received: by 2002:a05:6a00:2d9e:b0:848:2e53:3f63 with SMTP id
 d2e1a72fcca58-84889711f4bmr19471625b3a.21.1784209282437; Thu, 16 Jul 2026
 06:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707141736.1635698-1-akuchynski@chromium.org>
 <22064276-6c56-411a-9f20-6917ceeb865f@intel.com> <CAMMMRMduSMniMrixGuq=m=00nUvzXQpySE86TpmvfNQtAChB=w@mail.gmail.com>
 <868cab1f-f581-4a01-a9ea-b2fa1a7a2831@intel.com>
In-Reply-To: <868cab1f-f581-4a01-a9ea-b2fa1a7a2831@intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 16 Jul 2026 15:41:11 +0200
X-Gm-Features: AUfX_mz_IwM2nglp571SeZXVZm3Hv4_jxpWy24QKgJoVDr4KCF4EjNbeACVpK-U
Message-ID: <CAMMMRMdZciCCmfOv0_PhX_VfPtXdMEwNe-CXOLWRSmFYBAEL7Q@mail.gmail.com>
Subject: Re: REGRESSION: [PATCH] usb: typec: ucsi: Fix race condition and
 ordering in port unregistration
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jameson Thies <jthies@google.com>, 
	Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Pooja Katiyar <pooja.katiyar@intel.com>, 
	Johan Hovold <johan@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, Linyu Yuan <quic_linyyuan@quicinc.com>, 
	Jack Pham <quic_jackp@quicinc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:23=E2=80=AFPM Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
>
>
> On 7/16/2026 2:45 PM, Andrei Kuchynski wrote:
> > On Thu, Jul 16, 2026 at 10:28=E2=80=AFAM Borah, Chaitanya Kumar
> > <chaitanya.kumar.borah@intel.com> wrote:
> >>
> >> Hello Andrei,
> >>
> >> On 7/7/2026 7:47 PM, Andrei Kuchynski wrote:
> >>> A synchronization issue exists during port unregistration where pendi=
ng
> >>> partner work items can race against workqueue destruction, leading to
> >>> use-after-free conditions:
> >>>
> >>>     cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init fail=
ed
> >>>     BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>>     RIP: 0010:__queue_work+0x83/0x4a0
> >>>     Call Trace:
> >>>       <IRQ>
> >>>       __cfi_delayed_work_timer_fn+0x10/0x10
> >>>       run_timer_softirq+0x3b6/0xbd0
> >>>       sched_clock_cpu+0xc/0x110
> >>>       irq_exit_rcu+0x18d/0x330
> >>>       fred_sysvec_apic_timer_interrupt+0x5e/0x80
> >>>
> >>> Fix this by ensuring strict ordering and proper serialization during
> >>> teardown:
> >>>
> >>> 1. Move ucsi_unregister_partner() to the beginning of the teardown
> >>> sequence and protect it under the connector mutex lock.
> >>> 2. Ensure all pending partner tasks are explicitly flushed and finish=
ed
> >>> before the workqueue is destroyed.
> >>> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
> >>> queue_delayed_work() sequence. This guarantees that items currently m=
arked
> >>> as pending won't be scheduled an additional time, preventing a double
> >>> release of resources which leads to the following crash:
> >>>
> >>>     Oops: general protection fault, probably for non-canonical addres=
s
> >>>       0xdead000000000122: 0000 [#1] SMP NOPTI
> >>>     Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
> >>>     RIP: 0010:ucsi_poll_worker+0x65/0x1e0
> >>>     Call Trace:
> >>>     <TASK>
> >>>       process_scheduled_works+0x218/0x6d0
> >>>       worker_thread+0x188/0x3f0
> >>>       __cfi_worker_thread+0x10/0x10
> >>>       kthread+0x226/0x2a0
> >>>
> >>> To ensure these rules are applied identically across both the normal
> >>> teardown and the ucsi_init() error paths, consolidate the cleanup log=
ic
> >>> into a new helper, ucsi_unregister_port().
> >>
> >>
> >> This seems to be causing regression in our linux-next CI. [1]
> >>
> >> <6>[   18.008557] ------------[ cut here ]------------
> >> <4>[   18.013166] DEBUG_LOCKS_WARN_ON(1)
> >> <4>[   18.013167] WARNING: kernel/locking/lockdep.c:238 at
> >> __lock_acquire+0xa59/0x2750, CPU#1: kworker/u89:1/172
> >> ...
> >> <4>[   18.159950] Hardware name: Intel Corporation Meteor Lake Client
> >> Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS
> >> MTLPFWI1.R00.3471.D89.2401091901 01/09/2024
> >> <4>[   18.173125] Workqueue: events_dfl_long ucsi_init_work [typec_ucs=
i]
> >> <4>[   18.179257] RIP: 0010:__lock_acquire+0xa60/0x2750
> >> <4>[   18.183927] Code: 44 8b 5d a8 85 c0 0f 84 98 fd ff ff 44 8b 35 0=
7
> >> 0b 72 02 45 85 f6 0f 85 88 fd ff ff 48 8d 3d 27 25 73 02 48 c7 c6 1b 5=
1
> >> 27 83 <67> 48 0f b9 3a 31 c0 44 8b 5d a8 44 8b 4d b0 e9 c6 f7 ff ff 31=
 d2
> >> ...
> >> <4>[   18.263886] PKRU: 55555554
> >> <4>[   18.266583] Call Trace:
> >> <4>[   18.269014]  <TASK>
> >> <4>[   18.271110]  ? mark_held_locks+0x46/0x90
> >> <4>[   18.275007]  lock_acquire+0xd9/0x2e0
> >> <4>[   18.278562]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> >> <4>[   18.284096]  __mutex_lock+0xb2/0x1020
> >> <4>[   18.287735]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> >> <4>[   18.293265]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> >> <4>[   18.298797]  ? synchronize_rcu_expedited+0x2b2/0x300
> >> <4>[   18.303724]  ? __pfx_autoremove_wake_function+0x10/0x10
> >> <4>[   18.308912]  mutex_lock_nested+0x1b/0x30
> >> <4>[   18.312806]  ? mutex_lock_nested+0x1b/0x30
> >> <4>[   18.316878]  ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> >> <4>[   18.322238]  ucsi_init_work+0x66d/0xc10 [typec_ucsi]
> >> <4>[   18.327167]  process_one_work+0x2ad/0x8b0
> >> <4>[   18.331158]  worker_thread+0x200/0x3f0
> >> <4>[   18.334886]  ? __pfx_worker_thread+0x10/0x10
> >> <4>[   18.339128]  kthread+0x10d/0x150
> >> <4>[   18.342339]  ? __pfx_kthread+0x10/0x10
> >> <4>[   18.346067]  ret_from_fork+0x3bd/0x470
> >> <4>[   18.349795]  ? __pfx_kthread+0x10/0x10
> >> <4>[   18.353522]  ret_from_fork_asm+0x1a/0x30
> >> <4>[   18.357420]  </TASK>
> >>
> >> Detailed log can be seen found in [2]
> >>
> >> We confirmed that reverting the patch solves the issue.
> >>
> >> Could you please check why the patch causes this regression and provid=
e
> >> a fix if necessary?
> >>
> >> Regards
> >> Chaitanya
> >>
> >> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> >> [2]
> >> https://intel-gfx-ci.01.org/tree/linux-next/next-20260714/bat-mtlp-9/b=
oot0.txt
> >>
> >> -- Bisect Logs --
> >>
> >> git bisect start
> >> # status: waiting for both good and bad commits
> >> # good: [5f1b513690edf51727e6928b97705b6437f9a98e] Merge remote-tracki=
ng
> >> branch 'spi/for-7.3' into spi-next
> >> git bisect good 5f1b513690edf51727e6928b97705b6437f9a98e
> >> # status: waiting for bad commit, 1 good commit known
> >> # bad: [49362394dad7df66c274c867a271394c10ca2bb8] Add linux-next
> >> specific files for 20260713
> >> git bisect bad 49362394dad7df66c274c867a271394c10ca2bb8
> >> # bad: [dffddeb046466ed57038295bde28b42b7506a12b] Merge branch
> >> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/lin=
ux.git
> >> git bisect bad dffddeb046466ed57038295bde28b42b7506a12b
> >> # bad: [d154d0766bf3fe830e1bf98fb2d8648294a4a8da] Merge branch
> >> 'for-next' of
> >> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
> >> git bisect bad d154d0766bf3fe830e1bf98fb2d8648294a4a8da
> >> # bad: [671b0fd929bec9ebf863cb376baf9b9d1226a510] Merge branch 'master=
'
> >> of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> >> git bisect bad 671b0fd929bec9ebf863cb376baf9b9d1226a510
> >> # good: [f4fb100039e96211609dfc44fb24b9e4a8a0f2f9] Merge tag
> >> 's390-7.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/lin=
ux
> >> git bisect good f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
> >> # good: [c296d513e034df93ddb230ad1c7a118d6b58750c] Merge branch
> >> 'arm/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc=
.git
> >> git bisect good c296d513e034df93ddb230ad1c7a118d6b58750c
> >> # good: [de53c0a584f08f31eb957f8c849a59fb33b27fa8] Merge branch 'for-r=
c'
> >> of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> >> git bisect good de53c0a584f08f31eb957f8c849a59fb33b27fa8
> >> # bad: [a6969de5a038bc08a948ada52bd7199a8dfa6cec] Merge branch
> >> 'usb-linus' of
> >> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> >> git bisect bad a6969de5a038bc08a948ada52bd7199a8dfa6cec
> >> # good: [15eab2dd63a97587405ab6bfaad9728d5b35b5fe] Merge tag
> >> 'asoc-fix-v7.2-rc2' of
> >> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus
> >> git bisect good 15eab2dd63a97587405ab6bfaad9728d5b35b5fe
> >> # bad: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a] usb: gadget: printer=
:
> >> fix infinite loop in printer_read()
> >> git bisect bad c2e819be6a5c7f34344926b4bd7e3dfca58cf48a
> >> # good: [29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b] USB: gadget:
> >> snps-udc: fix device name leak on probe failure
> >> git bisect good 29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b
> >> # good: [1febec7e47cdcd01f43fb0211094e3010474666e] usb: gadget: f_ncm:
> >> validate datagram bounds in ncm_unwrap_ntb()
> >> git bisect good 1febec7e47cdcd01f43fb0211094e3010474666e
> >> # bad: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb] usb: gadget: udc: bd=
c:
> >> free IRQ and drain func_wake_notify before teardown
> >> git bisect bad 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
> >> # bad: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: typec: ucsi: Fi=
x
> >> race condition and ordering in port unregistration
> >> git bisect bad 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261
> >> # first bad commit: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb:
> >> typec: ucsi: Fix race condition and ordering in port unregistration
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for par=
tner tasks like alt mode checking")
> >>> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
> >>> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items =
are flushed")
> >>> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> >>> ---
> >>>    drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++--------------=
----
> >>>    1 file changed, 39 insertions(+), 43 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/u=
csi.c
> >>> index 92166a3725b16..d9668ed7c80ea 100644
> >>> --- a/drivers/usb/typec/ucsi/ucsi.c
> >>> +++ b/drivers/usb/typec/ucsi/ucsi.c
> >>> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucs=
i, struct ucsi_connector *con)
> >>>        return ret;
> >>>    }
> >>>
> >>> +static void ucsi_unregister_port(struct ucsi_connector *con)
> >>> +{
> >>> +     struct ucsi_work *uwork;
> >>> +
> >>> +     if (con->wq) {
> >>> +             mutex_lock(&con->lock);
> >>> +             ucsi_unregister_partner(con);
> >>> +             /*
> >>> +              * queue delayed items immediately so they can execute
> >>> +              * and free themselves before the wq is destroyed
> >>> +              */
> >>> +             list_for_each_entry(uwork, &con->partner_tasks, node) {
> >>> +                     if (cancel_delayed_work(&uwork->work))
> >>> +                             queue_delayed_work(con->wq, &uwork->wor=
k, 0);
> >>> +             }
> >>> +             mutex_unlock(&con->lock);
> >>> +
> >>> +             destroy_workqueue(con->wq);
> >>> +             con->wq =3D NULL;
> >>> +     } else {
> >>> +             ucsi_unregister_partner(con);
> >>> +     }
> >>> +
> >>> +     ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> >>> +     ucsi_unregister_port_psy(con);
> >>> +
> >>> +     usb_power_delivery_unregister_capabilities(con->port_sink_caps)=
;
> >>> +     con->port_sink_caps =3D NULL;
> >>> +     usb_power_delivery_unregister_capabilities(con->port_source_cap=
s);
> >>> +     con->port_source_caps =3D NULL;
> >>> +     usb_power_delivery_unregister(con->pd);
> >>> +     con->pd =3D NULL;
> >>> +     typec_unregister_port(con->port);
> >>> +     con->port =3D NULL;
> >>> +}
> >>> +
> >>>    static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
> >>>    {
> >>>        u16 features =3D ucsi->cap.features;
> >>> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
> >>>        for (i =3D 0; i < ucsi->cap.num_connectors; i++)
> >>>                lockdep_unregister_key(&connector[i].lock_key);
> >>>
> >>> -     for (con =3D connector; con->port; con++) {
> >>> -             if (con->wq)
> >>> -                     destroy_workqueue(con->wq);
> >>> -             ucsi_unregister_partner(con);
> >>> -             ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> >>> -             ucsi_unregister_port_psy(con);
> >>> -
> >>> -             usb_power_delivery_unregister_capabilities(con->port_si=
nk_caps);
> >>> -             con->port_sink_caps =3D NULL;
> >>> -             usb_power_delivery_unregister_capabilities(con->port_so=
urce_caps);
> >>> -             con->port_source_caps =3D NULL;
> >>> -             usb_power_delivery_unregister(con->pd);
> >>> -             con->pd =3D NULL;
> >>> -             typec_unregister_port(con->port);
> >>> -             con->port =3D NULL;
> >>> -     }
> >>> +     for (con =3D connector; con->port; con++)
> >>> +             ucsi_unregister_port(con);
> >
> > Hi Chaitanya,
> > Thank you for spotting this!
> >
> > Could you verify if calling lockdep_unregister_key(&connector[i].lock_k=
ey)
> > after ucsi_unregister_port(con) resolves the issue?
> >
> >       for (con =3D connector; con->port; con++)
> >              ucsi_unregister_port(con);
> >       for (i =3D 0; i < ucsi->cap.num_connectors; i++)
> >                 lockdep_unregister_key(&connector[i].lock_key);
> >
> > I will also try testing this on my side.
>
> Thank you Andrei for the patch. It seems to work for us.
>

Hi Chaitanya,

Thanks for the testing!
I will prepare a fix or maybe V2 of this patch.

Could you please share your configuration details? Specifically, do you
have any of the following enabled?
CONFIG_DEBUG_LOCKDEP
CONFIG_LOCK_STAT
CONFIG_LOCKDEP_SMALL
CONFIG_DEBUG_LOCKDEP
CONFIG_PROVE_LOCKING

I am still  not able to reproduce it.

Thanks,
Andrei
