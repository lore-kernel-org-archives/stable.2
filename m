Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2B345EA5;
	Wed, 22 Jul 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740755; cv=none; b=bj39y1vMptGp5VYYdw9cD9J5vsKv7OI5V2YDaSiV9AVAjmSiywl65WhdkVytamNrwYp+39aaaCC64RZTgongSZdMSXELG90czXy7NZOsnOlNLnFJfXG/04UBXRe6aMItBzFmp1LcUQ0Lw5yTH+KoLejmkR81+3JGiOf3TzGAgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740755; c=relaxed/simple;
	bh=tTR96qwEtTOKe1tZUq9pLn6ST1x1EO7ALiL3ium/JAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StwpotzOvtnRIxCBAO/vwCNdCzuEbGqSybPe12T9roSGCITptYb880eWQfe1Uk+U7+aBsU0bBMcBxLXg0fnQaeCeqTNGofAU0RrVLtgdUbUYlGg06BxSNbsYCb4D9iSV9M3nC3pmG9ssI+W6EmsxppG0HOQybc26JmI5zoTZm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=SY2LVr9t; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="SY2LVr9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1784740736; x=1785345536;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=tTR96qwEtTOKe1tZUq9pLn6ST1x1EO7ALiL3ium/JAE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SY2LVr9tzHsLzOY0YrSrHeOjOQEscoUxdSB3G7BvW8LmtArH7HHNNRT6/NkdTZgg
	 jZjYL+Byr8CGBaBLSa+RohQdWiWoH9Qnpnp7asq/dBJhMHydxZhRzUSURrZbKYQZh
	 Kpesx4bMpmzx2OuNlDnH9NKdMawcjsnAzFShSYOHrJwswkJ7bWLrmS9kAgbX585ut
	 MRRV6gEpHyfocr/bSgblkX9XSZeSSnpx1cXuuDEK6EcsVugbrEgoX+jr98JmFmndt
	 K5qUtXodAH61s1GVG0FQTJdkEc9DRiIRIo0a0wZM8e/Sq8sqrdWX86y1kdv6ARX6F
	 1S48r9BP9B9nNoX16A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M89TB-1wrnGN0307-00E4vu; Wed, 22
 Jul 2026 19:18:56 +0200
Message-ID: <47810646-3476-4f5b-b140-77b1934fd5b4@oldschoolsolutions.biz>
Date: Wed, 22 Jul 2026 19:18:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
To: Sebastian Reichel <sre@kernel.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus> <al-dJjzorP-I4Yff@gallifrey>
 <al_0LjwmfW-cECnY@venus>
 <41222b67-19e5-4f74-b4aa-928d05db9675@oldschoolsolutions.biz>
 <amDi7e8fqqzCRlAc@venus>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <amDi7e8fqqzCRlAc@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xfEtTt+C/P2m1drKcHEpRCiA7AFvkY0/eDi7kazHKEFCwBVpaF+
 QZupGkShPjbJkgXf/xQy1Ni3I0rhwBYLes8ZRTBo5ugEhtd9qV8n0Rpj4nUIAL8vRWLxXkP
 8az460jKbOqyI0/vjuPppEn0IEgoyAKa2/1qfMC7RQevcRoTn+h8A4vWwRpyOxM+hU1kZ2U
 0tfFGX/Yt2s6dk28bsPLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Es8H9HEck34=;mfoNmjz+7jqSwXIkMfFHI//VSYt
 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
 =

Hi Sebastian,

On 7/22/26 18:03, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Jul 22, 2026 at 10:38:34AM +0200, Jens Glathe wrote:
>> I understand, however I wouldn't want to nerf ps883x for the Hamoa
>> platform until the USB4 stack is complete. The issues you
>> currently run into is:
> That's exactly what this series is doing and not really a problem
> considering USB4 is not working anyways.

...yet :) Alright, nerf patch it is. Question is how broad we need to=20
specify. You have ps883x on all x1 (Hamoa and Purwa, like, Zenbook A14,=20
IdeaCentre Mini X, HP Omnibook X14 fe1). So probably those compatibles:=20
qcom,x1e80100, qcom,x1p42100, qcom,hamoa, qcom,purwa. Looks like a=20
nerfing table :)

I will do this in v2.

with best regards

Jens

