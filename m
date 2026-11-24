Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555918;
	b=qNI5N7jHUwDRueyzDSxW34E68IV/xnZHPiICPSWZVQQ/yF1uM8EpMp8RuIdFDrfSBWup
	 3CKnOCbw0xqxumk6KSmNit6gqnj6iFJqDy4AkQZY8aeten4OJg8zNFPk1BIGZhZpsT/l5
	 ZrR8M4TdL2JbTJi2q7O4bo8YlfOd2MyoySzr/SJZx9oSKQgRXma8ztMgWqD4OQyDGO3xE
	 ZWaFUhQUOUW3RLe15qXBfMTACCGg/0U4noCMegUjfRPapPYp6IUHpBXi7tDQ+xQ3OPzra
	 jxMvRAoMFWsLMDOvCVMtK26VaKAjD4VOVCFKradYebrSRaYVzsG4MeFc0gkFp8caBDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555918;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=gXaEf96BKC8pNivTSNLbtj/Et5+L+f3wGy+S78GkQ0U=;
	b=0jJX6Z+9EGrhHla9G633sYwE+QnHY4N7SB8t1XocQ1Y1XPnJ6+ON72d6NitUSpsemz3F
	 ncqArDSu61QpdZErVNjM2NrRj5APss155hi1GamtpYvnH2CuxEw0CWd648Rr//y7rnzY/
	 bfGuOT4kOl9GFP+moWtwJNm18SQ7G7+R6zAFihV6Z5vddAljOqmtRZB8iQ+SFEt5LJvji
	 ZMMzzevkHN+hmN6ysNg4AvfDWNbEjpS4IWlwE6Vk9K+UgYu6TyrwyCDd/YgsGuEFKAWjB
	 jBFe7QARk7F0MELhXyx3nlcMnEkV88clUzLYGQj1y6XHJu0kR1/1zj7XDNMp3nouYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=GVxqOCB1;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C16606A693
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C16606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=GVxqOCB1
DKIM2-Signature:  i=1; m=1; t=1795555916;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:oYu0kZEyUCaZ8ZK0SfGZi4PoyjPW
   1FlDXRXkoTAx+x6Ixhu1Ir+776+8msgn2rDM8LSoTZplS0ZNdewf21W8A+Njy20DaDRa5dj1kro
   /JSGcEcEvSm9c07qgBMWiezxGWR72Lqijre0yjS+kJ/gQYO6+25NZBlkJ4jsUVrG5ernFM935S2
   CpzEqAc3aL77wwVxR65323i/iuG7/GFd00yOVJwCCfowSUoy1hFczdG9C3bHZ01abbuWqb+yfSe
   cxw52U6sIRi2B8CiFliEQrITy2izQIXIP5ed7F5AF4K49nKRCRdnc5mWCQH/4ccgSCJIv9GLzxt
   XXqwPcmIhmV9yA==;
Message-Instance:  m=1;
 h=sha256:
   GQ2IE2VAsqkMrYNwvF7dz5E1WHDR4bXy8hL2TOYHmgs=:
   gXaEf96BKC8pNivTSNLbtj/Et5+L+f3wGy+S78GkQ0U=,
  sha512:
   OFFAAF20XV/z5vIrS2bTPz7lj1WwLLZiuJyCnClDeN6kpsX1pdlEYQNpQzZxM/t5sLpfgZpS6JABwPvREeHXgg==:
   B2duNw9Q/QBACjVr7Zzafd/UFR8ikvNFauTZyVzKgkyyySp6kfzoQzvUb4uPCfP+kMXK8lAMrdk9e/BYO+T7JA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1795555883; x=1796160683; i=wahrenst@gmx.net;
	bh=gXaEf96BKC8pNivTSNLbtj/Et5+L+f3wGy+S78GkQ0U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GVxqOCB18J7lAXN0Tqe5Rx/WmJzLTffIMg4fX9ZkyYr/YdK+EVkpM00CceMI3Eyh
	 TBWH5PvGzmyTBWgAvtOLYewSRAtwZLPmhF+j0XlrFwxFjSA27ZDNX5u3UQbijAjFx
	 NXHOnQBNTxPv62BUU58h16vXfA6WEft0BEdldB9vnwgdnGiXy31Gz82tjAI+1CSRY
	 7/GCRgTVn9uQa8vmuhJqJYT6uWx8EETMnNmrXtnS/2O13T/p8/wNmmV4TA8ovoPeo
	 8p8oeNvP4gKH3a/qznViHo2CHkmCRPdMzfEbkX6rlXEvVuF0VJS1GXJj6LOkl19Zs
	 FOwu6jLcLf76PSwFXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNY8-1y5IvT2MTo-00gPJJ; Tue, 24
 Nov 2026 22:31:23 +0100
Message-ID: <5c2bd597-a279-4523-b702-0af2c6d9d4f3@gmx.net>
Date: Tue, 24 Nov 2026 22:31:20 +0100
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
Subject: Re: [PATCH v5 1/7] usb: dwc2: fix recovery after PM domain off
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, stable@vger.kernel.org
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
 <20261117-dwc2-low-power-fixes-stm32-v5-1-0f197e0e6362@foss.st.com>
 <af32cbc3-9c24-4e43-a7ca-f4716f48cb34@gmx.net>
 <7ffe72c6-6204-43ab-bfb7-5df87341ce7b@foss.st.com>
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
In-Reply-To: <7ffe72c6-6204-43ab-bfb7-5df87341ce7b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dgsIduGijMl0Qz+evfHW7XOSHCZe6GYNvhNThRrtHQ1Z6wyYVFg
 xnmQuslbL9uPJklNLf45zp4iyEtKF52nH+8VbCSQyo7ZWNCxvvaTEIVriwznZV/rv3+odel
 v+uqwu4R8b2/TxNQHfFe3aJxqEBlrp283j1owEbkM/5y5VdML4zPUQdlPN7rjJthMs7IQuy
 vS2rz/WLUyDEmVTyTBoWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5wuCw/7vTJ0=;yjCYAkbX5CgLdoKlP3G3Z/B4u/V
 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

Hi Fabrice,

Am 24.11.26 um 11:52 schrieb Fabrice Gasnier:
> On 11/21/26 21:38, Stefan Wahren wrote:
>> Hi Fabrice,
>>
>> Am 17.11.26 um 18:06 schrieb Fabrice Gasnier:
>>> When the power domain containing the DWC2 controller is disabled durin=
g
>>> suspend, its registers are lost. Reading registers to back them up fro=
m
>>> dwc2_suspend() after clock gating can hang STM32MP1 in both host and
>>> device mode. Host suspend enters clock gating directly; in device mode=
,
>>> this can happen if the host suspended the USB bus before system suspen=
d.
> Hi Stefan,
>
>> sorry for breaking this platform, but I only had the Raspberry Pi for t=
esting and I didn't get much
>> feedback last year.
> I saw your series, sorry about that, but unfortunately I haven't tested =
in time...
no worries
>
>> I'm not familiar with STM32MP1, could you please clarify based on the c=
ompatible which is affected?
> Yes, "st,stm32mp15-hsotg"
I think it would be helpful to have at least "stm32mp15" in the commit=20
message
>
>> Could you please explain, why backing up the registers before clock gat=
ing isn't an option?
> Well, that can probably be an option, thanks on your suggestion!
>
> That's not the way I had in mind (power gating and clock gating are two =
things).
> This means: prepare for register loss each time the controller is put in=
to clock gating mode (but
> drop the backup values when exiting clock gating without PM-wide platfor=
m suspend, as these are
> normally not lost).
>
> I can rework this in V6:
> - Add the registers backup call when entering clock gating. This will ba=
ckup the registers when the
> bus gets suspended (either as device or host), then a later PM suspend r=
equest can skip the backup,
> if they are already backed-up.
> - Remains some stale states, as raised by Sashiko: when doing this, most=
 of state flags have to be
> re-initialized. I'll try to split into separate patch to ease review.
>
> Is it basically what you're thinking of ?
Yes, I'm not an expert here and mostly followed Doug's suggestions. I=20
consider my suggestion as a possible fix for my original approach.
There is a reference manual [1] for the EZR32WG ARM MCU, which also have=
=20
a DWC2 IP. Even if it's not your SoC, the chapter 15.4.8.2 Suspend seems=
=20
to have helpful information.

I hope this helps.

Best regards

[1] -=20
https://www.silabs.com/documents/public/reference-manuals/EZR32WG-RM.pdf
>
> Best Regards,
> Fabrice
>
>> Best regards

