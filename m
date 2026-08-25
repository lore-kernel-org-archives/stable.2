Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D73D2FFC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642654; cv=pass; b=FRPR1Ow0V5nnYnqm6zd9YM7Cd5Jaeay2H4fsHUCVzywf+KqX8wzc+AQNT6uSpTH+rTD8BRfWj6qBUAycK2mZB9bfvUzbniny4FUxRhqLXkY4NOsv7EOkzhG4akIV0Nazwu8V2Fa4oM+geGrJjiYcq98GzO8IknY0xegqR5P+ZYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642654; c=relaxed/simple;
	bh=SiNqUwUIFt6SRHZmrmpiB724uzW4gBOBRWi19Ci/8DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQbwo4sF66IjEn+uXeEwwXJdyyIQOEhSF9f7Q3m8BuHEZTMWDVZT4//pTFE2lzkp9nkNXztD1jklF0upTMmEZCveHvCWH5HJaJFKzzxLOZJnAd4q1+72i/+NHowlgsTSa0OSlZNnhby/ourlzsKQUArcdAwd8L54aFbCxXWn7j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA/Pytb2; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA/Pytb2"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c160420289bso637859566b.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787642650; cv=none;
        d=google.com; s=arc-20260327;
        b=RSTkAU33g8MJ4gwg66h1XGhFX1XctSIfeN8wPw2ig2RQqtjuEvVYQYvWpLzo5SkOF9
         bD25Fsv7HuRE62LZzAvcXQTzOpAqaqbliMaxlgCfiTYfFe6smviZ3v4Z+zFRYTLz7XkG
         6co96C3OgNhLhSQb99JP1ucHRkMffq+PlS9q0A9oTdWKKT8Rq2KFJygkfD9XKmwhvQwz
         nmN13mNKzEcBKATw7/PPvx1NW5ywIHT72MvpD0u2rNpFZ8EdOZN16ObWWF0VkWx5Deus
         2cxPs0q0du/SyWeR+ot1ifGrc7PhdGLE6mge34FOJ7UbheNsbXJgXmrcZ2qrNoNjBZcG
         E55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SiNqUwUIFt6SRHZmrmpiB724uzW4gBOBRWi19Ci/8DI=;
        fh=oiz3vKUAQ0KNYoyneiKFKlGWt3HoPP6p/MEJyzmJOxM=;
        b=H1u0FUjxZIMOG7ct86OF/2d8u6dje2yblA+f+ZQmlq/9nyAYSz/oc0dYP6lyliKxEE
         8m4pI0SAJi1o9wXmjemXa8NaETfYLHilORXOdrJZgvRPdLZ6OHJgmpmJOeGz5Qp/jCWn
         wwr/zmknVa3dN2ijV8QdjoNIG+1szO0Bb2XK7+L1q9ESkh8xIx439UuGc//FXYJPPTG3
         ilJAdHY8BEXj2LR11VrgeFu637Rxn8nc1pwiIuqjMr3kq9hs5mpJyrlmiB22LCJnTYUM
         zoF4tqXmWJKWvk98YQRNU/yxq0fstmdtcrv5cwWjutxs1Oa3aPXOhZpekdsM+o8ofynK
         aZBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787642650; x=1788247450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SiNqUwUIFt6SRHZmrmpiB724uzW4gBOBRWi19Ci/8DI=;
        b=YA/Pytb2ci8epOWjCEebgEFSHkwt1ocZSoAFGBRGFDSarcot3Z6RmFKSYaiJzOSBOi
         Xx3Gg2yOdXATkql3Z7/Eora+ohEXuCC7Xl5uXtZWPjqasn+++Xa6AHsybceG2Txtg1Jv
         c5Ezx3VCYswVcXisg1hxEQ6cLM4zCIAX1LDj4JGNNjeiNHYWf9zNel7BBlFaTEH4iKTQ
         63Fk7VP94zSvE3IXWJwfiQregup78xzhlHbC7TWLiiHphysimjy0k707mt+cTMs52cMu
         /ZSxWza/QF+z16+kN7QVI2Wjn0tHFvM0/nI2z/HWzT7rADxfLt+jCAQ3+mDRs5ZdAVFx
         DWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787642650; x=1788247450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiNqUwUIFt6SRHZmrmpiB724uzW4gBOBRWi19Ci/8DI=;
        b=OlUEzwiU4szZObi4jeBuOjOwUar7b0Uds93ZRw6kguA8c2OtlEKPmdsAfX+DSdjaOF
         h0akrfGkwlASDBPIi5q/qg17rt0a3yd9o0rjDVrh3Ly3cIjrI4wdzFQtB8BGx8RvzQ3D
         A6SvfpT3MG0zPxr4jXHgEK8+AABJFxDk2MRSH5jr3azKrKIYuhQ3x2Dh/jnGEEJE1QKh
         LDGTInvhfr/E5lk9dhFimj57JQeZUJ7mXAZjTbz4FkClIgtHrGPAxDFrZbzOJEpcAhN3
         glktiaPtG8Y7P8A3exwPANsNWZ2S37f1MZtAjF+57hUmm63C97FDVxXTvQ6+WH6dPhYQ
         X0qA==
X-Forwarded-Encrypted: i=1; AHgh+RrRx8dwtqiElz5rvHVtpNh6qZEund4WpVr75izWYGEns8lyFQAnGWZW567PQNl33TupgPNZI7A=@vger.kernel.org
X-Gm-Message-State: AFuF++n23ZngHjxsh38SfL+JSFPtYHKIoweMZ5a9UH7EmAe3WPfnyvyW
	oQvg2gPZDQoKgFFMVJ4j7akQO9H3a9blisviB36XC2kKgK0I0uJn66/+t/ZP/6exaOGhP4HVBdX
	9oXrM/Cgmhd9CN44xLh5VmkOWr3zMP5c=
X-Gm-Gg: AR+sD11A6y6v9aR0l1JKnR+flXxm33dZhlKF5IPnsBMQykR94V3Iw20G2e0Dxyca11v
	AtPELrm+oGqpVgt2R/8OGJqiHsxKi3eNxAJVATHDPLIf1etq5LiDhhmCy/ev+OswNGkM4K2sLIn
	9r49yXQ1tRMv/F+/lx24l1TXC4YxnBzeraXWpiVSu86ww0pSkeWj4O8vCLCz5N36NZiuCu80M/k
	QRYwICVdKnkNGwRAiizK9vXjKBT3pGcGdrEQyiVl9XJys6mc2pidmSqm9dK3+9fwbkSlh+LMYDV
	AGnh/l8TWcBg+Ev0ygchlmNE5rLLYRRK2+ugVWraApouNN4LMNGbICPjqxfIm1n9hkDatgo5hcO
	3m78WfihYWwwlq5/FHIxNeLfpcRFF
X-Received: by 2002:a17:906:fe48:b0:c15:fc59:cdf3 with SMTP id
 a640c23a62f3a-c24b3ebee48mr1966772166b.12.1787642649742; Tue, 25 Aug 2026
 00:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728125456.32359-1-meatuni001@gmail.com> <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>
 <2026082538-divided-raving-3346@gregkh> <CADqcGBko4B8hEXkgG6LCb9HXoW5HdcTNBAuWh6CQN2cURgkT-A@mail.gmail.com>
In-Reply-To: <CADqcGBko4B8hEXkgG6LCb9HXoW5HdcTNBAuWh6CQN2cURgkT-A@mail.gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 25 Aug 2026 12:23:57 +0500
X-Gm-Features: AcwNN1UC7gqL1hUuA2uFBvo4qMx47GRcm0iQcoityUhZNg3Aaw43rBz_aKIoujA
Message-ID: <CADqcGBnfEgGm0=arJHGkRtGJb48p24cJN5-X+Hzqo6W8B9JUFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE
 and frame parsing
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the context-less ping, that was on me.

For reference, this is the v2 series (sent Jul 28) fixing three OOB
read / stack overflow bugs in rtl8723bs where length or offset fields
from untrusted wireless frames are used without validating that enough
bytes remain in the buffer:

1/3 fix OOB read / stack overflow in rtw_get_wps_attr()
2/3 fix OOB read in rtw_action_frame_parse()
3/3 fix OOB read in rtw_restruct_wmm_ie()

It's been about four weeks with no review comments. Just checking
whether the series is still on your radar, or if there's anything
you'd like changed before it can be applied.

Thanks,
Muhammad Bilal

On Tue, Aug 25, 2026 at 12:22=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> Apologies for the context-less ping, that was on me.
>
> For reference, this is the v2 series (sent Jul 28) fixing three OOB read =
/ stack overflow bugs in rtl8723bs where length or offset fields from untru=
sted wireless frames are used without validating that enough bytes remain i=
n the buffer:
>
> 1/3 fix OOB read / stack overflow in rtw_get_wps_attr()
> 2/3 fix OOB read in rtw_action_frame_parse()
> 3/3 fix OOB read in rtw_restruct_wmm_ie()
>
> It's been about four weeks with no review comments. Just checking whether=
 the series is still on your radar, or if there's anything you'd like chang=
ed before it can be applied.
>
> Thanks,
> Muhammad Bilal
>
> On Tue, Aug 25, 2026 10:28 AM, Greg KH <gregkh@linuxfoundation.org> wrote=
:
>>
>> On Tue, Aug 25, 2026 at 04:10:36AM +0500, Muhammad Bilal wrote:
>> > ping.
>>
>> Context-less pings are not really helpful :(
