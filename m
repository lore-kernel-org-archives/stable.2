Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530774;
	b=dJiyUSPZ+fQYUF3R8HaElMwKVHEuPXgwsq6N/HsRwwOd3J3B2yE1KO0yKyI1uSDJUXZN
	 To1RJQa3B0oCWlf1mUmbXp15O76z98JLqzovLVXNznJwDwyyepdfAwXvOaNh790J+s57i
	 708dTUWhh2BMJtqTKqtbeqTXyIxmWphfwvVe7kRSrVyqAL3OdgLNPQzLpMGXRMfhUCXPZ
	 3q27g65bRe9dwSEZU6cZjpr/Q6EOWgdYd37T2bHSxS5OEjm8+RY0DZjXm8tRx9mTL7mru
	 ofyIbxb9tWOLQrZwnc7kJNNgH9JRkSNPK4DqJ4fNDxWVjajV/QWZBmgtXy0R8KJ2TTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ECyPyvXC/95TVpG8C1F8ZvcNpYFWdQKxsSElEdWhykU=;
	b=3UGqeA52ZmjIeVttMqawjvnOTLf0hGfwkT86GzbRi/dseA8/cssUpO6WFia3S6ayRYoW
	 +uLmwVZv9jDeqSOoInY5V2Uh1qLoNTViCiFLV1qoQfkGYAp4VPwcI5BZOEP0P2iVNZKet
	 RD/gnF2WmWGD3yGu7/5BxFd+L8E+YHyzpTADY7ROtuBapxsPbUzJMfW9u3QixHG1WYMk8
	 IOHRaegMUXE2vw6QcxJjtefVCqMqB597i7u+AcNaH2eDxinTlzfBRextSYHxcmowYJ+yZ
	 W6twY9tcs2WQZGlSsKazLTQA4GbYV3Q3aWhMUsQdp30/7qc7BmLybpwGU+FPkPKRioQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YvvnbJhp;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60B606A890;
	Fri, 13 Nov 2026 00:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A60B606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YvvnbJhp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530774; x=1826066774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oaJdx+9UqCQ4ZGLoGgzlp+vMwxz82WMtCK5tbgzGpx8=;
  b=YvvnbJhpDGSUzR4gT9xACcIzBuFRPVdpxP7pCRNtLWVAiQLMA+E4c7XD
   mqc2tOReIGkXDtMRJEoeSO1shxvtu9UxJqQHTVhh1h0N/j4p3Xe2yiPmh
   2gBXE9lfovSKeNI7yRR1aXgZEUvO6HUNR1x1c78cmKc+OckaBr2+NfF8y
   vNo1W6tkHFguz4CHK4Xh4sQdVnzpjNSJvj1EBTW/BCqYs5mMVJOVa2znL
   4sH/hV6Hvi7SauyYdWkAffX4ozIRcDUwWJCuEogxrufI1BqvYhd/aEboo
   aTWdGQBi6VhcBqqnqeXqMAAORq+gEC2STHSAVMsnDDAP27LVrz+TraSRi
   w==;
X-CSE-ConnectionGUID: KSiXO1sZS7egPz0enwA+jA==
X-CSE-MsgGUID: NCl6S/LFSgOa/ieQMQlm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361695"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:13 -0800
X-CSE-ConnectionGUID: RMI4bo6iTyminHTuVrTUpg==
X-CSE-MsgGUID: jmUQ8Pu6RhuFtoxUY9p86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724630"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:14 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	mheib@redhat.com,
	fballuch@redhat.com,
	aleksandr.loktionov@intel.com,
	richardcochran@gmail.com,
	saikrishnag@marvell.com,
	stable@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/6] iavf: add missing PTP adjustment callbacks
Date: Thu, 12 Nov 2026 16:46:00 -0800
Message-ID: <20261113004602.129864-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PTP hardware clock documentation requires drivers to implement all
callbacks and return -EOPNOTSUPP for unsupported features.

The iavf driver registers a PHC without adjtime or adjfine callbacks.
A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
callbacks can therefore cause a NULL dereference.

Provide both callbacks and return -EOPNOTSUPP for the unsupported
operations.

Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 87b97e09df14..fcb273828bc1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
 static int iavf_ptp_settime64(struct ptp_clock_info *info,
 			      const struct timespec64 *ts)
 {
@@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->adjfine = iavf_ptp_adjfine;
+	ptp_info->adjtime = iavf_ptp_adjtime;
 	ptp_info->settime64 = iavf_ptp_settime64;
 	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
-- 
2.47.1

