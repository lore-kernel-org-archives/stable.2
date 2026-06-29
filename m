Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A171B86C7;
	Mon, 29 Jun 2026 04:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707907; cv=none; b=MoqQ9NWYma1BFXzmDrsvftE6qSsX75PZeoVoP4vuJPSdBqKUiWAWG4/5p7tstbA2Q1bSgzz5Rxf4BJRdGzLWDkxvs+jxxRbUX6hXyxYGqwIbp4r0T5OqxrKGOzVMA9zLKedPxpHJSUGZOkWQFapSil7PdChy76aZh0lgEQQSTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707907; c=relaxed/simple;
	bh=sPaTuOssl0PK2K7VPMkuPqxE8PcSikZSFS5MKfxkmKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK944dCqoJF+2oBgiYuoakMqroqlq96rEMZcnyy15wJKUCsyiHKnGe0I1xUeksSqrTpmwtWt/SrXidmbPU99zgzOG251l/wAltK6VF+xQ27VLxdkgZxojgcBOy37ILEGUz7ERBwKvd8cmZH12FsD9g+uPsndguVSM3mDxoxPq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbR45vBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbR45vBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3831F000E9;
	Mon, 29 Jun 2026 04:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782707906;
	bh=5wL/jbJU8asRR9h0LL6EtfQgfxohGxvfFv3tXiRxni0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sbR45vBb9Ze6R0cRYLtvLQ4JJUjgj18CFJou2m8liyVQ9UMibfwgpETPXJmrN6fWE
	 pitSBXRBP4+peRwEdffg28F9wbQh01lJjWg96nukFcHEsvzKrh/uy4tp3X6rXNtf8n
	 6WsFyxU/8hqA2rh3YT7+rPBdC7iX0ua07jYeF68s=
Date: Mon, 29 Jun 2026 06:37:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: ntb@lists.linux.dev, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit
 failure
Message-ID: <2026062901-slather-filing-3fc4@gregkh>
References: <20260628083301.9781-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628083301.9781-1-vulab@iscas.ac.cn>

On Sun, Jun 28, 2026 at 04:33:01PM +0800, WenTao Liang wrote:
> When dmaengine_submit fails after dma_set_unmap has been called, the
> error path err_set_unmap only calls dmaengine_unmap_put once, but the
> unmap object has two references (one from dmaengine_get_unmap_data and
> one from dma_set_unmap held by the tx descriptor). The tx descriptor
> itself is never freed, so its reference to unmap is never released,
> causing a kref leak and a dangling pointer in the freed descriptor.
> 
> Replace dmaengine_unmap_put with dmaengine_desc_put(txd) in the
> err_set_unmap path to properly release the tx descriptor, which will also
> drop the unmap reference it holds.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

No, I didn't suggest ANY of these patches.

Also you did not use Assisted-by:, why?

Please start small with just 1 patch that you can do properly, before
flooding us with lots.

Please go and reply to all of these where you incorrectly added my
suggested-by and ask for them to be dropped.

greg k-h
