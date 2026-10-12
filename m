Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805015665C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819331; cv=none; b=RFrlzafo9/8sFw/WS8h4e3fOeFfW8hIzBRvIWN45Ai4JQPISw/sZNsAvspXQjZ0bQyDkPLtZkPyAc9rdQrX04u4KYnMALvjK79IVEEwDJWRsk/6BfTL5eYtvmYL/z6uwEMk13hvQF6htksX0BAKhGP+hUhGB+OFdmc6OJWoRGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819331; c=relaxed/simple;
	bh=GV1wicU12F6Cmfv5PX8nLXyLUJXZCOXwINDDQ35idnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOSUu7wfJxN5sQTVb8W57dWL6rMqUgS6khsu0RwvUNKoHXdFDQ1WEHm0TglF7bfFcWYstYDDZBqScG2ddMGAMUWn/X3eqxWgHkSwJAbw1zjxxuVflg3uiPCYEo9I2PF+97xNFI8l/quGWeDxg2Y9kU4jT1IvhpaJasSoGtRDzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFUQk8jA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFUQk8jA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE04D1F0089B;
	Mon, 12 Oct 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819330;
	bh=VumTKXp+lSVJjp/T3cc1IR60U7HxHbdeycmq2BoXlYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFUQk8jAjf2LPru5FOIf2UEh+vVTxZ8yjg8SBifi1jXlEwmg7UL8MzmD/SpBWx0rq
	 vzUaun95Io1O+qK0Of/bxyDgUexrcJYjZtYTNLhB6UmD1CU5SZtPGPLGRR4uq0N3vW
	 t9UwTRhdFoUjB5Cp8QYnlN0sT/S+I7fFegNpVQWlc83ixfSJCdmymji8HxlAu+k7tX
	 L6H9xvjGnHv7DIy8uDNF2b9AzE6yxUt9SABOa/lhBY39gh51sSFTyVv7K1AMDG6X1a
	 S/3a0KushYw7U/Mbw16g47voentSybJMUFar4XyUGrN3f5M/Aa433SBGC6QmyJjMRy
	 UP8lsxCLUWArg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Corinna Vinschen <vinschen@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test
Date: Mon, 12 Oct 2026 11:35:27 -0400
Message-ID: <20261012153458.1075797-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101248-ravine-unclip-ec97@gregkh>
References: <2026101248-ravine-unclip-ec97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Corinna Vinschen <vinschen@redhat.com>

[ Upstream commit 8538aaea10e141457bcb13d51b0d278c697c422a ]

This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
waiting for response from PF in set mac") introduced a duplicate
ether_addr_equal() check, so the current code tests the new MAC twice
against the former MAC.

Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
("iavf: fix MAC address setting for VFs when filter is rejected")

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260609213559.178657-4-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 436729a56dd4 ("iavf: send MAC change request synchronously")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index f1a01b8e2235c..ad906baa759d5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2546,13 +2546,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
-- 
2.53.0

