Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECB3CB2E5
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271265; cv=none; b=ZgcOzJdINu2Y3l3gvsK6AhCxM7b9SLM0o5KMVzZgMpFZRjaQ1odo0q6C5N5lYkw/vBRqHfNws2j+gotJzUf1chJeHeXntJ+HDelKQi7Gm7yIZWqX1pSoowbqXsMlHgUFXtE+tLlbvI/IFamd/FUQJa7lHzS4l1StK9AEUczNvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271265; c=relaxed/simple;
	bh=tVNSowxhSextdRxzWBieprk+FnCHCFVwgFbHNoXnWms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6OMBDb2aTTMCy5X09jaX/vZJ5INm8t3AWALOeEyDCNZN7uApQZuTgtFN2goKYfW7Rvb41ol7ydme5pakVXD7IteuhiW/ikQ+c55nslPGNagaCqhlgIzl1aJhRAimhzfb1P0AVKTXebZBWPdTml5nG38FFzQFxQ1Oue8cfpIyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iIwtOTxp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIwtOTxp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so11821326a12.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 23:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784271262; x=1784876062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6hz1r6iwgOBKq4fkKYrVarepHS3W1T0QqkGacktWfw=;
        b=iIwtOTxpj+AeJoc/Wpl1XDLOImfRTiYSEzuJ+V1ibJ3rHwcPjW60FF67eMwM1I/0bH
         Wm2G1iBO6M8KTvayFB1d7MRV4mr67uzJEY4S+osfaMSK4+ZLWNbFIygN+01xmyWvrS3b
         h4arwifk8Ws2ZsUJk1BwijCSNW2RKqhuXFaNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271262; x=1784876062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6hz1r6iwgOBKq4fkKYrVarepHS3W1T0QqkGacktWfw=;
        b=P//0ztvms4yuDvFS7xfs6CJ3/BvsrssdOx2+sROdNwnBecrJ+Qq7LhMTN8vYO4AUAN
         kwmtsYUN7DufLjVmNPxnUlHdG5Cz7VH5NKIyaPImp55pp49+F4ylw2+H77OmlbueK8Vr
         TXP9NdDtgZJ6pVQcfAMMqpYyjTebvAxvmQAVoO5PkOFYh1M82DeC+HQsxpBLY8/0GZt/
         alukiYZHnmzyrljuDCztOHPu8eyRxGE34we8jHVblavkWttyIBWP0dWPJzbOgC6qHFnl
         V551s1p3yF/jPm4GFwMN1mCjm9yNWw1cuf16uXAHBLJYPJptJO8c3IIkZWzkqGrXQZmD
         9Bxg==
X-Gm-Message-State: AOJu0YyhFjBy41KiaAGJr4y32Iiyqov3C+vdP3/0p2alMSfOptQkfRF3
	w0JLGboOfjLMwM0yBvBYBkutXiQcocWh2XgiXmr/EiPSsk8ihfte/Q+nH5ofeqZXij4QB1wa56t
	p0tp5tA==
X-Gm-Gg: AfdE7cllCwljSSL/MaEvJbnymMfXgRT/2WbGuFvzxTgduybRBXBoAaVVFj1u9+15kIT
	DqV6AZArpHKts+ivQPTKiVtGWWQK2hSfH09yx5KEu6fBEgH2xHW2XALakZ8j0ahXUOUaWzdyzCw
	I6NlwvPeobiNlhXlwqmu9Ozf4u8a8PcTJ61mrgXwKw5oZEHN2yeFDrYc81IKnZnzTEyX0nYFnUt
	zK+QDw1sS48AcP6GXphdvoRIA3blU5RrBiE7QJziGA5+192Bba4NlSPDuNplb/2W5kzBZSF60u1
	s+mW37jnHyh0gojtnxM07SIQRJdpXX+FUPllmXzjLE/OLygeilTIDiahlCVQnOZKSRczoJ88pPC
	4tEnV8+Vt+B6m2z3TylkMXbjmY+OOFjqzed0diudvnJwle9I1lghoJ09EYZpQqT+jWUKZUjNFkW
	QlRvxIbbIwV4KTdYULpBNVSHRmRVlYM9BsB3KdGDE=
X-Received: by 2002:a17:907:1c99:b0:c16:3074:6593 with SMTP id a640c23a62f3a-c16b457b1damr51411066b.12.1784271261984;
        Thu, 16 Jul 2026 23:54:21 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f986sm30405466b.40.2026.07.16.23.54.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 23:54:20 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso531644666b.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 23:54:20 -0700 (PDT)
X-Received: by 2002:a17:907:3fa6:b0:c15:b5fa:958 with SMTP id
 a640c23a62f3a-c16b4765a01mr46242666b.34.1784271259050; Thu, 16 Jul 2026
 23:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+2LXtmekL+oc8e48uUXL_2SXvfCc_v7MrHJ6JDh9usRHu0sQ@mail.gmail.com>
 <CANiDSCukMqtarMGb3F0Nf3TfTB7TxHDeWu776StV+0q5q1VSVQ@mail.gmail.com> <CAL+2LXvV66O_qvbrHeFyHGjreyart277PgfKVK7jKfJ-MXihbw@mail.gmail.com>
In-Reply-To: <CAL+2LXvV66O_qvbrHeFyHGjreyart277PgfKVK7jKfJ-MXihbw@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 17 Jul 2026 08:54:06 +0200
X-Gmail-Original-Message-ID: <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
X-Gm-Features: AUfX_mxLDEXNqAd79OfZAD65-VzbQpKVQ4KFZ4WV5zGruAe1WMEYqDm3nKM4NHY
Message-ID: <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
Subject: Re: uvcvideo: deadlock when async control drops the last PM reference
 from the status-event path
To: stable@vger.kernel.org
Cc: linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, 
	hansg@kernel.org, mchehab@kernel.org, Jay Chooi <jay@robocurve.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear stable

Could you help landing  6d27f92c54ce28cfbd2a8a479a96d6f4a781b7d2 in
the stable branches?

Thanks!

On Fri, 17 Jul 2026 at 03:59, Jay Chooi <jay@robocurve.org> wrote:
>
> > Can you check if this patch is part of your kernel?
>
> It is not. Ubuntu 7.0.0-27-generic (based on v7.0.6) has no uvcvideo
> changes on top; disassembly of the shipped module shows no current_work()
> check in uvc_status_stop() and no flush_work() in uvc_status_start().
> The deadlock reproduces there on every async control sequence with our
> D405s on camera firmware 5.17.3.10.
>
> > It landed in 7.1 but I cannot see it in
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/dr=
ivers/media/usb/uvc?h=3Dlinux-7.0.y
>
> Confirmed missing from linux-7.0.y. I backported 6d27f92c54ce alone onto
> the 7.0.0-27 tree as an out-of-tree module and re-ran the same stress on
> the same hardware: no hang across 15/15 apply/verify cycles, and async
> control readback completes, where the unpatched module hung unkillably on
> the first attempt. Please queue it for linux-7.0.y; it carries
> Cc: stable and Fixes: a32d9c41bdb8, which is in 7.0. Also requested for
> the Ubuntu kernel in
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2160752
>
> Tested-by: Jay Chooi <jay@robocurve.org>
>
> One thing I noticed while reading the code: the synchronous flush in
> uvc_status_stop() ("if (cancel_work_sync(&w->work))
> uvc_ctrl_status_event(...)") still runs the event handler under
> status_lock. If that event clears a pending async control handle,
> uvc_pm_put() -> uvc_status_put() re-acquires status_lock on the same
> thread. All our hung-task traces were the worker-side path that
> 6d27f92c54ce fixes, so this may be unreachable in practice, but it looked
> worth a second pair of eyes.
>
> Best regards,
> Jay
>
> On Thu, Jul 16, 2026 at 12:27=E2=80=AFAM Ricardo Ribalda <ribalda@chromiu=
m.org> wrote:
> >
> > Hi Jay,
> >
> > Thanks for the detailed report.
> >
> > Can you check if this patch is part of your kernel?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/media/usb/uvc?id=3D6d27f92c54ce28cfbd2a8a479a96d6f4a781b7d2
> >
> > It landed in 7.1 but I cannot see it in
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/dr=
ivers/media/usb/uvc?h=3Dlinux-7.0.y
> >
> > Regards!
> >
> > On Thu, 16 Jul 2026 at 09:17, Jay Chooi <jay@robocurve.org> wrote:
> > >
> > > Hello,
> > >
> > > We are hitting a reproducible, unkillable deadlock in uvcvideo's
> > > status-event / power-management path on v7.0.6 (Ubuntu 7.0.0-27-gener=
ic);
> > > by code inspection the same paths are present in current mainline.
> > >
> > > Hardware: 2x Intel RealSense D405 (8086:0b5b) and 1x D435 (8086:0b07)=
 on
> > > the same host. The trigger is ordinary control access (exposure /
> > > auto-exposure, which these devices expose as asynchronous, auto-updat=
e
> > > controls). With camera firmware 5.15.1.55 one unit wedged on most con=
trol
> > > accesses and the other rarely; after updating both to firmware 5.17.3=
.10
> > > the deadlock became deterministic on both =E2=80=94 the newer firmwar=
e appears to
> > > deliver the control-change status interrupt more reliably, hitting th=
e
> > > race window every time.
> > >
> > > Analysis
> > > --------
> > >
> > > uvc_ctrl_set_handle() takes a PM reference (uvc_pm_get) for a pending
> > > asynchronous control, released by uvc_ctrl_clear_handle() -> uvc_pm_p=
ut()
> > > when the control-change status event arrives. That release runs insid=
e
> > > uvc_ctrl_status_event(), which is reached from two contexts where dro=
pping
> > > the LAST status user deadlocks:
> > >
> > > 1. From the async worker uvc_ctrl_status_event_work():
> > >    uvc_pm_put -> uvc_status_put (takes status_lock) -> uvc_status_sto=
p ->
> > >    cancel_work_sync(&dev->async_ctrl.work) =E2=80=94 cancelling the w=
ork item it
> > >    is currently executing in. It waits for itself forever while holdi=
ng
> > >    status_lock.
> > >
> > > 2. From uvc_status_stop() itself, via the synchronous flush
> > >    ("if (cancel_work_sync(&w->work)) uvc_ctrl_status_event(...)"):
> > >    the same put chain re-acquires status_lock, which the caller
> > >    (uvc_status_put/uvc_status_suspend) already holds. Self-deadlock o=
n a
> > >    non-recursive mutex.
> > >
> > > Once either happens, every subsequent open/ioctl blocks in
> > > uvc_status_get() on status_lock (unkillable D state), and
> > > uvc_status_unregister() -> uvc_status_suspend() blocks the USB discon=
nect
> > > path, which in turn wedges the hub workqueue (usb_hub_wq in D state) =
=E2=80=94
> > > after that no device on the hub can enumerate and only a reboot recov=
ers.
> > > System shutdown also hangs indefinitely waiting on the D-state tasks.
> > >
> > > Hung-task stacks (Ubuntu 7.0.0-27-generic)
> > > ------------------------------------------
> > >
> > > Blocked ioctl side:
> > >   uvc_v4l2_unlocked_ioctl+0x97/0x190 [uvcvideo]
> > >   uvc_status_get+0x1d/0x90 [uvcvideo]
> > >
> > > Blocked worker side:
> > >   Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
> > >   uvc_ctrl_status_event_work+0x22/0x90 [uvcvideo]
> > >   uvc_ctrl_status_event+0x77/0x180 [uvcvideo]
> > >   uvc_pm_put+0x12/0x40 [uvcvideo]
> > >   uvc_status_put+0x6d/0x80 [uvcvideo]
> > >   uvc_status_stop.part.0+0x22/0xb0 [uvcvideo]
> > >
> > > (Full traces available on request.)
> > >
> > > Workaround we validated
> > > -----------------------
> > >
> > > A local module parameter that skips arming the status interrupt endpo=
int
> > > in uvc_status_init() (no events -> no worker -> no deadlock) eliminat=
es
> > > the hang across repeated control-access stress on both firmware versi=
ons.
> > > Expected side effect confirmed: pending async controls are then never
> > > cleared (GET on them returns -EBUSY indefinitely), so this is a
> > > workaround, not a fix.
> > >
> > > Downstream report:
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2160752
> > >
> > > It looks like dropping the pending-async-control PM reference must no=
t
> > > synchronously stop the status URB from the event-delivery contexts =
=E2=80=94
> > > e.g. defer the final uvc_status_stop() when current_work() =3D=3D
> > > &dev->async_ctrl.work, and avoid re-entering uvc_status_put under
> > > status_lock in the synchronous-flush path. Happy to test patches; the
> > > setup reproduces the deadlock within seconds.
> > >
> > > Reported-by: Jay Chooi <jay@robocurve.org>
> >
> >
> >
> > --
> > Ricardo Ribalda



--=20
Ricardo Ribalda
