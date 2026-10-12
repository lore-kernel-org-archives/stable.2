Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83547DD70
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838274; cv=none; b=CYBsUJIZeBByIYrdpSOz+Be4gCHjtAJslmnuAwsPglcAexjKxjcVMsZLOIhDE7TEeDKYbSg4dMQE6LnB835xj5HQgrfK4EA5vO4ssRSJNjZIaBLpLjF/bT0FHreUvqVIUTDXpzS4+ciEYYQzy7xWX9u1zpicp7R3LWrnIUpJAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838274; c=relaxed/simple;
	bh=w8I8Vr+kh9Ov6nEtt+AoHmJeYndyES1CdC1prqVNB9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJsTICZAt62SFilkcPLZUZYQUk2sDcvrLpaQevbbxovGKpOEjBAwUTfcziWMQoR+RqdF85sr7GK3kD0EANfIQMam4pLvW0VubfSA+ucKurilz6IHkeP/k5SXzmNhVi/QSApTKCF8zc+ja4sjSTOUBY3f80ESP0xN/NuwEokYVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kVWceD6y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kVWceD6y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6841AC1;
	Mon, 12 Oct 2026 13:51:08 -0700 (PDT)
Received: from e142607 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 001863F673;
	Mon, 12 Oct 2026 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791838271; bh=w8I8Vr+kh9Ov6nEtt+AoHmJeYndyES1CdC1prqVNB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVWceD6yqMECr6MTPnJSTzzhDahYXUUhFFnUPlgJ+2TZlRO4GOOzExhIBEqKXbqZ/
	 GcJPlmheVevZr0wuWuyfkZrISL7YMt0dVJCKaBdHVMXKpZee+K/nCtyMA3/Pg+SFjs
	 lLFRTGdZW27KbKiAq2eMCEzx0eROrVi+Ql3UWupM=
From: Liviu Dudau <liviu.dudau@arm.com>
To: stable@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	sashiko-bot@kernel.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 6.18.y] drm/panthor: validate userspace queue count against initialized firmware slot count
Date: Mon, 12 Oct 2026 21:51:01 +0100
Message-ID: <20261012205101.1275662-2-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012205101.1275662-1-liviu.dudau@arm.com>
References: <2026101232-cornhusk-quill-0ed4@gregkh>
 <20261012205101.1275662-1-liviu.dudau@arm.com>
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

