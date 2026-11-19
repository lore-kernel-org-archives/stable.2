Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090885;
	b=4aW14aBOTAdQG6om7iEl+zuG6cw4IJRE/D4vkWevnHA0YqAYPSPIkLX9h1MQf8GC2Y9o
	 ETFLMKjFEDfdA+mhwr9jZGbHlEnnhlTlH+aFo29L/QKugmCQlEgapQGZOwoXRyLjTaSg/
	 +4Mz41GIJd1OyTVgVQZRbLVElCXI+kbwLU+l1X954y+5nm8mBQnpkkoWq59oW+/Vls7Mt
	 e8q39wFcX0Sx3mjX+TPH2LGcW2KsbMT6/8Mdda+TYBTiJiQFkdoUYIjWWlHwFj011lUiZ
	 uh6oL8FauV9Gbn+M5IsISXN/NRbQkN+8IyHQDErOG/FUdP5ONmLH741hEUjBlJFwH8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090885;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=WYssq8Rh+IsPZSlP6a+Of+uyMJHFrjheKoG1lKYjPCk=;
	b=VGk54cEz/RAK9X6kO9YItRCLDHRNlIAXah2IfPIwhIgt0dFNFj6yjIlW3mtGuvH+Phb7
	 ogDzYmhn9potiexvoQPiBkTWgkoZwwOKVJ+hE+KR0PUupCcU68PX7XNvjAG/dXnfDC8On
	 awY2YrOjYSdtTphEP+gyXbttO0CVaLZXLm5CWpDAVLRHKjI80iOvqZfhCIxuWnrQvasiW
	 NUKY6e7OdsYyw/KALPU+Ng7qrmoIyUKNw7kqTX4FbPCgTfLlz0rIhdgbwKlWwe2u4r21i
	 05UvhQ2vigZFi3Pk+L9VGFgDU9h8yKlBuEiE5d4X3nEKklgAZUCe1Et6ppd1i4Ez1xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=09ZTVRBQ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87879606A324;
	Thu, 19 Nov 2026 12:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87879606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=09ZTVRBQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 289DE1A170E;
	Thu, 19 Nov 2026 12:21:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B3860237;
	Thu, 19 Nov 2026 12:21:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9139E11BC03CF;
	Thu, 19 Nov 2026 13:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795090882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WYssq8Rh+IsPZSlP6a+Of+uyMJHFrjheKoG1lKYjPCk=;
	b=09ZTVRBQ9vorhV1JokZODGHZMA27wCccoIMGo+Joy6DWOZOJVgulQG0JC0KGLGHadC/Ooa
	xJ9FZmjYiFtTN2djEci3EP0GJLYpilKFbh22KvIg5qkw1yf9unq4H9fNrh/SbH1WzXSL0F
	wH+AvXs6boeQtHaUM13PtKSEe5p0YyhehsyFCPLBjWRRtReWI0uMrfsI10gIy/iBJSyXT2
	4Om1DXmY3j5sauXz1rI5umA2EhrFnyMTEzUwz92uUh5lyjvgxpN5W9mgTgYDEG4+JXEd6K
	K1P1UBYqYbHXfxZxfSxLJ+qoi03flH1r8RR4QLO1KX7h0/y47JvbakquU7vFIQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: validate the base MAC address
 length
In-Reply-To: <20261117-submit-nvmem-onie-mac-length-v1-v1-1-e6d359b82862@gmail.com>
	(James Hilliard's message of "Tue, 17 Nov 2026 15:27:53 -0700")
References: <20261117-submit-nvmem-onie-mac-length-v1-v1-1-e6d359b82862@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 13:21:20 +0100
Message-ID: <87cxs1dnb3.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 17/11/2026 at 15:27:53 -07, James Hilliard <james.hilliard1@gmail.com> wrote:

> The ONIE base MAC address field is six bytes, but the layout accepts
> any length from the TLV. Its read callback calls eth_addr_add(), which
> always accesses six bytes, even if the cell is shorter.
>
> Check the declared field length before registering the cell. The read
> callback gets the transfer length rounded up to the provider's word
> size, which can be larger than a valid six-byte address. Skip a
> malformed MAC field and continue registering the other cells.
>
> Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout
> driver")

Not sure this qualifies as a fix.

> Cc: stable@vger.kernel.org

Especially not for stable kernels.

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/nvmem/layouts/onie-tlv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
> index 4da3a704388e..85562fc6b06f 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -30,9 +30,9 @@ struct onie_tlv {
>  	u8 len;
>  } __packed;
>  
> -static const char *onie_tlv_cell_name(u8 type)
> +static const char *onie_tlv_cell_name(const struct onie_tlv *tlv)
>  {
> -	switch (type) {
> +	switch (tlv->type) {
>  	case 0x21:
>  		return "product-name";
>  	case 0x22:
> @@ -40,7 +40,7 @@ static const char *onie_tlv_cell_name(u8 type)
>  	case 0x23:
>  		return "serial-number";
>  	case 0x24:
> -		return "mac-address";
> +		return tlv->len == ETH_ALEN ? "mac-address" : NULL;

How useful is it in the ONIE case? I don't know. Doesn't hurt...

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
