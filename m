Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A20EADC;
	Sun, 26 Jul 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070269; cv=none; b=L1trVkMIihFZnBiGoDapefjOfuKLwpGFs263IgCglc8L3ONDZNqmWGxsnCBBb9OKX8pkleiAfw/S7M8MS7WWvov/lHrnqbpjKF67Axz/TP6H2x2ta2hLbXm+s2coqbcRLt/8uI6LcZr03A1zPXpqu1oczuKZrkzZi/kASAHk+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070269; c=relaxed/simple;
	bh=5m7YllrqrDD+I64NdzvPe9Yw2dnkfAghZdQA85noM8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoFo8U+u5LezOWLJ7vtMQZDqhdsVQ71mwubMSZPrWkJTIW+UqzcvJ8g0CbOeot5+k/0FPf81tymUFpfmX0z3i6AKlObMJRU3VWS9Ug+DenXqp4gFkAcwTwxFxx0f4juWIRzKLfOIvnmd6tPnVQJEtNMF+dhmaZCD8cmWeeC6aoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIel452r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIel452r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF57C1F000E9;
	Sun, 26 Jul 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785070267;
	bh=JWSuNsIbkBE1hWpggEeho+a3f1uuuBPHJQEBb7AnlRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BIel452r2lqUGW5gyvhDilwr7MMIBH4XO8Y5MHaiviJwBkm0tNgiDBzlZEZ4Q9Nts
	 Kh/2jy1CjpitrJy9DMla04wgrlwUtdfAwulR/qu47hoLvmmlOS524ZVmrNi70NWdZz
	 kBWUeIL4IDuTAwW+jE7itWwola0QIn/WO1gIuQk4=
Date: Sun, 26 Jul 2026 14:50:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?6K6457qi5bKp?= <220255774@seu.edu.cn>
Cc: sashal <sashal@kernel.org>, 3chas3 <3chas3@gmail.com>,
	stable <stable@vger.kernel.org>,
	linux-atm-general <linux-atm-general@lists.sourceforge.net>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [RFC PATCH 6.6.y] atm: he: kill tasklet before releasing
 queues
Message-ID: <2026072618-plank-game-15f5@gregkh>
References: <20260724052710.1126-1-getshell@seu.edu.cn>
 <2026072445-delicious-uncrushed-b854@gregkh>
 <AIYAKgAhKje-OvrUBw*N1are.3.1785069041661.Hmail.220255774@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AIYAKgAhKje-OvrUBw*N1are.3.1785069041661.Hmail.220255774@seu.edu.cn>

On Sun, Jul 26, 2026 at 08:30:41PM +0800, 许红岩 wrote:
> 
> 
> Thanks greg k-h  
> I do not have the HE hardware, so the patch has only been build-tested and
> reviewed against the teardown path.

Then why create these patches at all?  What is driving the need for
them?

> Given that the driver has already been removed upstream, I agree that deleting
> it from maintained stable trees would be cleaner if that is acceptable for
> stable.  I sent the small fix only because the driver is still present there
> and I did not want to backport the much larger ATM removal commit.

But if you don't have the hardware, and don't use this driver, why do
this at all?  Why even look at older kernel versions for stuff that is
not used?

>  I can prepare a stable-only removal patch for
> the HE driver instead, or backport the relevant upstream removal pieces if that
> is preferred.

As no one uses these drivers, due to lack of hardware and the like, they
can't be abused at all, so just leave them alone for older kernels, no
need to delete them as they do not cause any additional burden there at
all.

thanks,

greg k-h
