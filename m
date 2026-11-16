Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847367;
	b=kEZQ5qRPGPWEbnaZnu0W58I6DMA/HEFbG593lCEb18t2/fBOuBIyOAQ0cWRKtgT1GTz6
	 rBK5hKQRgMB0C4CdOguq7upv4G35McUow3NpS1i2yLlTE8fnb/UMMKRfcsWUrwI8R9tzc
	 yFMV11BdcvZWUe8caN2jBkrJkOSbKBKS9zqhTyUbvO4hntVyczNGmuWiYZ9gGqiNYsnA9
	 1bsp0BV87zuwu8I1vKQb+kzc954nG10wvGfJXhFCLz2QW7n1JkFhXKeN1/PNKM5HcJmJv
	 6eW1OBKh9N0T+IsDtBXG1wG1srs5np309EoSTjA3ELKN4SuhUacFZEQxEdUji21pC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IJ8laK9ppBsQ5w0QCVG99S6Wck2m41XXe6YgxVTshXQ=;
	b=5Qf2ZywXuDz63VwNsw7WzXhiq2JMCFtvl8HBz2rD5CyiwHUBhJbS3ATRppbteoK0ZH2+
	 AKc+spd2k0ebsg4roYEjiQH+l3NEJESB5RRpm8ySwcGo0uitn53mVcVQsO91LPahrJhzy
	 dDyvNGnpYp+UAKyD5SvyvrsHIKBZAUUtpXRZMbVo6T0dEpU4eB7AA2oEEnVJcpiX6d+2l
	 lvpt01ZniS2Q7pJDmnh23KfoK6acB/x8az5o5AjaLGf+6mkfZfCpH6Ydfav5D5L8fHoqW
	 kzVVxPAHp+/+AZV18RMXEduPAfAJcK+HO8EveF/+pCFOUwN0PtkplZBvgl5pixGBcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5N+PC62;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E9606A32F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C84E9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5N+PC62
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so185015e9.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794847365; x=1795452165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IJ8laK9ppBsQ5w0QCVG99S6Wck2m41XXe6YgxVTshXQ=;
        b=p5N+PC62LG0ulJMmh8Zj20CTBBsfskyu0ICZWvennkU5j51rdfItRqDeP2wlMv+rza
         oTBg2iqEuEFbz1FvSROSL3lvUiz5o99IeeTlq2rwtYEGi1pf6edcXzmnFotC9raiybiq
         +Gko6/ey2YyWwp5p50fElSwrKS+5GHvYlR1a7aC6B0LFsV1T02BZK95BPhYLozh+R18b
         qHNLG+ppjIgq8LaCyIBpWhq2/mO+aocDwWeaehPbBBVdLV5p4KF/86rpYlz74KJWjRrC
         rKidTu2PWOhHfO7i5dptlVNNuQfbjDe1QuIfzKocJHnXsrTKV35vQlw3zfIcbqDxJffh
         0wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847365; x=1795452165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJ8laK9ppBsQ5w0QCVG99S6Wck2m41XXe6YgxVTshXQ=;
        b=r1zc6qPAV7pqs6zUMA3Q18e41VmeJ2MtjKGFYXHE6xN/FU0YRmlk7pw2dZlh5P6SBr
         HpnohTy+iDim3dMcLju6eJtNbxqRZtdouVV2OSMAaKOBuD7I8YZAC0UXlWab5KBbVQ51
         gwmXYmIKkxxrEslETFwUqKDGKiSBMiP0MIRC68XkMCVADcRNRN0oDbZv233q7MgJ1lNI
         O420yUEYy/wnM41DKBTLvqKdmI9INc9fk1ciE/QM23CL7v+7eqQVgCZNgNEY6YDB/Y4F
         Xo0KEvG5O9ucJ/B5O5MuQrcYx7ZbGcKC5LJXF8I6GnmbsTln0hHE1CnD/Ov6jqC341Pr
         Dt0w==
X-Forwarded-Encrypted: i=1; AL+hErFrXHqIk8GU9G8qoK4fazuk26CEYe8CrgwLBYTui9WY1yLaNdRmY1zPbZ16CzP9vWJXJJHficg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AnJ4L+1Cr4b9agJExQ8Pe8JITGuES65dnOu/2xYeCYkBo3Byk
	5JZClsTyGceU9NQOlQNR5iFP7l0O12tu7L4Ly+KBzf/GiCa41Jvxp8e6MzjncPlBtw==
X-Gm-Gg: AYBFou0/P8HjNpVxnrclzCWVsBJzD0mtAaLoP9NlAvGokZfSU3MzP8T0Af7y1tU3kHr
	ALfr3xyo8NUApRSq0nIWwW8V5NMNs1+5kzH4XWjQiapFCf9fyEViKU2OnRfPJ8NTxk+l8ySU2+q
	kyJFyExsP4dhlDivIhpw8YOOnHC9cjTcQrWuGVMCwOEA0YoQNnlJD6JDc7b7RdX6uFR6AKdXYVa
	f22XzkXTHBzlCngMyU95wDCF/54J8PSA5itu2IQ0jM6JtLBcu3a3Rwif1rhlnrhE9Gdek9OCl7f
	HPefaDWH7K+dBgvrEnO/Bg1fKQBl0IiDEdYcReZEFsJ4FIwcsjyvBlg5b3GoV5nFNfaLwpxbBj9
	TOqyxEnoqv+4mY//fvUTZ4VPOS4oXXRvilXGkF8PbOar2MsgJr4ZPJwJX/EbVvd1lzG77sKtYR1
	TyHCC1/S8h4KM2WEHLMIMmOXISOhwAgfdlP84WIgSfQOzpCUoTToNYcS6Wy4KJvf361nosMLuYa
	9u0ZNLUfb53moXgoI5IG0Xjp1BsgRgeTioB4gzPK4nFPT997redAxsr+l0v1OgiEf1SbtezOiic
	vJCn9DxdDDQGDqHF/GhklnAFANacq7lKfuMB5WsLBY2Nci46A/vqWtl14cTVJ4jFv+gSFR46VBM
	narO7TxFCr78=
X-Received: by 2002:a05:600c:5012:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb7837264cmr1312695e9.3.1794847364743;
        Mon, 16 Nov 2026 08:42:44 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783965d4sm791855e9.7.2026.11.16.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:42:43 -0800 (PST)
Date: Mon, 16 Nov 2026 16:42:40 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers/virt: pkvm: Zero and clean memory before sharing
 it with the host
Message-ID: <avsygB0HdGxR6psB@google.com>
References: <20261116110549.1863653-1-fuad.tabba@linux.dev>
 <avro44jUWOARFzul@google.com>
 <CA+EHjTxWuiyjmUc3vH_KxRtS_3oX5w=CE76LdsLcrqC+RzLGfg@mail.gmail.com>
 <avsNdPissIDAb1hA@google.com>
 <CA+EHjTwuvhAPWje63TJRR_d+VHT0xwORktQ4zxrcV7KMaHxupQ@mail.gmail.com>
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
In-Reply-To: <CA+EHjTwuvhAPWje63TJRR_d+VHT0xwORktQ4zxrcV7KMaHxupQ@mail.gmail.com>

On Mon, Nov 16, 2026 at 04:32:40PM +0000, Fuad Tabba wrote:
> On Mon, 16 Nov 2026 at 14:04, Vincent Donnefort <vdonnefort@google.com> wrote:
> [...]
> > Ha yes of course, that's the host s2 we are mapping into. And on the guest side,
> > we are only changing the software bits, so no CMO. Actually I should have read
> > the comment in stage2_map_walker_try_leaf() more carefully.
> >
> > That said, I wonder if that shouldn't be handled by the hypervisor, just like
> > hyp_poison_page() do the cache clean.
> >
> > That would be slightly slower than letting the guest (who has a mapping already)
> > do it, but pKVM is enforcing isolation between host and guest, and it feels like
> > it should do it by default no matter the memory transition.
> 
> After the discussion on the related thread [1], if we have the zeroing
> here, we need the clean here as well. So I think that this patch is
> the right fix now.
> 
> Cheers,
> /fuad
> 
> 
> [1] https://lore.kernel.org/all/CA+EHjTywWTaKLtM6OPF_0ETv29-m8JsHdvF3BeW9Xa=h713eEg@mail.gmail.com/
> 
> 
> >
> > --
> > Vincent

While I don't disagree with having the memset in CMOs in the guest, I still
believe the hypervisor should do it as well.

Linux is not the only virtualised guest and they all should be able to trust the
hypervisor to do the right thing for them, which it doesn't.

-- 
Vincent
