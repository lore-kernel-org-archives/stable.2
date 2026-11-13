Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602496;
	b=0gVjaa6rcu94xQID4tToGcVBMk0Lt+NNBVZoh/JhWMDad9oZ9XhQQk8lABVKBRPDti82
	 KWgFAWFDpvG/ap9BNUE6W+TIUL18zj/MUCjqHclwsQSvMkg8qHLFYX7K6mD7Oi9yMwwjA
	 S1OAeetX5wgvROejq4c59PC39nofyOwKj0ISDYeNmumX8i/6KxiCDnrhB1oLkOkXzDqQ/
	 oCf55S/unLPgnMkzyL8VUGm13ZBucykl14LGjzDWGzUCxUqtemlmt/p+3Gczdwl0w7d7A
	 nFqi1ZSDQ0NIcEvyupBWotI+nmE5LRsLEUCzJucQJLTx0eLvkuCuDZjipnktl4+iKVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=Go1UlgX1P4vYTlu1myflgbT685YTRFHTo3Fw25oz0DU=;
	b=cF4NMSlA4+cLoro6Rc+3aF2hFSbmn5sTCo1OyQXnL6aSw79+KsaALHXsrQHOuP/bqQih
	 nRvuKpQgQSoTBXBje+jNLEhe+/2CAHd29hEM2IpmnefrdhUzsgDnd1peYOn4FszfvC7UM
	 oxkilWxAAz/74P/f3kOByY3Qj0XmaQLg2g2MBVpAlippgvDdSBp0ijuhTXo5A8X9TaNJk
	 +IIzYPP4jj1zL7v+qwa9fBuYMtlhqhsBf9bCALPQsxeJbbcJ8K6+Emey8AB0RUopF6prR
	 igX4s+SJUt/2OaszcL4/rX33c04Gnt/nJHBiCGdbX8QxXuF4rBfx24UG3sX048VD8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H6cHbjyz;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277A606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E277A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H6cHbjyz
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e7af9a67fso9142246d6.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794602495; x=1795207295; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Go1UlgX1P4vYTlu1myflgbT685YTRFHTo3Fw25oz0DU=;
        b=H6cHbjyziz1gLSO7NGLmPKJ2sWjqqZPQtZKw9ktfXegRk5crmjVAzuYgLoGXwmOg6G
         4x0my1vj9kG7zmBMS6jT4gCyYqQAesvQvYZ80PekskeAQFS9xUotAKj8P+B/wM6TS+Ms
         R4OFYi+p4QJh4fuy8qJNiIv0ZGxfiKTZXFDc1Wd93RfKMeXl0e7qVhnAnyN3vrGGpKTL
         JTxq8WV7HynrNibJnldK7O9YKvBjRZVixNwa7+tqKizFa/HqqNHwrZ+2YuRwyLy0PuPy
         MYZJTsQsqmAUl3kh6Y+CIWueTXnEDdZBE+DwHDJusD87/q97axAwprGJExG0tzpGUBaN
         9DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602495; x=1795207295;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Go1UlgX1P4vYTlu1myflgbT685YTRFHTo3Fw25oz0DU=;
        b=HK9ZNsiR+h5MNhfHZOliHSGb1DmXQlMBuvMIqnj256IV6Jxyk2+JaG5AJZkB2Ucqqc
         U0FPcOESkMgk/8WNHaEYcuZR6Sxo3dmaKiy8/e/5yfmjaXYhwPA+kvtIwtQOnwXGjdPo
         ig0ru67RPBMfFkHZJ4NkXWwzKCoh94Wyj02n5eccrRq08Txasg0azgD3gJ/AcgmPkvoq
         Tzjg7T9oKdE2yjcY95EdERMwybosMTyJ8UsdyapXK16uLqp9bXzyvWfytQNHyKR7Vju9
         wy/tIt/Ai42ZcHzUStrJTbcxaYj2BD2wEZV+7q9LU6yhsuYSctAOcPsuqsOwlkh27YZV
         PHBw==
X-Forwarded-Encrypted: i=1; AL+hErFroDZVuzFb5anxZUOr/l/SplW5QsEmvA+DVc/F9guUDVoJ3DAJj05qhyFSwoVAmsdl5umZIlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y4O1juRu4JNw7ur/3LbYS+Vj0T72ka0AmBcQAWcJ/0exsEHzB
	FHzDCFMtej5JU/IKEU7UH83A9zzqAJbrSY9EBpQnOO6+QdzvRTZ8VhLwsAb1WKKeK0L1FS0e2bx
	8i9OI
X-Gm-Gg: AYBFou0Jvo9AYu2buzW82Xel5SzuFBgmxAZbKrADoTH9jhg9rdXO5XMUdPtEEggFUSU
	LioneRo1APjV3Q1BEPdl6f+3RdY87Lrju31+VzLGY5bNFqJLX2Xe0KXq3sFc7ic1dRL4bfvgLqb
	POgmp/pFLKeMZYgZQcTfxKkXNTiszfSQAUcfZ+E5oc+4mmGGvk9SUht/Nt2cXZQDLs53R5biUUq
	R6Ex9jKWt67jZtMaOjkCuItpRwmm2XzYJOtAj1NPRXO12UtoUYGBymM8I907i/4pz0g9Ow0/Pvf
	8Q5GTOvcnYBkRUASffF9fNftpIgC98UTQp3JjuU+2egxTV0Aa8G0yplDU2k9NQeTlElzJPifqUT
	MpJTAVxiBcqqd0WznQfLgcFCEA++QWgwUsA4V18UgASDsaFAWtTo42R5nYbqXB8rwbpC0p83vgJ
	j0pOlqX77CTWZfZzXg3QqHNnRDxL3IfDSnwmzL8gGAGoxj6sndtRIh/hHFMLJPOffSCrBscqFG7
	Unkcl8+1upjSsi78dOmwgYXBmNVEWsGWAQ19/zbODgJDsjyb4uop+N1yuQ1+XnzMB2HLkh/yhVs
	J3Ad9oKjjmh+y53RpTwZwagRVKrUFEoLF35DOc7fTNRL4NERaXIoZieXlitHqbia2icoisgjg91
	IGcaHibk=
X-Received: by 2002:a05:620a:2792:b0:93e:a71a:5de0 with SMTP id af79cd13be357-9494bb894c4mr610417685a.26.1794602494861;
        Fri, 13 Nov 2026 12:41:34 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c5fd154sm262112585a.2.2026.11.13.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org, 
 akpm@linux-foundation.org, david@kernel.org, kas@kernel.org, 
 dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
In-Reply-To: <20261113200303.GA395967@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
Date: Fri, 13 Nov 2026 15:41:33 -0500
Message-Id: <179460249376.482102.14669935557901467762.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-13 16:03 -0400, Jason Gunthorpe wrote:
> On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> > HMM can grant ordinary device write access to a userspace shadow stack.
> > On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> > can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> 
> I'm not sure I understand this? The pte is writable but you don't want
> only DMA to write to it?
>
> Is there something special on x86 that makes the shadow stack pte
> non-writable by the CPU?
>

Some of the context is here:
https://lore.kernel.org/all/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/

We had a similar issue with migration, but this should handle the DMA
case as well.

It's "technically writable" but the kernel is supposed to prevent that.

I will say my understanding of the larger HMM picture is limited, so
there might be a better way than special-casing it like this.

-- 
~Gregory

