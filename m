Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045744;
	b=dmbwaj1z1U0HDNSddKAiUMk8VScjK1Tub4/kvAay3HsKiwsGKUIXiFRY6CEO4hGMli2v
	 fVkyDAc+dQzxpgRy+3/xH9zRGvmssv/JG9MZqjG8fw/2vjnfnZuc//3+nYAict4cqgBD0
	 joqAXOq1xkVU/njhqj1EWfuC717rp7bqGyLLzoZcVWwATvQUa9wLxOMhK98Lk8XxNcUDj
	 yOddnu3n+Dsu7KAAk2Fzfd1VcQpNdfSvg9udV9bh2dhU0J1IcpHDuMnrNmHZyj3ikWzoX
	 aVSlFNycPlLyPK+Gjiff9vdHhTOGbXlPN3CsCrARQe+B0j6c9j61e9hJFs5PToHdGvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045744;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hxIZq7Pk7UPgWpNIkeyI8Jx3BOcqiaWKaSlTxbcwMWA=;
	b=ulJQHb+yokeAnkMNYMa/0hl6xdgBaDPR/O57opRDP0a2O2W8EgBEbebcdN0Qpbhb46eo
	 2VDyN2Jke6ppHYP6oeIc1ejFH3WQgkJ7X7OnuUrhxWvqMEVh/wyPL60o7mkMI20SFk5nu
	 TfB3b5qp/lMqtTmIUUvI+LVkIdzSrQ5O+Z6ub76xkC2nltM8/Cjjg1v+rhUJVs9/LAsYJ
	 8jg1PI4Db23iBNaag/TSSgtYwA+AHqrH1ZmbfBVA5BfwzedJs1Mm2TrXIX8fa1lU1QYd1
	 Nc9mdg4Z5cGGQ/WICzgAAOXboSjgQQTuWkfE8S3v2th/qNskxpKgUIgE00B6QNqcRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blTnJEJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blTnJEJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7421F0089F;
	Sat,  7 Nov 2026 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045744;
	bh=hxIZq7Pk7UPgWpNIkeyI8Jx3BOcqiaWKaSlTxbcwMWA=;
	h=From:To:Cc:Subject:Date;
	b=blTnJEJOSmZ/RtsSTn0gQx+e062M8wrbHDYSCAbGlwqxjxxkVXvCLCPsuWnK17z8E
	 TBxH6R0Ik6G/Nof6fcKaMUZ/ITmqC2Vxt0FwyeDsHTWhqgltCZlCQvOHDAIuzw956i
	 J8GnYOIZKVzFYuLtneQ4PWXjUlZA7veEJPBuZ/kjIn8PWLTYgwbeDWddwupbk6CiY5
	 Yi3jmABp+sggKUd37zOgW7LaUYtKs8tQ+T813CYjRi+ctCAfV++mQLfCr89rMOgVcE
	 DzrasvmCGg3gKJlENG+CWgGb0bLg73TjsFjHXQRJ7HyplRgLrkEfGoXa+kYVyUxmW6
	 ja8oaFEEwOXLw==
From: Sasha Levin <sashal@kernel.org>
To: jia.yao@intel.com,
	gwan-gyeong.mun@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:22 -0500
Message-ID: <20261107050222-failed-7.3-9daa302a8259@kernel.org>
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
git cherry-pick -x 9daa302a82590eeee7bdc68023ddad302df4b88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050222-failed-7.3-9daa302a8259@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9daa302a82590eeee7bdc68023ddad302df4b88c Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Tue, 4 Aug 2026 16:50:57 +0000
Subject: [PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 77429ff4d2a9a..ff8eee3831aa2 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -458,7 +458,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.53.0




