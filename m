Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13357395AE4
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762231; cv=none; b=A3pGC4pd7Rj2ekDlpA5qXtg5TSNeeHnb6mPNSbwCim7TQj0g+ccC4keALYnZwk6d9vDFWYzDKlmSjlTMfq0q5AbcQKPDQi5mvOOuLONEIc0yBwMuOEoJLYfyYhEGjy8y3ypZu3pnq5Xi0ow2gHc/rb/kIh7I5H5Ts4aFWnBFvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762231; c=relaxed/simple;
	bh=dWk9y7b0drDaUlfFd/9bCLMEQv7pdwsvhjNQU3mPn70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDNsQLX52oOPeU6tPR9EQHutI9eUd6tZrJREAUTypwGncEcK5dnfQd5WTP9lWON36IclXqvXVgu2tAspZbhu6sSL+vtMSyA4j1q4fimaUnQ5mbQmZHYgxbYe+VX3gFPR/vYrIhpalPmX6i9ef/+yY3rP1tqtxiAoviVqYk9aB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gPv2xR5W; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPv2xR5W"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dWk9y7b0drDaUlfFd/9bCLMEQv7pdwsvhjNQU3mPn70=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788762224; v=1; x=1789367024;
 b=gPv2xR5WCmei2BlE4GtflZefmNDXluoiWnU5rajvt4Vt+b8SjL04YH5GEufPNfr4AQ3x4XUL
 GnC/KWy2lHyfNi1h705t1T+61VQl+3W26EPM2Bcvi2mpt42cFoVjiLMjqyOp3xVze1u5RszBVo8
 maAzF46K7inKvMUK+Yy8psUs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bbad7cc037fa0143;
	Mon, 07 Sep 2026 06:23:44 +0000
X-Mizu-Trace-ID: bbad7cc037fa0143
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v8 4/4] alloc_tag: release the reservation when populate fails
Date: Mon,  7 Sep 2026 14:24:13 +0800
Message-Id: <20260907062414.106873-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907062414.106873-1-hao.ge@linux.dev>
References: <20260907062414.106873-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_module_tags_populate() can fail after the reservation was stored
in the maple tree, and the error return leaks the entry, since a
failed load never unloads the module. Release it.

Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 248496470904..3c25475becbc 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -971,6 +971,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 			shutdown_mem_profiling(true);
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
+			release_module_tags(mod, false);
 			return ERR_PTR(grow_res);
 		}
 	}
-- 
2.25.1

