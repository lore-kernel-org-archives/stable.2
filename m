Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3637C108
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799888; cv=none; b=pkSBgAw7AILAfivbo3hCxXNwY2vxcHNHiH45xBh1XX0P5cc2ZDIQ+WvYo3DqcACW/NubEsi8Ienp5D5ZODz2XEaOkRc1cqnX2TtGKqX6Wxz7NNEyt/yLmVUp/R1TCbS9qenMksYH1q22t+JUYZR/E5CxNjc5HDOOIIGR4l6cVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799888; c=relaxed/simple;
	bh=6YKLkQG5JiytFRfJwpWYN7N1V8zDCOSVTe4ZlicB3iY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4r/0SRZTBBq9aSkcCV1qVfEeq1JVnOA7sdethcsxvr66QT3/B/9MsMCChFz4Pa9es6d9VeGPX9A72Y5V2XelkqfGmOKv17EN5HSCEeOyDi7Qxpv/srNXr8bqj9c9RFmHPH/HVvJ0bUXd87v8pr08N80qa1VkBhQrwjsc3tKxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRICtksM; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRICtksM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6YKLkQG5JiytFRfJwpWYN7N1V8zDCOSVTe4ZlicB3iY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787799883; v=1; x=1788404683;
 b=rRICtksM2QDaUPWEouw5fSRTFefoDdtTkIiXiuwLHdfNgZXidEAqGnliFbrRvLM2f3Bs3y+G
 mcuJAVMb1EJoMyOneBsCJYY56iShpXA9LEnWSAuOJw1kZtbwq1ngAEpCH8JJ3M0gHxnqh9hBRx3
 2bxrEfGB8xOSe9avpcdCg6/Y=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id e31228036460d56d;
	Thu, 27 Aug 2026 03:04:43 +0000
X-Mizu-Trace-ID: e31228036460d56d
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] module: fix lost error code from codetag_load_module()
Date: Thu, 27 Aug 2026 11:05:03 +0800
Message-Id: <20260827030503.49171-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If codetag_load_module() fails, err is not set to reflect the failure
and load_module() returns 0 after the module has been torn down.

Also, if the module is a livepatch, mod->klp_info allocated by
copy_module_elf() leaks on this error path. Free it via a new
livepatch_cleanup label.

Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
v2: also free mod->klp_info of livepatch modules on this
    error path (Petr Pavlu).

v1 link: https://lore.kernel.org/all/20260824014736.35026-1-hao.ge@linux.dev/
---
 kernel/module/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..c32f1d370b73 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3568,8 +3568,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 			goto sysfs_cleanup;
 	}
 
-	if (codetag_load_module(mod))
-		goto sysfs_cleanup;
+	err = codetag_load_module(mod);
+	if (err)
+		goto livepatch_cleanup;
 
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
@@ -3579,6 +3580,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	return do_init_module(mod);
 
+ livepatch_cleanup:
+	if (is_livepatch_module(mod))
+		free_module_elf(mod);
  sysfs_cleanup:
 	mod_sysfs_teardown(mod);
  coming_cleanup:
-- 
2.25.1

