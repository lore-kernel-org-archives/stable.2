Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024C59C987
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891318; cv=pass; b=ASfedMKQ/52gmurH+S66HJQJqEtHwUUnvgozp2r92CXJFURbCkMIuJdk+jQxk0R7HpdyaVnTeYCZ7Igp8/2RZZAPEQi+RWAwj1ifl3N9njErfoFKkDGzbvg2izNy0i9aX9TmnHl3NYNu4MRW9PD5jy20C689ZsgEolG7kBUvM7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891318; c=relaxed/simple;
	bh=I1JWkwexAdECXk7Ri9fH4s02sP9GMsE/7YOTlpBK2Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb+n7jGTwYN4LN8/8vdYxDkZqa1p1dINbtds7h6+4NF3FloqU/SnDupqfIsmTRdBEZ73hlZlRcl5Ybxz0dBzlGpdSOxTYN1XeOiIrtQkgYClAUURjVANrrFa/MAJNCeWW6HBc3v7FSqMTIXxUAA/MSHzwAV/JWtlN1cPGLnrMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPoO/5hK; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPoO/5hK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cc39e06bdso59216296d6.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 11:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891316; cv=none;
        d=google.com; s=arc-20260327;
        b=ThrecFSrjJVf06nQJ4itDrIL6JwS3kDeb9MSu7RZA8Z8H998xmhJWntTzIUMM1kZhs
         /f3a4mcQt8kA+OwT+2phyr9t2M6f7YdC9J9i1DJSPg85nFZYzZjGYz2bb2jElWxjRvDQ
         GBi54KJPE81+wtdtcSB5wSCggwPIJ13Vscol7ZRg/JBMgudCVjNUwvY18L2PHkL3+3V4
         PCluvGk3emyUXuIgd5zsEcqVpHO/KeqsP3xUOxoWInUalG9rroJ6PW0mrWH8lC1BVygL
         NVfwqHKcwDoP1PJ+7oUctlBJ9LITkSNWBNmaMxv3kERMnw9lLuUejIJEvhobMClnVVox
         pacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        fh=HEordA7qT5fwu0QlIQDcq/TQ1DamQ5GTzxGn7B9v+xg=;
        b=Id3UU1Itu2yWgfhEr8MeQpTNuGZfiXZu6HMH89pfEG/IJG9m+Q9umEKf9SOY9RIu9A
         96AWjd3QSYTSfQBpXF2lF07x1ASU/6bK8Y7X9AB34R38EwOH9zk/iO6ZQ5EfZivyBreK
         tSCjdv43qAdPt/ILqs/ERsR5LKgq+WnrfN2iO7FslEVk/uypXXkvXUHlr9IPqbxmBGVh
         Ioskkm7XuZZfU3BGmT5ssxvQSykBXungtCtk2wJmHJ7q10C7U/HQAoMVuoIY5ADMfHq2
         9ORBq8GBZkvjR+FD9GQKmfypajU+pIq2HoocQia1tHE6LIemXVDC3qyes8RarESkjNYW
         qMLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788891316; x=1789496116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        b=hPoO/5hKS/oehig2qkq9G2M3k6jxjiGgP9b1RwRi8Ez+Qg4ps/gIf04NRZOHslBwqM
         aBzNWzFqK5+pjMhqkhm3DznbFy1E3opRNoHw6W3S37s6E55pe8rUoOKwGLD9uazyPWhq
         +81M11E3W8R3e1enOkwVDcHwbbpae7qyFULUMUVOvfp1Pe8br8SQUyAjjjvEHioB9enX
         4JDZo4mDBNIz29rCFEY1T8+z6nbT6D53r+Tqq6O/lLnDEXHXFJpFwUynQmIk+2Df873Y
         B6hKvY4fy2hn6HFMkplJQZbW2B/eTlIzVpUMhoMo2DOLbIEIjV+C2AvUBy2SfTsNryOa
         HHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891316; x=1789496116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        b=snrrt+T2Iu9+ou0D23XcuQ0mrs2jv/6nx4YZKSmgfwo6Ouu0Z3fB0V1u247UhyhlKr
         wf6BxiUrY1mKhLc42UIP1Qp4MEGeSt+RrYB6DTZ07sdSDtvRvo/15ICNLzgyoI0VtyCe
         HBr/AAT5zZKsqg+77wpLDSD8Xtg9eZRaNOvEradbiRSSNL/fxXaNaaGk3ynGFJ4KP3Mc
         KPiehYGPDiAEZQ3bBG+buiiAEBh14Xf6wNFmXr2Iuk1+GKrFvysh9waxSfjHyUukf+Cm
         nrSxWxYKdunF3nD1XN1weV+WORgYFc4CK5C005+8KO/zqRtUxJbyH8CaFVyLSyuLoUnp
         A+iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZPeVMWWWcynTmJ3ECmHvEVUQ3iMUidq5aaFPGhzhIZxbXQDT6H5KHRA4OXt5qpIRvldhKQVk=@vger.kernel.org
X-Gm-Message-State: AFuF++lWqaPB9nHoydLHVOWlRKB9FIkmq/BqLZDSTHlSSwvh1VZtXSiY
	Ybs1xkO1S25rgLxzdqymk28aVypY6+BrEvHoEO7fA6CKyrM8Kwn9gbOXtgRxv8gnJ6IaQPAyLtb
	GEC6bmRZkpdCPRFLuf1lbwr+v2qaZgeM=
X-Gm-Gg: AYBFou3jdgV+AbhBhJQkjcxyUvPBZqM1hXNjvT+4aR4HLRH25VddrBg3B2YQFKySeii
	HEw8+Bp2CKwbF8nMaJZlthP0KvY9BMQooAhQnnrcRp6d2g+X43A4UZpBOyjuwLW9ThKBBEjwAH8
	Ygmpab5V0aWANs6/vqaN4F4gIbZu2lYuozm7ZRYSmPjWgxVcddgP9h3VDsMriAtqovXITnH7zgp
	bYtx2LZgPkws1HkRSfWD931FiZQBfH1K1GB5c4xKP0DADO65I7VTWdMNACPVfbCUttz+Jc9Uyyz
	fOns6NeEDhf16jak9bJmPkS3IO4YXlpP0+1XGy8lBsJ7C1njopp0Ja8=
X-Received: by 2002:a05:6214:6354:b0:90e:8a84:f5b8 with SMTP id
 6a1803df08f44-9103efac50fmr274978446d6.28.1788891311145; Tue, 08 Sep 2026
 11:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
 <20260904020235.8227-1-98lawweijie@gmail.com>
In-Reply-To: <20260904020235.8227-1-98lawweijie@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 8 Sep 2026 11:14:59 -0700
X-Gm-Features: AcwNN1UywzU7cqy163imiuwCDI-OJo3UKdSrETVCLN-wYAoD9DpBSTsnKrDgB1Y
Message-ID: <CANRwn3RqPvR7g3riuKSg11TCm+Yt9MTd6r0tF4tqSK3rcRp_gA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
To: Wei Jie LAW <98lawweijie@gmail.com>
Cc: bentiss@kernel.org, jason.gerecke@wacom.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ping.cheng@wacom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:02=E2=80=AFPM Wei Jie LAW <98lawweijie@gmail.com> =
wrote:
>
>
> On Thu, Sep 3, 2026 at 3:36 PM Jason Gerecke <killertofu@gmail.com> wrote=
:
> >
> > I'm still finding the above paragraph kinda hard to understand. What
> > do you think of something like the following instead?
>
> Your version is definitely easier to understand. I'm good with it!
>
> > Other than the above language issue:
> > Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com
>
> Thanks. Should I submit a v4 patch with your "Reviewed-by" and the
> updated language, or is leaving it as-is (here) just fine?
>
> Regards,
> Wei Jie

I suspect Benjamin would prefer a v4 with my Reviewed-by attached so
that he doesn't have to make the edits himself.

Thanks for your work on this!

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
