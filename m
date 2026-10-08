Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD347D930
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497818; cv=pass; b=AV5ljuGSXHk/+Nd7XH4MsZr9t/y+hZhqtLy7tHrvV2V1q4ZKvT2ZKQGCMTvdJOZCnxzCD9f2ifm7uzGHP8KftX3pWj2WzhAJAxeFD6EU+mPWypOOZbFMajGEalYlHZ9EXUzmFQ7NFI3yWTqyBf6MzhNfr6DEC77ch1wew1nHAzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497818; c=relaxed/simple;
	bh=hRz2Up5ISD2OXp/YSfpaI4bBnwMkonIsXu4OzAHa+tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbYLeEf1PZ0jzwCrzK1FUAY9CyL5B9wz4kprG/jSaHC+zZHdJE6B1aumedlCqAImbw7iZE3dyAz1DasZ1SsvMxQDw7rYHB7pL9/QGV60rRNpxnBARUi6hBeTiE8JbDvUoDVZOMhLuEW9E97yYJrQBTwJTcGwMekpZnjeVXDZLkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gVcDmcFd; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gVcDmcFd"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-351f7a0b13bso710321eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 15:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791497817; cv=none;
        d=google.com; s=arc-20260327;
        b=dkaYcr3d24zuzKZrl0kEeJ0BOH2FPj7keOyUn9zfspjW71fWbB8g0hccY/xKkcdZ0L
         bXQxJh5cRFT5VGr/4Z4/+RdlJqnx0ignR3gjJjcqdbvcGhTbz+Ia2m8POHmdjQxeKSxf
         lvyx6ksfs9grLS9f8ah3TrsSmZ7090WcLLXKxOOk4m0yjVGaPz2f6Sc2hIu5bt24bbdL
         yPTajs+QWPo5eW4F4bF8BVgMD6dNYWzgyaD+nVm/ZIxZz5QFDp+FFW8H7amb53veUQR1
         8A1OqJglEp2gT6+7LOhyfGGiMffgxS8f/fCTYQKx5tc+3NakonVv1gpo835Uh0zRl7r/
         zmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        fh=12BkKAT5WSpRnIEOzAHZtaxvTN2E6tLsFUbRU9pz2K4=;
        b=p8LV+FNGK9CsTdJIOJanht1jDpuUlko12I1s7L3C/1vG57DpAGdLkRsPW7Su35LZbe
         gb9n91L2io0flQRl9HPgY+Zm5Ex1nCFFk7JhCY6pcXD7tkMWi7QcDw751Umf/KqF4Ko0
         Baa2TbqZZv3EyucVYQzdEHmU4YR2reeEgomePc+FV7wZ1LdJ2aT4nA9LpAEM6ltxxOlY
         +aD98gAELv644/nmdD9DtNV+FEUqwCbQfROkFNf/MHxbSqf6B0MR2Cx+A6RpTrUuMcc3
         XLfRRsyYaPWsVPPD+FRc+gRNYSvQdIKVewwosZLWaOys09OYsNvr+lXkc0b1Dl3M8uHq
         3CYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791497817; x=1792102617; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        b=gVcDmcFd0mcmAwWE0aet7pLllHwOmQURXOTcNwRkBJTOd4yH3kQoNhaZnzHFyIVH1h
         jU8YcHev3kfsI2pZRJ7OTVaN3AeBo1ZeHBQvORQPqxbV5JvDbkb6s5Vfdpl0BnCT6mHC
         OmJxaRz7SqCB2bdkTOakmsm30buqE+7cLcUBBBAkyiKuZ2VF2BBhquL3oGGIAOiv2onM
         t0xvu3by5JmUWQsUAWtPreGq8CnK/WlhOzH5EOHmporIaU9qqzKmHuviGN9/Tu7/G1ev
         bV4sjWz7vGw1Y98BylCeTgtmLmISeE8SCJCMn2hatOYg/zPgDdTiKcqiE54sb8IntrH6
         uURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497817; x=1792102617;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        b=YUQWuZd1deV/f2guUCtge/PcylI3Y6ER6cowXC1OfdIrAt++bMsH8CjTydcQuLigVr
         CRtFj+dFBkJa11lz+cF181CBG6TxzMbfxSXEYuifafVlTtk0eAk06kIZuNgzIQp0pNEk
         aKuIgUkNyrNeAEBQVvewbxdN2vqwZFzY79docxvmEK79abGg3Ijn6kaILjmBRE/p8UG8
         md90xD14J+NvHdcoBxk4RcO0+0DRcs9I1SKWwlQ4JFQv90UhsTRpbTgvOBIzhXeQmTW9
         OMMZpdvOKcecZA0Mz1Y3rAw+A7b11t9aep5rh6g83f5Sfva9DLsvT8V2IRIeo25DK7cE
         a2wA==
X-Forwarded-Encrypted: i=1; AKwUvBwao7aCR81QIsWPSTOqqIkTBIUOpz4DMxFWG/V0rZrQ0apfqcg91SkNkk7Gh1v8uXuvwdZBhf0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPGcDu13xlYjR8CyRQok5qWg//xS0JxiKQWGxfjYd9bmPPPjIS
	xPJzUOSRNMdrL4BnHzVSYW6BeTggKleH9jVwsT1mMuZmSAdwJfs/jEYO0qN8p4NTDd7KMyZ3207
	kj10v062plXRGFPhJO+8wFT0B061EF5mRVRmRJ42kRg==
X-Gm-Gg: AYBFou2TQe4W+f8G/lN7GIFFITVaDs5TBQGUX1ZTgOBPucsa6rip146Oexfk8uTE+Fw
	KOYI/Wop2eU8QRmRoVAcbVR7vtrdXGwo41LGYzV8uJlz0aurxpXth5JvqfEwMb4N9LCcq9awCDD
	b+aZut1mMaBY8iEj8v2SbNcYBLPgll+1cP9l2vjMDkBSMi+PllWBhhXRMLqSKHm1g1PbI+VRlgu
	BzkFCIOGstd0WJSXREkS5gFluqnMfK7HhfT4ye4fGVMBUR+0uHH85h97EbuAHzXLhtL/CWMKMGF
	GIW1kIbNcBFCaPN2kjs5Ht8j2oTYd07fVfL2GX8xogMk7nvtivKivgc=
X-Received: by 2002:a05:7300:c389:b0:34e:2150:e5a4 with SMTP id
 5a478bee46e88-3536c58dbf2mr892218eec.16.1791497816699; Thu, 08 Oct 2026
 15:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai>
In-Reply-To: <20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai>
From: Siddarth Chilukuri <siddarth@nexthop.ai>
Date: Thu, 8 Oct 2026 15:16:44 -0700
X-Gm-Features: AclHuK-e4AvKn1DVj6sz0TdknScpn3tml46-rFF4J0_u7LxyuEEllK9h95XoXnw
Message-ID: <CABAykkvoTxq=mDvpfUnN3H0O9oX-8D+DhWi9SqzrW0f7kRSFDg@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: NACK the last byte of an SMBus block read
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2026 at 9:02 AM Abdurrahman Hussain
<abdurrahman@nexthop.ai> wrote:
> +                     if (tail == 1) {
> +                             u8 cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
> +
> +                             xiic_setreg8(i2c, XIIC_CR_REG_OFFSET,
> +                                          cr | XIIC_CR_NO_ACK_MASK);
> +                             rfd_set = 0;
> +                     } else {
> +                             rfd_set = tail - 2;
> +                     }

Thanks for chasing this down!

Small nit: it looks like the tail == 1 branch can't be reached. The
padded branch above already takes 1 + rxmsg_len + pec_len <
SMBUS_BLOCK_READ_MIN_LEN (i.e. tail <= 1), so this else branch only
sees tail >= 2. It could just be:

        rfd_set = rxmsg_len + pec_len - 2;

With that:

Reviewed-by: Siddarth Chilukuri <siddarth@nexthop.ai>

Thanks,
Siddarth
