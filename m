Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88854233929
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352304; cv=pass; b=NWTvhCCDVn6snuAtKZLTrzzyS6dvPYT6/tOlZ05I6Js+sf998D66BqKp6rkvJG6mL0ZG9VmwEZtKJixvjn1Z53QiRSh2FvgFFLBywgnpkYyNgkMB6RHoy9HIm1me/qOebfd1FiI1pikOGo1QlcIwZPWtXk6XElZeinv1sYMknCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352304; c=relaxed/simple;
	bh=XRzNtKPR6AKm+sBG91uXww4VHhEG5iSLy5tnfi2M7lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWKn/Xq+SOKP82AisYJ4mJcGINpuV1uxZXku7l4YI4s1Mf1TxOMLonaIVw530nvFd438wHKC0RrdDztxokxN624cmKyOTjXigaDLSDSVaz5mtqiEPmtiX/QN4Lwbf2XhHVG0YGK7WyUmLW/0jVYJ9pKLFCzTVdcoV+zzhJNtQtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8rNW4Wi; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8rNW4Wi"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso1760597e87.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789352300; cv=none;
        d=google.com; s=arc-20260327;
        b=prcVAoyI7r5qIhRTxmTR/zj7bG7uBT0ROwVcfdmtp/S2YDPwHch5fMJVGAC+AtnEXy
         +BOjgLQ740qtI3Y/g66am393xsMRf6mFy5yntWpaudcvKPC+fCx206nIV9Rj9PrxFmvT
         HHVxbyt5/9ZJLN7sKGRfcoifb+d5pjEv2XG+GTJjEj2pdQsS1EmykquhTeYdTvgtaiaa
         c2LYYhxJ/SwY2EbI0vaFw9E7PFUGuxNtSc6pcNNtI/HvB46ZOm8Y3ej158cgKPcQ43BV
         Re/Kv8r+xeYMdTPUUo0kJ9dtAL6A5uU5t0liRD6xYzsr7MVTgzTrIe/lXJ7JbY/wdHcY
         szJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKvkuA5kghZYj6k0K2bq1InB60nQreojZmTTUXP/Hrk=;
        fh=YceFm1N6u1kvJvO/aIwaXAr1ZqPP+sUIAQeH1wnUuNs=;
        b=gyRGD5hpOVfrvnxM2iJYyQVxhRc1q6GK4cB3C8NlwzGVOCD1V9fFf3iLWES7v0fPP6
         7HWBhSFEpIm4Jghh93iJpJ9fVhwHiKFFVSFD5gc8A0m6OTT8OS7VPBN9qOkHefKYy4MP
         dWr+NkUxWlvu4BE7AoQm3UjcZqnmRxeCdOib7sPkWClukXXWc0bl+pVtVp7KYB3a7OBN
         AaMqQX6rBRsRaUADz3GtLtlhXDBYr1Z4Br7QLq71PZDa9bzVK31xlEonVCuxOQzc1aCe
         K8eXS1w4nVnxwyTX5l0Jivr0qHzAu58vxbBvolkXBVJv2EzhacRDziaKhrX19/w+feeY
         yUtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789352300; x=1789957100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yKvkuA5kghZYj6k0K2bq1InB60nQreojZmTTUXP/Hrk=;
        b=V8rNW4WiRdHVUWYra7yVHFYk8KAgjTBa47ph9/5xreOKTq9cfLPcKRP+gfYmo7JWsC
         syVUByLfRLNyigdih99PoOsCZYr5HH1RZ1UrD7gPuxkwqE74t471IZLXNAuDDuACG7Dy
         PFE7kyVep3ch16NARUjkH7Rj6fslR2lyM49X1IHL9RQ6H701CZEipE00ymBaEtT7uXg5
         ABFtvrNo0K2FcROAi6Y5w0KHXueLAjTRj/awsvJRpFsWEnG5WAJDA6eDHqnzCMPsq4IX
         F6nH3roc86yAqH7NCYAw/arf5oVQ9o/MMlIDVdQaiJ75618QSG8wjcU4ijfXNYIGuwqc
         6H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789352300; x=1789957100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKvkuA5kghZYj6k0K2bq1InB60nQreojZmTTUXP/Hrk=;
        b=dbmO0XRPum1tzBWiCvZxZrdTDmw5TT91A6OkaLdF26peQhuZFpVTYy2MnJ4gIDY9nT
         fIh9Dn6bNWD96dNme64dLElW5ppIXyaZ6kDVomtr/WUJiHqje8m51VIpGi2Ojx1fcBA5
         ANvvd5/U/N9Fv3viRG+xHlvAcaemXKgj7wgO6F3b845ryqo3r256vF8+dHiN6Ozzcv7i
         /tAla7TWx86uU2Pc7BZ6nZ2ih6cZUtiFLN5wiBV8wI0bFiNvSCx5KsrvTb/VqTxVM5WQ
         joIMjvf93lb3hWXn+10Vz4YxOEeLKdOGz2x7JEeEm8+HONK83SWmr0qjou/N7niNMXI3
         0sfQ==
X-Forwarded-Encrypted: i=1; AKwUvByQSlxXQDBAW/XTFnfvx/wYXr+dW4rJB+Mi+bqbdWuVkwgqGv6a/IWcwJLkg/IIM8vKmOeCoyw=@vger.kernel.org
X-Gm-Message-State: AFuF++kug+BFWsjRA4Q0U8vFFQv+YQCPQyZo9eOWVXR6ah9iaXfwSJJ9
	KUIdD07vD/GxMPCaJU801QZaxWuSF75QHLQqzxjOcyhWXOcKTsac0OfuIxw6U2Pog6GlDD2BVX3
	FlNFKjLXceod4Gz24wpH1hRnM566ahZZRFw==
X-Gm-Gg: AYBFou1qQZOhYfCQNzNVSY+MNXX8KtbPIddDkG/2IVAwVb9C++JGJCKBuD6Q2jhfg7T
	Hv50SAO+cM/3K2aq38gS/ipyTdJ+xpTTO6TkmfbENNLgRqHzxzL0ZGWqXwBZVtQfQYcZTJfSiH6
	ddsUZtfvr9J/yRe8a7VwmBZg8tTGfne+03eLa7aAzUV9CJFckg6x69c67Z4/IJtLFKrw/ac5lsM
	e/TZwwuXMsUe++Pm/opQSYPLKUbPZdESUHYC8QdVLzRzitrasED6CQe+a5W2m4NE/o+FlmyV8dH
	xXFtt0MqjrReLetzq17uWwBSCN++iNFyj8CTggk5qSi+TUcLoGOKBv0vh024HUkUmsbGGmkn5IN
	OSkZeJuuJUS/g2FACM2ZMN/iI
X-Received: by 2002:a05:6512:318a:b0:5b6:421:a8fd with SMTP id
 2adb3069b0e04-5b8ae6b9093mr149563e87.29.1789352300428; Sun, 13 Sep 2026
 19:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com> <20260913190904.bd6811bc8e094047017c67f3@linux-foundation.org>
In-Reply-To: <20260913190904.bd6811bc8e094047017c67f3@linux-foundation.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 13 Sep 2026 22:18:07 -0400
X-Gm-Features: AcwNN1VM8XngtNQB-pgIz8uVKeDvAsmMl48FSCAoRIZeQw0QMDqfpxAw9pClylo
Message-ID: <CAEdQ38FOnZPmhc2LYOCXS4sqpi4gqLGnkUMA7EXyDFL_9A=X0w@mail.gmail.com>
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:09=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 12 Sep 2026 14:17:35 -0400 Matt Turner <mattst88@gmail.com> wrote=
:
>
> > The run-length path rejects a block when dbufCount+t equals dbufSize,
> > but the loop that follows writes exactly t bytes starting at dbufCount,
> > so a block that fills the buffer exactly is legal. bzip2 allows it too:
> > its decompressor bounds a block at 100000 * blockSize100k and checks
> > that limit per byte appended. Use > instead of >=3D.
> >
> > bzip2's encoder stops filling a block 19 bytes early, so nothing it
> > produces ever reaches the limit and the bug stays hidden. Compressors
> > that use the full block size do reach it: an lbzip2 -9 image whose bloc=
k
> > ends on a run fails to decode, and a self-extracting kernel built that
> > way does not boot.
> >
> > This code came from busybox, which fixed the same line in 2013 in commi=
t
> > 932e233a491b ("bunzip2: fix off-by-one check").
> >
> >
> > ...
> >
> > -                     if (dbufCount+t >=3D dbufSize)
> > +                     if (dbufCount+t > dbufSize)
>
> Sashiko thinks there's also a potential overflow here which could be
> addressed in this patch.
>
>         https://sashiko.dev/#/patchset/20260912-b4-bunzip2-blocksize-fix-=
v1-1-c7384bbfc954@gmail.com

What's the appropriate flow to/from busybox (from which this code
originates)? Apparently we don't sync from busybox, but do we want to
avoid divergences?
