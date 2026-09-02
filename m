Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304F36B92C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337083; cv=none; b=LsZK3QjzEjS5WbIksSNZpkrPYPjDN6Y8SDB5Rrf+NSLH3+ruc4tB0WK0TkMgTf4uWrYGEiuJ1TQF1FDDnbLc7z9Hv4XRz26/XeBBKIlIoDXqvEdqJsjViP6+jJBNc+Vhc5Uv3KFI+oGMom92JqqUPIz/cf6Mlpswy4VP/rTPSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337083; c=relaxed/simple;
	bh=dWk9y7b0drDaUlfFd/9bCLMEQv7pdwsvhjNQU3mPn70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqp5YPUi/vIJx9/iI4E4Hho8C++v3tMLdzFE4/kb35Luy/FWl5Y6CQR0d/Na+xlYMmBK4eUOWxhxhmAod4ocWpB58K21dWwNQyJHouSOvbJlIuAoU6j0h1RsexiyW/URMUjbzrjXP8v1gXM6GUqBMHxFELjQWvknypqtLm+OPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=or4Fd+fj; arc=none smtp.client-ip=91.218.175.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="or4Fd+fj"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dWk9y7b0drDaUlfFd/9bCLMEQv7pdwsvhjNQU3mPn70=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788337079; v=1; x=1788941879;
 b=or4Fd+fjoDT55iqG+B+WGSLMTkSlmM2k8Qs99PoVYTcNgrL8/zCL/7azvjiPygrMyNP+v1eN
 tjsUmoY+rFpBv0IjhNbAKdX2oLGpT8SU8WZ9/nEl/T38ACMIGrdGTfEog5CkVYMXkx1yoI0TRHo
 be6yuvAXOPdMXJti7fV2Ly4o=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eca1d97746dd0c27;
	Wed, 02 Sep 2026 08:17:59 +0000
X-Mizu-Trace-ID: eca1d97746dd0c27
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
Subject: [PATCH v7 4/4] alloc_tag: release the reservation when populate fails
Date: Wed,  2 Sep 2026 16:18:02 +0800
Message-Id: <20260902081802.146145-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260902081802.146145-1-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
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

