Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1A59D61E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891347; cv=none; b=QaD2agu2XrAFtx72U28au8kLBMiGUYjhGERDIWSUryw6s3EJMAnR1E/CC3bdRO1t6adPWUFx6zE0izchkSZv6c7929E03hPu7U1OGOpGat/Lh5gCu+I6qgLgBsKCMLLVWrFgHnoEzB9bMN93hxjtxqR45Wn5EXyXCa8XH6oDscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891347; c=relaxed/simple;
	bh=BXhWhfR5sWAa9Zg7roFEOwIqTNeSQuDGv/0dY93IzTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH9NglBdGlfrRMQmfF4aAQcXrmOodnYa6BWeiE8SEYXkvntvEcJP0scwGLBJGTdQpmSwnYQA0wn4jR1NJlTSRsjwVXEiLIIQzAjsastcvk01aidUG7ivqqKIWSl6a2S+T3lutkRCc6/+OXKJBc/x31/714bDTCzaoJQy4Z5zrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5YxbTbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5YxbTbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF21F00A3D;
	Tue,  8 Sep 2026 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891346;
	bh=wPbIwdciPBTPWT8Ho+XwBatqmgi63Jf0K8uMzRc0sSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5YxbTbfjxA3uXwuA5CsExGfWP7AjrB0+bZWrf2/zaJ3F3/YzWleKyFdFNzU9Ga7R
	 7KaF0LiyiidnjihM6c4lxDspXg9rxizDXRXDKADq3vxrQmHEVMVJLQZe2X9cCiNQvW
	 ApzHiNTKjdmKFchOe3pPvn7FZCorYgeFaakWvCFVU0nNgA0medApDchNu1ErhfNpzK
	 QE3PDAVcEllQ29j43anm/gS5qkvRDF/t3IIRuDO28CnOUcDwuQp2noSC01dQ0lDH2j
	 waB5PpT02GpaWBbSShGEyiQrX0Zt4cG8dRhiVt/IDOB6jkQf7LfINWQe6BsbNQdXwU
	 j3lHZjmEsjrsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/6] params: fix charp corruption on allocation failure
Date: Tue,  8 Sep 2026 14:15:39 -0400
Message-ID: <20260908181539.191940-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908181539.191940-1-sashal@kernel.org>
References: <2026090332-blazing-handcart-8248@gregkh>
 <20260908181539.191940-1-sashal@kernel.org>
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
index 03443c99496c6..1b699c7632598 100644
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

