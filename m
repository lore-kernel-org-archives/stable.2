Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575268;
	b=cYW9b6ouDEOK9vCqSP2HPWIt991ISyOYo8JN2DfUsfczDXfiof5wj/d9yv95qLmkTNtU
	 TUQRq8rx9DGFJB/ChMwcplSithH4IDoGU+S8zkuO4nmQ5jZTlvzTKr+KY58RGdsOcU5VZ
	 4OyewdLM1dEXWJYFGygb0xrJNVYtjEG1I1lgOGQzlf5LVH79TY2DiDbj2k8VyzoVz/BG6
	 7tiQlteo4Ey4AZbr1rwSEUhR0dz4zFRmsEqD3EsKu+kESzMR9dXr7M2bvuihp32fTjmfy
	 qZ9yN54zdJqFV9T9Mi3wC9tqhKBKxnfbgi3rbtO2Dt/d0DmLJER3C8CeoAfYdJFQRkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575268;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=UfZVHokCNLD1pP/P6Nr6gv/uX2JAhB8ev3N9/tlPdoc=;
	b=k8G/eTHqZry5/InvytayYHVVHpn+F1tz04AbrnPOL2QSuPYsIYfO4yUGNhXBeG6XxYLu
	 Y2QxpX0nRdOqnEOTCOakGgMUCbsvt4gw9xlKb2kQDFYcuIYqGYT1e5VWDy0DYPFg32v+0
	 XRwYoDQAapQd+wvVKR3rJEG2Ec1hxrNJ+rn2+pjOJ/03V8hDGLNu2Erqu2slm4XC5T30n
	 Kyqh8R1qov6WQa1id9z8fLcw2mscyD0RUjpLzrzckzQ73+WA8xg5n/kTl6JrCsOS9W9RS
	 owqN9aLNXe07bRV8Zi+oLD47J6/AyUZ5i/h6KVjhVzAH+0KlRMrmeCz9lhGodgNhi8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=RbL8XM9g;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962B606A319;
	Wed, 21 Oct 2026 09:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8962B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=RbL8XM9g
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D84B7A1626;
	Wed, 21 Oct 2026 11:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792575261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UfZVHokCNLD1pP/P6Nr6gv/uX2JAhB8ev3N9/tlPdoc=;
	b=RbL8XM9gur1HZQkXDNtjhMB/TW4NinCTQLoyW3iOff7mfPN7ODWPJAV4rWLpcLMkBlkpJy
	1fOSUPse82TocaPS/mDLjMBeEDI1+leueE7InF75k8bgeXM3WiIiDN8OElIfS8Z2ZSFStG
	dFpZAgzK0RQFOL2oQOhaq0dAdatqaKhCNqrhFFsQ3Fkz2db36uXXIMNG1nyCHmTAsFtKcM
	jS7K8pBNl5cTdtfk5Y4cQ8b6OqDIFTF/gDMKT0bx/UW8JgSx37tno8Zu9eF79hsjhRrZIl
	BPFplSuLdf+rtbHFeLH8daLg5Ov+RVf5Yb+56df6UbmLo0VasJjHuxjb1hdF1Q==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 11:34:19 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <20261021005654.23517441.michal.pecio@gmail.com>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
 <20261021005654.23517441.michal.pecio@gmail.com>
Message-ID: <cae2e837872be0560f7f46e13651059b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Michal

On 21.10.2026 00:56, Michal Pecio wrote:

> [...]

> I will also see if I can figure out what Windows does in such case,
> because doing the same thing as Windows may be the safest bet.

I checked on Windows 11 (Intel xHCI, WinUSB + libusb): same
descriptors as on Linux (HS, bulk wMaxPacketSize 64), and a single
4096 byte bulk IN read returns the complete 110 byte reply, so it
seems, that Windows programs the 64 bytes into the endpoint instead
of forcing 512.

> [...]

Regards,
Nicolai
