Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1503ABD8D;
	Tue,  1 Sep 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272747; cv=none; b=HE0tqVX1uUJy5lJKHgoMCwopYEx4mFXsLnhXGly6hxUs6EXJIXec7IecgH5w6/YBVIsaLJ2o2XI39VkIn3AAVxzMkm0f9BNq8hVePqCVPTVGyOj2bF38v6uVa3CmAsvonxfUi81QU9qc2BFm7rnJBPTSbz/qM8fKaS03UFu1rE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272747; c=relaxed/simple;
	bh=q/aNeRp1M8+W5dq4jHs4weTa/XmaDxsrVyBRxencbn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+2t6iVkr3/TsYnuwDKcGOHaHvmvlgD4tFzKqeILaKebyOP6rlGh16oHuirDO0BC+SRkH9PvAlRxfIoWMYatRYRWArs86DmMtuyiWutXt7+/JkIye6kOemOVVj5Wk7Q+EqIkIxSo11+A92CMtcza2nshGDqXUZMm04tPSXY7F5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gd6jfIM7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gd6jfIM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788272746; x=1819808746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/aNeRp1M8+W5dq4jHs4weTa/XmaDxsrVyBRxencbn0=;
  b=Gd6jfIM7Wzmw1mBtyG8pXjYVzQfE87Sq5Q/ytTtFeqB61oXur1ML5n/b
   AbTU11M1xIrNDa+WZAqlZrNXKJixNs9RitUpubzZZlN5Rp6HfM25SWUB0
   4DRw9B6WaPdBdpmJIs/SOSjnEGKvFi4xdbrdw9w9b4qTJep/oLuPRM/C8
   RFK4l7WFxGyQYBLFUNHRGV1+7XzGmTsK1uIiiNdfsBGJBBXi7JWJbmwl2
   fVrQwoRzcp+dCzlprUat26qYyPzSqSMUPTOtodeO3nT7Jnf3Sooh10oq0
   NXAgIJ0pRq+WBC5rDLZvy1o0J3wbnm0UA4m4kh+DokgIlFPYGIWa/oLHt
   w==;
X-CSE-ConnectionGUID: wUQlWOMnQ2K9wqbLHm03lw==
X-CSE-MsgGUID: TqsHgRYuRd6ZPHsOEjN79g==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88555113"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88555113"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:25:45 -0700
X-CSE-ConnectionGUID: tGXYaYE4RqORCSUALmw9AA==
X-CSE-MsgGUID: QwKAUf1dT6aKM+56SK+k6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="292621116"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:25:42 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	JB Tsai <jb.tsai@mediatek.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	stable@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7921: skip CLC records the driver does not know
Date: Tue,  1 Sep 2026 22:25:33 +0800
Message-ID: <20260901142533.422664-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901011840.416787-1-junjie.cao@intel.com>
References: <20260901011840.416787-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Laxman posted the same change on Aug 16, with a Tested-by from Mikhail:
https://lore.kernel.org/linux-wireless/20260816174841.1918-1-acharyalaxman8848@gmail.com/

Drop this one; the stable ordering note is repeated on that thread.
