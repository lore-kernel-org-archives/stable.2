Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870630C629
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049467; cv=pass; b=CozwxYBn6960f0cctHVGQpfOGQBih39WMQW8tzaV/wQYbOWY1c9TAc1K1y+XYUiyHrPZDd9YmnIl0vwTaHrSt8R9b9rBRknh7GmkFoK2GmXqFZYOPshv0DqRY+tyC8E0heIJEzroHynjYLaaZQupUbxBX3PwEcdzcJPGR7MFNtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049467; c=relaxed/simple;
	bh=6o2xFZURyWP+tObe4cjpPDsfyvJKRP0tCizMlSF5sH8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n24wwlYdZCjWNKPl70dvqbGtH3x+FevXDmt6Ms60D8Uf/z7NSppsgvevR9/S7Ki+lhBGHLR8J/7DPAvs16QhsMrNUb9kpzJixWGI02AWYE28ewVMsT6ieoH2sY6d9uxQ5z4T7HUC2gbo6qN/tTOZes0q4x/qurgQhTu2OYMCMvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=XkfutodT; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="XkfutodT"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6611689dc10so3622738d50.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 16:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781049463; cv=none;
        d=google.com; s=arc-20240605;
        b=lziBe7SWXgKX9yYPaq0Swy3rq62u7iwJgNPkelKH0pMYIzf3qdNhjV/x6b1P6aADJF
         U/pvSvTnXrk83XIf1EMX+UmHLbAvPzJEebL9aBOmxqpqu5Qln5Cnp7EK3h+mext+FH7S
         9nJFEAZrLARq1jRv4g6aNNOQKQ35igAR3XpHP11694pbMu/v3MhgGvT5VSkBrICgc8Dc
         dcP2U+py7YwKAjUfl3cIARfGiGYAoRYDnUHBR5tvuPrUCN5su+Ie9UDLTxQGyLzGqygx
         /yE/YQBgWVzyGX63motLDpLOaTzn0MF1nScX//Rk7pDGGoScPcLbeRx5S7TdHOvx+QJU
         vvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        fh=jr50g3lESq8GJdJ5cvcbXZ7xLeQc70K4W5uzsP5WLG0=;
        b=ed0w8vz+HhMdTX1Kr3pktDQMzNSxMh8cjRO3ve0e6ty/Ejn79Cc41wY2DwalJNfkIH
         w1Ulx9heIBlOQUO+/YLtRXRIzRlM4HufG1h1Ejly8mo7q2ZJHQLtiVUktGt5jwSXwrgE
         zR3bfV+uguJePFpTsmVGvEWLQ3006PzwNi5r5JmOQ8/DtEVpOTmI7m5/xTiQrgF0FpFk
         XMrX5ZpePeejftpczOgKVxV3X7D0wKg1kC1Dmnz+DWKtpo45AZkK8lAa576ajvknuPSI
         KM/2p+sCsFPV1CA0/qDuxxPFSt9wQytc7zxW8bl6JPi1riT2VKVdzWN+8ASalxSDLnnX
         0RIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1781049463; x=1781654263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        b=XkfutodTdC3aWFewu//ZtfbOXEP8PT/+JXGIH2EK+v3USw+hg623JDXIagiWJjV9+z
         qIwFHvEWF4lszgEHh/eFJfxSHDoXHlXRX799qyjokf+BXr8jEraQuiRhdXJ3qsuhVyc8
         CZvV8faGpk2SHfvMUoDaSK5Vmkz4LFHipNl4CmacHz+/7Aj/D6ANtoztAnqCg0qysTqo
         ASQ8yC5CDwDbTcHcxkow2X+yAWm6d72oyuxgfezfMQhLdspPpc2kSpYp4PncrbuoXi9a
         4IITgy+W6/Sx+IN3uiptKMmn7CBq253mvGubffw1lX+GNHWQ5hy7v2QZy/2Cecqggifz
         +JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781049463; x=1781654263;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        b=Kd4nwK/9ijDl5u79Q1pK/2CS96d7F9Bq8RBNCWW4zh85wWiSBv/6tMVETWg8OPe8lU
         B2N9Q3H2IFlPlDziNm34jMSSeI5zoNcJS6gPbkDT+h7MmKTfPuTGcEyedtPjWSFZb89p
         SSrE/2LKD5vjcZlIN99sUw81gMat4XixgWgBqYUK0BDSA3N/Gc65Ifo0KdEJsMUzbcma
         LmyKURRiwXuPljB9rly7lOHN/RPBTCcehbu5Uv6I3miGkhiu/CwAEQA9z6TcvEvAwb2j
         P9R0l3vONuld6B5EBlEMVZzYNfI1I/5/iwtgWvnjr0dFL4ylgnd4wDNfQDxi9wnqkjbU
         tInQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YMT8q9lYoK1acmHlh62OBVRp+0bh4hOQ0kqtWfE/nM1l5bHrnN4v6tJq56GmozVC9yqRO+XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmfmA7XUh9NTgCQ7rRSIuC+YkXRy8NntYD8xtcHLen68J3NMj
	PoClUmPkZHIP5H7wakOIYeXPFaDQTMKqR3PwBwi9sOcJ8Yd2dCDF4B5Y73mJKBHJ2dXk1ipAup1
	Wdk34WW4ieubgcGil0t1TtT1XVyoNXt7hSTk6Cq/7
X-Gm-Gg: Acq92OGHeZ+bEkAObEEfhf4gdw3VXdQnF324VfNrCu1ixDClGUAGdXdrsaKldWVkuoR
	E1sgJeSnmzld9yP+BznEcPTZmmA7vladh9qqa20oHRPZOukiis4QWtv5brQa1vJEcejLaTaHDpb
	jas6F6CaFQULOJ08rsmGX5leeAp+neAlV54IEwfkjWeCj8XSEvB+Uk34V6Mi1wCffgAhYvkktNb
	fkXWNv9DAtbcaCvRd0Q3Y+rfHV1wsAjlG1+2JV6rPUfkK07raKRs9UhB3CWGAnmjh/f64Ex3nuA
	EkN6S7Q0yfprtkKPVai8
X-Received: by 2002:a05:690c:e3ca:b0:7bd:5c77:1aa9 with SMTP id
 00721157ae682-7ed09935207mr231089217b3.0.1781049462534; Tue, 09 Jun 2026
 16:57:42 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 19:57:41 -0400
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 19:57:41 -0400
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
References: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Jun 2026 19:57:41 -0400
X-Gm-Features: AVVi8CdwZwsROR8QvBcPRl0TTYKS3lybsjC7VZyFrbO3L3H_GqOslrHHbiWZhF0
Message-ID: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
Subject: [PATCH] cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>
Cc: Farhad Alemi <falemi@asu.edu>, Yury Norov <ynorov@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Waiman Long <longman@redhat.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

cpuset_update_tasks_nodemask() rebinds a task's own mempolicy to the
cpuset's effective, online mems (newmems, from guarantee_online_mems()),
but rebinds that task's VMA mempolicies to the *configured* mask instead:

	cpuset_change_task_nodemask(task, &newmems);
	...
	mpol_rebind_mm(mm, &cs->mems_allowed);

On the default (v2) hierarchy a cpuset that has never had cpuset.mems
written keeps mems_allowed empty while effective_mems is inherited
non-empty from the parent, and tasks may be attached to it (the
empty-mems attach check is v1-only).  A subsequent rebind -- e.g. from a
CPU hotplug event walking the cpuset -- then calls mpol_rebind_mm() with
an empty mask.  For a VMA policy created with MPOL_F_RELATIVE_NODES this
reaches mpol_relative_nodemask() ->
nodes_fold(..., nodes_weight(cs->mems_allowed) == 0) -> bitmap_fold(),
whose set_bit(oldbit % sz, dst) divides by zero:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:bitmap_fold+0x5e/0xb0
   mpol_rebind_nodemask
   mpol_rebind_mm
   cpuset_update_tasks_nodemask
   cpuset_handle_hotplug
   sched_cpu_deactivate
   cpuhp_thread_fun

cs->mems_allowed is the only nodemask in this function that is not the
effective set: the task-policy rebind, the page-migration target and
cs->old_mems_allowed all use newmems.  The sibling cpuset_attach() path
already rebinds VMA policies against the effective mems
(cpuset_attach_nodemask_to = cs->effective_mems) and explicitly notes
that mems_allowed can be empty under hotplug.  Rebind the VMA policies to
newmems too: it is guaranteed non-empty by guarantee_online_mems(), which
fixes the divide-by-zero, and it makes the VMA policies consistent with
the task policy and with the nodes the task is actually allowed to use.

Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: stable@vger.kernel.org
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)

 		migrate = is_memory_migrate(cs);

-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &newmems);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
-- 
2.43.0
