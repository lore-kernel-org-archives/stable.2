Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23841F5FC;
	Tue, 18 Aug 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042389; cv=none; b=ZQ4jjYkwDd9Ld1rVNQICmLDMRRviLyALnPJccgWM3xfrKw2BXJAVY2ByDw/lRZ+X6wWlK0zxEgxI3u+B9K/V6LiST+o5Datpv0yp1IKxxetrAOTsPfOTdNHW3CwcOgN/ha0MS93LU2QWMLHnjHqEGk3U1+voP7YQGUe9uOdKCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042389; c=relaxed/simple;
	bh=2JoUJYEW79RSrPhEoTT+IM76sG5qz9Dv2jMBhWJ7u1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKOboRS/lqGYXUdrg/4jzy6Nm5Xtqk+bHrD5V5tsJ2MqiT0TRpKwp4E3RMmDhbD7+oZOhh4YYiGRQFS1aT7AeqSsWK0SUvZNANuokX9zEK+EFqLqsogJMTKXePadw5wBJacN/5ow+czFO6VGrci5Rt6OeobJKYMWIeJaZmfYwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWmUliX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWmUliX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127961F00A3A;
	Tue, 18 Aug 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787042387;
	bh=geUleovd8cgXaOddQUXJJYwJ1H1WmoGLNIEuZszp608=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWmUliX+gAVAWgQ56XymdbGR/wJFEeaPtt6A4A6Kx+GuyLOxdHNXSJCMwALFhvd3y
	 W4jAljY5V+KRxkrmBtNgILIUKYywK13bApFDg0XW2bsjq8oEs3PgIr5adznhuQkikw
	 kLNTbjb0IUmAeSBcQ9svCfKiufN0XTTSI1CLvqECikX1S7xrO8FTS1z81I14LIm1Ph
	 k65T+DihNWUE1cLVPwHRJzjFwdWUxrQ94TShuQEFkbgU0sxz9Nwza7hqnEDn47aBf2
	 i49lWqhjZWSNpRsEDOqCUhjGRrpJcoPNvGQg87OR1cgdOIb0Aj6Fn/4WVjLiyyQkOh
	 4KhF1c4ODebWA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwFMG-00000000nal-3PkM;
	Tue, 18 Aug 2026 10:39:44 +0200
Date: Tue, 18 Aug 2026 10:39:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
Message-ID: <aoQaUAK7wiG1YjRD@hovoldconsulting.com>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808145748.2926096-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 10:57:48PM +0800, Guangshuo Li wrote:
> quicki2c_probe() calls pm_runtime_use_autosuspend(), but
> quicki2c_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.

I see that the HID ones have already been merged, but for the record:

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of a just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 5f420e8215c6 ("HID: intel-thc-hid: intel-quicki2c: Add PM implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
