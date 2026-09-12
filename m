Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62839345CCE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222871; cv=none; b=kVNrOR1DKWSqYmVoJD+df6kmMsw/yS3O192X9rZ/Tg8pqpD1G5kjoUOB40Bir/3/ZxReRZ3QI2Ufz7TENwY/OLVZvb7njZs67vp4Rtb5Kss3AmNkaB8iB9U9Et4CdYxcdIsA4KBvIha0IdO8/Vv2w3qNDPz57lFOUUOD3/T9xmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222871; c=relaxed/simple;
	bh=zCQgTa8YlLBfapyWyjQN3FuylDRruRlLgWD2Lr8Jm+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/t8ty3IPQXu5Pea9LOAp4sv712xImvtm/iJBA2XBzLp+Fam0R5czi/UhHU/fgKbUjtb+ODgw33Dv5LlvCZ8Q0AtI3dWtxk8fv5Igz2qKDLQCjiUbGtybEAqcvweMjtOZNIsZiA7y35xpU0Uk1L7J4EGykrqzjyzmdR6TV67+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXLY4Cs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXLY4Cs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5AD1F00899;
	Sat, 12 Sep 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222868;
	bh=8Q+E3XEHGFLgEna6EQUmCgEv+T0/H6YtF6miDIMZH4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aXLY4Cs5YuKpxpKW1r52cf3JBXswqvvNuCeYqDaLYu8+whVQNIs/Htd9YcekvfCZn
	 CSi+HlH+RpENrQqWQkdDkLwih7qVCXghw0Q+rjVJOwK3X6LI9Fk3tjnYOfqQkRuJzO
	 cEzN/olenQz91tjnuBLgOxXjudhFKcw9JT+qOk6+5xZPwjZE/oWZQgOppI7qs7fmuX
	 KOR8rbjjWyeQFOcSb1kJ/wTJNEgCcQfBx4eggaQHdQE9g9oyKqnVgNSQyAENZGyXpD
	 UXSePlk8Qm1obAIsFmYx1ZuCSRJeJQQkCZDNP6/UBjypTb/Xoel18X/t/k9fNheC6q
	 RQu+l8wGf8vRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] accel/amdxdna: Disable device buffer exporting
Date: Sat, 12 Sep 2026 10:21:05 -0400
Message-ID: <20260912142107.2914896-1-sashal@kernel.org>
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

