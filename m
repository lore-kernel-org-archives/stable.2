Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453F403E9C;
	Mon, 24 Aug 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566131; cv=none; b=b/SpaWEw4lFmv5RH4eDmPOYX8A6chCFor0m2un+H5Fp8hiavpgroIRMr0p4YUqxhExQgfOulQqb+fD62QDy4KiJlrp5Nqkf9c0pkXkraQASwK0XnOZnpZOTMcTWpP/wh8lL+UkXztGRvB1CL3kdzl9QgyFwLcoYkl5pMl/8kgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566131; c=relaxed/simple;
	bh=+LPKQRvimndmSuzG+z8+s3nitIAYR/aEhhRxrZvpETQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1rOLbl0bg3Tc8U6T2IvJDnNVUEszP2xPxQb2C2mXaH+v3ouLOX+HwEmorLbfd8Z6xLMMWvI8sTpx1+MQX4HxJnj7oPYZvUqK+4k/Yfuo/Ay0Z6GUmtatT4SEQQE7fDeOt+WwwT/+xO5cXRxNLXBMaldxVrOD3o9jRkuuocCqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N+92z3Mn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N+92z3Mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0N
	tmON3Iinqg4NTT+CvpMz+LBDo++1meA3igasdFZAQ=; b=N+92z3MniTkaYTvV4e
	67Pb3Ua4tbzpAbPwf51171tU4qRV3dk9eKtW26nPKW1a8KEd7c2NKj8aXmFAkv36
	T37wc2X4j3OpeLNTBFmk72KWX76A/oKEM14f/GJ7uGJvS0Mz9iKWYqrt+xdIZ4S+
	VzbUIOdmZX9JRTRwy60MsZtyo=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXwo0RGIxqh63qLw--.59759S2;
	Mon, 24 Aug 2026 18:08:17 +0800 (CST)
From: chenyuan_fl@163.com
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] mm/bpf_memcontrol: fix signed enum bounds check bypass via negative values
Date: Mon, 24 Aug 2026 18:08:07 +0800
Message-ID: <20260824100807.1829195-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXwo0RGIxqh63qLw--.59759S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry7Xr1kur1UWF48Jw1UKFg_yoW8AF1fpF
	s3ta4rKrs7tFs5WF13KF1Uua4fZw1Iq39xCwsrJr1rZr13Ww15Xa47Kr4rAFn8KFWjqr47
	J34qqryxAw4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzKZXUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hLHhWqMGBJbBwAA3G

From: Yuan Chen <chenyuan@kylinos.cn>

bpf_mem_cgroup_memory_events() and memcg_vm_event_item_valid() use signed
>= comparisons on enum-typed arguments, so a BPF program passing a
negative value evades the upper-bound check and is then used as a
negative array index, causing out-of-bounds reads.

Cast the input to u32 before the comparison, matching the pattern
already used in memcg_stat_item_valid().

Fixes: 99430ab8b804c26b ("mm: introduce BPF kfuncs to access memcg statistics and events")
Cc: stable@vger.kernel.org
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 mm/bpf_memcontrol.c | 2 +-
 mm/memcontrol.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..5e8107f240ba 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -125,7 +125,7 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
 __bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
 						       enum memcg_memory_event event)
 {
-	if (unlikely(event >= MEMCG_NR_MEMORY_EVENTS))
+	if (unlikely((u32)event >= MEMCG_NR_MEMORY_EVENTS))
 		return (unsigned long)-1;
 
 	return atomic_long_read(&memcg->memory_events[event]);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6dc4888a90f3..42a1b855bb75 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1058,7 +1058,7 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 
 bool memcg_vm_event_item_valid(enum vm_event_item idx)
 {
-	if (idx >= NR_VM_EVENT_ITEMS)
+	if ((u32)idx >= NR_VM_EVENT_ITEMS)
 		return false;
 
 	return !BAD_STAT_IDX(memcg_events_index(idx));
-- 
2.54.0

