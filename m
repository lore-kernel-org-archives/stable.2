Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA146C4C1;
	Tue, 21 Jul 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651058; cv=none; b=ekKhJZAjc/U16ZwkVWijasDUIMyLrCRUGvkUkH7XsuW/pDH5J8+M3HnmlMP8O0VBeHiDGZ6WSs9XTsfRtfXKkDWA866mPLdO1xrjr1AZhGtpDx7x0jT6X1U9IwBMdRRELeyfgpBgVYMNV4Q069pA6TxWndfMsaAe+VIQEvc37Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651058; c=relaxed/simple;
	bh=M9GKnOVRc/2iHlLIA3YgV+hx5vodnl63NAEXok14bYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9ySaVr1uhS52wm+r1BmIpLMde6eVYaHFlIxO6+EkKZx+ShNO2hWD3tUQ5iobR31qg4CuKrxFFbSTH3RSwRmx+tx5cKSJe/ZUrpmHyfg0duIhgt4itBOqqmc20DW0zu7iY1ilNrSDuNkWJHV5AAuJpbqTk0wTgi3c/R5zUEDhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sKeqSJ4c; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sKeqSJ4c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=60gNMuhoz8j9+PHZRsoGHJO6R5ote4Ye5QsNIwP9wFs=; b=sKeqSJ4cokJv3F06
	0TBnsQ9f8oW6sILXv8FY9kw4IoQUkSy1CakfshXlAOWVHOBcOxUpxdDtymmRYQwvZYFP8UD4sHjbE
	1qe7QhfPcoI86qa0aBCtUGPKgqEt4xLvu4zN2OXPmJjYURP9rbn1/KUohkl/CtHLFTXfJWtOFS1W8
	4nyXeSg9PArGvoKpmwodBEvZtmGSV4VJB/wvD8MHisNx8ZzZ6Wumi5osCXmo/krAaHmwilGn1zIbq
	qR5dfq/1isdgQYzXnO9G0qxXd6/LW8J3cbRCT/DwDmgP3PD+vZF1TFrFqyxQkE0vZtObF6/UcqHC/
	pB4fuKlTgMUv5Sr84g==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wmDGI-00000004GGV-2hBv;
	Tue, 21 Jul 2026 16:24:06 +0000
Date: Tue, 21 Jul 2026 16:24:06 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: jens.glathe@oldschoolsolutions.biz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <al-dJjzorP-I4Yff@gallifrey>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <al6-IyyWYRnEW4VC@venus>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 16:22:39 up 15 days, 16:03,  2 users,  load average: 0.05, 0.03,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Sebastian Reichel (sre@kernel.org) wrote:
> Hello,
> 
> On Sat, Jul 18, 2026 at 07:06:28PM +0200, Jens Glathe via B4 Relay wrote:
> > On Qualcomm X1E80100 platforms (e.g. Lenovo ThinkPad T14s Gen 6)
> > using the Parade PS883x retimer, connecting USB4-capable docks such
> > as the Lenovo 40B0 via a regular Type-C cable (which forces the dock
> > into Type-C fallback mode) often results in working USB but no
> > DisplayPort output.
> > 
> > This series addresses the issue with two main changes:
> > 
> > - Add a new optional DT property "parade,disable-usb4". When present,
> >   the PS883x driver rejects USB4 mode (-EOPNOTSUPP). This forces the
> >   Type-C stack to fall back to USB3 + DP Alt Mode, which works
> >   reliably with the 40B0.
> > 
> > - Refactor DP altmode handling to also support the legacy
> >   TYPEC_DP_STATE_F request (deprecated since DP Alt Mode 1.0b) sent by
> >   the 40B0 and other docks (e.g. SSK SC220).
> > 
> > - Add a short delay after writing configuration registers, which
> >   improves hotplug reliability.
> > 
> > This is a temporary workaround until full USB4 DP tunneling support is
> > available in the X1E USB4 controller and qmp-combo PHY stack.
> > 
> > Note: The DT patch adds the new property to all currently upstream
> > boards using the PS883x retimer (15 files). Happy to split it on v2
> > if requested.
> 
> I don't think a kernel driver limitation is a good reason for the DT
> property. I suggest to add something like this in the ps883x driver
> instead:
> 
> /*
>  * Hamoa does not yet support USB4, disable it for now to gracefully
>  * fall back to USB3 + DP AltMode. This should be removed once USB4
>  * support landed for X1E.
>  */
> if (of_machine_is_compatible("qcom,x1e80100"))
>     disable_usb4 = true;

It seems a bit of a weird abstraction break to put a machine type check
down in a device that's not specific to qcom.
I'd bet it's not just qcom's suffering from this as well.

Dave

> Greetings,
> 
> -- Sebastian
> 
> > As an additional observation, the same dock with type-c cable works well
> > on Thinkpad X13s, Thinkbook 16 G7 QOY, Ideapad 5 14Q8X9, but doesn't need
> > the ps883x changes (naturally). 
> > 
> > Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > ---
> > Jens Glathe (5):
> >       dt-bindings: usb: parade,ps8830: Add parade,disable-usb4 property
> >       usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when parade,disable-usb4 is set
> >       usb: typec: mux: ps883x: refactor DP altmode handling and support TYPEC_DP_STATE_F
> >       usb: typec: mux: ps883x: add a delay after writing config regs
> >       arm64: dts: qcom: x1: disable ps883x USB4 capability
> > 
> >  .../devicetree/bindings/usb/parade,ps8830.yaml     |  6 +++
> >  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  4 ++
> >  .../qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts  |  2 +
> >  arch/arm64/boot/dts/qcom/purwa-iot-evk.dts         |  6 +++
> >  arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi |  4 ++
> >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  |  4 ++
> >  arch/arm64/boot/dts/qcom/x1-crd.dtsi               |  6 +++
> >  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi        |  4 ++
> >  arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi   |  2 +
> >  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  |  4 ++
> >  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts       |  6 +++
> >  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  4 ++
> >  .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  4 ++
> >  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  6 +++
> >  .../dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts    |  2 +
> >  .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |  4 ++
> >  drivers/usb/typec/mux/ps883x.c                     | 47 +++++++++++++++-------
> >  17 files changed, 100 insertions(+), 15 deletions(-)
> > ---
> > base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> > change-id: 20260718-ps883x-disable-usb4-19b0fc13b5ab
> > 
> > Best regards,
> > -- 
> > Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > 
> > 
> > 


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
