Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794E3A6B66;
	Fri, 17 Jul 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314435; cv=none; b=lsMdlPClvCqiz3WWgiTZ+EcZSWRy9eI/GIGgfaimZcoKHtswFbgg+AM3soHbKgJwsfCt6zhyGfu1Xd1sg7VJPDT1+xi0p2t3ikBs3H7PBxu1PNQiMHwP3iqjCwGYjeHmuosLVsdz4PQKnUBngbLJWEYCg5ZaYzAvzE12Zfti4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314435; c=relaxed/simple;
	bh=xufC4EUuCf6ntUipqbGc/fRxVwUBmlWsbU+G6Pk4cfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb2SEiM6J5bRJuYaaRdR8A/fOew6zE0yFWZ7XFBMZc+ZISW+A9JCHO5EoHpjXFCaVHA1B2e/7yLwvGAX8ayOig9SVYWhLydy8lcltodwi3WRZ+d1H5QWiln9JBrGF9UJDdAReHVUvALeQyxKMVdO5y9xzvlDpaaNahfxSheZxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnyF3u/G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnyF3u/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314434; x=1815850434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xufC4EUuCf6ntUipqbGc/fRxVwUBmlWsbU+G6Pk4cfg=;
  b=CnyF3u/GlOQkOE9vFx6bAlgpUyHHn3xU0q96T4aixl6FOlvdKE8IOjw3
   /XY5slAbao5m01WU9JZjiE7nEFRweD0NQ3neHeQrO8niF5rapNjr/yGzR
   8635cQInhjetlqHMSi87nuy8UVKjs61meNWzOVUO4ZlzHu+3X7Kv4ciHx
   UJ8UnQscmrdqcSGeaJcDIDJWB9yCBFbswWVF87Zsc+deS3N2Z7HDBTHb5
   yytl44e0vnncqle9yUe88+YDj66K9yX7A24cMcWnUqDXXKlpMhgD+Uy9k
   kKQnhuJT3RmXQ3DkKSxuQfewTlZ+xn6YUlR7otBGyWnqwYeSciIAgLggP
   A==;
X-CSE-ConnectionGUID: 4UyWYPdxRb6eFDFyBNTU5w==
X-CSE-MsgGUID: kli9eFJYTRmp4eE5Ch5ZGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347665"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347665"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:51 -0700
X-CSE-ConnectionGUID: iVLn9aWFT3adE2wagS/mwQ==
X-CSE-MsgGUID: ostKvh4aS0aUELl57aRqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827269"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 13/13] iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response
Date: Fri, 17 Jul 2026 11:53:35 -0700
Message-ID: <20260717185340.3595286-14-anthony.l.nguyen@intel.com>
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

From: Junrui Luo <moonafterrain@outlook.com>

The VF allocates a fixed-size buffer for IAVF_MAX_VF_VSI (3) VSI
entries when processing a VIRTCHNL_OP_GET_VF_RESOURCES response from
the PF. However, num_vsis from the PF response is used unchecked as
the loop bound when iterating over vsi_res[] in multiple functions.

A PF sending num_vsis greater than IAVF_MAX_VF_VSI, or the received
message is shorter than num_vsis claims leads to out-of-bounds accesses
on the vsi_res[] array.

Clamp num_vsis based on the actual bytes copied from the PF response.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index ec234cc8bd9d..c4039d2b24a4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -248,12 +248,28 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
 /**
  * iavf_validate_num_queues
  * @adapter: adapter structure
+ * @msglen: length of the received VF resource message
  *
- * Validate that the number of queues the PF has sent in
- * VIRTCHNL_OP_GET_VF_RESOURCES is not larger than the VF can handle.
+ * Validate the VIRTCHNL_OP_GET_VF_RESOURCES response from the PF. Ensure
+ * num_vsis does not exceed what the message length can cover, and cap
+ * num_queue_pairs to the VF maximum.
  **/
-static void iavf_validate_num_queues(struct iavf_adapter *adapter)
+static void iavf_validate_num_queues(struct iavf_adapter *adapter, u16 msglen)
 {
+	u16 max_vsis;
+
+	if (msglen < sizeof(struct virtchnl_vf_resource))
+		max_vsis = 0;
+	else
+		max_vsis = (msglen - sizeof(struct virtchnl_vf_resource)) /
+			   sizeof(struct virtchnl_vsi_resource);
+
+	if (adapter->vf_res->num_vsis > max_vsis) {
+		dev_info(&adapter->pdev->dev, "Received %d VSIs, but message can only cover %d\n",
+			 adapter->vf_res->num_vsis, max_vsis);
+		adapter->vf_res->num_vsis = max_vsis;
+	}
+
 	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
@@ -300,7 +316,7 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 	 * we aren't getting too many queues
 	 */
 	if (!err)
-		iavf_validate_num_queues(adapter);
+		iavf_validate_num_queues(adapter, min(event.msg_len, len));
 	iavf_vf_parse_hw_config(hw, adapter->vf_res);
 
 	kfree(event.msg_buf);
@@ -2578,7 +2594,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		u16 len = IAVF_VIRTCHNL_VF_RESOURCE_SIZE;
 
 		memcpy(adapter->vf_res, msg, min(msglen, len));
-		iavf_validate_num_queues(adapter);
+		iavf_validate_num_queues(adapter, min(msglen, len));
 		iavf_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
 		if (is_zero_ether_addr(adapter->hw.mac.addr)) {
 			/* restore current mac address */
-- 
2.47.1

