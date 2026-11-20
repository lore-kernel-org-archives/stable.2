Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196666;
	b=gqvRbp6APi8HvgvdB9uSI2aXsWDskp/CkOGW8MsV+sj+QC8NIwOEcYvds4JgiU0tQqVJ
	 vdsUiN2eWhc5BL7mChFkValdPdEgWDFfpfs7TbTn9M2ZK8lElXXVmQ38yoDVtzp0sDGXC
	 us8Zah+xuGwhpvuAe9OQFX6fkEkdnx7xRnpt1WwbJN/Dfy5D1Y50V7ohKdy8B+7CZapa4
	 rl6XHWX0DhrQ8tN8G3nnCOR4cBWTE68KwDffGYYBwErIA3IeSof0PDllPXNvhl1JTrwKg
	 EkZQEjaLKmRRMIydNyk1Yhgrq2uUQHUyGN+3Xq6E9BjYl7LHhun3MOm8zUzBp99Yw2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
	b=WLkAWLoSt9gkpF+mf6oq/ArBcVXIFO5Je1/yk33QzpiI1dGiIqGEvgNSq5kh/mZqK5x8
	 Sj1f+A4KYQWYzJGrN7zQXoV9TKTyIUySxu7+cQ+ZsidSmEPd284QLHOiWTc8h0RJypwmS
	 lrq2x0qPNUMKDEnt63Qk5W2iz7L4DdjC/DvKLDGbnPlFS+uN0DcEpMCwYRUbn+w1kXZGw
	 Ig3PKbm3iz5rPm9IBxEqBZf8/Vp9VOOYZlFrb6nyCShYgChhQ5bWS/g8sGmtGqcJIAD9p
	 G+pBAtP1EVU1XJYKJikhpjp2qje2mRfxv18jj4Yx3A27zpmja3wr/4q7O5IW2OWMsgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LHJ6QWol;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884B606A335
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0884B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LHJ6QWol
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4bd3984f529so23152b6e.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795196665; cv=none;
        d=google.com; s=arc-20260327;
        b=JHGCbZ2h8LQti8aOVUxo9qxtwRFULd4DbgxuiPIlljiqKOP2yyZq0MOtEQsY1jYy9X
         ncNXnoiXriIXRfWSi2YznGJP9LatPNDwXnt7MJbzL7DmrD6l9gkDejX5/OmYkPr6CPdu
         50mLba2MZ71WyR8IVeY8TMOJC5rq5azIh+GVrJ6ZeKwSIwvmsnkA0T9RipZaF+jaU/ti
         lIoyCH3JfTx0WB4EnHwPAVcWv0k687CRTQDg9mWBdcKd0Jqnx20O7/+ktE7P/WseJNec
         Q8Aszas7c2HhZtFibpMvG+E0kFsVBo2k/W5tMs9i+1R7Tesp/9dKmJZ0GeBmu4a2QEcL
         bO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        fh=3XKyg0xwNL5dG9JoxTzq/xK4dsGcv+Di84WBq3D1BK8=;
        b=Ym6HyVwzSJg4oPMq7BTz6yuZwlqdTc2I6srK/jaGB/FRkRg1W0lzkyXr9IcUmzRe5j
         huJY31y3QSo0U7mHIo4Js8VSZ719G4+q5wc7fm4tP9R432Ht/OmTrqZmSVlS6ftozd8A
         UVGy7a0hg+9w0l3knowlLKuEwfpq5xox7OqemLd3oBme9NGZEt5ArK9EfJ6wR4Vc/Tfm
         5M3jERb3DXhQLVgRYXtnTG9ArrhJFHfXAcdfPD87meZ5rax3HhbBBreFzBa+5DhzqNsr
         pZJJ1JOVGuJEJjacLFKzMruhqEHUCh3yCoBltu3lqE8PowSbbs6ksECXroqmbV7JvFfR
         Fzaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795196665; x=1795801465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        b=LHJ6QWolNZbCECT1cCM5sJta11VYUHU7CZc8SHEQ8lqzh+DXexDxS8nP+YiC+PcCp4
         v3MOFF9uh+g1gyQx1S1rhqX2DYn3XGc6c0pg+Rx1xXLVbPaQeTJUCBHJOki5u/UqivmY
         1mOupbvh/iRl1UY43O5c6WPfw4/8eE/1zGpozyY6ZZjoFpDKKXOTq5bFosJHeZkzIE0Y
         a/8D+jz8UBjVhhqIyKRd4K6x3E79uakHohWgKzHoZuvEx9Q1u9sQRmrclQJiNuJaFwgR
         4NmxTx+QbZvaSXR6NPJMZXhA+1XWC4HPMhYBJdRrdCOPbL2HGffM/F/K2c8dCyG+JiAP
         X4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196665; x=1795801465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PSFFyAe69sjRzigw0kuVs6QT4zV1dRas7KhEugrhMI=;
        b=B5ejonxuYpYKq1xxIEES8A9hiQv3wxoCm8q19TQ4tm/kPTCeTa1jf7J+Y92KARRUGm
         +AbfgLUXEYG3mPv8M0Jimj1YzWZXCZxn1RqsRNorUWZ4aEjiQEOPZdg/sbuqQtlSVJmz
         6uXrGLYxSJLwHsJFB689bKEOaeyKds2IyM/th1J1SNmQxgpTcF+pYX7xol7808/zgLJs
         wHfuLTFucOLBdg37fgzSPVGVB8VGH7KdlU0dlw23cnswoBe5mq1qQ51QYNCdVsnozC/s
         zk6Qf8haBTfh2bScN+eH9GX5/6Vs0MpskvpdujEeGPkhMTaitGOiKoykmkXJmhqZqPQa
         waug==
X-Forwarded-Encrypted: i=1; AL+hErHN3e8NEMmRMjd95PgGLMDR//wZQO0GVzFRuWILC01MOvi3MbU6+IQsHfb70fE4VTMYcst8os0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eA4emovc3lSyyMOrQHO6EHiFcDXnkGryiPx8/qBOi+0P1z/KD
	9RJU8rWv3JQ3XkdE4w7PRQakipliC11GG/XUTiPfvXRKO1GkMoeUYdMLhQ80Du/OGOQKg9A/gcT
	Dg7i5Hf6x7a4oSlSyn0nx5s8FEOoeydxUwL3lgjwfTw==
X-Gm-Gg: AYBFou0a/+8qTrQNiiEL7AhoHFxbe/k7XNpl/uP4rsJieji0AhdUUfoW/kw26v/9uYZ
	3ZkaN6CRqbFb3JaBfnn1Jsi5fZgqfx6eIHNS7QbLu6Bay9sm5MYq5UeBnsAYOYTmAD3aTO+D1x5
	nm7/Jyh/IeGMwRFeY8sQhfjAzN0fk0MszIldnpUMjPNONrjl4YB9msxtdnMBO0I3csr6NmGc6b0
	+7G+KRCC0yOqthVp23StQaVFo8bPxAuOXE73Oca9E5aTnIkzEy0/xcRwx4qNtwuQMKuThW2mEh0
	BkDtpm2ixAN+MY95bDBX1bmzeYR7pgWZO1pDoG2eNd/+TvLxnKlReTmtmt6TRXr4sYM97FJ32S1
	3SJaJ144sr/HX/HogrKv/12lvYpWf7VrkethOiw==
X-Received: by 2002:a05:6808:151f:b0:571:a186:d6c8 with SMTP id
 5614622812f47-57a06506db4mr6743010b6e.1.1795196664754; Fri, 20 Nov 2026
 09:44:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awBnB-55HQ54C1x6@infradead.org> <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp> <awB_xd60To4UawrJ@infradead.org> <awCCG3FWbMHHvYd5@kbusch-mbp>
In-Reply-To: <awCCG3FWbMHHvYd5@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 09:44:13 -0800
X-Gm-Features: Aa3M54rN6No3ymPiMuTUPQJo1VGf1P8ZHIrPSwo1qjIt4YuOPXOB68fUXRsfIYE
Message-ID: <CADUfDZqNM2=KzsnpA+R5ygAbS-SiUzQczZvgM_NoYrhR7Qyj9w@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref tags
 are remapped
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Zakaria Belkadi <zakaria.belkadi@inria.fr>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr, 
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 9:23=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Nov 20, 2026 at 09:13:41AM -0800, Christoph Hellwig wrote:
> > On Fri, Nov 20, 2026 at 09:58:32AM -0700, Keith Busch wrote:
> > > > Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> > > > bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_=
WRITE
> > > > when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> > > > block layer can remap the tags in its own copy.
> > >
> > > Can avoid bouncing? I think the remapping flags can be tied to the
> > > user's reftag check request.
> > >
> > > If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REF=
TAG
> > > on a write, we can map the PI buffer for writing. The user explicitly
> > > asked to have the ref tags checked by the device, and partitions requ=
ire
> > > remapping them, so they've told the kernel to write to their buffer.
> >
> > No, the user did not ask for violating the mapping direction.  The
> > whole remapping thing very much is an internal implementation detail
>
> Okay, fine. But can we skip bouncing and remapping if the flag isn't
> set?

Currently, the remapping happens regardless of BIP_CHECK_REFTAG. It
depends only on whether the block device reports ref tag support via
BLK_INTEGRITY_REF_TAG (i.e. Type 1 or Type 2 PI). I think it would be
a UAPI behavior change to make the ref tag remapping conditional on
BIP_CHECK_REFTAG.

I don't see a way to tell ahead of time whether remapping will be
required without walking the metadata buffer an additional time in
bio_integrity_map_iter() to check the current ref tags. I'd vote for
making the simplest fix for the vulnerability (e.g. always bounce
buffering) and optimizing later.

Best,
Caleb
