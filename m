Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440052;
	b=koyMMRIXAKK8Z84lUhQeXWM84bLSfjQzJYLHqbrc0gOsqm/yJrbrmCT3lCCOPd3LTEhI
	 zSFHxjpY+qsRbsqngTRPmB2gp2N1Me5mwMAz29XeoMCCYc3RoxXeD4JccQYwLheZwXWN+
	 S57kqneyAnruyBZtIQtlCBtDu7qmYJ/D/7xsC0xLK0V8KbxG5+SGyLAk7giOIx9kFWLRd
	 ZVcvuEOgTWNl+eAaobMNFJBNTLwjMgwSrwnq3e3XVJe3aqiNCoUn3fQoUnvszacOvh0wX
	 ec/T/d12MFFkA5kzk3/I9lhlHzjeqzK6v/+GsE7MFOY6k7m7iRnHryIr8q8EUBgkRNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nQkJhOs7vzIhcJTG24G8BH/pwTyzsvnAwV9M0zA6cJk=;
	b=EF9sIuyoPbKQYWmdq/M+obgyd03lgMKDnpKsWnd5Yptzrj+5xoo+qictUjuXU6j8JMuS
	 rGYgmmdcpl6Rf45JDw5ogfiEawjCzyeE3mm3JMU3Rowsz905FV3rrIMdpFflI2vu6tLAU
	 mUYelnqyMfu8vHz+7KEIVzQmKuFyi8pGKEbIZXZHHWWnDXfbfDm0pmcPS4FnZJzRm/fjP
	 ggMf8XyvlnWt2YAOwJjEU+JVSNQRbCUT/aTjPqgIni/nNhQpVEITMbFEibvCH4FTLHEp7
	 m3gXzr2RyU/L2hwYqghBaEzRJMGitYSf9Ur9Yd+gVA7PzBLTU0yo1bCIZZBoZ3VK4Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dirbU1uV;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C3606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3C3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dirbU1uV
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50a4a2132cso461512566b.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440050; x=1796044850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQkJhOs7vzIhcJTG24G8BH/pwTyzsvnAwV9M0zA6cJk=;
        b=dirbU1uVg5XYaOLNs53rZEhqmiBZ/CARf2od0etpll4SmO5f7QaZ0/3zG0qKgtTjnG
         R6348TQ9464RhMhWmuw0QyPZooAwoBfor/MDsoFFQkPYtqp+g3fQVbSnScKFGSsT5ZWg
         rik85kKKtu/yQdPGauleEjV2J50e9ubejPI5wtkcEPJpyi1K5UjJMPP4r7MzbF512huD
         wKDL8/EZrESb1ECauFwmkW1ia5m8KZEu7vMWRbZZXOlBBbJN2zV5RrnqF2pll6nV/NxZ
         zvjAGjz5Z/9qtriSKjDuOjzHmx8/tWB7GxwiZx4f65IGcP5p3dkyU5YA4TAAtlnYwskA
         n+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440050; x=1796044850;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQkJhOs7vzIhcJTG24G8BH/pwTyzsvnAwV9M0zA6cJk=;
        b=u2gfWYNQMCnGnfY9EvZ0dTSwipkba+hp/TSRB6CxPgn5uZyakrZHd3PK5Pk5NirY4I
         075aIMihqqt45xJ//P8exLwHWtahYXV5857FkCpF1XUgEKFwByCQnYaKyjr+F0qOQWgq
         Qdk9E4H5S9786MPbsWXFRGLIhBE5XhUfNnjLJ3BM6eYiJdtC3aAgW71hUvxseiKXC7M/
         s+Z1IVJ141K1VO8hyMih+wJ604DlI6EDxdOXjH21r3/kBcdUF57BZvugyUNlKQ9IUqxz
         mt9G605b7bQyzCYhirEqDR9gZX40GlyNYmoKKXMI+EzOj4e/SOhzeoow486BCTY72xHq
         Z2AQ==
X-Forwarded-Encrypted: i=1; AL+hErFJb3/3thXiAY8GHUxGkoGl66OQs46nDIuIjyRrRgSd2bMLPAdXIe8x/gZh28WAlA+JR1XOErQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nsx/4fWVS2ZfuLZv9nBm4jXimcUUDpqF/G31zMC04f8AYKk6Z
	gWqMOGFmQvXhLhpNL/ZDTkqcKzpS6LlmYw6sL41TsBHW6T+z28O3Yaps
X-Gm-Gg: AZFdTZfKTlGyiC000e0d/u0DkEixwIThGl79qcM//oI4oYltbeyXTzR8g7KtLejMj5Y
	RkRFu9OamXQkgCFwVORgpaGNShs/+rd5OsSeas55iuZstdBsxaHONE0PhvvkoghLsSGSrzSXgyE
	EeETNqnCvOYPx8ksn7jWCjQSOATjdyJbzHgLBsmF+P5N+PIAu7i8vpFDBsAniWb4hJKeJpen3A7
	TJf7U9uxvq5/ivcunI1KCgbGMX+rVZfzw4jibPT6F0eZs+Kv+QY/qGhQdLL5v1ZZpuOwOomSVgt
	0w9RSH4TSnmIdmo974VxI9B8Jh51OryLx5/xE9NcM5I5kemtY7EfMBBVf1kPHFBIOms2j0AsyHO
	ZeYtwOnRUtytsQ1xR7xR5hzqIL7JnvTqLvtk3WBs5NV7wXHtx5FgQY5n9EYwKWfywhLcF8bgBwa
	Od03h5ZjojomDKq6QQ54ESn/WzN5FbsUR1fz6/oNQ9AZrwJYlbwrdJ7R54Al/gHdVLYvYxP4Tk7
	bbBZClWKz5pfxE48PtnG9JyQF+nyUCt40km6Ydgzlq9kV7+Eh7i18sNKuCIplUb9FkzlZlAFrUn
	6ddXeMgvyMez4XAz+/pHBgbDeJsHzIMOoleA25cOBh8OtzvHCJ5Ad47NoSTp80leimgfueR2XJX
	Z0ywGTiVaQbOMx+4+yWO6cv7w8lT0KaYBPiZIx+Jj+bMcuaK5FT40zZ2ifCjJ3Ap45p47JZoAJ6
	5f86qZ+uMqjp8NUwB1rSp9YgE4PQ==
X-Received: by 2002:a17:906:7d42:b0:c4c:d6a3:f4bb with SMTP id a640c23a62f3a-c513a999e3dmr691793066b.10.1795440050008;
        Mon, 23 Nov 2026 05:20:50 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b022e84sm411477066b.84.2026.11.23.05.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 05:20:48 -0800 (PST)
Message-ID: <2784354f-34f1-412b-aa95-70603f2f8cf8@gmail.com>
Date: Mon, 23 Nov 2026 13:20:25 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/net: don't charge the folio offset to truesize
 for managed frags
To: Louis Thiery <thiery.louis@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261119232935.1708458-1-thiery.louis@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261119232935.1708458-1-thiery.louis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 23:29, Louis Thiery wrote:
> Registered buffers backed by huge pages are coalesced into one bvec per
> folio, so bv_offset is relative to the folio, not to a 4K page.
> io_sg_from_iter() adds PAGE_ALIGN(bv_len + bv_offset) to the skb
> truesize, which charges the socket for the whole run-up inside the
> folio. A 64K send from 1.5MB into a 2MB THP folio adds about 1.6MB of
> truesize, and sk_wmem_queued fills long before any real memory is used.
> 
> The visible effect is a socket that looks full: with a 2MB send buffer
> only 4 of 128 queued 64K sends complete before the sender blocks,
> versus 30 of 128 with the same buffer registered as 4K pages, and most
> pipelined send_zc requests come back short.
> 
> Only the in-page part of the offset matters for how much memory a
> fragment ties up, so use offset_in_page(). This matches what
> zerocopy_fill_skb_from_iter() charges for the same data.

Looks good, thanks for the patch.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> 
> Fixes: 57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Louis Thiery <thiery.louis@gmail.com>
> ---
>   io_uring/net.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/net.c b/io_uring/net.c
> index 533afd335..8afad1b2d 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -1501,7 +1501,12 @@ static int io_sg_from_iter(struct sk_buff *skb,
>   		struct bio_vec v = mp_bvec_iter_bvec(from->bvec, bi);
>   
>   		copied += v.bv_len;
> -		truesize += PAGE_ALIGN(v.bv_len + v.bv_offset);
> +		/*
> +		 * bv_offset is relative to the folio for coalesced huge page
> +		 * registrations, so only the in-page part of it matters for
> +		 * how much memory this fragment ties up.
> +		 */
> +		truesize += PAGE_ALIGN(v.bv_len + offset_in_page(v.bv_offset));
>   		__skb_fill_page_desc_noacc(shinfo, frag++, v.bv_page,
>   					   v.bv_offset, v.bv_len);
>   		bvec_iter_advance_single(from->bvec, &bi, v.bv_len);
> 
> base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d

-- 
Pavel Begunkov

