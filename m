Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9B1A0728;
	Sat, 18 Jul 2026 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400048; cv=none; b=KVhVoxztrNcEF6xBWqcSTG7n3jgVqNa7Lv0Kr1qe8dn5LLXfaW9VbnK1XqAqYa4fPtndqQ1V1hnAEuCOVtQyQID8eQM0xCj87X/TQ2+3Mq36G+Y+VBDtIr9GtsYwVs5gTbUUXeT0ZCBLf5E5qxNxcJJwuo27HAyHFdI5yDjiK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400048; c=relaxed/simple;
	bh=pJ7LmPmrA/7Z9bqN5zoZcT8a9R1/gBeyIy858WZOfd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxetdmYx+xA1x0DzB+eWRUtHBniwn9rIn5rbqrabYAe5xF7Y2gA94jP4PVFGD4xiQPgujVWwx/0STQbYL9ZOkgL2ocbE14MmmTccAo6iv1IiHpRuXIRmvMbtUHBku+WsUVoQKha18AOwNcCtKITyJKs2vzLpnK0Fyb0rDDO0GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ZI2v1RF3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ZI2v1RF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784400035; x=1785004835; i=deller@gmx.de;
	bh=njst4iED7ogRViMF2twEXEb69Zq1L5XYxVfXqSNYx+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZI2v1RF3gPoWjohOlMKutEQwJmE3mtiVbusBiySL/Q/LukW7WvAAuMNELwG3kouV
	 NNWM9WcASfv3Pw+06KORgvRS5PMD+GUG/e1SrPeJ88L8xcy312THCgCEUacfsTsRb
	 ElpSkr7U+H0G77Pfa0L/lAZEwJ5Azu1WHB/yENyEI9o9jXK4CXd7aGPYuz9BMdSfy
	 6utFAyXUX2kyeIkCT2EtpeH/oGAisoMD36zaWdcz7rIX+MnxpZruaqklc+aNJwnq4
	 uXm130Cz/eyWnvY2hKDgbh5jA/LprINZXPVEAoZ2yHeYu4j7SKr2qnI4syMaAUVhc
	 mhbeAvwl8p4Xx6/BcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1x7pkE1LVd-0108M3; Sat, 18
 Jul 2026 20:40:35 +0200
Message-ID: <3db47084-7327-4efc-b9e3-1103feccf077@gmx.de>
Date: Sat, 18 Jul 2026 20:40:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: uvesafb: unregister connector callback on init
 failure
To: Myeonghun Pak <mhun512@gmail.com>, Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260701111224.48646-1-mhun512@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260701111224.48646-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BO7kazxDAo58+8Qm7/9lpjvv6T3DIMQWsa9SJnXueMXfEvvZkvJ
 zsdtvY3UcjV/z3Qfp4HhOjtT4h++FrWX41JhkToWQpMqZCnU/t+eJ0hX4ykZo88gFKOkzDQ
 74MfZPYkhGOMEHZVq+2d/TpFA73YBzhd4wDAXZkY9x+fU8ObxcIeJ6AV+v25DLDijnEywKK
 KC+dRsPXRb73Yz2+b7a2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gShvXsoSu0E=;rU7zfFAeeJH/y5T17dBZN0qAn0d
 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

On 7/1/26 13:12, Myeonghun Pak wrote:
> uvesafb_init() registers the v86d connector callback before registering
> the platform driver. If platform_driver_register() fails, the function
> returns the error directly and leaves the connector callback registered.
>=20
> The later platform-device failure path already unregisters the callback.
> Add the same cleanup before the final return when platform-driver
> registration fails.
>=20
> This issue was identified during our ongoing static-analysis research wh=
ile
> reviewing kernel code.
>=20
> Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/video/fbdev/uvesafb.c | 2 ++
>   1 file changed, 2 insertions(+)
applied.

Thanks!
Helge
