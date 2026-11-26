Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675218;
	b=rkp59QfIIatoxRn2+1rNWtGBRn+lTxTfQBNUQlYO7UeIQSPvHk3AaK8+g7hGNfqIXrDU
	 aDZWiPsfeq4t9qMTIafEO+kQnE7IrgXrq7oW39LwcZkHXRz/Ldsfko3UZNH03Uvu9ZGCU
	 BJZ8PVDtlmnoN+N5PDcybg7w1io2IiTjrHujgpm0DQBlr/MXdN5kQIpEeMWGZVWZ2aZNy
	 3jkCmqw87ZG9QcqsOKyUmcUonePuOzudm29OdtUjETd984P8UQgugFHewQMPv6/ekwvX7
	 06jjUP9+9EKGpW6R6qbIYUfSfPmGX9VdGjnC+yBtalQMqROFKI3dHEO+6CDSfhBcJ0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=OLlhHVUzzhl/e/Uoj+6AVXD8QxJnJlUHQHiSgSprbbs=;
	b=SzWfiCbaxq15RPzBpFB8ewZgwr5FGL5xH0+O/+qWraGFaH3wdBchJXbITddWE51BSujl
	 aqiEAcwQwFqIXeii8+me4a6xL0Ow+ZrIth6DvCd+ZpFbhIA31HFnoworl3bPYSEL1BF8+
	 PkZnMxquD9vefNHfi2rW1sZ6/v1sqOoDAlbAF/McCW/IUFGeqiqq8npAz1OUVX9kt9auI
	 l3VwyNd33meYam3iUsc8dBWMQ+WDlEKNPI0C1TIQQCBQYXw7VRmBKcTzjZQ+XXBxvHEHH
	 S1/LljKhF08QeRnzjs50FmRb44gSVguJFV6Xhh4m3yM4NG2ZlqOc37yPi6vQzvI/CYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn6VIDmF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE3606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81BE3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn6VIDmF
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso9342027a12.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:40:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795675217; cv=none;
        d=google.com; s=arc-20260327;
        b=TXp9ybGzYOFdoETY5vuE/kk1Ce+iZK7ie4p33RPu5nJM4X3zsR+XNSwpwH2VOZmO8P
         4I0oDVfvZJ0hvT8N7F86iF68A8A7vA+bgJ0ASjDOFfAZqJ1jvsmP7q6OmNdLmX5uvWRd
         Aai2x8v0KvxtJs3HRB5f366Ye2KEgt3JHXUowBuUAFZQC1hZHg1Yxer8Cvs8iFik3U5w
         oqDkXMKtSYSmkH/XmvXm9Igsy3UqPHQyWWKtS8d4PIuRH1wdaBfjaS4eWo897GB34w59
         8YP9a4+LAFLicbH+X1nxhHed81aZUJO3SuwyKDg6Do2nVRqCqQ+895+cZj1p1qw3liTK
         dXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OLlhHVUzzhl/e/Uoj+6AVXD8QxJnJlUHQHiSgSprbbs=;
        fh=MXsRdOm4S6gK2ggvVzdVqjgoFqfW8+RYcR+pklR3q30=;
        b=BQHOaKE7aklIxUBUz0qFB1oz8GiirP4vXDzxf3Q0HiXMC6eV1kRJLVXIYhdrlwlROW
         MecbODUW2EYkeeM18UcS7q4manQRyPqyk9Pglw459W1Lwk/+eRjp5TPvvup4WjZ8NXU8
         Mfto+e9ezk88z40kcZxBEz0k85bd8NEGwqGhYtGl6ElLuKB8u+lHd9r8RwCGzePx204K
         t5Bq2L/IosbmhGstBTotkVxV1IaFcSUXmIsV2mM9TDmGXhSSWErI740PSntBRf7aVB2i
         aU62+XaMxOMZ2YUuwNbsmWtdnsor7dPDYAi+3g116bVUTuckXBpP8EQObz2Nh93MIcqc
         obuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795675217; x=1796280017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLlhHVUzzhl/e/Uoj+6AVXD8QxJnJlUHQHiSgSprbbs=;
        b=bn6VIDmFclLaHVmyoTcCKsdk376RBGJfQSlfrVnXcOMK0uT2C1geTxawRNtLS2LFeX
         TVj8Vex3qbuWnDJNaX3ddgDpapK56K4dzGr3wQ5tKwCPGw0+zVdFjflahZ73e5ecetTR
         EdZM1Puwg3FnFTlXQ/l/YdBT1YaaJ4KjRkEEN0NkCYD5KfirbUb82TtZorVCofNgS+aM
         tYtKpU5u4YahIEQIRT7fPmZ9q8SUlvt6LhM418g17EYtV2m0KAdR9QPiAEYgZ6fumIvu
         bFYV+kA/EA/3Zo0aIsldyIul8LcC1N2hZVwAdL8GXUE06K7ZyoNzbsrNvcS7qQr+L9/9
         AJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675217; x=1796280017;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLlhHVUzzhl/e/Uoj+6AVXD8QxJnJlUHQHiSgSprbbs=;
        b=g2oUKWlhlmux2FgC3WRykUoBQKzBLexFcg1VTC/v/s05efUgtKOAlVmjgkbq5lwtDR
         cboa/yDPWC+RkHeAUEv1VfR/uJ++3AM1csRGZjMOUTt7KrIe3VOhhUGtqoLIZQTmYBZV
         qMkFiWtLG+hKhxWATm8Xz+kT0fa+R4VCX3yUXORx3AKgC4BMxi9ewO5TBQ1ZbQucImF9
         Kt7cNugYvnqQd3DPf2o88KMVmM/FEfr/qmOQ0dpqsOgyGpwb6AIU/I/rONxexGzozdIL
         37F0svrzPtCgZXrLLbtcP3+3sBBMISLpJJx4sf3KoyAr2yW38wIB1R3m26BwJQgP4Amr
         RFsg==
X-Forwarded-Encrypted: i=1; AL+hErEShhf3fyUwpYO1vtj6VYpl7SVUCuJolM7ACBAOdaj7CqOsL9LJZI8jaslS5HM9LL8QgM9KQjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GvPKdNpRi1OCD1EdbWOGwkTNL6PhrhNmQLFRLbbVd5kU3yhnZ
	1McsDsWgPrBpXwP1YpWAfZYujkDc3YjnKVFF3WA3Wy4wcwD1fw/Dh8+8N+Jh8hlTwjEkIkNhCK5
	VCw+gCLFP4uyL+qJnd3SJK4MnlwEngTo=
X-Gm-Gg: AZFdTZcRrXtbYqom43QOcTYyVj9xsBzOPZB44QW3+9T1+qF8YYiwWzEzoPrrb3flzxQ
	1ElVDmT82/bREEXGNMe6NOBOntAP4Rnai3TfGlI2f8f5nXmnQcoBvvRP9AvBHtVV2r+9gnWyLi8
	qYPGpMvYiZqwE8xyxMdLi0qXIzjH6Yd/4oq1XrDSCIaAObbsg6R0E57m79qLjbKxEljW3ez0mLC
	9LRRQQa5bb04atqgAoqCPe5fpRu4cw5l4syFDP8P5sgqGmUZkg3/NPUahEER12y/98FZOFfYlf2
	ohCHvuH5TuPr/Vl9SMYQEyXBEHK3Vpz5YJPEdYLN1a4dAFqzChceSgtye0pTXh2KYi+0z1KAQU1
	YGt/BVwfCKXB4mABYR4mXJQ7muamczFHdRrPpHGuO3OQcuk7lNTLXylZ1
X-Received: by 2002:aa7:d402:0:b0:6b8:6f88:b642 with SMTP id
 4fb4d7f45d1cf-6ba37ee4b37mr10917094a12.44.1795675216518; Wed, 25 Nov 2026
 22:40:16 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 01:40:15 -0500
From: kayano050408@gmail.com
In-Reply-To: <c304b43a-0a75-4408-8cce-9f4e6a1c5a59@rowland.harvard.edu>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
 <20261110-gadgetfs-ep0-v8-v8-2-8f90434574fe@gmail.com> <c304b43a-0a75-4408-8cce-9f4e6a1c5a59@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 01:40:15 -0500
X-Gm-Features: Aa3M54p_hGWypFvnKMoE7_rRJeDe_ul9O64EUmW6OiF7e0KppVgARtJ-29DtBIE
Message-ID: <CAE2LCh5zMjVTGC3QH6QrMCbG0MhknHLyRK3BB-czrqPXU-C9MQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] usb: gadget: gadgetfs: fix ep0 setup abort and
 unbind state races
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Neill Kapron <nkapron@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan

Thank you for reviewing the whole series

Regarding how an event could be read after gadgetfs_unbind() has
finished, closing the ep0 file descriptor is indeed the normal path,
though gadgetfs_unbind() can also run while userspace still holds the
open ep0 descriptor if the UDC itself is unregistered via
usb_del_gadget_udc() or unbound through sysfs at
/sys/bus/gadget/drivers/gadgetfs/unbind

In v9 I dropped the STATE_DEV_UNBOUND changes to keep the series
focused on the main fixes, and if you think that external unbind path
is worth handling too I can send a separate small follow-up patch that
clears dev->ev_next, wakes dev->wait in gadgetfs_unbind(), and checks
STATE_DEV_UNBOUND before delivering events in ep0_read()

Thanks,
Jing Lin

On Wed, 25 Nov 2026 22:27:31 -0500, Alan Stern
<stern@rowland.harvard.edu> wrote:
> On Tue, Nov 10, 2026 at 12:13:23PM +0800, Jing Lin via B4 Relay wrote:
> > From: Jing Lin <kayano050408@gmail.com>
> >
> > Several ep0 state transitions lose setup abort notifications or leave
> > the file descriptor in an inconsistent state when control requests,
> > disconnects, or unbinds race with userspace I/O:
> >
> > 1. ep0_write() drops dev->lock while copying an IN payload from
> >    userspace.  If a new SETUP packet arrives in that window, the stale
> >    response must not be queued for the new transfer.
>
> The window can be reduced but not eliminated.  After all, once dev->lock
> has been dropped there is no way to know if a new setup packet has just
> arrived.
>
> > 2. ep0_read() waiting for a delegated control OUT data stage only checks
> >    dev->setup_out_ready, so it does not wake when a new SETUP packet,
> >    disconnect, or unbind aborts the transfer, and can consume a newer
> >    transfer's payload if dev->state re-enters STATE_DEV_SETUP.  In
> >    addition, gadgetfs_disconnect() overwrites STATE_DEV_UNCONNECTED
> >    before next_event() checks for STATE_DEV_SETUP, skipping setup_abort.
>
> The problem will not exist once new setup packets are prevented from
> aborting older control-OUT tranfers.
>
> > 3. Early returns in gadgetfs_setup() on oversized OUT requests or a busy
> >    ep0 request skip setting setup_abort when aborting STATE_DEV_SETUP,
> >    while ep0_poll() clears setup_abort before ep0_read() or ep0_write()
> >    can report -EIDRM.
>
> These should be relatively easy to fix.
>
> > 4. gadgetfs_unbind() leaves queued events readable in STATE_DEV_UNBOUND.
> >    Delivering a queued GADGETFS_SETUP event after unbind puts dev->state
> >    back into STATE_DEV_SETUP after dev->req and ep0->driver_data have
> >    been cleared, causing a NULL pointer dereference on the next ep0 I/O.
>
> How can an event be delivered after gadgetfs_unbind() has finished?  The
> unbind occurs when usb_gadget_unregister_driver() is called, which
> happens when the user program is closing its file descriptor for ep0,
> leaving no way for it to read any events.
>
> And as before, these issues are all totally separate so they belong in
> separate patches.
>
> Alan Stern
