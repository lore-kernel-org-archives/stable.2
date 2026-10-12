Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF043FD29
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838277; cv=none; b=itkW5YqXLx5RoIfIJYixv0/BHlj1Iwz/ykm2HymwbogIgzhq/uTDicQsCmIZW2ADM1AXCO6/ydpMCCznCtCvtarDPqCKfGA+5Uridqcouza2XHnT2BWbvw1Wlbypi9Km55paTiE7wHRTsFARNx/FP9iWp/94jtdI/wrITeBhdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838277; c=relaxed/simple;
	bh=w8I8Vr+kh9Ov6nEtt+AoHmJeYndyES1CdC1prqVNB9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXUHof28HN0AUl9EDBPpiebBP9MLA8L58x7DXJ6YCGiHZQ56B91XMDQ6S++XgdVSlBpOC1W8QdCZn1sXARNR6YuAudo2V8FuS52Mepy+YjLS+dMIUZNyJz2Mc+rcTeXA9rJRaYN4I30GNBANSJhegyxDONM7u5/0BBWHeJ3drgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lCuE0QP4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lCuE0QP4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D9D169E;
	Mon, 12 Oct 2026 13:51:07 -0700 (PDT)
Received: from e142607 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E83A53F673;
	Mon, 12 Oct 2026 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791838270; bh=w8I8Vr+kh9Ov6nEtt+AoHmJeYndyES1CdC1prqVNB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCuE0QP4Sosb1I9kTP8xTI1ukY1j1wr6bV/Oa3sNzSGwBTtm14O4BzC8RpD3D4+XX
	 Zl6mcEGFJSjHVYRiSVjrbtnh3xuYfOORUb/rWsklHCfQnklvzGHboxzJmeJQ6f6wyR
	 9lafLDSCEJrkKetbtyV0qPVLAl7mxIclGQ91k1N0=
From: Liviu Dudau <liviu.dudau@arm.com>
To: stable@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	sashiko-bot@kernel.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH] drm/panthor: validate userspace queue count against initialized firmware slot count
Date: Mon, 12 Oct 2026 21:51:00 +0100
Message-ID: <20261012205101.1275662-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026101232-cornhusk-quill-0ed4@gregkh>
References: <2026101232-cornhusk-quill-0ed4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Osama Abdelkader <osama.abdelkader@gmail.com>

In panthor_drv.c:panthor_ioctl_group_create(),
the queue count is validated against the hardcoded maximum:

	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
		return -EINVAL;

However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
panthor_fw_init_ifaces() will only initialize that smaller number of
stream interfaces.

If unprivileged userspace requests more queues than the firmware reported
(but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
uninitialized stream interface and may crash when dereferencing
cs_iface->input->ringbuf_base.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20260804160048.174148-1-osama.abdelkader@gmail.com
Signed-off-by: Steven Price <steven.price@arm.com>
(cherry picked from commit ec86c43dcfff68eab4db9bdafcd3e2b16e342e18)
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 85e24ca474484..08008a667b1bd 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3549,6 +3549,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > sched->cs_slot_count)
+		return -EINVAL;
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
 		return -ENOMEM;
-- 
2.55.0

