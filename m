Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800537C926
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039254; cv=none; b=n/V5D3UDdFkUFC+wJk7dHVuiT2R8iClFvsLvEyOIRY/RYNX6Nd1C7g9VV/HDh5dhRiKsHy1/tX6sNq7FwWghrBhbnyZsE+keZtJCAtnro+TabK4R34/u+WzZxdR3RHYqaOMysx1eiPao54hRYe1ViZjoeI1svuBm/CiMV7k+TE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039254; c=relaxed/simple;
	bh=J3avfEfW9gW/TN5lEejRtS4N/STs0EUCkLfklwncbOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOSYAMsbBxk9+M3vHEUeoc4+qqY1djJT75maqlXa5n59ndFAFmi7yFAnef8IyvV2LRYCezHxuArG9EJd8IbhokIalkmG/bxEkY1yZHYiqeuHM5sa4NuoeB3vyF6FM1YTNkUYWdOKsiRP27lPdVFYqpIFTcFGrzi0GwgnoZvgcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNG/e6uO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNG/e6uO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso13077265e9.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786039251; x=1786644051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRbzzkyTb3jdfnCCyeAUeJJsqm0ppzhdGbvkGq0K/Zs=;
        b=XNG/e6uO/Es6cJOT/3YjkVedJsPT3nnFnN9KzD/uEtAOlLpFFRwngawhuXLwwAMjHo
         t1bGWqoDouYZLiZ9CZB5bCUERKqpXdiKec3mdRxt7lyeaGFJw/tXt2L3W1fYOP72J/ei
         s7uVawnnkG9JHelGWqHzruR2qVq+G19wbrEmMRj+SPHvqmkxmkGN8DetPgrDBmOIrZB+
         a3dG7zLf2WvkDT6M1nl0AyyIYCV/C8yo3EqRpmB68YJrWbMRa28fz7Wk4SnavNDtwoi9
         sZ+IDWzORRMAd6Yv+WKn4KAy1CLiXK4IS4pqEvzvYBQMaoK5XgS1jATUfzOzmhXdhe4G
         eBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786039251; x=1786644051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRbzzkyTb3jdfnCCyeAUeJJsqm0ppzhdGbvkGq0K/Zs=;
        b=Usb9/IoOnO+z3/Ztb5Slkk5A0JYJWWMGpD7w2wNDJaZAqxZlzLu8RiB4XiDvvkfjck
         5nlNeadjsPFb9hPTsVhp4PQ141U85QYevXGpRsC6LSAt3a3dColN/isy/BEdtPjd3ULE
         1E5PlJ4S0m1ueVjLhHZCkqu0H1KOq+uMcPgnxhr1xvkzUYZgCYojpn4S0atIvFNUQMti
         o8Uq3qPdwVClTDpJMQlVkAfUvU5k6LwSFydl3U5HtyXRQGeeF51YtYRj5CNAm9vTH/6X
         a4K6Cd6nmxKHvTyhfoA3m08OUa/u444hYXfV1y1ImAe3ZlGMHgviriyflulrS8PzxP4o
         5XYg==
X-Forwarded-Encrypted: i=1; AHgh+Rrtkxot6ZTZlZwStGIOtVbCkFIDDliDVZHVUrEGCIjaxeCcCABKAtN1Usgo6Ugc8/eFNn58C5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafnSOcgR1RmRHr1k7d/HuvSVg0ns93C+fqyUUElSvmG8sorqF
	l0XpTx8EnkFOTUX9JrKTklQHELjqk0sZkUpD837uZLb2UmA5p3m7xEEx
X-Gm-Gg: AR+sD13RrbzjSQk/OZhV327E/jsBi3EDgRjj9L3q0fvuzKJ00QvCXgh+eZFxUAyq7xE
	OeMvBbnsUHN8RwWJxXtJfNpUNu701ka0Ev04XSfuSuW87xAZQ1Ve2Q2nC5sd76Cl/IOImtKXUGg
	wlWCASs4gHM2G45fCmr8f5Cm4JSH+tHCpf1ySlsrwGsYMfVZ1xOZfCsf4NxzdoRIDySD6nuzuNX
	zmlP1/unf+9u9XbpYF2QEQqpoMwiyUN9DgZ07Wi0bE7lV10RHMiG/ei1hmV3Z4MQ2+fhHVcitnd
	s30kWyz405zf+Kzqo1qQ947yNQfTiHHrvQt1jHOKHwHpVxf8fPII/YduWqsnFPQTTggvKKmTQzV
	oGmUy82nES4IbiuiIKgr8W3TdYjyVuCWfciKOTXkSZFGqKDA/7KkHLLllEI4KeyYC9RWX6E9FLR
	qT/evoebKGD+pKhCTX51QB+iMPWNbQQpgtpzJFuEE/pDoOCill/I5vMShq4psthjkSaKm4Q/6PX
	KRKx0UJ2JDf1KBvqjd4XXr+qzzR3ikZpESXDQ1qZYsyscpBGUimCCWxMibSD+Wrvfu7GU6SQgWS
	5HPbNLyNp/H1QH1gl8uieH93ytxA60byq5eluVt6C5Gqs8urD3w/0iPaEl8u32hW7D8kDGTu
X-Received: by 2002:a05:600c:3422:b0:496:c18c:f9a1 with SMTP id 5b1f17b1804b1-4994e7cb6abmr177384855e9.14.1786039251156;
        Thu, 06 Aug 2026 11:00:51 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm78547805e9.0.2026.08.06.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:00:50 -0700 (PDT)
Date: Thu, 6 Aug 2026 20:00:49 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, grayhat@foxmail.com
Subject: Re: [PATCH v2] KVM: arm64: nv: Keep the shadow S2 MMUs at fixed
 addresses
Message-ID: <anTJa-VDvgCE-Ax7@gmail.com>
References: <20260806062352.93489-1-kmehltretter@gmail.com>
 <vhpuadbpqligv2pfol6wsxtwpdkdeorlq2k5ifurwgry5pbh5x@jdm5jqm57sp3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vhpuadbpqligv2pfol6wsxtwpdkdeorlq2k5ifurwgry5pbh5x@jdm5jqm57sp3>

On Thu, Aug 06, 2026 at 03:49:35PM +0100, Wei-Lin Chang wrote:
> 
> I felt the commit message needs to be tightened a bit, so I restructured
> it slightly and removed some information I found unneeded. Here is my
> attempt, feel free to use it if you find it better or further improve it:

Hi Wei-Lin,

Thanks for the review! This is clearer, I'll tighten the commit message.

> 
> > +	/* Allocate the fixed-size pointer table once per VM. */
> 
> This comment seems a bit redundant.
> 

Agreed, I will drop it.

> > -	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
> > -		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
> > +	write_lock(&kvm->mmu_lock);
> 
> Opportunity to use guard() or scoped_guard() here.
> 

Good point. I seem to forget about guard. I will use it and send v3.

Thanks,
Karl
