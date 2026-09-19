Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF254312837
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789787268; cv=pass; b=KaSQVVpx4KuLjTjSnzTeL9/V+yWWPt1aaimJn9UiTKSLnN1lLER4n49ZjAqRNz7/GRln5SOAhl8DCpT2rutYo7ChlBUPxj5gGAzmXyCav+gBFt//3y3vsKn9x8pR36TSyUhcW/N7z+9SH3K0BajUBSNzHgde3zfvAiOibAV1M1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789787268; c=relaxed/simple;
	bh=w0FzqTkWxvgr+7fjcUx1t+0g43Cb2S3hJxh82YqqopA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGtzT9jKnE7F8iPAcxX9xwLCC4OwvwL8kh1/rSQYPBAPdMN9W3XLNKNvI4bE2LehXMre0tA5zCeV5aPEHdvX5BNkQ5do8rB6/AIGwk3bKqjcKbVBd+6qxF2jWWe7RksPAeR45fW5CQnugI/D9wKwLtxB7TzUts5ooxmpvUBr/iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWF0nMm3; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWF0nMm3"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso1223896e87.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 20:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789787263; cv=none;
        d=google.com; s=arc-20260327;
        b=V/MSzyM3eN2uXACKpwWXh97lolzKw+6LxJqc8gYJKlnOotMG0aaaroHwneIfFk37DY
         fzsgPYeUxEjcR2ECaG8OPsppw/elghsIwBZ/J7qmGCYlkLJfObo5kCzikyUyHazEM53o
         myiv25XnH+VxPxy5CxEC9UwBXwrUqn5fjzeeEYt6LsXkGndIBLjjPaf52bqV5qRYQ00J
         pvnJkamtPegH+hwJf2MKpAjIiuMzOGlHYgbmDbfJHEXdwM19MFWd2RZti0jjmzay0/tq
         H9as4L/EGu9i1FAqtU+6fKa8nX8C2urO1HMGd9w57GNR6rz2f4JrwFftVGR4lwMLBUnD
         OGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w0FzqTkWxvgr+7fjcUx1t+0g43Cb2S3hJxh82YqqopA=;
        fh=Wetyi8SZgxpC1NL/Jv7JaX0oZlZmx0fMiDfnZxsUBGY=;
        b=eYj3ooamy55RVGth8LrIlfmrXtAPYaDgWVr502XK4i/h0rH4+R7KrzhcB6Tx+GafLT
         AkoPMRRkgZ+D5ROM7zafzV0PBeHbEP9rlAw7X2EuyNBirj0xLaNwwXVKOOthQ7l602RC
         6JU4UcMTebbfX1dOcqDTb3JzCvMPCWx/LXwc/fUC3pd/8oRK0SaG640nnFDuhTk3AIVR
         42vDrDmXzYyGS2P6IGIDVBxUBWNArk8ykCIX6tNK4D+6wmxh/ebxb6vlfnu6CExFVLZ5
         WVgTCQis6zDVPp2Q8Y5JDzOIpjrWAT3bTiKmwbEOaM4nsN7+rYPxpY3BBhXqn8ekPJ2p
         MppQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789787263; x=1790392063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w0FzqTkWxvgr+7fjcUx1t+0g43Cb2S3hJxh82YqqopA=;
        b=PWF0nMm32bsts05N9GBf+6CFTSNwZOkQCILOyYWvogxl1k3kk/xkXI5Chx4ImKcGoA
         I70f2KwLZG5JgygwJ+/bw1ZokfCxdEt6YNxYNPTC8la47zSKSEy3Ch7BUnzf0Y5B87L0
         NGZauxfGZ3VpPHQqGuSJgwNN7MyZjfdZa3mLb2aRnxI6NOxo/IBJKET9XIrZt2O7enj/
         XYGYND3Evss+W8ixfwVRFJFcqOJpt4Lk0K0ovlRtiDe2NXrrLJVIFnG+zVtp/2TflS/f
         7Xdb744AMBpG0+kwwvujDcghWQA+ofTYeAHpIm5xJVN/f9CnXdRIPLoJU/1Qy3gI41H2
         If8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789787263; x=1790392063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0FzqTkWxvgr+7fjcUx1t+0g43Cb2S3hJxh82YqqopA=;
        b=TRhpzIuBoTlQkoyHmG/1S6UHMlizVEfs6YzRGlSCwxdkatD16ycQ92RBBw5yJdXNVc
         G29OCbLMejb4FVzY5Z27ayV9ypqArzZKY1UCrY2g0Y6stufJe0NRUrGEAlnhGjHDh081
         7Pz4/2qVTUlw/W3AYtS7SMLVz0U4Qn5RJeWXmyE6YIrZt8bNh9e4R4mzmuFQtRWmY+VY
         LR/JHuKOdNlFZ5jbYm8fTE4pNlAmSk5o03DZieV+jFKLURUEDS0N0ef9Gqptj4oi1GaR
         mIBa3NeGsvqILhHSp7K2xBcfWvaaTh4bzf5sjgSUNH9gOt8tzx9uw/2yK1ycamkg9GUZ
         E/Kw==
X-Forwarded-Encrypted: i=1; AKwUvBxawIjFzjXaFR0jjDJyMHe5LNiV1i7QkhfXw3sR6R7HgQclYdmYibgi4oFuDnAlAiDHLOv29mE=@vger.kernel.org
X-Gm-Message-State: AFuF++lqZezaibJwizF/Yf1STJwSnvUtcOupXRpamSVOHGPMmx+i8AJd
	rRuudkDBi+3Lp3KsxB4oEGX2/10xdujhFM0LH5231wH37XcfkGGXTnwoDLbs+/tCXkelcS2t3Ae
	qGoPbOKFF33pYR9jVvPQ71AxRGX5zmPs=
X-Gm-Gg: AYBFou1a8PmmRcOZ0oApEbOVSr92PzQUtZo/PEMCNJso470OyOQm/NS9vcHt1ktW2iz
	VsagzgfjFF5VjhxNAhyiuu+lg8C8lAE/GBFyOjWhupjxQgRM/2M7K322gRUcg6uGIp8hukpXfsw
	fHH10ZsuL3bqKH3fOP0Q9oQdiro2QJnygzQaeO7y5zfo7C2ZUU4CpX+SgmvJ95st5xAOUnUuUDw
	OgOgZNqhmCBznNYOk2MQy3K3Vtp/5biOEA82GEIKqGxA6tFh2V3JeJyVKAoYe2l/nk0Cj5MIgEG
	w9D++fh6165jCliZxZiVJ2JN2cXgpGJ8AGd4EpVC18bcYzZzSfubck3JQeeFSRbPt4M=
X-Received: by 2002:a05:6512:31d1:b0:5b8:c53c:468 with SMTP id
 2adb3069b0e04-5b8c53c0572mr850142e87.40.1789787263185; Fri, 18 Sep 2026
 20:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915111351.2726334-1-qwe.aldo@gmail.com> <CAKFNMo=0hDANOd+DxxvKA=RNbiG-zygkWh6EUC6Vr2MYe4npLQ@mail.gmail.com>
 <e197037b70377be78b296380bcb31b8c3e8f8d74.camel@dubeyko.com>
 <CAKFNMo=0-rxN0BKG1v+KhrGwnh2ZL_Hn2Jbcqc9sWRV8cwxPrQ@mail.gmail.com> <2f638ff0568a55233899b2a7ef4dba3ed945bc51.camel@dubeyko.com>
In-Reply-To: <2f638ff0568a55233899b2a7ef4dba3ed945bc51.camel@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 19 Sep 2026 12:07:26 +0900
X-Gm-Features: AcwNN1XrKGMdprmXwaOngP5OHZSqj1InSVDqZdmSH5-4vyq3vJ2CKSIXed7wrwo
Message-ID: <CAKFNMonz0QUmCL2L7dcx=sxNp7Ept78QMLvy9hZ766LkOXj-vA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: validate file block counts during recovery
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 12:01=E2=80=AFPM Viacheslav Dubeyko wrote:
>
> On Sat, 2026-09-19 at 09:46 +0900, Ryusuke Konishi wrote:
> > On Sat, Sep 19, 2026 at 4:33=E2=80=AFAM Viacheslav Dubeyko wrote:
> > >
> > > On Sat, 2026-09-19 at 00:44 +0900, Ryusuke Konishi wrote:
> > > > Also, please replace the 'Cc: stable' tag with the following tag,
> > > > as
> > > > with the previous patch:
> > > >
> > > > Cc: stable+noautosel@kernel.org # Non-fatal bug fix; defer
> > > > backport
> > > > until a real issue is reported
> > >
> > > Damn! I missed this request. I already pushed the commit. Are you
> > > OK
> > > with that? :)
> >
> > Viacheslav,
> >
> > Since we haven't hit the merge window yet, and linux-next (the
> > destination where your for-next branch is integrated) is a daily
> > integration tree intended to be rebased before being pulled into
> > Linus's tree, updating the commit message on your branch now should
> > be
> > completely fine.
> >
> > As documented in Documentation/maintainer/rebasing-and-merging.rst:
> > "Some trees (linux-next being a significant example) are frequently
> > rebased by their nature..."
> >
> > I think it would be better to fix the tag and overwrite-push it now
> > rather than leaving it as is, though of course it will need to be
> > frozen once we hit the merge window (or after the official release).
> >
>
> Sorry, I have too busy day.
>
> The commit message has been updated and pushed.
>
> Thanks,
> Slava.

No problem.

Thanks for handling this.

Ryusuke Konishi
