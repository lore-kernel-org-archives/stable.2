Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE33A9DB6;
	Thu,  3 Sep 2026 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438214; cv=none; b=DSiXa6FntpJOZS1Qvx4ycVnN/4QZB4zayVbnFAJpryQJmzCvuA3kAWkak7BLm/ZZP6hZPM+AAxJkS74dRfJVnztQuqcMp5I1ElsNrcTdRNA+6FcoYOc2CIJgub9/iMni+Wtq1lAvsmwegk+bz2iE1qf+ZzNpcjbWsgs9vpMEzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438214; c=relaxed/simple;
	bh=fa7mr0JgBCTsBNiE2UJg5LEhQvwoX9nYhI8o/eXsOMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZX51gF0TqFEFfRNfTpErPjRLutuQJ2c3JJPEvRGY+OfEehMGRHWDdYP+TZuTrNaIF2lWjiswDEi0nN9cIJMWxISFdajTmE5jqg5kvdKjorZawEKtUy51rfO+D/7kyMK4RjWYB/Q8YwDBO7PdPjBM4TMxeQblZn1z1lAYRmT7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsj3/z8d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsj3/z8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788438211; x=1819974211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fa7mr0JgBCTsBNiE2UJg5LEhQvwoX9nYhI8o/eXsOMA=;
  b=nsj3/z8d1ljNgpKLu9dosQ1vZsi900Tq5tniDInd/oMpkyWVRw/c3GJe
   zBDLAwlVX7349WQ3d/zQHs4pmktV1oKoACEVjEXrR7xYLhi5r5C+p4Y3N
   V69knRoBJ+oimFhmo+KVhvzV/7bDevzXDKHxyM3PA7LoIq4sOTO3nj1EH
   j2t13cCL4C4tsSW/lfBITcqVd5KwVcXmaOmBYsYGjHNnXY20ms2rm7i/i
   I0phiBM4RQrcrby4TgM8Iva5UokxyAs+xC9RR61hnyz2GF3INoN1ory9R
   gmt804r4Bqf8/fvY10TlzUyDQdSVmyUHpVFNNXWy3okNx2BxwHbd+X4Bn
   w==;
X-CSE-ConnectionGUID: gPMj/TFZQfm0/tuEpNN2Iw==
X-CSE-MsgGUID: 0Kaln6nsSRmA6OUYD/LFWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88795277"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88795277"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 05:23:29 -0700
X-CSE-ConnectionGUID: OCpIJUL/QlezOpELQzbK3g==
X-CSE-MsgGUID: muxzlfsnREqo7PioYGTnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294581335"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90]) ([10.245.244.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 05:23:26 -0700
Message-ID: <6813d58b-a939-4ac2-81a4-438781485899@linux.intel.com>
Date: Thu, 3 Sep 2026 15:23:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] usb: hub: use shorter 120ms post resume hold for SS
 root hubs
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 greg@kroah.com, stern@rowland.harvard.edu
References: <20260903112903.542719-1-lovekeshsolanki00@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260903112903.542719-1-lovekeshsolanki00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 14:29, Lovekesh Solanki wrote:
> Holding a USB3 hub PM runtime reference for 200ms at hub resume triggers
> an AMD platform issue.  Users running Android adb report crashes after
> adb has been polling and waking up the USB subsystem once a second for
> some time.  Vendors are working on a solution.  Disabling USB runtime PM
> is one way to prevent this issue, but it is also proven that reducing the
> hold time to 120ms in resume also mitigates it.  See Link for more
> details.
> 
> Reducing the hold time to 120ms for the USB3 roothub is in itself a valid
> change and optimization, as the current 200ms is excessive: a root hub
> has no upstream suspended hub whose wake propagation needs to be
> accounted for, but still need some time for USB3 link training to
> complete.
> 
> Keep the 200ms hold for external hubs that commit 8f5b7e2bec1c
> ("usb: hub: fix detection of high tier USB3 devices behind suspended
> hubs") is intended for.
> 
> Reported-by: Mathieu Fluhr <mathieu.fluhr@gmail.com>
> Link: https://lore.kernel.org/all/CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Fixes: 8f5b7e2bec1c ("usb: hub: fix detection of high tier USB3 devices behind suspended hubs")
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

