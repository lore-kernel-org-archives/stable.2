Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045832;
	b=g4xjnOIcaqSR6VPxEX2ojOC+9OjetdvlQVgTAA6HCMRTeFF16tVX/AjvGGUDvHs28A4T
	 ZiFcmfNQCOn4owzOyNbishj0MxoTst9JpIeJIKyRpFHFmkQuYc8P11IJZD0w76OTM31KI
	 JrF9r0RsuhTK+qabDNRokWs1m1BWEwHaSkA0j5LOj67jbB+qk8WadOpmkXe92usx01cwx
	 fqqL9vh0PZ/6dpaKBhN4rVym0nYJd6+KjDQA3MyG3YLnjDK39zLAbugWTlAtuHOtr7f75
	 h895GY1eamXNW5ksDqdeMmEiH6QabhAITHQSCfN8dMolQs0yqu8mh4k2x15Hln+78vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bhocuNtpghK7qZmoqL+Z1/5zhyPOdtmFJmpz0YK/agA=;
	b=Z4uTVL1/dgxIgJhFHMZJsHV8BX51Q8cZbWp02JyplKqOzzqZjO/cD/AGCLZCMs5nx3+b
	 r4PZok7bKQHmO3nPdVtSffK9+M0wcCRo21Cf9qZJhuyNL0/NKRaxF4QnC/MZTbV2U96r9
	 C+7ruQT/a6rLiW6jroLeO+s+YdyEYXLjOgAlWLVBBAUCUzEDnoyuRyHJgWzA+GEgSqEyd
	 brsIcA999TbIQLsSwreAXYA1fsXnOG3w6FP1OE0rnDBL711YYj9L/tUFinszJrAQZ0EDy
	 XxaRXKjclclEMV7bNAxBkmecbHi1DFEQF0ijJ35oWdgwVyRXhOiNakZxhHnf6qyl1GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgRywQZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgRywQZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641611F0089F;
	Sat,  7 Nov 2026 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045832;
	bh=bhocuNtpghK7qZmoqL+Z1/5zhyPOdtmFJmpz0YK/agA=;
	h=From:To:Cc:Subject:Date;
	b=BgRywQZQIdLwoOIydGLlwui5RHEE1co4DwczcEFVlI2hKhkoa6z/yMBBUkHejdq7s
	 FBx0tmtjTV3Ubmr941D3DfmVdkltYLIgsW8FBNqiJK4VXbSfyaKJOd0CV//krcDvQp
	 KAT4XAyLFqi2+ONtIy5wWntK3+tn9ZqSaZfGg1CMlWZ3n/27e4QXM0V31fmtrd2NMG
	 uPpc6TZZhT0XQFZqID/ZqmNOvCOBSf0tSOOJCjrh+PZbPt2IJrqHnFm36hTQquEFcJ
	 8oBaMRCbQfeiaizbGcqhHg5WHROct0OOFEsmNwYwvBiBWHgnPhU9k4D2uiqsGjk034
	 TedzRsyGPMZXg==
From: Sasha Levin <sashal@kernel.org>
To: osama.abdelkader@gmail.com,
	sashiko-bot@kernel.org,
	steven.price@arm.com,
	liviu.dudau@arm.com,
	boris.brezillon@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/panthor: validate userspace queue count against initialized firmware slot count" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:50 -0500
Message-ID: <20261107050350-failed-7.3-00d4e932258f@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 00d4e932258fc5f2ace62daac307bd903ee400f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050350-failed-7.3-00d4e932258f@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 00d4e932258fc5f2ace62daac307bd903ee400f5 Mon Sep 17 00:00:00 2001
From: Osama Abdelkader <osama.abdelkader@gmail.com>
Date: Tue, 4 Aug 2026 18:00:47 +0200
Subject: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count

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
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ac6aee554820e..0493858e55d76 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3652,6 +3652,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > sched->cs_slot_count)
+		return -EINVAL;
+
 	group = kzalloc_obj(*group);
 	if (!group)
 		return -ENOMEM;
-- 
2.53.0




