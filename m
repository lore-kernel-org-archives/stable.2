Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844552E7380
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809336; cv=none; b=dpMJsVNUUS4+kdluaOd8oCcvTI+nJc6mhHPsXYwMjEv2CiRMr5NCgEEU3SDDk5PlAdQv4zLPBIHa+zPfSLjArSWi5U9yWfzLaitpHnymBsk83Jd/l9LqfjAkRWzyaVRy65qKTItyXMyqlJXpne3rWKa03WCm0utPzG9XmAJuwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809336; c=relaxed/simple;
	bh=zhFtAXNRRnp/AgKJCXFipgApjaq8J1upgNfl8PzIJVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo126MBfMt17/ycb14C0ugnnvdXGlJ6qQWqzuLXbKUv52Q2w5/6xDbv6tDFkdw+CDg4cscPA/+HiH+msaudkkvMZctI/dLpjEkRK1mOOq2rXP9eUY+6dfWOfgbBmRZTQeDj2yWJYASY/ScjfuRIK2uNj2NuVEFC23oOfrCJf0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y47w1JOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y47w1JOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887831F000E9;
	Sat, 15 Aug 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786809335;
	bh=qCMGQnQjeYWDua1iXCHq1hSdzeRgIkNaKO16v6SSkK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y47w1JOFdCOuEUf1iVed5JSErm4CqOlS5POxgzVw16lx8MrZKnuNyRNhFRw84D+TN
	 ya8Kv73IilmFkFMNxKI5k3KHDJc+uejEesZcxykw4yp3ptsUHtQy33/1Ft9vTsh1rX
	 iGPnjn7wFiN9pcAEOMNIe4fxYl3XdUulfySwvUI992Kc9sd4mHs3LjgJc+XHZkbaKp
	 PBblKSDHG+jYX/cPAeoa2oXtaDIpPsq3KwwDAUnydcK71UcqeY0AUEMIBX74mOn5K3
	 Sanr+iZFoUE7mkLaOeSYpvYeTJW1bIrrXFB7N/CvoMLowXyKJE1ieZJYOlD+z5OsNd
	 8sGpe1UW75+ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Palacek <William.Palacek@amd.com>,
	Alysa Liu <Alysa.Liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] drm/amdkfd: Add bounds check for CRAT subtype length
Date: Sat, 15 Aug 2026 11:55:32 -0400
Message-ID: <20260815155532.787421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080545-variable-gala-d869@gregkh>
References: <2026080545-variable-gala-d869@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Palacek <William.Palacek@amd.com>

[ Upstream commit 6e7566ba4739dd573c331adde1c96690f7a567bd ]

The CRAT parser validates that the subtype header fits within the image,
but does not verify that the advertised subtype length fits. A malformed
CRAT table with an oversized length field causes out-of-bounds reads when
kfd_parse_subtype() casts the header to specific subtype structures.

Add validation that sub_type_hdr + length does not exceed the image
boundary before parsing the subtype contents.

Signed-off-by: William Palacek <William.Palacek@amd.com>
Reviewed-by: Alysa Liu <Alysa.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 48e1d1e6e8798aef0312e68d8e586021b5b3cf4d)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a1087c13f2419..8b39c0707cf8b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,15 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 	while ((char *)sub_type_hdr + sizeof(struct crat_subtype_generic) <
 			((char *)crat_image) + image_len) {
+		/* Validate subtype fits within remaining image */
+		if ((char *)sub_type_hdr + sub_type_hdr->length >
+		    (char *)crat_image + image_len) {
+			pr_warn("CRAT subtype length %u exceeds image bounds\n",
+				sub_type_hdr->length);
+			ret = -EINVAL;
+			break;
+		}
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)
-- 
2.53.0

