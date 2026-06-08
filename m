Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D63218845;
	Mon,  8 Jun 2026 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900459; cv=none; b=GkP4GXfiZlKcQ70W+99YHuaCw/Av29D4gI3rCRXtz5Tk8rOeB5Yn2P6EV+Sc4LXByvWVTAmrr3RcBueGt/G4irnwNSwJJBYzLWzr/E5dtLrLCk4H02Xj4UuKOW4ZI4KC+0YAJ73/UvDGFUZINGEwKGMntNE7PwyVWd5xebIvZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900459; c=relaxed/simple;
	bh=W3h/fBkyDKOfkzdXvEOu1I9OJqsB2+3k4xA15o8fUiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ZK0bwdi/rLxc3TdvbzzyDEH/UNbya8T2YI3HyLeAJX0Z6KIGmEdb+R0csBSGltEbSvScnvLgQdCnsnd8rftQP+DSiNyLIuEfL5t35xHXQhgpZoGBLLuF7ebF8eoJ3GxlgTicBSbkaZ4+f6Q8v2Wn6H3og4oYNdVc02rn4H7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSEKBIkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSEKBIkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60F1F00893;
	Mon,  8 Jun 2026 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780900457;
	bh=blWPsD+1odUl0fNxPQWaphMDZQsI6tiVaSx9gPd1otw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DSEKBIkwQLcSXahiGe/3W8qvYjBTmyjwviODM0AzWZDDI/hHhCo5kkwgvZgPuSVEm
	 KdPd5rSLkoQntm41gsrt1Frb52AUpiNtLP2QHhyP/blyueAVwMAK+0v3Dd+QKwhqIa
	 n4CsbfUCSzgelQrz7c6kfUGEJoSTQLlLfHDwoNYBAhIJtUxqA8XMzkMZ3h7ae0lg9x
	 SIOoL1s/TWb7l6mDi+xsVkIrhEWfm8Oa4B+eIapbZISzfyAGRW9/hNn/uv6rItZOrM
	 1DC6N10i+bLBKsXKanPNHqo64iHnzrpCIYd83wWHYkOBvoPDvgHZVyNaTAMAigV6/l
	 Rhde6N3FAyeTg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWTYt-00000000K6G-1j9e;
	Mon, 08 Jun 2026 08:34:15 +0200
Date: Mon, 8 Jun 2026 08:34:15 +0200
From: Johan Hovold <johan@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Message-ID: <aiZiZy8a0al7xVXe@hovoldconsulting.com>
References: <20260607095114.9375-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607095114.9375-1-sammiee5311@gmail.com>

On Sun, Jun 07, 2026 at 06:51:14PM +0900, HyeongJun An wrote:
> klsi_105_prepare_write_buffer() is called by the generic write path
> with the bulk-out buffer and its size (bulk_out_size, 64 bytes). It
> stores a two-byte length header at the start of the buffer and copies
> the payload from the write fifo starting at buf + KLSI_HDR_LEN, but
> passes the full buffer size as the number of bytes to copy:
> 
>   count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
>                            size, &port->lock);
> 
> When the fifo holds at least size bytes, size bytes are copied starting
> two bytes into the size-byte buffer, writing KLSI_HDR_LEN bytes past its
> end. Copy at most size - KLSI_HDR_LEN bytes instead, leaving room for
> the header as safe_serial already does.

Good catch!

How was this found? Did you use some kind of static checker or LLM?

Johan
