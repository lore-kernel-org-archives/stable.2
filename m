Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9929D270
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035632; cv=none; b=h3eQw3llIlK1j3UQ4FvaeS81GDEeHYRJQUJwvhB26Ydkir3YfP3yQlDHNcGy605M+GUdWWY1yMjG9yL9nnBUQ3qzhal+Kg60UKzH7TwNK2FuEzW6G2wfxNiVhEbJc3YYpIEp9UB3u6MIEIDOfsxYzM1ob1Jax1WS30/5efF490E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035632; c=relaxed/simple;
	bh=4gtc1Atl/reaPLFpiFy49YLPGaA32T6kUO3QjS9u4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC9bO25gbM2kidafgdGsQQ5SLKXCqPulbFMhRLRpH5q6IpLL7cEOC4kHo0CBQUWR8aJd0HLcxSq8sAraUMOslEnHtgMsAtj6jALb9u7DaqkCnF8afmfn0bAOrhLU45fd1iUxMnV3pFWcEJunqmJO9Zp9fDXc1wCa72fryfo7www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJRR4+HB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJRR4+HB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EFD1F000E9;
	Tue, 14 Jul 2026 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035631;
	bh=36b99Og6kWEkF94Fv0JrkfA7SxMdJDW+WBhx1HNSiNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJRR4+HB/q1KCNYYx7nTggg7CWeiqcgVUG8u875DWzmPb1h8JoZUQ/ihJ3ssTG0LI
	 S3YGQ/NjbsHgXpcyUV4t0sP5zKjq1T0n7g1ksM821vCKMqY5QmPUOgcQ9emYGPXQl0
	 Y/dllq7graUi6zp4ICxnWJ5yyYGf81EOwafR4J52JXq5JSXxPnLkiPpC3SDjLhciaO
	 dqD4FUN0wSHtxrsXoBH4NkddCFOdSmG/c45epHyb70rRCIRIdmU3tTYjouSIGTjQPA
	 NMlBCDwBYIBLXs+KwmfwKC6+wXsaHAnzHwbOm/Npd6msN1N+yB8+CFzcEIML/sVZuh
	 TWbkLBjZQgnvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Tue, 14 Jul 2026 09:27:08 -0400
Message-ID: <20260714132708.2663976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071330-plus-jackpot-fb60@gregkh>
References: <2026071330-plus-jackpot-fb60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit f2365a63b02ddea32e7db78b742c2503ec7b81f1 ]

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note mlx5_vhca_page_tracker.status is relocated to fill the alignment
hole this split exposes.

Bitfield justifications:

  migrate_cap: written only in mlx5vf_cmd_set_migratable() at probe
  chunk_mode: written only in mlx5vf_cmd_set_migratable() at probe
  mig_state_cap: written only in mlx5vf_cmd_set_migratable() at probe

Dedicated storage units:

  mdev_detach: written in the VF attach/detach event notifier
               mlx5fv_vf_event() at runtime
  log_active: written in mlx5vf_start_page_tracker()/
              mlx5vf_stop_page_tracker() during runtime dirty tracking
  deferred_reset: written in mlx5vf_state_mutex_unlock()/
                  mlx5vf_pci_aer_reset_done() during runtime reset handling
  is_err: set by tracker error handling and dirty-log polling at runtime
  object_changed: set by tracker event handling and cleared by dirty-log
                  polling at runtime

Fixes: 61a2f1460fd0 ("vfio/mlx5: Manage the VF attach/detach callback from the PF")
Fixes: 79c3cf279926 ("vfio/mlx5: Init QP based resources for dirty tracking")
Fixes: f886473071d6 ("vfio/mlx5: Add support for tracker object change event")
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-5-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/mlx5/cmd.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index d7821b5ca77293..82831e0483c09d 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -155,25 +155,28 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
 	struct vfio_pci_core_device core_device;
 	int vf_id;
 	u16 vhca_id;
+	/* Flags only modified on setup/release - bitfield ok */
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
-	u8 mdev_detach:1;
-	u8 log_active:1;
 	u8 chunk_mode:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.53.0

