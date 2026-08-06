Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E246D0B5;
	Thu,  6 Aug 2026 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016960; cv=none; b=j886KSTrulHkx6IR6AutvVVDenSyRm6lEaPfHJdNg7TZYvh/3Pzyls9oTgivZSIoDgbiD5YHLirQRGQOjW7prNTUagtw69UWaTWqKQvA5ryw8WwQARclxnPwjvx6tpgsNU15S0BbUdgrc8fb07IQvf9x97VLz+smFx6lGVpO80w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016960; c=relaxed/simple;
	bh=wUd6BTz910GINwkFJ3oxFnudhEev1Ed6wapoS493qi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ms/UcNMfFQj2/GIZVrLGq6VAXTVcRvjRrMRUlRr/Qp5ZMzjvVzrpYbfgZ1wGdSPDVNS4YhPp6nJMOuhV0Pea9O5dvs79okMO6tIhBVyYkcWubSgRqDYGXdk9YIuuxcGF7hImEQ5BFEcRkVQ2eQfgNQJlrGp7qToLR4PtZsM415A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=HPOQ2qS4; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="HPOQ2qS4"
Received: from [10.13.80.162] (unknown [176.101.149.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id DB5DA5340316;
	Thu, 06 Aug 2026 13:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786016949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/s3rnEvEi/wr4ErGlkJ4G8TE/5xsRmeGjRMpGNrPM6s=;
	b=HPOQ2qS4tGHpMgL/fTwnEaea3KkRxWEnFwBh3/BGjpBGUi9zdkyGcQ/BGa6bd9cyAtm7i2
	DbIYy2/B/wMoYO6y6Y/g6lg+N14jZ+aqO97FyG+aSDGwwg0RRiwetEdUYud2mHzS/Y7iDL
	5vDIq5SNL/Wt9IiP0QU9VQuO3ae2kjw=
Message-ID: <dd2f19ac-a65e-4e53-aa2f-6f76c949366e@ixit.cz>
Date: Thu, 6 Aug 2026 13:49:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rk3399-pinephone-pro: DW9714
 coil requires higher voltage
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Olivier Benjamin <olivier.benjamin@bootlin.com>,
 Manuel Traut <manut@mecka.net>, Alexander Warnecke
 <awarnecke002@hotmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 phone-devel@vger.kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
References: <20260801-pp-pro-camera-v1-0-7b4d90788f9f@ixit.cz>
 <20260801-pp-pro-camera-v1-2-7b4d90788f9f@ixit.cz>
 <2j7ogeqj565sftp5wzqvtzi2id76fof623bifbmyu6ckhf6vm6@ya7h4tp5i4qf>
 <7d55eaba-967c-4de6-8021-6b2d17670b1f@ixit.cz>
 <galrq4ug3hhny2ivpylqwuztwv7vnqvm6sdhlu6pucxk6qy2mz@zxw4ckkxj2sh>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <galrq4ug3hhny2ivpylqwuztwv7vnqvm6sdhlu6pucxk6qy2mz@zxw4ckkxj2sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/08/2026 13:19, Ondřej Jirman wrote:
> Hi,
> 
> On Tue, Aug 04, 2026 at 11:12:21AM +0200, David Heidelberg wrote:
>> On 04/08/2026 09:39, Ondřej Jirman wrote:
>>> Hi,
>>>
>>> On Sat, Aug 01, 2026 at 02:35:21AM +0200, David Heidelberg via B4 Relay wrote:
>>>> From: David Heidelberg <david@ixit.cz>
>>>>
>>>> By datasheet the VDD (in-kernel named vcc) range is between 2.3 to 4.3 V.
>>>> Usually it's around 2.8 V. Here it matches the avdd2v8_dvp.
>>>>
>>>> Fixes: 9336eb829a18 ("arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera on PinePhone Pro")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>> ---
>>>>    arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> index d46cdfe3f7849..bde35d9b2263e 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>>>> @@ -473,17 +473,17 @@ wcam_out: endpoint {
>>>>    			};
>>>>    		};
>>>>    	};
>>>>    	wcam_lens: camera-lens@c {
>>>>    		compatible = "dongwoon,dw9714";
>>>>    		reg = <0x0c>;
>>>>    		/* Same I2c bus as both cameras, depends on vcca1v8_codec for power. */
>>>> -		vcc-supply = <&vcc1v8_dvp>;
>>>> +		vcc-supply = <&avdd2v8_dvp>;
>>>
>>> This does not match reality, schematic says it's VCC2V8_DVP:
>>>
>>> 	https://xff.cz/dl/tmp/6253a0465329df41.png
>>
>> Ahoj,
>>
>> thanks for spotting this, since I know you have the device, would be too
>> much to ask you to send standalone fix for PP Pro?
>>
>> I would drop the change from the series.
> 
> Ok. Just for the reference, vcc1v8_dvp here feeds an enable pin for VCC2V8_DVP
> LDO regulator (which is supplied from VCC3V3_SYS and not described in DT, yet).
> So in practice enabling vcc1v8_dvp enables both VCC2V8_DVP and AVDD2V8_DVP and
> while DT does not describe the HW in detail, it describes the only regulator
> that is actually controllable and enables all needed power rails for the camera
> modules all by itself in proper order/timing.
> 
> Not sure what's the DT maintainers idea here about whether DT has to describe
> every detail of power rails routing, or just what's pragmatic.

My perception is that DT syntax should describe everything, except passive 
components.

No additional GPIO is needed to enable VCC and AVDD?

Here, it seems to me that explanation like this in DT could cover it. But I'm no 
authority here :)

David

> 
> Best regards,
> 	o.j.
> 
>> David
>>
>> P.S. I noticed I didn't mark this series RFC. Too late.
>>
>>>
>>> regards,
>>> 	o.
>>>
>>>>    	};
>>>>    	ucam: camera@36 {
>>>>    		compatible = "ovti,ov8858";
>>>>    		reg = <0x36>;
>>>>    		clocks = <&cru SCLK_CIF_OUT>; /* MIPI_MCLK1, derived from CIF_CLK0 */
>>>>    		clock-names = "xvclk";
>>>>    		dovdd-supply = <&vcc1v8_dvp>;
>>>>
>>>> -- 
>>>> 2.53.0
>>>>
>>>>
>>
>> -- 
>> David Heidelberg
>>

-- 
David Heidelberg

