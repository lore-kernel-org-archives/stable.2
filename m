Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C2480DFC;
	Wed, 22 Jul 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709549; cv=none; b=GNQSkuFyCBYSypNWIc6aB0KlsfCDOV4nI6jEAm747l+9nE+W3GluGLyQLj1Z752NiB8MVnKydb3+vxJrZKw+2L+gueTV0FgEbDZd9n+We1LjWzHXRrSewQlsu+kDUMmA4YK/YYVxeyuCZD2jy65j11pdxv/oVMkecFAno/xu190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709549; c=relaxed/simple;
	bh=4q1Q1txUCwhk2J/e0hzakjsDa63jwBwt+yOGpSHvoxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um9hhH3shZOg9RWhPFIXBTUAVw4R5qWW9MiAU0vajEZNqrysfQYcpEt4g1jzsFl6esiPksMtfK7B9LNy2cLzLHeB2Qy20ttuPXAAnYzVEAFQuk/dbQwrPpPhl1N8WJ8JeJPegpbblAnmtHxQ4QaSZmRNkg+X8AzRrC0MULXrhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=FKs9Cd/8; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="FKs9Cd/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1784709516; x=1785314316;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=Zcl1RHNKMS9Lke9hhCKQRm3ZolwtmAcJeqnUoX3nHbU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FKs9Cd/8O2H/c7auevIhufytyXel7fmf3nuz8Siwu2KJZyJdSUhOnMB69aqGkCe2
	 XbopwKeiWSFUWW4Pp/RAvOIJZdd54fW1ksrQYoGUtS6em3qBrNfXeNhVorI8zBT87
	 cmtsKZsNFsUuO/fso3Z5IFk6t75VmalW4gMx3iLmiB4MTP/Ml4+oUBHNTqJvMROKV
	 OHKCYAwSg27SRjLwRtyycjMnHgPFcpWkUxqIWNnRcrp4e54pvNdpo1dTrpLzt5n1J
	 47b21vj8FIioq+04SwgjSllYpcxHlTCICHFeL41ej3oa7JQKf+vAUpxkEYTRbm0uQ
	 ujcPP6DrO2PYmnZHLA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N2VKr-1wzMUl1Ycx-0140zK; Wed, 22
 Jul 2026 10:38:36 +0200
Message-ID: <41222b67-19e5-4f74-b4aa-928d05db9675@oldschoolsolutions.biz>
Date: Wed, 22 Jul 2026 10:38:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
To: Sebastian Reichel <sre@kernel.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <al_0LjwmfW-cECnY@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V1f49sQ3eehQSpkMjgmg/Xz2Jz4inAATEwSRTyaciuWbI6TmbDe
 W+yOvr+fWI9gTq+aKyslK1YdzpTJaccZOn7yOGKl7b6jZ2QjwMlKvShSFNPWQnz0HprGMI6
 pzICEd9YhQvL1Dy+Gm/bfO4SpbKe+FcvHlKsdqibrGgFlnQm3FEx39uNeK3DoiVWepYAfsl
 P8otnPw/8XbPJOdwOu8nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EO6jLuclIYc=;Rt6SrONHNnsPq8mCNNmeZRVV3ui
 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
 =

Hi,

On 7/22/26 01:34, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Jul 21, 2026 at 04:24:06PM +0000, Dr. David Alan Gilbert wrote:
>> * Sebastian Reichel (sre@kernel.org) wrote:
>>> I don't think a kernel driver limitation is a good reason for the DT
>>> property. I suggest to add something like this in the ps883x driver
>>> instead:
>>>
>>> /*
>>>   * Hamoa does not yet support USB4, disable it for now to gracefully
>>>   * fall back to USB3 + DP AltMode. This should be removed once USB4
>>>   * support landed for X1E.
>>>   */
>>> if (of_machine_is_compatible("qcom,x1e80100"))
>>>      disable_usb4 =3D true;
>> It seems a bit of a weird abstraction break to put a machine type
>> check down in a device that's not specific to qcom.
> It's obviously a hack, but this quirk would be simple and fully
> contained within the kernel and thus does not create a new ABI (in
> opposite to the DT property). Once the kernel supports USB4 on Hamoa
> it could simply be dropped and people have working USB4 with their
> existing DT.
>
>> I'd bet it's not just qcom's suffering from this as well.
> Qcom boards are the only users of ps883x (the driver is exclusively
> probed via DT at the moment). So right now one could also simply
> remove any USB4 support from ps883x, but that would work against the
> people working on _adding_ proper USB4 support.
>
> IIUIC the problem is, that the Qcom board supports USB4, negotiates
> this via the PD protocol and then soft-fails because the software
> support is not yet ready. Most other ARM platforms do not have any
> USB4/Thunderbolt hardware support to begin with and wouldn't
> negotiate it, so they do not run into this in the first place.
>
> AFAIK only Qcom and Apple M series support it. A quick search
> suggsts Apple used an Intel retimer in the past and a custom one
> nowadays. From the looks of it the x86 world cannot use this driver
> either and probably handles retimers transparently in ACPI, so it's
> effectively Qcom specific until other vendors start adding USB4
> support. The only thing announced potentially running into this
> would be the Nvidia RTX Spark, which first needs to be released,
> then find a bunch of people motivated to implement upstream support.
> Nothing with USB4 capabilities has been announced from Mediatek or
> Rockchip. So I wouldn't hold my breath for another user and still
> suggested adding the machine check instead of simply disabling USB4
> for everyone ;)
>
> Greetings,
>
> -- Sebastian
I understand, however I wouldn't want to nerf ps883x for the Hamoa=20
platform until the USB4 stack is complete. The issues you currently run=20
into is:

- you use a tbt4 / usb4 cable and nothing works,

- you have a tbt4 / usb4 capable device in fallback mode that does=20
complex stuff when negotiating and firmware / a partial USB4 stack=20
requests USB4, which ends up not working.

Both cases are not the hardware's fault, it is capable of USB4. The=20
driver stack isn't. Therefore I would prefer to deliberately disable=20
USB4 modes by device via the DT. That way it can fall back to=20
re-negotiating something the driver stack is capable of. PS883x is not=20
the place where this starts, but where it's convenient to stop.

I did some tests without USB4 disabled and the 40B0 stack in type-c=20
cable fallback mode, and most of the time it just works. Except for an=20
unlucky plug, and despite it shouldn't request USB4, the request lands=20
at the redriver. Disabling USB4 modes reliably let's it renegotiate.

with best regards

Jens

