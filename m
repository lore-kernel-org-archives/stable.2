Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D937B400;
	Thu, 24 Sep 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232164; cv=none; b=YWfeB/cR6Irka5HeZe1X50oV6QBoaUPM2pI5DLYys7+0FczH5GRPUv4xMzqcr4V920ZM5S1Ds6ShZrJ2nnbHEhMZ2yNWq2SK557Ikb6bGh1WbGUwfvfQCSBZHqT2OitEgIHqI7u6uSiD/sp2DVn5C73fKbz2ZV6rh5f/o4yPHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232164; c=relaxed/simple;
	bh=JzgC5aRLIncP9PoEjjTQPsJFy4eYB9n2dhd5Zddzrls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHh15pyyzUPx7qncebd9tCYGgezf/5U7Sk+Yb54NZ/AiP/jNvewYrd+s18bCkh/zlBB5WIVQticPrGZXXxKZLs/qH4y4xAuGIhM/wAY50PbA+pLWEe67v5/sUEjLoP1fP9JgMpO5tZPUGKpeWfVbaNnmGmjIbNZ3ohqUnSWzDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQ6zShly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQ6zShly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E1C1F000FF;
	Thu, 24 Sep 2026 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790232163;
	bh=ylpTpsQHVQlvo+T1dyKmicxDD/bxUtMAt0acJ2c/+9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mQ6zShlygnpiC8SJqRTn1o52of1HWlyK5Tz3OSxaSUj0zRJ3XH2Qbr3V4TjHceJot
	 uCXUvbRuiHkAm2Z5JKDr8WVBPWTJttZmrQDYP1AN70k9xAiZmFWJdRF/0+XyLXW+9f
	 sxS3/Tn+Pa4PhZl7cJHiqnU02s3zrl2Oqi0EazGA=
Date: Thu, 24 Sep 2026 08:42:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
	ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/3] serial: fix IRQ chain race, baud fallback, and
 uartclk overflow
Message-ID: <2026092417-seducing-stank-af6d@gregkh>
References: <20260924060511.2364717-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924060511.2364717-1-benquike@gmail.com>

On Thu, Sep 24, 2026 at 06:04:43AM +0000, Hui Peng wrote:
> This series fixes three bugs in the 8250 and serial core drivers:
> 
> 1. Hold hash_mutex across IRQ chain lookup, linking, and error-path
>    unlinking in serial_link_irq_chain() to prevent a use-after-free race
>    with concurrent serial_unlink_irq_chain().
> 2. Allow a third loop iteration (try < 3) in uart_get_baud_rate() so that
>    when both the requested and old baud rates are out of range and try == 1
>    clips the rate into termios, the clipped baud rate is evaluated and
>    returned on try == 2 instead of returning 0 and causing a divide-by-zero
>    in uart_get_divisor().
> 3. Reject baud_base > UINT_MAX / 16 in uart_set_info() alongside the
>    uartclk == 0 check so that multiplying baud_base by 16 cannot wrap
>    around in 32-bit unsigned arithmetic to a small non-zero uartclk.

You only sent 2 patches in this series :(

Where is patch 3/3?

thanks,

greg k-h
