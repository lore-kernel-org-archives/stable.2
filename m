Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97E243387
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525896; cv=none; b=Dtt/HxC3qNhZCP6vpsnlZx946mo2R98eqyFQrGwKr8ZGaLuG6V7Zs8QPeY7Q4Jto1+hBUOXXqMHoWAxTb1xbrMi7lizkhZjmYpVvJL1azB5YUCw81Tmp5dKfSHXWzpY3XdnqefRVxHI8wyrfNsLyyNhwVDVhmrUz6wt9hQJRCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525896; c=relaxed/simple;
	bh=djRQWAKmsE7opjkimqomGp8otja1QBj8YkpiFlIjaXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8nIAovSMm3HcgRf/DVvFas9kP4WtRaOALG74imFGglYhPxU0uAiiiqUtrndhuykqzILlx4w4SeBWWZCHYz1laIv/g1H6CN/2ROLZtNARBPkfeW5u+bWKs7b5u817NvajTFujnrQcV0sUEcA3Flr2Zc1+Z7JS/g8WF/RWlneUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI3Oz6cZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI3Oz6cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2234A1F000E9;
	Wed, 12 Aug 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525891;
	bh=cKE/MSSYmUEufJHhvp/+k+jaqSfpnukUy7TGaPEFiFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZI3Oz6cZUzfthKOaSFDsLT1xFGiqcU6tN3r3xRhQhtaod1+B5q8l1ZTxsHLalcNlB
	 JC5KppGLCZOj9r0+eLWau1iQwkPUVT2usNEKymVuEFzixKMfPGPSPaZF4D5+OXd3ZL
	 7oTIaOUAXTS65oV0b6s3hu5ICQFmICigDPVJKZMj8UcKJ05tzPg53bCXAqd0ZfQo3/
	 BeW1xL9goGt5IlW70+SzJVBBjq2rpvp3czNF6RoXsisqYWK7dn1AHry70J3Bas4r3S
	 vDRvpUFNytq2PsdSY7koaki37K8SMWvz4lzWCQNCa3FjnALWpPueKxoP58pR2f5siH
	 KPK/o9Y9tqv4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ice: fix memory leak in ice_lbtest_prepare_rings()
Date: Wed, 12 Aug 2026 05:11:29 -0400
Message-ID: <20260812091129.1349712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080525-magnolia-rinse-caaa@gregkh>
References: <2026080525-magnolia-rinse-caaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit 3a9de5590da4ffd9e9c541c4c4d492aa2b54cf6e ]

ice_lbtest_prepare_rings() frees Rx rings only when
ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails
after allocating some descriptors, or if ice_vsi_cfg_lan() fails after
the Rx rings were prepared, the function reaches the Tx cleanup path
without releasing the initialized Rx resources.

Fix this by adding separate unwind paths for Rx setup failure and LAN
configuration failure. The Rx setup failure path releases the partially
prepared Rx rings before freeing Tx rings, while later failures first
undo the LAN Tx configuration and then release the Rx rings in reverse
setup order.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Intel E800 Series adapter available to run the ethtool offline loopback
selftest, no runtime testing was able to be performed.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 1ef57db5e6562..f0a5bc06864d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -489,18 +489,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_cfg(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_cfg_lan;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
-		goto err_start_rx_ring;
+		goto err_cfg_lan;
 
 	return status;
 
-err_start_rx_ring:
-	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
+err_cfg_lan:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+err_setup_rx_ring:
+	ice_vsi_free_rx_rings(vsi);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
 
-- 
2.53.0

