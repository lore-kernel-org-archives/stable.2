Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025E3FD969
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198564; cv=none; b=AXBk5Tr20L0DkzqaPgir17DGZgwCQ+p+HUNzYUbD4PPzB+Pk8UJ6BB7vUtVNh4KYk2MA12iBYoMHrR0U6z8gjM5WY3zWsquU0z0+EUOCPRV3mgcZES+JMo6yROxXTTeH5+S6m6J4mKX5PcKbKaHOwJuOkHVgrbeMj7eLDUyna7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198564; c=relaxed/simple;
	bh=Hw9vFtfLNadtKGcW37IdGOgqwKhIf5argLx7FSCLVNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ1h/D7Wxb9HcAz2+YXggMonQLUz+0icL863yU9mLGZwvdkVAsz1osCTG5PE5wRKPbf+qViXWF4VEofpug4AfxbkwCHqF5xtl88yOwbuo1TIeU4F+h1nzHsecEhpU2y4W6SjT9xFutHQsSwRXEZe/I9ArSGa+SeTqRlIQwSazTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dl5+EOLf; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dl5+EOLf"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a222edc62so145569585a.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790198559; x=1790803359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6JszVb+RTu6ALEMMDucuPIFOfd98yGFKjSHhbkgHgjU=;
        b=dl5+EOLfz+6ghzeb3ZMIe1VMfK+/ddoyHUT4H6XZM5TyY2WwAqNnWnGJP9PpGJ/lqU
         2Hn7MtvUHcYDwas6eouw2TCs4dB/592o+l9omfa4/G/4+XxMqRmT9w1tDvQVfTW7M1EO
         1krm7AfxA4uqME8K6uDuiz4vCmGRCI0qN1niIrQqi4I0B4lJpdjkGpudT7++yDY81LUJ
         LtTNT31KA8lDOTNKM/CAW5KinWLSmH/zPleCAM3KS5o2fXrhPEd1XicpXludiAtybYCx
         y3itvVQuZhrq9WqY5zVPNhId1Phfa525vRocAYNjm6i8sX545aP06kG2h3AQ4Cux0hqB
         RgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198559; x=1790803359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JszVb+RTu6ALEMMDucuPIFOfd98yGFKjSHhbkgHgjU=;
        b=TXZ4m1bQErvi7qvdEZxYOElEdC2QGHGNVIKc7NpzpKX1vSgK4uSaHBp7/+0iCxRuz5
         I6awTaMnU2qPQzdzlIXKsCeNlQax+jGJ07B+PFr9tG6WEeNaJZPXwz9y10jqtHQoro1g
         bePfhoe8k3CS4LWql8Le9mQsN1Epxz4uvaWkZ6EtGmc/kgCKLBwLBiJystrC4VXDODC8
         2XBR45SMMUH9/jev+7GdiCcuZg0hxlEiayUkITmW0dJfl+S44E9wuTo83lhYqUEmYNBs
         L2LKgbFoyaIhYGuH64AsACDr9HVD7dazAFGc5hiQ5mb4AQUxxcbYUwL0RDNGpQGdnzYD
         ZQNQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+o/LttNIu/DoD1PIp10FdCXrqiKZ1I+Nqi0SRYy0ClwO3D9Gmfvnn7Tn1F9k5X8GMkVB0nfo=@vger.kernel.org
X-Gm-Message-State: AFuF++l1wHYIWpYi+Xa+hQQnVSb2xePIxkBe5E9V4WFgTWbpSI8cNf7w
	BUchIoi0wfmjPK57zBa+b48U3sqQkruFZXQKBzNzEeBZ9I9vwzp1cAmtZL5NA7OOoAnhzB5kV32
	IKWmniKw=
X-Gm-Gg: AYBFou1H+YFyxZDsBN0h+gTKmmQpYSWkkiAXvSY8Ls5LkNkGdvfMj7kZd6w7vt1IhGj
	341IcwzF8WVWvyZnYd66RoFiaddI1x9yd5pRxbe56sYjriqeSwGfWJH+Q1mITo7sqeZsXbkEAUi
	VjxoQDNbw+Z4HKDek60YOLYSpgqvltTLWJ+NfuahupaW+5dQD4Rlm/vMu7lRpIygVTs7vQR+KBN
	gbF8joFJUVmwmgSAECc0mJPN9Tb54jhkeOrQTBejFecjW4RWco3RKTJen5izG1Xqdh+Lmlq8UVn
	xYF44Z105NDiQZ/S5t12rDBhMPdlNIJQEg0LfKJXZii5yNFDX5iuJenbcMljC3eG8/291tHzfE/
	0+1oUGvvwnPJxng6/sxAd2a22CX9XBvL4kp/sQ52npUh+DU+I/HzYgR+wcPBRlCCVIOH0IE5+lD
	EfU0wAwhlfI4tSn7yZN2uDG3pQW+rsanBwN7pHp+PGMebxlfXw9JVgic6u4nCo+EzuOrWiwaRvm
	WYaHUQUDsSsLFbELS4SdN9QtBZijcjQLl0XSOuBPK43qUSxKgSgr/q6Y/ilEh68Aw==
X-Received: by 2002:a05:620a:225b:10b0:93c:b10:7243 with SMTP id af79cd13be357-93c346c2cabmr50513785a.5.1790198558842;
        Wed, 23 Sep 2026 14:22:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248cf620sm315660985a.43.2026.09.23.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:22:38 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:22:36 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Message-ID: <arRC6lU7yJCrosDp@gourry-fedora-PF4VCD3F>
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>

On Wed, Sep 23, 2026 at 06:45:41PM +0100, Lorenzo Stoakes (ARM) wrote:
> It only makes sense to manipulate VMA fields if a new VMA was allocated,
> rather than merged.
> 
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since it
> never touches an existing VMA.
> 
> Currently, these fields will get overwritten by whatever state is
> established in the mmap_prepare hook, and if the VMA was merged,
> vm_ops->mapped will not have been called, so this could destructively clear
> existing state without replacing it with anything valid.
> 
> There is an implicit requirement that vm_private_data and vm_ops are
> fungible across VMAs which means that losing the 'new' state is
> fine.
> 
> However in this case the 'old' state is being overwritten by potentially
> invalid 'new' state, so this must be rectified.
> 
> Additionally constify have_mmap_prepare while here.
> 
> All existing in-tree users either derive state for the tree or are
> unmergeable due to VMA flags, so this has no direct impact.
> 
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

