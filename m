Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924300;
	b=SplybEMmhvEkRDWsBJnCN36BPzzo+WThnNYqMXWs5E18do1ASm4XYHLd0ROUkHytKrVY
	 quT8id3cFpDDwjX1uHXwiXXn8Pw1wa2i7MjgCgUQjtKV22KbByMctghsase6usFELc5q0
	 ncS/O9BaEgQmFiPLK2EhdUeEzLXIggv0s8Nad/VYXzgmkZjmy28Qk0JDbj2lcpXwSooLU
	 QXFWrx48KLZRXA5wjz7KFb7U2Xrv9z9p+tTV87E0cHU7HfxIZ4GhY21UIFXyVAPR/bWuN
	 Ral6eE2o16inSlNfjl1M/KoRG2tBLTiW+vui/vj/yMeuQCFxqNkQfL1sOa7WMI56/0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924300;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=o+yBsenDI2wUPc8JhBFdOyO8USU1Y1cTrtOmqBqpCOY=;
	b=qSGIvBL9WcsAJ5HY0NxLUGoU5LWckdRUEpF8rCUJCAoDJgjlsGqcdxUgM+1hCfv9oIE+
	 mJRmkMNfdCIybyIFtTEyiTmFpe73YmNDNJ1BEA9U8KHP1AiOYddxCnTTFxK9rAFquBby9
	 Iw4dZcODeD+lxD2wMS7tdTfqz+PAsy6CxqCI/LCYSIUeHbhrutJRi20HBYdaNSIfolXXx
	 nlCoLVEtzv/GlXK5/ZGINTu0xmHeSHy5XMgulTPgKUoHRdccVgNNdJCF3tHE6fubKzM+o
	 4guFgWsCVTtmkLHTUeP3dUWaunnXVQ2YI0bENcfRFWXwkj1EE6iv+ag6a1MNaq5tpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AWTwNaXE;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303C606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8303C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AWTwNaXE
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b179528d56so2292700a91.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924300; x=1795529100;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o+yBsenDI2wUPc8JhBFdOyO8USU1Y1cTrtOmqBqpCOY=;
        b=YGiw9Mv1k+2Zs4Bb5A7yPB4YXTgj5CUARBYdGPG+J6/pNq4uitVraUMSNH3a3pBy0A
         X4Maabdbr958gIserhUUdLGBRmGHtC7NMVwhXICyMwc6r4sAiPzSEVCSZWWBQOZeC2XT
         W8z3vNRDRxmC/rdNaAtcbY/7tSEI/xoTIhGITOQ4p4efP2cX9AKRC2JM/fc1o+nksuqY
         ci23JjZ1t4TBuW0PuP1e6fZpIYvGOJAfT1FzYACrOBOGsya2dwDfV+qaStiyx5sn8itU
         QUBOtww4yJP04J/jCG1IgGPXQ6nE+5ECx/K0Lidb9c3Ib2vS9+rZ+gGmmWlC0ru9LUKa
         nTfg==
X-Forwarded-Encrypted: i=1; AL+hErG7Zd1gQL/xCBfkCammLTjUUloI858+wRaSrj8R8rjBq3xVNmXdFMVB61yvjssLxDPT9adobzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1d4SQHgPR5iesoxAWNLOALX9LJkcsz3q6KH708jNArZFrTMop
	kAO7Y+rgbOBqVu5lGBF/HuAd+026PbnDiRWNOz2urVLh9XWWbhCkWyDmMHW/hmUBvt5ZUKpLso4
	SGxnQydIUefZQTQJpYI9QvNW5Ukt6SitPMJCLQ6XlwFeDhp7p436i8xzGgu9GCbrf0nXEVWkKvW
	3TW1Dm7wTq720JcB4wx42qTo8uytSupEuphfcR3/sVwA3cIGZv+FkXOyymQ6rpZnwylPmJFpJEV
	AF1HO7e5uTUQ/MeZw==
X-Gm-Gg: AZFdTZeyhirTnXr6M6DDM1mTiFTygOYEdunjYXDtPhPV5x3vp4Y576jLDY41w102GNB
	UBFO+iMgwjUfJs992SCpHG4ACcbYtGCLsURgvLejHLNCCj140Yz+IgBLmVm1170PJb76OS3Wd3T
	vvn9k24Ol1p3mTbdsMhWXP3RyB7EZ9KPcU0THvZZFRxgbGrEWo/Zle84HhiVtv0sx/FYfpYfbrR
	AH70RSJtzUAbyau9QxF6oKgaMcSgy1xqLibEDoKEc6v1KR4ulTbxNiP4HZI6VfgH2p3vj+xZz+R
	MmgAC3K3LVLNFHCcOV/EyIepmBovkxpgxxogCPbVcGxvJbG7BdekhX7SQoXM1KVj8uTJMSDdhR4
	vRW4XTyAVWmDT81yxnTBYxk99Yv/SZdmo/ihepfLqbu88cZ3EyXHslIUuHU4X9AgPq0DhkVgcXD
	cycbOaJka3S9jK5ghaoiMg9xzmVsS8bNSF5E2W3G4=
X-Received: by 2002:a17:90b:4c8b:b0:3b3:b71b:b01e with SMTP id 98e67ed59e1d1-3b3b71bbb1amr1688127a91.64.1794924299325;
        Tue, 17 Nov 2026 06:04:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abf029a5sm2010092a91.5.2026.11.17.06.04.58
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 06:04:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf8ea208bso36821855ad.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794924297; x=1795529097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+yBsenDI2wUPc8JhBFdOyO8USU1Y1cTrtOmqBqpCOY=;
        b=AWTwNaXEjfwUkOqo6D6SHwLlHauaazz2eT1ha/I5TBu4UF6akWIqgHCSnoNAyNdYSc
         fx0MhOKJXiyIwYesfBBVEP/PPcmPt0n6Q72Ipt+K+fOJ1IW5OBdt3vNkfusemvZC+JTi
         gAUrb7o27vgblNcK0vByA6wJ6TtNZdZNi1zL0=
X-Forwarded-Encrypted: i=1; AL+hErHqJSUSsX0atFfX6w64l/+B0QF/tFO8350D7OO/I2LLWHsLllW7+YHZlaHHf7cwHeKHOG/XAiw=@vger.kernel.org
X-Received: by 2002:a17:903:22ce:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2ee0dcdaa1emr123675045ad.72.1794924297121;
        Tue, 17 Nov 2026 06:04:57 -0800 (PST)
X-Received: by 2002:a17:903:22ce:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2ee0dcdaa1emr123674805ad.72.1794924296646;
        Tue, 17 Nov 2026 06:04:56 -0800 (PST)
Received: from [10.176.3.187] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76db218sm16492325ad.3.2026.11.17.06.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 06:04:55 -0800 (PST)
Message-ID: <b4ef6564-0e96-43b3-8784-57543ccf8ce7@broadcom.com>
Date: Tue, 17 Nov 2026 15:04:52 +0100
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
Subject: Re: [PATCH wireless 1/2] wifi: brcmfmac: zero-pad SDIO write to
 4-byte boundary
To: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 fariyaf@gmail.com, linville@tuxdriver.com, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>,
 stable@vger.kernel.org
References: <20261102122311.181075-1-tristmd@gmail.com>
 <20261102122311.181075-2-tristmd@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20261102122311.181075-2-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 02/11/2026 13:23, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> brcmf_sdiod_skbuff_write() rounds skb->len up to the next 4-byte
> boundary and passes the larger size to sdio_memcpy_toio().  The 1-3
> extra bytes come from heap memory past skb->data, leaking stale kernel
> data to the wireless device.
> 
> Zero-fill the padding before the SDIO write.
> 
> Fixes: 8f13c87ccc49 ("brcmfmac: Split brcmf_sdiod_buffrw function up.")
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 3 +++
>   1 file changed, 3 insertions(+)
