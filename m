Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E061490C1A;
	Wed,  2 Sep 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353814; cv=none; b=srskreStWTqQka3na2TDvGaxDOm+IAKwY8A4rzdvIoZifUjOHaE88pi3dlU8yl9GOt/YGH5zBn+eIBlgsJVf03g5fPgCBLUWp+uF6NfXIR4ZRW0WEX1OOcqYbX53eG9ckTLP5L08oKtGjyUAzCuIPgZvrGv05OPnIVVFTXpzXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353814; c=relaxed/simple;
	bh=nlxcKNedY8NFhhw7+pNar+5Ey+x/WWBiNXdjireTXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3S6HKladGYGpbGJ40tVbUErshWGDt54IarBUHQrM/bw1LtRNxfiPKOqBXMQBtM78X/JFPq9b9cA+7gKWRmseO1oTpJMfumCLaYd3zSy+NPzVM2z4m6XwRjAtgoQJgPoEsTOF0F1+f8CFzzRGithUWesRMUM5padN7lPEqKs4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCImdfFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCImdfFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9691F000E9;
	Wed,  2 Sep 2026 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788353813;
	bh=MsQZyz+mL6/nsyMG3omDM4pyMzMGLSUirh/ygirNMDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCImdfFvViQfRwBvJ7fVj0b4kMxyUeNtFVr0qvA2f7w1ST7Gu05lgfqppeE4vE4QR
	 x7WpLCEzU8KmhI+1fm0+tuJk9KcShByW6H+ROU9EYDZGRoPIgKHW2phy1doU9hQ3gw
	 IFFeuQbNCAWypjeduEPcpfH4uWT4kUCSqUCAaYwU=
Date: Wed, 2 Sep 2026 14:56:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
Message-ID: <2026090256-posture-affirm-f40f@gregkh>
References: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
 <2026090223-napped-nerd-790e@gregkh>
 <178835312958.943169.5134885168571622868.b4-reply@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178835312958.943169.5134885168571622868.b4-reply@b4>

On Wed, Sep 02, 2026 at 02:45:29PM +0200, Vasileios Almpanis wrote:
> On 2026-09-02 13:06:27+02:00, Greg Kroah-Hartman wrote:
> > On Wed, Sep 02, 2026 at 12:21:19PM +0200, Vasileios Almpanis wrote:
> > 
> > > ihex_binrec_size() returns uint16_t while computing be16_to_cpu(p->len) +
> > > sizeof(struct ihex_binrec), so record lengths of 65530 and above wrap.
> > > __ihex_next_binrec() uses the result as the offset to the next record. A
> > > length of 65530 gives an advance of zero, so ihex_validate_fw() spins on
> > > the same record forever. Lengths of 65531 to 65535 advance by 4 or 8
> > > instead of 65544, so a 14 byte image passes validation while its first
> > > record claims 65535 bytes of payload. emi26_load_firmware() passes it to
> > > emi26_writememory(), which kmemdup()s 65535 bytes out of a 14 byte buffer
> > > producing the following splat:
> > > 
> > >   BUG: KASAN: vmalloc-out-of-bounds in kmemdup_noprof+0x3b/0x50
> > >   Read of size 65535 at addr ffffc90000075006 by task kworker/11:1/174
> > >   Workqueue: usb_hub_wq hub_event
> > >   Call Trace:
> > >    <TASK>
> > >    kasan_check_range+0x10f/0x1e0
> > >    __asan_memcpy+0x23/0x60
> > >    kmemdup_noprof+0x3b/0x50
> > >    emi26_writememory+0x29/0xd0
> > >    emi26_probe+0x2d1/0xb64
> > 
> > Is this a real firmware image being sent?  Or a fake one?
> > 
> 
> I used fake images. 14 bytes long for the out-of-bounds bug and 6 bytes
> for the infinite loop. I passed them through the sysfs fallback loader.

Cool, so root only, fake firmware, not a real issue?  :)

> Out-Of-Bounds bug image:
> 00 00 00 00 ff ff 00 00 00 00 00 00 00 00
> 
> Infinite-loop image:
> 00 00 00 00 ff fa
> 
> > And root triggers this, right?
> 
> Yes its root only. The attributes are accessible only through root
> and it also needs raw-gadget.
> 
> > 
> > > Return size_t so neither the addition nor the following ALIGN() can wrap.
> > > 
> > > Fixes: 9fb4ab4d3dd6 ("ihex: Simplify next record offset calculation")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
> > > ---
> > >  include/linux/ihex.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/ihex.h b/include/linux/ihex.h
> > > index b824877e6d1b..0da1c4e3e693 100644
> > > --- a/include/linux/ihex.h
> > > +++ b/include/linux/ihex.h
> > > @@ -21,7 +21,7 @@ struct ihex_binrec {
> > >  	uint8_t data[];
> > >  } __attribute__((packed));
> > >  
> > > -static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
> > > +static inline size_t ihex_binrec_size(const struct ihex_binrec *p)
> > 
> > but size_t changes depending on the platform, right?  Why not make it
> > u32 instead?
> 
> It does, but the value tops out at 65535 + 6 = 65541, so 17 bits, and
> size_t is at least 32 bits. I chose size_t because sizeof(*p) is already
> size_t. If you don't like it I can send v2 with u32.

Let's be specific, otherwise people will trip over the fact that this is
different sizes.

thanks,

greg k-h
