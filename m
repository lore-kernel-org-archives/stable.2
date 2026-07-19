Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A101E531;
	Sun, 19 Jul 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423764; cv=none; b=qmLfqB4kWWsnBkPmtZUmRwq2nyEmI5AKCESpKftj72fDC9FW9DG2uXC9P9VuvYvTsK5acRTO4JmodW+aZ8TmYX6JqZBsee3cmvanZL9yiWhGjis+GwIJpl/mIG6H/IrGzdrCzyRwQ2CR5kX+X7IbyQyWll9S4PUbIYzryKEqGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423764; c=relaxed/simple;
	bh=B9+TpBYL0G9iJ+hbhyw0XaON05DzZzEFdjl5u4MaSrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P24qnLLLUBaiqqEsImDMdN3PQ3W94s4wXEf9bjKsnDZA14Yv7UsEQXWwA5S2vY24Sa9Ke8Tq00TCu96uCoWgtvjwMB/EuV8pcVtGlLDNuHHf53e3NuNKiMeX0dSExJdOws8Kq+BMqxDT0eFUsa5FTusw5LGzrcynTqTAfgptRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hYzDv1Mi; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hYzDv1Mi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=mxTKypsuc0BRoNLTq+43Llcx+hudMm0+ljB+zeaM/Vo=; b=hYzDv1Mi4QSCY6e8
	ZJcnyHwdFb0dP1jkOUkVxecV1VZ4NHJw6GaegAxmlt9diyYXSI17Pci1K9oc+6tgvZXCEIxeLhEBj
	whR+TdVSMT489aUUPXQDDz0YwAh8UD9ccNR9/lMQ8JlCsSkic1cICML5j+lvrejG2YeuwQCkJnHLB
	FTclQd73bwS3b5GIPdI1wmmJCmvTVU2CCVitpzQ/4LF6BFqLRuXqkhsRJCgBI9zTaQQJVAYN2V0nb
	C43LHcKw+qTJuxwe5N8AgGkvANY6Pz2Xe7nHoEq9Re4kzh6DmSmhUj9YbnXdMTwqKzj2YfrElzjsF
	Gar/6j9jIzXtLiLJIg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wlG8M-00000003ZUy-11c8;
	Sun, 19 Jul 2026 01:15:58 +0000
Date: Sun, 19 Jul 2026 01:15:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: x1: disable ps883x USB4 capability
Message-ID: <alwlTry32zTh3KT0@gallifrey>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-5-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-5-cec86d0b909e@oldschoolsolutions.biz>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 01:15:21 up 13 days, 56 min,  3 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Jens Glathe via B4 Relay (devnull+jens.glathe.oldschoolsolutions.biz@kernel.org) wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Add the "parade,disable-usb4" property to the PS883x node so that the
> retimer driver treats USB4 as USB3. This allows the combo PHY to remain
> in a DP-capable mode, restoring working DisplayPort output over the
> dock while keeping USB functional.
> 
> This is a temporary platform workaround until proper USB4 DP tunneling
> support is available.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Tested-by: Dr. David Alan Gilbert <dave@treblig.org>
  on zenbook a14 with tb cable

> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts                        | 4 ++++
>  arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts | 2 ++
>  arch/arm64/boot/dts/qcom/purwa-iot-evk.dts                        | 6 ++++++
>  arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi                | 4 ++++
>  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                 | 4 ++++
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi                              | 6 ++++++
>  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                       | 4 ++++
>  arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi                  | 2 ++
>  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi                 | 4 ++++
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                      | 6 ++++++
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi       | 4 ++++
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts             | 4 ++++
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts          | 6 ++++++
>  arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts       | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi          | 4 ++++
>  15 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 9fa86bb6438ec..5ec77c5912f8e 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -762,6 +762,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -877,6 +879,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts b/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
> index bfb7cea56df96..328a360843f4c 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
> @@ -601,6 +601,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts b/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
> index ad503beec1d3d..9ce080b9ae896 100644
> --- a/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
> @@ -703,6 +703,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -760,6 +762,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -865,6 +869,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
> index 48c4ad648354e..d67ded1da5875 100644
> --- a/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
> @@ -678,6 +678,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -798,6 +800,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> index 66d566808f583..e1033d3bef359 100644
> --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> @@ -845,6 +845,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -945,6 +947,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index 9602d65c8b3db..002a974c88751 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -967,6 +967,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1024,6 +1026,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1112,6 +1116,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> index d6de4da02dcd3..fa17cdafc07b4 100644
> --- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> @@ -852,6 +852,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -947,6 +949,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> index 02708f23a8657..4dd62092b8809 100644
> --- a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> @@ -917,6 +917,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi b/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
> index 7559557610ed4..1aa075d6eeda5 100644
> --- a/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
> @@ -759,6 +759,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -822,6 +824,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> index 2e38402e2c140..ada5da526634a 100644
> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> @@ -795,6 +795,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -852,6 +854,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -943,6 +947,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index 5d49df41be02a..c8bfb38c64ad5 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -895,6 +895,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1018,6 +1020,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> index ce7b10ea89b6d..11412099eaec1 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> @@ -726,6 +726,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -789,6 +791,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index beb1475d7fa0c..d16d3627796b8 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -863,6 +863,8 @@ typec-mux@8 {
>  		orientation-switch;
>  		retimer-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -920,6 +922,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -977,6 +981,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts b/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
> index f95b1f9f439d3..55f9df8e5f403 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
> @@ -857,6 +857,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> index 28342cb84ded7..4ccfbe7e14eb8 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> @@ -902,6 +902,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -984,6 +986,8 @@ typec-mux@8 {
>  		retimer-switch;
>  		orientation-switch;
>  
> +		parade,disable-usb4;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> 
> -- 
> 2.53.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
