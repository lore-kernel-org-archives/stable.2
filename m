Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473732572F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838438; cv=none; b=dBMf4wT5FY4m1j6ijRDIo+bul83od3IvrXSGzxH9UVHoUIViHtJ87piPI2d/NG/0P7npwZuuCl8kbTo8Jqvi+yD2Q5qp4ZkQcdJg1dOUNNoqhcFxQ9+cGrELxqGPLY+8+bbU57ga2539sBiZAndY3/tWi4Nb/rV7gsQnd/7k8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838438; c=relaxed/simple;
	bh=UMp4vvjmWgHsPzrvXElX+AQu0B4+fVQUMZ5xzztZEp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ancRiXhN44Ugt1R7kiEawCYqG+IzUTKLBPL+8H6ew5sBfGHMwOMZsAIw3B4R6VxCeULpOGjmVlYD/zXRbmyLX0UWiJvitkN/q9Qo8UhGW18xG55nopOuj+yL2dwT5aEdn8pw6LKdwNFcN3j+e0yI3MT3ASBJV/mm1OxAEwvXGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TMDfqskb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TMDfqskb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D783169E;
	Mon, 12 Oct 2026 13:53:52 -0700 (PDT)
Received: from e142607 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF4C53F673;
	Mon, 12 Oct 2026 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791838435; bh=UMp4vvjmWgHsPzrvXElX+AQu0B4+fVQUMZ5xzztZEp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMDfqskb83B6a1EG5yJHuOB3Rfeec5cwo1MCysDaozisRzKzG8wdngoZjRPh6bo8u
	 TBzqc5tQ1VkfswOsgcv4TFsUKjH9tNYOfqm2aOBd98yTCGr7OrUKw3wwmUbnRLFpgT
	 TzwTHBruNQfKDI945GKmQIwDDIHP0YJGM250qOsM=
From: Liviu Dudau <liviu.dudau@arm.com>
To: stable@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	sashiko-bot@kernel.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 6.12.y] drm/panthor: validate userspace queue count against initialized firmware slot count
Date: Mon, 12 Oct 2026 21:53:48 +0100
Message-ID: <20261012205348.1275964-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026101233-operable-brigade-e932@gregkh>
References: <2026101233-operable-brigade-e932@gregkh>
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
index 2f80c47e1f54e..822b003893a89 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3412,6 +3412,9 @@ int panthor_group_create(struct panthor_file *pfile,
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

