Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C13426D13;
	Mon, 29 Jun 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745451; cv=none; b=B47gpGHPFCluO8bHG5AsYjhIgFj2X+6YR7XpHz7AAyQkIcG9Nch+wMd0V2dVobQwxdhjawsIsfxfhd3F66aHJIf4l16wX0iXprFE9W9SZxMu/Uypvjnsey8b5qEwofZ7fa0XV4tZT4hM+YH4r7lWKYydx+6ehuawo9L6W58QoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745451; c=relaxed/simple;
	bh=qubJ+N+dc9V0cxYf6uPieT6b9/ZlYWmutB4jGVIR8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6Ky0fmkf1OMecHnBI92Mwd9orDbtQ20P1E6B90tPsqdR7Y6Esv7sbkmZLaxaHgCQZU5LUtf92B1bVvHnwmMZfD4w/n5pSecdOln3N9Ti8PdOINY1w6/1Bl/ZziOy7tXyoh/cYv0OYYV28k31iHNoEZ95He3dHqJHVl2H/1vmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUHTHZRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUHTHZRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147E1F00A3D;
	Mon, 29 Jun 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745449;
	bh=qubJ+N+dc9V0cxYf6uPieT6b9/ZlYWmutB4jGVIR8zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUHTHZRR3rZtUXc6QkfXeX0xOOHV3JHD3M+xTBshWJGG78Oean9LeG9GvMjWDu5J9
	 wZMCue+cQLzdEiY2LgcOWoJRohzD6y03b9xocsdfesWaCEXKoQ7FYQtfiJEMClwo61
	 z230tO+XVVKToqiq19sHXnkW+1HlY3YuKpIYHM+Nb/6KpauelgFGh2w29OZbYs/snG
	 BVO2bfuFmlYDcHwblKNn598oPrSJ/4rkz449J7ksniYskWVx0Csenqz7vSqsnt89CT
	 JBkTyE8MLvnexOLH1s77p2jEB+P6ucbQRCQ/W8uEMhK4FT3dfwM7sDJJCPgnqLHEqy
	 aq0dneZmaGyNQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1weDWp-00000000cJB-30gs;
	Mon, 29 Jun 2026 17:04:07 +0200
Date: Mon, 29 Jun 2026 17:04:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FE990D50
 compositions
Message-ID: <akKJZ5MyUAsYJ7oo@hovoldconsulting.com>
References: <20260612113916.34894-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612113916.34894-1-fabio.porcedda@gmail.com>

On Fri, Jun 12, 2026 at 01:39:16PM +0200, Fabio Porcedda wrote:
> Add support for Telit Cinterion FE990D50 compositions:

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Applied, thanks.

Johan
