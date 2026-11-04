Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793801956;
	b=xl8ac4drzou9ANdZvtSlyT3RZeA5iF0H0YxY8aQuSNkZEsde2lty32kQ9AeiukrXfTNw
	 ulIIiws8X/OV1LQpOvm2VV4Hi01kNStPXwPLpdlCxZ6OcED+XJdIavVB7YGVsQuIPEt8H
	 Cy3v5a5jsLUNuL/F/FimA43z4+3IVIYpKb1j4+UsGW2e7FHuq0Dcqj7HT5KP2Jb9145wD
	 RcYMeO5wBsG7q9r+ES3dsbyvMBF7ruzYKKtk/QDrfVRSgExc2C8fDYUb/jI2sgosEtk5A
	 igtXC3wEKj/uQutD6y5uSIYcX5H9vun6AvujCh5/d9ddFfvL2pGa9Tp/8mrn/JhTYBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801956;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=q2BqXdx+EdHeRHslloG+Jxr0IRjuPUfBGuAn6TTKiaI=;
	b=5o6m4yUvRoPLPHuqi4hLPEYGWmE5aUc7c73YC9Vv9Xk+lHpd6ZI7VVKZWh4ji/+Y/EfI
	 zRhElWcd1DY7u2lbNYiFfFWHan7Hk4DwLkoQ5s34jbRLT2GS0Uc3yfSnQl79WJx35/MYN
	 wi7wO1XwrtPrMknSLOTYtWgAaM1vzS1dTQpw5xJdZFue2HxCrcbIeyQQlc90IUvdhq1NJ
	 66ISlW5x4Fr2Olbb5CiJrjecQ0tFh+nR8uoTpdIqDG336vyNnQUnDJLCJH8w9ZaOLTzMp
	 3g7KB7dDmvhjmP7eA1qEeS8Pb3UKkDB3wgW3zf1M7314sm5xpJBKc6Ur0SJCfN5qeFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=d5kQAnW4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96B606A31B;
	Wed,  4 Nov 2026 14:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC96B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=d5kQAnW4
ARC-Seal: i=1; a=rsa-sha256; t=1793801923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DBVfeNLfXabUNMkp7xC611fcDiXKusM2FO/lvSYIBEVfX5vEOlG99/wAEPA2nn1CmXMhxquDhJ/w5GiywA6nmhAZAQ9qR7kF6ZMUae4yoaMtdtjL/LGafcmjiO9taQ12h2QoIBl8gE01pgR0qC7/J9C60lBls5dFPBBjTHoReTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793801923; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q2BqXdx+EdHeRHslloG+Jxr0IRjuPUfBGuAn6TTKiaI=; 
	b=WxF7Md9n/6T9oMxYLFDsCmJnDW/IVHf1shql+aBVA+9q2NfoaI/L64IpgZYtqsbS4nQtM+ZrIZCIztHXGJb13T0oOh68+mJYaFG71d450cuEDwWUOjOtOyPApLWKQN5hcHlBesm+jTEPcMIJCXvZ8vOMh2TWSDVOzaxvNU8s+Mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256; b=d5kQAnW4pZPZT28S914Jp3/gQri6eNKfx76LfGqS26FI8NDKAKizKE03J94JN31BLLMGtJqpZ4NljQxcfbqngsOJCZWEN3Rorwv+kFPTrd3s+wdboiqeHH4x75d872lLsCLbIpGrxdV42MtiOzOwR2Nn548ghSLKKgX/gyLo3cw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=q2BqXdx+EdHeRHslloG+Jxr0IRjuPUfBGuAn6TTKiaI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793801921669437.63445022416045;
	Wed, 4 Nov 2026 06:18:41 -0800 (PST)
Message-ID: <17cb2a11-9c9d-43c9-889e-8581522c7a74@collabora.com>
Date: Wed, 4 Nov 2026 17:18:36 +0300
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
Subject: Re: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
 <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
 <5b3592b1-74b4-43e6-96e8-a600b6fa991c@pengutronix.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <5b3592b1-74b4-43e6-96e8-a600b6fa991c@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/16/26 14:06, Sascha Hauer wrote:
> Hi Dmitry,
> 
> On 2026-10-07 14:20, Dmitry Osipenko wrote:
>> On 10/5/26 16:28, Sascha Hauer wrote:
>>> @@ -2792,16 +2807,13 @@ static void hdmirx_remove(struct platform_device *pdev)
>>>   	hdmirx_disable_irq(dev);
>>>   
>>>   	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
>>> -	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
>>>   	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
>>>   
>>> -	/* touched by hdmirx_disable()->hdmirx_plugout() */
>>> -	hdmirx_dev->rgb_range = NULL;
>>> -	hdmirx_dev->content_type = NULL;
>>> -
>>>   	hdmirx_disable(dev);
>>>   
>>>   	reset_control_bulk_assert(HDMIRX_NUM_RST, hdmirx_dev->resets);
>>> +
>>> +	v4l2_device_put(&hdmirx_dev->v4l2_dev);
>>>   }
>>
>> This is uncommon v4l driver removal pattern, I suspect it's either not
>> correct or needs to be fixed in the core code.
> 
> The pattern looks uncommon because many drivers in the tree are affected
> by the same issue ;)
> 
> Just like many other drivers the hdmirx embeds a struct v4l2_device in
> its private data struct which is allocated with devm_*, thus freed
> during driver removal. With an opened file descriptor the video_device
> outlives the driver removal, and v4l2_release(), called on
> the last file descriptors close then references the already freed memory
> via vdev->v4l2_dev
> 
> This is a long standing problem. See [1] for example for an attempt to
> fix it in the core. It seems consencsus at that time was that it must be
> fixed in the drivers which is what this patch does for the hdmirx.
> 
> [1] https://lore.kernel.org/all/20240610100530.1107771-1-sakari.ailus@linux.intel.com/
> 
>>
>> What is the user-visible or sanitizer-visible problem? How to reproduce it?
> 
> It can be reproduced with Kasan on affected drivers, below on the hdmirx
> driver, but it should be reproducible like this on hantro and others as
> well.
> ...
Thanks, the patches are good to me (tested on 5b with no problems found) 
apart from this one that feels like it's not a proper solution.

Will be good to have input from the v4l core maintainers, or have this 
fix made separately from the series to not hold rest of the patches.

-- 
Best regards,
Dmitry
