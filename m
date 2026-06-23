Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4A3C553B;
	Tue, 23 Jun 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199051; cv=none; b=vCAmDm71gqhp5jkm4Il6dxNzbqctBCsIMc1oxvxbQg1HNjfNneJjhqeimkgchhw0dHjjyuhsgPNvSvm8ICTQpFN7Wq+dJmaAkrjRkuvKIiMMx3udnjp3Q0ZTbFgbdTPsfiPvmzWUNAbvChgc7EHWibozSPBjA/7SJhQqT+BA4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199051; c=relaxed/simple;
	bh=par2JFVCFFzdM9ZeD965wgZlGQI7/fwJM7j+iYmrSgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO0DkZridpRZih1tIbsbnxBpSlWvFaXVgP+ENAowlALFAG2/4egMBpcaEbxc2mO4ah7Hl8lG/GNC0y0nVCKEOIIskL2CGKuu4LZU5TAU9/AWEFNUVB2hzeJ7yEnnVIIqw6FE35kIyVScZnHzWRP01uNkTXamI3LYWTdRSk60m6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBqi9nRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBqi9nRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5551F000E9;
	Tue, 23 Jun 2026 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782199049;
	bh=mU8lwFyruzZdzA11xuRnbl1GEFR9clqf1ztSluot4xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBqi9nRiAQnQRq7MbT+lP6a9z54LUeGh+uJh7OIZ5ggK05D9KNBGnBvYXgym9xmvV
	 Sf8rVsGKShrmhny5AE4eoBNbeLdhsUg+r1tzCqSXZUrfm8Xl/HSx0UoS/tPQWadWx9
	 ujqKfuneqCUnfmm7Rbw2YwG2pdo42hXI5CEKdGkw=
Date: Tue, 23 Jun 2026 09:16:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] misc: ibmasm: Fix out-of-bounds MMIO access during
 module load
Message-ID: <2026062354-crawfish-t-shirt-d45d@gregkh>
References: <20260623070909.362260-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623070909.362260-1-w15303746062@163.com>

On Tue, Jun 23, 2026 at 03:09:09PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
> resource length is sufficient. The driver statically accesses the
> INTR_CONTROL_REGISTER at offset 0x13A4.

The kernel trusts the hardware to not do foolish things like this :)

> When evaluating the driver against emulated hardware or during virtual
> device fuzzing, a malformed device may expose a significantly undersized
> BAR 0 (e.g., 4KB). In this scenario, the readl() in enable_sp_interrupts()
> crosses the mapped page boundary into unmapped memory, causing a page fault
> during probe.

Are you sure this is the only code path for this type of issue for this
device/driver?  Why just worry about this one?


thanks,

greg k-h
