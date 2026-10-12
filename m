Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466039AD2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823507; cv=none; b=Atb3OGiAo2G8hG6/O9jpuwgS8W3zc+1vShDuBu6TremBQnloKOubMPs7uTFzxCSqTffEGMiFhJFN6EWJlLfSn8l94uQX0B2q8eXuCwW95LaS4728dBYhFM/Muxl5vpVTjd+sHi+qt0n1a5Pw3tsnPiwLl9QsMNeYt9ciU6gEC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823507; c=relaxed/simple;
	bh=QgiGPbVvBLsH6/K7XwHw6Z520McePgS7/g7sX7rZTUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZaGuczNtRcgp/4aKEIlGjrC+2lNHJClb2ziqISqfiNH7FiEtUAPTNoRbXwYC+ODVDqM40Ugc0mNph43ssZJ9g4EBAKW1u5jRb8xa3yKLHc1IYjMKvuGtWHT7H2azEPh2/7FtMnihYf9bO97oYmds5YLS6TURVjmEH9Xxmwos54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2zD/rcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2zD/rcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432221F0089B;
	Mon, 12 Oct 2026 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823505;
	bh=tHglsPWHjqTJgSMQNmKXkwL2A1kBAdC2WpkaLT3ShiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2zD/rcK4S32nA/Yw5HF/v5xQD7bKfjZ061OyyNHQev8SAKbPPvDQbaaUXE0EYSMf
	 T6kH/UNibAUZU2VeNfM2hbd75rNqjRRMsCeUOy/orCp1iC7s9f/xcxKbtox4y6KgYR
	 zs1we9LdvF5aMIXXBJNDffF3q5+2tqfjpXu//5VSCf96/+F9gu4ywKML+/HWbf9yRi
	 BbWx9OiVV/b0Ag0jPTfr4PFJoB8WR4ObyXjQfU2RbZqAa+8AgouXL+oDOgGWVX3ftX
	 0ZdIzTV6mqX79b77s4wrfkaw82/MgfFchMtmBd8g2u25nULGp4lyBaQX/pJrkBbv/3
	 qyK0P/exqgfiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ice: fix metadata_dst refcount handling on representor teardown
Date: Mon, 12 Oct 2026 12:45:04 -0400
Message-ID: <20261012164443.1180507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101252-voltage-purveyor-a18b@gregkh>
References: <2026101252-voltage-purveyor-a18b@gregkh>
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
index 7de4a8a4b563c..569d1b95ec1ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -235,7 +235,7 @@ ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
 			continue;
 
 		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-		metadata_dst_free(vf->repr->dst);
+		dst_release(&vf->repr->dst->dst);
 		vf->repr->dst = NULL;
 		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr.addr,
 					       ICE_FWD_TO_VSI);
-- 
2.53.0

