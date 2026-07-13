Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F463AB293
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948774; cv=none; b=WPdFKO4MYuBHDRz2MJ0BJTyd//+4Ri8HAlsVbNmzSC/I83aJLIvog6NR7YsHvvZ79+YKxcrYu7mLXS29VjZedUcD85gL1sepxcJ2CP5eX9GHJ0vX/MdqJn8YCqtQEW9B73Nuvv0+7hsgQxGTZ+grjB6vfVexwEmsQEB7n+u3k1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948774; c=relaxed/simple;
	bh=PICjquxn7W1tq0dPphjF6nClaTkZEcrmImyVe7uca9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hq7TqpCAPSp/bpqhEUqCndYnONi1l53rnAr2gYnAn8x7Vu5pLgdjiFfjWcDNX14Dz0Mk6mH9vtYsNcYWgrQJ0ycglnQL/0vZ4St/R/+vBsWK4LVplITioOJNmHaBXEhN32L40KeNQt9rmfvPchhGvF6Uu7ZEYjCWg5/9o25rMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLjqAiGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLjqAiGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7CB1F000E9;
	Mon, 13 Jul 2026 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948773;
	bh=Yh4UkCrs8z8ctRU9UwhzlWGJElQmIOgNtVZ79ZPFxbU=;
	h=Subject:To:Cc:From:Date;
	b=CLjqAiGk2PAThzppdR5lpbzdhdkb+HKph9874ssqPUFZeWJVp1GXSLGW3UPriuRhy
	 PnoC3xwAc5cHWiDqGwl1pi+kPqCeuaZaR10+XlF+boxLIlK5cZFL5Gxyc/SolBn8rq
	 CYk2i3HyU5V1HGy4Hw2OltHQmC4C/2hy+M8KbxaY=
Subject: FAILED: patch "[PATCH] vfio/mlx5: Fix racy bitfields and tighten struct layout" failed to apply to 6.18-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com,yishaih@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:07:30 +0200
Message-ID: <2026071330-plus-jackpot-fb60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f2365a63b02ddea32e7db78b742c2503ec7b81f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071330-plus-jackpot-fb60@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2365a63b02ddea32e7db78b742c2503ec7b81f1 Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@nvidia.com>
Date: Mon, 15 Jun 2026 13:12:32 -0600
Subject: [PATCH] vfio/mlx5: Fix racy bitfields and tighten struct layout

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

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..c86d8b243a52 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,26 +158,29 @@ struct mlx5_vhca_qp {
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
 	u8 mig_state_cap:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;

