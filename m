Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFE360EC6
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516409; cv=none; b=LBq82dAN+wGMmJvuiw1hUTPflxF2JBEvgsYcAb4UzDnPcRuGJD/dMxVxj+QArMdniTq6Ag/l2luok09D6O7rxFX8gAgQQGK8zulDK2EHOQ9BIkt4fN/2IJURra6IA/0vKx7vrrbDOXsdjCOdAgOd/hbYD6EsPDN79nyfdqM6NBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516409; c=relaxed/simple;
	bh=a7zHqrMj8ltjJpM0sNDbXHJaz5KLofXlEk4pWj+B1bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmEzr3EYQ+7YkVAHjunfZ+6I9YgY/mV6hX5YYjSl9E9GUFh8XeMgLMHRGbO+QmZ6x9uExhz8dgFuPbUg+D2EfIYfC1fMKAPLLnfMHb05gWTfBE4e5sLrPRip2LNSP7hAihNoP0n02hqQ09F6iCDJTXdosR7jErTYnFKznYLVhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilLvOIcI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilLvOIcI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2367105a91.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516393; x=1792121193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LYAohfURFktRBLdiWxIwClXMCDAhfiRzTvJlH6pEOZU=;
        b=ilLvOIcIMa/wMrhJp3ledXB/nJ4VPqmQAijB98NRcCLCPTDd4cpB+u5bjtRR5ZCAiE
         hKAGIpKGGORX0FONhq+HjlqXJv/3NqTUK6zSURt76oCjAa5BlVEZ70e/Zppzg9KCc7wj
         js+Nd/n/XI1V2LyPN9s5R+D7f+frpdbJ1DkWolp0nl2OXzISnatQ0spyN76niX3xvnEc
         uCpEiEur9deoQFSTc4JF0QsBVO/nWeRfEJxTK3m/wdbWn5Hh/PbhsAcAskFRFxHTx9+K
         OTZ2cqaFJCniYFj5wJCK9RMBTX5L9j1/7mY9N3fWvyyYI+J27IKK/4N6+hj+RGA0Pear
         ZMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516393; x=1792121193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYAohfURFktRBLdiWxIwClXMCDAhfiRzTvJlH6pEOZU=;
        b=xdaH1rDRnvK3pzd28uTf8sn6hAanE9nApKvxZPuIV+L7IUBHQYfVoQmC/rX1MFwNzA
         bo9ch23JG2ndv/B2Aq2jsXMVcN56EFoAKmMRCXrz7C9oOAIfblCK+OOrR41eF6QMxHP5
         FswHu6+NreLA9BD7FxiIW671knLhFqtQKdUVJhbEIuaVN9Uh2Vg/BUV9nikO4yOtHkQM
         UA4dsvB2O2CWWPOfHt2ibEclpZgbjn34GGNjFxWCVSAlObir4N1w1nMc3yGd7tZ+T6zm
         +8hiLw39oBuQP1GIzmgj14eYYUBNk7+6DaTdteOy3hGzWN3MhuhIId5XX9JVXs1CaAXU
         vDJw==
X-Gm-Message-State: AFq9FYJAeddKaqyA4hpRuijII8ZQry1WKcntexDN/GHbHZUEw+k0kdE3
	E9RJqtUl6Tv1EzqkX31kJs/1of1FYjXdJe8O/DnVjv5cFbbstk4Io8O1/IQcmf6X
X-Gm-Gg: AYBFou3FUh/zXSVXu6iB2OOd8Fe1BubUHAm/CVN2a7w083B8k2G2h78t/RZIf3ZPO1k
	WKIV02ZU8twdJC9VxkWIrGJ1R/UPwEN2Z+2qYF156b8FSf8XjDbgJ93g0/kTiSc9YFmE+OlYxo9
	OqwOwOwts6BOqB/7mRgHS4RWo6gbfRUDJFdN4VA6WvL18opIPr5fzZIc0YQ6Ltr4a1XPW08+XCT
	GTS3fivlk+biGO1wKqsnPF7KcvPJ+ijfBmcQ7RpWR1HGFRr233FIQ1tO+JRM5TALspH22fJaIlo
	c2gd+8e4NOWmISXQjek8LcJup9iMf4hXvhjuci0el5xGagX4+ooeFmaWon4fhEkXcDu+zI78mXO
	Ayz2kPL0nFqzWqYOR1DcjjAgdKCx3cT53Qy7b1hQYBgUt6REC6VoibHOuw6Z73H9HWJA0fZZ3Uz
	F9d85qoe6Hz9Ob92pvyGEF1xV0Wpt3NmJl0rI1mHvcSwULzMx6Pqgrf0Joh2kSM3v8Pjr96L49n
	zSqGdc25KDRggf8iYx++Dr4BzNKfSkogZwaiK9U85ZIz3FkwlUonQVLgn9X8e3LitsYR52xYDAG
	OI+0/ZZg
X-Received: by 2002:a17:90b:4b09:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ab3ac58076mr575751a91.14.1791516393448;
        Thu, 08 Oct 2026 20:26:33 -0700 (PDT)
Received: from 0xiviel ([49.224.123.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371b2f2bsm1436401a91.15.2026.10.08.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:26:33 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Min Ma <mamin506@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to the BO size
Date: Fri,  9 Oct 2026 16:26:14 +1300
Message-ID: <20261009032616.432392-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit dbc8fd7a03cbc0704e8e558a448015f620547a02 ]

amdxdna_drm_sync_bo_ioctl() passes the caller's offset and size to
drm_clflush_virt_range() on the BO's kernel mapping without checking
either against the BO size. The ioctl has no permission flags: any
process that can open the accel node controls the offset. Any BO with a
kernel mapping reaches that call: AMDXDNA_BO_DEV_HEAP, AMDXDNA_BO_DEV
and AMDXDNA_BO_CMD. A DEV_HEAP is vmapped, so an offset equal to its
size lands the flush on the vmap guard page.

Measured on 6.18.55 on an AMD Ryzen AI 9 365 NPU, firmware 1.0.0.63,
as a non-root user with access to the accel node: unpatched, an offset
equal to the 64 MiB DEV_HEAP size oopses in drm_clflush_virt_range()
under amdxdna_drm_sync_bo_ioctl(), 2 of 2 runs; patched, the same call
returns -EINVAL, 2 of 2, and an in-bounds sync returns 0, 2 of 2.
DEV_HEAP is the type tested; DEV and CMD are by code reading.

Upstream bounds the range in amdxdna_flush_bo(), added by commit
dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support").
This applies only that check: an offset at or past the BO's end, or
an overflowing offset plus size, returns -EINVAL.

Deviations from upstream: that commit adds a feature and is too large
for stable as a whole. It calls drm_WARN() when the check rejects a BO
whose type is not AMDXDNA_BO_DEV, which userspace can trigger; this
fix does not. Upstream bounds AMDXDNA_BO_DEV by the heap chunks it
spans and flushes only the overlap, reporting no error for an offset
past the end; 6.18 has one heap per client, so this fix uses the BO's
own abo->mem.size and rejects such an offset instead. As in upstream,
a size past the BO's end is clamped, not rejected.

Built from v6.18.55 with the test system's distro-derived config,
DRM_ACCEL_AMDXDNA=m. The touched file also compiles W=1 clean.

Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
Cc: stable@vger.kernel.org # 6.18.x
Assisted-by: LLM
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index ca747457cec7..95d04af2b993 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -934,6 +934,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	struct amdxdna_drm_sync_bo *args = data;
 	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
+	u64 end, size;
 	int ret;
 
 	gobj = drm_gem_object_lookup(filp, args->handle);
@@ -943,6 +944,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	}
 	abo = to_xdna_obj(gobj);
 
+	if (args->offset >= abo->mem.size ||
+	    check_add_overflow(args->offset, args->size, &end)) {
+		ret = -EINVAL;
+		goto put_obj;
+	}
+	size = min(abo->mem.size, end) - args->offset;
+
 	ret = amdxdna_gem_pin(abo);
 	if (ret) {
 		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
@@ -955,7 +963,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (abo->mem.kva)
-		drm_clflush_virt_range(abo->mem.kva + args->offset, args->size);
+		drm_clflush_virt_range(abo->mem.kva + args->offset, size);
 	else if (abo->base.pages)
 		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
 	else
-- 
2.53.0

