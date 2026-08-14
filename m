Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D083D3329;
	Fri, 14 Aug 2026 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671441; cv=none; b=NMLG73Ponwm4OLSZFYcKgzJSKgcaC9v0yASIz4NwtlRmO7MHyS4XTd4xz5gv+LsksqqReVCaVLevOCGWCwWrIIqLY2o3XVPqxAL3quKYIKqupJ4yxq5jfOz73cfvrhyPbi42sL+BP2EyylHmoALjcdlGeRbE+gQ0khtcUYFDC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671441; c=relaxed/simple;
	bh=OmbtYsSgf2wKSXKdPykS0k09VRGKwq3ODVoMfNnO88A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDsghG65YElUAIRmbvFB22Z7g+M6uEiz2c12rgd83zzRt6j3jANYM9P9cTALZKfGTwc+sBayHhnGMenJzmjQ0oRYkrVv8AICMnoRxl2qLXIGgxsg6dLxtoqhZYc86Ao6BRTMSvW1IIe2VCHHBseLIYFIvAx1oH7F+bgDIRNyUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETOTxnBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETOTxnBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF40D1F000E9;
	Fri, 14 Aug 2026 01:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786671438;
	bh=Vq3iHeGc7xpNe+OM6JAaa7b3XLXvjIl9gZAUBqhf1Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETOTxnBsiniouqtFtlahlNll80dPT199o8lXIMuwT7YrSBIgjCQSpK7LZsmQDJxBG
	 PrWQbJho7vDgcOUpNs13JRI4BrFzgV/uscprH3zpnHyeMXwOPQLNo0xd2vtYeSesgY
	 hGzW3IDGDUIY3hRX3c+UC1HLgqUVR7UWpk+r2ARU=
Date: Fri, 14 Aug 2026 10:35:44 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: luoxueqin <luoxueqin@kylinos.cn>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	pooja.katiyar@intel.com, johan@kernel.org, pmenzel@molgen.mpg.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Add ACPI_COMPANION() NULL check in
 ucsi_acpi_probe
Message-ID: <2026081458-payer-pacifier-f4ec@gregkh>
References: <20260811095827.1001654-1-luoxueqin@kylinos.cn>
 <anw-41p6cVPQyrDP@black.igk.intel.com>
 <043577d0-4b42-43c7-be7b-abcedbbffc46@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043577d0-4b42-43c7-be7b-abcedbbffc46@kylinos.cn>

On Thu, Aug 13, 2026 at 11:25:55AM +0800, luoxueqin wrote:
> Hi Heikki,
> 
> Thanks for the review.
> 
> However, I'd like to point out that this exact issue has been recognized
> as a security vulnerability (CVE-2026-64227), and Rafael already applied
> the same fix pattern to 14 ACPI platform drivers in commit e4865a56d013
> ("ACPI: driver: Check ACPI_COMPANION() against NULL during probe"), which
> is marked for stable backport.
> 
> The NULL pointer dereference triggers a kernel oops/panic - a full system
> crash - not just a silent failure. Returning -ENODEV is the correct and
> graceful behavior, consistent with all other drivers fixed in that commit.

Yes, but it requires root to cause this crash, right?  Which probably
means that other CVE should be rejected?

As this is a manual bind command, if that ever breaks, you get to keep
the pieces.  We don't "defend" for that in the kernel.

thanks,

greg k-h
