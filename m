Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8C4F474C;
	Thu, 17 Sep 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646792; cv=none; b=AyHSu8X5bGQzMVTCw0wx7SBiEoIpl+us/NeaUhFEh9fC9A0G0QqqXCoXeOW7fwKUl6CEg7mFVbzg9JYSnrEcjEZXdDLYRkXXG4g3DmSRWmjVomubkHagdtLi9/JNmqvY4qgzXP2CH2o8jv4tkpP3SSoDp00xGutmPTfjBiqHGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646792; c=relaxed/simple;
	bh=W0EVtuCDJ48yKwMYYxIb9kPsSFu98eprCJt+0BriEL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNrKbEHW1L7VOXlTb5F3UPelR5NbSGnwoLIouCrEmDpld+3M02jTCrAaxoSfxqaO7XkOCs/HidJzsvuVQwSrAszt5+Pbiw609/natOT6y2z7QxjGSoDI4EtNaXSLhUfn/z0177WZZ/vSvGjzM4lTRl3oHHhRxEP2r8QZj5nGfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ljomUrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ljomUrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B62D1F00898;
	Thu, 17 Sep 2026 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789646779;
	bh=LlnRbt5c8SP+aAJF87ouKUvRBbld9YxcfP/ftrnkZgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0ljomUrwTL2UcjQ7HHAcYdrtIKTqFYzw3wyXinI7YNmmp9wq2uvlibGxRe3/YSkmK
	 ryRmZwW7JLzSvGxQ06hWYVVDby0dfdp29e7FXIUOZVmR0sEpEhuqhRPALUXGZax/u9
	 kyEaroyGZOc8yeqFj6lfvzQPnCrsFqApRO66wVvc=
Date: Thu, 17 Sep 2026 12:57:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
	jassisinghbrar@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix GCE clock reference leak in
 cmdq_get_clocks()
Message-ID: <2026091720-erased-urchin-8903@gregkh>
References: <20260917093745.2144930-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917093745.2144930-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 09:37:45AM +0000, Wentao Liang wrote:
> of_clk_get() returns the clock with an elevated reference count, but
> the references taken for the other GCE clocks are never dropped: those
> clocks outlive probe and the driver calls neither clk_put() nor
> clk_bulk_put(), so probing a GCE with multiple instances leaks one
> reference per other GCE clock.
> 
> Let devres drop the references when the device goes away, which also
> covers the probe failure paths after cmdq_get_clocks() has returned.
> 
> Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for mt8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Please stop sending these patches.  You are not responding to any
feedback, so we are assuming you are just a bot :(

All should be dropped until proven otherwise.

greg k-h
