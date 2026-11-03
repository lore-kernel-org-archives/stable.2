Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734329;
	b=1xkmuyjguK5ZLQihxwy99h7wtiOO3mwuLfacG3soy/fEfYg0/RKwOsktLgjLcjj83wT9
	 txU9FY7jv7/X+U2w+xaky63GNW9UGWGV+JIpuj2nnjVbAWDJIHvoUXa53O0AHh58RHylK
	 qYeJL17fD+JnBPoKOMAbxZxlxYI7Wos0/ZJxBQ/hhpQXQQjsl//2Uc/MfFEzXKmGVRcW7
	 2RYULUOA3DWpfNBZw/cA4rXhH3+XtHdmg43gmw931UHqolHJuz0RgtGNuUDrOUpvgONUL
	 y2qfhJCVy4l25yCSJCqEoybQqLTt47g/b5zVX103klL6eTP/UkXX/6zdpWSpdUKcafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=;
	b=cfhVxWqljBoWuz2Q5b0z/wNGJfWN0deNqbdGKBBrbzKxA/L0+10sjnAGwa6rq5DE/AUb
	 7f+ntYrnb/GVI6kDiFsVRDs6O9GyhOcDav5gFo25KIru1btusX3yFC2OiclyxSXloZ8a3
	 ntQjbzk8zNZ6YGOtPbhNpOyi2YjI8OOM3SvxpmrokfxPH7zkgGbH6UllQkg0CPnuwYK5b
	 BywHhzoRV3cMvZw2+ZcIeCpgHr9QjLFEC2UvTZf9ATIOxxhghooaZLhEbimKpHjP+bcrQ
	 52vCmclhIboIn68cwLipwypH0pE7dwE97x9cK1qsgfayPGntMeORKqa7UsZshrEoj0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HsnC7Dv6;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF2606A334
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9FF2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HsnC7Dv6
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1121919137.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793734328; x=1794339128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=;
        b=HsnC7Dv6rc4w9ws+TKm/m377rphZnE+oAeNZKkKElT68JV3uonPNOFCKzS0ifQO/4R
         ex0bUYk1bypeBnm6fm8UoNkA2q53BMCMbzR54FfUOkUYN67C3hsDkCxLtScWEkTM54Fr
         osOe7lwPraqa1uxF0uHVGuIWujBP88g4szt/iq/3+V0F/QxF7wT6kjvgGfB301zqnO4S
         kaGa9zDZS0HXdnXus/i+F3/RZv+jSoSTw+GOi6wbTqxH5M5N5kI9HpqQeY16T7a6um4+
         44UtyHiRj9rUmhKFMrK1ZbVb985toyZfusSYnxXM/oVSp5z/m9qWHLKWgpfEVP8HV621
         //Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734328; x=1794339128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eFZ903JDMQF4LwplGCwsYJNc74gwJQIrdxnW1b6B2E=;
        b=l9wDWJV129Sf9Y9UGuit4isiwLGtsEDTG6UuR+joZkQQ7pyv2TPcpfGXYSe7g1AVcQ
         kN/PQkmW3ibPZ3WzREuIRq7krNR54ciLcMNI7o99EzHMl+DHPh2m9E7r/9dYvOIEyrxH
         65v5wek3k4ptASlKYrtsWIGs3go8o27LJ10c8rh+oleKu9gGfHWCN+lfyUXh72qLMLsl
         EEQqsxVVfnWNEV2iCL/hj3ejG3DtiTJIbkuey90DXVjWcmXTMNQFbBBLD99VckX/khXT
         jno4hD8RK3lEN2H24pI++8bcTtBrPHtCy3jyaCSXzov5nyJPUfsyuBMf9Fy+RlDo/WqH
         RnZQ==
X-Forwarded-Encrypted: i=1; AKwUvByvYUruAxy/jC3K4oaKJFyEbTjYJWbwp2D/HoiBMyS7JBifWd3F0KEdLyHsn6DXBS6nz7ZfQzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z++hhp3Kk1JZnYkf99Ic9Jcl+8OlNtQkftVorBd48BzFWxYU6h9
	9bUDQIgejMcNeApN1GSWup06yPbAyrtwp0cC/aQZ52wH9YUWvzf6JUAA16S5RSgPK3Y=
X-Gm-Gg: AYBFou20yblsDInp4evnMXsZPG3M0RgqfQL7FJs6b5tgw9FtLt3oF0r8z5Oo6VNnEFm
	ilkjc/UAPmdDNmV0YlLdMHGl6DESlrHe2ulN2t7bjUSgBoTN+aVYHHzv81ICK2k4zCEou+nwZ4d
	QQgURWSZVVhnufLp8uYzhv0CsTdhBXLX2pubuf2rrKvNecc1OgPdWspaEwKtYE6GHWJnWYVYRV2
	L3jFcKLDDbKFOs/qbIpMunbpSuSokj+mwItkWpNXXxuqM1aWb2IHvgXkPeA5v+ARIbwzV54Ga64
	FLau90iw+1QL03KvZVMBBQhu5/PghRHZmQncbhTTUoQPvxcZqw7H0OK1zqEDRyBJ6n+Aa2thfuj
	3vSV/hCsSMCe0rhocBV7TTkXemgI1q+lIgrjPl4Upm4K2Me7Pe8STzPtafxsaooB0jSuqy6WLh2
	HHTzCPLd9Vjb2amRCQ8tceU2GTF6AwmYjd6EWV3qxqa87d08DHYxcRAi1TAF+MpBmQ3iiKHqTY5
	e3vM9SXpbsbHm8m3p088gtye0BCyxKYPhHt08wAR8ad822FQGwEiuzxe8v//ookZRG+6yaY5JV5
	CMgzBgKh8Q81vdJxHq/g++gw0ikJ1iTPFWud5nmDzoz6OlsCXwvjLUBqapyl5/GaDL/Olss+8dA
	g0pUM0tiBClZWDQsFW8942pZOAal8EUY=
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr5503016137.34.1793734327741;
        Tue, 03 Nov 2026 11:32:07 -0800 (PST)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fdaf4efsm33576137.5.2026.11.03.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:32:07 -0800 (PST)
Date: Tue, 3 Nov 2026 14:32:06 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing
 block set
Message-ID: <auo2qqZIbElECcw0@google.com>
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com>

On 11-03 12:39, Christian Aurich Zanettini Martins wrote:
> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
> 
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
> 
>   luo: Block contains invalid entry count: 0
>   Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update
> 
> Check for the duplicate before growing the block set, as
> luo_preserve_file() does with the token.
> 
> Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
> ---
> 
> Notes:
>     Tested in QEMU: create N sessions, retry "sess-0" to get -EEXIST, then
>     kexec and retrieve them. Unpatched, the second kernel panics for N=51
>     and N=102; patched, N=1, 51, 52, 102 and 153 all come back.
> 
>     Based on v7.4-rc1.
> 
>  kernel/liveupdate/luo_session.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index f48e9a4185f9..74bc66929f4b 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -176,16 +176,6 @@ static int luo_session_insert(struct luo_session_header *sh,
>  
>  	guard(rwsem_write)(&sh->rwsem);
>  
> -	/*
> -	 * For outgoing we should make sure there is room in serialization array
> -	 * for new session.
> -	 */
> -	if (sh == &luo_session_global.outgoing) {
> -		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
> -		if (err)
> -			return err;
> -	}
> -
>  	/*
>  	 * For small number of sessions this loop won't hurt performance
>  	 * but if we ever start using a lot of sessions, this might
> @@ -196,6 +186,17 @@ static int luo_session_insert(struct luo_session_header *sh,
>  		if (!strncmp(it->name, session->name, sizeof(it->name)))
>  			return -EEXIST;
>  	}
> +
> +	/*
> +	 * For outgoing we should make sure there is room in serialization array
> +	 * for new session.
> +	 */
> +	if (sh == &luo_session_global.outgoing) {
> +		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
> +		if (err)
> +			return err;
> +	}
> +

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 
