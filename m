Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0503369D55;
	Mon,  3 Aug 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759331; cv=none; b=FOR2c7FkBKpR6zYWFPdrVvnGZN3dBse3vPKpYkhTRzr5FqCSYUGqPcPgfH3qW0VQG9qtvY2P5WMmcaO2S/s8sxdGb9RdbyBd/3X+Qcy2nf04DJatsPZe4woWYGiQy2/X6Tue8tX1bxlGFhbvMEgYvSqMsrOdiBjdpttRA6QrOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759331; c=relaxed/simple;
	bh=n1wkdWIgQcFGCAu7/quVOH2VSw5oPF+sEuMSPCOlttQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XitAryKpmAzWCSCUlzKkO/VstM1z0NPjIckubbej+axbcQQt4y2gOMfscbuiiIaTiQLXl5uKCwmATaZ8h5XrBuPLmQ5Nr9VtcbuJBoslwUYk7U5oMS+RUzhDWckV2fuzY3FJ9D70fNSY2NiC9V+NkbmG1L3drRJ91bYpjuSTdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az+DCFjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az+DCFjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A41F00A3E;
	Mon,  3 Aug 2026 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759325;
	bh=hEHMyINoI4O0CExzLk+V5x0PUReFfT6DbYvfpS+vJPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Az+DCFjYcQ11T9PWCYkn5M7ebpriU/O+orU74FKowP5kdJYlLNtHXgPyJUdNzfiSf
	 pL0Z953SA2CyKtxxqSZJQ+as0muqNwRPHAGMXn4GOuN5UgiPA7rNAaUdX3YaXn6gU5
	 MDXYYB25p8+uMX4FFJTi2AqMVMtdi8rXGKixxRnHWwjosrDeoJiri2fEGX54ni4lV0
	 QmVJ60k+h6B41UXCdELcn/Ia1kDMi0CBSC6gZOD3YW5sk809E0b5kf1NvY9hBvLh0e
	 d7zA2G9q8VJc+yBhnmDOFYcFZOh+gTLkN3gq2s9smaOfkB6mOkfAyl3zUEKE6Jiu8X
	 ZXVfFP4uDyssg==
Date: Mon, 3 Aug 2026 14:15:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: David Sterba <dsterba@suse.cz>
cc: Qingfang Deng <qingfang.deng@linux.dev>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Andrew Lunn <andrew@lunn.ch>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Eric Biggers <ebiggers@kernel.org>, 
    Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Kees Cook <kees@kernel.org>, 
    linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: remove the ipwireless driver
In-Reply-To: <20260803121409.GA867448@suse.cz>
Message-ID: <1q088894-5178-s9r6-s515-9qn12ronp460@xreary.bet>
References: <20260803091938.259944-1-qingfang.deng@linux.dev> <20260803121409.GA867448@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, David Sterba wrote:

> > Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Acked-by: David Sterba <dsterba@suse.com>

FWIW

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs

