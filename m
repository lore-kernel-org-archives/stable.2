Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815F35BDA4;
	Thu, 25 Jun 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399289; cv=none; b=IAoqE7AxO3/gxRO/PMf7laH2bHyKeHxZHZIi9oSKAcIPLG7ObxhMGkD+PZmYKUAtnW/Rfh6SqE84+S2fZaQuowjUGNN7wYRdstoqfhygQyscTggbZJNurzmXlImvZ/xqW6jETsh/Jyl0WJHqHWmPWJq2s/rCVDrom1KEVuo76ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399289; c=relaxed/simple;
	bh=AQrgNKGD4pdMv2wt1uKA2FQBlcey1C2TvqrbMxpGDMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxUY54JeC01DXkVp8s0zqcNfVAdCSbaquyBSTfpzmK5fQGCPBUgJyqfL7if79AZi8TZe1tbyBOayWa5wP+zdJjvnfWWf4B79J/4phH3XvzGJzBe5e6hOuR1pde/ERjhQXv3mZN1tKo2IMZrSx+EahSiEQeMNND5avzoWLZ93nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6xTsxkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6xTsxkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4AE1F00A3A;
	Thu, 25 Jun 2026 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399288;
	bh=W4S+PfZgn2DfN5giasKtSYS891SEfg/04KKKv0G1OE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z6xTsxkVpNS37htO7o7NG2YndpM1svcJISF0ojvU9yBKmt86Su7LdyHqshkS6YsZX
	 pS3ZZHBzvnbYfmDolwhQedVnRimfCdMtg5T9Pt7b2KLJBzNwbR8+wcvtkTxR8s0fSK
	 FlMB4eAkf1KXRgU78+WgbcHSdnCpTHsruRY3CoEs=
Date: Thu, 25 Jun 2026 15:53:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vi_ _Ku <vishalmimani008@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, digetx@gmail.com
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
Message-ID: <2026062523-shank-explicit-6e09@gregkh>
References: <CAN+vipx-6gco_XMnV+JxbkRegJ=i8tSKFdBN4KcT16UceQduqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+vipx-6gco_XMnV+JxbkRegJ=i8tSKFdBN4KcT16UceQduqQ@mail.gmail.com>

On Fri, Jun 05, 2026 at 02:16:47PM +0900, Vi_ _Ku wrote:
> On Tegra186/194/234 the XUDC appears to post a transfer-completion
> event when the DMA write is dispatched to the AXI interconnect, before
> the store is committed to memory.  Under SMMU strict mode dma_unmap()
> synchronously removes the IOVA TLB entry.  If an in-flight AXI write
> to that IOVA has not yet been committed, the SMMU raises a translation
> fault (fsr=0x402) that permanently wedges the bulk endpoint; the host
> cdc_ncm TX queue stalls and fires NETDEV WATCHDOG after 5 s.
> 
> Fix for non-control endpoints: poll EP_THREAD_ACTIVE until the endpoint
> sequencer goes idle before calling dma_unmap().  Follow the poll with an
> MMIO read-back that orders prior CPU writes to device memory.  Only
> after that does dma_unmap() invalidate the TLB entry.
> 
> On timeout, skip the dma_unmap to avoid triggering the SMMU fault.  The
> DMA mapping leaks, but the hardware is already in an unrecoverable state
> at that point.
> 
> ep_wait_for_inactive() uses readl_poll_timeout_atomic() (1 µs poll,
> 100 µs timeout), already called from IRQ context in
> __tegra_xudc_ep_dequeue().  Change its return type from void to int so
> both call sites can detect and report a timeout.
> 
> Control endpoints (EP0) are excluded: their completions go through the
> control-transfer state machine where the DMA is fully committed before
> req_done is called.
> 
> Fixes: d720f0f7bfa0 ("usb: gadget: Add Tegra XUSB device mode controller
> driver")
> Cc: stable@vger.kernel.org
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Vishal Kumar <vishalmimani008@gmail.com>

Does not match your "From:" line :(
