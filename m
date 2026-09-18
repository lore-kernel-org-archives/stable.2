Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0364ABBC1
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719141; cv=none; b=CSWX75c59FZJmeRJXITlrx6m89jpSxFctM0H6KnWWiLVecbFLO+91h3vm6Xlx6UXSUbSOrrPsvh/qvB5OeMFM5zU3RZQ0H2he77vSOzsAlfaso6hoaOtW5i9+LE1+mW5MZ1QCD9I1lKyK2V6Dpe5h8MlypC3OqZU36xQ8rlv170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719141; c=relaxed/simple;
	bh=RSlF8VpDHyGGzPPSumjtrMkQC+rdi9G5voIFxktO2xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBYkUMRH4RM5uCMMrmapY4422hwvoooEnjjzMJf0P1BOQtyx0GB4Y0Vyh3UQ0t4aaINDcdvL6sy33gXTC5KGFIEQKIIPBbpDZW3Ep38lJlA/k3Nv/3gUcxjBcVrp1q4brElz0jb3m5JGRLPKGUM6HwwFaWqLBameYnSVCqUpFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmxIXDF5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmxIXDF5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so223779f8f.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789719137; x=1790323937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+LHj0w68UNIs9ksSFFw/ZHUYPHct0wG+azZjQnnxdM=;
        b=XmxIXDF5YDcXZ6vqvhzLaVrI9EqJ5oNexvFfoh7Za/2hHsCNFuAkheii36keDrkYYd
         oUzcfAJVC+dsU4bJtNo0MIkn05QuBkXSxIffMr8AMnqSkLXOxRQEnuaGTuY10ssOrzy6
         l+zhJNRx+23dTtIh35LgvuWotmjY+m+MzSfzXRLTKC9m9us5CT7UykMKlr6OKMDHkzw3
         Ac/mPYDyG88mo67bsU+rQzpT0K4Doo1YhjwdkEvNRRXTaJ+4uFGOPFzD4p7WamB1ertr
         d9g7rz+da2gyHw3hKipCPzB4Oi7SCoGAa8dYQ8OzDlxhscEKjJV68Fo1DtQw/7S2NOZY
         PAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719137; x=1790323937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g+LHj0w68UNIs9ksSFFw/ZHUYPHct0wG+azZjQnnxdM=;
        b=1542qNLNdVFhlAYMwZOavtAz0DFR+Ew3vsZPCFDYalgy4xMh77HXP8HuuxYZtQbN/u
         erwqKsXUKZEmZ1KrNgvvhMipAQyI92mAXKyO+J8K1Uyyf/7d/Qi7fdOoMNPAlfO04hal
         Xm6W8oUpNQCmEVZljaAnUx9Tit6hBTZGlqacIVV8gRTyXTW8w6IZYqXj8DahaEhIrFGZ
         BX6sWgRQuJjc/7MK2MIlqvPrpB3FavfcCKWGbFbu4waRTMh95R8sOvlBvJRwd3HCXEE7
         3DXTj+SZlRxMMAn6M2/vB6sQzxnCDYoMwfuQJv2TedhmJ1204epfXynDLDjSTQC/BjVs
         YX3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwssjvidyHWz9AS5zeKMxoCgSFVO+BlZVrjazBl6VA6/YhA8W80gkrQG8NiAYxGTO/Vqm3RsAE=@vger.kernel.org
X-Gm-Message-State: AFuF++mIsFhwKqjdNJfhRazGJsu7uhGn53uEQshGcOQailFE5zIfhyJB
	tuiNtJRzr8B/BJR51yKdwQgyKR6V6hr+jC0IHLWMpmxhp4Ky2ybM2jzU10aAKPOUjQ==
X-Gm-Gg: AYBFou2lco4Zm/mzLV7mcdnXjExyp9C/sUSS0Roh0ACLUDnsqp2OB63GLeSbYcopOIa
	AevG6ha6hE3DqBBtILUAT6wYiUsLfjhIKHqVbqjWgT5bTMUmKhoW9qHITmvw2ptNRVUpyuJDEqk
	R+YC4Z+P6OjZ5zQ9YWXHHQMVQb8ibg0AJPl0H3cQhR5dWcki84dKXTG7B4ip1pG5wGet2taLJ3L
	Rr9EOwg98gRvJcAmQ58WSZy/xQGKt2wdyAO2AvPJqrxKKhDnvof9epJqrU97Y+baSQROY16As69
	epcZLw/Sxy4oBkNc7z8z0RqM9IBjmOcUvb9x6Ayurm3tFtA1tm+GXrbJPpCkhx4CQIo/9jz5cRf
	JhkasR7PR3wyuOg+0ykg5ZgCd7H4x6nrA01hJtcz6+jzIGEytq3/NR1mnPZJ3vzACYYRInc9VrF
	P8ElOOPRK5nDb7Jkk34DM7cxYUmLrvs9toOV7/yWkGnGd6Eoi2WkiXvtnO6gwuRBJXDbRagU8uH
	m62Iesv/B6MXwOTZQEWbBy98W2jIDB9uapiZkmJUrnE
X-Received: by 2002:a05:600c:354e:b0:49b:8f18:714a with SMTP id 5b1f17b1804b1-49fc57226c9mr17380515e9.12.1789719136409;
        Fri, 18 Sep 2026 01:12:16 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff56021sm2439656f8f.18.2026.09.18.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:12:14 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:12:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] KVM: arm64: ptdump: Check the page tables aren't
 freed when accessing
Message-ID: <aqzyW6oJtStG_nSn@google.com>
References: <20260916230337.4162485-1-weilin.chang@arm.com>
 <20260916230337.4162485-2-weilin.chang@arm.com>
 <aqugxlnqegPzMpB-@google.com>
 <ezplrvcw7buhd75v5rezvkhbgdfldxklqavdpnxl2fad5thswe@kctrvkjzr6cs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ezplrvcw7buhd75v5rezvkhbgdfldxklqavdpnxl2fad5thswe@kctrvkjzr6cs>

On Thu, Sep 17, 2026 at 08:30:49PM +0100, Wei-Lin Chang wrote:
> On Thu, Sep 17, 2026 at 09:11:50AM +0100, Vincent Donnefort wrote:
> > On Thu, Sep 17, 2026 at 12:03:36AM +0100, Wei-Lin Chang wrote:
> > > An open debugfs file keeps the KVM structure alive, but does not prevent
> > > mmu notifier release from freeing the stage-2 page tables when the VMM’s
> > > address space is torn down. Therefore page tables belonging to the mmus
> > > could have been freed when a thread opens or reads the ptdump files.
> > > Take the mmu_lock and check mmu->pgt is still alive before accessing the
> > > page tables.
> > 
> > As Sashiko said, the read_lock is probably enough, including the existing one in
> > kvm_ptdump_guest_show()
> > 
> > With that change:
> > 
> > Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
> > Tested-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Thanks for the review and testing!
> 
> I agree taking read_lock is enough for most of these, but changing
> kvm_ptdump_guest_show() to read_lock could result in a dump showing
> weird output e.g. 0-sized ranges. This happens when the dump reads a
> block, and a parallel fault turns that block into a table, and the dump
> descends into the table later.

Now you say it, I remember discussing that with Sebastian when he wrote the
patches.

> 
> This is debugfs afterall so I think it isn't a dealbreaker, but it adds
> another purpose to this patch. Maybe we can change
> kvm_ptdump_guest_show() into taking a read_lock when someone reports a
> scalability problem when dumping the page tables.
> 
> I'll stick to changing the other ones into taking the read_lock now.
> 
> For future reference: KVM_PGTABLE_WALK_SHARED is required if we want to
> change kvm_ptdump_guest_show() into taking a read_lock.
> 
> Thanks,
> Wei-Lin Chang
> 
> > 

-- 
Vincent
