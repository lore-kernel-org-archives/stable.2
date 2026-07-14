Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18073446DE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999990; cv=none; b=oaxYvqlCCBCbTMG4rdriCzPUS1PYKSulRg6VD2kBIe9W9KwENeI3zDPypev6hDvkXlpRY8uY1MjTdNxfhC3NkdodJPiz2KUQmJVwIYxyVxvhNy/joG7DLaMMOYtUP5dAQul81IMjvcBIBTYIAAzVwB5LnKE3X8iycm5Ds+pbDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999990; c=relaxed/simple;
	bh=1N0IY7N/6XMvZF7U6elx+lv8qcqgY1rZa/7xp+itAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn4KZoOfPfFT1uO8+gQ86/QoUZO0/WW+K5pcw3w58TVC2QvURYkOktpNAIrnTM1h5Etl6zZHOU3LSSRpwZNylmmkGbOR5384yCkQabrinhA+x92QEnCjusrYRzuhmOWcApf8LJRiKHUiQEUSswwsP5iP1TKIBVx6QhcAOUdgNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHG0+JnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHG0+JnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6551F000E9;
	Tue, 14 Jul 2026 03:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999989;
	bh=Ts2vplMApUb8gS2fFc1kKhqwHRPZ/uhI4zjYisA0/II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHG0+JnZIOeUKnstFRdgt0eCNOZeGEbrryIJtH8uDrI/GeVNA5soplptUJgmqoMQO
	 uAocOB9hFUsbVwh/lKdAaSw2WvPYoGcxdP0AcgQ6SkUm4nPJeQmJ372DLoio5mGKhy
	 yz6qz8XupzjYv7IYALlmSEWCTEKFpDV5ai9jFaGcj0YCgM5oq+sm2n5T9q1B5dAT8+
	 ft/rjj4+IJybKH8j2mOGKXRlWdGrXvxmCOl6XCBjMQ68i4oniiluGhNuE7/M5WI5Dr
	 9ABQW3958T2NaV3hOh3YnwY1VNbgVpmxJjGxfPCV7SmoFBzdHif5s/1eydp83OSN2l
	 TYTtJMW6UpE4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] vfio/pci: Use bitfield for struct vfio_pci_core_device flags
Date: Mon, 13 Jul 2026 23:33:05 -0400
Message-ID: <20260714033307.2397254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071301-corned-default-6f79@gregkh>
References: <2026071301-corned-default-6f79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 9cd0f6d5cbb6fda09aa83beb8146c287a552017e ]

struct vfio_pci_core_device contains eleven boolean flags.
Boolean flags clearly indicate their usage but space usage
starts to be a concern when there are many.

An upcoming change adds another boolean flag to
struct vfio_pci_core_device, thereby increasing the concern
that the boolean flags are consuming unnecessary space.

Transition the boolean flags to use bitfields. On a system that
uses one byte per boolean this reduces the space consumed
by existing flags from 11 bytes to 2 bytes with room for
a few more flags without increasing the structure's size.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/cf34bf0499c889554a8105eeb18cc0ab673005be.1683740667.git.reinette.chatre@intel.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Stable-dep-of: 4575e9aac533 ("vfio/pci: Latch disable_idle_d3 per device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vfio_pci_core.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 367fd79226a306..1c56c1df163cca 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -69,17 +69,17 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
-	bool			pci_2_3;
-	bool			virq_disabled;
-	bool			reset_works;
-	bool			extended_caps;
-	bool			bardirty;
-	bool			has_vga;
-	bool			needs_reset;
-	bool			nointx;
-	bool			needs_pm_restore;
-	bool			pm_intx_masked;
-	bool			pm_runtime_engaged;
+	bool			pci_2_3:1;
+	bool			virq_disabled:1;
+	bool			reset_works:1;
+	bool			extended_caps:1;
+	bool			bardirty:1;
+	bool			has_vga:1;
+	bool			needs_reset:1;
+	bool			nointx:1;
+	bool			needs_pm_restore:1;
+	bool			pm_intx_masked:1;
+	bool			pm_runtime_engaged:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.53.0

