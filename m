Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300200;
	b=TrQVGaHL70gAidEQAxg253Ngy25gFeHqiaJH7NajzgFYniKvbaBKfvPXkhB3Ij5iokB+
	 L8CnwCuxri1GbOOfxavalaGXzov6YC5IBw9GZwEs7wLMyvnQyYSMsGAtd8u+XHQSPp0eE
	 5RGmM0vtbCpsklkEENwJD0YUVZJYjlsSfZPaRA8RwE5oRdWMyLsGyLBnP16VczjA9agJd
	 zLJxZbnTQ+iAqC5ukGMlYXML7KRmikjklqod7/fOBo/VsoCX1Pbi1vV1CmhRVYPipk5Xq
	 3Rp/wGpvB3zmI1p42fyelOoFtZ8aujKJ8Hz4RK2sUfIsNR7L/4UOQ6Vn4itN+LV6aXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300200;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ceyp6qUlPkZr8sRjiOtI55f56LZSHpjTj8wP8Vp3EyI=;
	b=TDYwzN08r7yO/QDbyzMfcJfJQ3Bjp8M9MSmhk7XVG9Imo9vL6vGzoaSeg2GG0cRU/RIj
	 dGz3skgefCd5hTYBW5ZZNuaiqO+KoJbPe6OJbdJk/TpogOOa//LCOTobQU73bZt0tglBk
	 rlhA8NhKDtHbzMRmLF+FSih4IlbfVln7Nw244+Myze6mMprp0CRTKBVjrdT6ppXboBWMm
	 5Bh/GACxevFnUIL32YhulU0N/eoMW/LjZW4qox1gr9kfU6qG7n4BWMx35dlWcok7buFta
	 sTlZ+QZ2wStfrnxwpOGfhbCTldrLraZjcnBSrlvsYeCXt0l+X985E128FMk8ZztLYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eoHPjw90;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E90606A321;
	Tue, 10 Nov 2026 08:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E90606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eoHPjw90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794300198; x=1825836198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ceyp6qUlPkZr8sRjiOtI55f56LZSHpjTj8wP8Vp3EyI=;
  b=eoHPjw90fdebjfz0myuVxN7ODdqvRfwVMxLbp0GSYFkNQB1c/74pQLTX
   jn2hQ1+OGKEgjLcvOSB1QCIlOrkJ54poUJxeduL7wZOIkLOb+ZSvsdGA9
   Wy/gxBSwp2Ui+AQIZeL9rJfoZlGHRDGCsW7gDYLCIGDvDhG26Z49VNyIS
   NO0/TycAYeYAky8YLxu4meMc+rZgTWX86lvhp23cK9SfkuECNajviVZ7v
   6A7BXH7dNzNzRjkyGuuixlL3AMBZ5WWjxssLEZS4CeYykaZSNn+dBlveR
   mnrkwmTsJ9e9guuW2FaXonUDGO5zV6LNXaxwErl3NQ0CcrhabRR00iSeI
   g==;
X-CSE-ConnectionGUID: vtCIw+zJTxyr/AgaaoBMlQ==
X-CSE-MsgGUID: ydey5/JCSzW7FDx+bRwPKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3053630"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3053630"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:43:16 -0800
X-CSE-ConnectionGUID: nIFQ9jbdSVGDm8tLoiS2fA==
X-CSE-MsgGUID: gmGvns63SEKcxV+ySiOZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8241688"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:43:12 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	tursulin@ursulin.net,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-kernel@vger.kernel.org,
	syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
	madhurkumar004@gmail.com,
	stable@vger.kernel.org,
	fei.yu@intel.com
Subject: Re: [PATCH v3] drm/syncobj: Limit the number of handles and use kvmalloc for user-sized arrays
Date: Tue, 10 Nov 2026 16:49:06 +0800
Message-ID: <20261110084906.2458016-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
References: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fei Yu <fei.yu@intel.com>

On 11/9/26 12:54, Christian König wrote:
> On 11/9/26 02:48, Yu, Fei wrote:
>> Signed-off-by: Fei Yu <fei.yu@intel.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Let me know if you need somebody to push this to drm-misc-next.

Thanks for the review! Yes please, I don't have drm-misc commit
access, so I'd be grateful if you could push it.

Since it carries Fixes: and Cc: stable, drm-misc-fixes was what we
discussed earlier, but drm-misc-next is fine with me too if you
prefer, your call.

I'll send the uAPI doc patch for the 1M limit against drm-misc-next
once this has landed.

Thanks,
Fei
