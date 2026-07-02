Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78D4ADD9D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001199; cv=none; b=e69FXrp7JLBlS8PwkYzbkeF7oJaEDCPzmBSc10lfsurw7SI2bA9ZfRL6asqsauJNImsoxyb1+aQap+s4JteQRmYLymL1R0JhBe1Qg6w9HtnmFoWqcBNnPlkzZcPMRRRVr3L4v2yuEv94e/qy5MYLw393j7A1ddZEPdLARmF/aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001199; c=relaxed/simple;
	bh=QBvbOqincIxXhJ4V+ybUttC3yJEWzPT9MEGVDUtBfj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJDf9/zl/wd6Pdn3MLI4r9kdAsKy0bk83mbfMQpgt6kFks4pOp2fr43MEXIV53I2YkHhv2Xy4WDyLyFfbZM0TL41sFugrQt1e2pMuNg/GxLO911SWAvYy3XZnrqurJQ1yAHSNossQsvutVuNfarAA0g+DDnWeQg3/ti2td2uyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aRebAApF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aRebAApF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CFC1F000E9;
	Thu,  2 Jul 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001197;
	bh=9+PRrGX0q7rIZhmQvZ2SqH5QvL4xftI6TYnwQruRhDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRebAApFUlly9YzQTPtaRrC1dJfKMHZNG1sPngDX/kRaDiriY3Zu0ybMSnWC6JNQV
	 vxHLUQI+87HZHLRpm0WzhjlA0drxrVGgArknipnfenULFak7658yaa7Vr6JacC/CM0
	 FeLoJls4ScUshFWPESidd4cf+u92SNRVcCpVIzgc=
Date: Thu, 2 Jul 2026 16:06:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Message-ID: <2026070229-rendering-plus-be9d@gregkh>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>

On Mon, Jun 29, 2026 at 04:41:28PM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> ARM missed the PREEMPT_RT window for v6.18. The following three patches
> have been merged as of v7.1-rc1 and are the missing pieces.
> 
> I've been asked by people if it would be possible to include them in the
> stable tree as it would make their life easier.

Why can't the -rt patchset just include these?  Why put the burden on
us?

thanks,

greg k-h
