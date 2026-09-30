Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC81BD00C;
	Wed, 30 Sep 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753677; cv=none; b=MICJuVv0ASaKpcXiCEfZBKrukJzs7iPSXm3X91WRnhGDxs+bEJIMiqzY/uRHlQ+LHWhcOLsoIFdyDQxlRsjdGE3UFEQ4eFtocOVjZ6Nmt31UIgeo/wb4gdzqkvY8YzRt/Bvi/X/BDAQhAYTzBAGoKw/CsxpPVBnEyR9A9RwMREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753677; c=relaxed/simple;
	bh=q4Mww5UKlD02DAYB3cFdXC8xiTXbC0qbijbGPQV2a0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6Dkt0y4hHmr5FGoLB74Oguu5bIFD+goKflKWrRNmmVUswn4HQ37RQasq9LRbRMPmDWLUkOocGrTg4C3fckpKNxQQ4ZpRmv2fT8FOU8iGje/7T+v8lhrNdaBXnpUZPOwqGHnbNFBL8oXcITtXOJWZ8bRo97IjFjBKxsqHHHc2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go0VTqpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go0VTqpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20511F000FF;
	Wed, 30 Sep 2026 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753675;
	bh=+bgd0mVPJ948cD/Xsm5BN0c44HNmKafNptfUbdYM+II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Go0VTqpn1bYrONXD4rNQJNPshyCFNDML7lv7CRp/Cd2Xun8FYaNeXiqYYEGAI5j6s
	 Rs/sSXAfZbyeqO4Ufbq67H3Y4jym6hcqzaVXESJyqsi6lFkmS6rGx1eT//ABjKqPWe
	 04gk0SVqCnZvIY6viAuWYzx9O2XuBOkCjF72LNhKDjNH5F7rveLNbvDqDs1ggKQVtq
	 zJyX9r7IwNfxwghd6BS92xcb9OUF2M8o79ZMQDg0+GNLwg9cL+FBDt4WD+JTMXQwkc
	 gzxsJT3XWQpBseL6UtVN+4LbhyPidYzffLSaVgzmpKAruPs8NXaMIpEuvw6qu3edp7
	 VjF5Ap6LP7y+w==
Message-ID: <6b7f77f5-32f7-46a8-9082-3a7752651037@kernel.org>
Date: Wed, 30 Sep 2026 09:34:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix swapped ZRASF zone state values for full and
 read only
To: Andreas Hindborg <a.hindborg@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Karl Bonde Torp <k.torp@samsung.com>, stable@vger.kernel.org
References: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/29 16:25, Andreas Hindborg wrote:
> From: Karl Bonde Torp <k.torp@samsung.com>
> 
> The Zone Management Receive command Zone Receive Action Specific (ZRASF)
> reporting option values for the Full and Read Only zone states are swapped
> compared to the NVM Express Zoned Namespace Command Set Specification,
> Revision 1.5, Figure 35:

Not only rev 1.5. The same definitions are in all ZNS spec versions.

> 
> - 5h lists the zones in the ZSF:Full state.
> - 6h lists the zones in the ZSRO:Read Only state.
> 
> The nvmet ZNS backend uses these constants to map the ZRASF value received
> from the host to a block layer zone condition when filtering zones in
> Report Zones. Because of the swap, a host asking for full zones was given
> the read only zones, and a host asking for read only zones was given the
> full zones.
> 
> Swap the values of NVME_ZRASF_ZONE_STATE_FULL and
> NVME_ZRASF_ZONE_STATE_READONLY to match the specification.
> 
> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karl Bonde Torp <k.torp@samsung.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
