Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C883AB5CA;
	Thu,  8 Oct 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477850; cv=none; b=JOllmRSFnx1YVAixeIcOC1rrRVsgMxdCbjAXMbRMYUQpxMUeEP4ajE4+un7l7je7wkNXO1Vki0fqlS3edFKE8/++yKgsbUxCKIxzw1yVcE4g3KF9uND4ELuxzzhz9+bBoWbYHdoq9MMCudnUvSo0gsVCbmp/7PqnPiDXKo9NexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477850; c=relaxed/simple;
	bh=ESx8K4nMao66mXKghRpoR7K1c42GN0u+Ur3E4TYamVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiJu8P9uy+H+CumWZoimQT4HDvSV1OtF4LS1mcqTzTpdzQldMYRi57Up89gRRf3jJa/rZRBqKSbIv1Aw9JWh0Dl9hvxYzOMcxC/2W9G+62WIrtslg0l9jhowlpKsw8+V0OvQYnnd5+8QUUjKyNvebA4yM6sbyE0ExC3Kj1zeyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LG06Xrap; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LG06Xrap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791477842; x=1792082642; i=wahrenst@gmx.net;
	bh=xyLvFSdbdC1sZATNCFcqQ2a+T87fF6S/GAPqr0ePeps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LG06Xrap7Qu5Bt6KXqd9U8tS+fKIvzmQDkd5jmfk0u7iMpwbIX5uik1Z68Dy43UL
	 GL+41fF/IE0Wv9SaPbhctLg2uDCu9hEgiPY4UwJOPnU0Y68y9MBRrFQaczrvJieqd
	 QmQH4C5jA6u86+ZxMB7tix567DyMyciVrA1MrxFJXZR0tanaQW2QHA8En8t3PZt3m
	 q8WseViWwzcOzK++JpWyNa8odU1UtWU8TfWYJo2cZY4g2dNf8K8cABs7TdeIQvs8k
	 uV4eMCuIw4pW2Q5DCPMVMptpBpg4v2iVO8HaNYa/6oeQlpBudbyxCS7+Q1BOKM9V7
	 54YwfCB/N4k5vLIFig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1wrg5m1FlU-00g8Nl; Thu, 08
 Oct 2026 18:44:02 +0200
Message-ID: <6f33d098-3224-431b-abd1-bd01f01ccfca@gmx.net>
Date: Thu, 8 Oct 2026 18:43:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] usb: dwc2: fix low power issues found on stm32mp1
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Amelie Delaunay <amelie.delaunay@st.com>,
 Fabrice Gasnier <fabrice.gasnier@st.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>, stable@vger.kernel.org
References: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OjQYLJZbn8g4FudN67gENcLVXS+lm5ug+pu/9TORaABAyK/Rmpi
 uOnX8xjdJ54bPLLbupiqE9bO2fpDAWvGyQCFjYj0QgP4lnKrtJuPK+HZTPKfYh3b4ITfizU
 t7B9JYuCJ0X8xfN6Z797OynyREgBD93FiAgHz1IPhM1HfAITbblZRTiiBWc9byeqimlXdv4
 OOMIXbQqHZ5+zro/hlAgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NtrJkWyAjhA=;yZ70fhCWiiknbDRPTGLxLGAfbFP
 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
 =

Hi Fabrice,

[add Thinh to CC]

Am 08.10.26 um 15:33 schrieb Fabrice Gasnier:
> This series addresses several hang, bad_irq or re-initialisation issues
> found on stm32mp1 when going to system low power (stop mode):
> - First two fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
>    and EVAL boards.
> - Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
>    an external Vbus regulator and stm32 dedicated detection logic.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Minas isn't DWC2 maintainer anymore:
https://lore.kernel.org/linux-usb/c2a97d0eafcbaa9509edce5b7b2648d6f9d80863=
.1790993820.git.Thinh.Nguyen@synopsys.com/=20

> ---
> Fabrice Gasnier (5):
>        usb: dwc2: fix recovery after PM domain off
>        usb: dwc2: fix a possible interrupt storm on stm32mp1
>        usb: dwc2: hcd: fix possible successive vbus supply enables
>        usb: dwc2: hcd: don't disable/enable external vbus by system susp=
end/resume
>        usb: dwc2: platform: fix stm32mp15 detection logic power manageme=
nt
>
>   drivers/usb/dwc2/core.c      |   1 -
>   drivers/usb/dwc2/core.h      |   2 -
>   drivers/usb/dwc2/core_intr.c |   6 +-
>   drivers/usb/dwc2/hcd.c       |  11 +--
>   drivers/usb/dwc2/platform.c  | 222 +++++++++++++++++++++--------------=
=2D-------
>   5 files changed, 118 insertions(+), 124 deletions(-)
> ---
> base-commit: 1a5dad490a3f8533ae955be59ac5d26a3dfb6166
> change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252
>
> Best regards,
> --
> Fabrice Gasnier <fabrice.gasnier@foss.st.com>

