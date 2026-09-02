Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E145478E3E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373318; cv=none; b=SgSvAMjYbo/GPlWOc9r/crsmW4/D2XMmbkz7zd/imMl9TVkjky9iDHfLIAgbKYmX0C3wehMRXshYhGaR4VdDHE4kE+7BDsMacGzu8u1MMZ5c16vjcn8obQRz0odkDidChqizy2Jbq6QvLzigTIqfrKlpljH1m5XxEc/qWWqSi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373318; c=relaxed/simple;
	bh=3X+93BwJddB9py4mR0joP3nCeAIwwXvBE0mNLCtpoZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+a3jy6TKOhDefQIA52+Ri39Ax2dnNaislQBAix6Oi/utQ6TGplyTXgVZGM5WnEH66Uk2qy18BeNOS3LQADRtarbwmRTW938MsWwJUN9lT5lhy+QDoPFrElBkFCUyJMAZSIe7256B6YJMGnZBizXpomHgGGiCYRY03rTgbUjjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLN7+Glu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLN7+Glu"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc328b43a56so1055745a12.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373317; x=1788978117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3X+93BwJddB9py4mR0joP3nCeAIwwXvBE0mNLCtpoZs=;
        b=ZLN7+Glu0LAZLx4xENIFnaGDODayMt0YjSdScOghFVRndDk6Vj7Sn/0WNAPXLrGCDt
         x4ZQKdEE5aWnPZQIv6ZZnSM04U9E432L8S0bHCcyf1UkOuwIxwP3iOxnpMlu+6FSUX9y
         187KVISIEdxeVoqRVPR01djwX4RqaCh+CsILqdvTkUpUGWecipSpO/A7ipnoGSOfpyIR
         gUuvUbjATw+A91JfgIvHIQ6xUBPyGQ9+aiFqZl6FITJbahRw3YilZYi8r632wuzBoWo2
         VKSgwddynbUQ76R7qVYw21purvFYvFZRuVq/KmH/zZ2j9eUeUUovotv1FJ55B4y6oldo
         AlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373317; x=1788978117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3X+93BwJddB9py4mR0joP3nCeAIwwXvBE0mNLCtpoZs=;
        b=P0CmmLgsWasQxYi/ikmuKn98sPuXfKDEkj02hKf1iuSs2YxzjRZcdXHeszGhT0bmdQ
         nQvBQs0+FYx/Ym5adRgC/kiFnBngGH+yyHe5yJbb3KXCfDkZK19H4aLinZtFScXA9l0k
         qZBKzfZ7wW/G/xsQwc4JBOb/UXmmxhG69Hr8lPXk+A/X4GqN/Nz522OEPgGjt41gPMEA
         ofh4gXALk9YUJeuUJOZOfDBPSw/NmLE6AjfXqF4U34APvfpFHBc1Am4q7ogOCzhEpcHm
         2+zgHN980JpPx6WrpX6tgm0qSoov6FgImZ916/TowdKmfbBXWYByurjAxvEZM+M0qS4p
         dZhg==
X-Forwarded-Encrypted: i=1; AKwUvBwFBUq3PuBDVQ+bYmPW5IuJmMrUleMF4XCWt0BKReEupNdg4WRFfG/GHa6UfTZNnQgqCVGNwjE=@vger.kernel.org
X-Gm-Message-State: AFuF++mvu0CD1BwSNTmH5hVXdCBoUK2jx99R8hv0OHA9O1YFzlCoPA6w
	5wh8uj1Bvn/Gw0yrXQZQN5/SB166HDxkMfCtrqOZlI1aK0ZAAgHBWazX
X-Gm-Gg: AYBFou1j3x82gXslQ/csqcdhGwdcKEtL+tXg08CRpaCMN/N9N8ZbMI3ly+So3HS2Nms
	Q32lrImWYCnEDz0Ae1wg6Ye/gGaE4aEqn2jdwbWjIMmUe62ETi56BicrtnOl3G4hgPodD5Y8WE8
	JUPZrsoctrKRrsRSGFTu1itVpI2O0Op4in/ZAzUg3AOY4KeC/R+uGJ4uJ3UZkbXthiLP94FBSd3
	4bnLqvxZK63txVKOAvK7kjferO9Pad8wma8d4P6vEhRtH5Z9Vl3jP4iloeW9XjvwnzSeXwfvJgE
	yEcA3DPJQTc/p8JL0kw5+ypocThtMxT1rThnS9PMIYuDFNWIOyGLLSGVQd0eOikQd6amvryK6v7
	bUINsdZnZ4oCxZn/dTHWii3EbPQ5yCqgbH44IeLAVAPhLo0+fj149najsGKRYBaMCYgVKQFtkKO
	6spngwz8gEqyoBYRz5Tao3k6+CI3/s4Hxi1DHpEb3Qi64AjiY1zzmvjBt0AzJXwueaXogUqaswP
	w+yR8S6pMLGFcVjk5LB7fl14wRY2MzgYGyiOA==
X-Received: by 2002:a17:90b:5109:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-39aee152d79mr10767129a91.25.1788373316382;
        Wed, 02 Sep 2026 11:21:56 -0700 (PDT)
Received: from localhost ([2409:40c4:d:5c19:7852:60e7:cc2f:a6de])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f7d77sm8745198eec.12.2026.09.02.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:21:55 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:51:51 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Pecio <michal.pecio@gmail.com>, Mathieu Fluhr <mathieu.fluhr@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from
 runtime resume
Message-ID: <apg16LtZ-ru9MIBQ@eggarch>
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
 <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
 <apbrp8EaJoIfEg5X@eggarch>
 <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>

On Wed, Sep 02, 2026 at 03:10:41PM +0300, Mathias Nyman wrote:
> It's possible PCI side or pm core already provides some easy way for xhci driver to check this.
> This specific issue is currently not on my todo list, yet.
Alright, would you like to me to work on this? I could look into
that side and possibly come up with an approach.

Thanks,
Lovekesh
