Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198023E33D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787536040; cv=none; b=nSVRPQqlJ4BkCLkpeiG9TLjrVPfh+J7nBlJV7Fcv1KQiCxFJk02FaaOWUA5lVslIcinQyLzxEbz47lTVGq2A0hnfEeAjNVVQ0Gv0Ht245gx1UGNzCrjM0GoVwzj7h1cfhA170Ni526nvHN9w9qFQmMuE8wNovGBHyLz1fhLe/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787536040; c=relaxed/simple;
	bh=GMXp/uzjwMPTYkYu0trgCHPdqOIOW0rq90aIR8oBimE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mtWWLpvFU+U30NEW0MKY/6ZNxaMhtu83DTD8LoBx6DpQVDFygR78bOHjUo1lAvJQLbvtQcsz7akzul35bBn1/v93QC30PAP6ypNgkSvH8CECDF7IfKHg7ILwCDVjIb5UPXPYJAc+l+/IUc729fCRoCiccR/RDV333ptTlom8ASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gTg1k2h4; arc=none smtp.client-ip=95.215.58.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gTg1k2h4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GMXp/uzjwMPTYkYu0trgCHPdqOIOW0rq90aIR8oBimE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787536035; v=1; x=1788140835;
 b=gTg1k2h4x17BocxgJIbRcTKRVmdk6CN3x6sULp0nrNiPgHuOUgwz5tPToUkGmxgmKv35jw65
 jbsRGpVtHwA9+YnVkWqjbu63sEKFtohxqkB97+UHsTVTXy2A7zun0YHLeT1kNafVyDVIomCTc6F
 KD7hBLRROt+JZT7G+Za8FvmM=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id ffe8640577d465e7;
	Mon, 24 Aug 2026 01:47:05 +0000
X-Mizu-Trace-ID: ffe8640577d465e7
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] module: fix lost error code from codetag_load_module()
Date: Mon, 24 Aug 2026 09:47:36 +0800
Message-Id: <20260824014736.35026-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If codetag_load_module() fails, err is never set and load_module()
returns 0 after the module has been torn down.

Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 kernel/module/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..afb810f0154c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 			goto sysfs_cleanup;
 	}
 
-	if (codetag_load_module(mod))
+	err = codetag_load_module(mod);
+	if (err)
 		goto sysfs_cleanup;
 
 	/* Get rid of temporary copy. */
-- 
2.25.1

