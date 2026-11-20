Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171654;
	b=vt8vnj3UP1DGGWv0Lahahadwbmkbpd0fgjV098MsgoxNtlY+V+ihu7U7GY7mZfNB7K41
	 UsvKpXZFD77fJjnPWm2YzpnMF9S4v0YSYYmyKTo4bRS0C/f/5JfKNIOh82tt31gOH9ih2
	 gsVWGi8Yj0LrLh85qWQD5iix5oClK5n92bUVW9hlxaWyng6W2bwB76Nqgq1PVhy/b6v8O
	 PFlOVu7iKrsZsVMc/bp6SHYg5jgD8Qy3TK9eKNUcwxi+f9N5qMb5ik8FBXet3CaB1WrWx
	 EWSL8KQ2uMjtLfF31eYb+ek5SSVWHCXsn8U1dBNitu5kdFldOIyAuXX4p3o7U5mgvfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171654;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lFLzfeDX5+GA+gtI0FcKgxoRUqo4S+nL34hrT/BINfg=;
	b=w4nvGh/8oS+h8M2M3Qf2gsMZKhCIAbI/XyTSj4UdjMfOvKHiKJ9gnEC841tGPgwbdUeY
	 1bXWxL/3PIJrNDipI+zP1l1802B+GYfNtqICzU0h3B/MePb2Gc6CUdZB8VknW9a2LJE6Q
	 bsyhPXbXomdZmKyIJvAW4kLvoZQOw95xyCjSH3rMMek60//qseH8rTmI35Z5y8Ktu9lcb
	 RPlLb65SvxOUSWA1U5l1z9A0ZNhNBwrXaNMcLZSRQ/BrG1/0+2faujtTMxVL6RQM9X3l+
	 eZ118rXrlSv1myrq5q1BGePslEwhuFnNAX78yTmyWh+XtRP9blAmi2ivrXU2c4pWehg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P1F7kEw+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1377606A320;
	Fri, 20 Nov 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P1F7kEw+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8FA1F000D1;
	Fri, 20 Nov 2026 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795171653;
	bh=lFLzfeDX5+GA+gtI0FcKgxoRUqo4S+nL34hrT/BINfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P1F7kEw+H/gGXP05c7K1ZXa1AAKPU0GrhJgZ3shtV3S48SQpILvRZJPlwuup5Xz2l
	 DDQq/AdAWzM2LH+P4tbQuFZMcCkAMFFOxAaWO+RX7wJN7mR3Tsextc/Zgdmt8TdAgP
	 amxWg8zw/RtdaAlkp3MeqZH5rYVGXZEAF1u1sQ9M=
Date: Fri, 20 Nov 2026 11:47:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: f_printer: bound PNP string copy length
 in printer_func_setup()
Message-ID: <2026112009-smudge-chaste-0ef0@gregkh>
References: <20260930075920.483189-1-benquike@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930075920.483189-1-benquike@gmail.com>

On Wed, Sep 30, 2026 at 07:59:20AM +0000, Hui Peng wrote:
> In printer_func_setup(), when processing a GET_DEVICE_ID class setup
> request, the IEEE-1284 PNP string length value = strlen(*dev->pnp_string)
> is copied into buf without checking wLength (the host's requested buffer
> size):
> 
>   value = strlen(*dev->pnp_string);
>   memcpy(buf + 2, *dev->pnp_string, value);
> 
> When the host issues a GET_DEVICE_ID request with wLength smaller than
> value + 2, memcpy() writes past the end of the transfer buffer, triggering
> a slab out-of-bounds heap buffer overflow in printer_func_setup():
> 
>   BUG: KASAN: slab-out-of-bounds in printer_func_setup+0x280/0x450
>   Write of size 3074 at addr ffff8880024f8000 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    __asan_memcpy+0x3c/0x60
>    printer_func_setup+0x280/0x450
> 
> Bound the PNP string copy length using min_t(u16, wLength, strlen() + 2) in
> printer_func_setup() so memcpy() never exceeds wLength.
> 
> Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by binding
> f_printer with a 3074-byte PNP string and issuing a GET_DEVICE_ID setup
> request with wLength = 64: on the unfixed kernel this triggers a KASAN
> slab-out-of-bounds write, whereas on the fixed kernel value is bounded to
> wLength and 0 KASAN faults occur.
> 
> Fixes: b185f01a9ab7 ("usb: gadget: printer: factor out f_printer")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v4:
> - Re-target fix strictly to bound memcpy() size against wLength in
>   GET_DEVICE_ID handling in printer_func_setup().
> 
>  drivers/usb/gadget/function/f_printer.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index a27792966287..f8726e3d849f 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1033,9 +1033,13 @@ static int printer_func_setup(struct usb_function *f,
>  			if (!*dev->pnp_string) {
>  				value = 0;
>  				break;
>  			}
> -			value = strlen(*dev->pnp_string);
> -			buf[0] = (value >> 8) & 0xFF;
> -			buf[1] = value & 0xFF;
> -			memcpy(buf + 2, *dev->pnp_string, value);
> +			value = min_t(u16, wLength, strlen(*dev->pnp_string) + 2);

min_t() is not needed, correct?  Just use min().

thanks,

greg k-h
