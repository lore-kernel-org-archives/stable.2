Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688749D594;
	Fri, 18 Sep 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715547; cv=none; b=T7dCicBK0StFjPg367YCbdRrFGAcXMuG6a6VhlZ9JWzmPwzmhshYGyiOPNbFtkFAT0mTAQDeR5Ao92fl1stLgoJrlMSa4tnClF/aQfyK+cKD779c7ZTNTHbUrhBplKYapqnQjzvGEngJmhnZ5tTrCRskbxRPa9lOHqG/y+Fkcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715547; c=relaxed/simple;
	bh=qbeZlVy+5SBEKTSymSb/qxfJ9QW/jVvvGlezIyaiUGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a71w0FohgVvHAy6mGbsxlopdMrW275rENXpTlQwUHpUmpx6vPJvpABm/DH0XmvXJ6SY1BCznl9v4n4YqZd08EFIwk+wq6mg1QAuGlKCPsqBbPgdh9coCLxtFJB0elFoOY/1dXjQqdAfm1/bbZLg4D0MW8cYksAjPhGQtc8g87ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=gxOCxE8s; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="gxOCxE8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aBmuyDYC6BL0NuO22P/UKnyiVKMdfpL2R0mfPFPf/BQ=;
	b=gxOCxE8sPuNKysXsbS8wQRqJ9f+QjQpyHrOrdCDl8Ov3ZIhrUFtKok2X5Zxagr
	BeGM2ed0XtxHyPPWez4vSLRjhSSlfKeSJK+W1y4utwprJu87rWIRk4wopUndl/4Z
	PCUpZ7SAtAna82fL8jlCahXOqn1RahLRZPuHlGDJFE1jQ=
Message-ID: <6b00a649-8672-47c2-ab31-8b7d68ce1dcc@126.com>
Date: Fri, 18 Sep 2026 15:10:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: fix the invalid VID programmed by VLAN
 perfect filtering
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917122245.1338365-1-xiaolinkui@126.com>
 <b521308c-34b8-40dc-831a-757a163902d6@bootlin.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <b521308c-34b8-40dc-831a-757a163902d6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H6z146xqSl3ZBQ--.23835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyrJF15tF45Xw45Jw1rXrb_yoW8AFyxpa
	y3uFnakayqqr1fXFsFqF18X34jqw4fAr45KrZ8tFWUAw15C3saqFW8Ka95urW8ZF9Ygr1j
	ywsFy343GayvqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4Vb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRb70mqs4-Z0FQAA3Y

Hi Maxime,

On 2026/9/17 23:57, Maxime Chevallier wrote:
> Hi,
> 
> +Ovidiu
> 
> On 9/17/26 14:22, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> for_each_set_bit() leaves its iterator equal to the bitmap size once the
>> loop terminates, so the 'vid' read after the loop in stmmac_vlan_update()
>> is always VLAN_N_VID (4096) and never the last VLAN ID that was found.
>>
>> Cores that do not support VLAN hash filtering (dma_cap.vlhash == 0) fall
>> back to the single VID perfect match filter and hand that value straight
>> to the MAC. vlan_update_hash() therefore programs MAC_VLAN_Tag with
>> VID 4096, a value that can never match an incoming 802.1Q tag, so the
>> perfect filter ends up discarding all VLAN tagged traffic. Both
>> stmmac_test_vlanfilt_perfect() and stmmac_test_dvlanfilt_perfect() walk
>> this path and fail as a result.
>>
>> Remember the VID while iterating so that the last active VLAN ID is the
>> one passed to the perfect match filter. When hash filtering is available
>> 'hash' is non-zero as soon as at least one VID is active, so
>> vlan_update_hash() keeps ignoring 'pmatch' and nothing changes there.
>>
>> Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Thank you for proposing this fix, however this code is currently being removed :
> 
> https://lore.kernel.org/r/20260908164309.59282-1-ovidiu.panait.rb@renesas.com
> 
> So no need for this patch :)

Thanks for the heads-up. I'll drop this patch then.

Ovidiu, I'll keep an eye on your series. If the fallback path
still needs a valid VID after the removal, feel free to ping me.

Thanks,
Linkui
> 
> Maxime

