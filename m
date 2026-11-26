Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795663293;
	b=pP8dOTvZjUbwsGQ5OSbGnpG5USFVF+swUQ+x8ecw2cZzShaDqmxOGU6H/Rv6zIPmI26W
	 58qW04oWhnsmijoHjdnVEIZtN7SvU+dRAoxaY9AMZ5FNBbzUt9yJ66nn3xlErJ4CTlfaC
	 pRYwEnGcw0EuuB6oa71YnuXP90/uCHlFxZ9CFSSFGt2yvQmo7dWHTL9vqYuQAI/6pKLFW
	 v/FbF074UlyzsBWupTFlo/4hPyZrC4QFwJXMO6b8vhaAkdhbhVhoSfbPDgvz/2Dj//b4/
	 za4RqVZ1VuKcUhEUt7+JPiwKwes8zWbB8l9q9pI3srUkyd+RW8kthc5GIZrEj4Ux+ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=c8Z6DV8gdGWeEQmibR6f0uelgWz6UwbDwMuOqZtOlGc=;
	b=Y23mzZxXL1be+ZQYhXKXDXdROi0YqK4dvcJgXwVL2EWrlKjpFSvOxWi3Ccx0iouPcl9k
	 wIaTtQLMmqzNx/IGwfJTZVvQI7WqzWqB5MK3xWUbirC2g0BkX7KxLNGcxiLH4LAB0IfgD
	 GqkzAAkQ7g0ns8tnlxIa23jGTJ/+G0xHsJe69s+hD34IgYuCrc3Hyu/Y0KdpIeoMICIS6
	 SmjeVv2YOcJHoMFjrDrl4Iy62xZqH7co96+ZiD79iJ8nkEC1NdLUuSlQ5zF2kwSQ1Dn9S
	 fDWcb9UYOJljhBcjoMzwoyzEWyaLLA61CtFKugCDKZuEns6mX4bcHy/teAIcY2a4cvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsc03Yx1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF12606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsc03Yx1
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so7103541a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795663291; cv=none;
        d=google.com; s=arc-20260327;
        b=PoBUaoOqhVLspV87U+yu/u2iVlqcnS2EB0Skv5+TmQRgg41xswUrpPqM2NqA2ksaoJ
         hgpaAqC7rcv3UlW4y+GQOK6nAtbVNzhyRtod3CC512jYz75CAL4qL9O59J6am3YFUWh0
         PPuiJqvNvqwmObQsK+wykk9AtNwqOg3t77wXfTs/tK4I98QttupMFmJsfozp7f6qbHOp
         egiitFY+URUJbAsOD6fNCICrm5YOEaSDG9bWNL1XDLC7YcLuvUdG5RZ81olvXI3HMACu
         rHq3Uc+ByYbJQT4uSJpjYZ2FuUSnoczRVDQdwnFWulPZetex64xLK/ozlrw+hKcjjbA7
         ZPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=c8Z6DV8gdGWeEQmibR6f0uelgWz6UwbDwMuOqZtOlGc=;
        fh=OTWLtN5z27ZfEjRZImtKx/zTNQ7CfNISo1cKy2BmEYo=;
        b=AnOBZuy8e18wcMVsut/v4sWlGoGtijSeEAMSIcmzsflabXkOjiUym3b23wI8OvId6x
         kBnlVaPxwZEb1Cg2h5yX+SsE4m3lHODwZ9OtZg3KQVKrPCDQbHw2oeztBgUvQamHFdPi
         MFwNlrvSRt6EKE9vBbP8uf1r85GVZYHjE/fi5F/LqFfHbjUnlAjLE/nAamtjaqW6KgM5
         7uKrD4yYW33H0No5+A97arFyBwRi+vukinY24SdGR+KTXzNodDzyh7dwd1L5GzmTMVjR
         AY7utMoRbjXiaJOJhAv8e1nHkpBeGUlxFvAK0PdxWR4PP2Qhr5eO4t4hoL/jnc74XUsC
         L1mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663291; x=1796268091; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c8Z6DV8gdGWeEQmibR6f0uelgWz6UwbDwMuOqZtOlGc=;
        b=Gsc03Yx15dzhHpjYTTT2Inubjt3C5ks/2wkmp0ycXJ371FUNAVlo82xZYb3++gLGZz
         Y0O4M40FHj36/yWp+t3Zpa+iAAHk4zOoZW6lkuMimS98XQXWjTR9fN8AM6Qc9mXr7IIa
         1tV72ZRHzaZZoh5tRi1cPFmmP4zmvkCg9AzZRykk/+tIkcJhN3ET2DyjUZWz+Xifzl4W
         h/c62sHVsBG+FRC5XBnrwhewQejhe0WpBEwYjg/DlPxcLtP2fTm37b+2Xg6ibgDCf3C9
         eCHQLeVWIitXYod/uGRwXdK6OkZEZ8gNb1OvK4KHOXWhuOGGZ76W8nH1J/YSJBehhgJu
         TZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663291; x=1796268091;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c8Z6DV8gdGWeEQmibR6f0uelgWz6UwbDwMuOqZtOlGc=;
        b=A/od5Sjy+tdV3sk6+wGwtOWpyqbvTNoY8zTinYLWIgL6BlBbF4Pvvdup+nhJVU7AiG
         d64mAbqPW3ZKDZM+C9ja+KD8lQzFBQaIf4IS0zUMVvXV+1tKQpWfyfGmNASbg3UtLRjP
         pvZSKU8DyMhI78WDTZX8W7HdtCixIEyCyxcjmuL6WSmFuAMcrZcqHMWBoYvEZ4M8wCvT
         DvO5nt2w7gy/eiU6ZsjrB5GpTc0hL2kFQWIrx5weHgKgg/PnJwdbVdKr4bz7QTbQbJAm
         aErRooloKn3S7LM5/27ove3g0c1JSv+4F19C3JS/I01T3JK5pYTkC8Xtogc9Mt/kYEfO
         sgWg==
X-Forwarded-Encrypted: i=1; AL+hErG5tDbhiohVDQWZFpgSr4/kX1S3jqVZr1yRnNbPpnAixt069Ve4xNH+AnzwfbB7rD9aLhZGzB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t5U6qqeK3oD+J6YWYNhdDFSOJf0KyUBHknD0DOqPxic6ih61T
	o32BWJWiRROsY4rABV6Wq4PZoI0zSEjzEwu5TDgCvsyTwQb4yiNfZVH4o56FSL/SutnYDEpS6dW
	ZXZ/x9rNxUNx+OTHW8Jzfa8nzanMw6ERrxzq44lM=
X-Gm-Gg: AZFdTZeAYdJve9hnxLE5v9KqBvueGJZJdsTNSZSCbaRwCd1tsa/7wN7nVcgyTUOolus
	5c7qjU85GBd5rWgbQmcGiyFbmu+36rpYa+DyR5106Awr0/WKMPy+jAZjKCOo3PRG84ddai7Q9ox
	uzlbKtsRWfOepmLlUHV6EpuATHpO7bVRSDh+llqHxlmWcXQZtj7z9UgbZInu0Fiedc7vdKtM5zN
	4NLYnfQxrlLyCSd61oVSOTrOhRoGw8gslP8fDt4qgJ9zWgKYlyHFrnZi7qqpxXyl5njngccUo4T
	xBnnYQFoYSHYsOT65aBzHMC2A4BOpuFiq08RYhuVmHbi3a+0Hi+smEDoxZjNAheKLe94zyT8NMx
	CWXZzg00fMfQUEnJzAwadb+tbKwX9ywd45hKm4I62isnYEske
X-Received: by 2002:a17:907:3f18:b0:c46:9711:e30e with SMTP id
 a640c23a62f3a-c5131a1601amr1679769266b.29.1795663290899; Wed, 25 Nov 2026
 19:21:30 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 22:21:30 -0500
From: kayano050408@gmail.com
In-Reply-To: <b71d58f5-ca09-4f11-bac1-ab9720cac5dc@rowland.harvard.edu>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
 <20261110-gadgetfs-ep0-v8-v8-1-8f90434574fe@gmail.com> <b71d58f5-ca09-4f11-bac1-ab9720cac5dc@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 22:21:30 -0500
X-Gm-Features: Aa3M54rPL2FamNAEIXP9ZhIRzp-Iokuf5xZugLV3IRMpHTKq6sQUPeDjJX4LFko
Message-ID: <CAE2LCh57-f27Xk6NX+q-agg=h+G7vzg7ydGdP7s7tdRTYpyStw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] usb: gadget: gadgetfs: fix ep0 request lifetime
 and buffer races
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Neill Kapron <nkapron@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan,

Thank you for the detailed review. I have received your comments on 1/4.

I will wait until you have gone through 2/4 to 4/4 and shared the
remaining comments, and then start reworking the series based on all
of your feedback.

Thanks,
Jing Lin

On Wed, 25 Nov 2026 22:15:43 -0500, Alan Stern
<stern@rowland.harvard.edu> wrote:
> At last, I finally got some time to go over this material.
>
> On Tue, Nov 10, 2026 at 12:13:22PM +0800, Jing Lin via B4 Relay wrote:
> > From: Jing Lin <kayano050408@gmail.com>
> >
> > gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
> > the gadget, assuming that no I/O remains active.
> >
> > With controllers such as dummy_hcd, disconnecting does not necessarily
> > drain ep0, so a delayed userspace response can leave dev->req queued
> > when it is freed.  This triggers the warning in dummy_free_request() and
> > a use-after-free when dummy_udc_stop() subsequently drains the endpoint
> > queue.
>
> This is a genuine problem.
>
> > gadgetfs_setup() and the userspace copy helpers also race on dev->req
> > and req->buf:
> >
> > 1. ep0_read() versus gadgetfs_setup().  A delegated control OUT request
> >    is queued by gadgetfs_setup() and completed by ep0_complete(), which
> >    leaves the payload in dev->req->buf and sets setup_out_ready.
> >    ep0_read() copies that payload with copy_to_user() after dropping
> >    dev->lock, so the copy can fault and sleep.  If a new control
> >    transfer arrives during that window, gadgetfs_setup() reuses dev->req
> >    for it; for example, GET_DESCRIPTOR(config) points req->buf at
> >    dev->config.  When ep0_read() resumes, clean_req() frees whatever
> >    req->buf points to, which is now dev->config.
>
> But this isn't.  Or at least, your analysis is incomplete.
>
> The real problem here is that gadgetfs does not handle "aborted"
> control-OUT transfers correctly.  The request for the OUT data stage is
> submitted when the setup packet arrives, and the host is told that the
> transfer was successful when the request completes correctly, but the
> user program doesn't receive the data until some time later.  And if
> another control transfer arrives in the meantime, "aborting" the earlier
> transfer, the user program doesn't ever receive the data.  It's not good
> for the host and the peripheral to disagree over whether a transfer was
> successful!
>
> The start of a new transfer should not be allowed to erase all knowledge
> of a properly completed control-OUT transfer until the data has been
> read.  Instead, the gadget should NAK the new transfer until then (i.e.,
> not submit any request in response to the new setup).
>
> Fixing that will be a fairly substantial change.  Furthermore, this
> whole issue is so entirely different from the race involving
> gadgetfs_unbind() above that it belongs in its own patch.
>
> > 2. ep0_write() versus gadgetfs_setup().  For a delegated control IN
> >    request, ep0_write() prepares dev->req and copies the response from
> >    userspace with copy_from_user() after dropping dev->lock.  A control
> >    request that arrives during that copy can point req->buf at dev->dev
> >    or dev->config, so the userspace copy overwrites a descriptor buffer,
> >    or reset req->buf to dev->rbuf so completion calls clean_req() on the
> >    wrong object.
>
> It should be possible to handle this problem without copying the buffer.
> For instance, the user data could be put in its own kmalloc-ed buffer
> instead of in dev->rbuf.
>
> > Copy completed control OUT payloads into a private setup_buf in
> > ep0_complete(), copy control IN payloads into a stack buffer before
> > preparing dev->req and leaving STATE_DEV_SETUP in ep0_write(), and track
> > buffers allocated by setup_req() separately in dev->ep0_req_buf so
> > clean_req() never frees descriptor storage.  Ignore zero-length reads
> > while a non-zero control OUT data stage is pending so they cannot queue
> > a status request early and clobber setup_out_len.
> >
> > Submit ep0 requests through a shared queue_ep0_req() helper that tracks
> > dev->ep0_req_queued and wakes dev->wait whenever the flag clears.  In
> > gadgetfs_unbind(), tear down non-ep0 endpoints first, then dequeue any
> > active ep0 request and wait under dev->lock with wait_event_lock_irq()
> > for completion to finish.  If the controller rejects ep0 dequeue, keep a
> > reference on dev and let the completion handler free the request when
> > udc_stop() drains ep0.
>
> These descriptions are a little confusing to read, because they mix
> together your solutions to three separate problems.  Each solution
> really should be in its own patch.
>
> Also, don't worry about a rejected dequeue call.  In practice, the only
> reason such a call can fail is because the request to be dequeued has
> already completed (or was never successfully submitted in the first
> place).
>
> Alan Stern
