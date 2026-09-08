Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203859B672
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891674; cv=none; b=RGd3f+Fd+MSz5QfZ8uNtuno8M1S+jQhAs9SiHhjeLs2DXNhmUgKZ3Glp1U5wLHB1TVhnAt1Lz3K6w+GnSJ+RwWvEUschUI6lz0SpiRhj+3r5sO9tjXba1pptwz7sYpvp7dzSs8jcKtoxSnM8mfpcJyHIFHT2UfS0ponSL/lcvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891674; c=relaxed/simple;
	bh=tJvJM9URRC9p+8c6+Mym1dx0E3aR/0c5jDRoubEyuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXcjnA1O0grG0FS6UBIW/4+MLBChyxIMjunjIi3SLQj3rjvvNmRoNVBLyejMSnmZtG+16gYLDuthd98y6O2G1A7CftBgV08p8gyMFFDLbfOoJayj2JSGKbSOa0V51uI5Zk/2lDLSK1K1YdDxSLlgNgOl11TacUtoilIe9ulNVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5q2eF/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5q2eF/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD1E1F00A3D;
	Tue,  8 Sep 2026 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891672;
	bh=I9R3EpxLo8aQbj1cPy9cXd4b/GsGGXsPShxFpdGz6wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5q2eF/1YpVJsQp9Ht1DFP5TejRN8jo1WMc6nGm6hpYTAqvQNLfmhXJ2/7GeFm2Ln
	 5XANl8HX7YW9YBL1UaFk/tUIZq8MWG9d0to7jXUFsoXYSVyIHShVAJuPAJ8DVK9j7j
	 Feoyv3qOwc/2Cv/6+WVMyS6uoC+dSJB0VO+ETXYiliXGMiCtRh9llpuOPGi2oMxSMm
	 7K5tD9M9F5Nz+SsDwIdTC1q4Bkj7W2iqcWSMytu5RfQS2fRJ7U7hzMWZmFIqCre2u9
	 WcIOCzZ1qj7zcGoADs/nIIXHJgTUExw82wOQckxr+oPcIsTuwlDoSAm7S7zNP4WhsL
	 uzoGcf/7QkdZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] params: fix charp corruption on allocation failure
Date: Tue,  8 Sep 2026 14:21:06 -0400
Message-ID: <20260908182106.202353-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182106.202353-1-sashal@kernel.org>
References: <2026090332-lankiness-same-e48c@gregkh>
 <20260908182106.202353-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiacheng Yu <yujiacheng3@huawei.com>

[ Upstream commit 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae ]

param_set_charp() stores charp parameters in allocated memory after slab is
available, and releases the previous value when the parameter is updated.

The previous value is released before the replacement allocation succeeds.
If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
left as NULL.

Failing zswap's compressor update before zswap is initialized can later
trigger:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
    zswap_setup+0x3b1/0x490
    zswap_enabled_param_set+0x5b/0xa0
    param_attr_store+0x93/0xe0
    module_attr_store+0x1c/0x30
    kernfs_fop_write_iter+0x116/0x1f0

Allocate and copy the replacement first, then replace the parameter value
only after allocation succeeds.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index e1eba5b8230c1..32682334ca7ff 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -265,6 +265,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
+	char *tmp;
 	size_t len, maxlen = 1024;
 
 	len = strnlen(val, maxlen + 1);
@@ -273,19 +274,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 		return -ENOSPC;
 	}
 
-	maybe_kfree_parameter(*(char **)kp->arg);
-
 	/*
 	 * This is a hack. We can't kmalloc() in early boot, and we
 	 * don't need to; this mangled commandline is preserved.
 	 */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(len + 1);
-		if (!*(char **)kp->arg)
+		tmp = kmalloc_parameter(len + 1);
+		if (!tmp)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		memcpy(tmp, val, len + 1);
 	} else
-		*(const char **)kp->arg = val;
+		tmp = (char *)val;
+
+	maybe_kfree_parameter(*(char **)kp->arg);
+	*(char **)kp->arg = tmp;
 
 	return 0;
 }
-- 
2.53.0

