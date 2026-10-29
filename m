Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262005;
	b=c35czf4ZtMqjt1fEjKTpDBCBEAdV5LZfj/nXfNhuDO7h8EQjAS6Kj6dCgL0NQWTKfPc6
	 v5GEAxl9qbwWmuRGeEAUpUYzf1KYOiahJmgasO2ypbT4aNoKJxFR16gB26pwDnIBSXGWt
	 chGxyGnTR5mmletsJ3MsLobPJHpwe/fJTvD4ZX4AKaS/MtpBlmzNze5yoiY/ZG/8BtuvP
	 3B8GIYSHv9TQQjHf2efrldIMxFMTc+5g3LP3h3xlweXIafT+xcKm38n2y7f1O0xoIRxSE
	 oGDMQhxhvUFPaHIeKQrLrSq66g9qmQsNqWbNYwzwkUwZf7vXOdzBjZl2DyMgqo1foAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262005;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=hq49hLBHa7UxfN5Y7PY1/zeZc0Rq/8U/5K7+yWJjlb8=;
	b=hPER8zrlQoXd3cV8IWdXxYQMCGysvTE5AZkuJwfFQkAZ3bDJ9iOUQ6q3Avul0Iva/IQ0
	 OpMno35RXvGuVFY3+LdmotX1cRyP5TVBJUS6ljhLEcWjNjQFVWXdIowfgcrZE9+33UhGe
	 qdmGFRiG58qoOQfGEuDF4IGaLnpqVsGCs2q/pwzCNHipX31zmwibanbBmkF8wtW18rdlm
	 X/WOO+GyjWce/F/Pv9LKBp44ICgmGkOLzvY/R8QAqndBP6k5VzwxDbbz8JxJ3iU0f9dnt
	 SRpi+4YPP0Qut4FTq90kpiiGNO+v274HctV5DOQf5xXkMc5AeaKtSuGweCOy2mnJe7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=QIMHzxMr;
	arc=none smtp.remote-ip=212.77.101.10
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CEC606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6CEC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=QIMHzxMr
Received: (wp-smtpd smtp.wp.pl 19003 invoked from network); 29 Oct 2026 09:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1793261996; bh=hq49hLBHa7UxfN5Y7PY1/zeZc0Rq/8U/5K7+yWJjlb8=;
          h=From:To:Cc:Subject;
          b=QIMHzxMrXKyvbvSPf9r3zdRNpzdUXlqA9y9T+e0eXS1souqtzoh16entuXwVA90XY
           M3fNHWJ7hzfryk1SjVAppe86hzO9mafjrdFxpQpW+uCSr77xtdbvxySibggXUMA1Hn
           luhOT3bkTrmlVbqFPYxAVh9t25uH4kUISSUcSWnrsGn9e93jg3AGs9Cm0jFwp68v1M
           ZUcM80POHLdc0k/otEl3iGEaPLRy+ykIVPdx9/Ln6VTShgOUvDcAu5moUZ6elDPwCS
           BOO8kSRl0nvlV6WVHM6aJbPN3lAtRN1Ti9JkI8YCxkM5pnzVT/GU63v19qkImA1KdI
           yZeL0RKr1ySrQ==
Received: from localhost (77-236-11-144.static.play.pl [77.236.11.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <enderaoelyther@gmail.com>; 29 Oct 2026 09:19:56 +0100
Date: Thu, 29 Oct 2026 09:19:55 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Wey-Yi Guy <wey-yi.w.guy@intel.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: unregister the LED if 3945 hardware
 registration fails
Message-ID: <20261029081955.GA10212@wp.pl>
References: <20261028142328.18560-1-enderaoelyther@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028142328.18560-1-enderaoelyther@gmail.com>
X-WP-MailID: 075bfac9a22155880d5d6a0228c06ea4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [4eLx]                               

Hi,
On Wed, Oct 28, 2026 at 10:23:28PM +0800, Zhao Li wrote:
> If ieee80211_register_hw() fails during 3945 setup, later LED callbacks
> can access hardware and driver state that probe has already freed.
> 
> il3945_setup_mac() registers the LED before the mac80211 hardware, but
> its registration error path does not call il_leds_exit(). The analogous
> 4965 failure releases the driver and reaches its existing remove cleanup.

Could you explain exacly how this is fixed in 4965?
I do not see this in the code.

Regards
Stanislaw

> Unregister the 3945 LED before unwinding a failed hardware registration.
> 
> LLM assistance was used to find the bug and review.
> 
> Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> Validation: A W=1 module build with MODPOST passed. Not
> reproduced; 3945 hardware was unavailable.
> Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.
> 
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index f7ca182d1494..5e11f0597255 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -3529,6 +3529,7 @@ il3945_setup_mac(struct il_priv *il)
>  	ret = ieee80211_register_hw(il->hw);
>  	if (ret) {
>  		IL_ERR("Failed to register hw (error %d)\n", ret);
> +		il_leds_exit(il);
>  		return ret;
>  	}
>  	il->mac80211_registered = 1;
> 
> base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
> -- 
> 2.56.0
> 
