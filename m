Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395381;
	b=uwizCOb86icyzd/xFKprUR+sL/9IQGt2/+PQHP/DojS04C7Eo7J3aY3g8+zxKJ0jITsU
	 5HlZF5VjlQWDYP1goHoNGcRYWba000LZOmfTNJ4hjr3mLArzh3cOVF3OfDYD2xBREQvlj
	 7yyNaAd3p7LaNjuv8VkoIR5Gi5/7adRk14lMMSR2F/QGVo0RXC1G4gW1yVQLKlGdYtABC
	 2gss5tuwXFgnNmBL7hKyIDakxkrE27HOgS+LReckytB526ZjuL/Y87yOrLDgjiV4qDQGg
	 unl6GpycR3QFAAUp/A3dqjzW/8btgxQKkRh8c47ju06smYr2vI1tluK8y9YYwTGt/8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395381;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6iOWOlhokRTvZ+1ZzgrBgIX5wJx1n4wumL1FFGWInLY=;
	b=Xr2aSOwtmm6Tjd9DKniP1nG5TJR0sD2qCzGD6ExHWiYFVJk2af1tEjDibNgxm3eHfUh8
	 SunhjucXcJ0mxdFYBxIBjoVnPnxrNL4pzk38BoobhuZCE4yBZk3euiziPdSqPuPADnyaP
	 labBOKsXKvCOSLQf69kLB8E89aJ+rB1PbuDlBfwp9rdq0VWWUbJ28+EufI9xuyr3iI+6A
	 QqylbPKM8M89RF3cqt5OBzW09uM4FfNxKdqV5lD47qTqANpnPbEgBtCJENOZJi83vOUYN
	 wfeTX/gfga01dbH2AMEP3yuPIBCY6ZD/mmizPcwQrhKQP7SYAY4X0OlLM7xmYojV97A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CsnqehUh;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22948606A31E;
	Mon, 23 Nov 2026 00:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22948606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CsnqehUh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795395381; x=1826931381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=te+YbI60VJc4AmXexw7PT/rJUBZf+kBjHxUOZYIJA5o=;
  b=CsnqehUhVEsnsMT4xDBw9qRHKjeBLh2+IEAyc+ETO8HQxG8RcdZaPc2B
   IOCYj6LLIuvLL5PZL/grJKRJZ9gwI4B2HLAuAVisnXc2evtHwpPg/tSw3
   vBzpbb18Zz3esUD6RTcbFQa+rWDYm3frYpA1oDABVT2tl4L1H5QekObWw
   VMODJTQk6/q5YWskL+YPLQ26exfgFbluCvRXYkDOjMukUPpacDUXYCTuv
   zQkMmtv7mJxp3mj6NBO9PE4WIreaHZ13tFMplRuCpX8muiILaoGeiqabF
   B60MzWxVW0aeErFVjsAS0o5peXoTZvcvNb9Fqi0/nhoO85JFaykFc0gyt
   w==;
X-CSE-ConnectionGUID: 1stBgjFpSveb192jE/3H6g==
X-CSE-MsgGUID: gIrqiKqbTNmvCmKmVJqVIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4181284"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4181284"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:56:20 -0800
X-CSE-ConnectionGUID: vAywu57nTcOXEAyIQuBFbA==
X-CSE-MsgGUID: sTw9e0AqSGWQNQyI6LQtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11045618"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa003.jf.intel.com with ESMTP; 22 Nov 2026 16:56:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Block translation before removing IOPF in blocking attach
Date: Mon, 23 Nov 2026 08:43:10 +0800
Message-ID: <20261123004310.2828884-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blocking_domain_attach_dev() drops the old domain's IOPF reference before
it calls device_block_translation(). When that is the last reference,
intel_iommu_disable_iopf() calls iopf_queue_remove_device() while the RID
still translates through the old domain and its page requests are still
being reported. This is wrong in two ways:

 - iopf_queue_remove_device() requires that no iommu_report_device_fault()
   is still running for the device. A report can have linked its group
   into the pending list without having called the iopf_handler yet;
   iopf_queue_remove_device() then responds to and frees that group, and
   the reporter hands the freed group to the handler.

 - With iopf_refcount already zero, the drain in
   device_block_translation() -> intel_pasid_tear_down_entry() ->
   intel_iommu_drain_pasid_prq() returns early, so the PRQ for the RID is
   never drained on this path at all.

The removal was placed first by commit 17fce9d2336d ("iommu/vt-d: Put
iopf enablement in domain attach path") because the old domain was then
taken from info->domain, which device_block_translation() clears.
Commit 91b55eb171cb ("iommu/vt-d: Use old domain parameter when attaching
the blocking domain") switched to the @old parameter, so the order can now
be swapped. Backports need that commit as well.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..a8c0ccae844e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2897,8 +2897,8 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev,
 				      struct iommu_domain *old)
 {
-	iopf_for_domain_remove(old, dev);
 	device_block_translation(dev);
+	iopf_for_domain_remove(old, dev);
 	return 0;
 }
 
-- 
2.43.0

