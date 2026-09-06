Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5E17B425
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658365; cv=pass; b=MNXy9UzxRHKy7tUcsKzQh2bOjd5oqCKQBYb3/1dfnRdzKNDuYrfkGG75RLEr4mji1Va13ILyXlNjgOql38E1KQHpqXIU7I/2sUqYiTpnEC9utVdyUk0ff2E4xPYRGeLz4lIvmJ8mnlWNAuYqq6pia7SrhlWvF3pgAmiOE1YpjQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658365; c=relaxed/simple;
	bh=XkGisV3Evjj7Mvd+zTCV+TdTT1vDp/RPTN9iZlFQXP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdyAw1u9C/1G/swPlusSUJQnYkfnwfU22DA5fwc/KYbL1MCq4dQSDUdj3ve+11aGgNh7bWEdXsivne7RJ7U7ZUCpIoOpctv9RZh3oqMklsDs88KpoTKymziCZlfqNhI+GXIIEo3J3bSg1MzKtFGZWTIrXZS5vkdEecJyEWGW6zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hIsoI8dn; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hIsoI8dn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-86265451beeso840766b3a.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 18:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788658364; cv=none;
        d=google.com; s=arc-20260327;
        b=hKFJNHbur0RWgwZgJ8VCeVVHeSz8mSXSMQK5LIniufNfBAY+9J3KGZo5mywY8Kubwc
         UJA0MozXZQEar/BIT+V+h/3unvgHcdfemWt7Q6ED66+zfQL7pTOAKXa5owZeewY0uQWU
         iVnyOhfx1k5GcSK26opUocH7nO2XLo1fikSv6eE38sKZR4NqbVzjMz2J4eipoAJe85oZ
         c1tC3gEDwHWuev4fh6l+kUfTCv/XjveR2wuYu8fVC6xLP8MHPPsCmvoAeS+fGGMzWbnA
         BUexclLlnsxywgDKmnPJsSwlBHmy9nlEz+gCfCTXDRvq8b+5Wj2anGqQLsymSJXQ7U8Y
         WJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        fh=BOfgqumP+mkf9EEJyfa84i7uFeqoxLgXqPg9WRF+xLg=;
        b=BKgpyZ6fcksltbaULvaJw0ETApx7u0IHob5vuQxOxE8jiyFZIb2MDKUUA88NwTa9O0
         swjCDh1TtO+bSyXqJOVeVpwxkDWGc4QpuxksMeYs7GyZFn60sVcJOhvdbpTuRAZOwGMi
         aQ8lzXl7f9kiZDMViyiq3jAuGYPZq/pZHUQSXu3n1IsUc4lUQQDIroPkgEaLjFoRLFeP
         VNOFI4aQNCr7rCuXBudhabk3XjZ2ry0TqFKAR6fvKHBmcwf3bNENc2pZ5mnm/Ue2wVTl
         Kdym4egMWv7HPYADdZc38aYeSXfiksqxSxz8FzQ7Bynl4PaNCw0uivy8jXjzW+xydqTt
         0bwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788658364; x=1789263164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        b=hIsoI8dn3ooUJo2RoZBogUyaO4ghoK7cpiIxKv+qbMk2p3FE0hyf/WVGtAcTBmyCvT
         mKf3wmOGaWGy6vVRsIV64RifYQLC6cDyiWtbHw/QLc+YSDrrPHg1XKJ63BVjsSPzk8jf
         nuBYQ4mO3AraaXSKMw6RemPLy+s5fNdjVkueakCX+nhF46YxNWoDjbKf+BEm0PIBycYf
         ipbRUF9DIDLbWXgVO/i83JEfytBscS5QeDTwJnIkQ8mgq77qMvqAXLF9XBdQUlCc0UgQ
         TX7REpZqU1Z3BQUpAdkSXkktOfsrMJOK5wr81oCTDrclTfUSpQX3S+UY7nR+RtIILsI8
         urFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788658364; x=1789263164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        b=q8zl/5D8ijnJnXH96AAacc7KJ7+4XpwHbSP1KamerMgRl33LUoqMGxGyt6aZHyLNac
         K1SKRErjPrP430/rHE2N0AEFMphKibpRdwYiqHlX3XofaW1SSG9ataJC7QWJXjeSByaE
         V+8JGeKCFZS9C9IedBnFBgeAwb84xWYQtkCrAzbH5xzS2UqBjzAO0zf4B7j1BJPHE8nu
         PK6Aty+/mk52tkdO/HZw791JjsuLQ5X0VD/aGomSW89yxGQCrrDas6Bb/xXOX442YNul
         xFgW/NLD1JfkdHvdJ77L3F9TtKZkwppq8PXOQ6mqg1X1hs12mtCguTTQgPYbB+vgXjEe
         NUYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ3bpYqCXDD34lcEgYDrSn9wETlMwgMcY+aBAee26dXO9P2UlAGRIi0nliGX4l0tZpOHiNX9w=@vger.kernel.org
X-Gm-Message-State: AFuF++n7rLjnpRFK+1yW7N8VzsqtBdwVoFqBlRyy15aoNXjjQ3JEWbAC
	E9O/N9gsmO3UCIzD+C2cO0rHE2GUJLh7JP8sXTR5zil2noTUsyO95GVFXFrKbuA77v9tNO970JW
	/hgyCaufM5rKPNHzXAioXZq377GMEk7rNdL7Toy2B
X-Gm-Gg: AYBFou2c2nuPqJMgO0NlqvxXyF1fnR65xDNOh4gwjWa+D7WVMfikrxe+eG3SN+y5cf4
	cKj5blvhnujfyEaST1fRXtehyybnz0o8247A4t1fTJyK0AkybQ9mSm27VGN9aX+QnVQz04zA2OO
	gVXS3J5KnDeNxHWUdod0EWkJ6nAx9vdCYzNYDWe2AO+79IB5iojChB8Q/UCCh10I998pCu9CRHU
	9ur0WNWY1Dsx7etzW5rhzkP+L/mvu4vv+DKW04WTuDnMzURlE3E7qzAUIM/EWH4CEep4wjmu+eR
	bl0AiEllwFCIWgfEC8+Z2tltrQEm4ZYblfzqq+hd9KivZ9tI2fQefZ9PCiIlQtlc75xOg0XiWE6
	3yILQABjjjA==
X-Received: by 2002:a05:6a00:2c94:b0:857:727c:a1f2 with SMTP id
 d2e1a72fcca58-8616907f6e9mr21628645b3a.20.1788658363695; Sat, 05 Sep 2026
 18:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu> <20260727233706.218446-2-xmei5@asu.edu>
 <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
In-Reply-To: <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 5 Sep 2026 18:32:32 -0700
X-Gm-Features: AcwNN1UPXRzFZw8ZZGT_UcW_OJxAT5DgOQb9MbK7fu1zShy4ZYp6C_Z4xnhZ2ys
Message-ID: <CAPpSM+RgWtmFLUAMfCvCg0ek0z-fSLAjr-eCVYivv0z5tKNVxQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fuse: bound io-uring payload copies to the
 registered buffer size
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:28=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:
>
> > Store the registered payload length (payload->iov_len) in the ring entr=
y
> > and use it for the import and both bounds checks, so the buffer the
> > server provided is honoured and an oversized reply/request is rejected
> > (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> > fuse_dev_do_read()) instead of panicking.
>
> Can you please update this on latest fuse.git#for-next?  It looks like
> some of the checks are already added by Joanne's patches.
>
Thanks for your help merging 1/3. I checked the latest version finding
there is some changes to these functions but the check is still
missing and we can still trigger the bug so I rebased the fix and
dropped the review-by tag. V6 has been sent for your review:

https://lore.kernel.org/fuse-devel/20260906012924.1928316-1-xmei5@asu.edu/T=
/#t

Thanks,
Xiang

> Thanks,
> Miklos
