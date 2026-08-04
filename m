Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F7305660;
	Tue,  4 Aug 2026 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812885; cv=none; b=O/rptRJSEDz8InmzHvLFFJxnE5nklRSMK5uwr7FRC/HLVvEmfRfbW7fjPqIVawgK0YL7xWKDKiit4Vt3FxW8EivhKgJoudiNHLQmT80o19zsLgCAhlyoeiPW4cXM0AMPNzbDNVpcnGaI+gTiVCjkyKjxvjdsm/cLBpZ/9Zw1xUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812885; c=relaxed/simple;
	bh=6e7fEo+yH3CS0utjEIF3ZYJk0Bo7r58b+dyBnMlNWrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpYuKMv3H7apkvqPfbVP8K7Mr8YA0SXZPX+h3GRwU7egI9WYPAht9GV2nb6TajBSQ40PkJ250vELmhOLKX8gbMtZ8AmOAtZB8CsnuLW2YamEbaCesPyD48ZvftvFLqt8Gp4u70gE2PyAR2UxFZ9I2C9hHBXeCzVnSSbQM6Cs4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEeUDIRi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEeUDIRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785812884; x=1817348884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6e7fEo+yH3CS0utjEIF3ZYJk0Bo7r58b+dyBnMlNWrM=;
  b=BEeUDIRiZkR/62M/ZH94hKGFgcQRAW0n7xOP5t8FT4j2qod2rwq1Fbkp
   PSahVTfoMVMclObhNXZiPrKLIbLEal/cQhW1FEkTQpMDHFZX/r1shWzmU
   6bSrjkY131c+Y3TTpJp1OK80Yzyw06VLe050YgRwn+WP4YSHTMGfncEB+
   6oVq3YcGQ/ywRl5Z+2hMaiaultFKvgfPriGX5MA1v99A+BwPDW29S//Se
   WUvQxzAleem3k0Ve8FDBGghKIr3Yu3JkXjVPvBs96FB3CePiISmnFZxoQ
   E3hf5W1y9NJPYv3rWwXoY/hbP6AcjgWL6e3hMwGQ2kt6tD2XoYP8NBEX/
   g==;
X-CSE-ConnectionGUID: 4KI+ZFo+RYaqCfE+edmkrg==
X-CSE-MsgGUID: n/+zHWZIQ0OZ6bp7GpB1Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86436512"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86436512"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:08:04 -0700
X-CSE-ConnectionGUID: aMuq/oAxQVC5HJwYLjVslg==
X-CSE-MsgGUID: 99FrX/6zQcCkd8pv2NtdUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="265642998"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:08:01 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: Re: [PATCH v2 1/3] backlight: aw99706: Fix DT property names to match binding
Date: Tue,  4 Aug 2026 11:07:07 +0800
Message-ID: <20260804030707.1936569-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803141310.1379194-2-junjie.cao@linux.dev>
References: <20260803141310.1379194-2-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rest of this series was lost to a mail delivery failure; please
ignore this one and see v3 instead. Sorry for the noise.
