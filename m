Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24D2931ED;
	Fri, 14 Aug 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670474; cv=none; b=VGnsa+6wTbLogj3LMJEy+70SZ3y7Z/WCRsPQ007SbXXKNqKMwkumB1W8Es6E9+f466QYOwir5EPm7DKBA3DY3Mx9+bhxBzmo8gmOg86vQTdyrSOaAKmX0nCOqsi74DWgGGW3htvs/hwVv0keHAWxDhzfxyCSHAUJO1VjLGgUges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670474; c=relaxed/simple;
	bh=6MOFBcAQJtz1KEg++7AS+7cnBXyHvg/Mg13dg/EVhc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSJS4A2ihK8o8P0rjnex8Y1wTahBpbwdj9kfCzUzppnCG/MDnn9g4zs0ShpvbE3PDxNQXSYecvfsGqrxZT6qsIs6y+DpXnLCGk13f2THvbfMAoBoZLrY1iyHhlod+Gfw1gUVGmNnIjCCTdHIj5eJm0VXsHk/W0Y14CsQjtEqH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoaDoWzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoaDoWzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307021F00A3A;
	Fri, 14 Aug 2026 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670472;
	bh=pGd/Nbzf0/woxXyoYCLtltZgiXfrqaFQ0VzYyGSlY9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EoaDoWzxXblj9tj2w4XsJDIbThDRImzmJQF+XQPKbxAzU6+sByK98iJBj1kp/7eFc
	 4vGOBoEk5u34FzYu4qtlZqMwdiaV6bTTr1FtaRD/6UCbjasAvc1hXaMU7ox/PfmQvC
	 JcSU46+3zd9vrdz+AbnVnJq3RC/7CNcUNFhGzKPYQreYN/dz2ov7WOT2OTnVGlIRhm
	 VNlQ5mQladFHrkokfAihIDvNFP2cNo0EJTCq5JKrTJc1VQI0oh/RP8EPt3A568ab8j
	 iY3PcIxYqyFwNeHY2KfE51d3w38p9LKG5DQUFN6I8eSbUkfcCQeXBh+NU+cwpGGShY
	 OxmjLFQzTIlZw==
Date: Thu, 13 Aug 2026 18:21:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH 1/4] net: hsr: fix packet drops caused by GRO
 superpackets
Message-ID: <20260813182111.088aee3d@kernel.org>
In-Reply-To: <20260809121455.1745-2-xiexinet@gmail.com>
References: <20260809121455.1745-1-xiexinet@gmail.com>
	<20260809121455.1745-2-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Aug 2026 14:14:51 +0200 Xin Xie wrote:
> HSR/PRP process each wire frame separately for tagging and duplicate
> discard. GRO on a lower device hides multiple frames in one skb, which
> cannot be forwarded with valid per-frame metadata.
> 
> Disable GRO and GRO_HW when a lower device is enslaved, matching the
> existing LRO handling.
> 
> This is best effort because GRO may be re-enabled and some devices cannot
> disable GRO_HW. The forward-entry segmentation fix handles plain,
> trailer-free GSO skbs that still arrive; device-specific fixed-on GRO_HW
> output is outside this guarantee.

1) could you explain in more detail why GRO is breaking things?
GRO shouldn't merge packets with different L2/L2.5 and packets
with trailers?

2) the code seems inspired by LRO but LRO also has
NETIF_F_UPPER_DISABLES. This change looks rather incomplete.
Calling it "best effort" seems like an excuse.

3) Clashiko has a number of other comments:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809121455.1745-1-xiexinet@gmail.com
-- 
pw-bot: cr
