Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447081;
	b=OjxFVJ6NPP6R8FRBz6i/jUD+XgotgmMSDcPnJCdvEtXX747NBT/CADfiqbPBsgvG0NbT
	 7jH+Cgjm8xOJW6hKM2X3tJUO7u6S3ZJHaMiBJs+EPciEYGWNFvit+d41NQA0Ro6ZROzy2
	 LjLrFX7sTdJssXKX7ermiZmo9jXG6EfE9wSnKxqw0QRPsS15tnvuIMKFnE/hLG9NqZJkl
	 GY+Ts1LH6fE64qY2halXlrTkQc47xM5YsH2bMtjbRPXXxWzWtDd+XfnrBWMJJhmxrjICN
	 3DDNK/QNBbXY3aj75c45nfIzP27cWU746acwsvzVWOMV4cJ/vgL5IVEI4KaiXIGEgUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447081;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=tbAelE0MgrzBlqY6meyYnUeXwzPQQ8o74J39xWeGzMI=;
	b=rZT7gzTxTbTVN0ah4oNFNh6vxHD5K/Mwo9L6y903ML7jIAnqIIFZbs5bPn0ZUm8cFGhf
	 fooIhYbCtd8PiYeL21+d8Jc7KRW5OIQ17ZUJeDtvc4i80a+aH0W4N7ymWCJZr4z0itsmw
	 +oiOeYzGHE3rTCKKAKAduqOuKKW8nj/4Hooc7rz+vQfdzQqG3yNOeDhcyElO/7WOJTkxG
	 lm1tCaL9Ujxcqj15wO/PX0NRNEV+lrNWiRxN6/6T4qCTDR0E95rWW2b3OulaygtxV/QVv
	 fHWwLy58Gt6C07GnRHI/v0eTy/Rg2vb0sbCnAaJ6du6eWBpZZ+OzQBhbyvZBEQijD4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAX1KQf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4279606A333
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAX1KQf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA301F00A07
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447080;
	bh=tbAelE0MgrzBlqY6meyYnUeXwzPQQ8o74J39xWeGzMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cAX1KQf1Rzsl3baWjSeoL9KqFkTL1LmLNbp0E7qvwOM0SZG/F5dkudx/fNzxgDuMK
	 GK/I7Yw6HwlPiQQsj3ellpPk3FiAvNUAb+8kNfBwSkPOvSIjKy+Eicot9YEg0s3OPO
	 3c68Ud/AcuoSMRQcGVhTkxPtAYF2zG8Y855SXbuP6NE9e7yWaEK8/PxZniNNPDXHfl
	 HW5rJtHZoo3tPzKBs4DbPLKZbDYPi1BTOBK2pPoYbDVc0N7g/NJGX5L6VhpZ7W0WUK
	 TqwJBmB/5yyxNJJN/6g1OttGDgZ9sS/p46Mx1UFXCzfiPZW5xkagpHbky8bqUYNx71
	 YXOqfx3pBCcyw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso4143372e87.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:31:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEhF6Ef2DqtpwPo1lVJAV8K2UyKlV0O98qxfZZ8p6iTCTaZqsYxtGOfmLYJ25JOMAxcpyPIq3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R0O5OrSW6xOjFn56WUD/Z9loho6fxpTmADnjFyDAJuTgVP7d3
	B0iiaWmYTFlECxC4J22q1sNNmoN9YGA/Su8P6jjgqb0+olSWr8GsDlLqXQeswuWszXiOMqAlcv5
	lNJ4cmy2fmU1DzLPpX30Mv1tt+zUVsAk=
X-Received: by 2002:a05:6512:4011:b0:5c0:a57:2cc5 with SMTP id
 2adb3069b0e04-5c15d5459a1mr1246023e87.3.1794447079338; Wed, 11 Nov 2026
 17:31:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111033150.847104-1-kj2864@nyu.edu>
In-Reply-To: <20261111033150.847104-1-kj2864@nyu.edu>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 02:31:08 +0100
X-Gmail-Original-Message-ID: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
X-Gm-Features: AclHuK-2jkI_1P4f-3m0WBpZsZ-pjI-2oWTd2FJHzyQYsGPvJZ5SBMTR5ALOLsI
Message-ID: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
Subject: Re: [PATCH] ceph: Use unsigned types for snapshot split counts
To: Kaho Jiang <kj2864@nyu.edu>
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+408fcc361565713f@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kaho

Thanks for your patch.

The u32 change fixes the backwards move on 64-bit (I reproduced the
KASAN slab-out-of-bounds with injected split counts and it is gone with
this patch), but on 32-bit sizeof(u64) * num_split_inos is still a
32-bit size_t multiplication and wraps: 0xffffffe0 still moves p
backwards, and 0x20000000 leaves p in place while the split loop then
walks split_inos[] far past the front buffer.  Could you bound the
counts before advancing p instead, like b3bf89767e3c does for the snap
trace, e.g.

        ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);

for both arrays, and ceph_decode_skip_n() in the non-split branch?
Also, please rebase onto the current testing branch.
