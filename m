Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AB471D03;
	Wed,  2 Sep 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347193; cv=none; b=loFqwZ6qcNtpoooRhH5FUtMNBDe5Fc0IWeixh+LjrGWy2kyojYASR6ZPIm2TScvuI/+LXxOCjAoObU3Z3WhfEWQScer1DLULHSnZY7jJ9b0xb7E5nspCXMtSBbdz7PCWxJsYGurZxbki1eNPeS7rIqdxUZkXHeUC9RP8bvUYoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347193; c=relaxed/simple;
	bh=gg4oaeObB+ZvkDbunSo+2Wv3qmDg2Ckasda83xkxFyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvHJip52UvO5yyNLgzuDBtu9e2RPZQN3VBEUjC0ur6qUuUghySQW5fLI/15C/coRUYU7eTXF84Lnscd4urbSCMK5Zwiu4Yyb786xDqJE212zgamCKeXhoAiUqv8cv53fhB/piKaYqK5/tAIlkDz8g7/uyFhIvkT2LrHaMTdEXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G521DKuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G521DKuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B081F000E9;
	Wed,  2 Sep 2026 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788347192;
	bh=2KejZkyIUl3Cw92CMKhHBilt7CFXtfyld/pR8L9PEQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G521DKujJWRyJA+Xl0Q2x2JtSmwNopaAg2YObYd6S+0UASQAlplqL4x7Klc0EI8nm
	 pr1OguEkQ2RI2NZIl95Optq7a5LiAVTxryK87q+QgPqZ5Nl5FOgUV17Ys34Y1UKiG2
	 1dPQTOipNhNu+t2REFVbMEMEEPwCYaCyCRWmOwyE=
Date: Wed, 2 Sep 2026 13:06:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
Message-ID: <2026090223-napped-nerd-790e@gregkh>
References: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>

On Wed, Sep 02, 2026 at 12:21:19PM +0200, Vasileios Almpanis wrote:
> ihex_binrec_size() returns uint16_t while computing be16_to_cpu(p->len) +
> sizeof(struct ihex_binrec), so record lengths of 65530 and above wrap.
> __ihex_next_binrec() uses the result as the offset to the next record. A
> length of 65530 gives an advance of zero, so ihex_validate_fw() spins on
> the same record forever. Lengths of 65531 to 65535 advance by 4 or 8
> instead of 65544, so a 14 byte image passes validation while its first
> record claims 65535 bytes of payload. emi26_load_firmware() passes it to
> emi26_writememory(), which kmemdup()s 65535 bytes out of a 14 byte buffer
> producing the following splat:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in kmemdup_noprof+0x3b/0x50
>   Read of size 65535 at addr ffffc90000075006 by task kworker/11:1/174
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    <TASK>
>    kasan_check_range+0x10f/0x1e0
>    __asan_memcpy+0x23/0x60
>    kmemdup_noprof+0x3b/0x50
>    emi26_writememory+0x29/0xd0
>    emi26_probe+0x2d1/0xb64

Is this a real firmware image being sent?  Or a fake one?

And root triggers this, right?


> 
> Return size_t so neither the addition nor the following ALIGN() can wrap.
> 
> Fixes: 9fb4ab4d3dd6 ("ihex: Simplify next record offset calculation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
> ---
>  include/linux/ihex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ihex.h b/include/linux/ihex.h
> index b824877e6d1b..0da1c4e3e693 100644
> --- a/include/linux/ihex.h
> +++ b/include/linux/ihex.h
> @@ -21,7 +21,7 @@ struct ihex_binrec {
>  	uint8_t data[];
>  } __attribute__((packed));
>  
> -static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
> +static inline size_t ihex_binrec_size(const struct ihex_binrec *p)

but size_t changes depending on the platform, right?  Why not make it
u32 instead?

And if this hasn't shown a problem yet, in the 8 years since that commit
happened, is this really a bug?

What changed to suddenly cause this to show up?

thanks,

greg k-h
