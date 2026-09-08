Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5975476FA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872658; cv=none; b=iOlXfQ91fTC/5XQHKTHRqWPOJQlVcBLARuZARuwKhXVSPGPfw3M6HwlwYWRw1vZ1Q023W4e/lxq0OjwB+pGfReBuGB7is54OTGRb+1qn/iTvetSu2SaJw9J8mBWP1BWiRqK5eXR+UC6f67uqvwhtAbOzUwQR4GFEY2S9MZEmeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872658; c=relaxed/simple;
	bh=Us/q7SLbzZ4oV0cqtA9AUdygdN3iWgHORK09/87t+C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atf3bAjmmlRnAPkloAyeDdzE4w2tMVreLvP+LJlik/MUINaYMpG3VE+DehZeLCzQRmWZ/jORuQ2sc7CX/3JE5EEZqSCvUHklZ6qafI0pVWukklG0Pxrr/hGJ83Z3XkRCmWXzeZKbssNap9cMsafpucahfOuSI6DDhRxpWZMFBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxziIFnX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxziIFnX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c259e5c22ffso390752366b.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788872648; x=1789477448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TF2FBSAbA99rTI7hgd6XJ5POJVbB9v0L/f44ZOGfZAY=;
        b=sxziIFnXwxCymezC0ZKR8x8fO10AH7DBeCwwIR7eD9XJzKS5I/ZJI8q7gtg07fkBm+
         hFbg4RwwYXHIKOVlIO2xTO9mRGNRCbhpE5HT4b9wbNAHgnODx+oBTq4JHTdCBS1+zzn3
         RuNYDbTX6/VuixmXcX0rXRJCO5No3z9ZUz4gREwWZEJw7W5V4UfM7sjD6AjKoweZqLJi
         MRjpw5TGBzztrukEbsozKHnXPaaEaUII29rTHawEjn3sRqBmZD7NnvgRJfiuVgZTP6Hz
         3xE0SIRKqTYpn0mMFl4RI5HaGiqkwREyaqL2IsVdX5HUQLtEH6+bda7x783i7+JK3uYD
         yOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872648; x=1789477448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TF2FBSAbA99rTI7hgd6XJ5POJVbB9v0L/f44ZOGfZAY=;
        b=gw7fO1UcKS+k7MrsEiQggqTDMloqpWf6lSV6xTd4EsGW8VtH5NbCk2xns1I7Z93sGI
         ATrqnSVaI+57ONT20f+jFU/xTBYD+uksEG4Oq9UqwiVDgRz11hqjoiU+/BDmqRr6PR3F
         VJNWODq6uYDIWU14zVh1q5JyOudvjSHTY45K/vxHOHR6f5ewJxYLgtY+PvF6S9KiTfet
         DhI8qQ95BkbjczYEOWteRL/qIMkeUZM1EEfPZ4g2mk3MG2qZFB7dAxpagKhT8vVoX1JB
         ZAUr5gEf2g6QGO9vQf4SdLkpb6rQ300CmU3GAzNzAsps67MFFFWPo3QgEcMAaVn3avj6
         0DTg==
X-Forwarded-Encrypted: i=1; AKwUvBykAf/mJaIMt6XayDxnK2ErBTuAOp2VpXgvF3QmZqVkc3ZWagiwEJGvvNPHiLzpqK0ep6upDHI=@vger.kernel.org
X-Gm-Message-State: AFuF++m/DhPtM5fsncXy3YoFdd3hZ4dFw8cdi2ljud5LxHf6UOlxSbDf
	zk/VT9CGBB9oYCsmchdLFVUJ18QshrkXOSNXBoR7n3MA8Bprk4ERTIdI3WVYkMMzNQ==
X-Gm-Gg: AYBFou0mYdBzns3LR3/FSdFo+4teqI/qh2wUHZqvN4jrboo4bGXK8xRifzJ6K3/6/rH
	QWKuu9RNWTFVsxfKMcQdZd2h9JKTpy8cmdO590yq8/GFZ8PDmKFxqH1rA0stqhTkRxR8ojs340z
	NlCjdgRoVNg7HuVWpgTd8gzZR8TBTgj9aZBeCVuBD3ul1WUtBfAUiREk6OGTvJW4L94AOXnNdFi
	lR/rUXYsbRC7Gp34t/O1c0+y9MdqLz5zIYDLkuhP/TMJbMygUN21QQaY0SHRVnAiizNei87annt
	zsy+HJPwIA8757erJAEWvfqVC2+ya61dw5m1ys8lYM+2/K/otf1ihWSUGGA4HmGPHE2zQBUoLYS
	ZkuN/umxVMpiNZ2GjJme3bC7DCA2hczs96Q9BnhDR3ytHdwsXcc4k1LF8j62TqC1D6GY+zEbqfM
	4ODY51rqMZMzibeQsHEj0pSQzlaSWHDuDw7JyWfMjROsJzdtAOGx1mQXYjjioI66pbOothuvHB5
	knbsYts89uSoqVP4f6skVrJt17y88gv
X-Received: by 2002:a17:907:c081:b0:c25:6230:dfcd with SMTP id a640c23a62f3a-c260c9e3320mr1176298766b.15.1788872647225;
        Tue, 08 Sep 2026 06:04:07 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d582304sm623294966b.43.2026.09.08.06.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:04:06 -0700 (PDT)
Date: Tue, 8 Sep 2026 14:04:03 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>, Keir Fraser <keirf@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Hiroyuki Katsura <hk590@cam.ac.uk>, Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: arm64: Fix host access to the EL2 stacks
Message-ID: <aqAHw8Is0bNBbXUl@google.com>
References: <20260908110713.1540304-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908110713.1540304-1-fuad.tabba@linux.dev>

On Tue, Sep 08, 2026 at 12:07:09PM +0100, Fuad Tabba wrote:
> Hi folks,
> 
> The per-CPU EL2 stacks are initialised as host-owned after pKVM init.
> fix_host_ownership() walks only the linear-map alias of each memblock
> region, and the stacks, mapped in the private VA range for their guard
> pages, have none.
> 
> Patch 1 is the fix, and it needs none of the other three. Patch 4 adds
> the check that would have caught it and would catch similar instances
> in the future: once the transfer is done, walk the private VA range and
> fail init unless every valid leaf is hyp-owned, or is hyp text mapped
> without write access.
> 
> Patch 2 is a fix in its own right, but to a different bug.
> fix_host_ownership_walker() matches hyp text on its stage-1 permissions,
> and that test hasn't matched on a non-hVHE host since 7.0, so hyp text
> is donated there rather than left read-only. Nothing crashes, but the
> instruction dump on hyp panic reads a page the host can't access, so
> the Code: line comes out as question marks. It matches by physical
> address instead, which is what patch 4 needs too. Patch 3 splits the
> start of the range from the allocation cursor, with no functional
> change, so patch 4 knows where the range begins.
> 
> Based on Linux 7.3-rc2 (df2908090cda3).
> 
> Cheers,
> /fuad
> 
> Fuad Tabba (4):
>   KVM: arm64: Transfer the hyp stack pages out of the host stage-2
>   KVM: arm64: Match hyp text by physical address in fix_host_ownership()
>   KVM: arm64: Move the private VA allocation cursor to __io_map_next
>   KVM: arm64: Check every private mapping is hyp-owned at pKVM init
> 
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
>  arch/arm64/kvm/hyp/include/nvhe/mm.h          |  1 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 20 +++++
>  arch/arm64/kvm/hyp/nvhe/mm.c                  | 79 ++++++++++++++++---
>  arch/arm64/kvm/hyp/nvhe/setup.c               | 16 +++-
>  5 files changed, 108 insertions(+), 10 deletions(-)
> 
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157
> -- 
> 2.39.5
> 

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
