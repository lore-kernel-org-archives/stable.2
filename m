Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649296;
	b=WFsNOEBAevsIblL5Y0qftljF5C6ziDT3whUylLA4+w2kfmg9phK2znIEnhzlrK3nZou0
	 1Jf7UGXe2Ti3jb9QiXL83nqYoH7FyuEsHimCstzBBZmtvpjk+V/z3E+IJM4mYJOyZNajg
	 tSjvatNRy//OlLKvEVBUul66mmc1uEs+M0vJ873mML0OZZFMUHmF8SX+wlwKN990HmCsR
	 WxhME7EeyeFmbyRNh4hvnpqvgz50sO+TTO3suRg+FC5yPERuqUd7BDsU1xpt9oFFVSr+g
	 ZyEjskvx1IVMuGO1EqabZUEAVwHcKLeT3HhUsXvlOfdehuA3u8v8uDAUQOPsM+qpbUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=YZKNPz9PG3QrKLxSqkizeV9QLKpF7n0r7auD7Pqs79w=;
	b=o84gBEy4O/6x/N0rlzodzkg8oEKsfz7QD0RddVTepi2ppK92TqzLJ4j6CQAeqpl/bPes
	 41i3ReRdpCg4WmLmEKtzUCMFADj2O9X27+1A3wdazvB54UJAQr5gvHqwZ5a24yjcVcg+P
	 iTaM1FSjHLGxsIiO5acmaYTp8W17L8H5Yb5+X/aKziWCqD89bxDnS5Sf3V9qx8kJyDGWs
	 UKc2yitUQAZ5cwVCSYPtah9b7XEACQAE4SYxwGzgE9vxPDS2FK0wDHjgsKOZfhMrfDGxO
	 sCnzRIEL4lu8pdx8QwV4Ml3FwXuv4YCgdaXrlGW0jKRznvQJX2PsMbOOsRl7t3yMwpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ElpfnpdH;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D5606A321;
	Wed, 25 Nov 2026 23:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ElpfnpdH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795649296; x=1827185296;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ZoYqhiSJo7Aiz5L1iPTzKO6TEVFUUZQnz1R2hmjXZOU=;
  b=ElpfnpdHc9DJgwc+sC5XPLz8VF+7TR17sL9Os7Eql+JvSHreabNhFHj1
   mkKOzfRb1K3ucfw7yaDgMqnYUCUFKLwFY8ih9SUwXAT3yyUntQM39CnVQ
   H7Zm40Q6L9bfVMIm/sfWEknvpFKhXen9/1IS9hBD1ufGMVuW9glsykK+j
   AlXJ7Z/6fOE3MAo+goF0ZeUqfkD+sBSiW1NI3aIcC1h++04O/TZjb4wDR
   Bx0Etbhc//qCpbyz6tHPwCOaHfahfZUXtqnrY1BOL/2sjq/Wv2ztwA67C
   Qt1pt6xueDyjmkSo2pRBiD8BQR8ze7jTimzSzy5EpB3LV+CL2jELkYrX+
   Q==;
X-CSE-ConnectionGUID: 6EmV7Pr3Tn6H5yTeDK1/0g==
X-CSE-MsgGUID: efSV4NDXRsWxd4AnsySR/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4539575"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4539575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:28:16 -0800
X-CSE-ConnectionGUID: ySWwS8pXRKyt5Bv96gY4qQ==
X-CSE-MsgGUID: 9bpLFjIuQeekO9GEdUlceQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11869117"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:28:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
References: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
Subject: Re: [PATCH] platform: arm64: lenovo-thinkpad-t14s: Keep the
 interrupt off while suspended
Message-Id: <179564928768.9828.8032613501238646797.b4-ty@b4>
Date: Thu, 26 Nov 2026 01:28:07 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 18 Nov 2026 17:39:25 +0200, Abel Vesa wrote:

> The interrupt handler reads the event from the EC over I2C. Nothing
> keeps it from running while the system is suspending or resuming, when
> the I2C controller cannot be used.
> 
> On resume the interrupts are enabled again after the noirq phase, while
> runtime PM of the I2C controller stays disabled until its early resume.
> An EC interrupt that is pending by then fails, and so does every further
> one until the controller is back. On the ThinkPad T14s Gen 7 that showed
> up as more than a thousand of these in a few milliseconds when resuming
> from hibernation:
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform: arm64: lenovo-thinkpad-t14s: Keep the interrupt off while suspended
      commit: e5340c0623fb9cd699fbc095c5ef5976286c8134

--
 i.

