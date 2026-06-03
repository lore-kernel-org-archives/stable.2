Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A9023E25B;
	Wed,  3 Jun 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489607; cv=none; b=cgvYkQwd/9GkoQT8+VqeyWvLd9DdjjaxvtEuci+7FutRVVdbRW8qWCKDr83NEFSzT8iPChgdFzRfov2/tSoj0Tt1195nSXcMugT/wlfgzVyVApY+fROeUHInYh6WlVKSKVyntZfuDQI1TVhMe4eKBfiiLqnxN+BiOkcss+Rte3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489607; c=relaxed/simple;
	bh=Gqw7iw20rg0vdxig5ZaroVk4JjzJ7wLm3I1dv50Nd5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jLOL74IU44VdQ16FRO4439sH8Zem7AWrp0OXTIvwONqhZuZsemDYmnEL0QAgGRDLZXBjaR+kvHDkkjsHoksMUbrEBowRWrtQT10BDpcyWqp9lQ0DNm8kd5ztFMOnQmH9t+l3oPqBEWaOJVekStNM+apSD8ZfDjwj3PWcfivX5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 439F792009E; Wed,  3 Jun 2026 14:26:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3CDEC92009C;
	Wed,  3 Jun 2026 13:26:45 +0100 (BST)
Date: Wed, 3 Jun 2026 13:26:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250: dispatch SysRq character in
 serial8250_handle_irq()
In-Reply-To: <52692ae6c3501f7940347cef364ad7fcacaab7e5.1778675349.git.jnilo@free.fr>
Message-ID: <alpine.DEB.2.21.2606031314340.22659@angie.orcam.me.uk>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr> <52692ae6c3501f7940347cef364ad7fcacaab7e5.1778675349.git.jnilo@free.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 May 2026, Jacques Nilo wrote:

> Switch to the new guard(uart_port_lock_check_sysrq_irqsave), whose
> destructor is the sysrq-aware unlock helper, restoring the pre-split
> behaviour. Update the Context: comment on serial8250_handle_irq_locked()
> so future HW-specific 8250 wrappers know to use the same guard or the
> explicit sysrq-aware unlock.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
