Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641737;
	b=czLPPvuYn6T0bc7BYRIquCm/Gu1qdBTuInNiTaP+2AsGtUx0xHWnhCKSYb62YiernCww
	 Twxma/cdR88ddZ6IbNrhnBQSeAG6GD3DkNOc+JuL/a7THHXUz0Lvy0T/pqjKv7mmBLxt4
	 PrtSnBykcs+ZC/H1hLXngJ9J04utaqZi0Gge4J3FXX1TI7K3Kbza73G+Xqbp3d50Kfa5U
	 jLYpPSneqnoH7IJW9AfxlequVcpZeyVCFf/TQYl8R5/tlh+VS12yDkGrLDC6yT3tOAMJP
	 YLKavSB3KkVC/bLSQdLFHnpyCEHvC2ZwBl8C/JLu4IShNdGtWMx7UUoNrLKp5jVKmmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641737;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=;
	b=MxH5JvZORdK80aJ0R2TheMqHY+vvpplSB1rIzWAdbG2CfJ6UuPDnOtK976hLA99pu6TS
	 YZzlxvFtSUF1YJ2Z4H47yKHH1q0Rp60aRdNF8WNjntDWBBdnspxuK1Brr8LxxS9SplVBy
	 Ax+gqfCxb/ZVzxmZJiqTN3X0WGfqk8YbX57i/T3jz9pcDHYlsswBgufswAs82EEjcSI9I
	 bWoz4zqMQ6K1hK+IX+yp1D7icm+aK47sQvhY9qgDk/H6N7wN5gYjHYmBJtFiHW5CY1vgF
	 E6pv/kxDH+XhKTI2fs34LohaJ+MGJ5E2Gpf+M2oxPrAop1OeC3OCtyhWvRSta1TWorg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=IiNo+lzZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U1NSwhIm;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA8606A906
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FA8606A906
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=IiNo+lzZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U1NSwhIm
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfout.phl.internal (Postfix) with ESMTP id BB041EC05D4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:48:55 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 12:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793641734;
	 x=1793728134; bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=; b=
	IiNo+lzZdgRgb1LmBnbR/AyaxzHsiiTesFUTALF3o7B9p3xcIVUAdqkOuq/FB+3j
	ckJl3ZYnXLQVZxN1girWl7EvTkaIIfwruCS0kWzvBYeBDpfn2jpUhDNQGt6nvTjw
	Q7VA4KSPjpTOOHqWFMR5+7whPzdNg2aY0HNWxDibNKHMe68I6aww8cLv3xgaUgjl
	J5w4HiKEaHTRJegs8XNNNt6w8fXnrCuD4rWW3ELCZKMZ9gj8rakvPWlhvIdO9maK
	QqPrvCJl44djieuf3qmC3o5MynWgQ8crEhJSzCs7FiNocD57HHuWEJ1NaDfDW9mF
	pLcwWfKeY9777T5mryNexQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793641734; x=
	1793728134; bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=; b=U
	1NSwhImXB10yFfX8P11maB4ou+M02tRikMiuiL6vSghMJOhiAYpkhIZvvDBKu2y1
	Cfj/q2njqV+T1hTVW60PR2aZSH2LqpshS78iUsVwR+3URueNjDPZ0aIO4vgly/fQ
	YzqaMHF66hc+MI8rjOiaryq46qiGBEooVXRFtGAeEHJq/CAIyM1tmLfwPp6llxoJ
	OvANyp2fBCaFBro5HI7gr6f1uAlQSWquS/mSQz0l9zM607kzZHLIKdqBbucaBreG
	9a7Ei2Odikkq9wAZ6dTLlLlixOgjNCQFECBJjoXYE/ktWAtUrJUsvt2NbVdJM2jO
	lnI07YK05cXJdcbjH3D7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793641734; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BMIVVpem5tMOHlGK7S2TkrwOgl+EUID8MjZcyVyDHyFq3pW
	M4iXiXRQZ3lTBzgtnsLQDbE+2mG2PQ19qKOauk4UwyKp4nASQ0kTQbe005AC5ohk
	X5xNd/zOyb8PJzQOkYf7n2+UGaY3co8tTG8vlzAz56CXgnlDyhlLXFurjKsC3SsU
	/ZzuQkCmcav01Nn0EGHx535FgvENO44LPikYd7GywBaf1w8ilf6PABDeSFPSKJ/b
	gNKe0IKMrLOPkLlnjV0gBYgK5OrJ6tA4iOrB1X7Mq/7mcCjDOqC9dLYSCAxDEVs2
	uefS0An9DauOTzbu48kDYaHnWC7LM3fcbs3OceA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+T9rqvcAn2tEourMhxxvEXXGzZA3/HK6R+riLlbkuOo=:UJ0nj2m4f6P1FRVJiS22N/Tuphb29VM7fiePoWeLp9E=;
X-ME-Sender: <xms:Bs3oauhsfU46CBG4TEC_L7--h1PKdoFYDQ6MR-hOGVK3V5PsbXC4FQ>
    <xme:Bs3oap2iroxmhqrIqCU8YLmcPyjo0gnQIPeMOk8e7MJDrEw8rsPjOJFe0_9CRMJWs
    -M1vUFYG8a4T4Iq0Aq_ISlp4OS6gXEiz-aT97rkMlJUhhMbUcrRuqNQ>
X-ME-Proxy-Cause: dmFkZTEMLs5fHg3Me8rdwk2ZYUrYjrTNASYaAuulDI3RfmwAr8iMA8VVpMZM91C5E+cExz
    SvTAmkihgn2nuHYYWcCpJA5e64zhj7Su7KehaoyIkM7xZV8bQ8D9YOcRbRXxO/fnd1jvRc
    8uqY6Ccsg1v25lhz1XYlAxL3NDP2eKxr16zaNz/JJBEVmeHluKtODu1j8MrPIkO/fO6sBO
    +78ls0gL5YejrSt5pVEHj/XpWu6R5Dd4wXLmBGoYUCp9bvxZwgm6/2vV9C0Nanx6Ix6ms6
    0InrmiHpAOrGeAvX+VltfKV18OHT2K9atTCxabn40oTSYKdP/14NMnLfwKHlXt/wg7/Sm0
    da9kBEZNdbCPfM0SJF0abNROp/XWz4bal8MXwANhJrLRRlmQa9+a96+CrV6Q/PR0ZVyjMh
    8myXu6C7xemjddHSWaRqb/9Ir1Y30JjPHib1NDU6539eFne2ZS4Np3eEBbjquero7QHa2P
    DpyksJXy8EmBrhIJgJ1fm8Jb9YBVzkyxs+52xsE6uslLtPAexlZlaW0GxUev9FX0xJulTS
    DujWKU0tZG2aAuSC9SKsHR6W1oe0gOkNdPgBagbIrfT1AkAEC1p/ix+sx4R2oiN66ITpb2
    I+U1/B/MhaNTq+92+VQmjGtspNZ/r4txpD2V09QWiwcUU0Hycr6+dDpxSWkg
X-ME-Proxy: <xmx:Bs3oavF83XQx6mOw3moUglnDgz-UpYFpoqponWGpI8zfbuc3Lkd_0w>
    <xmx:Bs3oaum8iOulIDf3m1UtkDKUzzGmS6HfEC9YZzi_TulAz1ZqN4-ZWA>
    <xmx:Bs3oajahAUMn_1SRNqIlNgbFtJ61CnGqvr-n_3hqnxF0kSJCiyIzAA>
    <xmx:Bs3oajGW__5mCJw7Pf1EFo1SvMD87zOtOchCojknTVsOEIZQ1xy4Yg>
    <xmx:Bs3oamwvuvn45oikuuzaYOtcuKkrR-Kn8NVeNywG9C5UiuduuifUrnIu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 6D88F2C00082; Mon,  2 Nov 2026 12:48:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AYDYWHX8bjAc
Date: Mon, 02 Nov 2026 12:48:34 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ricardo Ribalda" <ribalda@chromium.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
In-Reply-To: 
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 2, 2026, at 7:40 AM, Ricardo Ribalda wrote:
> Friendly ping...
>
> On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wrote:
>>
>> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
>> sysfs-driver-hid-lenovo-go to avoid this warning:
>>
>> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> ---
>>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
>>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
>>  2 files changed, 6 insertions(+), 40 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> index c8221373ef76..f3ba3504939d 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> @@ -364,11 +364,12 @@ Description:      This displays the available options for the mode attribute.
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>>  Date:          April 2026
>>  Contact:       linux-input@vger.kernel.org
>> -Description:   This controls the behavior of built in chord combinations.
>> +Description:   This controls the behavior of built-in chord combinations.

Nit - this minor change is not part of the patch description.

>> +               For the Legion Go S, this controls the touchpad's operating mode.
>>
>>                 Values are windows or linux.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>>  Date:          April 2026
>> @@ -377,7 +378,7 @@ Description:        This displays the available options for the os_mode attribute.
>>
>>                 Values are windows or linux.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>>  Date:          April 2026
>> @@ -640,7 +641,7 @@ Description:        This controls enabling or disabling the touchpad.
>>
>>                 Values are true, false.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>>  Date:          April 2026
>> @@ -649,7 +650,7 @@ Description:        This displays the available options for the touchpad/enabled attrib
>>
>>                 Values are true, false.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
>>  Date:          April 2026
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> index 4d317074bb7e..218164cfe544 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> @@ -231,41 +231,6 @@ Description:       This displays the available options for the mouse/step attribute.
>>
>>                 Applies to Lenovo Legion Go S line of handheld devices.
>>
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This controls which value is used for the touchpads operating mode.
>> -
>> -               Values are windows or linux.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This displays the available options for the os_mode attribute.
>> -
>> -               Values are windows or linux.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This controls enabling or disabling the built-in touchpad.
>> -
>> -               Values are true or false.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This displays the available options for the touchpad/enabled attribute.
>> -
>> -               Values are true or false.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>>  Date:          April 2026
>>
>> ---
>> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
>>
>> Best regards,
>> --
>> Ricardo Ribalda <ribalda@chromium.org>
>>
>
>
> -- 
> Ricardo Ribalda

All looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
