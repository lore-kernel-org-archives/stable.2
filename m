Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0F4766B0;
	Thu, 23 Jul 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828543; cv=none; b=rO9A0jXHu//Bxq0ElU83N7OjnD7Ax6CkU/n1ZuwQrOXik5nVUeBq4G0G/97veNRULm9yZu0wYrcIUZ1832k6pTQgvhVmxH7Pt0URqab2pfTfIgE1m/B8cHLtOjGZmLpZa8ji7EgUSrCmREohxvMyyGnSopTkQ+msevXA3ask26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828543; c=relaxed/simple;
	bh=E/2X5bAzh5xpkz+FihuC8kAZZBZOBbrDQ0/VDrS+Kho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqkbdqhMxSeHY4q2oXMGy5Bn+efActq+ArGzjxB94Db81liPY//+cNuK8DSJo1ztWQSw22FJmly/+MQYxSVCnCqkT/5vGMSXaws1zbc2ZZmgPnwwW5RflUxNkrfMutwpPG4qKnvUhTePvNpMcpwhXVlrNB/xC0XiSZICS0zOI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=b/JtcHny; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="b/JtcHny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784828540; x=1816364540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpoNptoA6QkO+QN/J109Z8DEprciX1W9uKSFsi8gD0Q=;
  b=b/JtcHnyysImEgoZHM7GtYmVsmKoThlF2amv/DOOfEV4Hc9dmiliRUuv
   q6xYk/8PRlTpDopqAQCvhT3LkIhsBRuta7+S9+9Mk8CmG5jNRAIc+U4Xa
   WXL0P1jqKVrzElu0/BhaYOMP/9doMcHSpPYkJlg5fVW+cVL5C+6t5vDOL
   xctOjrwe5cAUbaKPjNWbbx5zvadHZJLNgqvBbt1XMbV0Sjn90f5y/XkUr
   CnDZXHg+2N3fnZRpFr9oSBXX7UD7/16tWhBreZyPFmF0/nhWYOoMiU8Qy
   7wb37MZ5YqOHxwUCgIqafmIRN13sqozRWKBJX2xqTR/4+gv4LQV62WPXB
   A==;
X-CSE-ConnectionGUID: CXfL5PeXRhaNaJSh+lYCmg==
X-CSE-MsgGUID: BtEyvpegThG8QMPPnuoscw==
X-IronPort-AV: E=Sophos;i="6.25,180,1779148800"; 
   d="scan'208";a="24119645"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:42:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:9725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id 71c689cc-b71b-4774-8f0b-e90749cc4b35; Thu, 23 Jul 2026 17:42:15 +0000 (UTC)
X-Farcaster-Flow-ID: 71c689cc-b71b-4774-8f0b-e90749cc4b35
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:42:14 +0000
Received: from localhost (10.187.171.39) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:42:14 +0000
Date: Thu, 23 Jul 2026 10:42:13 -0700
From: Cory Keitz <ckeitz@amazon.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
	<linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] media: qcom: camss: Add "gcc_axi_hf" to 8775p VFE
 lite clock lists
Message-ID: <amJPH7TMiMP79mIe@bcd074ae11bb>
References: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Jul 23, 2026 at 01:09:50PM +0200, Hans de Goede wrote:
> The "gcc_axi_hf" clock is correctly listed in the clock list of the
> 8775p 2 main VFE-s, but it is missing from all the VFE-lite clock lists,
> causing these to not work on platforms where the firmware allows turning
> off "gcc_axi_hf".
> 
> Add the missing "gcc_axi_hf" to fix the VFE-lite blocks not working on
> these platforms.

Tested-by: Cory Keitz <ckeitz@amazon.com>
