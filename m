Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032298;
	b=yIxDjy+Q06wpKuBeOZ1LzP1FtHUe7qrhRgg3SMJyo7JsgVs3PILEIyfwr72SK7FdQEDh
	 OdOVwXt+ROgvzTS5cKjqb3kyAu6IuuanA4pONJXERNYUZriN0K/lEQn76UFKgtLUj5oWJ
	 uPbGzJawqnqC7XWv2XI4gNejw58Ef+dv5QgwN4jJgjdSkPzXynhKz/s85CY008UV7UEqb
	 ta8lKorGpmmWsHat4Ez6V5a5NJCAOETfLuFZFrvZ0WVw3CJshcAQXrmpGVVPTYzFYQszp
	 WSgOo36xvbmvN+kBRmhMQc7JXhS3ZOdYJEkBlRsU8TFpMkumWdwu7pc8TL+7Tu08qiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032298;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Shx5Rs3ERCYkBOzZH3Om29/lV20CBoRJBqj6ilDEc3c=;
	b=q7bVD+p0qF2gBhorBoI1Ym23NhG9JJKglY8caFZV+kRd+78KUzmhs5hHPjSYHXm3Yc4y
	 VnWwxfLJ5MrvwV6urDC/eCIwnPXBsdECe2SLv9Po+RuDC13qFz4xFZc5i4vNL+/otp2IO
	 FuYrgZbBQiKs+Ph17RgpOotN5Kg8Es/z8GapQusEF2X+zqReFuidYb+B08RQQNHRWS3rc
	 kbqhzc5MI/MYJuhwFpHT2/t48uuVIPIQbGzJDnkRfDCR3ymn1gux92a489DPM1mWgtl7U
	 Gq4fPdWGXJeVhZYIVX4/Bpk6yEzOObSCygcgYrB2W0LXUElpYchJDOWinE6Ihh+XHeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4NnhW5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE9606A320;
	Mon, 26 Oct 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4NnhW5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5801A1F01825;
	Mon, 26 Oct 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032297;
	bh=Shx5Rs3ERCYkBOzZH3Om29/lV20CBoRJBqj6ilDEc3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4NnhW5tI5ka9y1/OjFrGob6cRzM9clGGgXqK8fZtXTrXzUmjPLdtzl1xBOfN7vFQ
	 WOPqaWANvaXnd47mUjOySkWOxQeoRl6qVuTkPqUaAIURXxVbykQCiqSVIcwayOfTf8
	 mzWA5N9u7K3n7RjNMW5ANrwYfypvDtvAfD+FteQAhxa9uzJHwM5qD2iYiv+dxzXKXh
	 S8EiyE6OjL9L7dKFCGrYUqcFHXBsBfmlPf+FEsuiRETEMQpZem4K6YKIZ8YSNTYuML
	 EPGYaiirYPgT3Z+E0iAGYavUzLhjxtnEHckT9KJJeIbPoujVmIG1HaxtV4g4puShKF
	 zJpTFb5j7rfBQ==
Date: Mon, 26 Oct 2026 16:31:33 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: usb: pegasus: do not advance
 rx_skb->data on dropped frames
Message-ID: <20261026163133.GB257209@horms.kernel.org>
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
 <20261021020310.34045-2-law.wei.jie@gt.tech.gov.sg>
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
In-Reply-To: <20261021020310.34045-2-law.wei.jie@gt.tech.gov.sg>

On Wed, Oct 21, 2026 at 10:03:09AM +0800, Wei Jie Law wrote:
> For the 0x8513 chip, read_bulk_callback() skips the 2-byte receive
> header by advancing pegasus->rx_skb->data in place. This is done before
> the pkt_len > PEGASUS_MTU check, and when that check drops the frame
> the goon path resubmits the same skb with the advanced rx_skb->data as
> the transfer buffer, still PEGASUS_MTU bytes long.
> 
> Every frame with an oversized length field therefore moves the receive
> buffer two more bytes towards the end of the skb data area. A device
> that keeps sending such frames makes the host controller write received
> data over skb_shared_info and past the end of the allocation, and the
> corrupted skb_shared_info is used when the skb is eventually freed.
> With an emulated device sending frames filled with 0x5a on a KASAN
> kernel:
> 
>   BUG: KASAN: slab-out-of-bounds in dummy_timer+0xade/0x3f00 [dummy_hcd]
>   Write of size 1536 at addr ffff888105821202 by task swapper/1/0
>   ...
>   Oops: general protection fault, probably for non-canonical address 0xeb4b474b4b4b4b4c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0x5a5a5a5a5a5a5a60-0x5a5a5a5a5a5a5a67]
>   RIP: 0010:skb_release_data+0x36f/0x800
> 
> Only skip the header with skb_reserve() once the frame is going to be
> passed up, so the receive buffer always starts at the beginning of the
> skb data area. Unlike the old pointer adjustment, skb_reserve() also
> moves skb->tail, so the two header bytes now count against the buffer
> size: lower the length limit for the 0x8513 accordingly, otherwise a
> pkt_len of PEGASUS_MTU - 1 or PEGASUS_MTU would trip skb_over_panic().
> 
> Found by code review with LLM assistance and reproduced with an
> emulated USB device (raw-gadget + dummy_hcd).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>

Reviewed-by: Simon Horman <horms@kernel.org>

