Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34D349AFF;
	Thu,  9 Jul 2026 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624841; cv=none; b=bSB/GC4e9bmeffDbw3XcYacMcvnzYF8hTytYdnjzjltsQq7lt7J4Y3++dxS+jezplJxTcuqEIR2g1wmxp5iQa2T9wWI4XNwW91SSvVlglw3/n8muV1Zm/wqYnhqBAGJQKGsd4rDVmMj6fE2t7oxVyM7SfZSQAiOSg/unyRB5m08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624841; c=relaxed/simple;
	bh=P5sK9NprA4nFECMghBKHXOsfS7erHEbO6SI3xOIETy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgQb8h4C6QtD+Ao+/k91hbJ25O1tKP8OWcEsYpGdJuoHLO2eXdTNdGd6XPWPDOqhiF+D1Hm26809JDwsU2T7jyMBF4nOtYQ029Lw31rN1JfEoApSoSiFBaJAheEUDjkC4XTNyFrqf/rTVMpVSG7a6t0vQ7xHThvVAGYkTfJM0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ok7AZNxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ok7AZNxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028DA1F000E9;
	Thu,  9 Jul 2026 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783624839;
	bh=MO3r+XohUEwAecP18p9D9scY3bD04+5zmZZZ404/Jp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ok7AZNxPp71pUUcv/OrRr1HxQhhOFFmnlWo+UKFTcDZdR2HFYd+7EwWCwLPEHwC2h
	 R3sWaGKEfY3IexlHGEk3GjjXEm7Ddk0NTI1MqbhZh2QkHwRcxvtiobrRjcyFRbGeAO
	 t5NUyt5fqUttEBM6Ixp3B+7eLw0oMZcrLHxY/XVw=
Date: Thu, 9 Jul 2026 21:20:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kbd@lists.linux.dev
Subject: Re: [PATCH] vt: fix spurious modifier in CSI/cursor key sequences
Message-ID: <2026070921-everglade-obligate-597c@gregkh>
References: <20260626024833.3419086-1-nico@fluxnic.net>
 <4ro94n6o-r585-9693-07op-6p196oo273no@syhkavp.arg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ro94n6o-r585-9693-07op-6p196oo273no@syhkavp.arg>

On Thu, Jul 09, 2026 at 02:24:29PM -0400, Nicolas Pitre wrote:
> 
> Ping.
> 
> On Thu, 25 Jun 2026, Nicolas Pitre wrote:

Sorry, am still catching up on patches, hopefully will get through them
"all" tomorrow...
