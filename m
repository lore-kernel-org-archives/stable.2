Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFE27456;
	Sun, 14 Jun 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462260; cv=none; b=Zi7nqYsh4ztxBWM09GrUq2ZKJjyBjoOv54/L+VQiRwia+XSInx2j9qvbqO9V+gHdWv7W0FztVcIjZec5a2uWJEFqPCGP7GHiUFhIdVe13KXteNpZsrGkTslB6bDbwoUoODp1+R3rCN/xPuA+dJgWWjE6hrPRSz8N9mwS4skH28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462260; c=relaxed/simple;
	bh=Z7HDfVJg2jcODeiTiqOrlDAJJhrLYUUdqKCMicF5dg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFKF/roJJMKbxkyHqc/fIvSedloJUBUzyFKmDEwSaUC+V3s1XaCo832iFZxU1ZN6bB02/k4BT+jUQ1/Z0B73MmFXv4IvTCGQ5COh/9W3Qpvo+HeUa2vkRTxV7POkXmQB3c/NJwmV6gUtJ5QLjVKlgTimq0oMIS8YQdgZksH9kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BIIGEw1p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BIIGEw1p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hugQHs4sKsTK6Ai2NwmbPrwwXHDZ4UgWd7vqKRkJQ84=; b=BIIGEw1pe0onp6jNBRHRzN7ucu
	eSDC8PAcam0j14+iCbKI6yR7kbWP25vga4NMV5eQXGou6G3S6RINnXN6x+CN+uXL2vBF8lB9qr0nN
	CdkgHCBA/DCUDV7Qr03pmiWx1JECyFilFnalj5vJgJxv7zinJlHcncFKUwQf7RUEdFxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYphZ-007gaR-OT; Sun, 14 Jun 2026 20:36:57 +0200
Date: Sun, 14 Jun 2026 20:36:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] atm: br2684: validate IP header length before
 filtering
Message-ID: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
References: <20260614084027.1179-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614084027.1179-1-zhaoyz24@mails.tsinghua.edu.cn>

On Sun, Jun 14, 2026 at 04:40:26PM +0800, Yizhou Zhao wrote:
> When CONFIG_ATM_BR2684_IPFILTER is enabled, packet_fails_filter()
> treats skb->data as an IPv4 header whenever the packet protocol is
> ETH_P_IP and then reads iph->daddr.  That read is not protected by a
> check that the pulled skb still contains a full IPv4 header.
> 
> This is reachable through the receive path.  An LLC-routed IPv4 PDU can
> contain only the 8-byte LLC/SNAP header; br2684_push() accepts it,
> sets skb->protocol to ETH_P_IP, pulls the LLC header, and leaves
> skb->len as 0 before the filter runs.  The VC-routed path also reads
> iph->version before checking that the skb contains an IPv4 header, so a
> 2-byte PDU starting with an IPv4 version nibble can reach the same
> filter decision.
> 
> In both cases the filter can make its pass/drop decision from bytes
> outside the packet data.  A reproducer using a dummy ATM receive device
> filled the skb tailroom with 0xa5 and showed that an 8-byte LLC-routed
> PDU and a 2-byte VC-routed PDU were forwarded when the filter prefix was
> 0xa5a5a5a5, even though neither packet contained an IPv4 destination
> address.
> 
> Drop IPv4 packets that are shorter than struct iphdr in
> packet_fails_filter(), before reading iph->daddr.  Also reject
> VC-routed packets shorter than struct iphdr before br2684_push() reads
> iph->version.  Such packets cannot contain a valid IPv4 header, while
> normal minimum-sized IPv4 packets continue through the existing filter
> logic.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>

So did all these people find the problem at the same time in parallel?
Can you point to their reports?

It is a long time since i worked with ATM. From what i remember, ATM
cells are 48 bytes in size. So can the packet actually be smaller than
48? Would a 48 byte packet trigger this? Or is AAL5 involved here? Can
AAL5 carry a frame smaller than 48 bytes?

What hardware was used when finding this problem? I know DSL often
used ATM underneath, so was it a DSL modem?

	Andrew
