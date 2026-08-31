Received: from sg-3-29.ptr.tlmpb.com (sg-3-29.ptr.tlmpb.com [101.45.255.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CE43F4B8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183229; cv=none; b=q+AX9JmSuDH7ThzdalCE9PZfRZjJ9r1dgapmvEoquKSefDf6bsbw3JgapCPx0GyFSi+QWDCkw2gA3SmNafiLYuc4HFh3sTrwi06l+WmUvkvsvGt3dUTrdVLQoww2cnpzmVdWMg5tiLVQ4422UctBMUdcKkAtn7ETmfuEoXI5U9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183229; c=relaxed/simple;
	bh=plswYjsOWjbztznk1Vg0t8i0AffMK8C5DB+uxBq/4qg=;
	h=Cc:To:Mime-Version:Content-Type:From:Subject:Date:Message-Id; b=hyiYiV5CVmn1fxZ/gLXSzAoETEm6v90yiitR77DsU6zNb1rRkY/S4J9AADvtx0Lf5YR/mWg4Fp3VfTATx0luHxa8wycdlNBQf0HKmi+HN2zToyfU+B/AiYEP6EfwMaYpSke5TYecbDCjDyc35G+FYJvN5kWl6UefrEzeueXU130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=P+7HXOjq; arc=none smtp.client-ip=101.45.255.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="P+7HXOjq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788183175; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EbRchCsufk+S5bbT7cJOnYn1Fmv1FXBDWUxIFy3XOUI=;
 b=P+7HXOjq5Vy97c0DhF9xgu08MVmJK4soLVu8W9nLyBsZ7kw0kUDBfkoNqVfxw+anT6wFAu
 zdtqUUNUpw46lKvU+Z0NC5uJ3Jai13pQCrlUVpFhZArDPssrPmMVAlKXucujhXIGXWCaWA
 Qfhv1A+X1ZYpXeKkXTFhcC06JW9KUvKj8XQcDzDekXb0KPzs5UxYwhMpQoIBve2eSfTPiF
 gR6+zGeWZ4H+Zwo99WTeGzTCxJm8nJwM5yyQE+f3bOEDcXYaMS8zaNwpoDVM2n8LQsIoIg
 Ah/CSkeHChQJf640ZDWEyzFRSHwq0+6zdvinMNZh4cTVmrs6GydftwPuHptsMw==
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <mingo@redhat.com>, 
	<acme@kernel.org>, <namhyung@kernel.org>, <kylebot@openai.com>, 
	<david.lee@trailofbits.com>, <linux-perf-users@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a958285+705081+vger.kernel.org+yilinzhang@moonshot.ai>
To: <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Subject: [PATCH v3] perf: Fix use-after-free when perf mmap() revival races with the last munmap()
Date: Mon, 31 Aug 2026 21:31:52 +0800
Message-Id: <20260831133152.1231045-1-yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Mon, 31 Aug 2026 21:32:52 +0800
X-Mailer: git-send-email 2.34.1

perf_mmap_close() drops rb->mmap_count *without* holding
event->mmap_mutex (the refcount_dec_and_test() right before the
refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
perf_mmap_rb() can slot its entire "revival" path into that window
(perf_mmap holds event->mmap_mutex for its whole duration, including
rb_alloc):

  munmap side (perf_mmap_close)          mmap side (perf_mmap_rb)
  -----------------------------------    --------------------------------
  rb->mmap_count 1 -> 0   (no lock)      (holds event->mmap_mutex)
                                         inc_not_zero(rb->mmap_count) fails
                                         ring_buffer_attach(event, NULL)
                                         rb_alloc() + attach new rb
                                         refcount_set(&event->mmap_count, 1)
  lock; event->mmap_count 1 -> 0
  ring_buffer_attach(event, NULL)
  ring_buffer_put() -> frees the *new* rb

The revival's refcount_set(&event->mmap_count, 1) is an invisible
1 -> 1 write: the close frees the just-revived buffer although the
other process still has it mapped -- a page-level use-after-free
allowing local privilege escalation to root by any unprivileged user
(default kernel.perf_event_paranoid=2).

Swap the order of the two counter updates: event->mmap_count is
dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
transition and the ring_buffer_attach() stay serialized with
perf_mmap(). rb->mmap_count == 0 then implies every event using the
buffer is detached already, so the result of the rb->mmap_count drop
can gate the remaining teardown directly and detach_rest is no longer
needed.

An earlier fix for this race from Kyle Zeng and David Lee takes
event->mmap_mutex around both counter updates [0]; here the not-last
close stays lockless.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.lee@trailofbits.com/ [0]
Cc: stable@vger.kernel.org # 6.18+
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Tested-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
v2: https://lore.kernel.org/linux-perf-users/91825d0335d2f7cc017ee23886ffeef44c1cc633.f061f277.0045.493a.937e.53242f19a7de@feishu.cn/T/#u
v3: swap the counter drop order instead of serializing both under
    mmap_mutex; keeps the lockless fast path, drops detach_rest, and
    references the earlier independent fix [0]

 kernel/events/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..f56f9d9e4f01 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7029,7 +7029,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
 	if (unmapped)
@@ -7060,17 +7059,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&rb->aux_mutex);
 	}
 
-	if (refcount_dec_and_test(&rb->mmap_count))
-		detach_rest = true;
-
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
-		goto out_put;
-
-	ring_buffer_attach(event, NULL);
-	mutex_unlock(&event->mmap_mutex);
+	if (refcount_dec_and_mutex_lock(&event->mmap_count,
+					&event->mmap_mutex)) {
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (!detach_rest)
+	if (!refcount_dec_and_test(&rb->mmap_count))
 		goto out_put;
 
 	/*
-- 
2.43.0
