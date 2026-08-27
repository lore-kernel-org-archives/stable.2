Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAE349CD2;
	Thu, 27 Aug 2026 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866370; cv=none; b=QKiOv9eMUefLjXnnU/mM4bCe6geeg01ocsg7h9rPClta8+WqCEpzP6QjwsGMYqGBq3wEk9V3VVJkwUV6ZMZQgqJR9JrwHGuZwrK6Ajx02OXd9UOyfVNPZWG4KU+hUJ2NlthQuO3hu0nfY5UIbM8g8kt+M0g+glee27djCe7ZxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866370; c=relaxed/simple;
	bh=Nr0Cy+uBT0Flm2v7WVmkxQoA9wjhO9C0Wl0ja0+g8yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA/5jfYwUxJ8jbOCJfopQShVCzzC+0UBbLO1FxoTx+2pRaxeMhmBt2H/kQXtYDVqh5seyGLfiL60T1cWO2Mezhd1FDnF3nZTxCk92aOo2kdmCgAtcnWouqw5L1RF6IQASUX4QNX3VA3Ybn74rq8bnczDefn9yFq0wL6ue846BkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edygtnii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edygtnii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ACC1F000E9;
	Thu, 27 Aug 2026 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787866368;
	bh=LkJBPyUwA+hyO/JesG4AiAf3V7aNlVVXoW+RmWZs2F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=edygtnii9K6HXbSrjcTddfpEsrJ3lPRpekgDoU9c+ejrv97vEuWw7hayd6mX76tse
	 RpsRg76wTwrW04lUOZ+4xjGfSXEJRWsNvttoa1AGgmgIHtbRkhxuwwjNABf2fVOeU2
	 ORI9eBfeEDmAxX3CF24bt3lnEpidjRD1wbuYOGjwn0/N7DWCY/VsAHoDcBJvTRr14p
	 LEiBb4OgbOtb3p/Kjg3+v/h3yxq1NRXnYgU28jWWgzIjMoSDAUyVLCB8VqDPAfYNo9
	 K4sY0ejVdaNvY+nnRuurlKdNDejPCqmFSvVGP+v9WYCQg9+7W4+Cw6Sn7gYpsGfTnI
	 60UomytggBGeA==
Message-ID: <164b4f99-a642-4c88-8ff9-78930264d093@kernel.org>
Date: Thu, 27 Aug 2026 23:32:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] wifi: mwifiex: add dt flag to avoid conflict with
 platform reg domain
To: George Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch,
 krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com,
 kees@kernel.org, miriam.rachel.korenblit@intel.com, rongqianfeng@vivo.com,
 wenst@chromium.org, rafael.beims@toradex.com, avraham.stern@intel.com,
 error27@gmail.com, s.kerkmann@pengutronix.de, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com,
 peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260827130335.6606-1-gvalkov@gmail.com>
 <20260827130335.6606-2-gvalkov@gmail.com>
 <fbde1932-5433-48e8-b352-bf27eb545149@kernel.org>
 <CADOrJmY5jZvn8zEu-jCntGChXSY9wRd3bsOy1GB0EWNTY9GK6Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CADOrJmY5jZvn8zEu-jCntGChXSY9wRd3bsOy1GB0EWNTY9GK6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 19:27, George Valkov wrote:
> On Thu, 27 Aug 2026 at 18:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
>>> [2] https://github.com/openwrt/openwrt/issues/9956
>>>
>>> Tested-on: WRT3200ACM, OpenWrt
>>
>> OK, so this comment from v6 was not about binding, but this is still
>> wrong - there is no such tag. Just make it a standard sentence.
>>
>> Do not introduce OpenWRT rules in to the upstream kernel.
> 
> Dropped the invalid tag. I hope this is suitable:
> The change has been tested on OpenWrt and fixes the issue where
> phy0 does not start on WRT3200ACM-EU when a DFS channel is used
> 

Thanks.

Best regards,
Krzysztof
