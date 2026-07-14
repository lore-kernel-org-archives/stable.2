Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B226FA5A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047100; cv=none; b=qtBJKq5LXRxcDpd9IxKKDaI9TVf9i0RFw4GxLIhxPNLk210T9YoVgWpSDG4WVFE6QkEKFnVYQ5V0BcideCwa+OjwCQQsyiY5fFSSPTGNwNwy4dbIXRgSlDfN94mngLa3duqR3Xf1mj71tBU8YT+UoRq7zqqP+ZR72WqdrC1vP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047100; c=relaxed/simple;
	bh=/ttAlaUearU8Aom2c668kQqVcyp9O9qo5x2crFlqFm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP1H9aLkaav7gJ3fkM4XLhwy/QUXBhAi4LNDbn2lfEFtdc3BfZha6zmIqMnpqP1Qt4aXBe6e8dKsvA05z9AKUCNGl3HcAnuut1oexzqKqggk4zN6OWSZAxzCC3Q1wLPnOqIthWIZKr4lqKdhJH9jXz49hmKoJmsFchp9+2hWNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swyl6FPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swyl6FPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602601F000E9;
	Tue, 14 Jul 2026 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047099;
	bh=pQXyVPQ2MfDGk1Hk0+KBPD6wModGtRhX3PFDqWY55TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Swyl6FPNw7fCzCiWoZgi05+iyReozCRNbFPHItPrchwsdMngIOnBLU4m6S9+v5aVb
	 o+anO65EmRA6nIUNeVMdXiygsG3whtJn3Zgw18J2Zgmk6DaqP3r4n3AEcA5pSncCGD
	 /4AGKkXxlISVvN1YOEt7/j6TGiaTNyGtkAGss6F+XcyO42+6frb74VlTudUsXUaAa4
	 wAQWPvgrRnrxercisk8/9YPZlIYl1G5CaUWdtjtbX4wfZSmnskYOR3PMnJVeGsB4I7
	 ybNSOdjOCZStFd4rrAOKHNgbq7YDRQ7K2iJtYnwj6s3y32+T2rhGLkKFDcRyqPSfsA
	 fAXEK8LcJw2NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Tue, 14 Jul 2026 12:38:16 -0400
Message-ID: <20260714163816.2850342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071303-justly-shown-9b1c@gregkh>
References: <2026071303-justly-shown-9b1c@gregkh>
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
 drivers/vfio/pci/mlx5/cmd.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 921d5720a1e57b..40f23c33680058 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -82,23 +82,26 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 is_err;
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
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.53.0

