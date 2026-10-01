Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79153D45F7;
	Thu,  1 Oct 2026 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892246; cv=none; b=dtXU9aqmP+0pwQtIbBhInphFuRuybBr1mWWx1/auev7YnoElJE7R/EsWosv2JZSiKioZdOPbzaPyPyTsV6DfPkpmV4xhb1/51kdzwHokl4Lx7ZzQI6SWjmsEAWu/W1uQW88LBVyqtTdON7ebwlYBURlL+Bg2jtq9qn5DqSOPyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892246; c=relaxed/simple;
	bh=nfS9/TC6e0333cbeFdTAlCNsRPsUcCP0MU0tGa2jJbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnAn7n4YMmmPd7syRqqLkI/9didRZXJvMLAOqQ34igY+samct9rOxoKg9k1hjpXkjQRn1w2npa+WlkWFxBhBfmVqBUulKGobE/pgV3vz3fID/XpyOZKpjKDOKbwreeRGLGHmUUGoRzW0DzX7ALha9l36Rjx8jwxoAsE35BUIWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBVde1QQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBVde1QQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790892245; x=1822428245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nfS9/TC6e0333cbeFdTAlCNsRPsUcCP0MU0tGa2jJbU=;
  b=FBVde1QQpgEHoSeNK9q5W6xkWLfXQ5x9Pqzslt+rW9WxX6myGKesFcaJ
   ymryzKwBlLHVk+ipFmJl3Z46ktGXJlEPqPqYnztvF6KoWMqFsJPZtLI0d
   qXzhl4F9+cjpSJe82NuDbYhokquqOv2+L8yMzwoLkXQKCPkfazY+RaODD
   S2dIGKUGzJZ8wFP+I+aTldawwTguNzPXtfd2+Xdep80fkG1dgO4U/RiWB
   UKpxZXEXgGsFx8K+beIemdE75Resj3WY3gRZQH4B7o9/s5yeMZialxoX1
   m0wQ/cb6vB/A9j44wJpmYgxxUNP1bU2+RG0noIG/T1p8HKHmtzNfHWgSX
   g==;
X-CSE-ConnectionGUID: rn45EJSdTD6iEkQ7KdzlRw==
X-CSE-MsgGUID: B1Lj2h5UTQmWmbZw4Y7DKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91684107"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91684107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:04:02 -0700
X-CSE-ConnectionGUID: atrvW6AGSWysJenpngdLHg==
X-CSE-MsgGUID: 446A0lqKQduZXQK/XkH35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="276206247"
Received: from debox1-desk4.jf.intel.com ([10.54.77.98])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:04:01 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	rodrigo.vivi@intel.com,
	michael.j.ruhl@intel.com,
	ayaz.siddiqui@intel.com,
	syed.abdul.muqthyar.ahmed@intel.com,
	intel-xe@lists.freedesktop.org,
	hansg@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/intel/vsec: Fix inverted walk_header() test in get_features()
Date: Thu,  1 Oct 2026 15:03:47 -0700
Message-ID: <20261001220351.1592138-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001220351.1592138-1-david.e.box@linux.intel.com>
References: <20261001220351.1592138-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

intel_vsec_walk_header() used to return a bool that was true when devices
were found. It was converted to return 0 on success and a negative errno
on failure, but the boolean test in intel_vsec_get_features() was left
unchanged, so its meaning is now inverted.

A successful walk returns 0 and leaves found set to false, while a failed
walk returns an error that evaluates to true. When no other capabilities
are present, intel_vsec_pci_init() then returns -ENODEV even though the
auxiliary devices were created, and the driver core tears them back down.

This affects platforms that have no DVSEC or VSEC capabilities and
describe their features through device_data instead, which today means
DG1. Test the return value for success explicitly.

Fixes: a6ce8bf3c993 ("platform/x86/intel/vsec: Return real error codes from=
 registration path")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel=
/vsec.c
index 5ab2215fdd7f..7d51f27f09bc 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -641,7 +641,7 @@ static bool intel_vsec_get_features(struct pci_dev *pde=
v,
 		found =3D true;
=20
 	if (info && (info->quirks & VSEC_QUIRK_NO_DVSEC) &&
-	    intel_vsec_walk_header(&pdev->dev, info))
+	    !intel_vsec_walk_header(&pdev->dev, info))
 		found =3D true;
=20
 	return found;
--=20
2.43.0

