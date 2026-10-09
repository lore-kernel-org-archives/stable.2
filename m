Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0D4E06C1;
	Fri,  9 Oct 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549402; cv=none; b=JOiNQhKGoEPLpLRr9PO+ikBTFObPwztm6naSu9iTpyCObjV2oefJHLAkWtu/UcElu6a6mOHP20PkBX00sGuFrQ554TTPY1ppwqeivjjpWH8yP/7NF4K1iY8b0+jUFHUNXvie9uHNtmQAS9n117OiAFi40Mk7YH6vzac48pG0AD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549402; c=relaxed/simple;
	bh=Wjwr73O4UvLnkiIbbule+CQPiWSkvxW8UU/RghgU6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPuwBH5a+0NsfyIWN8bNjzyQEEt/fZqVVe+rfwQje+aeplwjdVhMP3TWNBzSWZa2a88AVooBTDWv7tHUHVI2n9QFFqKlBqWt7QqCTGEzsFOP+M24mDd8wHylj/YFUqXwHynq6iPwXyeArg/XaNrdoj4vPwsXXYnfKOO2eUpZaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=fKwdJ1yy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="fKwdJ1yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791549393;
	bh=zJnUMtE0sH0CISx9MqqvOOGAYYmvxKjdN07mJU6EPoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKwdJ1yyWC3TCjy69nztsAiPj9Df7HHX6pya+9DZkAsGEFi7pAH2WbERHjZEd8jlN
	 8/x+lF2nCTgJCxGwBDoYCxkk6V5dzXnP8+9TN8+QwtxM2UBC+anuvSup12Nrd0j3Dm
	 hzLi3wb367JKjIpNuIxULLaBZQArtPel3q0qMBjoTbfG5IS7OYuNAogIRBACLBO0LX
	 Tx+SDS0qcRKeTEMe4ojzYnpQLJDSjSh3Nf7v9Tw8izxtwm9WfmsXFVlvDgXVlHD6YI
	 mkZICfwYC5EePJ139iWlk1sqyLEgPhgmPvJz76bUA7USxS6mqDkdN691lCU7JHDJ2y
	 f74hf0pohCxjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j1RDw5v1gz4wTB;
	Fri, 09 Oct 2026 23:36:32 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-media@vger.kernel.org,
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
Subject: [PATCH v2 1/2] drm/vmwgfx: Use get_file_active() for dmabuf->file
Date: Fri,  9 Oct 2026 13:35:55 +0100
Message-ID: <20261009123601.94079-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009123601.94079-1-matt@ozlabs.org>
References: <20261009123601.94079-1-matt@ozlabs.org>
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

