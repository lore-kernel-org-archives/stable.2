Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C434E777;
	Thu,  3 Sep 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421374; cv=none; b=t/hpdgmTA70eS6tnxrXfSMlT4MTY+3MvbYkmvYTlqayhh/93zaMqnT834HdCUIeK9d0ZV7QYS5OBExwHApKmsDcnzBeD49Hr554DSRoBKsBkIyjM5fXNmk0rRmWLevirv2VhziWcoUfqG281TBGXpuzj7yjr0UBGNSb1Xct+YHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421374; c=relaxed/simple;
	bh=FG3MtrmdgQ7a4c1CKUCYR20sKlxyOJddAEaTVpOvgJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdGCvsk4lvuVEB53j32F23b8PeGFqYgaG+p1WDlcVrnY/pdqQjBlfscUunyGgp1OSkBfUJhPs6H8RdY5lVyfI5dj3AvO+hXO7Ix21MQ02N2YAAktI2hXXluJNRBk6Fs5uI6EyKpZ7yXtJbXdP20uYEUaouG2mKxZEvMlsCzKmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnRY4YvY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnRY4YvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788421373; x=1819957373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FG3MtrmdgQ7a4c1CKUCYR20sKlxyOJddAEaTVpOvgJE=;
  b=YnRY4YvY4sp7ajkn/aLj0jpe1jF1by2EM21czkcGe2Fu+c5X7CF16snP
   0dx/2QAO9aDA0un8msgB5SzHX2FRk3+viNuXDqorhUpAsAvsk9NV0f5p0
   uoo+0o5ZeB/p6ZNWsryPmdRXonDvD1qcBIqGqRjp9mAyzJKcwIeE2hTpa
   ZXnkkUvozlRXpxgGjhQrDJmLuImhCQCeIo2bzgNuyD50aGtMK2DuDJpMj
   /YBS+l6ucF7pZ1IUaBf4RV7QBJ7fSPvhKkwN5HTTMC8/cTujKMnC336AZ
   XGNOArVPPMuHkvbEwVdDL1/osH+lRT6DUEpDLB+IN4dpjdUuFsxkAcVBP
   Q==;
X-CSE-ConnectionGUID: TnXuGnvXTy6NRSQNW9dwVQ==
X-CSE-MsgGUID: k3w6ifpdSh++en65AWtziA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92763250"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92763250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:42:53 -0700
X-CSE-ConnectionGUID: FP8+91CrTB+BaT1IR2FPZg==
X-CSE-MsgGUID: tkY+JHxgQe6KuP4SgZD5/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273798426"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90]) ([10.245.244.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:42:51 -0700
Message-ID: <082467bf-d045-45d7-b097-97a5790e79d6@linux.intel.com>
Date: Thu, 3 Sep 2026 10:42:48 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from runtime
 resume
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
 <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
 <apbrp8EaJoIfEg5X@eggarch>
 <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>
 <apg16LtZ-ru9MIBQ@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <apg16LtZ-ru9MIBQ@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 21:21, Lovekesh Solanki wrote:
> On Wed, Sep 02, 2026 at 03:10:41PM +0300, Mathias Nyman wrote:
>> It's possible PCI side or pm core already provides some easy way for xhci driver to check this.
>> This specific issue is currently not on my todo list, yet.
> Alright, would you like to me to work on this? I could look into
> that side and possibly come up with an approach.

Yes, please, that would be great.

Thanks
Mathias


