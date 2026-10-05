Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24A2116F4;
	Mon,  5 Oct 2026 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173537; cv=none; b=rLroZzaGdsoDCzTKnE2SpbszyPhNCewhVCP9hay6SVgyYwCwlLm1qYem/esDSEmyw40fJb4Zim1eTGeQQG6eEgsjV6tTqRggHQ2+CQh0I7kiU5/s4EyOc4yovKcIDOjlhQuk5OEXpIFkucHLxX3Gv3tll5PWFfqRi24gWFGSMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173537; c=relaxed/simple;
	bh=YQppuIDi9fm/QoM2Bn3vzbTb84ufmOlYG/KToC8U0TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW4+J3UthvoRmQgRK2xKaknkIzGUg+Dr7Y3k2wLcyaTeerEgKXv7pSljhbrJuovMz4Z5enUe0+XuufNwyStm+vJXhsDeY73uvWmnb8SbtLJon4c02UYZVIEicuhE0MgQtL0lRqHVCglrSwwLA98d1WojMTkOkRrjMazyj55lcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtVXVLm2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtVXVLm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791173535; x=1822709535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQppuIDi9fm/QoM2Bn3vzbTb84ufmOlYG/KToC8U0TE=;
  b=YtVXVLm2ZkhsUTFu94xznkpfI1GsD/2JoFVKLU+bFca4+/3CpillDE2M
   tfww2enhk9hT2wmy2yGSetHnrCjt2eDLzM0tClAU+4IC4voCFTZPnhpIm
   Dx+yDsn/wMEG73sj7n5gojGXeKBshU8mbCgp2OSEP1TsmvQVuvQZdWBGM
   PqYS6TiJ54l/f8sbcZUMJiBHQPmoX7Zwg5FnFQB/kM4qqTJcZcaYghTjt
   zmIa9hCYBoW776htd/csX3c9vgJz059NLZyZG6nuiX+S3TubPLmVV7ZDs
   X+CtfA89aULhOyHkviNSk/EMl3nnBb21T4e+3ut1WiG+/0OQQSE/GHlNJ
   Q==;
X-CSE-ConnectionGUID: kyFOxyS4QYmBsgozq641Iw==
X-CSE-MsgGUID: jabr7qCtRa2w67/V1dbIVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94325671"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="94325671"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 21:12:14 -0700
X-CSE-ConnectionGUID: dEjqj99XQvOCU6pOXgR+cw==
X-CSE-MsgGUID: DFftWtHdREOR8SGEDprtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="274821563"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa010.jf.intel.com with ESMTP; 04 Oct 2026 21:12:13 -0700
From: Ravindra <ravindra@intel.com>
To: runyu.xiao@seu.edu.cn
Cc: jianhao.xu@seu.edu.cn,
	kiran.k@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	tedd.an@intel.com,
	Ravindra <ravindra@intel.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: use managed IRQ teardown
Date: Mon,  5 Oct 2026 09:44:57 +0530
Message-ID: <20261005041457.3021139-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
References: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Runyu,

Thanks for the fix.

I have tested this patch with repeated Bluetooth load/unload cycles on
an Intel PCIe Bluetooth device and did not observe any kernel warnings
or issues with the patch applied.

Tested-by: Ravindra <ravindra@intel.com>

Could you please send a v2 including the above Tested-by tag?

Thanks,
Ravindra
