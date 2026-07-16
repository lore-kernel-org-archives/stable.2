Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB03346E44
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193371; cv=pass; b=QuBa1qJd09LifIfAZjW6hZ+Z8slx/5BNMUZGT2iOFp1Y7atagl92oBG27wWvsAtUUJQY3eEoGA+lk1B8bXDmiY1eSeJ7KiCBAmDQ0OdeW8kO637IcZHKxur5lZ5Q7IWnm8w6Bl7Pwofwq2LqLuzirbKpR4gPj5ogXpvCplu5hpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193371; c=relaxed/simple;
	bh=u6JEI69xZGq2CpSU2bm8ILr7/gPuk6rKdjLoCMG3MfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPPLUyk8plxnshXIMBuFO9yIFBWysEJvXAOjeO3IsuhviQK2ErWDdHNEd8HA+OC3N1olyFALqzEvmF/l+BVzHp1DvLX9yAmBxH1mInP3tiYSu7OJ9qoUisELPOtzL4w6sGeJwAJt17gDr7iAqnWEx5Bs05/oZ/7wOpTpB6kDmdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wt16vwY1; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wt16vwY1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484f229529so2194749b3a.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784193368; cv=none;
        d=google.com; s=arc-20260327;
        b=mymFoHdkLhSF8ePgvjXv4nNmd8yTyZSeQPclaFmxyxy5/YjLoVt2JLx/NYn5lluXWC
         i7QEkioMKmBIoE+m/mDmQvqkd6rrAHdnFf56gLn11j9yIZWz8vlAZt5npIgrCnifBo3H
         za7RsAX0/5Mvx5lxAvE5kItADoewj47BnetxAuLcJyPdrrXxytI0Kdvbw5v/U+2/OQqw
         n6KPnxd6DSXYPJ35R3rIehfAhUMyqHRw40U8aJ28RUANSJMqWcjtrPV87ilnysnd/X7/
         UEpl1Tzplc3IFW0jbXAPAuEVqARXxUOXMw7QUgNe18PtdqM8lpbGPT5mfbpnWtV2eJvz
         YPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N3Aj4n5hxVSal6GClm3WYMDJDzMMqX/C9M6A6jZSm1c=;
        fh=wtI6wdH2Lw0Jz4L8CkVQkicJX0pCxTncIzD9DBRvYX0=;
        b=GP4xZcX536ETmAUXkyCpJq37RtavV9HYMNH+BkXFQin3hQJc/iu4sA5DDcSdaNIrY+
         7T1fjuwB+OUXMdhWc8PplWAX3b5kcGtTcCF6ZGskpgsFK2C+0+E/DebuGFV0G5FhHFOC
         oLpFbO+xZPl8F10aCOGClS6F+5+tGIbLk7apHyrsmwcNgLHbXqxbLyo08U2O2yxDbh1E
         hEa4hs6nV1NevMtd7pp1oBHfaogyXPwzTGI5R38Qx5n04VQaXzREoKeGSmrZQkhcFPap
         6IqR6aL1W08tUoyf8uUFRgI/GEu/8NF4gWU4H+WmMxF1CqiBL+JXQztalx+uy0TRADKj
         ua8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784193368; x=1784798168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3Aj4n5hxVSal6GClm3WYMDJDzMMqX/C9M6A6jZSm1c=;
        b=Wt16vwY14CmqBqwXAz0C/3Xib4H/dwwWACUcoiVtpJwvGBxs7qAZZ94wAw9Cr6/RRK
         K0kYRsPzrU4Jz6g/MndWjM1DzIl6nWWGC29aI3uZS41C6qVEB4kmK32tf3q/NwIeJfk9
         jtle/wM27AOfrIiI6G996QAflcsqwG9vSOyLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193368; x=1784798168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3Aj4n5hxVSal6GClm3WYMDJDzMMqX/C9M6A6jZSm1c=;
        b=RDL7SSqIyYbjIC5X+8vI07upEAyiTJ83ySXSELbZ80q7K8hs3rP7FFkrxzIas0sR5D
         KdzJWogarmBEHJJ2q9dyDJ/lZbwhznj63v4XcfcItMqYCx0Ar1VIm6b2SRPc7qxEGj13
         Q3LbQKvyEsTEvJZu70U3G99UrBFHvVrA2Ej1GXm9eyTrS3PVBilbWxA55RulJ6NNlP4F
         ncNXRRE0M5yuu4MuoKNVL8Ka1HgW3e4YC2h8NiSh7E2AD8jFQbGvHSUvhCmCWGtai32o
         2C5kQVZMdM8jHKmnVrNrwjNhhd5GR+tPCtfvXPpazx4vVFT436470695hkNRkTpgg3AK
         FejA==
X-Forwarded-Encrypted: i=1; AHgh+RovkT1ZB3iDDna8wUgNt4anzSWuzYREez+TEmxo1BT3I8u66wQWKejxVg6vk8SstWGbKX/GC38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxeMjxUFVvNH5unKgMUJxTSrALYEvwPrcsyGGXGsPT1OlN2ll
	TcxpfAvuBvv2dSz5XYYZfk9kf2Ef073pUOQ0TVU8QqgjMsoZ7xUnhqkm94mjXIJnKjBLOf3gzqr
	udD+4s3DUeLfgRupP24lg4iss5/L7o6GMbc9F2YUh
X-Gm-Gg: AfdE7cnbZXsqwQ3Yc07oA09VsE5j1j2k0UBqbGT/eYizRmswrhdCAGhdx2ZLWEONJkE
	+5FXZycmgmM62NxI/uz1qsN0d2I26HYK+3HOxN/HLX3ugDmQ3UQC+lHCE3A4GYaxA3w5JqkHQw8
	GBfktVfPnhJz/jqoGYAvJKfk+BZ1QdAisSc/grqJaew0Qiou60MKXqcgfxhbIDQmqLnMsMnY5Ca
	jvhrCAJR1fkjsh//jDol94fiojZb6weLIZpZrc0a88JhP0rPYHzyi8DuR6aFVvDKDOlqVl+afi6
	Cl917Y+SSh+ui+nG
X-Received: by 2002:a05:6a00:a229:b0:848:53c7:b927 with SMTP id
 d2e1a72fcca58-848898824c6mr20424018b3a.76.1784193368555; Thu, 16 Jul 2026
 02:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707141736.1635698-1-akuchynski@chromium.org> <22064276-6c56-411a-9f20-6917ceeb865f@intel.com>
In-Reply-To: <22064276-6c56-411a-9f20-6917ceeb865f@intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 16 Jul 2026 11:15:55 +0200
X-Gm-Features: AUfX_mzp-_dtH-UipridEtAFINWR6sMaF9la0gNmY9FR86uyrNcL32L4dUU3zN4
Message-ID: <CAMMMRMduSMniMrixGuq=m=00nUvzXQpySE86TpmvfNQtAChB=w@mail.gmail.com>
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

On Thu, Jul 16, 2026 at 10:28=E2=80=AFAM Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Andrei,
>
> On 7/7/2026 7:47 PM, Andrei Kuchynski wrote:
> > A synchronization issue exists during port unregistration where pending
> > partner work items can race against workqueue destruction, leading to
> > use-after-free conditions:
> >
> >    cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
> >    BUG: kernel NULL pointer dereference, address: 0000000000000000
> >    RIP: 0010:__queue_work+0x83/0x4a0
> >    Call Trace:
> >      <IRQ>
> >      __cfi_delayed_work_timer_fn+0x10/0x10
> >      run_timer_softirq+0x3b6/0xbd0
> >      sched_clock_cpu+0xc/0x110
> >      irq_exit_rcu+0x18d/0x330
> >      fred_sysvec_apic_timer_interrupt+0x5e/0x80
> >
> > Fix this by ensuring strict ordering and proper serialization during
> > teardown:
> >
> > 1. Move ucsi_unregister_partner() to the beginning of the teardown
> > sequence and protect it under the connector mutex lock.
> > 2. Ensure all pending partner tasks are explicitly flushed and finished
> > before the workqueue is destroyed.
> > 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
> > queue_delayed_work() sequence. This guarantees that items currently mar=
ked
> > as pending won't be scheduled an additional time, preventing a double
> > release of resources which leads to the following crash:
> >
> >    Oops: general protection fault, probably for non-canonical address
> >      0xdead000000000122: 0000 [#1] SMP NOPTI
> >    Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
> >    RIP: 0010:ucsi_poll_worker+0x65/0x1e0
> >    Call Trace:
> >    <TASK>
> >      process_scheduled_works+0x218/0x6d0
> >      worker_thread+0x188/0x3f0
> >      __cfi_worker_thread+0x10/0x10
> >      kthread+0x226/0x2a0
> >
> > To ensure these rules are applied identically across both the normal
> > teardown and the ucsi_init() error paths, consolidate the cleanup logic
> > into a new helper, ucsi_unregister_port().
>
>
> This seems to be causing regression in our linux-next CI. [1]
>
> <6>[   18.008557] ------------[ cut here ]------------
> <4>[   18.013166] DEBUG_LOCKS_WARN_ON(1)
> <4>[   18.013167] WARNING: kernel/locking/lockdep.c:238 at
> __lock_acquire+0xa59/0x2750, CPU#1: kworker/u89:1/172
> ...
> <4>[   18.159950] Hardware name: Intel Corporation Meteor Lake Client
> Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS
> MTLPFWI1.R00.3471.D89.2401091901 01/09/2024
> <4>[   18.173125] Workqueue: events_dfl_long ucsi_init_work [typec_ucsi]
> <4>[   18.179257] RIP: 0010:__lock_acquire+0xa60/0x2750
> <4>[   18.183927] Code: 44 8b 5d a8 85 c0 0f 84 98 fd ff ff 44 8b 35 07
> 0b 72 02 45 85 f6 0f 85 88 fd ff ff 48 8d 3d 27 25 73 02 48 c7 c6 1b 51
> 27 83 <67> 48 0f b9 3a 31 c0 44 8b 5d a8 44 8b 4d b0 e9 c6 f7 ff ff 31 d2
> ...
> <4>[   18.263886] PKRU: 55555554
> <4>[   18.266583] Call Trace:
> <4>[   18.269014]  <TASK>
> <4>[   18.271110]  ? mark_held_locks+0x46/0x90
> <4>[   18.275007]  lock_acquire+0xd9/0x2e0
> <4>[   18.278562]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> <4>[   18.284096]  __mutex_lock+0xb2/0x1020
> <4>[   18.287735]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> <4>[   18.293265]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> <4>[   18.298797]  ? synchronize_rcu_expedited+0x2b2/0x300
> <4>[   18.303724]  ? __pfx_autoremove_wake_function+0x10/0x10
> <4>[   18.308912]  mutex_lock_nested+0x1b/0x30
> <4>[   18.312806]  ? mutex_lock_nested+0x1b/0x30
> <4>[   18.316878]  ucsi_unregister_port+0x36/0x140 [typec_ucsi]
> <4>[   18.322238]  ucsi_init_work+0x66d/0xc10 [typec_ucsi]
> <4>[   18.327167]  process_one_work+0x2ad/0x8b0
> <4>[   18.331158]  worker_thread+0x200/0x3f0
> <4>[   18.334886]  ? __pfx_worker_thread+0x10/0x10
> <4>[   18.339128]  kthread+0x10d/0x150
> <4>[   18.342339]  ? __pfx_kthread+0x10/0x10
> <4>[   18.346067]  ret_from_fork+0x3bd/0x470
> <4>[   18.349795]  ? __pfx_kthread+0x10/0x10
> <4>[   18.353522]  ret_from_fork_asm+0x1a/0x30
> <4>[   18.357420]  </TASK>
>
> Detailed log can be seen found in [2]
>
> We confirmed that reverting the patch solves the issue.
>
> Could you please check why the patch causes this regression and provide
> a fix if necessary?
>
> Regards
> Chaitanya
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2]
> https://intel-gfx-ci.01.org/tree/linux-next/next-20260714/bat-mtlp-9/boot=
0.txt
>
> -- Bisect Logs --
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [5f1b513690edf51727e6928b97705b6437f9a98e] Merge remote-tracking
> branch 'spi/for-7.3' into spi-next
> git bisect good 5f1b513690edf51727e6928b97705b6437f9a98e
> # status: waiting for bad commit, 1 good commit known
> # bad: [49362394dad7df66c274c867a271394c10ca2bb8] Add linux-next
> specific files for 20260713
> git bisect bad 49362394dad7df66c274c867a271394c10ca2bb8
> # bad: [dffddeb046466ed57038295bde28b42b7506a12b] Merge branch
> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.=
git
> git bisect bad dffddeb046466ed57038295bde28b42b7506a12b
> # bad: [d154d0766bf3fe830e1bf98fb2d8648294a4a8da] Merge branch
> 'for-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
> git bisect bad d154d0766bf3fe830e1bf98fb2d8648294a4a8da
> # bad: [671b0fd929bec9ebf863cb376baf9b9d1226a510] Merge branch 'master'
> of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> git bisect bad 671b0fd929bec9ebf863cb376baf9b9d1226a510
> # good: [f4fb100039e96211609dfc44fb24b9e4a8a0f2f9] Merge tag
> 's390-7.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect good f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
> # good: [c296d513e034df93ddb230ad1c7a118d6b58750c] Merge branch
> 'arm/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.gi=
t
> git bisect good c296d513e034df93ddb230ad1c7a118d6b58750c
> # good: [de53c0a584f08f31eb957f8c849a59fb33b27fa8] Merge branch 'for-rc'
> of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> git bisect good de53c0a584f08f31eb957f8c849a59fb33b27fa8
> # bad: [a6969de5a038bc08a948ada52bd7199a8dfa6cec] Merge branch
> 'usb-linus' of
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> git bisect bad a6969de5a038bc08a948ada52bd7199a8dfa6cec
> # good: [15eab2dd63a97587405ab6bfaad9728d5b35b5fe] Merge tag
> 'asoc-fix-v7.2-rc2' of
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-li=
nus
> git bisect good 15eab2dd63a97587405ab6bfaad9728d5b35b5fe
> # bad: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a] usb: gadget: printer:
> fix infinite loop in printer_read()
> git bisect bad c2e819be6a5c7f34344926b4bd7e3dfca58cf48a
> # good: [29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b] USB: gadget:
> snps-udc: fix device name leak on probe failure
> git bisect good 29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b
> # good: [1febec7e47cdcd01f43fb0211094e3010474666e] usb: gadget: f_ncm:
> validate datagram bounds in ncm_unwrap_ntb()
> git bisect good 1febec7e47cdcd01f43fb0211094e3010474666e
> # bad: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb] usb: gadget: udc: bdc:
> free IRQ and drain func_wake_notify before teardown
> git bisect bad 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
> # bad: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: typec: ucsi: Fix
> race condition and ordering in port unregistration
> git bisect bad 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261
> # first bad commit: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb:
> typec: ucsi: Fix race condition and ordering in port unregistration
> >
> > Cc: stable@vger.kernel.org
> > Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partn=
er tasks like alt mode checking")
> > Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
> > Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items ar=
e flushed")
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >   drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++-----------------=
-
> >   1 file changed, 39 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index 92166a3725b16..d9668ed7c80ea 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi,=
 struct ucsi_connector *con)
> >       return ret;
> >   }
> >
> > +static void ucsi_unregister_port(struct ucsi_connector *con)
> > +{
> > +     struct ucsi_work *uwork;
> > +
> > +     if (con->wq) {
> > +             mutex_lock(&con->lock);
> > +             ucsi_unregister_partner(con);
> > +             /*
> > +              * queue delayed items immediately so they can execute
> > +              * and free themselves before the wq is destroyed
> > +              */
> > +             list_for_each_entry(uwork, &con->partner_tasks, node) {
> > +                     if (cancel_delayed_work(&uwork->work))
> > +                             queue_delayed_work(con->wq, &uwork->work,=
 0);
> > +             }
> > +             mutex_unlock(&con->lock);
> > +
> > +             destroy_workqueue(con->wq);
> > +             con->wq =3D NULL;
> > +     } else {
> > +             ucsi_unregister_partner(con);
> > +     }
> > +
> > +     ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> > +     ucsi_unregister_port_psy(con);
> > +
> > +     usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> > +     con->port_sink_caps =3D NULL;
> > +     usb_power_delivery_unregister_capabilities(con->port_source_caps)=
;
> > +     con->port_source_caps =3D NULL;
> > +     usb_power_delivery_unregister(con->pd);
> > +     con->pd =3D NULL;
> > +     typec_unregister_port(con->port);
> > +     con->port =3D NULL;
> > +}
> > +
> >   static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
> >   {
> >       u16 features =3D ucsi->cap.features;
> > @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
> >       for (i =3D 0; i < ucsi->cap.num_connectors; i++)
> >               lockdep_unregister_key(&connector[i].lock_key);
> >
> > -     for (con =3D connector; con->port; con++) {
> > -             if (con->wq)
> > -                     destroy_workqueue(con->wq);
> > -             ucsi_unregister_partner(con);
> > -             ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> > -             ucsi_unregister_port_psy(con);
> > -
> > -             usb_power_delivery_unregister_capabilities(con->port_sink=
_caps);
> > -             con->port_sink_caps =3D NULL;
> > -             usb_power_delivery_unregister_capabilities(con->port_sour=
ce_caps);
> > -             con->port_source_caps =3D NULL;
> > -             usb_power_delivery_unregister(con->pd);
> > -             con->pd =3D NULL;
> > -             typec_unregister_port(con->port);
> > -             con->port =3D NULL;
> > -     }
> > +     for (con =3D connector; con->port; con++)
> > +             ucsi_unregister_port(con);

Hi Chaitanya,
Thank you for spotting this!

Could you verify if calling lockdep_unregister_key(&connector[i].lock_key)
after ucsi_unregister_port(con) resolves the issue?

     for (con =3D connector; con->port; con++)
            ucsi_unregister_port(con);
     for (i =3D 0; i < ucsi->cap.num_connectors; i++)
               lockdep_unregister_key(&connector[i].lock_key);

I will also try testing this on my side.

Thanks,
Andrei
