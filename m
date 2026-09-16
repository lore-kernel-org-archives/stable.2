Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263C4F0542;
	Wed, 16 Sep 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567456; cv=none; b=bx4ZzgKJftn5YA69Blc1UkEOIlxRa9MpVYzv/XMVA+hlItLDfyWVjWyCsxV2mMIPCkeB7b0WNVcPFr7JgBP2nVzHnrrgZwp7b+89WSS5iVHfBUZedirwazyjVirYyQIJsAeRmXV8TOKNAwiVGUNALLayS1nQnrLnwLMsub1awUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567456; c=relaxed/simple;
	bh=ZffUj+Vtky5NzS0pjSwUPr2TNNuX5Ka6HlgD9m/JuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suAcdrgFdo5lg1iC1LW6R4RbbNcHJAausJ1quwqjf0Do/boSBNPrajsNAm+rbb0NM4w+QmzwpFR0y2daYBsDoo0F9HaTBUsluwlxaK0Q5+duQu47h8CfFUj0wFB7kDtAZuX192vxOCdIDPn9Jf9VxOcH8uQn6IqZu3XgIfUSxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+dt66Va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+dt66Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6271F000FF;
	Wed, 16 Sep 2026 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567455;
	bh=boMQ7osEAul/ozW1G53nUYFfNLneFVBiqiJGnzzXaeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+dt66VaxtszfuUz8kcSbJx4jqtic4eEmaf0bKnhCuj1f3ieaFuWMoOQG13iLG3Zu
	 FnSz1iP13gsK1J/gLjjKtsH+bg/TEZ90d+E0QsdYX/A6FVrDGMqKbf1Afu6msR6hIm
	 VsYgKrYXi98MyMnHmCGg49WNAVKz/oMwt36oiocCDJKdbGq+5XLE2TfJzCqIfuD947
	 Oui6B6NUvJX94tpBM5eKNEy7oQeX3zeN2OuFF0K7naosAu1nhr1qH3hc4DXLV7A1m0
	 tQ4+z8txAUHz5tQxTYBd8NY8JezGhm6kZu6L4qMqPRRa7cy+dvDU1bfor4BypCbWjW
	 dG1Ye0xerhEdg==
Date: Wed, 16 Sep 2026 15:04:10 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Tai <thomas.tai@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: (subset) [PATCH v3 1/2] mfd: wcd934x: Fix NULL pointer
 dereference on IRQ probe deferral
Message-ID: <20260916140410.GB1605367@google.com>
References: <20260903-wcd-dma-v3-1-d3920c6563c4@ixit.cz>
 <178956680898.1616494.3176016583638775540.b4-ty@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178956680898.1616494.3176016583638775540.b4-ty@b4>

On Wed, 16 Sep 2026, Lee Jones wrote:

> On Thu, 03 Sep 2026 17:21:42 +0200, David Heidelberg wrote:
> > ddata->dev is only assigned at the end of wcd934x_slim_probe(), but the
> > of_irq_get() error path has passed it to the error print since the
> > driver was added, while it is still NULL.
> > 
> > This used to be harmless with dev_err(), which copes with a NULL device
> > and was skipped on -EPROBE_DEFER. Since the switch to dev_err_probe(), a
> > deferred IRQ reaches device_set_deferred_probe_reason() ->
> > dev_driver_string(), which dereferences the NULL pointer and crashes
> > during probe. Use dev, which is already valid at this point.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
>       commit: 1389a4a5877403e57573d6bc01c5b7790a4472ce

Didn't apply initially, but I reworked it.

-- 
Lee Jones
