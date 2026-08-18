Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E29364950;
	Tue, 18 Aug 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071804; cv=none; b=KR/yfo0uyjjFo+nOsAt7sOq5oK/egx0V2DePe0212bgCF3uS03dQolhsN3Eubg7FDLclbjyw4DGEPgJtldZlE8abib5eK0sGhc03WWW9LmxQYFR5tRr2Syocbhc1Px/KePrwsdMXRiduaSrKme/5ZNE22+5aZq1D+I/gGzvo2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071804; c=relaxed/simple;
	bh=DNpXBkZtFA2Kjio20xvnieJz/fjDqKwPqGsBbvrxwqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBVWI+HvgOrimhWS2GgoSBOnvDYivOU/cwPYCRKTUM3Ey1DdtufGARIjomb8Mn5pfp+CUbGppVlQFeGBFikArgH36rY4S+1FZh/x4qyWbLEyodT38SJ7w393tL56WNrm91z2ix29LDx4U+upb0a9WJg9WiptaNBIWvVV7eOj/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=l7uCTaPt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="l7uCTaPt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787071794; x=1787676594; i=deller@gmx.de;
	bh=LqEoVAQSB8SfO7zVu+8pARogxFbcMp2CXli/mDMlnmY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l7uCTaPtet8puZmSgyCTSSIoexiOAhyCUASE30gLgNNuR271Ph2Tc5dB2/T0iUUU
	 H6XeWvN/tI2njcwlsc85UatxUmHFFZSGVmUp6cPgAfMVd1lRKu7JqoGaMNu4P30yd
	 8D9wxp812Ai67aa+Ux36MuXGZZ27P6qarJrggX4j8y3/jgMPakLvQOtQFKhNfMozO
	 UgKVyWMgV2Mf/VN48XXrPwHs+pf0rxFy5XJKwDJWLiux9Wc7QAqqJMsBMeKEnMopw
	 K08EsDD7+B0ngzPpsOXqKLb+zrvPQAKqiJpNQYdt2OQiKflAr1dF1jCNF2WHm2oEA
	 mUeu7BNARoH8UOWtOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1xU22a0rqE-00QlVR; Tue, 18
 Aug 2026 18:49:54 +0200
Message-ID: <27cdcd5f-7cbc-4e22-8ac3-81d427c68f1d@gmx.de>
Date: Tue, 18 Aug 2026 18:49:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: omapfb: panel-dsi-cm: initialize lock before
 registering display
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Dave Airlie
 <airlied@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260818135318.1957283-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260818135318.1957283-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ra3s7RSaoMTOth51JcKMBzR8n9NwN4Is5sDceLU62RYrgA4U+XE
 Ud0lfKJ8jzR4f39IsPRsxpsUYq4V/5tCd2YQNj9hMChabUx76uJLCqmZbZKhv8Nyc+j97vi
 9Iv+2ghOCGJRV0OrL54c7bhf7r7VrvTS8aOL+46BUGcBwc+eU7/FiNHmq4fHziGQjtTwGxW
 HimbGm7vAn+DCFsIVN7Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QuzhfZfuXtI=;wQn8KojJ3tTUoBUtpT1CLdsJFKC
 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

On 8/18/26 15:53, Runyu Xiao wrote:
> dsicm_probe() registers the display before initializing ddata->lock.
> Once omapdss_register_display() publishes the display, another consumer
> can reach a dsicm callback that takes this mutex while it is still
> uninitialized.
>=20
> Initialize the mutex before registering the display so the published
> callbacks always see a valid lock.
>=20
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
applied.

Thanks!
Helge
