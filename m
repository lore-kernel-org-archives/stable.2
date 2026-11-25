Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600536;
	b=ckV9LDhem/NVU8yNJ2pqbyoiwNQ2flJcUF53NGA1d27EjnQ+l2aHz8zan40XQwfWC7b6
	 dno4auxe70WnyIacPE/H9WTKTAuC1JNmkkHlaOpvoGbWF8PGUbrz0i8APlnrBSsNQMAJQ
	 Y6pWCnPh1wJQuCgRfSFzPADm+eSE0wsrSyqYnzh5gVUCwejnt+dPuVVpUUljvhRvHqqtp
	 XIeFzkRx0UxghG12Yqzb2fOjLZqnkiHPY/GNJltK65G46XF+kMQVTFiKPfayPyM186ydA
	 4yU/0tmhJnsHvWpUvSg8/qzty7Wt5mFsuofQC0cZhNyWSmQRzIvakLPfzou5D750bmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600536;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZLVlI2NL908Wxdofrqkg/tBLlvC04V0H6Sg0xldxjY8=;
	b=3hMTrN6Kj/Ys2rYUcTJ0rX4ASJ8xqkc3ANb460OcpNrev5ITgsiEq3qZJOImHgbX232J
	 WBN+0J1pz+c2A4rYs28++AY6uR8oqrUMuNbIgr6rq+byr/oGZtQGZ2GRwrtaJMlIs76MD
	 IYvsfavP3DzjkMXZhOtIZ9LiSi8/aDdw9gbKnEAefTS/R2fKkWlrsclQHhYfhQN16qhim
	 HGnn2RHvxem4B91uS387dq/OXQwtdy0l/OnaC5ju4oCiEer8s+nZSsn6YPt4e0EnOfxRq
	 iKmUTS3hF+iCr5ZXRGw4G0ip3wPhZDSI6WbH6RJN0Obd8MryNt0DQX4DwwDivQHS41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMR5EAXP;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D772606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D772606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMR5EAXP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795600535; x=1827136535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n+z4ONkDth3LAMEpm3e1qLmoHlYrXg9wa2r9okZZh3M=;
  b=ZMR5EAXPFB8qQklQa0gym0zNcLlhmJtBgjMHjlF6R0dnGh2wHhrTQgme
   XTAJ9P6d2Y2s2kglxdxDt961dErPMaTqJb1HL2XY8OxazoeADAPWglaQw
   /iwUynbaqyJ17snzRqKRh1Pp2+YwHe/P5d/L935IpdJTrAa+WtZ1A4DsC
   wjZiU+68CYrT3ea54YMLootpilQfuNrsBeLCDRyqRxWKv6ykEa12/cEOE
   C+raeZ2uLgTK1roiUA/ieb5Z6p/FsNmok/+R2gcCsJ9nhuJ/5PbzkwPSb
   jISQleFPcavWm7wMlyGSfxhhR7rPht4H3MEc0AnB/1JjescZTTxfA1qKK
   w==;
X-CSE-ConnectionGUID: BdXf7gvNSTebd7lVY4QSCw==
X-CSE-MsgGUID: /iNe5abIQvOToqLlMBnklg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4475755"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4475755"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:55:18 -0800
X-CSE-ConnectionGUID: dqoO2yQ/SWa5u+soZJRBYQ==
X-CSE-MsgGUID: WiHWsMkXTsKMCFw9iN6Yow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11615793"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.52]) ([10.245.244.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:55:16 -0800
Message-ID: <a4789efe-4abc-4b5f-a590-3d0d4dd27b7a@intel.com>
Date: Wed, 25 Nov 2026 09:55:14 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when
 it's no longer needed
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 19:09, Thomas Hellström wrote:
> The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
> VRAM. In that case the bo may still carry a ttm_tt that was created
> for its deferred placement, and it is left dangling on a bo whose new
> resource doesn't use a ttm_tt.
> 
> Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is NULL
> or its memory type manager doesn't use a ttm_tt.
> 
> ttm_bo_tt_destroy() is internal to TTM and not exported. Rather than
> exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
> export that instead.
> 
> Patch and commit message was drafted using an LLM.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

