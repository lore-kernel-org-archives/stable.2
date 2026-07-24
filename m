Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F124A06D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855441; cv=pass; b=Fxgkjof63ZTCaVXAHNxn9kYYrr6EUk0r5jhABJSsSwi+aKR5KnZQ/yA1AR4BDwn00pEX/avaDVAKdwtSFzaDbsl16QWGyDw04WsgZ/Rhz5VyJ3MRkTwA1DyBEG56WAaODcfdOcBPBKz5AyRrhmLMCdqOqOz1sEjE6h8HGO/aVkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855441; c=relaxed/simple;
	bh=cBMihjtfnzn8xCdItbkni5HmOZKExq/gd6xSmOtgIxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV1+SXQxIPtCLklZvKv7zlgyq7+s9vYC2vpNzGQWVTvyg/3/qT1kmwy+MGlymIKfxYxF/T0lkEAvDHI1X4uWAQhaObZMDt7r/6/yONP0Eygp6Xj+sZSvSftryMVYAfX2Ihz4zdhvTCsNh6/oxa8meutkK2IqVjQOAEx+Eu4HqbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PcOXBiIV; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PcOXBiIV"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee4f586632so99011a34.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784855438; cv=none;
        d=google.com; s=arc-20260327;
        b=pi39di2n/fh3gdRJ7p0upNjbg+ypxNvJ3xqnnIwXQ1SRQFihfBWEww6DFP196KCkpT
         XLHJY6O3ifzZFykAOm9m3FFfOpomMi2N6qLp1xHTl78JPEibeOyndPc5A/QeEIFu91WE
         dvvqzICBKsW1InfDzgLr6szoBK1NN4T8EGlmXUjZgdZlRqyWaE58NpD7RAvLfaUWpAv1
         jhEJSviwF4md0xNtwB9FNa5E7V3W3/HKVMjvASdxZetWBlvyXC+B8hQMC+6G1BPaZBxs
         wNjDTZPB7qLFrWHufnY0cvrrOPR9EwjMbqDBnBfJaqdqnZ9nTQK5O2PtyHUdKoXzf8Rr
         4p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YjEvrw98k2bIS+MXJKjl1OOCntzqCiFfo9x9NFJokR8=;
        fh=xIobi1TCnKMXZgcqk4+9oc33Ss3eXcBMdr5Pa/ZpFJ0=;
        b=Xp02e4Sk+mMjov61RFD5IqPe5yucDcTF4fEwPh9iSs7PrUOhhA3BvfwJEBONcdqfi6
         xLhtsuKLgTNRBXsmo2p+3cwv77eAiUFN1C5pHu3O4MRG2Kg7slo7AfDMf6o647WueLPN
         1nwfL+h+ylh3g/2MhJH+CTL+v6bRS0iRQEHvm1I9t1KXGJ2buZ/KRmCdbQPpouNub1ba
         gsVdAsjuQTCFdooquv7xrfzEhPJGHRwyrwk8LDWbKRIQ4fBqeQ4Wb/Ok/HOSon7AUE3P
         lR/eDGTjTBVl0xKYWUnwp85/NRscfrL4rGqZQBtoyT32L1jDm/eAo/RKOiFTl3uVCQO3
         /sbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784855438; x=1785460238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YjEvrw98k2bIS+MXJKjl1OOCntzqCiFfo9x9NFJokR8=;
        b=PcOXBiIVNanJ2SeRbAJAvB2WeJSTfNHdJfeocsPPmkH0hCwgEY5acewlbR+rMhBsd2
         vWAS6HR/H1wQNJCAZqUBC/OOBKCqGIuOvbXmiVdDVkoPkSuLq+8PzpqHqTu/L+uj4y+R
         lFpXz0YJG5hLU5OMOoZ+VPZIA2FkOQazlKsLpqBSavMeCWUyTrT29fbtCoUNVKJ9AAdW
         pbulT0pW70tSvWSze1kt+7aaVX792sh1PcZXR119t3sSyGSQz1aXbhBXiGH+apf+ivJo
         k8fBgFEep0NRb32kqXrpV1xsKk0FSsd9YyF8EEjq8+DvQm7p/Z27jXse1/wH3JmA2v5H
         fTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784855438; x=1785460238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjEvrw98k2bIS+MXJKjl1OOCntzqCiFfo9x9NFJokR8=;
        b=N5spebSwRlYaHl1K9DqDLBxQ/gc97kMgC0ZgZ3ZsH9GAq8R0gYb+Z7AnpjrQzrCHvl
         yj5oyBVbYMHXxYU0N4GQ7rrBVhYUl5+rgckOcwT1SPxjMgDoB1EikGOogsEJkOYFuDks
         /3cjTPA2ZKF+sX0k9xoTZ2I+JHyf1ZAQbqV1D4HaBoXxAa7WOuzUdJSs7TuV0F6VsO5X
         Oqqk6Gi7rM6Nh4+YFwg38+dkb9AlNeH8PLtuElc0FOsRR4ACLyjyETAptGHNo+BoUhG8
         SUnUjTbrbbwvHQVSCbXzoox3IkwisAD+KBrniD470+I/VSp1zCRvgj+KXa9tG6a230YF
         OtyA==
X-Forwarded-Encrypted: i=1; AHgh+RqNLUh9LLLIYZ2xOo8Rt5MFnqkBf6h80pdUUWKz3xzI1yFr6CsrsoWGHIMA/BZVg6BRrDdPTas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNbBwV43VfvKBDfYdNfYkeLNh0s/UUeBf2qE+mM/Aiy/dkzOI
	kqhrFkkkcrCv3oD4ld4zfTTLN8F9TTRRk+lD9YZp29XpnJDroKsyBlWsN2Zh4CDMQwIcpauulHe
	EZuAyo+xP75trXbtTfwiqZaOSvCQnmyQqgdhJYaOHGA==
X-Gm-Gg: AR+sD13gybTwseWAEZCq3dNQ0IbIhqMFbm/gL7MgoJFAls/SQw0i0CkSEYOloaolQ62
	/UIM4f3ia1eU3PGUXE6HIcwlcJna61KdR+ZjllEcasfDWQhLxDafqBOzQZnzO6fUSyX9CJXztw0
	07/ZPKoWlhauqpUfB7HPk5Iu+NcmDjlMKEIFJe75vkowCoJ6bI81V9grthOObidXYtuSe9ZPYH4
	h+Kp3l3MyKUUHQQs5jQ4Fo+U1zjyTeLePsAVjcLnQ/VHf528WzPgXU7KDbCvAo=
X-Received: by 2002:a05:6808:120c:b0:4a4:866:c1c5 with SMTP id
 5614622812f47-4ab487a32e4mr763595b6e.2.1784855438121; Thu, 23 Jul 2026
 18:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720032338.461681-1-yangxiuwei@kylinos.cn>
 <20260720032338.461681-2-yangxiuwei@kylinos.cn> <CADUfDZpAW261MhFJg434=4nZFMD7mV=LL7F-ZiAWPa7dYvGpcQ@mail.gmail.com>
 <20260724004907.2742329-1-yangxiuwei@kylinos.cn>
In-Reply-To: <20260724004907.2742329-1-yangxiuwei@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Jul 2026 18:10:27 -0700
X-Gm-Features: AUfX_mzxjwAB-owwzf9zzBMmhMb1g2JJjyr46qdZmeRBMmcP4vb96w1zCZX3oAo
Message-ID: <CADUfDZpsTH7zU4gyVE11R9GxdadjbcrcGVX+btoEjRYS-tBiGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: bsg: fix TOCTOU in io_uring passthrough command setup
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	rc@rexion.ai, axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp, 
	bvanassche@acm.org, linux-scsi@vger.kernel.org, io-uring@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:50=E2=80=AFPM Yang Xiuwei <yangxiuwei@kylinos.cn>=
 wrote:
>
> Hi Caleb,
>
> On Thu, Jul 23, 2026 at 09:56:08AM -0700, Caleb Sander Mateos wrote:
> > cmd->max_response_len is passed through here, shouldn't it be accessed
> > using READ_ONCE() too? Omitting READ_ONCE() only seems safe for values
> > that are ignored (except for a possible check that they match a fixed
> > value).
> >
> > Ditto for cmd->timeout_ms later in this function.
>
> timeout_ms is the example Jens already called out as not mattering if
> userspace rewrites the SQE:
>
>   https://lore.kernel.org/r/55f36cc5-a013-4960-8787-fbdf4b4d0c20@kernel.d=
k
>
> max_response_len is similar here: we clamp with
> min(..., SCSI_SENSE_BUFFERSIZE), so it cannot overflow the sense
> buffer. Same idea for response.

I don't think that's true. Without READ_ONCE(), the compiler can
assume no other thread will concurrently write cmd->max_response_len
(else it would be UB). So it's allowed to load it multiple times:
cmd->max_response_len ? min(cmd->max_response_len, SCSI_SENSE_BUFFERSIZE)
                      : SCSI_SENSE_BUFFERSIZE
becomes
cmd->max_response_len ? (cmd->max_response_len < SCSI_SENSE_BUFFERSIZE ?
                         cmd->max_response_len : SCSI_SENSE_BUFFERSIZE)
                      : SCSI_SENSE_BUFFERSIZE
And if cmd->max_response_len changes between the second and third
loads, this could definitely evaluate to a value greater than
SCSI_SENSE_BUFFERSIZE.

Best,
Caleb
