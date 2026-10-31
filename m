Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457155;
	b=uo03Pbf7zwKP4nLaczax4OXgaddNnvfFIakgCJwMvqy9TDELIMqZemYo+TX5yUMc1fsN
	 vSRZW+8NQUuEjY6hW/fEMC4Ag2yGr2Dg1YrE4uiPCvgs5kK4fWtCCqzK0fhAjT0rZgKpa
	 9flr9/nk+WzHQDFCEDxz5ABGfQFBDHE+nzj4DAYBi9YEwrQ+5jUUSbNPR3bLmN2SPWcku
	 0HXc/CmajcPi0Ch26Bee5eCSD6HoEeaovLMlCmj+mEvJywU389+0372xq7ZQvOaFURS9Y
	 nM8KDKMe7jFaeMxllqGcC0faNkleaATdZDALTaKllxSayVD2kf1y9dKXv4onLGbVY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
	b=qJ4fVSPu7E6pe+N53p0F4QcLrPBUypr6eNlXsDQZ+uBeMx04p1N067QF2Z2ZPUT3bvsW
	 Ezp7C75RQ3HFdAqkzFpsNl39CzOBWY/GYusfBc8P7e8OTiSw6yfNRZZE7VlrCWiAVCtat
	 Ji7yq/eAT0kDJi6wL3yYTS8u9BdrPw9pDs1HMz2D6LTJ/x/ZDAsN6bfgquEcHw5SPH4A7
	 AfPTfamyxE8a+HY1HPkMsYuFNuTMomyCUr1LBmE/GDpRTnjREiSDuOOu72aqxtvA+fWmN
	 sOHJD/MT4PbTZf29gqwKaYYXxSuigZqxOjoIhblB1PpieRwETP/81ZQw6rAcvtrOdfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHoaVHww;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498F606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4498F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHoaVHww
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74ab99038afso1112210137.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793457153; x=1794061953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
        b=SHoaVHwwlG7gC4I6IU2I7XHJrFCgo03jFrPHmqa9nlpLPRliO7uPAoMT9o7gbaVCa9
         Kbc+ui+2BiWx0nC3hN8bVuEFR17ckv0Jm6lcSzU970L5mY/ydJhr2izHw0RMmxsiZZdz
         YNnolrWDcr2jN6blXYMV14gGnes9jUhE21BvmZEo5IBo+MlqXVXMd42quJf+Wf6CHjFx
         Ap/OcRSm7eEm/2TLTM8KdLsSDeojOSF9tyRkyKEiMtKTzpan3ojXUlh4ufO+yb6p6lAK
         88fdOYAi9cf740slUVYVmwlhovozfFEznOEHIjvU5gyuvqbbtiujiPwU5yABQ168hKD7
         IYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793457153; x=1794061953;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
        b=Mb6k+wP9mb7k4r7jKzPx+codLfOT7kX1OBGIj10poM67beKMBCLcpZlPUW3gYxKMF5
         TPJrL8Qh6IcDg3TS6uj5zJDtAdDPq0iOC3DDK5kIiGpDhFNxYJ/ZVr7tnQwaFZ+ptVOI
         TGKiEeN99qyFikAAs2ZJz2YcN9Vayt4xGnSOIxv85vWiq0sPfvlO9Na0RmhPYy/q0+EA
         JXhxi/D8YPO/Y66jimXrY45hTjTV+DsVmnu+klH5/yQCMYM5va1WDNw496ffvpCgyAPU
         A1TKf/vqt/mpvu98xBVTY2KXd8MszKhH8q2z7pl3aYd1Gk+3t8KVwxd929p22f8G2/C/
         ciaw==
X-Forwarded-Encrypted: i=1; AKwUvByaL0EafHDVn2gP0Rl6MfK3dVqVAzHNd+DoyVMXU1lx/d79QO+2fCE66PZePFz3+1WNrTZ3tkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPMe9/DFtMMoX45povUFch8jleEFY8xfk+l9Uxc2wVCb0Hrur0
	ccYvb/bn6nzLv1J3V5+GiqUn7eOAgOWucf3f56lJMmI9w/SKSuCfwZxa
X-Gm-Gg: AYBFou0jZaIRQpDoEaZhxAPAsdNODjGIVEj4EpzlFiWqLLZ1R0cY80F350K6cMGbEse
	U8B2cAm+wM0uPBNp9CA8ZPUFByOHKzXW8fw9C1sAUQZGj9wdwbcaR3Fi+xfI+Do6QEVuBMhp4Aw
	aA+pXtGkpSdSUYpzzxFoBZ4JEUrA92OdOtyXaBtTuGQ6YRz/udW1lj3zRGzRyTCmSA4T88MBhrp
	9h5BqWasvICpH4IcPBFCBOoJeQWfocbxZNpL8TmxtIHrAjxPff2gFRt0XEo0NEXkgq9hgEgqQDD
	pN8LcDNtCuNyTS6VAvuFSiRQwxot31bmppIgN2T8kb8Jf0wBMpFoQMMKYx7z+WjZmQ9zcPkpTKE
	yZTAVIjMstiMm2YIuv4dsGdK/ZB7zha8Z7cERxfMwB1B1keBJlyUF1W0qEUWOj7qhseGTrGacwV
	+hQ6O2srHq/hCb+fhU/uguCFR6jsSy/fuNszFw/3aQxnjPSts2iOYWdW65AYsDjl4EX3boFKa/u
	xuOfUEr6L9OhzNkaksOsQJJcZ57mAG3+lp5d6Gesdf/ePSE9lsaW8GftKTmickQsn2wlFuW3B5c
	IyFkj7aJdGjaHo5fiFDPTxgQ2phIECKbqsObsqW9jOq311gFwO4Sp43rmdD1wRPj7EjAJeZjxZX
	0jkgNXKoVJQ6Amn0dG58+ho9lN/8BWRE/Y7Wb0GUuR20p1mGYVPqEtZYDT+lqdREKP+0q
X-Received: by 2002:a05:6102:14a3:b0:7a4:e550:eeb9 with SMTP id ada2fe7eead31-7d072710407mr2530458137.22.1793457153130;
        Sat, 31 Oct 2026 07:32:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d077606b7asm5562013137.8.2026.10.31.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:32:31 -0700 (PDT)
Date: Sat, 31 Oct 2026 10:32:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bo cao <treebacker@foxmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 edumazet@kernel.org, 
 idosch@nvidia.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.22a3131380a8c@gmail.com>
In-Reply-To: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
References: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
Subject: Re: [PATCH net v3] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

bo cao wrote:
> The second half of the MTU guard in __ip6_append_data() has been dead
> code since the initial git import:
> 
> 	if (mtu <= fragheaderlen ||
> 	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> 		goto emsgsize;
> 
> (x & ~7) is unsigned and >= 0, and fragheaderlen is at least
> sizeof(struct ipv6hdr) = 40 > sizeof(struct frag_hdr) = 8, so the
> second condition can never be true.
> 
> For mtu - fragheaderlen in [1,7], (x & ~7) == 0, so
> 
> 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8
> 
> underflows below fragheaderlen.  Every later bound computed as
> maxfraglen - fragheaderlen then wraps to 0xfffffff8, in particular the
> datalen clamp inside the fragment loop, which never fires and lets
> fraglen = datalen + fragheaderlen escape the MTU constraint.
> 
> With MSG_MORE on an egress device without NETIF_F_SG, alloclen = mtu
> while skb_put() is called with the unclamped fraglen, so a single
> sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg and
> IPV6_MTU = fragheaderlen + 1 triggers:
> 
>   skbuff: skb_over_panic: len:61280 put:61280 ...
>   kernel BUG at net/core/skbuff.c
>   skb_put __ip6_append_data ip6_append_data rawv6_sendmsg
> 
> The same re-lowering exists with a transport-mode xfrm bundle: ESP/AH
> bytes counted in rt->dst.header_len are not part of fragheaderlen
> (ESP lacks XFRM_TYPE_NON_FRAGMENT), and ip6_append_data_mtu()
> subtracts dst.header_len from mtu for the first fragment, so after
> the entry guard passes, the recomputed maxfraglen can be pushed below
> fragheaderlen the same way.
> 
> Replace the dead expression with a single check that requires room
> for at least one 8-octet payload block after the fragment header,
> matching the minimum ip6_fragment() already enforces:
> 
> 	reserved_headerlen = fragheaderlen;
> 	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
> 		reserved_headerlen += rt->dst.header_len;
> 
> 	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
> 		goto emsgsize;
> 
> For the transport-mode xfrm case, pre-reserving dst.header_len in the
> entry check makes the later ip6_append_data_mtu() recompute safe: the
> subtracted mtu still satisfies the same minimum, so the recomputed
> maxfraglen cannot drop below fragheaderlen either.  The check runs
> before any zerocopy uarg is allocated, so the emsgsize path needs no
> cleanup.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
> Changes in v3: collapse the fix into the entry check of
> __ip6_append_data() and leave ip6_append_data_mtu() unchanged, as
> suggested in review of v2; this also removes the emsgsize cleanup
> hazard for the zerocopy uarg and the separate maxfraglen check.
> ---
>  net/ipv6/ip6_output.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..936dad85f1c9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1477,7 +1477,7 @@ static int __ip6_append_data(struct sock *sk,
>  	bool paged, hold_tskey = false, extra_uref = false;
>  	struct ipv6_txoptions *opt = v6_cork->opt;
>  	int csummode = CHECKSUM_NONE;
> -	unsigned int maxnonfragsize, headersize;
> +	unsigned int maxnonfragsize, headersize, reserved_headerlen;
>  	unsigned int wmem_alloc_delta = 0;
>  
>  	skb = skb_peek_tail(queue);
> @@ -1499,8 +1499,11 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>  
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	reserved_headerlen = fragheaderlen;
> +	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
> +		reserved_headerlen += rt->dst.header_len;

    ip6_fragment() only enforces `mtu >= hlen + sizeof(struct frag_hdr) + 8`
    once `skb->len > mtu`. Checking it unconditionally here rejects valid
    unfragmented datagrams that fit within `mtu` and never carry a fragment
    header (even with IPV6_DONTFRAG set)

    Placing this before the `v6_cork->dontfrag` check below also skips
    ipv6_local_rxpmtu() when `dontfrag` is set and the payload exceeds `mtu`
    while `mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8`.

    If this guard is moved below the `dontfrag` / `maxnonfragsize` checks and
    gated on fragmentation actually being needed (`reserved_headerlen +
    cork->length + length > mtu`), `reserved_headerlen` should also include
    `rt->dst.header_len` regardless of `!skb`, so a subsequent corked append
    (`skb != NULL`) that pushes an initially unfragmented datagram past `mtu`
    still accounts for the first fragment's xfrm header space.

> +
> +	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
>  		goto emsgsize;

