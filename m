Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AC3955CA;
	Thu, 10 Sep 2026 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034745; cv=none; b=nbbOU83hJ0JnkNIyXCT1N7gDrJyFPUQfH8yvQO1ekUuXjXxqycNKESKf1gi1VhdDgnG901/cO6tHUCzBnkyamiL/NVE6tlXtUbD0kcFgG4sj0vmgnw+w+lfyL/y6F6m7vplupd3erde+rwI+2tvtL+olJn0/Nu/GRLzGt1a4nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034745; c=relaxed/simple;
	bh=VP2JEcLwxrjx9fxceVXLw0Wh34i2sZgDDL+TqvAmKO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnhoncRHtpSI0sMeCyp8qSVNOW/CW7Dq2lf1siOb368g/E7gKHkfT4xgxId/2Hr/ZMGMtLxB5Z4n7Da7nS7LyGgUgaq4k6BXoUinz/2ajG1T1RqeU46sl6Ywk6+SdrIGRou/YYLr0/vUMJ45+b/33YQQvkCeZOM2EQVpCByOUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsbYvMMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsbYvMMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BE1F00893;
	Thu, 10 Sep 2026 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034733;
	bh=lgg2GkL5fgNDO1ZMfKkjX6HYmypLUd1Wvkwn8EBGFLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GsbYvMMq8a2fVr1gbI4FvCsu1rghZipQf2uzR1F5t+FV2hr7w3/ZduFZ917ujEhGK
	 gaO1jAavWJU4ryTMbFh+X4nEol1jSklDjgx/rIvpDp+1EJ2kr9tSm+1XQEYdNLlLxS
	 xyGC8wxQ+Mv0gWVtEQk8l78eMXqKuzHDaLJgWIT3fyVYA2X4b+KMoO52+X2ku66Mqa
	 M9ZARcApYBEyuoii4t6WMZ9/lW3fhDTC7Tz8DPmUnrLSBygeqPJsREmqnF2Ool4/uo
	 riEwhnv4lMO6BTAj1UAfH/SvRzGIl2duR25MRhtsEph+3c9qc3cW39KMayNtZQWFq/
	 AxE3YKtjc9t5A==
Date: Thu, 10 Sep 2026 11:05:29 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ncsi: validate response packet length before
 accessing fields
Message-ID: <20260910100529.GT40544@horms.kernel.org>
References: <AS8P251MB0001E6ABBE0B6809D3E21B9DC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001E6ABBE0B6809D3E21B9DC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Mon, Sep 07, 2026 at 12:37:51AM +0100, Aamir Ahmed wrote:
> ncsi_validate_rsp_pkt() computes a pointer to the checksum field based
> on the payload length without first verifying that the skb actually
> contains enough data.  For response types whose expected payload is
> fixed (e.g., GCPS with 204 bytes), a short frame whose header falsely
> claims the expected length passes the "ntohs(h->common.length) !=
> payload" check, but the skb may be much smaller, leading to an
> out-of-bounds read when dereferencing the checksum pointer.
> 
> For response types with variable-length payloads (GP, OEM, PLDM,
> GMCMA), the payload value comes directly from ntohs(h->common.length),
> so the header check is tautological and provides no protection at all.
> 
> Add an skb length check in ncsi_validate_rsp_pkt() to ensure the
> packet has at least sizeof(ncsi_rsp_pkt_hdr) + payload bytes before
> any field access.
> 
> Additionally, validate address_count bounds in the GMCMA response
> handler.  The handler iterates over rsp->address_count entries from
> the flexible array member without verifying that the packet is large
> enough to contain them, leading to a heap out-of-bounds read if
> address_count exceeds what the packet actually carries.
> 
> Fixes: 0b49507fc090 ("net/ncsi: Resource management")
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
>  net/ncsi/ncsi-rsp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index fbd84bc8026a..1401528dbd6c 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -45,6 +45,13 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
>  	 */
>  	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
>  
> +	/* Ensure the packet is large enough for header + payload */
> +	if (nr->rsp->len < sizeof(*h) + payload) {

I am concerned that there is no guarantee that the skb is linear and thus
this check is not sufficient. If so, I think the check should be
implemented using pskb_may_pull().  And h should be set after it is called.

...

As noted collectively by Greg and Paolo elsewhere:
1. Please include an Assisted-by tag
2. Please keep the number of patches in-flight to 15 or less

-- 
pw-bot: changes-requested
