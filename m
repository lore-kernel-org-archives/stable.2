Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118420;
	b=T5EMBKOW/GxQFi03V1/3I3XDx/Vej+Yf2qBD59EvqT4x1Xx0WETOLnEpG6OvoVoTpVxX
	 jiLSbSeWffrbEs9/P+goKSX7403Nhlb1NW6rHy/lWl5kLSwN6OTCjlsgfGuGq/gUMpzJm
	 s+14/p9xdRWiB4+2ZAraEr2SVksaexdsG88Ymffo8BaApJw29OLn/wVDUbOqCEyK+d6mt
	 F+q87OmKNCirkgfZww+JJx710lxcYteVzfs1c8b5/rKamnAPmkTkvhHipX8k4HNuTsncx
	 g1DEH0GpvyicztUqXOM1+VXtbG2DVa781RFW3ZniPjewTFQaoUfC9iTRJuXIgSquTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118420;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=OPQ5C9ox5OYC3Jbm97wqjDiE2BuBCI1oIX36fmfA+js=;
	b=bEEqVX0g/Touwq/mfyXdWlMOn0P98X0Dy1sY22RFXZ6FhNiceTe4ipMwbbESXGCF0ZMl
	 N4ePiQTNfe+zWUeccuMuLIXi0bkXDaOBeo4Enix3Cw4Mw1CMHN/koenGHB2nXvxPR6Lkx
	 1SG3ZAUILBCoQwKjqwPKCNZ/ZdS2/u9Xa9KUtohLoRPdgcUPIp9mGy7mgIW9X8/MY+6U3
	 ITUjZJy10DjJxKEN2GWP7VhxAoeCsk2fP0RPyXLn2ZPMJTFDnJGoD5rpOlLSHZD9ng1Ma
	 vQwsWPVv6VxYlgUABp95RP8ZgZe9O53Oedyb920n1VGrOi6VNpmD0FKqyZM3DQcmPYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=DjCTSvW2;
	arc=none smtp.remote-ip=212.77.101.11
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B9606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=DjCTSvW2
Received: (wp-smtpd smtp.wp.pl 18763 invoked from network); 27 Oct 2026 17:26:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1793118409; bh=OPQ5C9ox5OYC3Jbm97wqjDiE2BuBCI1oIX36fmfA+js=;
          h=From:To:Cc:Subject;
          b=DjCTSvW2JrntDI2UY8hFy7i/9e+mMPSImsFADNGFApLWLxtCV0nAbIK98ffUMxoOH
           zKRa/QeqVDip6BqMrWiL9uBOKFaBn/tEEf0qhgjK6OvZSKPoo6jcflSlF3bBLTtNhF
           sjmRMNpAj+kOAVgUBsD4HqWH3lVVQjMGlG9NJ0cvWCDkSbJwoFA7KCn189tzsjI92v
           QqHYmKCmM2SPoW5fDJN3LQBj/8ulM8g5+EeEuFQ2uKS+6ZOYFPA/cLt4rYsGfwj2Wz
           +XNKRlqiaf17gJ8DzAQZhfs6VP5dR2gc4DwdChfBwGmfvN02qxy8Ybr6RJUw+yOKTq
           LLbh3ZbgCSssg==
Received: from localhost (77-236-11-144.static.play.pl [77.236.11.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <tristmd@gmail.com>; 27 Oct 2026 17:26:49 +0100
Date: Tue, 27 Oct 2026 17:26:48 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: Re: [PATCH v2 wireless 2/3] wifi: rt2x00: replace open-coded IE
 search with cfg80211_find_ie()
Message-ID: <20261027162648.GA4623@wp.pl>
References: <20261026223213.2091616-1-tristan@talencesecurity.com>
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
In-Reply-To: <20261026223213.2091616-1-tristan@talencesecurity.com>
X-WP-MailID: 5c6b4989cf0c7d2f1b05553d339c93bd
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [0RJh]                               

On Mon, Oct 26, 2026 at 10:32:13PM +0000, Tristan Madani wrote:
> rt2x00lib_find_ie() open-codes the IE search that cfg80211_find_ie()
> already provides.  Replace the hand-rolled function with
> cfg80211_find_ie() at the single call site.
> 
> Fixes: 1c0bcf89d85cc ("rt2x00: Add autowake support for USB hardware")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 30 +++++--------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> index 4d94b7062f440..921383a630bf2 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> @@ -557,26 +557,6 @@ void rt2x00lib_txdone_noinfo(struct queue_entry *entry, u32 status)
>  }
>  EXPORT_SYMBOL_GPL(rt2x00lib_txdone_noinfo);
>  
> -static u8 *rt2x00lib_find_ie(u8 *data, unsigned int len, u8 ie)
> -{
> -	struct ieee80211_mgmt *mgmt = (void *)data;
> -	u8 *pos, *end;
> -
> -	pos = (u8 *)mgmt->u.beacon.variable;
> -	end = data + len;
> -	while (pos < end) {
> -		if (pos + 2 + pos[1] > end)
> -			return NULL;
> -
> -		if (pos[0] == ie)
> -			return pos;
> -
> -		pos += 2 + pos[1];
> -	}
> -
> -	return NULL;
> -}
> -
>  static void rt2x00lib_sleep(struct work_struct *work)
>  {
>  	struct rt2x00_dev *rt2x00dev =
> @@ -642,9 +622,10 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
>  				      struct sk_buff *skb,
>  				      struct rxdone_entry_desc *rxdesc)
>  {
> -	struct ieee80211_hdr *hdr = (void *) skb->data;
> +	struct ieee80211_hdr *hdr = (void *)skb->data;
> +	struct ieee80211_mgmt *mgmt = (void *)skb->data;
>  	struct ieee80211_tim_ie *tim_ie;
> -	u8 *tim;
> +	const u8 *tim;
>  	u8 tim_len;
>  	bool cam;
>  
> @@ -666,7 +647,10 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
>  
>  	rt2x00dev->last_beacon = jiffies;
>  
> -	tim = rt2x00lib_find_ie(skb->data, skb->len - FCS_LEN, WLAN_EID_TIM);
> +	tim = cfg80211_find_ie(WLAN_EID_TIM, mgmt->u.beacon.variable,
> +			       (skb->len - FCS_LEN) -
> +			       offsetof(struct ieee80211_mgmt,
> +					u.beacon.variable));
>  	if (!tim)
>  		return;
>  
> -- 
> 2.47.3
> 
