Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9044C64C;
	Fri,  9 Oct 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548544; cv=none; b=TDONh2g//bUPBiE/t5swaafQkQyaRI0sOcTaJm7O6+qDK4aFMQKSZYMx9S7EUf805fWslliNk80bvVcTgw2WmWnbF2Iu9zLgKleiLDn+Wytfgqh6UOCvKmhbpMdyMZ69KuBnD4niLQ/OBqm4/gChSB8ThrrK0RdQyiV14nRE91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548544; c=relaxed/simple;
	bh=464YzXGaDQUbdH+7KNEdxBgo56LjFG1riLV/FeW9DEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYsmH33M7MqOokNOkU8VyzQCC1aEnq8lEeF5PYZAD6QhiIhlDMMg1uQfQ92howg/CF2uw7yaTgZEojnK1kq97RW6mQBs+qAEY/appwFSL7ZWlH9MlZPe/TWzanYHo0mvPn0b3YlwW9WfZQOk7Nwy+IKV68XoXX03JtF+T61z/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4QMpZlUr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QMpZlUr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZqrK1Qsencsi1WEjQh8Yxu5eRbvhSvpLF3WsCRZH2UE=; b=4Q
	MpZlUrJY9LL0t1S1d5NYqm7eHgNjlOo1QjEUl2H173SfCZbQ5j5NCEHDUUVpORB+mpuJQS0DJizzh
	tt6UpvKz+wTcCzv0cHf3RmaAQD9nc8fzCQLQ9z5jxwzl/ZV6kHYE5MBHOnjl8IMbsH7cusZfz2vvP
	q1rTazV+qlU4LJM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xF9bw-009mlP-0G; Fri, 09 Oct 2026 14:22:04 +0200
Date: Fri, 9 Oct 2026 14:22:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Hayes Wang <hayeswang@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	nic_swsd <nic_swsd@realtek.com>,
	Birger Koblitz <mail@birger-koblitz.de>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
Message-ID: <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>

> Hi Hayes, Andrew,
> 
> Thanks. Since the newer ICs notify only when the link status changes,
> the driver cannot rely on another link up notification after the link
> has settled, so v2 can leave the carrier off when the first read
> returns the latched link down.
> 
> Before sending v3, which approach would you prefer? Both fixed the
> problem in my tests on an RTL8153B with v7.3-rc6:
> 
> a) Keep carrier detection on PLA_PHYSTATUS and read BMSR once before
>    carrier on, only to clear the latch. This is the option I asked
>    about on v1.
> 
> b) Detect carrier from BMSR and read it again when the first read
>    returns link down, as genphy_update_link() does in interrupt mode.
> 
> Neither depends on another notification. Neither reports a short link
> drop that recovers before the link work runs: with a) a later speed
> query still sees the latched link down, with b) the latch is cleared.
> 
> Hayes, for b): is BMSR_LSTATUS reliable as the carrier source on all
> chips supported by r8152?

Ideally we want a list of devices which correctly do notification on
every change of link state, and which are broken.

For those that work, read the BMSR once and report the down, and then
later on the second event, report the up.

For those devices which are broken, double read the BMSR.  The danger
is, somebody who quickly unplugs and replugs the cable is not going to
get the down notification. The dhcp client will not restart, so the
old IP address will be used, for the next hour to day, and the network
is broken.

    Andrew



