Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAB27456;
	Sun, 14 Jun 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462365; cv=none; b=oj9SQMfUaEVPT+6mcKRM/5iUueDIPuiyEE9z7Zt0aupG9yf+jrSjWWGPk7DnGlfqI8UPqbELcUFt2so0MdwolTlGCIgqAqyZlocXWJ42v8b5K35GGQDdKeAQCko5fThsVKVvF5Zo9oARdKtiI3y+X4eBjehCFp2bcOd5i1cOXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462365; c=relaxed/simple;
	bh=XWeJ+VAo5WoGAHZj20GCG/MtvCQ96kosUj0MbYlCE2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNKSS3tdMfBQlpcfeDP5ZnObUmbpvDUNinC//tX7z5L8NQZuL96xLr/I1zwgZga/HsF5T/n1b5QpnSXL0AqyfperwhuQjbUVS9+ZgmmpDDiB1rxHRJ73Cdle4Zrbdv2ova3/mxGBBd/aYRSqFIqm7Z6F/pZ/ErK2tgqVeSwssUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XoeQRymO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XoeQRymO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TXNeFJn+AG/aK3bbUBS/Q7VeiAGyp4weS0aoeXvjXUA=; b=XoeQRymOQBh8G5gC64tIq3y5eM
	R+4VJiZGkpv6ehvpJ8zQon7ElnXs9P3Pgv2n+UzS7FVo3Yv0ckPpRsk9TwOhIGO/+wL6U+DFNj1km
	0bvkBvOcIOPKai4R0N4qDhOa0HDadUIgApcz71vsNDHsd3VtMoV3YUWcgJa2PnTve/k4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYpjk-007gbh-Ja; Sun, 14 Jun 2026 20:39:12 +0200
Date: Sun, 14 Jun 2026 20:39:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] atm: br2684: reject short VC-MUX bridged frames
Message-ID: <26ebc58c-6399-4a45-aa55-91a3bf398fef@lunn.ch>
References: <20260614152746.308-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614152746.308-1-zhaoyz24@mails.tsinghua.edu.cn>

On Sun, Jun 14, 2026 at 11:27:45PM +0800, Yizhou Zhao wrote:
> br2684_push() validates the two-byte pad at the start of received
> VC-MUX bridged frames with memcmp(), but does not first make sure that
> those two bytes are present in the skb.
> 
> A short AAL5 PDU can reach this path after a BR2684 VCC is attached with
> BR2684_ENCAPS_VC and bridged payload.  If skb->len is 0 or 1, the pad
> comparison reads beyond the valid skb data.  When the bytes beyond
> skb->len compare as zero, the code then continues toward eth_type_trans()
> with the malformed frame.
> 
> Reject frames shorter than BR2684_PAD_LEN before checking the pad.  This
> keeps the existing validation for valid VC-MUX bridged frames, which must
> carry the two-byte pad before the Ethernet header.
> 
> Fixes: 7e903c2ae36e ("atm: [br2864] fix routed vcmux support")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1

Same questions as for the previous patch. Lots of parallel
discoveries? What hardware was used, etc.

	     Andrew
