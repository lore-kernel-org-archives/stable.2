Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1EF3EA97B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286541; cv=none; b=c1MbaDhaIv6jVI1VwmHN5caENmP3A8ySFKANwEnqWAr/qqU8aOOWgfSjfiMKYld4fpmCWvfnGto3LDDfrY1+45J9A0YXDYXLzDfAx2K7A3cZpAC7HVf7Wdc2bqvZxtSUhWJJoaag5uImZY4Lv9lRTfblP5rqkk4zAYvElFH3zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286541; c=relaxed/simple;
	bh=zDVOEiONu9RIqG/vaAanRhfnlAZdolLbZCe8JQswCvI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=D/QXotRj38j4CCFagZM2EPImRmVxV2iOBz2RWgK7cDtWftCeweP0KEkyaDmEQxg/CPtC8gFNxEuv0znQ16NHKaB45iHCB6wwOlScdbJ5o/5XLVV5REgzwHNk82IonSd0QgfrEiQSRpmPQeOkdHyLqhCee8mAtsgFcua7c3KyOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QEIr1L6X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QEIr1L6X"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954c9f380bso1556215e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784286526; x=1784891326; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PkeU5J611rL837GI6Oka3yn0u16RbjAUf6SE88GlOtQ=;
        b=QEIr1L6XLrizYJueg5AhVRz6XKVuHOMZhGNsFoI3lv8P1DtcrJoj6vsZC9udmiksx/
         hxEwhQy49ksmryc3/5E6miBLDWu+tt1WRww660L9iMoRJx15y80g5GUXFse+DBvSLAHV
         WKg1ZUrP7Cx3qeDq9eJTiIsprztGBwcKF5mvVE0377msUIW0y3sLQOLdOSUCTdBrO7Pw
         0cucDaWW90PucyXdegTOE5d/Sb9lvxQmPUqZRMXEr/xVLfDLH0EYlVGkgNWd2iekV2dd
         r0H5ht7fdK3BX2r7z73qDUq0BxscTV1anl92MoNjy4iLXJJJaIeyNfgTrZW+n0GWmzKP
         dcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784286526; x=1784891326;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkeU5J611rL837GI6Oka3yn0u16RbjAUf6SE88GlOtQ=;
        b=tSKojs8ZioBPU2C/zGlqAO2nz+x6Wt8XedRnXzPLh0+B3UmgZ9UW13ej/8qL7eJpha
         yOr4TD9ns36noKpAVnl81BZDi3Pd6JNd6rXS96C4qIAC4d8KGXRX1MxoleKyFtNIvgpD
         Wgxkuu/uPD6V3imMjWWNCDRkeGBDltOfGstdRPvvWeCx7Jinwesj2bGA2DQDJuTAWAoT
         mvHa2+sddk7UCdG5H4SzMhjG3OOYB7n4dXR7sMcW0ugBoQ3HlXKmbduw792ykmFclfqW
         mLZYJ2d+5dY8Xjv/s5g6M9bfYcGdVQnND4juVg/tZGJ6CSAIlpYfRKAhVU9oHHLp2+LE
         bodA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1Eh3n9swmcg0+sN5ZcycNkFQzKH9zwBG7MmLM6ephPmG/Qlrt6AYOo8FvJqc8LhpQOzwe0M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMxnW5/VNkGqTIbIdBtffvz1ZNcITLJXZWtF1Gksm9pfpUs9D
	bGxnhgzKf6fllJ2AVCDBha9CE+SFykkhObCGanws7DwEGfYcO2nptKlx5KMN8Goi1/g=
X-Gm-Gg: AfdE7ckzy02Ee1l3jncym4kNc9C0P5hfbOA9NR+LUVCyFIgg2w9Xb36GtYZBe2pwKPc
	g15PjNMeTAV78luj4MOQRu4VqA+KFk5V117zMk6muyQeOWDcfEtK5HkZzvNu1Rlviso7J+/tFF2
	59LwD6i6PyXiJcGagrwfFFkg5zinBzwcln3E15qkegQbrbDbwz9v5YDGWHc1SF1lVud/x51cBXD
	T/ZirXrQVdB4LyT6LIdv34sU8jLz9HqOBen9IUUE3xu9D0SiCZNFFE7v70HbmH9WERHeRBkhxHd
	2ZZ/0f0q5H8vjh7kZipeO7LNh4nE2Df7yXnUVysDveDq9MfxUfTQUbX+U8wfBThnGlOb6ODB2q6
	wtaRhmL5y93ezaqsEkusCXkkhiiW/ZKbe02QC+tZhOhH7gaNp3C8Hz9Kr0W4smFaio+GsBjiKVN
	qCaEQDp/4fCIZpgL9na+5hV5MAEY8GCQ2ESk2Vy2epJTeJyIbW1pnK5w63N13A4Q==
X-Received: by 2002:a05:600c:4e0c:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-4954bf564d0mr15542655e9.13.1784286526389;
        Fri, 17 Jul 2026 04:08:46 -0700 (PDT)
Received: from localhost (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a36312sm46247875e9.2.2026.07.17.04.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 13:08:44 +0200
Message-Id: <DK0SS9CO8VPC.288VHJRRGAWQ2@baylibre.com>
To: "Rob Herring" <robh@kernel.org>, "Carlo Caione" <ccaione@baylibre.com>
Cc: <saravanak@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] of/address: Fix NULL bus dereference in
 of_pci_range_parser_one()
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260706114731.57353-1-ccaione@baylibre.com>
 <20260716204914.GA1262499-robh@kernel.org>
In-Reply-To: <20260716204914.GA1262499-robh@kernel.org>

On Thu Jul 16, 2026 at 10:49 PM CEST, Rob Herring wrote:
> On Mon, Jul 06, 2026 at 01:47:17PM +0200, Carlo Caione wrote:

... =20
>>  	ranges =3D of_get_property(np, "dma-ranges", &len);
>> -	if (ranges && len) {
>> -		of_dma_range_parser_init(&parser, np);
>> +	if (ranges && len && !of_dma_range_parser_init(&parser, np) &&
>> +	    of_range_count(&parser)) {
>
> Why do we need of_range_count() here?

too zelous but this hopefully covers the case where init succeeds but
the property holds no complete entry, so the loop never runs. E.g. a
32-bit style triplet on a 2/2-cells bus:

      soc {
              #address-cells =3D <2>;
              #size-cells =3D <2>;
              dma-ranges =3D <0x0 0x40000000 0x40000000>;
      };

It is unlikely and a pre-existing problem so I can drop it if you want.

cheers,

--
Carlo Caione
