Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE4374E5B;
	Mon,  7 Sep 2026 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791717; cv=none; b=ebbBxqkMTZg3RISb5Yd67VjHO+FCmHeD/FxX6+SYGR9ZRhYoo3K4ogScZXhQX0qKTKIExB/L/R6KZbBqVWoWOMWL8q1kbw1noj0V0rp66cS4uD6rFtyr4MeQcWQww/bzjXpub4MbZ8POqQgeWdMNihntcf1JB2lMacWdRHaE1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791717; c=relaxed/simple;
	bh=HEcP379TWIjIK3CWF6bXSzB4m9SXPB7FSWN8GCkHyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNBOSAXmiQn61xDj3GPmVHLLtG255+Oi6gU6PpbqLi+Xeozdi6MnSNlfzr8rY5crcVeaTwvWk29VfiOCUbfN3gu0Jj65lR0JfqOD3GzoFlJ6nl/8++RKCy8I46IBZXrHhkaSjACV5XZf0/bVX9B+tQoJ1AKybbzttOFL0TjAnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VVuJQDqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VVuJQDqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53571F00A3A;
	Mon,  7 Sep 2026 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788791714;
	bh=r5InLeLGh2uPUdFgZJbG56cDWSx7pTWcpP5tGOiVnRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VVuJQDqtAiwXBrESc9ksllVuhIUxekh3pvUF6P38IWmd4rqvvnxv6qWeqECBrxU+w
	 X5AGYUlf5udSHhILA4MVA92aHIE13D6JjtgtlAjlsDs5e5Si2tpFqE9USmZmtNDUjm
	 QSZQeZFQlw/2CV1Zs00LPVMXN3o6BQjjOm1vy1UM=
Date: Mon, 7 Sep 2026 16:33:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: David Heidelberg <david@ixit.cz>, linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and
 nfc_llcp_recv_hdlc()
Message-ID: <2026090735-overhead-epidermal-9d2d@gregkh>
References: <AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Mon, Sep 07, 2026 at 12:36:45AM +0100, Aamir Ahmed wrote:
> nfc_llcp_recv_dm() reads the reason byte at skb->data[2], and
> nfc_llcp_recv_hdlc() reads the sequence byte at the same offset
> through nfc_llcp_ns() and nfc_llcp_nr().  Both run after
> __nfc_llcp_recv(), which only guarantees LLCP_HEADER_SIZE (2) bytes
> via pskb_may_pull().
> 
> A malformed PDU that is exactly two bytes long -- delivered directly by
> the NFC controller, or as an aggregated PDU inside an AGF frame whose
> inner length field is 2 -- causes both handlers to read one byte past
> the guaranteed data.  In the direct case the byte is whatever follows
> the valid payload in the skb buffer.  In the AGF case the inner skb is
> allocated by nfc_alloc_recv_skb() with exactly two bytes of payload, so
> the read is past the meaningful data and into whatever the slab
> allocator left there.
> 
> For DM, the stale reason byte selects between NOBOUND/REJ and the
> default socket-lookup path, potentially closing the wrong socket.  For
> HDLC, the stale sequence byte corrupts N(S)/N(R) tracking: a bogus
> N(R) drains the tx_pending_queue unconditionally, dropping in-flight I
> frames and breaking the connection.
> 
> Add a minimum-length check to each handler: DM requires
> LLCP_HEADER_SIZE + 1 (the reason byte) and HDLC requires
> LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
>  net/nfc/llcp_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

For all of these different patches, did you forget to add the required
"Assisted-by:" tag?

Please resubmit them all with that included.

thanks,

greg k-h
