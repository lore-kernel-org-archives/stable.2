Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC031D362
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820948; cv=none; b=t2flY9ZAaG+AfZx5g8v3EoYTQmfKaL/K3kECm5a/hrvbiabaU97Tz3uqxWnrgA3zQ7kERBVKEZxkcgTO5AvHPvTah19G1MDSkOrXtx5ksMPEw+3hximvWgsH3DsVlMc1O+1ZjStNWUoNEGvSOIrn89+klRE45oQF1b/muIpCDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820948; c=relaxed/simple;
	bh=IqM9LXLFu9ch5YcS7HvRzOKSHRo/R2g+GDpcSWzWvKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTFBXiG5w4WRNUaIZgxPhb6CEwowNPjfU3QPYobgcCKZuI7t4R+1MYx0AizTuSbLnCKv9BDBzdX6qMtugeqH9QGL5njeFta/DJ70pGZiI5+olsMu+xPBm3AD2SB7+GS+TwsJa9JoTxPkyBB8WP1RsdXs+yP1IbTuqdhLHFWyQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmTDRDyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmTDRDyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC511F008A4;
	Mon, 12 Oct 2026 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820946;
	bh=re/3jYfqI4ECN3SegX6HW7P7/ZHs4pqzMs5PGqi/Wd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmTDRDyQiG9Ahuk+HA9KwirjDRJm8QRhQqkFehPVz493xF1clrXgRmpuUTmvTWu2N
	 9eX8TRWo7jSHFtuAYjIUNgu9ZEZoTr79g41ND8KoKZQksZLJS/D9GGoYtGBrP8rho1
	 fxUV3dB5HZPuLJUaPUoIKm5pxsnI/f4E4kd94U24EDjvtf6NToAHGz53gS4HrVZJ0K
	 ZdHfCP8WJR03QwTZkXA91ZjsL3Rdc9TWMSE5Bgz1Oo1UyUUMv5ZBSewgMruF3Iz9Hp
	 OjVFhaqP3QOb85tfTq6gH35BX7q8ECvySCH5zwMs6KZqkBp8onVvOrORfaFK5ud/xp
	 CBwBd/qoUR3Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ice: fix metadata_dst refcount handling on representor teardown
Date: Mon, 12 Oct 2026 12:02:24 -0400
Message-ID: <20261012160152.1105374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101251-unease-coastal-c9ea@gregkh>
References: <2026101251-unease-coastal-c9ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 58858b8f14803a7eeac297b3ce20f3b21bf2ff66 ]

ice_eswitch_release_repr() uses metadata_dst_free() to release the
representor's metadata_dst.  metadata_dst_free() directly frees the
underlying memory without checking the dst_entry refcount.

When ice_eswitch_port_start_xmit() processes a packet, it takes a
reference via dst_hold() and attaches the metadata_dst to the skb.
If the representor is torn down while packets are still queued on
the lower device (e.g. in a qdisc), the metadata_dst is freed while
references are still held.

Use dst_release() instead, which correctly decrements the refcount
and only frees the object when all references are dropped.  The dst
subsystem already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Other drivers sharing this pattern (nfp, airoha, bnxt) already use
dst_release() for their metadata_dst lifecycle.

Fixes: f5396b8a663f7 ("ice: switchdev slow path")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260928230429.495442-5-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adapted repr->dst access to vf->repr->dst in ice_eswitch_release_reprs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index e7f1e53314d76..528ca4be2b648 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -207,7 +207,7 @@ ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
 			continue;
 
 		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-		metadata_dst_free(vf->repr->dst);
+		dst_release(&vf->repr->dst->dst);
 		vf->repr->dst = NULL;
 		ice_eswitch_del_vf_sp_rule(vf);
 		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
-- 
2.53.0

