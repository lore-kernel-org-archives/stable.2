Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880B4B049D;
	Fri, 25 Sep 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347969; cv=none; b=aw4jHYNzpZxkeBr4iWalRHijpv+NkEYPXFZTn7Q47NCmg9VaQvqmAGn+/PiN9Il91H3ncKs1Vlw56DpTbizULnL8GUXNkvJumaPg8pJBP1NTIMdOAWmR1VJMVc3PBXo6kH5Bl134T2afDhN9gIrUiwzrl7rK6CnFQqth2VaItg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347969; c=relaxed/simple;
	bh=Hl+8wz8tp1wu8qAL6hnJ8ublCc3/qSu9zox/vnjT1Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew1u3ucgil652hj2bWM6p19Ddg2OMflUk0msgk7IsM2Nav5N+h1Vvz8tnDlBFZ2bPpo0v80xwTn6MkFtrVdF0Pg0RxARvTAAgWgl6tZuLHCU4Pd8DWTgewIuaTFl7Z/TH15KUe2HDzHzZCDIiG4x0UXCR4emWt+CAWUkJqb5Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKKK8XKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKKK8XKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9D21F000FF;
	Fri, 25 Sep 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347961;
	bh=eqwba8uIyIBHU0D+mbWaPP6/65+16kFFe7c0vWebTx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKKK8XKP/if2xktccrO3rxMkmW6KauTsNF/lj7apJemrvIkZh0tl++Rd6QTb/r0kB
	 7aiSZdBVt4ia9O5hAGENSxqkZ6y2rmcbfkuKUCjPZzgPw2pwDyiOl+fIe5iyPYZ8H/
	 Ax8/uJesAMhZVGETEX/Idvmy/JXR20JcAIQ/6lnzcMqNkB+Zj5dIMi78/ThMizoyQa
	 RuS8y4xzId+2brqX6xy9hkRWnXdYwcBc8RPHksQMo6YqBf6F/wgkB6axS4oSzJmBOG
	 SJ+tevz7BD4d/3Z1HyECvqS51nX6U5rChQ3MB+b0dlPtJiXM64w+BkSrns4wj5gvKM
	 RgVt6SXFkZNVg==
Date: Fri, 25 Sep 2026 15:52:36 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, alessio.bogani@elettra.eu,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net v2] igb: initialize PTP state before registering PHC
Message-ID: <20260925145236.GO13925@horms.kernel.org>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
 <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>

On Thu, Sep 17, 2026 at 11:02:47PM +0800, Runyu Xiao wrote:
> igb_ptp_init() currently initializes the PTP lock, work items,
> timestamp configuration, and timecounter after ptp_clock_register().
> The PHC is published by that call, so PTP callbacks and timestamp
> interrupts can run before those objects are ready.
> 
> Initialize the complete PTP state before registering the PHC. Skip the
> setup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration
> helper is then a no-op. If PHC registration fails, cancel the work items
> queued by igb_ptp_reset() or a timestamp interrupt before returning.
> 
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@seu.edu.cn/
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> ---
> v2:
> - Restore all PTP state initialization before PHC registration.
> - Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
> - Cancel both PTP work items when PHC registration fails.

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference: please post new patch revisions as new
email threads, rather than as a response to an earlier revision.

Link: https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Thanks!
