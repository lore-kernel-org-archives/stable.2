Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793783EDE68
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527155; cv=none; b=kBCvTIUp1YnEp0WA9TK2WLUQsW5MtwfcVCZWn40cOXCl1BU1bdp08/ZuwNgWjyh40NkDsckDB8iGT1qoiBk0qz0CEF9iiwe6gINUsH6OXNtedglLvrPvNNIEDDjajlAfRnX4Ns6FscPIn1ejp8V1It3jbSy7UYdiqBQTqbTmReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527155; c=relaxed/simple;
	bh=hjvanSM1osP8SbZCKE7bZhOwJHmvjklK0lg753FItp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COjNNBzZRnqLsgkM3GfnwA7HBy3CHYZ9E6J/KV5mIlQ8I8h+/ZXs1fYj7UvijJOEseigqf8fUj/4in8Zj6ALWuC3A4AmNd437IC5mtdSbeCGolhiu57fGgSMtF6QCGRC6cQLWTYXhNEw4GilnB2bXfnn4tAv+5dEAKzSVFqrxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/arMNiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/arMNiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646D11F000E9;
	Wed, 12 Aug 2026 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786527154;
	bh=1wFHtvcgDtR37Hqjh3wb3J/FEBlVfto1Wrk0mJpEirA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/arMNiUwVpl0KqUAcWZPq8EMvOWrAJLClegEOZwu9lkA8zsneeCP3mjUejdrJFfY
	 munjdTrnAuiQc7WplrtoqRp8nrcZuhggUHVuzDsXcMjfV/OuzBgIYvOeH73LY2MZtk
	 J/QX70K4sh70FXyPAMEw/v7NJeXPlInqH4J6BPNAghgX1CgGNQyLnQZ5PB72SvQVUB
	 74qsGxNuMhiy4elhQ7QuEojsKI95So6bu6caobjvbN9ti/LRCrzPUDAEhdF5R1IpEf
	 kevyAPDlNmhIbcH2t5RWseEhZ8mjKne6Ypigcg3lxyQd4pk6w1XvyxfXUiLhhmWh4O
	 djM27DKfAE0oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ice: fix memory leak in ice_lbtest_prepare_rings()
Date: Wed, 12 Aug 2026 05:32:31 -0400
Message-ID: <20260812093231.1522389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080526-defeat-eardrum-280b@gregkh>
References: <2026080526-defeat-eardrum-280b@gregkh>
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
index 7f1bf71844bce..8083b63c4b310 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -478,18 +478,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
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

