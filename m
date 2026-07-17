Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD43A383C;
	Fri, 17 Jul 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314434; cv=none; b=c/medRrIYGJySckjIX39RBEcbW6l+OjHYGXD32oAn2vLjH5zdlVZg67ZPdLgqZ7vhzjK/m7B7B/m+C5NozEXrDKtomDKXZHWkO2HDI9qogQiKXA0z5NK1vDyAIwEcTgCgrKIJMmbbFv8jwptQ8ym21pk2iw2RqWFN80IQlat5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314434; c=relaxed/simple;
	bh=JLcB4ySPF/PF+chFAinAMquU9n2vAiYJK/lKnD9xZ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=honeJWPDkItfa0D8Gk+FQz5dO75PxqKDqvyLdE7oictOpd/v87kn+moarceiXAnQKTk46tINbwRHYhucvAUHy8EU2Im91XQIUnw2jBZE/82xVDBfEzdTbnZ5AeyPA6Zh81Q4kC96cVFITMv1psRaS3nmZw7y847iMW1opEGgJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UElb157G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UElb157G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314433; x=1815850433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLcB4ySPF/PF+chFAinAMquU9n2vAiYJK/lKnD9xZ7g=;
  b=UElb157GvYhn3snMQtxNkHMDS640gIWgS1TeeR5gJucePtNJpWPKs2jn
   W4qm7VPkISjCCaPlQY9WwULVwX92HuWSKwsS7HhLA6SzMDjJW+XjSq5h+
   7MlYPlEDj+dj3mQO0MgT3yXivKy5ibxWVSVpWejav+AllD8wokloBawWV
   JJuY0JRiCNqrAA908k74IAQIO5iOUewTkHxLwKWh/MGhuytb66Jpv9GQD
   aNtzzjQU+KNJ9TH6ZMTZZ07Bli4vL2iaNkbHq96jNB/trssdyEVSMs6Rw
   bf6pNJxcb/lqYBegQCX6275zHfU0qZ6pplDT8UlBdJmpD7YDzMHqY+Djn
   g==;
X-CSE-ConnectionGUID: 5jwmYkIiS4a6yxdGzWI/BA==
X-CSE-MsgGUID: fJVShBMZTzuGE+ksIiVJiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347652"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347652"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:50 -0700
X-CSE-ConnectionGUID: EQlCllcnRP2bIR/ibEFipw==
X-CSE-MsgGUID: r7iMHqGnTV6hAmnd8PP4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827259"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 11/13] ice: reject out-of-range ptype in ice_parser_profile_init
Date: Fri, 17 Jul 2026 11:53:33 -0700
Message-ID: <20260717185340.3595286-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
providing ptype >= 1024 through VIRTCHNL, resulting in a write past
the end of the bitmap and a kernel page fault.

Reproduced with a custom kernel module injecting a crafted
VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
kernel 7.1.0-rc1.

crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
crash_parser: setting ptype=0xffff (max valid=1023)
crash_parser: calling ice_parser_profile_init -- expect OOB crash!
BUG: kernel NULL pointer dereference, address: 0000000000000000
Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
Hardware name: Intel Corporation S2600BPB/S2600BPB
RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
Call Trace:
 <TASK>
 ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
 crash_init+0x127/0xff0 [crash_parser]
 do_one_initcall+0x45/0x310
 do_init_module+0x64/0x270
 init_module_from_file+0xcc/0xf0
 idempotent_init_module+0x17b/0x280
 __x64_sys_finit_module+0x6e/0xe0

Bail out early with -EINVAL when ptype is out of range.

Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f8e69630fb72..3ede4c1a5a8a 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
 	u16 proto_off = 0;
 	u16 off;
 
+	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
+		return -EINVAL;
+
 	memset(prof, 0, sizeof(*prof));
 	set_bit(rslt->ptype, prof->ptypes);
 	if (blk == ICE_BLK_SW) {
-- 
2.47.1

