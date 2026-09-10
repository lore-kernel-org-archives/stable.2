Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39157384256;
	Thu, 10 Sep 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052482; cv=none; b=d5hGOMbaZJNyhBheRWNIVwapXk8pgSbVo43wNRVtZ5YEgVxhsMb/HtBRGqszVvurPoeQWWnj9G/FUJTcHFXG33TZl5JraWoEdY6hUYZ/VBHoZhT0Q2ZrrQf7aJ3itj1VQGo29/ZWp+6aoJYWQs6qzsuOizYAi36szUMWPDWBzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052482; c=relaxed/simple;
	bh=L8DM0rJVl8lI0AE8AqZeZSU4hIs6eem028Jbow6Fsxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUobJRdiUxlCqL4abE6QQLfdQCmGDl6m0oMWyDHCok0WD/k9l6RKpxxxW+G1b4blY64cCVLMjV67VzSIsC7Fu2FvkvfJ23qMYpSU6yYOEBh3fPepUc2gx4h5jYGI9WtDa4VKYg4b3nY7E+gtqY58vtFGTP8ad+zUOGRlBIGSVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPB2dbOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPB2dbOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3722D1F000FF;
	Thu, 10 Sep 2026 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789052480;
	bh=JOXfFD2pYQZzyzXEGGXBKQ9880w58jVJaec/hDfB60g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HPB2dbOcLtPdehPej5NTutXykBpbS/VVRRWrdLCwFK5eSCgS5uoDrSR/QpfKLuymh
	 jwroneGXNmJpi0orSe3AnvLIu4ObY9gd25gYBV/8IBV1SzaP4YHYJu6K8e3hFxE/7M
	 y3RP7MiEi1QjV+COgtucSsnI8j7p8uOaVzpREwrU=
Date: Thu, 10 Sep 2026 17:01:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiazi Liu <jiazi.liu1984@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, frode@meta.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Message-ID: <2026091053-unstylish-punctured-9ad6@gregkh>
References: <20260727092258.1121-1-liujiazi@amazon.com>
 <20260907073756.22329-1-jiazi.liu1984@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907073756.22329-1-jiazi.liu1984@gmail.com>

On Mon, Sep 07, 2026 at 03:37:56PM +0800, Jiazi Liu wrote:
> When dwc3_check_event_buf() reads a GEVNTCOUNT value exceeding the
> event buffer length, commit 63ccd26cd1f6 ("usb: dwc3: gadget: check
> that event count does not exceed event buffer length") returns IRQ_NONE
> without writing back GEVNTCOUNT. Since the DWC3 interrupt is
> level-triggered, the uncleared IRQ source keeps the line asserted,
> causing a tight IRQ storm that accumulates 99,900 unhandled interrupts
> and triggers spurious.c:184 BUG -> kernel panic.
> 
> The resulting call stack:
>   __report_bad_irq+0xac/0xc8
>   note_interrupt+0x340/0x468
>   handle_irq_event+0xac/0xc0
>   handle_fasteoi_irq+0x120/0x228
>   gic_handle_irq+0x68/0x108
>   ...
>   kernel BUG at kernel/irq/spurious.c:184
> 
> To reproduce, write a bogus value exceeding the event buffer length
> directly to the GEVNTCOUNT register:
> 
>   devmem <DWC3_BASE + 0xc40c> 4 0x1004
> 
> Write the bogus count back to GEVNTCOUNT to clear the IRQ source,
> consistent with the stale event clearing pattern in
> dwc3_event_buffers_setup(), and schedule error recovery to
> reinitialize the controller.
> 
> Fixes: 63ccd26cd1f6 ("usb: dwc3: gadget: check that event count does not exceed event buffer length")
> Cc: stable@vger.kernel.org
> Co-developed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

I missed where Thinh signed off on this, where did that happen?

confused,

greg k-h
