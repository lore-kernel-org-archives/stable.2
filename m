Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AED388E4E;
	Wed, 15 Jul 2026 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100111; cv=none; b=SNXVg3AT22mglwTRUs8s+UuyRzCneTthV5IwCbTZQ8FsrfwxrBb7wn+Pc/5HEpx46kJwpOR59FAAZOBD4voVtZs1TncJEDXs0VxG3IFk02JRGowwpqb/OeBh1Vo6wj8odre0+ljZ0rbY8m5khzh2R15ReEaMtvRPvyR9aUA1tCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100111; c=relaxed/simple;
	bh=jS96YH0bZi/WtaKu5ZDmok216M+wjpPqA7kQlqgoRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg83LqJsjKWlofLTv/h19c/D8tCT7C1Q8Mt0awkRnBRdINd/aG1DyyjEYKTJiE6n6hzBIIYckZYENiA3CgVovMVC/eve4tT2++bDmNqPJloT8oUF2HGfWTx8jCCC9E6XwzmePQs5Q+islNVS5HfzviyzrzYG/cOP8pHpzbh8WAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ8G28HK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ8G28HK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D07C1F000E9;
	Wed, 15 Jul 2026 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784100101;
	bh=9DEO/UkyHXQgX2K9xSDM2cD4QOShsMKToetq8ep2wOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jZ8G28HKC0EEddCyswVGU0Q+Z2ZgME3nsfBxCrUX8QIs2EK+R/dB/aVfUnZ53+Uvz
	 E2IOURCugd0/GCEAuI7adXbZTdNYs9uk/viiMBbFNKUlCo6MOiVc5VLLszcrVs6Bjg
	 FJWv45OVttIjlWXZZNvkVnQemSCAFhGqcPqAcUVb8y0OG3WB+IWnX1cb7Blm8iBEHk
	 F+H2b4rSzo8quLyOm9z3k3qnOclJU9QGzv0tyIWoEc/Sba59H9sfTRsSZlCqSV0pH1
	 1p6jjtj+0vowmC0iuoNPtR69pQjq0PgVwnRj5+gpJnuogk5vzliQRqlq/LxjPvr9HS
	 lw6d4bIcuKhkQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wjtw2-00000005pmJ-1bF5;
	Wed, 15 Jul 2026 09:21:38 +0200
Date: Wed, 15 Jul 2026 09:21:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Jay Vadayath <jkrshnmenon@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lukas Dresel <lukas@artiphishell.com>
Subject: Re: [PATCH] USB: serial: sierra: fix slab out-of-bounds read in
 sierra_instat_callback
Message-ID: <alc1AjhB3v4M1sDH@hovoldconsulting.com>
References: <https://lore.kernel.org/all/2026071453-reminder-ageless-dcea@gregkh/>
 <20260714181142.10976-1-jkrshnmenon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714181142.10976-1-jkrshnmenon@gmail.com>

On Tue, Jul 14, 2026 at 11:11:42AM -0700, Jay Vadayath wrote:
> The interrupt-in URB buffer is allocated based on the endpoint's
> wMaxPacketSize. A device declaring wMaxPacketSize == 8 gets an 8-byte
> buffer from kmalloc-8. When such a device delivers a short packet,
> sierra_instat_callback() still dereferences transfer_buffer as struct
> usb_ctrlrequest and reads a further byte at data[sizeof(*req_pkt)], one
> byte past the end of the allocation.
> 
> Reject the URB when fewer than sizeof(struct usb_ctrlrequest) + 1 bytes
> were received.
> 

Fixes tag missing.

> Cc: stable@vger.kernel.org
> Reported-by: Jay Vadayath <jkrshnmenon@gmail.com>

You shouldn't add a Reported-by for your own patches.

> Reported-by: Lukas Dresel <lukas@artiphishell.com>

Where was this reported?

> Signed-off-by: Jay Vadayath <jkrshnmenon@gmail.com>

You also need to mention that you used an LLM to find, write the commit
message, test and/or fix this issue as documented here:

	Documentation/process/generated-content.rst
	Documentation/process/coding-assistants.rst

> ---
> Apologies for the wall of text in the original mail. I wanted to include
> the artifacts inline so the bug could be independently verified. Just the
> patch this time.
> 
> Same shape of fix as Jiale Yao's option.c patch:
> https://lore.kernel.org/all/20260712170012.3503601-1-yaojiale02@163.com/

And as I and Oliver pointed out in that thread, that fix is not correct.

Johan
