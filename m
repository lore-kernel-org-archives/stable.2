Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793976530;
	b=GKlOlM2+F7H5z+EdnQK+F5WtDyoUC0s60nXwJSV3F2vHWUPr4dWEKP5fcTE1MsxexK7w
	 jWIMeOS3Zq2mWpNPx92BDb3dG8KYRUfQFSZ+9gGVIzi4M1/BKMB3pB2uqtGf4RxG3dxNq
	 dpON/cvh1z5gqUULFECpSm5GU/sDK9Zd2w3N844/a0eIuqUTLqMlPOY8awQEtavpu4tFC
	 HwnuPzFyd8pSy3YzDBWQVPWwyl4FCcdRO7B4yqxehvXPLFya6Et3rnzbPOMUVgonbsK+0
	 Xl411J51RJMuXr7myD+xmo8+VQ4GogNeeUzAUlHXfd35DKhaBolIgg8Jjbyk1Z0guaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xvOaTMhDj13OUDMQSswZJ0IAxOUEKyawCvIprNPuBl4=;
	b=KrblnDknys9egAv5fq67ybjmAGP9tVgs9A6RUeW0yZqhZ1V3ITrfz8AUQ3iEKbMSTl3s
	 OPXnCHvAWhzLDgdFEzu/aOK2po/lfCwNXJPESNFOCwm0l44X8QunKyIIrTrplFS37muqP
	 QoP5YC8NsevM17GvAX30J/TmVn5Bwyg5xxehLA4Q4gbk1dCUywa+78icMlIs8hVbOki6c
	 b4oQE0cEfEDXAptXrEpfY/Sdo14uy4EwSrMLBCLNYDwUC6TLnQ2jAzVj1WeeLMHD8Hejf
	 NE8bQ+prKNhluPXnvwlpJZaJFMZu3pDTQEisgKOd/9iH++2IIGAfLFz8UU8FMNJC+jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k/CycRCN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C10606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k/CycRCN
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e90071735so101718eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976529; cv=none;
        d=google.com; s=arc-20260327;
        b=BNJXiRz45h9By//h9ZHpldhXbHc0w978aPHDBO8PogshprSVYmPzK9CjbtIZ7N638h
         RlRYIdkZZNUqmfjUuktB2mceJZRMThoC7ilujho73M9L8jAH5bbF0PpNJWThguMqgGBN
         zkaL6AvBMIvFdNHcnq9AIccXbDEdYRXQkwT6/4LKG5Ki9YpMFhdD1OYcm/ofNcLsU5QE
         AUuV8QeER2xh7rNd+/uvdKoeRnZOUkXbF0ZnwV8uB3Jfg9RI6k2hmyFyGvyYnWzTiOK6
         qGmyBzI51TMLquNJdFrF4L5/R2L/2bQ6nxsytAKaSv3SqKrBA20RpvCWNZApk1FRSPgx
         on9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvOaTMhDj13OUDMQSswZJ0IAxOUEKyawCvIprNPuBl4=;
        fh=kwNdZEcqh3gpedQdEsoOvey1ez+fSTTaPdEF72q5c0E=;
        b=OdvNvZUr6OxSBfjKAtF28ZfV9SkXKcv4+NOwCZ3TEkF9H8BwscXiaCJGkUtECC5ouA
         +JyACUwHLnbvvOirP1G3R8USuy30qM2Z34LPgTaMbZUJICBmLxQR1xnnIh+2ysk4vxuh
         Dd/WqhWBkphiorTr7STPj9LQK2dofHT0YAd/X8+kUZzsgk/MCkbVnl8mx5dt9o0Vp5hT
         kXAC0WDODW/f2aXAsiioERVTvXDaCYPJT1dDcXKVNIlsgmdSx7GEF+HeyZBVw3/EDaSf
         4KyBNjBS6a6t9/WWjoX1maRfRKC3LYrS5+C99Eh2AOPZvoTOZahXB/g5QBxsIU5Mzu7W
         Vdtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976529; x=1794581329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvOaTMhDj13OUDMQSswZJ0IAxOUEKyawCvIprNPuBl4=;
        b=k/CycRCNCCmdSNwXEiqinFmBn03lJE4RCxKVyQz8caMQ/VkqEe4WwIV36jgyNEdGGs
         HZUfeWfi+3npU3YYF9PFRRGWi7UuhOnChMmK9T6XdNHMpLOYEcBt9NsKnn6i4OSOad2R
         Y9B652GbrBvx1yZ6dhujnXzPkwDL+X3JcESnlKC3LtvcPi+jqehOcqjatF96mOEI9Z/v
         VZDGsI8zpmVzAq77h0jpIr8FGxI1ccTWheFdxohcXGi0505QIUBWHKSvEhAK/3W7T2Wx
         /Jqo0J+nB9eH72sNdvSfmAchUj7waFEcS503z4XATLECEWWk1bd14sxiUyLz6ctDX2/d
         5M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976529; x=1794581329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvOaTMhDj13OUDMQSswZJ0IAxOUEKyawCvIprNPuBl4=;
        b=GOQmf3b5ccAs4eGKNoiF/ljeX/xYhXlPZqwih4Byss3Y8ww4+hxeRFwVuSGOjDLjXL
         RoZSqmAebpVw1OpEmiJn94vfdDaNvSUaxN797B+i45TJrFCqBPSnbkwBEHPYqAd7S/vx
         1ODmXmet75lHTaMCtKKA5vWbKDxLi04nh8PQvIBO3jCFz5JkI5WGNUl/zY5caPoF78Hs
         C3zUJ4piBrtWaMcZdWsBEcpumYC4wo6KMB12CY8sWTvkURAcAH4XpNMiPkxUZoMl/wGG
         LrfuhaQnI+Y+pllj2oqcUI1S6w+9WeSFtCNiOd9zsP+l/UKHqhwBilAbEAvsmOtZ27Y7
         VOsw==
X-Forwarded-Encrypted: i=1; AL+hErFG3ovl6p7FDHGEeClGwNK2m9ed4+aGj9G+ymiQEromgzF8iOFXmKxTmxO+Ta9ouZ9kmgXXDsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bgIU1UNxdekKjwD6GlG2/KXmfbZCfM1SuFMbZK3F6+bcaKrE/
	GZt/kfrTGXndsd+yy9v19HmIAY7f4ykwlhptmLKIqsqJbFhEhyJw+/fZocob2nTFuX5n85wG0qN
	srJD1NfqJCq2MEUiwNx1mdzPCPBnVsHE=
X-Gm-Gg: AYBFou2DBgizMA5g84wh6Te4SnMWT3OCyPkRSwffoHeMa3vUq1vC+KvO4UUeVWexIcf
	lh09CUbH9Xsp2d4VanYdnvWU1K4UCHkQYky3vS4CaBSZbVFZB40yAA7QgtF7ZaMRSxfvJoOd3Lr
	prlAOmlzueoPU7rnH6QTNcWje6QH4Rj3Fj5lIOt3rJLONkz9yezp5bM1tACMW8Y2qkuwzHo1Wpr
	NxqgoDQlF3mzchBioIyNK72EfM46KyICBO+FKW6fZrpOoYwpLdttvbSH4575NP4COJ+GOEi8mqF
	7sdSVir4mGy7l8kiIa/nLYiinQpVVbrGrX4rYLp1UVQeNxktwMSYhyVsnlnqZAAIJJ/NWTJHZvN
	GnR4uwvVECjIFMbfdfmNsgji/7KnUqgfYyTeXeDX8d1Qi24sTE0a25Wvp+oTIbboChctrhtgO/5
	BFLyqqACM9Fpnj63JM2LY5Cq0t4/wqcbYbkaygnvL4+L3b9B+O7OV3DjdmMiZUAbq/oxOqvGuX8
	nyJiJC6k90gIWBFueQzQjJmS0pov9vf2I/D
X-Received: by 2002:a05:693c:2503:b0:36f:10ec:f692 with SMTP id
 5a478bee46e88-36f6fb7f196mr5007497eec.0.1793976529153; Fri, 06 Nov 2026
 06:48:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110416-donut-counting-ca1b@gregkh>
In-Reply-To: <2026110416-donut-counting-ca1b@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 15:48:35 +0100
X-Gm-Features: AclHuK_HF5_v1G1Csnyx1-FHH3ponFaT2JRkXqW4GknkibYRA1D9_meh7bGC980
Message-ID: <CANiq72=8aFhqCXo2BcjB+2Y8HQ-4B72=GPqEn_cuahVqW3SLZQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: hrtimer: declare cfi_encoding for
 hrtimer_restart" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: samitolvanen@google.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	dakr@kernel.org, fujita.tomonori@gmail.com, gary@garyguo.net, 
	ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:14=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This is at (as a series):

  https://lore.kernel.org/stable/20261106144721.29080-1-ojeda@kernel.org/

Cheers,
Miguel
