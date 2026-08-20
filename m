Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB4438478;
	Thu, 20 Aug 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226067; cv=none; b=lMEz44kUT5Tnmhtnv64CrF3mJjxplVBF7sSWyTrldfUgwnk5uPDU3a8x3qKPcZ+x4l1Jh0Ea6m5WohUT8cTxAFd+zG3DJFGIYEBocCeyd+FT6BcK3vtJ7DDyoOZ9PHm1Rvrz8Y4uCaMRjuEY6HZ34CC9Zcwa8DilZwf4gHf7cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226067; c=relaxed/simple;
	bh=tsosuo0ZUHJSre3DpsJqpKrPgXRIpBQ34rrecnFoBls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFM2et+WsnTj7GQrTuRHvpwiH4yCiEkCkhLU/InD8+87bafa2nTEP7DVGzGTMcGC6DPv+BRZAXcgWz/zgOAH/gc5ySi9nD0F1qA0AvANnrgCk5pCJ5uxeYd7InjGzVZM0T4qBwgfCVnZs68L0yLI3gMl73WtE1KAxINARWxrA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3zY8TQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3zY8TQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C891F000E9;
	Thu, 20 Aug 2026 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787226066;
	bh=Gsyeb/yMTxTFIO11HW6csDUuh6fG0jEe1JB7KC5HlzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R3zY8TQ4y0t5nlXwldq0Y9PThRZ0n9FvpxBDPLTuqAE69V5OaiM1IiPzt+PaL3QLD
	 dXuORCbrZIwj3cXy7BmAg+z2dL3mUEBTV4shRYt9N6VIFMp88Ymcl2G+VF7WZYU3KQ
	 JE6DFwHMWq+gjrf1T1nEMuhBO9jnyeI80kRb1tBULZdv9s71+8WK02yeqYRD/gVSEL
	 ykmihzZvGWX3jACrOkhvAdcZ5vE0UO8/qGxnWvOKxl9kzHgUpxXKlqFJJ4qAKxqOou
	 YduTUZ9xexkyDDTReOr3ibz0QcMRPHL3H2L0UUDEhxn/nsnXwofKfyBHGfQaNrlQSZ
	 xAmb+LVOS5qSg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wx18p-00000001iFh-3D0r;
	Thu, 20 Aug 2026 13:41:03 +0200
Date: Thu, 20 Aug 2026 13:41:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
Message-ID: <aobnz6lCxib4-5Ma@hovoldconsulting.com>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com>
 <aoQaUAK7wiG1YjRD@hovoldconsulting.com>
 <p80oq2qq-5o87-01o7-qr0p-5op97414951s@xreary.bet>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p80oq2qq-5o87-01o7-qr0p-5op97414951s@xreary.bet>

Hi Jiri,

On Thu, Aug 20, 2026 at 01:33:16PM +0200, Jiri Kosina wrote:
> On Tue, 18 Aug 2026, Johan Hovold wrote:
> 
> > > quicki2c_probe() calls pm_runtime_use_autosuspend(), but
> > > quicki2c_remove() does not call the matching
> > > pm_runtime_dont_use_autosuspend() during teardown.
> > > 
> > > If the autosuspend delay is set to a negative value while autosuspend
> > > is enabled, the runtime PM core increments usage_count to prevent
> > > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > > during teardown, this reference is not dropped.
> > 
> > I see that the HID ones have already been merged, but for the record:
> > 
> > As I've explained elsewhere, this is just misleading. There is no usage
> > count leak here as the count is balanced whenever the user re-enables
> > autosuspend through sysfs (by writing a non-negative timeout).
> > 
> > Drivers should clean up after themselves and disable autosuspend, but
> > this is more of a clean up than a fix and should not be backported.

> Looking at this now again in more detail, I believe the code change is 
> actually OK, but the changelog is misleading. Or am I missing something?

Indeed, the change itself is fine, but the commit message is misleading
and these do not need to be backported.

Johan
