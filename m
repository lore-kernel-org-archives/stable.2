Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846B4EC659
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623420; cv=none; b=sIBgAfDqvuXIRyNbvtHM52k7HyNGBJtanJ+nsLXmUvn46Vf9Z9oTAtIL+b5YC8g8ukmTByRlWiJ3DC9e7NtS2AQBKNwTalsMNFEde/y7dV++KfaY8EEZoasjZlGJ8yPBYDez3l/hr0ia7oi0ffhmP1HPwoiqC1d+dZVtuytKc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623420; c=relaxed/simple;
	bh=Gg6LEuIxaWE+7cRK2yBBmz2ArAP14aPOU/p2x3Q6Pkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePlSTbus2ZF44y7DHyV4MCicyQKqK3gYiME3GN09sNA3EcMJ6uN+rgxb5eQFPy+OO6WsbA1Nnnktisvkz5Iy8zXbWhNVRu2q24+juv1aJXbs5G/jeVa622KIhff8CTb4XpYjVQ9lFRHRtfTZJrRhR5npWGi8bs/rzRFr3iy+NcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnhWRVz7; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnhWRVz7"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so1938137eec.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623418; x=1791228218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
        b=JnhWRVz75vxTVY9ngbOszYowBWNCUCeKKOvEBbPinhyOWTnjySsE49B4rUyRQ5B3eA
         6g7l8kw0oI+LBDWf6fqfNBhizj5RWFwopP1mGKEiBN9XKLUv47oE4sFv2dL/ivFrqESy
         FexaImx2SmDvj4FRnIObb5W2//0bZ2BptOiilEWRMi3m0HUQ7NaT0jpTW72H7pSzEnPx
         ie17y0hRhQXMe3lvWWnz5g0rd8Z31JCfRiX4/hRQAxWmylvAqTH0jqq4ySRF6JC9DzqV
         DPznoFGca9sS1hs9xUbna5kAEsxM3ZXsRNnrscupmVcxgsuJUIUH8iR8IF6sOpJ2/6kc
         f3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623418; x=1791228218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
        b=XX4ZNg6OCylaRRZBlbFM767RGc3BBnJF+Tu8GkggaSjGVIzIs0mTsEWmyPinRYVRNf
         oFJLic7Qq8zdgCzafSmVujIHhUxcQ8T6f7xgRTPZOvOFe28IqCGN9LMnnRFxrfyci4LR
         ePdDubPdgoRrKPtJGXz7hGxnq1kU1DSh14XVETJwiV6TxwFzfnN/JA/bHEctuyR3bpb+
         0ihvC5nPGuH0AdPyejpIIFeIeCBFYwPrjEwL6rKklGNB4tAxSgYvBxW9K2nroL6/0Esg
         S+pBLKdJJhSKSkw5Ote/xEk4sb7ItScEDhnObeoxPcdXbawhHDQ3A7tLhHDnT5U/gpuc
         rDcA==
X-Forwarded-Encrypted: i=1; AKwUvBya4qJozEV5E4q1LYNWqSPXST0Zixm11jnKyOABZhnQY+2m6EYKbE49E5qG+Y2HVgtWEYJljO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2FuPipwAGdcAwR+bOJ5nicGxTfpxTfcv0ipXKTWjV+jDoXEl1
	jsya9J1kyQaCB8qOHJ5q99OUb12BU9xdurQbIUNvAvjW9WfbPkgdIbGc
X-Gm-Gg: AYBFou1h5I0u4guygnQfgREWGkRh0j/sENFTk1oBsxAkJhiqBa4r/no07EhxTIqjzax
	vp6TEajFLR6WI4Je216k1e7rddKuuzYQpJ+PfTasAIVUBd3/uxxKrWGGJ885qHvbnoFIt9zm3OB
	4jF4qUFtaelTawwhXhPwqsOc9WMnIm3IebFJ+17ELuXGg3SqriZ8SFb5XRj2CZfTCm0RTDkW/qK
	697hLwlw5HS/yY/vbDAS8ix3qx6Taf/cC07EXCrPTas924raDp6yXT2V3CXZWSwoqDBCM+CiMLp
	wi19QhdWCOM8yMLPInTmKolcon6LT1lwyKv/PZu19Cw4Lau5qr3cmDxQIO8zt0Mlwv6rxEKLXYI
	BZmBLaJpejlSxYJdsQHhiFSjOWlkNNg4M/tOci5C4iE2a7PsbiOUzdG5HkdPhmdxtGV5VDgqj5J
	4oXiOe6jxzhGogQuBAlg0StN7t2os2p7OLuO1TCEbEw/Hhbb7MzYTsJcZ5W292foDBppWsM05KL
	dFDnXAUJRE=
X-Received: by 2002:a05:7301:1f15:b0:33b:5b1b:134c with SMTP id 5a478bee46e88-3427344e560mr15142029eec.38.1790623416429;
        Mon, 28 Sep 2026 12:23:36 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm48477679eec.9.2026.09.28.12.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 12:23:35 -0700 (PDT)
Message-ID: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
Date: Mon, 28 Sep 2026 15:23:33 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] e1000e: restore jumbo config after DMoff exit
To: "Craig I. Hagan" <hagan@amazon.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fabio Sabai <sabfabio@amazon.com>
References: <20260923235832.473-1-hagan@amazon.com>
 <20260928170234.21877-1-hagan@amazon.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260928170234.21877-1-hagan@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 13:02, Craig I. Hagan wrote:
> On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
> switch reboot) the interface can come back up unable to pass traffic until
> it is manually reset. Observed on I219-LM (8086:15b7) at MTU 9000.
> 
> When the MAC exits the DMoff state on link-up, the watchdog resets only
> the PHY. A bare PHY reset does not re-run the jumbo-frame workaround
> (e1000_lv_jumbo_workaround_ich8lan), so the jumbo configuration is left
> unapplied and traffic stalls. This was seen with NIC runtime PM disabled;
> if runtime PM were enabled, the device should go through a full reset on
> resume, avoiding this issue.
> 
> Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset when
> the MAC exits DMoff, so the normal reset path re-applies the jumbo-frame
> configuration.
> 
> Fixes: 2e7256f12cdb ("e1000e: Check the PCIm state")

Wasn't this bug introduced in def4ec6dce39 ? The more recent commit seems
like it just adds a pre-condition for the DMoff workaround. Tagging that
commit could cause stable to miss backport to 5.10.

Otherwise:

Reviewed-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Matt Vollrath <tactii@gmail.com>

> Cc: stable@vger.kernel.org
> Reported-by: Fabio Sabai <sabfabio@amazon.com>
> Closes: https://github.com/systemd/systemd/issues/25925
> Suggested-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
> ---
> v2: Rework per review. Instead of the fc-latch autoneg-restart
>      approach, request a full reset on DMoff exit so the jumbo-frame
>      workaround is re-applied (root cause identified by Matt Vollrath).
>      Drop the diagnostic e_info. v1:
>      https://lore.kernel.org/netdev/20260923235832.473-1-hagan@amazon.com/
> 
>   drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab3..df7da86a8 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct work_struct *work)
>   					usleep_range(10000, 20000);
>   					pcim_state = er32(STATUS);
>   
> -					/* Checking if MAC exited DMoff state */
> -					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
> -						e1000_phy_hw_reset(&adapter->hw);
> +					/* MAC exited DMoff; do a full reset. */
> +					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
> +						adapter->flags |= FLAG_RESTART_NOW;
> +						goto link_up;
> +					}
>   				}
>   			}
>   

