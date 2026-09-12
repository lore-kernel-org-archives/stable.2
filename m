Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC1345CCE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222865; cv=none; b=udXYEJWw3pccGK1NUopBnQ+S33MnyWwqJWI02adEa7nHE3R+nRTP6mPYlqEiUo/0r0r+RezOgPue9Ye2iAUJqjhT7zv1IXXKVbXA5qLLHAfQKkYJJTQAaodQKnuOFoIGR2jaFfX8yCHCw7hRo62iK6MiG55zkAS75NFBWSObRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222865; c=relaxed/simple;
	bh=SMxYAEy93KhjTG4qbvxVDWT9DINmBR/4mrbyWY/1x44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh55QcSRnUZuAOjOsIMTQ7tVhSQlaPQ8hoCALT2yqQ1XomdkUOxrlw6+2eBBsbhyah1GVRr3z6Vwwx7TpBLlld0VKQwzScTEOqKCx8xq02AzIihqj3g1QG3d+F+C2mV6YRwgBPh+0FjljFC9+Q/hbfLiUlnQtV1F2g1Ks5cuUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJKpRL+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJKpRL+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9291F000FF;
	Sat, 12 Sep 2026 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222863;
	bh=zWa5YLQzpeKd0TC9SnOFuKaN8qN1+pJJiGzJtTk7Raw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJKpRL+V6ow3lWpiX+5GkzGr6Apa+IlP9MtcFXP+XTuqMjK+f6NlcsiMColOvG8q6
	 06cjSZVvvt/dvy/Dt+bbNwz+1gGQ4Mu+OJoaawZx1jyi0/MmlvxD760IJ7uosyBlQl
	 xDzsCe6uH5dHq3/GGK8y9lw9j6caDOXLyi7K6KvTNpW1MxhUEJ3d4xVScuzF2tFMJC
	 iFujbxtijXWEJEv4Ene2ufJEXGMXcMuutNpunPh2FnEpGR6gZm/oJdgyxJeR/gZ23D
	 y6ymjGArEYwFsFUV6CP13czuu5ArtMPbhThS8qkHQSY/FvgYFRgKQUUDa91+IAhut2
	 V278509HwRFDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] accel/amdxdna: Disable device buffer exporting
Date: Sat, 12 Sep 2026 10:20:59 -0400
Message-ID: <20260912142101.2914515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-turf-outthink-f4fa@gregkh>
References: <2026090944-turf-outthink-f4fa@gregkh>
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
Stable-dep-of: f43fa4b8522b ("drm/xe/i2c: Fix the interrupt handling")
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

