Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147881;
	b=aBD9fLWoXTzUU0eJ+efdbR19QqQrVzMDWPPW/3DGBLWiaat6iLF7VIRUIWZGACTTh7c2
	 HyFMVIE/BeMJnZ5pUbgpwQYD84/dxVhvr150f6YzT3pOhmZTzVIzEQjuzrVuXJ7P/YoDY
	 3hS3w7OQi2QT4qEabZzwVJlvmN+KmZhc5BHaGANCGYEGtiFrIFMBwKvz3LsP2/VLRrZHI
	 5sWNzlz7UM1NIntHDykTMQlK9QL2GFdNzT/ySLOJEOx0gnGCoMesNF2vGGQ0TE1sEvlCa
	 cTQCFf0k7QNizpLPTNj3lmCW5ukAzw4YMZERxo33Lm/NumswfZUHLw+t8JLDPRAsXAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
	b=vygWq2DNBIcsNMESunjy3xoH7esLOTBvPC5eI63hxlqIo1cSSiXyl+pDHb3HT3CsjCZS
	 oybatkQHsxETqIaLUpK0upfb/0LcdwwSPJpnuOQG6cEyAxamaEprE+Il/63MH6EHawq96
	 zt3++SYoo+WqbfeJr0DiYG9YrEuOFAXk4/8NxbraeG8VJl50wwpHlwGwhFxJBuNrvRzzy
	 50VwTdGDa/DWvs2Lkfbc/E5o48H0g84Blbmx0yf2d7CrzWuez42FqY+411Bnhdr3CGs4W
	 ft7hD42QgoiPdP77m4J+4u/FD8D3GJseUli8VKWzD2clv2c/+V8lnPYjh4Ql3IJPmnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C5NrcUzz;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202C606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2202C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C5NrcUzz
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-382ecd5cf2cso467793eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147880; x=1795752680; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
        b=C5NrcUzzjEeh5N5b7MJ1ysemqZIEWwGi/rQnUUquiOK/UZiz3N9ayMe1qHV7/3hIhK
         lGlarHUH5G5QU4e3sssyJirIPNqXEQaUD4hr6kxHy2z7fImPMeKYvxkHH/zCZo+iXaOC
         POsghlSsyX8bw6cCS6UYsgmd9kCqKOr03rPuFpZTAp0SRSUgF3XG48O3IJXFaB1dT/X+
         vHLGqVVcn0RKgP/PFsKGN45lPVN6y18bq1EsXHhtsYbId65hyIDzPxPRha3kdPYxmBEJ
         DkFdiH/SUvVbBj7UFpoDRoF+VGNNPDo+bxRABaKkekSt451YS0LtRX/EuSmVuEv3CNXr
         2izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147880; x=1795752680;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
        b=CObLdPQ3XAjwQitbP3oKi5/ww4KvFcHEVuEWGcAk4cXzKmEI0zrmih05yq1dH+0lUM
         JO6eUIog7MqlC3H99r8uW1uhdnz0iG4btfQQheY44CBpFHyZfFyK2VzOmNANR+XPE5A9
         DxaI0jQ+/AUt/gh6nMMP7QAycGlwZMC5z4S0tPxZ1z493npGBky5PLKfDJvgRsfoSzPp
         Vym3pgQwVY8cs7gsEZKBI2kE8BjFbVJra4SsQIDXHtn0PPg9n3ffqinASleRAcA6RNts
         mAGa0FTfmF31TaCWPXi+X/cezP8NB3a2ypdc2XGi3+MCNezcpmK7C/zU0FG4eKW/5UFX
         I9vA==
X-Forwarded-Encrypted: i=1; AL+hErGDCGduLTpzpwLrI9OEex4S2FwiGM149qUS21LpOJB4XvO9O0fXCwToiFacoeP5JrlKkn7BEJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vVoJW37pRcCt2x8YQrpWOg/lNuoxNMAUjXfvjXujj96AjANnp
	Nb8uTnP0Iq/KYo6uu6GANMxR7XKABU5A9F2hrHGnlyKwQMCpQZQnbw+g/iT2qQ==
X-Gm-Gg: AZFdTZdMfqkeC1z/eRVGUobwvEdmTZrhV284V84CPLGLYyNJ21xY6BnS0kQaHuyV1eW
	VjtjWGrp0SicdB7Mdiv/vT94Di31ttj7REXEGNLOeku18FfW/JLASYkkLv1qqXyPPuI4uxaDEJN
	6Yi4iYtEVr6ZzniflXUnNg12tbNXn6R/z3ZX9plzsKJQNARGlgggx7A3tPRR6BTlxtukmkHzO9h
	2klo0UsU412pooQRmQAdo7tY0HNY2gSUIstXBPEIGzxS1guTnjex78/C12OuMpnBNa6MtiAQ5OV
	AzSAzbZZmLspLDr5hErMe6RVT75+TLXIn4mZsagCiNr3+qPplRs62KR8d/VHulq1MWrYXrhN1xS
	+4KmTrB/yukg/sP9V9sje3tcA6glnrwDHm50F9IW3zQwnD8FWIYH0gK4Ksv4XY+4V5QezU4E12s
	eqLyNBWy0UAk6nVKuVsWr4O3if3mZRlGuBsjYfQo/gBkS6a9qzihD7ZEe0u8B02uRxvbfIGsJLT
	6KIYAH/KRYycsEHXVTtghrhp1Gh18GzmSFZ2MXtOXEOmYzW8X8Q6C60qIrPLjBGpluEICAz0itD
	NqWeoxen/4rad30XV3EIFqFAXuA=
X-Received: by 2002:a05:693c:25cc:b0:369:f17d:efb with SMTP id 5a478bee46e88-384b3e77699mr4201476eec.10.1795147880077;
        Thu, 19 Nov 2026 20:11:20 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646632b9sm3322697eec.1.2026.11.19.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:11:19 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Hyunjung Ko <hj351016@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Hyunjung Ko <hj351016@gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: initialise metadata_size before reading it
In-Reply-To: <20261119034745.1460361-1-hj351016@gmail.com>
Date: Fri, 20 Nov 2026 09:39:33 +0530
Message-ID: <zev4jg8y.ritesh.list@gmail.com>
References: <20261119034745.1460361-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hyunjung Ko <hj351016@gmail.com> writes:

> papr_scm_probe() reads "ibm,metadata-size" into metadata_size without
> checking the return value, and the property is optional, as the comment
> right above the call says.  of_property_read_u32() only writes the output
> when it can decode a value, so for a device tree without that property
> p->metadata_size is set from an uninitialised stack value.
>
> p->metadata_size is the bound for the metadata get/set commands:
>
> 	if ((hdr->in_offset + hdr->in_length) > p->metadata_size)
>
> so a garbage value decides which metadata accesses are accepted.
> Initialise it to zero, which makes those commands reject every access
> when the platform does not advertise a metadata area.
>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> Cc: stable@vger.kernel.org

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")

With that LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

