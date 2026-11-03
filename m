Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793746143;
	b=3u+NHYG2yqOpSz+rfH2pDT/LB3nyRLlx/EBq9Hx1mjx3tblvvr/gQ07l7UCAxjF3YpNZ
	 fJgXReCUK3S1sQDFtrgEirtSvCbZ92edS2VU9stYix6+vXx/dXq/e14jqahvgSWR0lJH7
	 aePTPLN6dFc2aPTprh761sqk5vzxepvgPCm3xi8MQsl0XH6E+mAuZbgN4s7RBAtmhyYpE
	 +vkmSwrFJ63F/Cr8W0jLjvpp5wLAO6Gf3VtJ/eUxaVZjkLCl2/V0Ex3wjAX7sebkfLWtw
	 jU4xH8bvhOF1p4qfTPb/JFceGH48kT3qQbGai5jwgKd0jMiu7bf0PA3xVQj5cxFNcAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KjsO2xbI1+nan0ew9bz1EKvcLMTzPy170fWQbRpKB9M=;
	b=I9yFnwbDLc8jQPTCezJ2M4MnzniIkbwOhoncCX07M6pwI9749bw74uWGR6MIIB8fCQ67
	 +vKEehc7WpJWxpAj88w9H1b44xJvz17DHn1FehAqlVUURJ6LILDRZU+snijjNedfhSaKC
	 1BsDcCxOZv7fho1e0aZzpvbUJaCbBdsT2syylerx4sSBugfChUIy2e0mtX/nzoNbbXvU8
	 HR8ii47qaf3nuwyobH27MxTwXYQjb7bXWLEbcgBAnvlVgw5/CRsfWfsSsPyEi+kCGFdEs
	 6fXZmrLv88PYqstr/7AZ3VvPjdDtxWBL1gaKahSXhNgsvucOAVjSeH2OW+OaXrF66Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZXpytd8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0E9606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZXpytd8
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab37e44643so966067b3.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793746142; cv=none;
        d=google.com; s=arc-20260327;
        b=qhJR+PLHrHlgJ5xm7JBRUiH+t28qyXWWsZIb3s4J/xKZJKoH2tPW7nrA1R4sFf1ANq
         Ch4+IhX8JqD1Ji7LKOxzG6IryqJ3BrjJnxC2+ApJgHVay4H41UGDxtIoKHhuyyOj9IE6
         dbpKRtVM3j/tjsaVz4xSPmHS21V9WtIrObECIL9CJTpQcp7c/rrQlx2NYVRpfsn+X7iG
         H2Ak/nZZ6dr0gL4UppcTc6sdBZZrn/kx6mTrI2S0JUDxl/xok27KACUJ2SafHlfAd7gu
         oJgbckCV9mGHVwBFPMiqcuP+f3cLHEzLQqX31CnDHEM4lUm1XMdiDolcyKCjPTO9TcFD
         hCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KjsO2xbI1+nan0ew9bz1EKvcLMTzPy170fWQbRpKB9M=;
        fh=BAtAgqNrw/wl9UROBF7x9eXdOqfZK4XwWAXjUeR+P2Q=;
        b=e6MXi9m8mCf7PvGM8TvkZWflQBKwR34t9QWoa4hy51iJW1SxfAuJ4q4E6otMiOircl
         iu6Kcnq3ptUEtR6oQkxI27ZHwXVmBlpLCQMCMd6gD0INsjLaPNxmcbTLGL1pJgFstRvb
         HglwYi3OyNvifinY6iZwkw2P5mgaV+eL4GHZUpA9cwww8RCso1dx6UD75kAIKfFlKXk1
         RtYB/eK6r98Woy5utRtdpKjZw5nZ4l5WdFg2C7lyVo+QgxVBv+7000S3sDMF/nLFMtYH
         kwug9MrSv/vLnkOc4QpHanHhE+rQ7xTirUapcr9cQxw994DN/+Ai2o4TaYm3gUVbsI+w
         GbbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746142; x=1794350942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjsO2xbI1+nan0ew9bz1EKvcLMTzPy170fWQbRpKB9M=;
        b=CZXpytd82N+GyyopJIgKJr2BdzKJ/NFxXhBg1NBKxHgCJwb4CGKc4PqEBOzKqRuX54
         LKDmdM9OEQQ2C/zoX7/gHYbCueFW6ANoy4cK4O2vXwCfWfmpnGz0C2bcs0xXAEfmsY9+
         +2rGrC3aL9wBy+1QFWzgBlBAXhUdEzYAAw6opZH8WSxD7cudjVkq+/RomwHbjl9JK1jg
         kRH32f+YDo3jdJQMgJ2ntNv+E/ME2cZnKLFLRivYq3QMgwN3T5qZBj7ZiBItzZ/Kst6H
         zntLBvINH7WK+LpY3TNnSWtTIFSMB+7DGJXT7Sn1gtDaHq0O8jiDCx5/XyssfhMp0rAn
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746142; x=1794350942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KjsO2xbI1+nan0ew9bz1EKvcLMTzPy170fWQbRpKB9M=;
        b=tTHbXJO72glnZAT4qP4As2qYJ2Bmu65kOE1gRYuy5zgAqnuzLef5H7ujNAjl2lXRda
         5seEijTPYBhFGFjYX8972Yyg3GsaG1Upr3g60fxp+i3zUM1E9prvxTe+pbZZWpyAOFwB
         hxX9qjDxB5tXpGAibJPZyTCBdIOyMOn+LYld0GJfFbW9wi1L23cUnZ8PXQz7tZ2g5b3U
         bJyHIcWifF8PX8QZ9mCWEVaXNmFxVs1epDfodvaDlNzmLuBVMw500QI8gW5ywzXeV1iR
         UtnO7hCr9L87L/C9H/fiFJOib9TPe6uZyRjJvROuo8XPKeeuZ8Rn9RNnt44+xTKyjXgY
         MVeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWH6GtxxiBy7bk8sjfggZmkiPt0LgKrLDls210aKQQsPbDIONGAxonFj5CGBsyqJ44986GN54=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kwCGH2q02bAkVmT1xwOqF0FeJpnKzZmcDbVcymwF5comafxWK
	z0bQtg6w03VCsxAAa9MK9HtIVvNw34fKrANXy7bMfyLGdpraUwrTi1xHYwhyC3U1vMZ+eXVMP5S
	cG7NhJI7jKCAxOxm+nHD3PAVborZeug0=
X-Gm-Gg: AYBFou36t5BqqMR9sW7qX5XtKr3YjGJ+wGgSSv3sxjnRADjzxymzXqc6sOX4t14o9mm
	2gR6jzut/Y6CsZtjbBfEWcbHq0AbGxo0drDp41amQ80atjWzJh/PFwHhzuFOZYtd266WYwqQbf2
	zncsWlSaYwQ2zIVUm3PmlHBm610tAj9FPX32GyvFgt/r1P32HAO/qdlEgYEwEHVh8UsHjpd3QE6
	7MsMZcmn1HoX7ucOMSkJjRvB3NSoowRWsa5K39V6LoL2Zo8J4j00NIEH9I8Jh1jwhHodYLzFpUx
	/fqkZgSv8HAmtp9GidkpunK3i1CUSra5WnIq9QzjPkKspuzVaEj6QgAW8iP9m5aZligu2Jao2MA
	j+e4EotrQilkMo2CX3FiIbzUwKsa8lR3DxeDg7sQeW/rtjuJNrPCVRq+brqiHsvSjXvcLyXpMxK
	v0fqnkncU3pnADJs0BfZme3jUShPQm5biNKFBV/j0448fewZxlgzkTwCs/IP8wDu3zwj2vsiK4K
	N3Yv/Rd
X-Received: by 2002:a05:690c:f93:b0:89f:4c20:73ca with SMTP id
 00721157ae682-8b2b671f0f7mr94194447b3.46.1793746141623; Tue, 03 Nov 2026
 14:49:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102201410.55089-1-sidchintamaneni@gmail.com>
 <2026-11-03-1-daily-reply-0011-re-smb-busy-dentry-dio@kernel.org>
 <CAE5sdEi4GOXeVDPEUk-RR7bjE8z=25f+waQNedMQd6VCum3TrQ@mail.gmail.com> <7bd9007e90f271821114f617fda2c1ee@manguebit.org>
In-Reply-To: <7bd9007e90f271821114f617fda2c1ee@manguebit.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 3 Nov 2026 14:48:50 -0800
X-Gm-Features: AclHuK9F4A_hrgFEV-uV0gf-kgj7qpX4biDiSW1s2drGmroNJJVSplQURRyCVRY
Message-ID: <CAE5sdEhCOuK=UK1y-25rRZwj_Ub0Bd8jETKm-VuiYtceGAJv-A@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] smb: client: fix busy dentry warning on unmount
 after DIO
To: Paulo Alcantara <pc@manguebit.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	wozizhi@huawei.com, lsahlber@redhat.com, sprasad@microsoft.com, 
	tom@talpey.com, glaming@microsoft.com, linux-cifs@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 14:30, Paulo Alcantara <pc@manguebit.org> wrote:
>
> Siddharth Chintamaneni <sidchintamaneni@gmail.com> writes:
>
> > On Tue, 3 Nov 2026 at 06:52, Sasha Levin <sashal@kernel.org> wrote:
> >>
> >> > commit 75f5c412fa867efa0bf9b646bffe0d912109e84a upstream.
> >> >
> >> > Kernel 6.6 predates the netfs I/O request conversion and instead splits
> >> > I/O across three reference-counted structures that each hold a
> >> > cifsFileInfo reference
> >>
> >> This is a hand-written 6.6 adaptation of 75f5c412fa86 ("smb: client: fix busy
> >> dentry warning on unmount after DIO") rather than a cherry-pick, so I need an
> >> ack from a cifs maintainer (Steve French or Paulo Alcantara) on the list before
> >> queueing it. 6.1 also has 340cea84f691 and the same bug; please send a 6.1
> >> variant too.
> >>

Don't mean to dodge your request. I'll work on it.

> >
> > CC'ing Paulo Alcantara's correct email for review. Thanks!
>
> LGTM.
>
> Acked-by: Paulo Alcantara <pc@manguebit.org>

Thanks!
