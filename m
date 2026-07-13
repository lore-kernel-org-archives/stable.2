Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3343712D;
	Mon, 13 Jul 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951329; cv=none; b=VBmEeGYIm3GPiaRzUnYItSm6zyTvnbyk/tEf5RiD/v+GrJPg+xlN3SFTt9RIYmSzB3CZ/J4jJ55XyPpFIWOfHHKwwKTGGW6DIx9+zqIHwudpBfV1UjqlzhbjCu3ugrLhB+X5wZnCC2ax8ClKyiF5hsJ7pPNyDhcwDz4TXRKzNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951329; c=relaxed/simple;
	bh=rAoflZ7dU2zWOKzTwefMVaAJ9I7PYu3c3DG0uX0OyiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI297dZ3FC2QPydeDukH30ObbbXpGm1brsL/pNLaIEZDz8iwguHW3DiMVnuh0vz6Y2fScGVaR0XAfuiRg/XNteVruZDgVNbBvTqmcjZLPYAz4/H/Vg8bDayI24Ck3VhO1tNRrj/yVcUPudQVEpOLTwPbrtgbpnrURvmZmkgKQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Ea1hUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Ea1hUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5531F000E9;
	Mon, 13 Jul 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951328;
	bh=VHWWX3igIqoXlkJhrdkPaM1ZU2q8wVQ+l2OU8Gbgv7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2Ea1hUgzgQf/KfQ2FGfuS8rdPCCpAQbyalFan22o6o8Dmf+69zVGJsG8DinLoq7y
	 41e/rNM5YeoOIzb0+i5EYATrxa6PYu3q0GsiBSLIeOadnAS3r9XqFWFwVbgs8H4DOB
	 o3I1nPQO8pt2QL2NvmUJLbgu9itj4tMeo0xg5gkWMRx4zG/rxi+rtYFMQxUxAdL5l7
	 PXk6p+dT4HMddlUHt+rCbcfcpWnAzax/cBcf275RaY+WRfbWG7wPCFg+41KPmDmfNV
	 exyhzzHVxlAVFjeKFQ/mFymX8n18ZYIOYFKY120cv/YWLqOpl2ozCR8CYhKq6ZCpfB
	 qWkAuXNWJUASQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wjHEU-000000052Jh-01m8;
	Mon, 13 Jul 2026 16:02:06 +0200
Date: Mon, 13 Jul 2026 16:02:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] intel_th: Fix MSC output device reference leak
Message-ID: <alTv3j9hIH2qjJ2Z@hovoldconsulting.com>
References: <20260713120205.1003691-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713120205.1003691-1-lgs201920130244@gmail.com>

On Mon, Jul 13, 2026 at 08:02:05PM +0800, Guangshuo Li wrote:
> intel_th_output_open() looks up the output device with
> bus_find_device_by_devt(), which returns the device with a reference that
> must be dropped after use.
> 
> The reference is currently intended to be dropped from
> intel_th_output_release(). However, a successful open replaces
> file->f_op with the output driver's file operations before returning, so
> close runs the output driver's release method rather than
> intel_th_output_release().
> 
> For MSC outputs, close runs intel_th_msc_release(). That release path
> only removes the per-file iterator and does not drop the device
> reference taken by intel_th_output_open(), so every successful MSC open
> leaks one device reference.
> 
> Drop the device reference from intel_th_msc_release(), which is the
> release path that is actually used for MSC output files.
> 
> Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Add Cc stable.
>   - No code changes.

You forgot to remove the intel_th_output_fops release callback as I
mentioned here:

	https://lore.kernel.org/all/aktZDK0NZrTdEqOm@hovoldconsulting.com/

Johan
