Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130343;
	b=YLQ7FqK2LYH7p6eAwLxPslI1mbLqHVGaHWPT2rGTYOzW8YltXyK6F1dJy415QYz8Bnwq
	 FkGk1lZ0gYR7pOrZfefLezHsGNgps40gyE8Dah7VQQd7pDIv726xufST3MKEx+dhquV1C
	 4v5cp7TRnv+F+Fl6TFj1GvAOwCNsP1OZsrZrAytBVUGEnSa7FmnffV5rRXhyEPJjJ29RK
	 5Z4HCEpTC0M7qD35DFCu/8CrbZiyGIqeWWJ70hHSGV2AhKKC0KiFLTL4wFwrncXPNRHZa
	 /bZQhpy1QccNZxLw4ShcNfGmmphzY0RHlVhEuCqQKh/bP0iZ4PcxQgdB13LoIKUhrmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
	b=c1scfIJZp5Y6TsqwKTFjTIWWGWRlfaQrbdIF8wqUvtRbxAnfm9D0xQnBDyNlqG4YF2fc
	 5nEz2J9dbJGX0tAyHb8gU6k8q7hBTk1YKC9f6o2iNTv0ln9tEREKfIi6ly+yEZtpxFM8U
	 xex4AYXfKS1yrj8AWbtUO3DelX6VwxM10CrB21ykGz+Mko4eZ1mVp9h53jik82jnOfOKo
	 ag3Pvbfk+PdfND1Jt6KxHaetCelztNJUttD/UVAc4Bwu7Fco67EPbw/9tF9+anoK8/P7e
	 LqIFZrxPI295neFKEvRUJWJWvHLAcokP2t9/vLO7O4NWK3hGr8kUXicf1Sru8lyI+Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvtLJQnH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD2606A323
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DD2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvtLJQnH
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so177815b3a.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130342; cv=none;
        d=google.com; s=arc-20260327;
        b=E0d0JN79BbR2ID6cbtXOnUKMWT9zkbzV4xfCI9o/FJkHmtuPn6Vsmvlij9KygtlFF5
         JF3JITjsvRMp2KG9PQJNEdQOwRkU3CJX2tprrqkO5m1C3GPDC2nj2kCBN8XhhqQy1pP+
         jwDeUTytXDDThjhHtXzGD+U39H+AY7T0EY36slvJYDgT/cgGuuSEZ+XSswPLIE2iSgvL
         GUzneLZKCNA1+9FzJIk0OnYpL+bBrc5MuxrJ1jEqe0WVYZ/yMUlaHeQFYIkCLJRYOTxu
         rcAHWAFHBFG8PBqo58t+uq7OcfAJLjITHr7jTmGV/zKQKmfJRqKinea+PJwW9TxpXGoP
         AWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        fh=HBY6tK7JB4Bwm6CIzd9oz25UMSCcCvS8Y9sQRxv2S4E=;
        b=F2UptMfRQ3wi9SUA7dMWe+lyiW19y68bN14kQ18drsPLsXMA3o+KZvl7kOVefUWA2p
         BbfpQLV+EYHXWQSsoSnL19VDnFGtv3QfQxHgtVeSJzGanNJ8ixaCncRHZvDpNqOMyT4u
         hAMLrVKFxWreJJtpE0Ic5BMRlDMok7+g2EIoqQcH1R59Ppj9f0oufJ5c1I2c+D3YtOyw
         sTRHHSMx4u0ee9MzNvhc66r1HwQoEqZOE4exMmmgzQQNamrKwCwk+TRk2Y7isjusGM56
         LR5udNGB1UUoWT8F4mb67TjwvCRy6nB7jmgRDUllPulsV8Antygsfb51KmPqnqNOaT2B
         s6eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793130342; x=1793735142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        b=QvtLJQnHGRLSwRNPoYCSXfeF3sSHH84H1GAref5X8bRhAghX6Vz3eDiLKvQkm2UymG
         kgHEaxULJi7GJEievjPGR2PlXtayLjVylkEeHRs7MpgmmFYAiAZKShLZZdyk49M9GXdf
         mLSx1bDdgNW5KY2otgkeOMMEVbdOHoZTqlRgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130342; x=1793735142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogjdZNRhBvM3uhV1/iXpFfYGVHaekc8nB59hXwFT7Hg=;
        b=m02AGiXkNEB7kQdAZpaqCZBRGUl24yVjLnX7M3I60xCWco8yMweYjvyUIe//Hew5Wp
         S5Vk+TWtIxZHYvot6zrfLFEVaiEqaVJwaw/DXD6oNbc7r5KX4ODC0WTD8o8TVm1sG9I8
         AkBtsowGY9F0XowClZApGvwyEsnrvjbkkhVMq0jKJ0l9ht/dI0q28rwRB8A4DZk2Qal1
         iRXn5sVanS7E5WzQoAOWTeWdsgMbyranhiKa7hR/nmvXsVWCa2Nqw/TYlCz/z8wkoMBt
         tQhK/11f6/oRzEld1B9KR2Obe7tPC3/l125qWS44LEglUQLW1Nwhcn4XNkr7BQo9nLFe
         5CDA==
X-Forwarded-Encrypted: i=1; AKwUvBxXAOaE7NJNZ2fnTR2CstWZN6J/NGzvuVgWh3PZB6F58T6F8jnSPakMp8l/MwgjDtYyHaWTlDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYINNZS6cq2zHxiRaX1N5qW9AKU7aayrRJWrEdgP/veNlCS7t1bJ
	09hb7w81MmI2YJGBDiyLfVC6cPQEiNqReisxLPhGQuGulewHJSoCxgvj7oj00Pu+3seF2rFPcAq
	S5wgZD8KCccQtoNDCjp6U98H91ErVBKeYHbiXF0/BtP9kVpOCqtU=
X-Gm-Gg: AYBFou0E/vw0J6YRuB0g0OjYB/BSJ4ZeKUaONXBLxpMUJM1Tx4VZa//R/463VFqGSN9
	rcN1o1MXlLEXIR4AFkxjGu3vyGmtKboUuISUOg+bcZhorSc3RaKYaPVSUxCRnVD8LJIv88CBxym
	YZUHR92fOlPZ3g9o4t8N2C/EVbxMWdO6aW+54Gt/mlGMTwQhk8UTPNwl6BKENus2aGH/Iznp79x
	K4xVUHdTrw1RmvDRt7x6miMQWbdFQXIpG9QWq0VCcOLUhmOeEEVqPbf5s2rqpc66EUWI0Q8MoTb
	5a3nHDgPMEdMTNNXg5Hg0Vilfy03hQuyos8FKA8fTqOq4d1lfN87xYmh3FjAf2KTHvYrVsERTtX
	n75J1tcLETg4/3K5SgMjSlNUkt8tVrrnnEn6A/jkZ3Ggiw3itsH+OElL5WJU21Li6Vf6wodm1Y0
	C4NkfitacAZD/u8+8=
X-Received: by 2002:a05:6a00:3a0d:b0:893:12e5:c07c with SMTP id
 d2e1a72fcca58-8a6e82b2c88mr187466b3a.27.1793130342392; Tue, 27 Oct 2026
 12:45:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
 <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com> <20261027182905.GQ257209@horms.kernel.org>
In-Reply-To: <20261027182905.GQ257209@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 15:45:31 -0400
X-Gm-Features: AclHuK9VHmyLnFXXwTIyYI5AQH1rkT6wNTiebNqpfKQAGesdZXrNLOB5IQZpdg4
Message-ID: <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 27, 2026 at 04:04:34AM -0400, Jamal Hadi Salim wrote:
> > On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> > > > >
> > > > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > > > This is an AI-generated review of your patch. The human sendi=
ng this
> > > > > > > email says "Hi Jamal, passing this on for your consideration =
as it
> > > > > > > seems to have got stuck somewhere."
> > > > > >
> > > > > > There was nothing wrong with the headers this time - so not sur=
e what
> > > > > > is going on. A bit frustrating.
> > > > >
> > > > > It is frustrating, you are the only one with these issues.
> > > > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > > > >
> > > >
> > > > Let me send a repost3 - will take the opportunity to pedantically f=
ix
> > > > the commit message (no code change).
> > >
> > > BTW, checking i see the threading was:
> > >      0/2 cover  (root)
> > >        1/2      (reply to 0/2)
> > >          2/2    (reply to 1/2)
> > >
> > > I checked other postings that didnt have issues and it was fine. I
> > > also found the approach
> > >    0/2 cover  (root)
> > >        1/2      (reply to 0/2)
> > >         2/2    (reply to 0/2)
> > >
> >
> > And for repost3:
> > - 0/2 (root)
> >      1/2  In-Reply-To/References: 0/2
> >      2/2  In-Reply-To: 1/2; References: 0/2 + 1/2
> >
> > I am sticking to this approach going forward.
>
> Hi Jamal,
>
> It's unclear to me if the threading relates to why the NIPA-Sashiko revie=
w
> of this patch-set didn't propagate to the ML.  But I would suggest that
> however b4 handles threading would be a good approach top copy.

I looked at several patches that it didnt have any problems with (some
merged already) and it doesnt seem to care which of the two approaches
used. But i will look at what b4 format looks like for completion.
I am begining to suspect it is not the threading, more the repost
approach. The "repost" was not including any code or commit changes
and it seems to be problematic even when i changed the message ids. So
likely it is only paying attention to subject versioning i.e vX or the
body text. I added modified commit text this time on all 3, so lets
see if that fixes it (caveat: the Vx didnt change).

cheers,
jamal
