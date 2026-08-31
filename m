Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA3357A25
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158080; cv=none; b=B0z9ocbqvr/c4n0Q96QxRUDXoWU42ms+AXHIVA4SRIGNWdm+V8xsNEHRFc/MdfbbGkhdiEbglwHS5GOWgbmMBEj+PFB5IxfD8IH28sN6Wiku1TJZHQvQllD1X/zn1xS6lcOH/BVnn5gb0wrRYaiTH+yXl+um8vGbHmqj678mYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158080; c=relaxed/simple;
	bh=QPtiJQzGldeofVfYRdgZmiDMN9d80s7B3m08r9GFiqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RAUynMgxUcy63P8y6Q8U5gshzEqNLKLDjQWHyqu1S46CvXKEuOyhmI6Bt1haPOyxl2uQ+RpahlaBuuExmUi8wpo1FWeWwtsEuw8N3seZcEsjw/6NNqjhOSU/1LN3NdggolKhBnsYGmDAZ7FBp7S8m/h8tsSDqcKWI8vJjdbQyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHpTYtDt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHpTYtDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788158079; x=1819694079;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QPtiJQzGldeofVfYRdgZmiDMN9d80s7B3m08r9GFiqM=;
  b=kHpTYtDt3tOq1faBMdGPHSbk6g7IzmtQ9qY7IJyN6rXE5Ni5/CJSPFjC
   OUp2bESwMWiduhi5jIDaBsZV6js/2BC9QzvU9cPvfN8UrSzYL5JMMANhs
   QKZIE7ik0n6L+yjGcdxNCxKznkmG6hmG4PIs/nEg7Xntmho4V9q12SJhF
   q1pnYF5Rw/D+RaNbraipuPLmevitLj2ou+J3hdohMOCiU+CxwT0VOYYc0
   O4upswNnTSDuHhtC0eKaGlOxjUZE6tPI7aMGYt7lfJyiK1Ni7cqDaNN02
   E+B2ANcxnAUqJd0sQCce0El/DA+X6L0DatrHbhCTATpv/CP0Ux3VCmf3J
   Q==;
X-CSE-ConnectionGUID: pX5FgONRRFWhg6J/TTzfug==
X-CSE-MsgGUID: 9WGNe6m5QiifUrbw+kJW8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="105930170"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="105930170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:34:38 -0700
X-CSE-ConnectionGUID: 8vniCwflRMyJOUEx7VF+nA==
X-CSE-MsgGUID: TySjLyIgRGqSo7QIrLfYQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="267377594"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:34:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Shuangpeng Bai
 <shuangpeng.kernel@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
In-Reply-To: <apSwfmDiwsuyQT6I@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
 <apSwfmDiwsuyQT6I@zenone.zhora.eu>
Date: Mon, 31 Aug 2026 09:34:32 +0300
Message-ID: <1cabd39167ba04934dadbe0eb36c4adeaa702d4e@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 31 Aug 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
> I'm going to resend the patch so that it can be picked up by our CI.

Nowadays, there's no need to do that. It's possible to request retest in
patchwork.

BR,
Jani.

-- 
Jani Nikula, Intel
