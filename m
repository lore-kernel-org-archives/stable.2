Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFF400E0D;
	Fri, 26 Jun 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490348; cv=none; b=tlwvmp55H6TtQO/0MwMMXmB281KqJfQiipLB6cMoAR39zhUh0CUy+Yv4xgHoSj+drk41dxvH1kRtzCYEdbL4OVkSchL0bY4A5cZLjP4Q5/lWdLfqDWIaVTOs2r1+MnWwRqRrqPlLdDPA5YOUNUDHJZhn2/8K1jjmWJ/lBsP9cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490348; c=relaxed/simple;
	bh=ISwVEgvPeIhpSVRDPum/uCO7UKaxWvF5D0mY18XDJa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoCqOciEnkZzb++9tvwVymXeHbgc71g3Mib02I+dlibPk2ltJLSleuEQugYNXiZiresI4v3drEuoCZ20VvejCDicuCQHsCTJuwDXaUJn8wkseQKaGabajuh9bzyOq2Vq/h6LNQ2tQGyL6YAnQbEWtg+sLGb/hcX7p+wxg1rAifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=blSyQ+/9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="blSyQ+/9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZbRZRFSGqO+LRDzsnXP4Xb9np6R1yKu/VFJITsVvY2k=; b=blSyQ+/9WHCKWgzE9GoTW0lJDP
	CxAsS3MbtWNmaALGkmdOfHHud3lg2NRZvdDpj7Ut5arvEIY185Waf45/4MOYByrolsrnGzwiVJhHk
	XyxdegZNnW7+cYpAVC/Igpt3ieHFSvQK8l3Sse/vNOrN41gVxJQmPaJ8zaNeqcRJV36w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd9A7-009OHV-LM; Fri, 26 Jun 2026 18:12:15 +0200
Date: Fri, 26 Jun 2026 18:12:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: ti: cpsw_probe_dt: fix phy_node reference leak
 on error paths
Message-ID: <e5562d13-eedf-4e18-8adf-1665d6a9e77a@lunn.ch>
References: <20260626152906.52112-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626152906.52112-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:29:06PM +0800, WenTao Liang wrote:
> After slave_data->phy_node is assigned (via of_node_get or
>   of_parse_phandle), if subsequent calls like of_get_phy_mode or
>   ti_cm_get_macid fail, the error path jumps to err_node_put which only
>   releases the loop's port_np reference but not the phy_node reference.
>   This causes a device_node reference leak.
> 
> Release slave_data->phy_node via of_node_put before jumping to
>   err_node_put on error paths after phy_node has been acquired.
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr
