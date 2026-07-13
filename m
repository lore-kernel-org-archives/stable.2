Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507433F4116;
	Mon, 13 Jul 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943569; cv=none; b=ZSpKa7IJ8nFfR970ocIaoLbx3/UMrPXNmiQnyWv1/3tqpg9NeqzjmrF5NXdsC5/igWJx8IO1KGMuzzjSPjWhR6ht+iXAzZli1R5oYJ0TiJX2Opp69pKvDSwBK5gdEXlrDgBQjRSjyBbkEkYcG/fbpLl+3jYMKx7sSCVQ1hjyrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943569; c=relaxed/simple;
	bh=pcKVlxyOm15Z2BIGF1THFUV3ru6W5lx2ct0St2rETNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m63zwfrK6PVYqF7PxqtICvTOyC3DrZ9C8C/BQ2W7KMArHvQVKxgeFxQ7X7XbmcruOOzQx2e+W992SQzzg679o9+BrtZkSoP8z8gIazgHsQNKdKW4GXmG+D6g+zx8wtFyCIPL2m17tdJMf0EPKi/Le9JOwmxbs15h0+NnS9A3iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=p+gFikwC; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="p+gFikwC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1783943566; x=1815479566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcKVlxyOm15Z2BIGF1THFUV3ru6W5lx2ct0St2rETNY=;
  b=p+gFikwCHdC5SbeXn9SqanMiTy2CqX/WJ9V/VW6WmGQds6gc/uykvZa2
   gapPPjOVrEa7TnIRp0EGc0aucBqTKtsvUe7XO/8nMbUGReJ2mLzRfDayb
   NqqLwZjZ6hm8EM/L9LS+O/ZXRCyOBEG8v0xCwjrQsKxJba/yiPphwolJJ
   U=;
X-CSE-ConnectionGUID: EOPx2jo/RvWnT4rZz/snDA==
X-CSE-MsgGUID: eQFU/od+TPaXooHwjBARSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="100701446"
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; 
   d="scan'208";a="100701446"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:51:28 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 13 Jul
 2026 13:51:27 +0200
Received: from ISCN5CG54722ST.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:51:25 +0200
Date: Mon, 13 Jul 2026 11:51:18 +0000
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: LiangCheng Wang <zaq14760@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"Angus Ainslie" <angus@akkea.ca>, Wig Cheng <onlywig@gmail.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Message-ID: <uhwfd77gkvcrs22h5h42x5ujclzrq7ru5wkixguywfej3444w2@ejmn5s2kmapd>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
 <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE827.infineon.com (172.23.29.20)

On 07/13, Arend van Spriel wrote:
> On 13/07/2026 10:50, LiangCheng Wang wrote:
> > The BCM43752 is not reliable with the default 512-byte SDIO function 2
> > block size: on an i.MX8MP board with an AMPAK AP6275S module at
> > SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:
> > 
> >    mmc_submit_one: CMD53 sg block write failed -84
> >    brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> > 
> > Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> > set up the 43752 like the 4373 for the F2 watermark but missed the F2
> > block size, which the 4373 limits to 256 bytes. The vendor driver
> > (bcmdhd) also programs a 256-byte F2 block size for this chip and runs
> > the same hardware without errors.
> > 
> > Group the 43752 with the 4373, matching the F2 watermark handling.
> > With this change a 10-minute bidirectional iperf3 soak completes with
> > zero SDIO errors at ~270 Mbit/s in each direction.
> > 
> > Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> > Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name
> 
> Looks good to me but the stable instruction looks confusion. What do you
> mean. If there is no 43752 support there is no need for this patch, right?

Arend, one year back, from Infineon we had submitted a patch [1] to correct
the vendor ownership of 43752. i.e, SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373 got
replaced with SDIO_DEVICE_ID_BROADCOM_43752. 

So in the older kernel versions like v6.16.x which does not have patch [1],
the 43752 support exists, but with SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752.
So his instruction is to, again replace SDIO_DEVICE_ID_BROADCOM_4373 with
SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 in his patch [2] while cherry-picking
to the older stable trees.

Rather than that, I would suggest to cherry-pick both the patches [1] & [2]
to stable trees, since the new patch [2] is dependent on existing patch [1].

[1] https://lore.kernel.org/linux-wireless/20250724101136.6691-1-gokulkumar.sivakumar@infineon.com/
[2] https://lore.kernel.org/linux-wireless/20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com/

Gokul

> > Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> > ---
> 
