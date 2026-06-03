Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFC374E66;
	Wed,  3 Jun 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528073; cv=none; b=fmE+0JzQCbj+N09zNPHcTJBYupm2aLzybxTEsDULnbPJafxbs4in+5J/WBRpj4MBd7y9dUYyIGeO2+yRbHdoe1PuaoJdkj8ZGeIKDmxkzNsN/LcclT7mnJoph/XZddx2rSJG6XBNC4Kq1SIQWWZCNwuoc/CCNP8Q/Y6oWGAlMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528073; c=relaxed/simple;
	bh=3IKC4WfDBL7PuypJ/cK+RzIQJqFPQCs+k2glHaWyuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv2kQ8kUhgcDInr9sRNqgikT5QY9XNVjnjhWv0nIoWzHdYQKCZMDTdUwl58HcYLfFIrdgW+6hN2EuderIi5kS2IvT7H/yyUWTwAWHdyNzDvvak4zFxe+jSLVeRBopwHwz8S90ljZMk4BiIoTyNc09ep7k4EkwvnURprGfWYPa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW5uNPvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW5uNPvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132E1F00893;
	Wed,  3 Jun 2026 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780528072;
	bh=63lWd/7ABwncvEN5kcTFLVuVMpSwlY9NkS59RGzcqao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DW5uNPvyZjZ3q6AmHxFScbM9FiVEry5AAQP4Fh4Ks3HzceTFm+/lg74OMFoPOI6vn
	 jDLWZWbwBdMspHtldQMuH0+/L0ToqXNHUxdD5XmNLG56KmR6t1V+fSAo5doTLW25re
	 3E8ucZhFVZqWJUe4IVHBBMf0ICkLw4qZq+y9pfl8bHICWw4fpC/nEwCxZa3WwB298h
	 AhoOWO+IzMCBXrXGhISsLOjtM2YW7cUWQme/XxVgLd5dD9S69u19o8188+kjeIwb9A
	 6pWuR8OeDQ8QrZYzLoe0D6RvJzRfYpL4CeeuEMuvnH0NRh/GyKIvurQbKVADzJSZTb
	 xdkqibzBjLoNA==
Date: Wed, 3 Jun 2026 16:07:50 -0700
From: Oliver Upton <oupton@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: maz@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Take the SRCU lock for page table walks
 in fault injection and AT emulation
Message-ID: <aiCzxtzmx1BIw3RE@kernel.org>
References: <aiAZfdeyanIvP8SD@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAZfdeyanIvP8SD@v4bel>

On Wed, Jun 03, 2026 at 09:09:33PM +0900, Hyunwoo Kim wrote:
> walk_s1() and kvm_walk_nested_s2() expect to be called while holding
> kvm->srcu to guard against memslot changes. While this is generally
> the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
> respective walkers without taking kvm->srcu.
> 
> Fix by acquiring kvm->srcu prior to the table walk in both instances.
> 
> Cc: stable@vger.kernel.org
> Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
> Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
> Suggested-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Oliver Upton <oupton@kernel.org>

-- 
Thanks,
Oliver
