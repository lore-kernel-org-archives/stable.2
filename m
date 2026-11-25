Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647120;
	b=xqkDC19XLCE0hnEo88fbnSr8jR+pivjPYJWffHwNTSJ0J+nBDUCAnhfzVBst9pe+Y66v
	 uAf0tuAAs1Y1OhowWMV0DV81BuuytQaRodeDqsQbrPCUels0/FdnX7rPDM6/Jw3T/6nnM
	 9EEbIbSLji7JRc1Q3sgiuzohTafhCSFu9rHf733G6yzvKtg0n2I8txp3UZCwaX+4gyA+J
	 G98DSxfKm089KorclMv3F/0QsmlIqsPMZox0sF0Rw6K+lTEGhK6TFlRInQtXammAJgOBN
	 XMWysOXttPF815y1e/CNTmNbUJpa0jeDkoAzbXj7rIRCEOi2tl9mQkY0VpQosuKyElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647120;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zY2DQ7jj0w5ASDwv4S0fgG2/n5QhZ/n3GYMGmtP9EG4=;
	b=lWfj5/pUhVf1XzWHM8XsGzJ+UUxyL7HSEi4OgCtallnkrN/sge2bjg4tVSPxm/94/jdT
	 nYFqrmJhsglHQKv8NJCZ2VbI+9GvqA4m+Rih9SqgzrIyB7n2MFgWsxMydnsZ5MByRGEvy
	 xcI1Jn5egKhpaMTN7GaRZYDGrBr4lzYBS/uBOmaVbCt8ogsuY/qA9sC/aa5jfwqncIeqU
	 AHQtHZ+IYegUiedlCHQ8JAhnsD6IVVEscATYzY5L6A+6gaFJGGO2HglOiMfugI5n70ElC
	 ISFHfH8SNKA3j5+b1RFAPOPM9OahowhkA1ANnHe8dld3m0ifxAysoEbYyCwCb+oX2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k+6Mi4Av;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAF606A33F;
	Wed, 25 Nov 2026 22:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7AAF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k+6Mi4Av
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795647119; x=1827183119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2aXTTqfnK1EMR8EHPymbWbG5VopxqujRzmo69Rj4KB8=;
  b=k+6Mi4AvnQJzRFWpSfOwXgPalWCP6RYDdVJpQHIBUV1yqGO2doyBkOLp
   jWs+NCduknw/0p9PxwhAWvvOnUKLevEwaL/XW9e2H6kBttMlL5ma0mko3
   kpDtVWzESMsThK3IgGW+kbhsi5nLZLj8knc3ICqvOTWnhcJ0vzhev88B+
   43DG6EIfbLUCYBpFifGErtvlpQd9hIn8HycwJeSnrzhNP/YtNQnbuC+6L
   nZfok6FIEol/SiNsNa6rugC8ek8XDLmsx8C47ik7XCNA1C79EfAgZWe6Q
   Gf4cuQXvlw+jBAqlnBkA+q5xz5+Ktp4RaMr7F0xH+OJMuktS9CQl4p7OV
   A==;
X-CSE-ConnectionGUID: OxNBXAEPTD2BavhAeoEa8w==
X-CSE-MsgGUID: ydjjPue8SIKmcZabmp87lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4450674"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4450674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:51:55 -0800
X-CSE-ConnectionGUID: RSJgDNCGQ7+xZtQKhuXBFg==
X-CSE-MsgGUID: f99Y5nlSTfeCRrCYPV/d5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11996939"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 14:51:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	willemb@google.com,
	netdev@vger.kernel.org
Cc: Tian Xun Ng <tianxun.ng@bytedance.com>,
	anthony.l.nguyen@intel.com,
	oss.patchbox@gmail.com,
	emil.s.tantilov@intel.com,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	konstantin.ilichev@intel.com,
	stable@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/6] idpf: ignore link events once removal has started
Date: Wed, 25 Nov 2026 14:51:40 -0800
Message-ID: <20261125225145.4126333-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

mbx_task keeps handling mailbox events while idpf_deinit_task() releases
the vports: it requeues itself, or is queued from the mailbox interrupt,
until idpf_vc_core_deinit() cancels it once the vports are gone. A
VIRTCHNL2_EVENT_LINK_CHANGE event handled in that window looks its vport
up in adapter->vports[] without a lock, and idpf_vport_dealloc()
releases the netdev and frees the vport before it clears that slot, so
idpf_handle_event_link() can follow a NULL netdev pointer or use the
freed vport.

Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
The previous patch waits for a running mbx_task after the bit is set and
before anything is released, so on remove a link event is either handled
before the vports are torn down or ignored. Shutdown has the same window
today; the last patch of this series sets the bit there as well. The
window also remains on a hard reset, which tears the vports down without
setting the bit; that path is not changed here.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 348c7875134a..854eb1f1ada4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -41,6 +41,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 	struct idpf_netdev_priv *np;
 	struct idpf_vport *vport;
 
+	/* The vports are released on remove and shutdown */
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return;
+
 	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
 	if (!vport) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",
-- 
2.47.1

