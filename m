Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32C4973A3;
	Fri, 18 Sep 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714951; cv=none; b=TKcIEJfK8U3UX+UH3gjin7T/R2YHigS3SPGcJxORrN0TtCHGzWgg2+i9HhEIKkB6/raz1DOGRpyTnf3xjIxt7Hj++TuL/DvizFu96ocM7cKPz5xn+fo4fmU7P0Su3rHbvaSEmJ9w83Aj/VgxeHbYj0MqYFT61YC7EOLlReBQsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714951; c=relaxed/simple;
	bh=Ab57gbCozA0XCg2TAtvkerpNt0WPhCOtEoULJllt0vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb/YfMasG/xawy4ITjnX06sl6tHyQt+5UYz6sh4MiVUjFSCn8+vcQLYngHFqOyTHHsWPIUVzPd1bnvzaaNrltU24GIVNRdm8hg+stl6YXj08m5h+NC8KDjyLVsCAeHmDLGHt5ntzXi8lXmQl1lVaV8MsY28CVcRvVx795nX17kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pp5sQcEh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pp5sQcEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789714948; x=1821250948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ab57gbCozA0XCg2TAtvkerpNt0WPhCOtEoULJllt0vQ=;
  b=Pp5sQcEhe85EuDpWmtWebefWXYMVID4GmAmlmYk4IwKbatJBxZedrNpO
   GOWWVan37bwo2jnDWAX/2Lga96WmLFjnFUnsvdgsUnusxbeyZBHm2LaCx
   MeKkVplrT8goUM+OXTQGRrrwNlB20M41GIoRgVb+ZSNSHEzccjYrsrQRV
   bqulF4j0bvuQBNdpWoPMaR16a/KR+5IPP+x3Tm7qyaSKSWvwuaY2VV8mL
   usdrK2mqCGHkBYv4/20Rjv5VvkSsP1kwHhioOAM46GS6uVJUYjnpUQY+j
   +6UvUNkTk1VIqz1poRuP4IK96eAEAGsxp0VrgIehWOvBHS/7NszOyUIUz
   Q==;
X-CSE-ConnectionGUID: 1ALbxmxCSlaa9fMq+EzMLQ==
X-CSE-MsgGUID: g1tNhm4tSRqJekUMlbN0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89336567"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89336567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:02:23 -0700
X-CSE-ConnectionGUID: bJAezRZrSSiXc334p5QXXw==
X-CSE-MsgGUID: iOs0djwWSw64jUA+bjHBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271582529"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:02:19 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Knitza <manuel.knitza@googlemail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Do not hide the option in the ancillary menu
Date: Fri, 18 Sep 2026 15:01:49 +0800
Message-ID: <20260918070149.688376-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aqvTlNnMw4FRqom_@kekkonen.localdomain>
References: <aqvTlNnMw4FRqom_@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 17, 2026 at 02:48:36PM +0300, Sakari Ailus wrote:
> I'll post a patch for this.

Sounds good, I'll drop this one. Thanks.
