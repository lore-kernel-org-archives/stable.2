Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954803B0AF0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670008; cv=none; b=h4tFSvfJdEfEVvCH6b1Rww4HcBCctkr00wFC+awqYCxk9lMmI3ZisUOWvEj6GbJ1vf2w/o/lBh4hILQMZaaBdJ9AmEFM0lMWgRFXyOHzPgEX/xxv7Kfjm9DRuYNItqeYKi5PVyfiMYjxOhElWTuhPNWewN8VUTCwCaSONfTaZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670008; c=relaxed/simple;
	bh=mEWPvX1FdDCMegEZd4lktZpkSzG9+EQuZUeCnBEnrM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3gg4H2XjNOId6ia2rjwA4zSS02KYMRJyjd4g970UDGw5hZSaIiz22dP7sr7bMENAZJOY80aGZ6J83Nx7eSUC+RKUc34rS7uEvkkNqNIlNwqRBEQhaQ8OHPXO5CfoAgIBTgb3FTZdy4GQ5w1+TKGZQ4w8TwZeLD1yhlceWZNz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fUywBQfm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fUywBQfm"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mEWPvX1FdDCMegEZd4lktZpkSzG9+EQuZUeCnBEnrM8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670003; v=1; x=1791274803;
 b=fUywBQfmVrIpnyOcm5zCU9r/hPSXUL6ztvivVbohT+mRDCS39o56y3hUSieZJcbyW2Hbgf9+
 kSRfKgp19gzcrttVynEBgB2kxzHW7pjP3fC6OX1JxIh4/cBrKb0GfPlY5nwg9uoHowoCPTZC0tA
 v+7bgBLuW+fIbyaGjk0dRlRo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 343c75fff31967c5;
	Tue, 29 Sep 2026 08:20:02 +0000
X-Mizu-Trace-ID: 343c75fff31967c5
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	=Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v11 3/7] alloc_tag: clean up the populate failure path
Date: Tue, 29 Sep 2026 16:20:10 +0800
Message-Id: <20260929082014.160587-4-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929082014.160587-1-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reservation is already stored in the maple tree when
vm_module_tags_populate() fails. A failed load never unloads the
module, so nothing releases the entry. Release it and roll
module_tags.size back. Without the rollback a concurrent load that
already passed needs_section_mem() can reuse the freed gap, skip
vm_module_tags_populate() and write to unmapped memory.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 2070e682fe10..3e6306ee0764 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -947,6 +947,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		return ret;
 
 	if (module_tags.size < offset + size) {
+		unsigned long prev_size = module_tags.size;
 		int grow_res;
 
 		module_tags.size = offset + size;
@@ -961,6 +962,8 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 			shutdown_mem_profiling(true);
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
+			release_module_tags(mod, false);
+			module_tags.size = prev_size;
 			return ERR_PTR(grow_res);
 		}
 	}
-- 
2.25.1

