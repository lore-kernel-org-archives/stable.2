Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3F36194E;
	Sun, 11 Oct 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703075; cv=none; b=RsSHpYXoLPCtjgR4QRx4JGCI07AyBeCeKDj5CSy43po7Y6C6A5a3rYFv619TmI9+vkax00pvgsgPbHzeM6muvEGQEiAjpHsIjSvmteV2Kinz+9FeSSXyn577GODkCDPFiBy4c2noCLAreiGzd2SgQwnq3eRkTN+mmkb0ajlu1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703075; c=relaxed/simple;
	bh=b7NeHVhy2QhOQSfstvOeB+xNjbhUW3Ffzn7dw4ph1O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upSATiocXP8FJmxsibDSwMobcKgaR9VjbzQ5ZKD0dfWy42UAjM6Je2X9lxEu/LLqD23vQVV8XreT4y3Zg4p8sgSI+E2D9IjE9EEFtAalWenGYUjUdVvsUx1DCwurUD37F9jWarR72YyBtIg3KXAtHKogAUYeCS+Pyv/+UeAMZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u8bCl5dc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u8bCl5dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9171F0089B;
	Sun, 11 Oct 2026 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791703074;
	bh=UP0CXRuQOO+3Ammpkg1AGpGN33zU0hi3auzlWpD28+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=u8bCl5dcRLSQ16ypGvsTQlf/8vsfEGvawNYkxsKWq28gB59qX0LSbmExjOolx7Xvz
	 5Ra2pbzzp2JWVmgGRoECIm5ebpUOHoGgK3zJx0ncFQhkC7LW1SXiwtmp3v+Y9qisMK
	 2a1l6n35mP5abn7720Yh4rc6v8Xyql0taJOB9aS8=
Date: Sun, 11 Oct 2026 09:17:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Menachem Adin <menachem.adin@intel.com>, stable@vger.kernel.org,
	Joe Finzel <joe@sudmix.de>
Subject: Re: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
 LP DID"
Message-ID: <2026101122-immature-endurable-3ea6@gregkh>
References: <20261011-remove_adl_lp-v1-1-177758bd617a@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-remove_adl_lp-v1-1-177758bd617a@intel.com>

On Sun, Oct 11, 2026 at 09:29:12AM +0300, Alexander Usyskin wrote:
> This reverts commit 930c922a987a02936000f15ea62988b7a39c27f5.
> 
> This device ID is not belongs to HECI and added by mistake.

Should this say:
	This device ID does not belong to HECI and was added by mistake.

?

thanks,

greg k-h
