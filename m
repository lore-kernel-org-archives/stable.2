Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276377;
	b=0VBFcfjdK59hxSlqCh4C18kvJScR6mxi1jHvm0e7uabFVGLlrJN/QDTvVg03Ji0puhSV
	 6JLmYzOzp1uQoAcDjA2xJjeNULK4mEux3CCmSW8DQGxQ2ifIDhm/umW7lom7bOJjFJ7Ka
	 CcbyCK7i/fAUC9DDt9hF+eyl5atSpQ7YAm/V75+/jWYg/JcLjqZsl3SPY1tH2xrVpYAHy
	 TE4mYlNgeSiBrsl53orGhLqksPn46D/y9bqHlt6858+fJYXabCPkeRvXK6rNu5Z1Lr20p
	 wlJWCW3EUKg7KoxdR4kXcbbIX8qXyuHx0LSdRVEOYwtglIFe99LzJxWMpR9u24MMXIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=v0+bmrVch8O7udOcj7LFp4OXX4/kMfKbl8H3cpVT56A=;
	b=XqhVTjNyczly0Hk8zy9hCy51Sj+WukgC/Vgn3YJjr5xliQIAD0MM4MS9s7zgsJuwLbRo
	 PlfpnrVNNJK7ieHo3RoNqDR22oQaJHIyLcM7+orYRVKNQMSugnTcywOntiIaEtFR90kXa
	 GzgUZWb7V2PqLAshMtkhfnORM52POxYaZ+EJukCj4wa/HYMgMxgBkU0gBRjJRBzYyDE3L
	 ie40GZQaOyjDJs+CtrWbefKMnx9yn2lPi+2w7wM88hjnvrd6GWmxRfhpKHyYXYWNdha9Z
	 Z7OcO+BV6BosaWdB6G0zIzLEvkZm74F2r8r9Q3hJKrMIJXkgY9/XT/pjG/RMPPkIPtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=g2rA34cP;
	arc=none smtp.remote-ip=212.77.101.9
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FD606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=g2rA34cP
Received: (wp-smtpd smtp.wp.pl 30609 invoked from network); 29 Oct 2026 13:19:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1793276372; bh=v0+bmrVch8O7udOcj7LFp4OXX4/kMfKbl8H3cpVT56A=;
          h=From:To:Cc:Subject;
          b=g2rA34cPx7L+7P0Mm8FCBOsYVWTIjw6+YpDTw455JmRtL0PDHXxsM7XOjJQ1l1eyI
           bcTs2Q+eTjI3FNDKqE0qq6mhBCkQG3z9sX96esEZTZVT+rRcgzVHFJa97c65bseCi3
           GA2xAsoxoJ5dMKUyOOPn2URgBIj7i4RspHDHlV9NkLohTjdS+xgAQQbHKXS2dQC38r
           1IUXJzR2EFGFAIU4Pq06T44IXPQJ2pD/tLArSqG+0WHov1MSyCt9KYgU0bck5Z4p7q
           szra+va4AxbHFR6quVt2xQuY1bDt7w6uWBELjRwtk3+Wtq1oW71Qck/N6qf351K7ry
           AyMexwlI3yB1w==
Received: from localhost (77-236-11-144.static.play.pl [77.236.11.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <enderaoelyther@gmail.com>; 29 Oct 2026 13:19:32 +0100
Date: Thu, 29 Oct 2026 13:19:31 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Wey-Yi Guy <wey-yi.w.guy@intel.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: iwlegacy: unregister the LED if 3945
 hardware registration fails
Message-ID: <20261029121931.GB10212@wp.pl>
References: <20261029094741.21162-2-enderaoelyther@gmail.com>
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
In-Reply-To: <20261029094741.21162-2-enderaoelyther@gmail.com>
X-WP-MailID: 23fd474200074c378667d66de8555aa4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [QQLh]                               

On Thu, Oct 29, 2026 at 05:47:42PM +0800, Zhao Li wrote:
> If ieee80211_register_hw() fails during 3945 probe, the LED class device
> stays registered after probe frees the il_priv that embeds it. The next
> LED trigger registration, or a write to the LED's sysfs brightness file,
> then uses freed memory.
> 
> il3945_setup_mac() registers the LED before the mac80211 hardware, and
> il3945_pci_probe() unwinds a registration failure without calling
> il_leds_exit(). 4965 already performs this cleanup: when
> il4965_mac_setup_register() fails, il4965_ucode_callback() calls
> device_release_driver(), and il4965_pci_remove() then calls
> il_leds_exit().
> 
> Unregister the 3945 LED before unwinding a failed hardware registration.
> 
> LLM assistance was used to find the bug and review.
> 
> Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
> Changes in v2:
> - Explain how 4965 already performs this cleanup (Stanislaw)
> - Describe the use-after-free concretely
> - No code change
> 
> v1: https://lore.kernel.org/r/20261028142328.18560-1-enderaoelyther@gmail.com
> 
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
