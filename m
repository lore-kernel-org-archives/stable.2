Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1A442FC2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453779; cv=none; b=V2QvhCOT6vFfZ3+dbKieyNP+p7u6CWewsr0QH6U22tDpym1p6aQ5E2+VOsHbpMG1zBO95Ydsg/xEHb9O87MtsCS6qJypgvyKRPeW76M73xX/2gRp+GWS7MyrJUYW48LbkNn0NUDUoGjf+Tax7l0cJc3EJTW7VHcwGXC8q2aa1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453779; c=relaxed/simple;
	bh=Z5iWUkC6NQtwn75QvzsOHpoxMPbGFFoc5pZ2R3iaOQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTFiDIMfX1jCX52EVLsbEbKUPE9idHFh6pUNhPIds3wAuNjWMCcNra7vBSJ66CkSKcROU7c4jTsw4G5vSM1+M/YWqgxxMzWJF6nTp3OXPE2HDP42/9flUgt9X8yVIlLGLgBtQ1f29J/D7CrQNZC47SYlkvPEIs894BmT8UyagCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkfoX7g9; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkfoX7g9"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so692159a12.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789453771; x=1790058571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jliu2qQ+Am9D5/J1PCi8w8fiwrrDcbTYHcV6N7E5S9c=;
        b=YkfoX7g9X7/lSJf+D962W0lEGVSn6tSwR3GfuMRne76G8Oz3mJGpAhIU2pYtdGtWqy
         Dn8HV4jQ4AylQ/xY4UYsHTLAdchgOuEK/Mm9KDzdg70uNVlpWRHIhjKjMNxTeyZIKBV5
         KhEsMCsOR21PkwK2sEoe1ILRVqO0RQROcJj9pGd9urx/9U4WcEDFhK1L9LBLfArOwQSA
         Vu8gE5T9aOZ5oJsFEO26TT0lfjPmYPRYzL0J3Cyx/f0L3BfX/ABF4+lQPuLIc7yLXl1O
         JWybA6dxCuI9mYeDdHzykF6c47UVIA3c49CrQzp93DQbyPNwGHLhII/rjIK+DYu/kk/8
         +19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789453771; x=1790058571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jliu2qQ+Am9D5/J1PCi8w8fiwrrDcbTYHcV6N7E5S9c=;
        b=fcdvxfbUmmxYA/8ff3LM2gqVX3pw2emsLq/KSODW2BKrQJUC7dVVqBFpvS9CFw6MhQ
         expFowq+mRHc72V7/tMVJBKApBcXYDqMH46eVCygOhxtX96yhDrM5+59h+DMnp2fyam7
         E0f12DyYeG0EJGEFWMU2zANr0ugt8m+1xVlT5olG/l1HkrvzPkFDH3aYk5dKyWViRHRk
         1PXh6bXXqlWq2JY6HYOVHCkZD1DYS2pUXpYPt6p3XdE0WdvsprsijvWuxsqZW+a9KA8P
         T8Lr0EX/zYphxU5XTgquNS4kTNxk4XERYPY7HR5gsl/5IKrOjt1mrXp3KhXJV3N6SlOi
         6vBw==
X-Forwarded-Encrypted: i=1; AKwUvBwbINuHAN06vpzBghibmQwKOP8Rq3gkD3Lj0/SupR5FjeKimQXaxLS1atPvQPcgTohjBE6CBms=@vger.kernel.org
X-Gm-Message-State: AFuF++nAJVrQpTflwO2RxCLOpF4aiZFw7sb0IiH9UopsCipuVRJYS1zo
	ko/x6zkaWmEOm9C6/8gpd3K1WnhKR+tb8lFt2T8c/lN2xjDBYInQuPYV
X-Gm-Gg: AYBFou2n4RhIkY3RlOvGUMslHdK/aZSn0KuG6g0v2ttTSMyMDPk5lBzzC36Aa3hCcyC
	mHuhJm/3n61/d26P8sADnt9V0zG/YIG60iukEATKzRK0zL2O21sDAi80HUkY6+uLggH5faxphRX
	ZXFpiBt7+nIOQAmk9WepbbDerK3TGGaw3tcpMe0yfYxMInbVXxMkdrlme05sc22ZEEcGRCyxe8U
	zylqeXOx3yCj2Wj1ZnAcJgyPdOTKortD4Xp033ClvWCQA76iB7hFXzZbqmPk5JBzHuNvqVglPJK
	eytzW6qf3TUnGm49MJViy7+DEY5Vx2wAogUhtph87MHKw4hr0prVGTWrdu1FeEGFKkewtNChFVW
	D3gwXsmiJAjosqaV+aoak4eMyfvXjlzmE7r9HKEMGKxkz9NmhSZbaDo1YbbxroWZz9H+0nmr45Z
	vzlnVmgmunvhccRHeEAR1e5JMrdHSHi6zyZsrtQLYJzPSjFeZ6jwGvJK05GMjyDwgHbrS2hWERe
	NdnUXxl+erix+seEnzjBSC2nxfMTUUQtbtcIKIgKKFkCtLxMIZ+p0I53yiPAZwjBeJCnIA63UTz
	vhZcE/dBzss+zMmsViXzxgl1ODlr1vjdfFmlsrwxvLXqhULR9cEsAQ14pwseNEQ2
X-Received: by 2002:a05:6a21:3382:b0:39c:4e62:b843 with SMTP id adf61e73a8af0-3db5005bb45mr4318757637.10.1789453771209;
        Mon, 14 Sep 2026 23:29:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549d95sm6031973a12.12.2026.09.14.23.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:29:30 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: size shmem writeback budget to the object
Date: Tue, 15 Sep 2026 14:29:24 +0800
Message-ID: <20260915062924.2410550-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the writeback_iter() conversion, __shmem_writeback() walked the
object's page indices using its size argument. The conversion retained
nr_to_write = SWAP_CLUSTER_MAX, which the old loop did not enforce.

writeback_iter() consumes that budget for each folio and stops when it
is exhausted in WB_SYNC_NONE mode. Explicit writeback of larger objects
can therefore stop after only 32 base pages, leaving later dirty folios
unvisited. Mapped folios also consume the budget despite being skipped.

Use the supplied object size to set the page budget, restoring the
object-sized writeback attempt. Writeback remains best-effort; this does
not guarantee that every page is written or freed.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Link: https://lore.kernel.org/all/20260914111511.648711F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Thanks to Sashiko for pointing out the writeback-budget issue.

This is a separate follow-up to the folio-unlock fix and applies
independently. Compile-tested on x86-64 with CONFIG_DRM_I915=m.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index e7b18f7f9644..5751bd25c2b2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,7 +308,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 {
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = SWAP_CLUSTER_MAX,
+		.nr_to_write = size >> PAGE_SHIFT,
 		.range_start = 0,
 		.range_end = LLONG_MAX,
 	};
-- 
2.55.0

