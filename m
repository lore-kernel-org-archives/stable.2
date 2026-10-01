Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94B384223;
	Thu,  1 Oct 2026 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892246; cv=none; b=MQUbKVsDhAQkO8qA/oWDR6o4ml0gQMEXwphuvFOLLrOXixXHatjOSlmEzeHXcni86anTX8jojNrYzImYYOOdFXSIUuNhs7sgigAMN+OCRhxvU7jSkzUSGVMSleJDHINN1barMs7CiwAxPsLBpjl4xLNLwVXwEOWFG2eLRVW++8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892246; c=relaxed/simple;
	bh=im0MF/77O/DWBGe4Ej0EtpWL8k5fyxg1MRI4XahN/9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf8HU3a7iZkYQzLOBPoV8NttqvG1AoEgD157XIlnBeKj9QPlrCxGwi4yFlTU+8dttttKOc2Cbo+zi61BVq/E4DchhL0o85lb6owchivxTZk1y3zmlFYTvPFT4mV0oSePQFWIU/yV4lAMpWzDEEgJBooiNYSmpRs5ltSzHc+maEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBuh3s6P; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBuh3s6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790892245; x=1822428245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=im0MF/77O/DWBGe4Ej0EtpWL8k5fyxg1MRI4XahN/9s=;
  b=UBuh3s6PKom5Y430VXaEhaR3q2qhWPTStUEOGy1h1URFkXJwtXSMoxhk
   YfNiQ/uX8fUMMV1DK9OF3kZEzwyEtYxdLOPzUvYenMLRh38avqCZyxJdk
   rYUZr2gvwoUjofO5hRZeSFyAnGpP0w5Tc4uIEYSGLE7cppsTVq4ZLdt5q
   HD9gmvAb6rHWClEemGxP9ZFnpCnzGYt4l+fXrUCWTyeAqodkBQM1eTqIO
   3X6FrD85sL93+V4UGMB7k/sOuJQ1Z2eliba0JpdsmHY3V9krTVcpU8DhS
   VuxEUYclL678sS8j8zuvuXiv1kc/SLKcHv+OBQS9vAk9zmjwq0FeKjhjg
   w==;
X-CSE-ConnectionGUID: o2sgeuDwQ/CRc7j5sqYE7A==
X-CSE-MsgGUID: oeYxnHHPQE6IgjnxrUQpIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91684104"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91684104"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:04:02 -0700
X-CSE-ConnectionGUID: MBsmCVIvRxGTzsnp19PgPw==
X-CSE-MsgGUID: DA+WT403QJGQQEe2mvFy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="276206244"
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
Subject: [PATCH 1/3] platform/x86/intel/pmt: Fix NULL dereference when reading crashlog data
Date: Thu,  1 Oct 2026 15:03:46 -0700
Message-ID: <20261001220351.1592138-2-david.e.box@linux.intel.com>
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

Commit 353042d54d82 ("platform/x86/intel/vsec: Switch exported helpers from
pci_dev to device") changed intel_pmt_read() to pass entry->ep->dev to
pmt_telem_read_mmio() in place of entry->pcidev. entry->ep is only
allocated by the telemetry namespace's pmt_add_endpoint() hook. Crashlog
entries never get one, so any read() of a crashlog sysfs data file
dereferences a NULL pointer.

Use the intel_vsec_device parent device instead. The PMT class device is a
child of the auxiliary device, so derive it the same way
intel_pmt_attr_visible() does. This is the same device telemetry stored in
ep->dev, so behavior for telemetry and any read_telem() callback is
unchanged.

Fixes: 353042d54d82 ("platform/x86/intel/vsec: Switch exported helpers from=
 pci_dev to device")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/=
intel/pmt/class.c
index d0ab8e33c62a..b69c79785d9c 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -90,6 +90,8 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	struct intel_pmt_entry *entry =3D container_of(attr,
 						     struct intel_pmt_entry,
 						     pmt_bin_attr);
+	struct device *dev =3D kobj_to_dev(kobj);
+	struct intel_vsec_device *ivdev =3D auxdev_to_ivdev(to_auxiliary_dev(dev-=
>parent));
=20
 	if (off < 0)
 		return -EINVAL;
@@ -100,7 +102,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - off)
 		count =3D entry->size - off;
=20
-	count =3D pmt_telem_read_mmio(entry->ep->dev, entry->cb, entry->header.gu=
id, buf,
+	count =3D pmt_telem_read_mmio(ivdev->dev, entry->cb, entry->header.guid, =
buf,
 				    entry->base, off, count);
=20
 	return count;
--=20
2.43.0

