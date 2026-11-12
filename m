Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794492864;
	b=U1/HtHS3mYCrhvT/oQkAJRKqaXZ9LnMxsSW8DWC+/lIQADPOJLC7/5hPeWJkYpEQjCPk
	 ewuLhpZ0CzcKTmbmZ7K7Tuzch+6iuWflVxYDRfjNfcUETHsfjXPJ1uC+FZPn9A1mFW8qu
	 XiyqwuwamKNK0emVjfaDXz6vHIphgeZK41gFgNuqOzm8HJRr34B9HyunkFwt1XRuj+uBb
	 VFWWW+wIPiSUjwBrTO6snLOCucu5iYxziS3LbdfiM1fk9JEGhNFyjsxIOIL94mxDb5r02
	 3e/Ra2P2NpTwRsUD0GZawbHvv2N6xPO3ofz+qlVU38v/0JHS5Zdly2vxDUyTHnCo7kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492864;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b/4UOiXvF4Fr1l92XLmjcr1eg7nNlBSU5NS1Fo/IyFE=;
	b=jEB2N0FbrehnvVqUPlLWwL2YeXhofrvALCuofJrmYTVLhKAfqbNzHZvqO6d56D/fl2p+
	 x7d0W9/MWHLzn11QYPSNq/2DHApT2RyDu0dzNlsUpsrp4OrBQet459Z5d/rfI/hF2u5AJ
	 qx/yXnSQ3tUQ7GjGMxzWFqe9QUQZjCGlNaSydD+tMnY/N4NXqfI9/8nFdMKgDmfgPHeKn
	 sxcanTHhVNKYqsXSToHvqa4/mMJC4zp7wcQQ/zdVaRRYqZMcy7Z3GVY23uHxky9atRfHF
	 leAfdRK2Nk755wxl9T9PyBpjno4Eqv/UFgfzDQ/giheynN6WCa0aAqNC84msA7daM7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NAA3skTk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E9606A31C;
	Thu, 12 Nov 2026 14:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D92E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NAA3skTk
ARC-Seal: i=1; a=rsa-sha256; t=1794492841; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LuyQY12bW/Z83IwfAOxYJxZ41E4wry34UxveT0D7p1+KeG7vuh/g3/Z4PL/QiweY1cAObHPOqdNN/ST9ovLVoulqLB6bQcsSTjpu6+AM2Ic610a4k2B4uTEqtRfchqN3tPwu9RVXJDXtLkU6M0IGvzogik9csYMt7ietj2/S8js=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794492841; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b/4UOiXvF4Fr1l92XLmjcr1eg7nNlBSU5NS1Fo/IyFE=; 
	b=Jh3Jwp/xcKr3QKgJDQDf4E73hZu+wtI6ebEk8TbtrWlJP3CZ3MCU6v+pPsoAksowh2AxTMeOVC88QvUJRBWyiUjmn39z10Wfj6SFAwyNTbQsd4y688beAE9MMxDrreNbjzLFt1UAHYle0tb/I2Nc2jHyyiRzD5tU14dDYcElZ2U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=NAA3skTkaOCGS4WxaR16OMOYO4CU8JVVcpLMtoI7vIovt4Dfwq56POyv8ssffi5G2sLrZk5OMqH5Z9I5dqeVZXLfMkODQj1dVWmhQg9vXsc96zy1cvmu6WHRHj/Gvwhr50LP6e9o0juz27pfKKS/2LPFjTjLzkGAov5QTWIWmCM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=b/4UOiXvF4Fr1l92XLmjcr1eg7nNlBSU5NS1Fo/IyFE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794492839836438.0202804362593;
	Thu, 12 Nov 2026 06:13:59 -0800 (PST)
Message-ID: <f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com>
Date: Thu, 12 Nov 2026 15:13:54 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
 after remove
To: Philipp Zabel <p.zabel@pengutronix.de>, aiyengar1990@gmail.com,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Hans Verkuil <hverkuil@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>,
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, stable@vger.kernel.org
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
 <20261112-hantro-robust-v2-2-18561fd48838@gmail.com>
 <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 12/11/2026 à 11:19, Philipp Zabel a écrit :
> On Do, 2026-11-12 at 08:30 +0000, Arun Iyengar via B4 Relay wrote:
>> From: Arun Iyengar <aiyengar1990@gmail.com>
>>
>> On the RK3588, the resets of the AV1 decoder include the AXI and APB
>> bus interface resets (SRST_A_AV1_BIU, SRST_P_AV1_BIU), which also cover
>> the Verisilicon IOMMU of the decoder. When the driver is unbound, the
>> driver core runtime resumes the device and, through the runtime PM
>> device link, its IOMMU. hantro_remove() then asserts the resets, and
>> when the IOMMU autosuspends 100 ms later, vsi_iommu_suspend() writes to
>> its registers while they are held in reset, which raises an SError and
>> panics the system:
> If vsi-iommu accesses require these bus interface resets to be
> deasserted at certain points, why doesn't it request its own reset
> controls?
>
> Depending on implicit assumptions like another driver not asserting its
> exclusively controlled resets seems fragile.

There is a side note on IOMMU doc saying that once the IOMMU has been
enabled it can't be disabled for security reasons.
That means that writing 0 on VSI_MMU_AHB_CONTROL_BASE register in vsi_iommu_disable()
could raise an SError so I would suggest to remove this line from IOMMU driver.

Regards,
Benjamin

>
> regards
> Philipp
