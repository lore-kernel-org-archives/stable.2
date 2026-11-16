Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865161;
	b=c5UOL+arGqTxh9dKpbSeW6MQSnfxLJiZG2u40pHSL69pfujNyCcSIQpsCesGJNRxIaJ/
	 xUKyrj/Mnes6H2wiasQiWFcd8OtI/b0HXHedv5bdfWokbOBFMZHp4m4YSQDPDEnDGCtAA
	 CmN23suONS2baMNlFeKStNEytyXp9U6ytxcmXvyU5mCu4rXMYTldk7oUq7iYtlLkplnWr
	 wxi34ewj5W2B8se+WuGE3yNZpfLP1FkvbThhWVQLCpWllJ/+iVa4HRmimdMyzD8bcG1nn
	 awfILiVhhhbQ5VABOTpHPYnbtLA9yZChB5PR7tykV8wl5S68F6sSJPWaePUvIzNEpnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865161;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yYAsEB8BH3PiA+kHiYs4W3fhfHk22zC78uA+8Sl6HJg=;
	b=fJ3rkS+SIM+FS+RPynnVSL6DJPqjX4qK6DRHktMG4nFvodWV4cfmjl+ZAeWr6NHipvzb
	 xIBu82ybNWN/ipq6zYgUJ7W7a3EuFksqL7hrdGrmZtQQNFEGJsugIKxGQnJ8TPq8K2NOv
	 HAfpCtAMH6PCUdNgcmpQFhezlfisVGEARGl0YLGdQboD1ak7ExVoVVPwh5PrU/GLwdckJ
	 bua3UXQp5UxOsvhSoDLMjsmp64/Kepfv/oIWXT/BoRVu5wd8rhos+t/EQhIS+800U5jON
	 rDaxl6BUHeuBdT+suReSwFy3X8jfYh7jB3whLlyBGAj/A2km0pnwWM9DvRnx8Rqf2Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bD7r6g/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECD606A31C;
	Mon, 16 Nov 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD7r6g/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF461F000C4;
	Mon, 16 Nov 2026 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794865161;
	bh=yYAsEB8BH3PiA+kHiYs4W3fhfHk22zC78uA+8Sl6HJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bD7r6g/GgoqGyQFIp8E6K19DS+GRyUpUTJsn7mfCafczJrGdjjMMrGndYsc/O9JKB
	 /Z7f7iaGdJwRbaF3PqrST39wr8rBCCaD3i80ilUFBm9NJpzMFuHrFz7D2TSUfj0awS
	 IajonQT2TUF1tkxg1f/4QOjdDIre/uXl12OqlaT0wka344eKQAWrUPH7MNSD1g5r/O
	 pNS+Vnfi9WS06mjuyJbLg/I+D1bSqUqN2cP9e5U5g9KhYDV1NT/RXU+BkYpsmpelDI
	 FJVdg9578X56Ak9XWgTSm3kVRZX7/SHUY7IPTJ5Xc5HNSgw2G4KmeGkU5cGZLvg7GV
	 S23W+c0X5N25w==
Message-ID: <88a268a3-20d1-4f1e-97dd-0076da92af6c@kernel.org>
Date: Mon, 16 Nov 2026 13:39:19 -0800
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
Subject: Re: [PATCH] ata: libata-core: Add max sector quirk to INTEL
 SSDSCKKB240G8
To: Justinien Bouron <jbouron@amazon.com>, Niklas Cassel <cassel@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <mkp@kernel.org>, John Garry <john.garry@linux.dev>,
 Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gunnar Kudrjavets <gunnarku@amazon.com>, stable@vger.kernel.org
References: <20261116205430.44305-1-jbouron@amazon.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261116205430.44305-1-jbouron@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 12:54, Justinien Bouron wrote:
> INTEL SSDSCKKB240G8 with firmware version XC311102 runs into FPDMA
> timeout errors when queue/max_sectors_kb is set to
> BLK_DEF_MAX_SECTORS_CAP = 4096KiB / 8192 sectors. Similar to model
> SSDSC2KG480G8, the issue disappears when setting this max size to 8191
> sectors, thus apply the same quirk.
> 
> Firmware version X5A1ME59 for SSDSCKKB240G8 is un-affected by this bug
> thus keep the quirk specific to firmware XC311102.
> 
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
