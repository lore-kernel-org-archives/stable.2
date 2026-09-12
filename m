Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D31330B14
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224132; cv=none; b=XuRDHnaZe5aL3xFMW173zzGBh0i6ydZVHRFh/5cEkEcIxapDCvU64vQPMI2d0BwojSJZHpp7jacR8QUAnPh0S3KshzVHABAwQln6ZCj34ZTG6gsmLOSV3PED3AhvWE7nbg9b3fIDO7dHCIl7gvy3iCClFrdnMMU3fgRxZY9sEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224132; c=relaxed/simple;
	bh=zCQgTa8YlLBfapyWyjQN3FuylDRruRlLgWD2Lr8Jm+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYvUX/tPY7ahF0lkUto39Ni6sm796oJopbGNYy9ZV2kXl95aaSdD+TynvgbGuX0i40SVZOtfkkPKYGtSw0S8iOe9rMp4gQmxtJ50shWLTG5n7njJmz/gcAKXfPjCeWTx+4KzXVBJY2uLgr9xNzB+OtAwGXIqt+BuAJd8bolGRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3azY9Gq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3azY9Gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDDB1F00893;
	Sat, 12 Sep 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789224130;
	bh=8Q+E3XEHGFLgEna6EQUmCgEv+T0/H6YtF6miDIMZH4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3azY9GqNOA8dhSxoh4K8Fha+dS9/GSYGcAzEg6FewEkcCa0bHFbKM4a8mwSf+H1z
	 NUTx5HXwlYYVKSQoz9NZlJjKlBhdD3jTjDyvl9LKLleS5gVeKTbi8nRNcBoPYuqSw8
	 8qe+WgfIEOk/CDp44Jt6sdEm+avn+fsbmY97SjxPYI/2tMkMQZX19Bo6cjxABYPS0T
	 fRAsHDs0SIbRnuaevFiH0MxnekQ4hQdMQTt7BNSdpMeQY1hNXZjZNdrOmcxqO+9FYJ
	 G4PvFK4wIJHtWr/Q2grO1gqsNraMvknHIBdzkkx6Yt6r7ZEuE54yV6+WdR+ZNqvobP
	 CY2J/j4dER++w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] accel/amdxdna: Disable device buffer exporting
Date: Sat, 12 Sep 2026 10:42:06 -0400
Message-ID: <20260912144208.2989900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090957-lilac-mocha-69d6@gregkh>
References: <2026090957-lilac-mocha-69d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 9480dd7ec3fcadd4217503e4bb32c16e19e4b21f ]

Device buffers are never intended to be exported. Disable exporting
support explicitly.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260526185058.1780869-1-lizhi.hou@amd.com
Stable-dep-of: 244abef7f280 ("drm/xe/i2c: Keep the i2c controller always enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 2a16de96e6a4e..d18de7eb7af47 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -758,9 +758,15 @@ static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map
 	return 0;
 }
 
+static struct dma_buf *amdxdna_gem_dev_obj_export(struct drm_gem_object *gobj, int flags)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
 	.free = amdxdna_gem_dev_obj_free,
 	.vmap = amdxdna_gem_dev_obj_vmap,
+	.export = amdxdna_gem_dev_obj_export,
 };
 
 static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
-- 
2.53.0

