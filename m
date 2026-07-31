Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DC42E8C2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517025; cv=none; b=La+m0bOd1AJYIOsO8B9HYFWLjgPNcBSHqH0jRjPTrgXg4n46d5fuBl4CJbY9QNTim7AnDv0Q1nI3s2XQZYwW4j3IiH2XkhqTILG4hMSgITqOuD19KFPXWr15KAiuPuVnZSe7avjXtUJXkfGljSHQIOAth0QS0EwZ4DczJhcPi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517025; c=relaxed/simple;
	bh=Br+k1NGMeqsyOwkkDDLjvh0EWqV3z81Vj+st1zS+D6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmgsg+137fl75rRPSBuUhucus/YD1Ut0OUH7FdSSKifXBHW9uDl3sH80v/DmXih+w3Z9WnYQ5rVOBGmk2j0AjcEMd7GdBWrNLHOylbJAsTXFX9tPEdZy32zVnxr4X8UcUGhhCoElbYP52pIW1azKsVTLHWsYnnQH3YvoSvist7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0OB6yZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0OB6yZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250811F00ADE;
	Fri, 31 Jul 2026 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517023;
	bh=IWX97EF5RjsCJ4Phq8ZyD9AS6mWEegxL0RslSeakOQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0OB6yZdoArgq4S/Lco+2aXK90GATi2uwlnXSgfx1GsuzdKyA527C5ZuCUlmnBFB0
	 V7X1yofgkWpjEMqusSRma2X25fQoQN6YnE8FZATQoqOBe+YGl6puKXu0ZigmI0wHqL
	 dxwLf4QF3s0Bo2s/QG3eNrVPLJzZwzH7aeDEGY+bWXOz/3bBFLK4kMobAkbbI3OBpw
	 brsk8Wv6XxExgSevjmi0Cd2HvHpg6ZBTEyZzmG9VRnl8tgpiZPoPtdXFw9vGXH8J7W
	 9BfJO+RYhxgf1vIBfFikYapk8R1V5GHxw1TLblYY7lybtzoKivUYyHthPCMelvlYCL
	 ZNGOpA7FAQdlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 5/5] drm/xe: Set TTM device beneficial_order to 9 (2M)
Date: Fri, 31 Jul 2026 12:56:58 -0400
Message-ID: <20260731165658.883265-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731165658.883265-1-sashal@kernel.org>
References: <2026072950-giggling-gooey-3782@gregkh>
 <20260731165658.883265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit ba7fd163422877ad5a5cf31306a38c07d3932b0c ]

Set the TTM device beneficial_order to 9 (2M), which is the sweet
spot for Xe when attempting reclaim on system memory BOs, as it matches
the large GPU page size. This ensures reclaim is attempted at the most
effective order for the driver.

This fixes an issue where an order-10 (4M) allocation cannot be found
despite an abundance of memory. The 4M allocation triggers reclaim,
unnecessarily evicting the working set and hurting performance. Since
the TTM infrastructure was introduced recently, we are tagging the TTM
patch as the Fixes target, even though this resolves an Xe-side problem.

Fixes: 7e9c548d3709 ("drm/ttm: Allow drivers to specify maximum beneficial TTM pool size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260611235844.3725147-1-matthew.brost@intel.com
(cherry picked from commit 0d81db90d364cb3d733410829118759f28957c5a)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 58cec453b9ad..39465f4465a2 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -478,7 +478,8 @@ int xe_device_init_early(struct xe_device *xe)
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
-			      xe->drm.vma_offset_manager, 0);
+			      xe->drm.vma_offset_manager,
+			      TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
 	if (err)
 		return err;
 
-- 
2.53.0

