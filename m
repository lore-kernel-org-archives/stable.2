Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CC3CF94E;
	Wed,  3 Jun 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489602; cv=none; b=rJR2RhBW2SPwyR/aokYjk3/wEh8f5iKL+G98tmni643dPBfUgxab6lffoqnl+VsIKeVrhpx6WmUEM5PBvyfZO1FCapDGRJB1dKfDrEeKpKR7bkBxIMdmQPpFo/iHfu59XEoCBRJjOW6yg4MSBb1JbWN2HxS0D+3GNCEtDfFPEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489602; c=relaxed/simple;
	bh=vQTDnlvp1Cgx+/xFkKa5SSX6tyuC2rRhTo69Y+n63Zs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F5Gb75XRFtxB/clCTH21ghQAnxVR4Z8De2xq4Eoq307W/Hojms/+M/WfgU114TdXtSe9di4MOsBgsUO4djNEfNvedLeGIzMM5gEzgniVz3+u5rPaq+HkM0+aBi4/02tbNet/Fe9FWOmYQij+HwOpw5qvWpSE3Ti57mUWD5Up4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 904C99200B4; Wed,  3 Jun 2026 14:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8AE5892009C;
	Wed,  3 Jun 2026 13:26:39 +0100 (BST)
Date: Wed, 3 Jun 2026 13:26:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: introduce
 guard(uart_port_lock_check_sysrq_irqsave)
In-Reply-To: <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
Message-ID: <alpine.DEB.2.21.2606031313460.22659@angie.orcam.me.uk>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr> <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 May 2026, Jacques Nilo wrote:

> Add a dedicated guard(uart_port_lock_check_sysrq_irqsave) variant
> whose destructor is the sysrq-aware unlock helper. The lock side is
> identical to uart_port_lock_irqsave -- only the unlock-time behaviour
> differs. Callers that may capture SysRq characters must use
> guard(uart_port_lock_check_sysrq_irqsave); the existing
> guard(uart_port_lock_irqsave) keeps its current plain-unlock semantics
> for the many callers that do not process RX.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
