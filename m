Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADCD3E6DC9;
	Thu, 17 Sep 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645548; cv=none; b=uyLNK/0NRAsYzvv2r7flgELyKk/ToZ2ZPxLqJDsYYvMj9qnZP/dr2jpNRn6981/UjbYURK5oI0u/A/8XVooLO2+xBtJSoSU5AdHh85wvtH1yYYwvh3XQqX6PzxPNxmJP/IqlJIC2UrfsPT+Hgddy172ReO5yt02s8nEqzqkjJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645548; c=relaxed/simple;
	bh=/3xFAsixpbLOVmiAeQK4biZ/FbUY9ljCoxm2CgIBQ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmFmOw0V9YNmXlXRu0l3j7h/JXND6h40D3ej2SvESEueHCEDDQnswo4bLKCLNdeedQjjlH3j6TDkEFOy5WcoDNI776vFer4ntgkzve7ElTaPDyb5kjsu3OzXWIDD7AG05iYpaDZ3IAKtUXV581sb1TxJ2VTl1Fwf12TrDO4QB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjAr3hwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjAr3hwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC03D1F000FF;
	Thu, 17 Sep 2026 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645541;
	bh=0v+tsxXpYqYIhx4Aiu8hayvlXd6sXVZLkcA+EBndX9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FjAr3hwtoDc25gxTuEmNtgzR50wEOfrVyKXJc/4R50IdpnSbDcCQnTl4D77hSZaNX
	 z7KjXUslA//XbInacrrCteJQNcrQLt5DhxPmq1ka8hddLXW6BOywZODFMr9J9l2MAZ
	 qIb+f/HzGyIJzX0O2PV+xwZj1VeimloAYUYudAwA8InD4Js94ThXnp8j8T7zqbG6vQ
	 ytgkCFvA1on78uHtM6G59ommoGl2D4SyZago/nDovtly86ZOWF6I+nLgzAfTA2e5tJ
	 VieJeGEM+g9hRpx1L99M9IEXG9QYBS73E1C/KHx+utC87QzkMHQAQPVfk2E7nRsU/2
	 PRb5svoD8ZdUw==
Date: Thu, 17 Sep 2026 12:45:35 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: drop truncated I/RR/RNR PDUs in
 nfc_llcp_recv_hdlc()
Message-ID: <20260917114535.GZ51261@horms.kernel.org>
References: <AS8P251MB0001789BBF04B72745C7D96BC8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8P251MB0001789BBF04B72745C7D96BC8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Tue, Sep 15, 2026 at 07:54:27PM +0100, Aamir Ahmed wrote:
> nfc_llcp_recv_hdlc() reads the sequence byte skb->data[2], via
> nfc_llcp_ns()/nfc_llcp_nr(), before any length check. The receive path
> only guarantees the two-byte LLCP header -- __nfc_llcp_recv() checks it
> with pskb_may_pull() and nfc_llcp_recv_agf() admits two-byte inner PDUs
> -- so a two-byte I, RR or RNR PDU reads one byte of uninitialised skb
> tailroom. The byte becomes N(R)/N(S); a peer can already set those with
> a well-formed PDU, so this is acting on uninitialised memory, not new
> peer control.
> 
> Guard the read with pskb_may_pull(), as commit 95674f506c63 ("nfc: llcp:
> reject PDUs shorter than the LLCP header") did for the two-byte header,
> so the sequence byte is present and linear before it is read. RR and RNR
> PDUs are LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE bytes and an I PDU is
> longer, so no valid frame is rejected; a truncated PDU is malformed, so
> return without a DM reply.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> 
> Notes:
>     v2:
>       - scope to nfc_llcp_recv_hdlc() only; the recv_dm() half duplicated
>         Lekë Hapçiu's pending fix (20260729011547.19191-2-snowwlake@icloud.com)
>       - return silently instead of answering DM(NOCONN) as v1 did, which would
>         close an established peer connection (Sashiko)
>       - guard with pskb_may_pull(), matching commit 95674f506c63
>       - add Assisted-by, target net, Cc the right lists, reword the changelog
>     v1: https://lore.kernel.org/netdev/AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
>     
>     Built net/nfc/llcp_core.o on v7.3-rc1 with KASAN and W=1, no warnings.
>     No NFC hardware; not runtime-tested.

Reviewed-by: Simon Horman <horms@kernel.org>

