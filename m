Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1347A0DD;
	Wed, 16 Sep 2026 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546591; cv=none; b=Vx79sdPaznvnvEhsTtz3E7h/uQL/waSd8dkfEx/vEC9uF9CEBWRP4CYE1sqKHCi9olKyvYRzMTRzuUKLIT2xpni0wXZqqPkSOs0Tdj1TX5rTM0E7oMoJ98OSCzf9XsvFMZb9aqSj63RS+J+n3vxNNegJJ9L8zu+IzNfGETFLsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546591; c=relaxed/simple;
	bh=a0Lpz0KWiW0t6SX8Sm0pRTi6OEXCaet1sxsTa2bUJGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2g31YpuNaUf3k0czKsNZsYpjdJaDtWEwFEtOEGJW68KaxxZGSN9K7WXqEi6axGBXF8VRjCzJBROEtztUWTn9Oo7TqtP7piT4llaFlkA6w+9cCA9+tYaQ0GPN4F2/amdLOBdSmT9XKsq4UVwUErBbmzzzaVbi3Oko1AG5hvSwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXwBUxpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXwBUxpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8951F00893;
	Wed, 16 Sep 2026 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546579;
	bh=SjWIP8bNgzdC4buQnhVS9zvJ7ieVsM0oE8uqr/MRoYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXwBUxpp6BrunGC9Exr6GM/vSGpDSwW0e19VQG/HebrdWDreqD+TRflwbah2sHQOp
	 FpxMLshY1UEor/GvOfupqRFWD/7O/D2IT53Ts1TI0qFtHguYs/mwcF9Zi3Q3eq5daW
	 zDrOlbTsyURpbnesjY/9q7QnelxvpU617ZiErDVoEip8cXsy+kXVqb4NL0quiCe+fz
	 VUWYamsRGz77Z/6BQ1e99VwL01uV5WAnNUvkI2cMNjx/mSZFEeZRdfrPgO6QyFkNxL
	 4wb3ea39LRymM0UgOJlA2TIVhPRqcPmZq2u67H7j2RDNLc9dbn0+llVJHeqS7b4Itb
	 l8KwbL9+yj3oA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6koS-00000005wGU-1cEn;
	Wed, 16 Sep 2026 10:16:16 +0200
Date: Wed, 16 Sep 2026 10:16:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] usb: xhci-mtk: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <aqpQULC3P0wspKwL@hovoldconsulting.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915090223.1346-3-joshua.crofts1@gmail.com>

On Tue, Sep 15, 2026 at 09:02:19AM +0000, Joshua Crofts wrote:
> The disable_pm label in xhci_mtk_probe() and xhci_mtk_remove() both call
> pm_runtime_disable() on error or device teardown, but don't call
> pm_runtime_dont_use_autosuspend(), causing resource leaks.

No, there is no resource leak here either and this does not need to be
backported.

The autosuspend setting is not restored, but that would only possibly
have an impact in the theoretical corner case that someone forcibly
rebinds a different driver that does not enable it.
 
> Add the missing pm_runtime_dont_use_autosuspend().
> 
> Found using Coccinelle.
> 
> Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
> Fixes: 04284eb74e0c ("usb: xhci-mtk: add support runtime PM")
> Cc: <stable@vger.kernel.org>

So, without having looked at the rest: none of these should be
backported.

Johan
