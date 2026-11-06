Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983314;
	b=TzRMXtHcAjupS/L3wifofeoO5OSJfCRXHQdAC7vYbEt27jkfY4OvhKJH4qkAOiHcwSEg
	 F0mAVbX2gM5cgBaHCMwSo3GZ9Q7ervJWU3+/zcOc//DCfWKra47XIgIWB3+TMbdQWffwr
	 m/oryG3dfWxUB6vr5rYy+sJZLTqrMi9o2z+9wMTmm2bnaZckr1eaM4zUfSiuOjSfLm/A0
	 x8YTeRP9IGo6HHTC0aoIIn7lYIeClEf4k4QMFPWPUXcuMVmLi+pt1HvaU18A5/lVjzxBd
	 ZRPtF8jzg/SjCtYJxlDDioRMPwkuI/Z91cb2q/BF3c16vTfStR4cwfmNUo8WxLQ99qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983314;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oPspVz2u3sUVQrpVa7QtYannDPmyJMtXsmAP0J0uodo=;
	b=QByB8dmsqOQaBR5eAUTb9pJ4D9YACHVBzZOrmyReMHzvXgg6BGZAiI3KTRm07SFfFnsO
	 Z93rHhkgNnLzHTJ6yJl13XhrIl1e86XePHSSRll+hPMK0M07eOcSlMb8d8N2scLQgHt0P
	 TwppixpU34o+3d6I5y6sxXSsLsCPCyvRtDF3DJXfMnLgfO/4nlh9GQMTOJEWmqX6NqZfW
	 k7FB9BfruWZXVX7hhXlAq0/TZRs8xM02zeB1hGy1EupaeuBj85bfmRxQNtUUyvVpfgKiK
	 0OuAqZlUybJhdDnTmq2nEPNkqmRYkCypJdxVoh3GjnkMKAbB990OQFhCEzMCaN2GRCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRI6UUZs;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF7606A33E;
	Fri,  6 Nov 2026 16:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FDF7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRI6UUZs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793983315; x=1825519315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U41/yhPtOEbm2rdavaCV20VU455lrs9kR6LVwMJnUdQ=;
  b=ZRI6UUZsrpdTJoMofP7J+0iCMTFMKtdzS6ighslr8kSq4IzjVc28mztZ
   N7DGdWVPitaip7flIaPtDtZmITCDmqGoenDkFEzrQhL120ede3qprOy/b
   VbB/134A4Kd0EZGl0kAjGBnwi+1LJpfstXgd1jy7xKW+WR6DN9zfDHdyv
   cHJZkveglHmjM+6tkXTwc12CFdsL2UW0oJr8Kd9y4TGC9YmPVMSp1kDev
   auMVp/3AvG9rnxfqBtYVjvpyEsjJXhOS9LmfCYgb8gm/JrqgycLg9gplM
   +3ESdjTRrJJbQpe/vp+29Osa+gjsbAEM7zyf+XQfrAcuiFnsHbnAVgVvW
   w==;
X-CSE-ConnectionGUID: DVx4N3ZATNiii2beJqzfUg==
X-CSE-MsgGUID: x6mJ02xUQpCNQCFw5fEamw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2669066"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2669066"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:41:54 -0800
X-CSE-ConnectionGUID: AhncTAcSREy/LIg9F9dhYw==
X-CSE-MsgGUID: 3Uc2TKvlSuGnHOjN8ZQ39g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7660259"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2026 08:41:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A09B699; Fri, 06 Nov 2026 17:41:50 +0100 (CET)
Date: Fri, 6 Nov 2026 17:41:50 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com, tvlad744@gmail.com,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Leave the mux to the altmode driver
 for alt mode partners
Message-ID: <au4DThRaGmNzZ0HU@black.igk.intel.com>
References: <20261103135046.1654-1-26rote@gmail.com>
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
In-Reply-To: <20261103135046.1654-1-26rote@gmail.com>

On Tue, Nov 03, 2026 at 10:50:46PM +0900, Joonhoe Kim wrote:
> Commit 25a2bc21c863 ("usb: typec: ucsi: call typec_set_mode on
> non-altmode partner change") set TYPEC_STATE_USB only when the partner
> flags were exactly USB, so that the altmode drivers set up the
> switches, muxes and retimers for alt mode partners. Commit 226ff2e681d0
> ("usb: typec: ucsi: Convert connector specific commands to bitmaps")
> turned that into a test of the USB bit alone, so a partner that
> reports both USB and alt mode now gets TYPEC_STATE_USB as well.
> 
> On pmic_glink platforms the altmode driver programs the same mux chain,
> and the two notifications are not ordered. When the UCSI connector
> change comes last, an FSA4480 switches the SBU lines off, the
> DisplayPort AUX channel stops working and the sink is never detected.
> On the Lenovo Y700 Gen 5 (TB323FU, Kaanapali) this happens when a
> DisplayPort sink is plugged in during system suspend.
> 
> Set TYPEC_STATE_USB only when the partner does not report alt mode.
> USB4 partners keep TYPEC_STATE_USB, as they do now.
> 
> Fixes: 226ff2e681d0 ("usb: typec: ucsi: Convert connector specific commands to bitmaps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 2f9adf4f8bde..395554ba0312 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1356,7 +1356,8 @@ static void ucsi_partner_change(struct ucsi_connector *con)
>  			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
>  			break;
>  		default:
> -			if (UCSI_CONSTAT(con, PARTNER_FLAG_USB))
> +			if (UCSI_CONSTAT(con, PARTNER_FLAG_USB) &&
> +			    !UCSI_CONSTAT(con, PARTNER_FLAG_ALT_MODE))
>  				typec_set_mode(con->port, TYPEC_STATE_USB);
>  		}
>  
> 
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> -- 
> 2.43.0

-- 
heikki
