Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F982331EA1;
	Tue, 30 Jun 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811316; cv=none; b=fss+FmeSmqdU1QnLy6cnfYwUTzaoi5J3bXDKD3GzaOImvgCKkgUwRwsHxLj/nW54rnk9nNkRIc5Hwy/4r3qUemX9hXVMkjsUFOcM4n+EmAjOWIo4GKuCYrb2VD7IC15UL/ZG4ftLENsseDWdStSfuRdQE0Y9Kmwoyg/0mhVcZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811316; c=relaxed/simple;
	bh=Ei8HZnDIpEU1SQi8sI2tGRTbiKCMoBDZ3k2LMoyZNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ42eXWs/GOcyz0sfU2e+WCjpAD6/NOBNyj8JPLHZsSXqc0JfumDMUo/w7aEPd77a3W/PO6H235PHATqhS4XRVPfrqGpQOhYl8KaFWRfd4JLI98rEH+q5wpH5BQAR9LLdptbkkxXhll+zaAD71a7sN6mAh1s4GFBlHRDHfjuP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQMZz+Rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQMZz+Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D51F000E9;
	Tue, 30 Jun 2026 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782811314;
	bh=8UVj/xbCgEWxRoJHuLmtaRwcHH6P04xVZjzmRYgd69w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQMZz+RnUAGPb7y8VDGwbYpRXk8/gR7jpxdyA7xypKYocm0TfU3xtlGEvgsHFHbXy
	 Ne66zYC08qAlefoIOXkpEH5HbelIW5u8IquK60mFLkBAebdxiiGHnOAnc/EPl9UD00
	 DzCnihP4oakIUiw90A5Qp4T5AE89R5LA7puEYxNU=
Date: Tue, 30 Jun 2026 11:21:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Andi Kleen <ak@linux.intel.com>,
	Alexander Martyniuk <alexevgmart@gmail.com>, stable@vger.kernel.org,
	David Airlie <airlied@redhat.com>, Sasha Levin <sashal@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error
 propagation in agp_amd64_probe()
Message-ID: <2026063021-ripple-uranium-f24e@gregkh>
References: <20260629102124.252403-1-alexevgmart@gmail.com>
 <akKR2bNYFokN43Sk@tassilo>
 <5fbd827c-4c4d-4364-882c-41d2fe666fde@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbd827c-4c4d-4364-882c-41d2fe666fde@stu.xidian.edu.cn>

On Tue, Jun 30, 2026 at 09:23:50AM +0800, Mingyu Wang wrote:
> 
> > What is special about this virtual environment? Nobody else
> > seems to have seen that in 20+ years.
> > 
> > Or maybe the Fixes tag is not quite correct and something else more
> > recent has caused it.
> 
> Hi Andi,
> 
> 
> You are right that normal users will not see this crash in the wild.
> 
> The environment is a QEMU-based driver fuzzing framework. Rather than
> functionally emulating specific hardware, the framework extracts device
> matching information from the driver and synthesizes a mock PCI device just
> to trigger the driver's binding and initialization paths.
> 
> In this case, the synthesized PCI device matched the AGP bridge's IDs,
> forcing `agp_amd64_probe()` to run. However, because this is a synthetic
> fuzzing environment, there was no physical or emulated AMD Northbridge
> present in the system.

Which means this is a contrivied environment that no one will actually
use, so there is no need to backport this change anywhere.

thanks,

greg k-h
