Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF64314BE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930234; cv=none; b=kvTcMshOyY5uhr3S79HEpujq2ExESGMrfAzFzAcWNdxNTkhsgeo37ibKlqpUu4wQ0S0nSj3eDpM7QJSkx4w2xmTwgcGhZmtv5jZiLa2zN6TL+ymlQMTuDW3OGciIWaIJhe/if+vds/RPC7cScNLJVFkphlYI/323JgqhcQy110M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930234; c=relaxed/simple;
	bh=Hx033WMuaFk3nNLuqqOArzReN6XuhGs32RmND7peJsY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J3ku6xye3OFkZ2R9d7yyeladLodYz7IBIXmqThTvH0dhsfsihAHpfoZTC4/S4sncIYnwEmPncyDzJz55ETqGa4bZi+pyanNAU3sq6yHDfd5SvlNOcW7p8CunbTRwjlSbBoI2FsvF8YayJeNEMLQJFLFa5hOTyIPpY127iB+VfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vAH91C7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vAH91C7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585881F000E9;
	Wed,  5 Aug 2026 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930232;
	bh=yFJ3pq/dhq14dSfwFYvyge1B2SyrIM8GPyqw11xO0m0=;
	h=Subject:To:Cc:From:Date;
	b=vAH91C7PU32SS7ItPEMidQZdslgpDEjPj3syp14TOnijATbV3r6hKe7bYY1I3P92u
	 FLhzQODQeLT0zgYwKAI/NES+qGq4G+yKMIptml07bzg9tRnmg/8N80SoBuydDAel/o
	 R5QUIXeGxVo0/H5F5ZLFCLTMNPj6x1seGpCI/L98=
Subject: FAILED: patch "[PATCH] ice: fix memory leak in ice_lbtest_prepare_rings()" failed to apply to 6.1-stable tree
To: dawei.feng@seu.edu.cn,anthony.l.nguyen@intel.com,jacob.e.keller@intel.com,sx.rinitha@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:43:25 +0200
Message-ID: <2026080525-magnolia-rinse-caaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3a9de5590da4ffd9e9c541c4c4d492aa2b54cf6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080525-magnolia-rinse-caaa@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a9de5590da4ffd9e9c541c4c4d492aa2b54cf6e Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Tue, 16 Jun 2026 23:57:42 +0800
Subject: [PATCH] ice: fix memory leak in ice_lbtest_prepare_rings()

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

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49371b065845..7eb380be7ed2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1069,18 +1069,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_cfg_lan(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_cfg_lan;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
-		goto err_start_rx_ring;
+		goto err_cfg_lan;
 
 	return 0;
 
-err_start_rx_ring:
-	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
+err_cfg_lan:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+err_setup_rx_ring:
+	ice_vsi_free_rx_rings(vsi);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
 

