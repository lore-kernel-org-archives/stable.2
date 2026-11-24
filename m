Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543209;
	b=RAccxElmbGK40mHfSnZylnoy1kPxR3IsNmORNa0tAMk7yP6s79QFp90k0sk4JIRfAtE6
	 /maAmsB8D4rJljvQ9NtdUNJhPRKr+gspUgj1YAycbEmI0KKi+rR3IQAtIGURnMlgzzZjk
	 PaVghdD+Eew82VXofitNuEJbqAz2If1D97N+xjRWrvj/iT2Z5OM14qlTf+zJbc+MYT+Mt
	 rS7ubE7b+bsaCj9BTrCssm+cGd5yJ7XhXIzyGjqrU6l1aIGVQccG0jCLxlXpeVkZXsTGf
	 Ut+27uP3HgCxAmVivXIyJMTBpgTkQMYbETxFzEdtg3Hzimuz/YTutMt6PpJsnDdLRUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8qQL2cawsszFVZraQt84ZZ5nw8FyEzyGMVtNWkN8uGM=;
	b=40QcyIwKD8ApOYyH+kVDgAw3eZ6acePdZTRUrCFXW7ZczOQLS6gMshc57QxpWQWXoShx
	 g+yhzqg37qUn88ahEKTUtvtyWoT4uYJhE+RA1AgY13HnWkywCEVFisKlRruJLqZl2VXL7
	 nmwXx+K1g6clkySQuvxITosk1px4er5u4JENNCcFzmBxY1Wsb4KcF+54TS24KUiFTdGWm
	 scN3MbG/TcCK0KON2trq30nyWw4reGDiV5xs+C6MKQpPkTFHxKK5d6wXw42yPVe1/V8ot
	 OfmhHZB4aISv8rsA6KzMplnISoOltQUUTnBLqAVEidaNZoKb69K2ARr07R04BhHWhVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ECcRAnAB;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248F606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1248F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ECcRAnAB
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3869f03af6aso4012551eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795543208; x=1796148008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qQL2cawsszFVZraQt84ZZ5nw8FyEzyGMVtNWkN8uGM=;
        b=ECcRAnABWXwZzPSUNLbCIrMIZxmCOEpitBrAoStUYbzHFiLrOCqNcx1nIqubcarSTM
         r1xMwZgi6imT4Y/IC1o1axRvxuhWHIj2/kg4RvWZb2w0Lut3XVQmVpGHQDsMHKwetW1p
         6WFUy42y6LaJIWnMa1Qcg7kW7TpmyRVYjWRg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543208; x=1796148008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qQL2cawsszFVZraQt84ZZ5nw8FyEzyGMVtNWkN8uGM=;
        b=Y0UWKBfQXTgWw9A39xDK0IMyuFnu/rlx/XzWLXe5M/UF7/6Y+h5R/f0scmB/nIme/O
         rZf+a89wc7WpqBCKsbTFKx2kaZX284zWzEJv6q27ebQBsZ7PTbWvHVQrfzsRZQ0G+C+K
         GDIOVVbWEhiaqnBM710tRtkjwleE/um0sASIZhZhAmlUKWgsApBaggSPzB5yvAy68PVN
         8oYrz1ys7V3JcN9515qBlqhPjnN2ZeABb0oct6jNXmixfTwD9nnZUA96Qx+gAgddWEzY
         YR9QS1jMaLrcRRkDsbb63VovuxrtPuBYbqRtBttCR1WzT+xgAl4aZrpUCTZf4HKU3J+V
         /v9Q==
X-Forwarded-Encrypted: i=1; AL+hErHqQaWJ0jM4coP6vYskRJct9o1/+Ns42ilVe16p/F3kCIUXHuIPhZztXpZI6N5SDon34QxaZrQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b/mSJxsKM9KKjMqPlozJq7Qwy/dV0BtPkQKcBSwk7FoOgRbd1
	vGBLjszmIPFynUUhrNi5eYxQQDaGxJav7i1W90GikpLQAyaSE0R0+8ydkc+BJe0Jdc22KmWw3HK
	wbE8=
X-Gm-Gg: AZFdTZfjOITQW5LbCFyyeF97G5jSANdEvGOEK/CfoE7UDhSb10pQd8VrvyuDDeSofTp
	sJArfg6nuD6YgfmgxT2otuJppxWnCK5pU0kVueJUfFg/B/qcb2IQEGXo+pI4jzJypLI6KSmP2on
	2OBSyDs5tIuyD7d9/Wb5L+nYHvCi2a11LEhzOkbER0Z+sr6Smp06wBDVeqYBnx+arIttdO/5cSt
	D/H9Xr6bYXNGwJAKzB7Z4FjPo5mLzgYCwBZS2oEyF8sqVsoMWgkhRKOC6bUJWMDBuYWEWhgR5Xe
	Ga2E/HssKb50xQwUkHJuPGL+Kntt4DCGYoVLpw65RgJ+24glPAxhqrJQ9kREwsgmS7WSYeQDya8
	YklrOYWpxWNF5Mr6BWfPP+LWFlCLhEdUiV2hvOyr5ALU0OX+fcY8x8zZTv2WkbvYhx9DciJmTDv
	tXdpeu/qQeUL2VDA/1B2H8DfoZFUupSKakyxXPAaUje6MRkNtFuOZLSXQBechqFY19iY4nDKkY6
	ThKy84R8XJtP7/rnIUXWL8Nk1CyqTUVvUHc2ym3tweKKCdLTbnepPk0H0c337tUsNDyGN48ftbt
	ST1gtqmSdNm81MFwJr8SJ6uBFSr/e95KW1AiS2WnOu4ugsJayqmumaDFAmZVJyQPFzg9
X-Received: by 2002:a05:7300:51d4:b0:384:fef7:5876 with SMTP id 5a478bee46e88-384fef75c78mr18248122eec.24.1795543207990;
        Tue, 24 Nov 2026 10:00:07 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:6ad2:8ba0:aedd:5a84])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385666e96bdsm43845676eec.7.2026.11.24.10.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 10:00:07 -0800 (PST)
Date: Tue, 24 Nov 2026 10:00:05 -0800
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 wireless 0/3] wifi: mwifiex: fix three
 firmware-triggered validation issues
Message-ID: <awXQpeeRwME1kVFs@google.com>
References: <20261124174620.1572200-1-tristmd@gmail.com>
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
In-Reply-To: <20261124174620.1572200-1-tristmd@gmail.com>

On Tue, Nov 24, 2026 at 05:46:17PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> Three validation fixes for firmware-provided data in mwifiex:
> 
> Patch 1 bounds-checks the TID extracted from ADDBA responses before
> indexing aggr_prio_tbl[].
> 
> Patch 2 validates intf_num in multichannel group info TLVs against
> the available TLV data length.
> 
> Patch 3 caps the TLV-derived length in IBSS connected events at the
> remaining event buffer size, with an additional guard against
> unsigned underflow when the fixed-size header advance overshoots
> the buffer.
> 
> v2:
>   - Patch 3: add underflow guard before computing remaining length,
>     as pointed out by Jeff Chen: when the header advance overshoots
>     the buffer, the unsigned subtraction wraps (Jeff Chen)

Please include information about how you're testing these. (You're
testing this, right?)

Brian
