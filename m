Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7F5013D9;
	Tue, 13 Oct 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892949; cv=none; b=N1pJKpNws/gcsSrlJB+VNZhuQxs3Uvj53K9PkycM6YMR5Q6xOBWNnLC6TTbQucNULasuSCV830slebxc3AHppKOgtq6XivciH+eoEW+qZ0hJAKf3DddIeyN6M5UuGxfh3fhf9+hAwla1+w4s7UNVrF/ku6ca+LcDktf+MAiwsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892949; c=relaxed/simple;
	bh=Wjwr73O4UvLnkiIbbule+CQPiWSkvxW8UU/RghgU6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0VVXfTrNYQrMyxOZgRiza4KsMdvkw4rXej0mghrWT55hbJKxVUky9q6WG6m927PO54EthKQdRPD9SPdVlNk1GD1ptNASteIypzUd9i7g/1VKeI9gEjLFZ4oa2pS58gFlm6SwFmaPkJKht0t4j8eAA/CroEpnL8xsEZ731w3MhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=ZcGXX+Ol; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZcGXX+Ol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791892945;
	bh=zJnUMtE0sH0CISx9MqqvOOGAYYmvxKjdN07mJU6EPoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcGXX+OlHmmb1tbmmNK4uJpoF50N17/9hFpzl2HdfHKq0k1kEyEp/sAZBXaBl6LmD
	 SixqFjsxXx02gGoTMLT9MMO3JqYov/JlnGtS8hoN8hvgHyDt2dy3I6BsHJVzQdavM0
	 VD+9OFfo/Pds6v92+GEjBmb+h39P0f/0M+e8XF4bhRzJS21CZabPtO4hSoreIO+evN
	 zaQYgRJOGD99gUSmYWHkJDcC9f0asNZXHQjtsVu2a79sub55NQuUhoCNaBkiWpy6W8
	 PgDYFlRRU8fD//yE8UB1YShuPnctMPcKzm8vcRFe6t7T4LdjoAv87BfwJcM1ww06G/
	 oyZzIWjdML33Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j3tHh503kz4xgw;
	Tue, 13 Oct 2026 23:02:24 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex@shazbot.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/vmwgfx: Use get_file_active() for dmabuf->file
Date: Tue, 13 Oct 2026 13:02:04 +0100
Message-ID: <20261013120211.135807-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013120211.135807-1-matt@ozlabs.org>
References: <20261013120211.135807-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops") moved the dmabuf .release, and broke the vmwgfx driver's
assumption that dmabuf->file would remain valid until release.
Currently, dmabuf->file can be stale after the file closes even if
.release has not yet been called, and a future commit makes
dmabuf->file become NULL instead of stale.

In preparation for that future commit, convert
get_dma_buf_unless_doomed() to use get_file_active(&dmabuf->file)
which is the safe method to access and get a reference, even when
dmabuf->file could be NULL.

Cc: stable@vger.kernel.org
Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index f9042bafdc93..9137a31eaa1a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -471,7 +471,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-	return file_ref_get(&dmabuf->file->f_ref);
+	return get_file_active(&dmabuf->file) != NULL;
 }
 
 /**
-- 
2.47.3

