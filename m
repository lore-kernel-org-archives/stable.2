Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F31427A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195265; cv=none; b=f6JanFc3ueZtyPHPteB2Gw9iWOuEcl6htWY+i/hvErjpAkLHiXE88BZX4AbJToBeu4aay89kZviEkEe/M6rsYkp4dkjC4vry9VNZNwk88hlrtZLGiy0Q/7QNfOm29FFEofnT0W0L6d3XeIhi+SIJwZYwXrvvxV20Szn5I46PfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195265; c=relaxed/simple;
	bh=nAuv/7NdCC+0ciRLy4Nz84UmG+QSUsSrYcVvd5NPukg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPyndU3y+BH56PIl//b48AY7VAyQ0yZABcFepCjcbrS6DS7sjcf96Rk/cFZSf6lJPRIAEWXZuHhsuA+WxTHWxD3Z2YW0x8vVBhTq1Pp9wx/EKSGkRpLPTTkVpzmNjp3i2bTxIjIqiOOA61droxOTRk7z4pW+3PJk4NmFhV0PmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyupDKr8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyupDKr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9D01F000E9;
	Mon, 27 Jul 2026 23:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195264;
	bh=BsHfypMgaGhX4MzauigOUYjAYIQdT8fLijWH6rEy/xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WyupDKr8SMlXOX6sQ2QZCYACjotTtI67SjcmcgO3yTmK9KbF3cLg72KFdjfNefc89
	 dxRiKv4Qlt/avgWLeLC82vjwJcUpkU3QAHEZRsqfH+Z9HvlZTBcw4LkB9cdYFRqQhB
	 6GXsCZuKwj9+PuTQ25E9frJtpcxslAR+83Mw7O+iN+M+UY1QftyhvjkTPBaP49h4FS
	 r+VKKR6hmP1xe55UzDblVHfoFqGiHA7VeBHZtcVRamvWScNGNLyBtj/hbGd8j+DzO8
	 wIa+gxonXL2Iqn9h3o/9CO/teotdpEzUJdB8yvVdegHpa0jX/eKpEvc+AHXSfq3pY5
	 iqti/bWZagLvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] fs/resctrl: Split L3 dependent parts out of __mon_event_count()
Date: Mon, 27 Jul 2026 19:34:15 -0400
Message-ID: <20260727233421.2423844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072028-reverence-sandy-7415@gregkh>
References: <2026072028-reverence-sandy-7415@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit ad5c2ff75e0c53d2588dfc10eb87458e759b6bbe ]

Carve out the L3 resource specific event reading code into a separate helper
to support reading event data from a new monitoring resource.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
Stable-dep-of: 52fce648607e ("fs/resctrl: Fix use-after-free during unmount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/resctrl/monitor.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 7012a75814ac36..cdd5070d9ec71d 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -418,7 +418,7 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
 
-static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
 	u32 closid = rdtgrp->closid;
@@ -499,6 +499,17 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	return ret;
 }
 
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+{
+	switch (rr->r->rid) {
+	case RDT_RESOURCE_L3:
+		return __l3_mon_event_count(rdtgrp, rr);
+	default:
+		rr->err = -EINVAL;
+		return -EINVAL;
+	}
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
-- 
2.53.0

