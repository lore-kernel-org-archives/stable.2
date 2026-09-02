Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7623EC808;
	Wed,  2 Sep 2026 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340217; cv=none; b=CPVGHKaih0EzLtEZsoMKuviyQxTlPdEuTc7DmaAuJiMWj2ounTOXPlrBnsoECY/tP/jsehXC8c7I3KKLbkbBYDqOsH458w4SqrBQ6grIvxyrkOFfMELAAtnu3t82K4tMaRXsvmScJwjX4B5G8QyFzwEIIOoXZ4IXul6jwDoXl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340217; c=relaxed/simple;
	bh=Ugizi1/Oz/GDC6hSM7xY+cdvMaq2t4Ps9VEX5p1bxBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6U7FZPDhe5EDcek+tGmtLclL5ftZ/qs6I1haXKRBX49tLouKTriw/YoKzCo4XTNwjeWBN5vs93UJiRNI8Uei5ApxCUe0JUm7tonnwzHfmbAabYAvFQzWIqt+zGaYqvyh3obMO+aTrIJkIar6+b1TmbrRwaroZ11CHeWw16oCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1SirV6k9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1SirV6k9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3B8D1A1953;
	Wed,  2 Sep 2026 09:10:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 935226053C;
	Wed,  2 Sep 2026 09:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1B3A11C792D5;
	Wed,  2 Sep 2026 11:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788340211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dWQm08I1k5LyUTw+wBhW0HthtUeHce+mEdC10fdxN/A=;
	b=1SirV6k9/fAEqVYJRgYQiMtRJcFLFJPD9Qa4SPbnxEoaWVGcRuMj27XmFPWJx+kj88yr6f
	KM3VAlxhYw00T6QKynkYib37xl0DjDmgT8GWTwD1It91umoj0nBGz1iQ4/gCPi+AM5MZRs
	1/Pnl1HsFVZSKN19K8BbCJyFMAr4m40pnJvI8stNwbccFQopVO2XbpYfVDZzsyqGzxCUfQ
	RnQvv2CV5zryqYFdoJYXGLulq7bmwVm6tdMyl9niiFkFa5vqXADjm6hemoiKtSK9iCEp5u
	Gt6KmJVE68xAjOKQrb+H6RTkhc2xxvicacXTlbPhyIpbN42rWTvyHkQNjK8S2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Heiko Stuebner <heiko@sntech.de>,  Michael Walle
 <michael@walle.cc>,  Finley Xiao <finley.xiao@rock-chips.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-rockchip@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
In-Reply-To: <20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net>
	(Alexey Charkov's message of "Tue, 01 Sep 2026 19:33:11 +0400")
References: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
	<20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 02 Sep 2026 11:10:06 +0200
Message-ID: <87ecfc81e9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 01/09/2026 at 19:33:11 +04, Alexey Charkov <alchark@flipper.net> wrote:

> The OTP controller is driven through a single set of registers holding a
> state machine which has to be stepped through for every word read, yet
> nothing keeps two readers out of each other's way. Concurrent reads
> interleave, and the outcome is either a reader bailing out:
>
>   rockchip-otp 2a580000.otp: timeout during read setup
>
> or, worse, one of them silently taking delivery of the other's data.
>
> Reading two cells in parallel from userspace on RK3576 reproduces both
> within 150 iterations - 53 read errors and 9 corrupted results, the latter
> either losing their first word or, in one case, ending in the two bytes
> which belong to the other reader's cell - whereas the same reads issued
> sequentially never fail. Concurrency is not hypothetical here, as six
> thermal sensors source their trim values from the OTP and reach the driver
> straight from asynchronous driver probing.
>
> Guard the read path with a mutex. Reads are the only way into the hardware,
> as the driver registers no write callback, and they always run in process
> context, so a plain mutex spanning the whole clock-enable, read,
> clock-disable sequence is enough.
>
> Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

