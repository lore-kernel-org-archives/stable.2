Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B883EFFD7;
	Tue,  4 Aug 2026 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822959; cv=none; b=SAr9Menwnl5M8A/lV1+5eL1lkagJawIGs78EyW2AIjpPJLw/nBKbJY8W1Chl+uzCnh88EnSmRW4/8ZcU24chRHh3wJ5jzkVJrjKZpbwozib7k2m3GzR3COJzRHcUI5CcZO6s7p+T1CvXwK7t53q9n49rXkXv/HzQ73R9ZySYUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822959; c=relaxed/simple;
	bh=QvJUlP8r3XvbSMBXBaZvFAlByS+JuSmIUaDWLwDyQOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBwrZiYfh5pxqLvgHKhgDKEaPO2jvWnePAAOix6NjjNEk1OE83myfgNIQIe7by7Ql190Mtse6PkT/Ibj01a+5Uy8lcb7ohD3XHQfN6hGXf8s1BPueZOLElgkeiULFkTcpC8x0E2Tg5m8ADwwRXRN6fVIQYGSN7KY8Zpe/wurSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=dn5DZ4H9; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="dn5DZ4H9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1785822958; x=1817358958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QvJUlP8r3XvbSMBXBaZvFAlByS+JuSmIUaDWLwDyQOc=;
  b=dn5DZ4H94hah7rlvdIvwyQIvlQsPzEhLyCuk7nJ472TxKQ9tnrHRFiIT
   t0kJz8pScM1uu5TtY1DGseYJxw1Eg2wTUNbS5I+YX6SAseMu5pHrCoOBS
   3RXNvXKl2g8T73mpFXWgfI6o+MscGI4nVOZWy6ZmktjXJeGWJTiDihYOL
   Q=;
X-CSE-ConnectionGUID: ka7EmkByROeTgyrI7Tc61Q==
X-CSE-MsgGUID: 6s7yvq0bS3CLKpCJR/iu4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103364718"
X-IronPort-AV: E=Sophos;i="6.25,203,1779141600"; 
   d="scan'208";a="103364718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 07:55:55 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 07:55:54 +0200
Received: from ISCN5CG54722ST.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 07:55:53 +0200
Date: Tue, 4 Aug 2026 05:55:46 +0000
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Bogdan Nicolae <bogdan.nicolae@gmail.com>
CC: Arend van Spriel <arend.vanspriel@broadcom.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH v3] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Message-ID: <iy4xilhiwzkjuzuxy7jnagyix7b52s4fgd72tyav2rfxdlgcmt@4m4snobsb44s>
References: <20260804044708.402133-1-bogdan.nicolae@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804044708.402133-1-bogdan.nicolae@gmail.com>
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

On 08/03, Bogdan Nicolae wrote:
> Zero out auth_status on initialization. Otherwise, garbage will
> leak from the stack to the firmware (when ssid is less than 32 bytes
> and/or when params->pmkid is set). Then, pass the params->pmkid to the
> firmware (without it, the firmware caches a garbage PMKID on successful
> authentication and denies a subsequent association request that includes
> the PMKID).
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> v3: Added Fixes, Cc: stable, and Acked-by tags
> v2: Split into a separate patch
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> index 873754be5..2c59b5e57 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> @@ -200,7 +200,7 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
>  {
>     struct brcmf_if *ifp;
>     struct brcmf_pub *drvr;
> -       struct brcmf_auth_req_status_le auth_status;
> +       struct brcmf_auth_req_status_le auth_status = {};

Need to fix the alignment here.

>     int ret = 0;
> 
>     brcmf_dbg(TRACE, "Enter\n");
> @@ -208,6 +208,8 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
>     ifp = netdev_priv(dev);
>     drvr = ifp->drvr;
>     if (params->status == WLAN_STATUS_SUCCESS) {
> +               if (params->pmkid)
> +                       memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);

also here.

>         auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
>     } else {
>         bphy_err(drvr, "External authentication failed: status=%d\n",
> --

Patch needs to pass the checkpatch.pl, before it can be submitted for review.

And need to follow these guidelines for linux wireless
https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html

Gokul
