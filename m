Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C3C4577;
	Wed,  3 Jun 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489599; cv=none; b=iqJZaEMXptXiwGVq/th4zpUXKwX+vCJQMy4DnVvf5iycCfMl9u8LEdYVkZRC5YaNDoAd8BUZxUvZ39gR+ZSdCDij+D/OSSb8Lw2jCsPeJGt0VMtTPQ84+4oEVu9lLhOd9s0kzxnRexi9MveRW7FqsDf62ghiKSbc4Rz8cQJ5DV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489599; c=relaxed/simple;
	bh=iEw0d2HxGjaXO1qlltq6rX8bbbhmpUKAI2DaxgB8uVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=axlNW16jaIs2I4NFaqe3NeumCBPrwGviBLTAeU72Npv0Q8RjZlfDjLOiky0J820hbUvlBFTVznqj4A8uCIsgk1ZGs8SXfn9CKb8HsmSLS0NmAhnPHmd36WX6HEZMFSMxLBF+SBfVflE7Clo89YS+ZO3V0xBnTAsTonGtugtTXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 43DB39200B3; Wed,  3 Jun 2026 14:26:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 400C992009C;
	Wed,  3 Jun 2026 13:26:34 +0100 (BST)
Date: Wed, 3 Jun 2026 13:26:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: 8250: fix BREAK+SysRq dispatch on
 guard()-locked IRQ handlers
In-Reply-To: <cover.1778675349.git.jnilo@free.fr>
Message-ID: <alpine.DEB.2.21.2606031315270.22659@angie.orcam.me.uk>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 May 2026, Jacques Nilo wrote:

> This series fixes a silent regression where a SysRq character entered as
> BREAK + key on the serial console is consumed by the kernel but never
> dispatched to handle_sysrq(). Same description as v1 [1].

 Thanks for the report and working on a fix.  This issue hit me hard last 
week when chasing a bug with one of my systems where my debug hacks caused 
me to become unable to become root and reboot the system properly.  To my 
surprise I was unable to access any of the magic SysRq features either and 
consequently I had to power-cycle the system remotely via a PDU (it's some 
1600km/1000mi away).  I've now verified that 1/3 and 2/3 bring the feature 
back with patched 7.0.0 and said x86 PC.  No way to verify 3/3 though.

  Maciej
