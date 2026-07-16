Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CE3BE62B;
	Thu, 16 Jul 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196446; cv=none; b=m5h4NJPhkYrot2bnzhKI93OqROp9YCtxgZ7bDUdr34NWcuQf8V1H197WokPawe9IbcGt6J6Me7cxKJ8niInTNlN1oyHsOOMKy+tJprVfOTrkGKT6qDKk5ReqK9vAx5FgGWdCh/t2+ZhB+xnIU5KHk8Npu1Re/BtzDYds8zNdtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196446; c=relaxed/simple;
	bh=hEC05jwcg9Skg9XbF3K3NtDonPGowgYQascbvjZAPLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc3swLulalO6EdeM0feM/g/APivJsKgpvd5eOWInVsBz1EdZAAg64QcHpN8K5gqYpP9Dt5Mt3wShlD2BjMdvAkWRFQCoe3IxyCp3FegpXbehKwgMaKIvmgZUkH1Wca2Jg3uoZOmm36PQ2Z+d0c0kcmlDpwNHX7WZUyPixG28G7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBAsic7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBAsic7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F41F00A3A;
	Thu, 16 Jul 2026 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784196445;
	bh=jz0KHElU6VtPQe+4sG6f4UAGeXGN5XeMuMXaMZIDuc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oBAsic7u9eXZAcaF/I+2S2lPtykMuxyNqB0E/L1OyW6SUmyYLbNH9fJBVqXsWHGyd
	 PcEH2JhLkwuRpOyWqtpy5Zb2i8lnu5k6v8MzZgsUGRZaYQR0QoBkTZlkZ2j25Q1NM7
	 JlqALoMgwfZXJ1tEYI1HxwpTgBUdyTROHhNY4RPEX3MDHA816g53SzBCIaPWPrEMW1
	 OdNXfR5dsWhT9Zukqdav4j2bpK62Lp73PfTsVPLN4cVhHZC6YEejSafEEdWOJkFiAl
	 E7yuOf6vp2XDw4Z/tgbAGmjkWDK6mDax3Q8QIeyPMmjQ0+fDhEQG2RGbk2jpylLZBl
	 dsbB2VbWRQPYg==
Date: Thu, 16 Jul 2026 11:07:21 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev,
	david.laight.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: bound the connect_sn TLV walk to the
 skb
Message-ID: <20260716100721.GG95246@horms.kernel.org>
References: <20260709131229.44477-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709131229.44477-1-doruk@0sec.ai>

On Thu, Jul 09, 2026 at 03:12:29PM +0200, Doruk Tan Ozturk wrote:
> Commit 27256cdb290e ("nfc: llcp: bound SNL TLV parsing to the skb and
> add length checks") fixed the unbounded TLV walk in nfc_llcp_recv_snl(),
> and commit d8bd2dedbde5 ("nfc: llcp: fix OOB read and u8 offset wrap in
> TLV parsers") subsequently bounded nfc_llcp_parse_gb_tlv() and
> nfc_llcp_parse_connection_tlv(). One sibling parser sharing the same
> pattern remains unbounded: nfc_llcp_connect_sn().
> 
> nfc_llcp_connect_sn() walks a TLV list, reading a two-byte header
> (type, length) followed by length bytes of value, without checking that
> the two header bytes or the declared length stay within the buffer. It
> returns a pointer to a service name of up to 255 bytes that may point
> past the end of the skb; it is subsequently consumed by memcmp() in
> nfc_llcp_sock_from_sn(). In addition tlv_array_len was computed as
> "skb->len - LLCP_HEADER_SIZE" in size_t, so a CONNECT/CC frame shorter
> than the LLCP header underflows to a huge length and the walk runs far
> past the buffer.
> 
> nfc_llcp_connect_sn() is reachable from nfc_llcp_recv_connect() and
> nfc_llcp_recv_cc(), i.e. from received CONNECT and CC PDUs. A nearby
> NFC device can reach this without authentication; LLCP link activation
> happens automatically after NFC-DEP, and the nfc_llcp_rx_skb()
> dispatcher applies no minimum-length guard.
> 
> Walk the TLV list by pointer, bounded by skb_tail_pointer(skb), and
> validate each declared length before use, matching the approach already
> used for nfc_llcp_recv_snl(). Starting the walk at
> &skb->data[LLCP_HEADER_SIZE] against the tail pointer also removes the
> size_t underflow for short frames.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2: drop the nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv()
>     hunks - fixed independently by d8bd2dedbde5. This resend covers only
>     the still-unbounded nfc_llcp_connect_sn().
> v1: https://lore.kernel.org/netdev/20260705113505 net/nfc/llcp_core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

