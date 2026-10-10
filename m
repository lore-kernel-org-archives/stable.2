Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF737C0FC;
	Sat, 10 Oct 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791641146; cv=none; b=ZezQtOZZmVZD7MX1oCOi6+qcybgNxN68mqodclIWG65VuK2xTA4yP6vCpEVBkASBBiK726ePhdLADElQXHqHJQItL0vrf0PVJu1Ntc+Q8U5cUnr4ViRFHS6oRTCAT0nyQ7mDgorj1jx7kbBgrXNXcSiE5ra8b7NiGPPi8p0cqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791641146; c=relaxed/simple;
	bh=7/6D07oY3BQvUronBIxd6DIvspYz2npT2JrCk8e+Zes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kljUztY3ZnDoMK/0rD3xdNAzUC/+c+XiJ40Gxgzs2rHzIfbYzjXBxjlyvIKAa8Bl+Rb3XOtlzSYs8DzGWjNxlwFsRjItSN5UwaCbi5HMMZJPH1ECWtWtM/SMbaotG6rVaUzjw/UZCTg74Yr5+2Ufk7+fyk46ycEA4YF5OtjSvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpsFX85s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpsFX85s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE1E1F000FF;
	Sat, 10 Oct 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791641145;
	bh=GyknJpqFfggtxhblqqqi57Fv191t8GDatIYjjn2u/JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpsFX85sisLmYIOVIujbckkjWQzvbR4VG8YU5nv2hZcP0Unh0CDMZFlk357+cKfaa
	 hNP2TOAljwO6WpvQm9jP2erAvKMCCXI50eB7DXDrDD54HaU4uo5Yx7mgnFO7QoBxYw
	 zGuhfmwht0TbRxtGPYQzuSCSGrgPVMttq6lum+USoB+3BSMjY0nsg0KWyOqa7Gh608
	 0K/4kZyGAbL/gURVxQZ4NobN0uEQRRkIfHuKi/IH7Ba1U3ivMjZyhNo99skTPvXnRp
	 ddX+4bv49B/7OZrkNpzsWf77HD2ydvM8kVuWlF8j6RC+AlWTNBqV6SN9l8ogD0fqFf
	 vY4FIYCwuek5A==
Date: Sat, 10 Oct 2026 15:05:41 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Message-ID: <20261010140541.GQ83879@horms.kernel.org>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-4-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008125754.3520773-4-xiaolinkui@126.com>

On Thu, Oct 08, 2026 at 08:57:54PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
> pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
> but neither of the two error paths below it gives them back. A NULL
> from ice_vf_vsi_setup() returns -ENOMEM straight away, and the
> release_vsi label only releases the VSI.
> 
> ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
> queue mappings and the VF VSI of the VFs it already started, and the
> eswitch attach failure path releases the VSI of the VF it is working
> on, but neither calls ice_virt_free_irqs(). The caller then runs
> ice_free_vf_entries(), which drops the last reference on every VF, so
> nothing further down the error path can release the reservation
> either.
> 
> The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
> the leaked vectors stay reserved for the whole lifetime of the driver
> instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
> pool that ice_set_per_vf_res() divides up, and after enough retries
> ice_virt_get_irqs() fails with -ENOENT for good even though the
> hardware vectors are idle. ice_dis_vf_mappings() meanwhile re-points
> GLINT_VECT2FUNC of exactly those vectors back at the PF while the
> bitmap still books them to the VF.
> 
> Release the vectors on all three paths, the way ice_free_vfs() does
> for a VF that is torn down normally.
> 
> Found by code inspection of the VF setup and teardown error paths. It
> was not triggered and no stack trace or error message was observed.
> Compile-tested only, not run on hardware.
> 
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

