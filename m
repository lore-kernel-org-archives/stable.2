Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E343C3787;
	Tue, 18 Aug 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044997; cv=none; b=mA+ywz7yfdIukcbFQShFu4pULYmXgiZXqfv7JKeLuo753iPj55aC5LMMdCUZzboD3h+3xHxEO69A7s9JUMd1DXnmBiFdXPi9KOVpkne5pCUWiLW8fFacwWX9F7Mm9mfykYPcCFl5QP7MVwQLe05CUfCY4yPjeKjKP1mGu3POlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044997; c=relaxed/simple;
	bh=Fklls92D7o/nzv2a52itjp/+dRs0TMJ5t9nX2WjRCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgq8+cE1le2LDsa9StNsc8K2Sh/X4sDB94USPhj6pq5kG+Yy/7Mk03AjKWlIEJz4XDcElmU84Yfau03w+FMHZudsUSeXKqBQW87a93V9jotU+iq7T4uoc7DdcKoozt///fXRJ4FRI7bb53kI/jOJhdHOvkByvL80m1QsEsaVPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsQIfpFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsQIfpFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAF11F00A3E;
	Tue, 18 Aug 2026 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044995;
	bh=LUJt84aUUdQlopP9J8PBFy9OonDzbo4ffp4HF8ZN1fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IsQIfpFbixsmO4v28/uo5b8Qv/38tCuiTrNvZnULuPkAhAzmKzJZgLbTdmWH4NZfY
	 9HrYkmTHXN+XnBIQYMYPDVgmnOkkbD5v084bHoCqTdd6+Z7VCo0SpjJwG42Q8OFk+W
	 GwkBiCx1wEMQah8I0ewTszkxKt2cyH/skNnPc+DpVcPvti/dNP5gO7EsW4lhp9PLn3
	 mThyMPs/UnLl/e9oVondd/9AI76Ao25zZqikPCH0fvmF2h6jft5Hbs+PxHcpyU1sBs
	 w4mO1YLuk6YGrzz1caxqvr5L7LeQrwZZVt3IUEZXh4jtIXkL6tFc2Pg3mW8rlb5hJv
	 N4mBHMU0M6B6A==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwG2L-00000000olb-2IsI;
	Tue, 18 Aug 2026 11:23:13 +0200
Date: Tue, 18 Aug 2026 11:23:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
	Daniele Palmas <dnlplm@gmail.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Slark Xiao <slark_xiao@163.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: fix usage_count leak when
 autosuspend_delay is negative
Message-ID: <aoQkgbI-ZoBTuqe2@hovoldconsulting.com>
References: <20260808062916.2604668-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808062916.2604668-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 02:29:16PM +0800, Guangshuo Li wrote:
> mhi_pci_probe() calls pm_runtime_use_autosuspend() when runtime PM is
> supported, but mhi_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during device removal.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during driver teardown, this reference is not dropped and usage_count
> remains unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> Add the missing pm_runtime_dont_use_autosuspend() call before
> forbidding runtime PM.
> 
> This issue was found by manual code inspection.
> 
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
