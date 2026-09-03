Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572D4E235A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449917; cv=none; b=fap9Mad9AQqiIiUR+9FRC+Oasz2sPyMvRQsbd34oeTXKDlk87XtTq0d1w1VSpc9eERlFUx0z2iMtdLYv1YfJIj7fgDNqklhCAsJBIuBbARzHODP9/TqwnnLyRljFJ4Gu8InYPP6Ug6A7fE+nc0uB9LDRkU9w/nfSrjcuMJdCJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449917; c=relaxed/simple;
	bh=QoXktP4uGtw9wgU8iby0L5XetLaa/bq7YQ6JKhPAexg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VY3Tp6kQsZxhcR7uixRi9KZwUaQLJQXrWT9zA4HhixI5tcwOG8ULh0YtUq/FwjbrAU5SlBmR7DjhwY9qqKCT1UIe8jf9Na+42E/wCsgWStjQBojSmazZsFkVWqM7mwtW2FB7HHQrFNbFjfhd0zr6VWlpim2SDllv62IaIJWnPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ujQI1abX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ujQI1abX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1C1F000E9;
	Thu,  3 Sep 2026 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449916;
	bh=UmAgKl8Vrz97S2Qgq2vCUXUL1BN1K8N3dJd0V6oqkwM=;
	h=Subject:To:Cc:From:Date;
	b=ujQI1abXSLkKUVzI1m42QY5qjYTzgJ6bheXfjasSca/3mljff/8gY2TWZVjlV5fnQ
	 GJJh4Wl8DIUQSJ6QctkodPVGgDwbhQXS/qh6XPXTW45O+RNwGLsmS6xxndj2MswqI2
	 At2Pi5RYWODXpq4q/qJTdjiWSRyTI4DIJnLVppIk=
Subject: FAILED: patch "[PATCH] net/mlx5e: do not HW-GRO coalesce small frames" failed to apply to 6.1-stable tree
To: gmj@meta.com,kuba@kernel.org,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:09:10 +0200
Message-ID: <2026090310-fax-kindred-5230@gregkh>
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
git cherry-pick -x e2466392a0b8496000e12181cb1ee1535eb0da25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090310-fax-kindred-5230@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2466392a0b8496000e12181cb1ee1535eb0da25 Mon Sep 17 00:00:00 2001
From: Glenn Judd <gmj@meta.com>
Date: Sun, 16 Aug 2026 09:42:59 +0300
Subject: [PATCH] net/mlx5e: do not HW-GRO coalesce small frames

When hardware GRO (SHAMPO) coalesces a small IPv4/TCP segment that was
padded up to the 60-byte minimum Ethernet frame, the trailing padding is
folded into the merged payload causing padding to be delivered
to the user as payload.

Detecting and reproducing the issue: the selftest
tools/testing/selftests/drivers/net/gro.py subtest
hw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
In current code, it receives {106} (100 + 1 payload + 5 pad) instead.

This patch avoids giving the user padding as payload by simply not
coalescing small packets (which fails the subtest; the same approach
and behavior as sw gro). This gains code simplicity at the cost of
more computation (passing an extra skb up the stack) for small packets
that could be coalesced.

The threshold is chosen as ETH_ZLEN + 2 * VLAN_HLEN. This is the largest
frame that may still contain minimum-frame padding (+ 2 VLAN tags), so
anything larger is safe to consider for coalesce. (We do not include
ETH_FCS_LEN in that threshold computation as netdev_fix_features()
drops NETIF_F_GRO_HW whenever NETIF_F_RXFCS is set, so retained FCS
can't reach this path.)

Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Glenn Judd <gmj@meta.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260816064259.3279548-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 6fbc0441c4b8..6fc6605d2054 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2263,6 +2263,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
 	data_offset = wqe_offset & (page_size - 1);
 	page_idx = wqe_offset >> rq->mpwqe.page_shift;
+	if (unlikely(cqe_bcnt <= ETH_ZLEN + 2 * VLAN_HLEN)) {
+		match = false;
+		flush = true;
+	}
+
 	if (*skb &&
 	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
 							 page_size))) {

