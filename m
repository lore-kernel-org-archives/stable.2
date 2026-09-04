Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B00248F64
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494574; cv=none; b=fmv2f/2MSzN/UGCTZQdFxSl0vstlje/i/4smFSkOOQ29zAv0lUoPGWXsoQCuHFlfATA3iBXlhwPL+eoE6rmFg87BqKZIx9RTkzX6iAF0dugWM1TdIHgEVS9my85D1LXQ4llZZ+1+1h0bzu5mQ1qLZ8ZIiOUgfL6Q8BBmrMB0bDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494574; c=relaxed/simple;
	bh=l7qxdyLthksN7viBx28FTROc2LOAvoR67yaOuXpXh6c=;
	h=Message-Id:Content-Type:Cc:Date:References:Subject:Mime-Version:
	 Content-Disposition:To:From:In-Reply-To; b=GE+hYJ6bStbVMRzV4EMRmvsIyBxSlM2gkM9XDFYMp875XpscmcWwTv3pwEq5C9GAmmS1UQOf+liA3iLFHQRP7EZDXkGdpIjhaQqIfzd4/IG4ns/UzsfK9oIQqDmpV0WURzsS7RlcJvzpslXlxCntiRvGERkB2pJt522fnyTKy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=jxV2cSsU; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="jxV2cSsU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788494566; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=l7qxdyLthksN7viBx28FTROc2LOAvoR67yaOuXpXh6c=;
 b=jxV2cSsU2wFZ2YfYPkHpwGMs6vAoKiOQCyxS9trvVJkiUf9FKaApBFCuhYJ3AF073+I1tg
 cZ/jysPbiG+8omxFiqzt0oEuwxzv5DlTkl9gctvwlYi+KtfplFWoETVOO3JuOwPgfc4jHE
 Bsv9veyip7lpx3E0Kr75Xe7yTE3d6z5hiZqlIH8pWL46oH2HsortJ/IpIl1JKVDz2Rdm+U
 g+KrgiypLuF3UxyJOU26gIqlO63oZujzEASqpgAsCwOUYqvYU9b1FI7Vt/8EJ3Y55LPrRj
 Gem2NWHYWuUHM9TLj11hcEQ5NShxOdSIBLMTVvkNU+bxaUJxTtl18Ckg7dGEOg==
Message-Id: <appC4LJ4B4NKtoRw@pve>
X-Lms-Return-Path: <lba+26a9a42e5+862d8f+vger.kernel.org+me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>, 
	"Fugang Duan" <B38611@freescale.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Fri, 4 Sep 2026 12:02:40 +0800
References: <20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc> <20260904-fec-ptp-pps-event-uaf-v1-1-9af446be4a11@cherr.cc> <GV2PR04MB11739E67E12529585010DEB7488B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
Subject: Re: [PATCH net 1/2] net: fec: don't leave a stale PTP clock pointer after unregister
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from pve ([111.42.148.74]) by smtp.feishu.cn with ESMTPS; Fri, 04 Sep 2026 12:02:44 +0800
Content-Disposition: inline
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>
From: "Shengzhuo Wei" <me@cherr.cc>
In-Reply-To: <GV2PR04MB11739E67E12529585010DEB7488B52@GV2PR04MB11739.eurprd04.prod.outlook.com>

On 2026-09-04 03:15, Wei Fang wrote:
> Why not move fec_ptp_stop() after unregister_netdev()?

Good point. I was focused on making the PHC index lookup safe
independently of the teardown ordering and followed the approach used by
similar fixes, so I overlooked the simpler solution here.

Moving fec_ptp_stop() after unregister_netdev() is cleaner and restores
the proper lifetime ordering. I will rework patch 1 accordingly and drop
the ptp_clock_index_by_dev() change in v2.

Thanks,
Shengzhuo
