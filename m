Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046077;
	b=fpcfwVhYxQ5r3CaFSIpzuKulx2w3P2xc2ozdCP+8nb1aB5pxrFn1xDgZANR4BV8E4rXP
	 g17De8FknXcECJOVXmUhKFT1jnQ6Sub6nB5cff8h77DEX+vQIF+JW80hK33muiWdTPE7f
	 lQQtOwvlthHRqoOuzvVOcZ2WvZmQDz7lVZiBKHvFNKD+qy54aqwuHFT7wexXqH8P950BK
	 /bc/GC9+AeVaDLNnPXHBWqGtsMMKlz8dOGNh9H0fcIHZbIciGZJBEaMqvgcQJ5e5qLNaK
	 2llV9S++Ac8wnR+yd/1ddGbu31hT+1YIVuEQNZBqvC+tSpirweAWiZ45frAx+zoj2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046077;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0BIkAGe/S/t8b8XZDIObxwOPsBl/Tn4xAW0yTM9BxnA=;
	b=loHgUmmzj7TubeL+1pA3kE3Mr8u4QPr1GmAS2JZFwZZVW0wCQ964gsIcB5BIUie0Tbcs
	 PbuRcKTfvK0jCDRlFtqOLGBtbEcqPwhjbW0UQU5ZoKP3XM2mzudn4MiGRLYG/fduphaw9
	 bxep9OUwp1VBDirkLDZULlZyjjuunP4YZ9dAPwXR+hI8Bv9nrxLHc2XrOXyrvQOpayfIf
	 RsiM494PcmcFmFMeymWy55Cs5hY1ZLcQSmm5yAuYGDXeX8wj/PxO0l/st7/g0tenwlshL
	 wBeSPeHPT0tEoSt166xjl5UE98ktRlkCLdtIZG9wY75Um4loHnvB+5As5bYKFWb9nqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9OTTGXw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48909606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9OTTGXw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC41F0089F;
	Sat,  7 Nov 2026 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046077;
	bh=0BIkAGe/S/t8b8XZDIObxwOPsBl/Tn4xAW0yTM9BxnA=;
	h=From:To:Cc:Subject:Date;
	b=e9OTTGXw2qZ5dEO/MPjVe2Ym07QxEen/14mhwkvf+ZbE9dRjVWnEjxtSYvBJVCszD
	 HSpo5MBc4lsA/hel6caI7XF19gZXwRo7minMFHni/sS4+LiTkm4gx75vuaM/O6aN00
	 xZs7kwoPs9qmLju50bzfPERqnUkjzVN70deNf15Q8ZRSpi5rhiLp2YysbabU8pRlhE
	 O/+C3/MHWSqhgd4YCSgyJ36GbWNZ5yondIT8j1df7pztnV4fToECvVud9IkpOq2xDv
	 HZzo9yR5PJ4mU5J+19kh+l4fZsi6C5uuGVBguBnp4/OkI5vjU69dMouJhXzIyufupe
	 yLgNDlc3nl+PA==
From: Sasha Levin <sashal@kernel.org>
To: lirongqing@baidu.com,
	alex@shazbot.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vfio/pci: Restore 8-byte ioeventfd support" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:55 -0500
Message-ID: <20261107050755-failed-6.18-b30b52c2fb82@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b30b52c2fb82e6d38ee2845a4d85e8254b44f3d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050755-failed-6.18-b30b52c2fb82@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b30b52c2fb82e6d38ee2845a4d85e8254b44f3d8 Mon Sep 17 00:00:00 2001
From: Li RongQing <lirongqing@baidu.com>
Date: Tue, 22 Sep 2026 12:00:13 +0800
Subject: [PATCH] vfio/pci: Restore 8-byte ioeventfd support

Commit b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef
ioread64") inadvertently converted a conditional 8-byte rejection
into an unconditional one.

Originally, 'count == 8' was rejected only if iowrite64 was undefined
(#ifndef iowrite64). When iowrite64 became globally available via generic
fallbacks, this rejection became dead code, allowing 8-byte ioeventfds.
However, b44a06bd28f2 removed the #ifndef wrappers but left the nested
'if (count == 8) return -EINVAL;' intact, breaking all 8-byte
registrations.

Drop the unconditional check to restore 8-byte ioeventfd support,
matching the original intent.

Fixes: b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef ioread64")
Cc: stable@vger.kernel.org
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/r/20260922040013.2188-1-lirongqing@baidu.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17a..df88480876815 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -423,9 +423,6 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
-	if (count == 8)
-		return -EINVAL;
-
 	io = vfio_pci_core_get_iomap(vdev, bar);
 	if (IS_ERR(io))
 		return PTR_ERR(io);
-- 
2.53.0




