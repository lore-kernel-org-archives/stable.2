Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600418;
	b=vZX0x54pzlE3bapDM6OBk0YxHb+syPhYsKMNLE5xpTTkrTxK9YdfYAhxhwcJj63n77ai
	 AmULNgaU6/3jkbcH79RFP9bjjCrfLiuMCQZGeHd8AuV4yGn3JM17olkHF9Te18qFiHtIT
	 Q+JZixK9EZB/X4fjTh+oEewiP3pDHWKKBr2CJUOkcaBQfOrVF4Ox4e62anVQZt6E5ZkMi
	 b+T9Q2eBdTMHr54CBWvpf9EJpSaTeYVYRFCre6eMe2o6uHFaLdFngBXBJrAGmqunHIv+G
	 VxxkIfahXH77CC8AGJ+IQk0loiH85xca77/C4kSddAsarZSKqjqFrjh7csnOc/e2Zhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600418;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K2TeO+AjX9Kquy67UUcdqKmeUpQHa5egziXlpC2t764=;
	b=zWBligp0Q1N1cMFmevAYtY+f48kKBwLfcWnzJG6RrguwvvDWJOwfnIv7yr/R5AFJLj03
	 NTlIJkU39eBBMHqtLm+rAhhwsnvLXzvl+GZ4j+MprmxNoOOITq1pseny0Niy59c27rYiv
	 7bij5E72VTHATzcSs7h5xEJ5z13wZxEK9ZySvOpvkSH7BJXVVypgK/WF2VBQlQuifbeqU
	 RnVEn4d/nz+08UxhXbdWBpxtURAIb86fmiXH7KSiuQjRJNyo7AqMilxEI8FYwcvG4MwWh
	 0r857foSn9cESG9YYUywy4oQQ0CxqpjbYT1Wd3UJVAWvH0/C8iBji/N8Isl1HxmDBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVyq4REV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0329606A31A;
	Wed, 21 Oct 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVyq4REV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE961F000C1;
	Wed, 21 Oct 2026 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600417;
	bh=K2TeO+AjX9Kquy67UUcdqKmeUpQHa5egziXlpC2t764=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVyq4REV6Sd6APeqtOjROHj2z1BZNGinFn9bguf2GlYvcASTPWyCbXijlnRXZvZet
	 Ggkb6lrAM5X0oytVF91EGBByQfViBVEqNdiEagkOBAIBbAuOL3mLaCRIf1D3rPj5ok
	 1gf01s4e1ABXT92EM/ll46lAXxqLd43dfqLK7mzpngxfrVAKKdNFIASa7in5IhCH0M
	 ko2aSQr8b79U2hr3kx7kbnDbCXz8kP6kxoy/pL0EChQNrCud/Y9aHQ5ptNUrLD8HWv
	 RWWrsc1kLhOzJOJdmsdZWaqOQW1c9gqunb6XTsOElzIKOOtzcJ2GZtBdPH6rDyfN1u
	 QggOgmSzVMCeA==
Date: Wed, 21 Oct 2026 17:33:33 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/28] mfd: intel-lpss: Remove registered MFD child
 devices on probe failure
Message-ID: <20261021163333.GH1795367@google.com>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-11-lee@kernel.org>
 <atjFroYp0Cp7eN8c@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atjFroYp0Cp7eN8c@ashevche-desk.local>

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> On Wed, Oct 21, 2026 at 12:09:33PM +0000, Lee Jones wrote:
> > When intel_lpss_has_idma() is true, intel_lpss_probe() registers the
> > iDMA64 child device via mfd_add_devices() before registering the host
> > controller cell.  If the second mfd_add_devices() call fails, the
> > err_remove_ltr error path returns without calling mfd_remove_devices(),
> > leaving the iDMA64 child device registered after the parent's
> > device-managed resources are freed.
> > 
> > Call mfd_remove_devices() on the probe error path to clean up any
> > previously registered MFD child devices, matching intel_lpss_remove().
> 
> Good catch!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> assuming you will add Reported-by: Sashiko...

Roman suggested Closes:.

-- 
Lee Jones
