Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B724A0910;
	Tue,  8 Sep 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859564; cv=none; b=SWTcN3ieU+WN9iimOWuLKLU68cCpFTHaVLXTvG0BBLhU7jN8NnOcE7FsCzNqgRmCw42jWR2ZS6A+70WJT0Oz16zORTFmDw/5H472fRA+Tvg85YuogEfcMuEgoyCUc8fULi3e2YEfikgvQpmKRR6Ju5oJokr81dh3AKrwcgUI3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859564; c=relaxed/simple;
	bh=DUiEwI/ExDlzzZ/qhMuh2PV5ZE+tMD2+ciGcjVmWCYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHMzmjRFYw9WPUwSX7r3CxwVRFv+klgluTO+s0kZIXhqgtqL3NiprqoO4WTuf0Jxl+DV2HFHWFhpeHtu6LnMkPnFl5cKf6JxC0YA/GO2pYV/hAFg3VMZKJB83IKZgtaKLv5g+5Y1LAFpDTAuPttTtONVZj6St8GN3gs1TjIVPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcJWZiWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcJWZiWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D131F00A3A;
	Tue,  8 Sep 2026 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859562;
	bh=o69IttcuA7tEu2aNd7IWY/GFsPeUHYiH4+43qLbSxr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JcJWZiWyuNXSBXu33ocUnSilnVKHTJPyZfPQ/D5JSsXezRh4OfA9gIgz2xZJH/jhV
	 hcB7WL/AdHcKT5W68v3mBSZ1D8rAxtxcnyvDBmiTr+FRAo0OlzvlDCEsp5v2ieZOKi
	 o2lXHejcSnhPxNXlQxtMT2UWymiWyksbYs1C0YzR7SVuFnTg0FqRAmDsHdoaHnnUIX
	 JU321VdkHKCKYv5RBZzGkE0CNs8l+H1T13Pi0a+orsdN7aPj04CBMmhcYUil8LSHAs
	 g/90mUJPsX+Cl81g9gA+wC3tXd1Rx757idGPB5cLkutCMStyOVT6za88mNYJrjc1Xf
	 8P0FbPxOVTq/w==
Date: Tue, 8 Sep 2026 10:25:59 +0100
From: Simon Horman <horms@kernel.org>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Message-ID: <20260908092559.GP40544@horms.kernel.org>
References: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>

On Fri, Sep 04, 2026 at 05:18:27PM +0800, Zhang Yunfei wrote:
> The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
> memory pressure, but the result is passed directly to request_irq()
> without a NULL check. The IRQ core then stores this pointer as
> action->name and dereferences it later from /proc/interrupts and
> procfs, leading to a NULL pointer dereference.
> 
> Add a NULL check after kasprintf() and bail out with -ENOMEM.
> 
> Additionally, when request_irq() fails, request_threaded_irq() frees
> the irqaction itself without taking ownership of the name string, so
> the caller-allocated name is leaked. Free it on the error path only.
> On the success path the name is owned by the irq action and released
> later via kfree(free_irq(...)) in the cleanup loop, so it must not be
> freed here.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>
