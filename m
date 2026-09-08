Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B158F070
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890148; cv=none; b=FeR96Fn/E7WFGXhL1KX2y4F3VJPaCylsgiiwV59uskWJmCnD1KOIMrN/7e5U1n6j+SazEsU9Dbubx24HlbID87g/KAG6pumu7LsxFVlAwcxFu02cdptInq3U0o29djlwBUvi1MWqwvYEFEz06AZ6sfLwNT+SfFNXkiZ3K5FtQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890148; c=relaxed/simple;
	bh=uOnpGB1EjY92DLzG5VdI0mv22ORBDIgXGtYLy/YtsR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYMtDrfU8q79C0TfDctG5+XGmzAf161o0+Wv140cJQTmw4Y1NKRZRAp/0ZccVNsw9bwSc4CpIvToMfk7T63iNv9crmDs+lEo58oLujqLgxkJg2Mex+YHWkBnv46n4JqHSaqoousl1xo5KHCnB3vTdDZE+ZX3Tul10jbU79qwnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfXjvvWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfXjvvWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826DA1F00A3D;
	Tue,  8 Sep 2026 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890147;
	bh=B8R6HfQwTnr40kg9N6vTgVC1Kg+vdh7WO5m6+qxEDnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfXjvvWfEkqKZL8CoRzw7YTKXdDL5FJG7xdDp26Jfk8fbiGtd3jUVwGDsmeU+LQAf
	 H7lQtjJmyM4FGAYT6Wq1TY8SmN+mfuxXs2LKnYT8P8lCDxOkHgnqUIX8Ey3cfSqxhe
	 RDvCM5F0GkbOK19IAb6uvuxccpMkS4ML+TVhl/rdfnhhsHiSdA++c+ztrUPfX14QYF
	 jF3CMYqv3AOM143EDLouzkZ5QP3EG8hSWMlFbCtc7oaRzRttnpxANT4lwpV2NOIt6w
	 XHuXdegZ41vOX5oGWMlocZuhd9luCqpfDP3HyUXEyeiQBWy1bSarMry4bFu5Ce7y/0
	 8eZmxCraJwi5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] params: fix charp corruption on allocation failure
Date: Tue,  8 Sep 2026 13:55:41 -0400
Message-ID: <20260908175541.151692-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908175541.151692-1-sashal@kernel.org>
References: <2026090331-stays-casually-f049@gregkh>
 <20260908175541.151692-1-sashal@kernel.org>
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
index f6d11831749be..12fb187ebf63e 100644
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

