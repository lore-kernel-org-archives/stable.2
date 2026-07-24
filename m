Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2633D4E8;
	Fri, 24 Jul 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899792; cv=none; b=BDKnRM5IlALjvbAVCFWWfyQgqqPKGVt2zYqMWvg6P1cazPjWc1otPLda5DiCet83g/HzuiUvcAYFx5JjXWe1wVqEjcN9c58qxfXiukksw8/umvoPEQ9I50KrLepl62STsZgWjOfNwbEDXs3nUOc8YAxAlAjDYRYo/C9/S6zzWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899792; c=relaxed/simple;
	bh=OCJ5QJpFX+/c47h/UFE3+oYD1nX5lByuRL1l3DGr4ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5DY7ZuvCIAIIRNUmv5v83SKhNxWEwvBEzZ4WhQThOPU5joI1+EotI0e3H7wBWeUx2Zm5TBaMI9d9bvJN+mCdAa7qyjWQjdBN+LWiViLBVoZOGWDA9HYPY6ym/TZux4rjHywPPQB6bBFyncp4JK6e07nQfL3JYd3etKwoC+z3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=dOHC6zQS; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="dOHC6zQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1784899761; x=1785504561;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=OCJ5QJpFX+/c47h/UFE3+oYD1nX5lByuRL1l3DGr4ck=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dOHC6zQSkeuAOPK2kByHb+WIyTkf5mVh82MCV6tPEi11OQDB30qfkzmXHV14XC5r
	 TBhgjpvJPDf7PKvtEQKUa7QDT7diXDglTG7+Z2m3fUNb6UKFBa3S7/ulBVg31uOhI
	 YQIbuvXa3PSDaevw/yoSn97YEWIxrNnOvW4EHceARGA2EGmP2XObtIx9NgVf47YTF
	 Id9nRFn/8oD1zmGemt93Uq1ds7aSej6W5EAKU2e6jREnz6Ve//N72lAon12cOCEc0
	 aascGryUVEa7vCQRip0clAWVmb8gw60VI4aGz1FqAambQjjQziuSXCMQFNIXGjAMc
	 Sb2niX7K7v2d/bQo6Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M3lLh-1wmR180QEt-007yID; Fri, 24
 Jul 2026 15:29:21 +0200
Message-ID: <1dbfb670-202b-48e9-8bad-185bf2c395b8@oldschoolsolutions.biz>
Date: Fri, 24 Jul 2026 15:29:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <rmckncb6oimniwd6venptbzaidxh4v6ffhbkebztqcuxg67ixy@u3bi5tclfon7>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <rmckncb6oimniwd6venptbzaidxh4v6ffhbkebztqcuxg67ixy@u3bi5tclfon7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ybLy0eRt+/YFF09Ll6hqlkouUS7uVkT7sQ4hQ59ukuEGO1WLX9
 BkLryKfezYSFxPZSTPu2t1/ehHET4bskv7Fv1VAYkDKe9RER/hRcLlBiA7plnrkoRsV76Hd
 jhkF/WMr7+vbnrk/q7uTDbJ9841YSJZPjv3zLQBO6U+kJhVkWz2A5uH+06P+yGEtcMHpnS3
 6XKlysaVEPMwqreuWP5WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7WiYxy4H1SM=;B2pfNGTc2Ac8YWHNdjhjM7d5Phv
 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
 =

Hi,

On 7/21/26 19:56, Dmitry Baryshkov wrote:
> Just for my understanding, here you mean a Type-C cable with all 4 lanes
> and the SBU lines?

Yes. I used the type-c cables from my portable USB-C display, which does=
=20
4k@60.

with best regards

Jens


