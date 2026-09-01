Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4C3242D8;
	Tue,  1 Sep 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267234; cv=none; b=IV8lqoEh2pQEqCpJ+Fwv0g+fKzD4VjsWZsj1NOwYgVVL8cvCEl+Yfgr93zF5FXLMeQW9ZLWUtqp0rWirhE51cXiGOF1eVoZ8C5qiCGOQI3d/rCYCqDC9nWVbqrG8eX0hR99kOrOUGBYCZqMBssYV75iiwXdQXDRVegZSFJGPYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267234; c=relaxed/simple;
	bh=V6OoRJ67TwzVkYxbJlByopo4R17aC2ff+RAHQ7AIFR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKaVrN4oZc1WD9IH7SbwZQKUOJ3kJhYJTIWmGA9XCeJlJILYYMkHszBmyDVR13l9HhRT4i1u7/IN67PQE+io7o+0NYZyJtFigod59BmsKHJkrF4ge+r3NmhhF3gkPh0aRGhi8IivzASbzN+wZRg+RcIqn6HHX42Z26aRJwyZGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6DluzAe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6DluzAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788267233; x=1819803233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V6OoRJ67TwzVkYxbJlByopo4R17aC2ff+RAHQ7AIFR4=;
  b=E6DluzAekqnbjd9qjhgsPbdVtncDJBeHDiv/nZqkJH7IVFzabbpv0XXq
   Rr6VvCmADD7nAK5DtHFhqYAFfiSd+RUlCfQc9WEP6cnnamrmb5w7FhpcZ
   L6QWK3SZtTjYqAM1YqkqjPHhFb/nJH5NZv+CmKX37zUIeg49gI8s+F+Ug
   E9UDxqpysRKr3Hd2OTw0Ick1rCMQFpKG2/YNSMrnBVfe0rl8KptxtMzkm
   mnT1ME16nHTLq41FL+ty2/rIGCoUXOhz8AjYzjUwHxhgSd6npAoWf5Z3k
   EUW2y8FXHvFO0+RJ+gi5XX9OZQehKxZo8EtUE8b3IyAlefqVPZJWdPhzt
   g==;
X-CSE-ConnectionGUID: hnPjGOTFRSagscQbkoe1Mg==
X-CSE-MsgGUID: 83SQwTS4SQ+VRuSpsUeWIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99854795"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="99854795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 05:53:52 -0700
X-CSE-ConnectionGUID: xQJc9KfmRe+xiGRpwdPSLw==
X-CSE-MsgGUID: bb249ls1TQm2xtjSVSQGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="307306175"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.0]) ([10.245.245.0])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 05:53:50 -0700
Message-ID: <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
Date: Tue, 1 Sep 2026 15:53:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from runtime
 resume
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 22:03, Lovekesh Solanki wrote:
> On auto resume (is_auto_resume), xhci_resume() used to msleep(120)
> when there were suspended USB3 devices and no pending port event,
> to give USB3 devices time to resend their U3 LFPS wake (at 100ms
> intervals) if the first wake signalling failed.
> 
> The hub driver now holds the SS root hub awake for
> USB_SS_ROOT_HUB_U0_WAKE_TIME (120ms) after a resume, which covers that
> same window and lets the pending port event be picked up through the
> normal hub event path. Therefore, this legacy wait in xhci_resume()
> is redundant and can be removed.

I looked into this again and remember now why we didn't remove the msleep(120)
earlier.

If we want the hub driver to keep us awake to detect delayed port activity,
then we need to wake the (root) hub driver in xhci resume.

That means always calling usb_hcd_resume_root_hub() in runtime resume cases where
resume is caused by usb device remote wake. (xHCI PME# in PCI case), even if there
isn't any port activity yet.

We don't currently check if runtime resume is caused by xHC PME# wake in the xhci-pci
driver. Not sure if there's a driver api for it.
Instead we in resume sleep for 120ms if there exists connected and suspended USB3
devices without port activity, and then check again.

This msleep(120) is unnecessary if runtime resume was caused by userspace instead
of usb device initiated wake (seen as PME for PCI hosts)

Probably best to just take Patch 1/1 and look at this xhci resume part separately.

Thanks
Mathias

