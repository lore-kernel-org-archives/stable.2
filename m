Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82390418351
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971225; cv=none; b=cK1rpVj3BD0S7KIgrrDgmC/5ryn+6rSzP+hgpqCd9qfqEvKubtQK2uyYM6JzbDcDaHklPVK24wL0FRp7hNP3M1IwQJ2GdQ4RxGiQMKNILBjQVvyrrSBvLT4+CeFICjGsP/+qdZYZlvoZIwXOr43QlTzhX+xCavNB5jP1IYLWEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971225; c=relaxed/simple;
	bh=92/LJ9ytiCnTo9nxdyNCfvLsbqsb1dRXtZFbNV2qfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN6cCLqDrm7gS81k8R7xWrXckrGDEJXQHF3mm1t1gWMe3fV7JiRYpToa/R6hBPxeCDJCPcU+ijCkVMJr+y4mn/TxitJ/Xk22SW0ncN6/rMoYIpBjR3fb5VPM23Y6NyVjOjvp2bWYycNB+YN+Bm0WbbE7iJE77xoMoOzB4SQRbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+vnvTrV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+vnvTrV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso261855ad.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786971224; x=1787576024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/HO5352xrmxomcN/usyEVXCVrY50VpsMFDwsFMZfKc=;
        b=q+vnvTrVo4MslOUavPP0NIbDRH/ble9BohqbLZZgLXM+e2NM3DidaFz5e80kK3FIuz
         K5Zwvk9IzaVuKkNyY4mnn39mSUQEjqx3E85fRuO/FCsjH0iibn06nvaYy3+52003MIMc
         Z5kgnRURj6JSr2py1wJ1f6gkI6nHQXMyPURLmrSZVO6ftS8VGyZ9EevAHAL3o/t8BK8A
         T5sV8Q+LU7dk7G4BxG1A13S7k4h5RDK/KaLVheZFm3jHGE4xzCFyEakoneL191rTtzCn
         FSEFhmL0MLYg7bCuBKUXN/MErIn3ZlHeAY0j/QFqZSPsoYofp8fPZh73eVLLl/ogkjC+
         n+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971224; x=1787576024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/HO5352xrmxomcN/usyEVXCVrY50VpsMFDwsFMZfKc=;
        b=rwORnGtjk3wIiAKOu8FQLoRyDc9ZeM4DiwjwRT7zmK4RFzxik/ROw9krgXHDm8VUwa
         9pXimEjD+jagBt+6oEjqFfbnjzUV+/4t2VdvuWbEs0RcTexYtj6+lU513USHjc9Aw5DN
         w8540ahKMfsYxc2kdeA7Z/zv7mgd+rKvKrgLoLtyvsTizblhIjGGHllirD7fxHPEMOWe
         DDINwn+0r5qQW+MfP3vstIacood0HVjLs/r+UonSKaJRUFlLaszBgbxMMCjGEpxtRIKt
         Q3a7f6ai808QEVqmIVPP64nt2CONg+TXba2atphnRnW8VWqEx5sc9/PmSK4aTvy+thy5
         rwzw==
X-Forwarded-Encrypted: i=1; AHgh+RoDZpv5fq35JsytkS4EBisMkSwmKYGEyowUmz7O3UUu5PX51Awefb04phmVrWabzmRLNueUuro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn9SjGF7H/EQ0NQ+AqKtRsJTvW7ugNxD33oRXvLInvp5uYMsQ
	i6eZ/09sStfgmzIKORYw8MikjatWCUG/+npms7tf1QCkEuVwU54tp365CrVKewHIMg==
X-Gm-Gg: AR+sD12iRthQk6yQ0qJhHloSo5HL+F7J01bVKng4l3e14DQ0yZ+AsDMh6ybRSCM+9Ek
	LbSn9dotuOHufZAq0UTv6Cmsoyveh6llLmUw8TYohtnzzgG00jZwmC/OEjU7GGwXFU0Z4+Wt52j
	TCJuXUZiHzCVhWvXBj+yAVhLEI9qe6QCjOmba8AGgESWHHiUnESfKJa0b6cZqZYkBJfDu8lsM+1
	SEV/z9OQnYa20ToqeJWi2H3RKJN+WrnHEpbUNpC9kSHf241Aq5fvzmLGtWaje9B96sA1y30IkLq
	4BVO4wcFIXemQ/YhuuPZ1Vf+VmmIF4D7l/nd2Zg4sOoYxvSGp6rylHkW9WHC4TOhgEuXO31VBwo
	m3/pmWk8yyn+hFb6dSrUuiC0FvPA8lvjhopQShyw1nQvx7mLbiVhhqxQJUT8ZndOmZko9YMFFKr
	cnB/y7g8/ZK1arsmnCmV66yUhZMGxIpRJkM6NmruFRrU8hQAMJAeRy8kTA81uZ9F9hmLBzxyl5c
	wsQJhJSzrJ0MvZIYEqiWOM=
X-Received: by 2002:a17:902:d983:b0:2cf:41ba:96b8 with SMTP id d9443c01a7336-2d590bad516mr5207305ad.6.1786971223287;
        Mon, 17 Aug 2026 05:53:43 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499d4bsm5258655ad.4.2026.08.17.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:53:42 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:53:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmitry Malkin <dma@nebius.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <aoMEUDQKlaWzvE8n@google.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <aoLtgeYLpYobpyKN@google.com>
 <20260817114407.GB1175472@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817114407.GB1175472@nvidia.com>

On Mon, Aug 17, 2026 at 08:44:07AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 17, 2026 at 11:16:17AM +0000, Pranjal Shrivastava wrote:
> > But, regarding PCI P2PDMA, you can still enable it with ACS enabled in
> > the upstream kernel *IF* your hardware supports TLP forwarding between
> > root ports.
> > 
> > When ACS is enabled, all TLPs get forwarded to the host's Root Ports
> > instead of getting routed directly through the switch.
> 
> Generally nobody wants to run like that, the performance is
> terrible. The reason these systems have a PCI switch is because of
> performance of the P2P path.

Ack. I was assuming the enablement was the major challenge. For perf we
definitly need to hairpin at the switch. 

> 
> Jason

Thanks,
Praan
