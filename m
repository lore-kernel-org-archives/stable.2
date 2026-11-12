Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456786;
	b=HvlqSF/QTB9QD/RKiRtjK4hYVsWdGSAQTFNJP2JIvHBYu2PkV7g/Fxd1oIEBWMaibCIU
	 QOHJ5pNL6r5mNakO6rsibNuNh7XOTTYuypGBnx8HXwm4wF7xIeKcVaGDpUWWPlnHWquZh
	 ZdnB+XMLOFP4bjcidEc8cwFYpkkinuqELNyGzI+yGgSJEwtnPoqo1AE9cHw07A7Z1OdfY
	 okQHvZ+WhNylnvYCjusHztqLe97XQqWuvKBad7RyJREAnKSDzyEg3GPwT+elc9ayOfYcP
	 UtJQgsV6l9JkI2pApXLBqDZPckCn9syOGPBoMJ4FJX+jueC4PgYKKOrlc9j7mNq7EOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=IpWUmRExnEtcbdALoE0Cr5qSf7fpbyBSfGicozo/2Fk=;
	b=5cX/mdG7mHWAVQYL5SLswmEpnfw1MIQiMEPuJChwbiHXtbrXLiZkuRFUXV7b2jPChaTv
	 zeNDkNG/YndbuLJHUsvZ41/YxGfTD1YNIdGOQl/Sr5mHf1kQsVdgto9exOERKACFsdqmt
	 BjhDVK8hJQyhqAxAAkkVLlG6VnlD5Ynrgvdm/jSteRG1W12nv8jWJpRyt24t+q+jfZoY8
	 Oaq9F8C6psLCd5V2g1UNP6zlAdn8PYaosg3cEJnkSHGPQ+49zl1eVKGNrf4Kxdpx7L3AF
	 dD6r+zBIyn821/vRPmpTi0KrDpg94zJRtuAXphVk7dkuGzfBPAmXzQDCWiHckkomQ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JvcMI2h3;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB24606A31C;
	Thu, 12 Nov 2026 04:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JvcMI2h3
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQ6SC2vKtz57HS9;
	Thu, 12 Nov 2026 12:12:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794456779;
	bh=IpWUmRExnEtcbdALoE0Cr5qSf7fpbyBSfGicozo/2Fk=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=JvcMI2h3JoKiI/KvRzu2NO1PF5ll+pfYF35RFM7evo9gTDOGXx5HtolaC5gtvQiNI
	 sabWN068QBkccJ5MTwNMpKdd5tdaw79L5uCkSMk1b58do7vp4czmuJS7G6mH8nP7gX
	 Ro/8XfsQgZ5uMGgDuO/IKsnJLAhv6SO3m9yB3SeknGBh7X5Gfz0F40etGx6Tk4sH0Z
	 wxoUFkj1bUn/ukpXrqA7XV14X/sVhuYDZsnN6hNOC+qOokpWLbVe/2uw5sd+87+gX7
	 oXYnE0SukjRkM+g5zL0hIa7Y8aGp8vMgxbqH0zddoV1hhA35r/jophBVq7csSv/t54
	 C0E53NtO1uqYg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AC4Cr1t062157;
	Thu, 12 Nov 2026 12:12:53 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 12:12:54 +0800 (CST)
X-Zmail-TransId: 2afc6af53cc6d55-44861
X-Mailer: Zmail v1.0
Message-ID: <20261112121254674Lwi5B4G97rdqfX-kLlNRj@zte.com.cn>
In-Reply-To: <440db014-a58c-44e4-bc96-e950e69b6763@kernel.org>
References: 20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn,440db014-a58c-44e4-bc96-e950e69b6763@kernel.org
Date: Thu, 12 Nov 2026 12:12:54 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>
Cc: <cassel@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzRdIGF0YTogbGliYXRhLXNjc2k6IHNraXAgTVVMVElQTEVfQ09VTlQgZm9yIDMyLWJ5dGUgcGFzc3RocnU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AC4Cr1t062157
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 12:12:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF53CCB.001/4jQ6SC2vKtz57HS9

Hi Damien,

You're right -- those bits are reserved in ATA 32 and must be zero, so
silently ignoring them is wrong.

I'll reject a 32-byte CDB with any of them set (fp = 1), keep the existing
multiple-count check for the 12/16-byte forms, and resend the series as v3.
2/4-4/4 are unchanged and keep their tags.

Thanks,
Shao
