Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456591;
	b=QjNtWMbIvnO915Rj3SZB4bSfFk7C7+CzFPCJMrxFvBk1pwd3BaEmRbr1yrrAn6MzY3N3
	 Wvgkt6BdhjhOImtothx+3ZBzfJ2nmM1DLgUmx35cxHuoBGGtr09Z5o1UWr8zn29e2LYhs
	 QYhKOD5W1cqFp4TzUndqqgPCa8/XZ6t45iYuA9lOrXaxq2BroLc7deuLoOxKXfz9qYuZs
	 +cx+OoJlV2TOj04/9YnGGmoVoLLhyu9tZ+i1bhnojG1x6SLr/av+cirIZPQqhxAcvtmmd
	 KcxPtGKgoJnfgfMRprYb6HOTfU7s7EQczReCmAHSPb8n4ZJ/0XubH4JLM+4A5uQAecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456591;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FjcL9AJZ4sENmxXqjg42oyqtitz2pn6fc7a0N6UMUyI=;
	b=AOGYYSLHmoo4AOfa+uu2nw1j9oLrhKAahRZAL6LUsLPVYSfh7lj49r72tTtJTrJKo1IM
	 a2mt9aYHipZSrUQ9SHG2bMdx71oBhXK9MrZlYP8vCXDdJ/18pXI+w/g+Ani8F2noXxnGX
	 HzZj+KF9absgA4lrTf/wCoAv6eze2rt/Wt3pF7yDMi3J2yhPVNvxx9TdwX/20fow2/AA7
	 VKNdPHyp93g4kXeZU//nDpQw+sngJUHDi81PdlR4I4YYOBdekd2Nc2AviS8H6wqwgJDHd
	 LRq3YRJmNlZGQL5qEljnueXOHoH79QjpXzEkzPoa6u1cTcMYpz6i4eI9UGQPXeyE8zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=klvaBI4N;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB0606A331;
	Tue, 20 Oct 2026 00:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCB0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=klvaBI4N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FjcL9AJZ4sENmxXqjg42oyqtitz2pn6fc7a0N6UMUyI=; b=klvaBI4N5Mhh8DjOhAKZsaSE9g
	7vYvd9Odn0GCqO/ednu0lxXh52iEFcCqIPxBBXk2/xAr7lkgxGtQn7zG0ACbdD3uoKS+bMWh2aaGo
	9tiOT6H7Xqb5C381/5wPgxbs9lJrDegQyJZARXhPOKup3lrClaDrXnsjenw9fO41zu8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIxpw-00BjO7-4e; Tue, 20 Oct 2026 02:36:16 +0200
Date: Tue, 20 Oct 2026 02:36:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] net: usb: lan78xx: do not update statistics
 after a failed read
Message-ID: <4080c576-e612-4192-965e-4df444f65b62@lunn.ch>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
 <20261020001621.2920-2-law.wei.jie@gt.tech.gov.sg>
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
In-Reply-To: <20261020001621.2920-2-law.wei.jie@gt.tech.gov.sg>

On Tue, Oct 20, 2026 at 08:16:20AM +0800, Wei Jie Law wrote:
> lan78xx_update_stats() reads the hardware counters into an on-stack
> struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
> rollover check is skipped: the counters are still recomputed from the
> uninitialized stack buffer and stored in dev->stats.curr_stat, which is
> then reported to user space by ethtool -S.
> 
> Keep the previous values when the read fails.
> 
> Found by code review with LLM assistance. Tested together with the next
> patch, which makes short reads fail: with an emulated device, ethtool -S
> then keeps reporting the previous counters.
> 
> Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>

net-next please.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
