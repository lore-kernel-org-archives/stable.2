Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097529;
	b=V9kEMfPwRlyxob3vqdP9buQEfPnl5ZQpfypkQj7D6tv+fFicZ3MP+TMC3fs+vek2zyMG
	 TeMmBM8Z/lnJ/KXL544d28m1+ajLy+79AgxyVQVPj7lviFDsWXNuSVoAe6wqLhHkJJG0c
	 GCZMRbf/VQ1VG4iApH8NxCXjF2WYEShNzVyhexiS3L/j4wMjJQJwCTfcVVQfeOnVXvMrp
	 x/T0EwbFYVzlvHbAn66ZMwZmBlGtpDqzLUmF3vX5dwT1xS8avatjc84PnvZNQWi8EmhLz
	 KQZhqceqT/lO7XY7yhLDlVefJBlUMUzD27UY5kNzJggPCmf8W0xKppRPkcXa6wFrAAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097529;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ByWK1YCGVSNc/h5YBvelTmidZVWgMT9x4ETZP67cNCU=;
	b=pee/A2X2O4jUdtU6ZozQScP8wTZ+nFUqZiuDkfzJ+Ao2oVChKQQBh9d/3nKp2DUAtfTC
	 Hb9sdU3skRmjbyEggcpf17K3mlQvupc7yGNkTKtjYEbCz4hIaByDmLqjxWUU6WYZUhAsA
	 Hie1qy1hH4RRIlAxPh146hMaPYwB9bo8c0lSS/E7qKlYTylfnxZiu9xMy8d17Gj5mmODP
	 i8zJT2ZwMbfCuwcXPZE1qJjN1pl5iQIOqPHBksfLS+mkgQ7Fn/z1U5mdaiDL6tte9rpgf
	 prwMjG6vuDMUw+XThh7fVc6Q+6AeLmLrnWE7Lox2W769ZE4sFvI94kgwBeDzqLkRF8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FNet4chP;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F26606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FNet4chP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795097528; x=1826633528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vebLE46OBdUROJUS3bix/KJ+ukxDZRcsmGJk6frAy8=;
  b=FNet4chPd1unvcKLpXgLZrd4pJ09aNmw+U4SSvpOt06QH3Cti5CqiAmt
   HqXEw8Ar9khgJirf5Cd/Nrb3Dzx8gL96awoVD0vJ7V+0EH/+++IRE1Mfw
   x82ZT/LT8YKRcIp4aZlbfV2U/RiyT3e+Ffvuk8fSEM77tcRvOzkdwrEjW
   OMV38PHXOQ/nLRluCp465ukEe8hrrxx/ZbOR4A4znHIFT/rcPGpiNsz5C
   R2t7LTVOhvGBO51ztB6M4Asub3Z8X8K87g5YkMMfxHJMhb9gEmfJNBtaD
   V5lSJZpeC7rgyUnDhwZ/dWEKfbj9RKPOjFGB/3mZXq56uRh6pUYTF/cF7
   w==;
X-CSE-ConnectionGUID: 5VzaqqGfT0WnQT86CU3iTw==
X-CSE-MsgGUID: 2sMUa99cStmuaABoFM0yng==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835633"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:12:08 -0800
X-CSE-ConnectionGUID: lcP3UfoOQ1K5kg6a2/zWOw==
X-CSE-MsgGUID: 3NWrlUDeS/KGX0aHSFDOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10476156"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:06 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-next v3 2/3] idpf: enforce strict ordering on BE when reading XDPCQEs
Date: Thu, 19 Nov 2026 15:09:37 +0100
Message-ID: <20261119140938.1363722-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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

On Little Endian platforms, everything we need from the completion
descriptor is read at once, while on Big Endian we read it
field-by-field. Depending on the compiler and optimization settings,
reads can be combined or stay distinct. The latter leaves us with no
barrier and with possible stale completion index or tag.

Change the logic a bit and read only the "readiness" field first on
Big Endian, then perform strictly-ordered read of the cookie after
making sure it is valid.

The Little Endian code remains intact. Found by Sashiko.

Fixes: cba102cd7190 ("idpf: add support for XDP on Rx")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 1d8ed7ac3e17..48320ea004df 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -236,8 +236,7 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 #ifdef __LIBETH_WORD_ACCESS
 	val = *(const u32 *)desc;
 #else
-	val = ((u32)le16_to_cpu(desc->q_head_compl_tag.q_head) << 16) |
-	      le16_to_cpu(desc->qid_comptype_gen);
+	val = le16_to_cpu(desc->qid_comptype_gen);
 #endif
 	if (!!(val & IDPF_TXD_COMPLQ_GEN_M) != gen)
 		return -ENODATA;
@@ -247,7 +246,13 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 				IDPF_TXD_COMPLT_RS)))
 		return -EINVAL;
 
+#ifdef __LIBETH_WORD_ACCESS
 	return upper_16_bits(val);
+#else
+	dma_rmb();
+
+	return le16_to_cpu(desc->q_head_compl_tag.q_head);
+#endif
 }
 
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
-- 
2.56.1

