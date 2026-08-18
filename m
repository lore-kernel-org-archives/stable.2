Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40237F32F;
	Tue, 18 Aug 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042148; cv=none; b=VcfX2hUveN+tgSKuuWAS0N45Xi+9Eyw6am/PuyEmxMSOX7Q6+MPs8zkFCUCbotUiaPXma2YH5axq7xowbTC78FfYTuRzYrrP2wJcmf9Up1peYJELll8DeTUNVrhGBziShfQQTeI9Xb4fXRJrLcRBmlhhpjp+UTB8wDaqiYsJzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042148; c=relaxed/simple;
	bh=huMdxlT3xnjN5bvGGWYblTVfARng4WVe22VMrtYpl40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvt3sHjxI8BFIi/VG4nvtltBEeDHcWuOqHm9NzvwUSiDYBVnUsrDdfVTyiRnwVgbJrqDz271qUr+P7YBlv3H4VxNdliHanBNCVlMmKEK5WAiL5Wd0qocrVzDlCWtQKPClCflx0VfE0IOvNbwaffwKvEIvwvBEpT7yZVzWUWvzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E966F1F000E9;
	Tue, 18 Aug 2026 08:35:46 +0000 (UTC)
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwFIN-00000000nW2-3Pfh;
	Tue, 18 Aug 2026 10:35:43 +0200
Date: Tue, 18 Aug 2026 10:35:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: fix autosuspend cleanup during removal
Message-ID: <aoQZX1h-9vobiHev@hovoldconsulting.com>
References: <20260808094452.2752443-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808094452.2752443-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 05:44:52PM +0800, Guangshuo Li wrote:
> pl330_probe() calls pm_runtime_use_autosuspend(), but pl330_remove()
> does not call the matching pm_runtime_dont_use_autosuspend() when
> removing the device.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of a just a few days,
some which have even been picked up. Please send follow-ups (replies or
v2s) as soon as possible to prevent further of these from getting
merged.

> Add the missing pm_runtime_dont_use_autosuspend() call before restoring
> the runtime PM usage reference in the remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
