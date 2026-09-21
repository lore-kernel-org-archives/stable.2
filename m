Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188563E49CC
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028480; cv=none; b=hnxSxitVON+ZAbr2UnPzy6jR45pdHbkKvtjENpvwYvjd7Fiqlr2ps/EcmYPSoZSsm4DxzHdcE3jypUyB//d7KjZvRJ81VzbEocPEve0Vk8XJnvpfVF9NHRFLl3+gD0p2G2Sa5wp9DiQr4LyDJakaVKFcSvMv5aiYHvipEH6fFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028480; c=relaxed/simple;
	bh=ddn3hw42wG26XWdsFpmJBgiUOAHN1Wosbj+AD/5UoQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX4wH/ngv+rvDlir4u8Z/TKek88PK8LDV8NdK/5l99ZZQ5OUrU65astmeL1cXaqcxRaoqR4YtJ3Cd27FsJbXRsVb0QnU/ADDMO0MkzD64LUtaOLNAm9oRa1xYBNZseMdxthxMYZ9H77Ub0+QcNdgEFgBv1HuTkFHgX5KXyts0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5hdUmUp; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5hdUmUp"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so5303067a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790028477; x=1790633277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1pgNsBmK2/dFKUlz3XZGd+vlj9HEQ93howCfc/y5AE=;
        b=S5hdUmUpEolJFbB9H0nwC75SIF2fFegeM/odLBRgUfeB+/5iMrVZIffDL3DW83K9Np
         my9cLVhpyEZH3cvwaJj4Qqc/2hGOD/sPn8yxc5s3TVNA2JcqXjnNOyhxL56KRIpkOFuz
         G3tQsrEdO1StXys0UPjsIZPYJL0OXf3P6N08qXtL9uAxNOjjDtcngCd5UudGziraMP8E
         GjiGaKRLH0d9rlWzAf2jc0rVoaG3vCuFeoqhLO3usIrg6g+t9VbM6D3qOkZeLAMUgT2W
         QykGWtj8d7eZqn1BQQ1f1Rv6E9K/Bkj213yPD2iA3Zq0EhkdHBmC02JjMdIQjAczA5jl
         BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790028477; x=1790633277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1pgNsBmK2/dFKUlz3XZGd+vlj9HEQ93howCfc/y5AE=;
        b=OgDzqIu9fnpGKkIvKlWYnv9yuwKrp8+FN0gKbPR3giBQTQrrmcPHDjhh5W15vj8aJa
         xMK6KVkqu1Lino9F4Pmzwt/ewvO7LFng/C1Vom0VQwBtswgJlin7c0xTPLi0Sw8ZZ7Ek
         vhBS4IX5wo96KzyVaLx5bzE/1mF35VsPqvc25EkSXP3HhzNrCSqnFAk9G5sgsccaEov3
         Pgrb/N2BhD8jimiu06cevMGjDOa39RMwj4Y8i+YEmZIgf8endg/MSUyvq5MK+VLjni6I
         C68AyeC2SB5wK/ETpDOpbeigbhIBzfml3wxsGfjd7L8eQTPBgsxCSnViirawxZbzZT21
         lfNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyeVfMVfKYQQjQnrPdYn+6NrJKqGJb3PihJcwKI48gBNhmR57chpwug7bg0UxGP5/i9alkv7E=@vger.kernel.org
X-Gm-Message-State: AFuF++m6iHthVD78OoHBLHEYl8vWeL2DhrHS+1be+Xy9lZOfpPIzO/Bh
	f5to9DTEfZt8lqQYNX01q+qnzuD2eBj59py3n1SIFpxjg33FCE0yvQME
X-Gm-Gg: AYBFou3DI/J2hz+ET19L+MoXYC+c56/Z9ZAr0HDcrj+/on3WTJx47JixNzZiHCe4UyT
	Y8tx+JWFg1QUS2Gb1ex+j7j3gpVjZ3Gs5+EE3PhYPe9lMYonzyMK9/ItBWndJb3NcUCJYC56F33
	QXd/Pz1uSppRlgin4wkcVTWl5CqblMg1EgrnAd8Rme+swNm+dcKiuEHXLUG8tgvzcOtVLd8ajED
	Gblbhbnb+rXiQCEJPiZ7kZPQAvX/6Cu2nhBJS2zeX2hWUrQTOx6k2HUMSAEn2XB+dGIkMvFluvu
	3e0bjHN4hwIPaeiXr71I8rl+qOJIcByAMk1pxaqjfLTbRRtAFsEmsXkqVzVTN5tVH5f6Ii9g7/N
	xI82tUHfRy+F2XGBOoRlcFHcrww9uq6j8sysMH2n2uQ3JyBBv0PH2BK3wqJ4vPh3IwqZP7hLY1a
	b1O8vHb5SR/uf4nWnjZlsCb4JG3VwGV5Z06Ccz3lWt7LHXxxVIHjxIx9oDcs8l3pK+KIZRF7sbw
	b/vsCHOPXvEjlsfcs1OooDppVxNO4yM6o8Pf7UOUhEPTlKOkFzw
X-Received: by 2002:a05:6402:24c9:b0:6aa:2:97b5 with SMTP id 4fb4d7f45d1cf-6aa56890b40mr7853797a12.32.1790028477306;
        Mon, 21 Sep 2026 15:07:57 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:f474:15bf:74b7:bee4? ([2a02:a03f:a75e:9a00:f474:15bf:74b7:bee4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa0f7bfe8sm282195a12.2.2026.09.21.15.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 15:07:56 -0700 (PDT)
Message-ID: <6a083020-71d5-4302-8eef-af4c99d2ee81@gmail.com>
Date: Tue, 22 Sep 2026 00:07:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
To: Hui Peng <benquike@gmail.com>, Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, Simon Horman <horms@kernel.org>,
 David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <aq-E5MPYZS5s9_bk@fedora>
 <20260921044025.1535982-1-benquike@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 06:40, Hui Peng wrote:
> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> Switch SEG6_ATTR_DST in seg6_genl_policy to
> NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> validation rejects any attribute whose length is not exactly
> sizeof(struct in6_addr) with -ERANGE.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> uninitialized kernel heap memory (tun_src =
> 836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
>    sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
>    NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
>    length, as pointed out by Hangbin Liu.
> 
>   net/ipv6/seg6.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 62a7eb779202..8c2b156c227a 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
>   static struct genl_family seg6_genl_family;
>   
>   static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
> -	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
> -		.len = sizeof(struct in6_addr) },
> +	[SEG6_ATTR_DST]				=
> +		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[SEG6_ATTR_DSTLEN]			= { .type = NLA_S32, },
>   	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
>   	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
