Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAE42F709;
	Mon, 21 Sep 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989085; cv=none; b=itIPDjksUHf+xcxfrRCxs5YOepeNzM2LHJ/8OFjdf+f5MrouDEyenG/UQbWzNShnGrdR2MhI1wJ6y6jH/LMyoMIJVzyp3ipCApgtQmGiEP2jPXwBU5pmaebUxI3Du2eHDoNXPPyR/XWL3/UMSmRTqtdec9OjGqwW4/oUyaUfEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989085; c=relaxed/simple;
	bh=KVmw4/iCMEr46CN6E/02QkIGZ5qIw/ifaBePmcgBqkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC0nHy9uGmaoLhqwYXlELYAB1NNHeMVz5FpRBGffWfcaSrn3rW/Icyyb8h/xeY3bEQ9qv8r71XK/rWNbLbZkXCxxFymgem8pzjDbY5xqAV1KuhMDaQfYL81e6yxIbatbN9iUNz8o8gC35m5lwW3GhB/NTyBLSWlgQ7v0tsPb+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=IuzV5ABl; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="IuzV5ABl"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 4704753406D6;
	Mon, 21 Sep 2026 13:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1789989079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IecxrbI1Oxnp6UQdEsBFcFLuXx/aPYWQ+14ndTQaXH8=;
	b=IuzV5ABlF2Hqnl2UjIxaHjpRF7887QNhwI1nyJit5VuxSJkEEU5y+SwAiglo02WsfREJd6
	yOezSg/vXNFecdwryc1fl0z89Ge8pplzks8FFj9ntdMkygeeko5gm5/e5+1usvVvyUsq2t
	ysSEn8nmOgPKXlxwPqEbAkdySsg5xdM=
Message-ID: <426b6aeb-578f-43ee-865d-30e69b7bb2f2@ixit.cz>
Date: Mon, 21 Sep 2026 13:11:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Lee Jones
 <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 stable@vger.kernel.org
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
 <22355625-a2ea-4b6e-99b3-65cf93ac8034@oss.qualcomm.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <22355625-a2ea-4b6e-99b3-65cf93ac8034@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 13:08, Konrad Dybcio wrote:
> On 9/21/26 12:46 PM, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
>> which is what the pm8941-wled driver wrote to:
>>
>> 	rc = regmap_bulk_write(wled->regmap,
>> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
>> 			v, 2);
>>
>> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
>> defined as 0x40 + n, so the two byte writes for consecutive strings
>> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
>> with the default three strings only string 1 ends up with the requested
>> value.
>>
>> Use the 2 byte stride.
>>
>> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/video/backlight/qcom-wled.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
>> index 2281007bdd459..f452d328997ad 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -54,17 +54,17 @@
>>   #define WLED3_SINK_REG_SYNC				0x47
>>   #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>>   
>>   #define WLED3_SINK_REG_CURR_SINK			0x4f
>>   #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>>   #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>>   
>>   /* WLED3 specific per-'string' registers below */
>> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
>> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x2))
> 
> Ideally n would be wrapped in its own parentheses (doesn't
> checkpatch warn against that?)

Yeah it does, thou not sure it make sense here.
If needed, I'll send another version with it... :)

Thanks
David

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

