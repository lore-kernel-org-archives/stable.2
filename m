Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2548381E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388722; cv=none; b=VaCaayv8qlk3IAmenyhagMX4TaNKbtE4SYTYjgGqLJAcOPo6ChS1AC/NMuTK3IZbJcbmipHEtFqM1e7YVBvuqY48KYwEYq5M2ZnUINeDP0VAuNS+ByxtTikOLAqj8JSAE93lijj8J27JjUxOu7rAxLzljmJ5+5Ms6bOcDUuFHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388722; c=relaxed/simple;
	bh=6N7uwP3rCC6GNCQQInhTH/OwMfzrHTS2Jh/5l+ygl5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkt5b2y57lDdFMqHfrI9p6YsOTcRc3W48Kybw2vw0ObdSyXH8wCkhdgm6goRCT48KZr9rEe263GalmljzhUw5kpcp/XFRX/78iC9NFvLUZOjwUoR+dGY1BhPv2oklQsivR5JOfOYpFZj1hb/CHErs8AIzXg4hzoo6Vc//ByXlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0oYIfWa; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0oYIfWa"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6N7uwP3rCC6GNCQQInhTH/OwMfzrHTS2Jh/5l+ygl5s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388677; v=1; x=1792993477;
 b=t0oYIfWaL8HWPSXoAcn0OQ0Vy0MgYHgr8VtN3BKpp9Du6V5yhCZLzag5GMVZwQE/xbp063HW
 KXSUkyScJvMMR2EjvWXkSprQJjUpmGE8c8P5UfPYA6KydR26K76oH6E64XoDeRaILiR0B+LznQo
 WrmjnlALaTYwhVgjvZbsO1uY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d648b1f8ce06a9d5;
	Mon, 19 Oct 2026 05:44:37 +0000
X-Mizu-Trace-ID: d648b1f8ce06a9d5
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
Date: Mon, 19 Oct 2026 13:45:27 +0800
Message-Id: <20261019054531.87652-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019054531.87652-1-hao.ge@linux.dev>
References: <20261019054531.87652-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
false.  The unmap side does not, so it still walks the shadow and
origin page tables even though KMSAN never installed any metadata
there.

Add the matching early return.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index a706666db097..107f66841274 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
 
 void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
 {
+	if (!kmsan_enabled)
+		return;
+
 	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
 	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
 	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
-- 
2.25.1

