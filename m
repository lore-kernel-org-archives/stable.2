Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B1282F13;
	Mon, 27 Jul 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165596; cv=none; b=r6k46d1joqADKWEW8nXcJCo7uJ8pPmdrL97k5KLgKhpT7w15wYMcX5xmNCpwtSSGb60ORhK9NhJnK4WGEtb8GKQbWTEA6i+W1SVvoWPynV0BqCi757eupvkXg3DQNTN95CySOqTOSwXXAKFIk05aq2OwSkN+Y846TCmGQFLznAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165596; c=relaxed/simple;
	bh=LbyJqPm8RaIXinzsZygdAsF8m0syDf5XT+QpBibBq7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUV0Ai1wh5gCJaPDc/fcJzJl8MzlRRJQFvKZHraatMF/IHWHQ8l1zyXe6/bTsB0H2LJaRGD0knb34tM+TeEIE9CMmpmvbkGMr0r6KZ1HLDv5Dj+4LRYSthoD/Cny8qscUztmMjm4xwcq/0oLCq/cTT3yr/b2ubDvDPPJotDwoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG+z9Uco; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG+z9Uco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785165595; x=1816701595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbyJqPm8RaIXinzsZygdAsF8m0syDf5XT+QpBibBq7Q=;
  b=EG+z9UcoJ3cd8YpLrUng/9R34sPc/n2rxeA9kSZ8c6gTnW4n7DBsnjY8
   PZ7rDgMJgecdq9TEtejslHJnZtYG+LLxkSU4uIvCVPEaldWzLbWUtA+Mn
   aOuGFncJytUfwIUqgv6HaJWcxrSpbBfZq8Y0cKPmO8rfESZTMz5TFyIsy
   cVmyITKHqeK2Saeq8qZuVWBXeuqbdcmySo2zYOGdc0NC8ZUSa3G44apzk
   tZ/JwJBr4hayNcOvOxhN+VgCq/Plp2P7TC2BPeobFDu1nRxHktjFKcqzL
   zshThPGEWkwAZKUuScOzlgvqZfVrRIHv4Xpiq6vgMXzLa18dLVf2ZZM4o
   Q==;
X-CSE-ConnectionGUID: DYmQIg7aS9+YiiMwe8PMRw==
X-CSE-MsgGUID: GfaYlwwMTm+d3I8pBlDEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85925568"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85925568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:19:55 -0700
X-CSE-ConnectionGUID: zdUkAW9SRtKRhz3tdR/Khw==
X-CSE-MsgGUID: D8vdk8NUQuqX9Qdf2jVHXA==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:19:51 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
Date: Mon, 27 Jul 2026 23:18:14 +0800
Message-ID: <20260727151902.214691-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>
References: <20260723014129.1129730-1-junjie.cao@intel.com> <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Thanks for the review!

> Really? Why to stable? Is this a regression of something that
> used to work before? Using RT is fringe IMO.

No -- it is indeed not a regression: the lock has been a plain
spinlock_t since IRQ support landed in 2011, so it never worked on
PREEMPT_RT rather than regressing. I Cc'd stable because current LTS
kernels with PREEMPT_RT hit this sleeping-in-atomic BUG today, like
the two fixes I referenced (286533cb14a3, 90f0109019e6, both Cc'd
stable); Bartosz has since applied it with the tag kept, so I'm happy
to defer to whatever you and he prefer.

Many thanks,
Junjie
