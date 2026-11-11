Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420854;
	b=2Sg6TPkODSiElGR+RvYqaRadCw+rWu5Atqrj2eF3pwbOEkoF17fW/2XwI+XKC5260cov
	 pvdscCcjlTg53wHxk/7DIVqnTWNprt23xqkv07Vut1STi27t7jpcugL+dTqweQHkA6HGJ
	 2uU4hToxQM9ZwdQMT6NPmJHcw3MWRfrx/KIfD6m/sxYT8tFNwDAiC8mX9CC2uhEJXVq1C
	 1skKEPKlET0xcxLwH0Ua3a90vosCdGzlkSyooeacxW0QnM7Vkdb7MLt556XtFCWeeSmXH
	 rfad6Apg6yoiSgtFbvcw4q9prm+PhXAiv0A4nSB/LpU0KRS4nDFi5y8Fgfcu6Jdcjkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420854;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P77y/7kt1y7+rX559SuEiGkJe08l/ufdA6D5PwoUHF8=;
	b=F2X4+MRkUfKaxcxnt4IugUK2o0wn4EejfsxUYr+90ZY8ujq2B6u+4nfmDld9xtKCpcv0
	 Hmu0naxoHyqQc/tETPWhpAZbLRXgaWCqZjBxOKo4+GgqCeGbr8iWFluF/a+Tuj9idCkce
	 H4LgUvFW/qhms6zdKdAylHVEcqGBiTiAmZlwGbB2+ZvkTBH/Tr1XxFxosvidd6xcDgdN2
	 RkBd4HPaGBgKAOvw6jTX1UPFKv8PO1Hk7B4jH+4hTRNFgJF9ucUiH2Qk3fTScimw2y5gU
	 SvZYrY1zKD0mcbkXzPQvkH+v5DZGjimwwK/2gMRPCj/IBqJ64kUPjXCVXqwBmiR7CXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ul6g87vr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE1606A89A;
	Wed, 11 Nov 2026 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ul6g87vr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C91F00A05;
	Wed, 11 Nov 2026 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420854;
	bh=P77y/7kt1y7+rX559SuEiGkJe08l/ufdA6D5PwoUHF8=;
	h=From:Subject:Date:To:Cc;
	b=Ul6g87vrcahtCdQQl18AuyzeILV3lOpch0X+0iIicnk0DlFQfuQXsmH9TaKZlQL/S
	 WjDLYnab3GQJwmbI9XfT1YShrJPtcnxuFDsaCS0yeUehxX53peguu1LeEqugWcT/cY
	 o8QG6XaUY5RInTkZy+ihZhQfRXGT/QLcSrXJr0xJc3MAIrV21R4YgwdDxn5d+eT6KP
	 MLlMz3gS1TKsARmHMDBHBZcR/zOC69qflX3oCBKrUE71W5RT5C0085C3gWBqrnZE5x
	 Ou3wpKGynuq0cReHCBYykC6OBFahHTbtVFSKZdlv3wFgVH7GvjBdqv6/vCypO8WAgq
	 HVUFXq0FaggHQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 00/13] mm: batch of (urgentish?) fixes in oomk, cachestat,
 dev-migrate, percpu
Date: Wed, 11 Nov 2026 18:13:14 +0000
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LSwqAMAwA0atI1gZaDf6uIi6KRg1olaaIIN7d4
 vIxzAPKQVihyx4IfInK4RNsnsG4Or8wypQMhSkqa02Nu9PD4y5LcJGRI7oNZ7lZ0VBLU0lNQyN
 B+s/Af0h7P7zvB5HA7NZrAAAA
X-Change-ID: 20261107-mason-migrate-et-al-fixes-0494d34884c4
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=ljs@kernel.org;
 h=from:subject:message-id; bh=qNocdPfgYdCqYkS09WXKZzoMqv0tyceAP/BmWJ6twEY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMh6/jjggEma/N5V3S07XynbZuybunzBqwu5UlJrv
 WJmeO2e0VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJCB5kZJjzxOxws0rvo5nh
 an+Tm1ZIePvFZaofOV4ukycVd26OHT8jw5p7drqvkg04c+4cX/256vjk2ds3znor/5nFZdLC0tw
 yRjYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A bunch of fixes for oomk, cachestat, device migration and the per-CPU
allocator.

These patches were originally AI-generated, tamed into upstreamable state.

Some are more reworked than others. Those which needed a significant
rethink are submitted as mine and marked as Reported-by the relevant
original author, others are smaller edits which are annotated as such in
the usual fashion.

Please check for correctness, sanity, and whether the cc: stable is
warranted (I have not included it for 3 where it seemed unwarranted.)

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Chris Mason (5):
      mm: cachestat: count each page only once
      mm: cachestat: restart the walk after each entry
      mm/migrate_device: fix ksmd oops on a migrated KSM page
      mm/migrate_device: refuse to migrate shadow stacks
      percpu: queue the balance work on an unbound workqueue

Josef Bacik (4):
      mm/migrate_device: allocate THP deferred split heads
      mm/migrate_device: don't collect a range twice
      mm/migrate_device: don't let go of the fault page
      mm/migrate_device: look up fault folio after a split

Lorenzo Stoakes (ARM) (4):
      mm/mmap: free gathered pages before MMF_OOM_SKIP
      mm/migrate_device: fix use-after-free of the anon rmap
      percpu: fix contig hints that are too low
      percpu: search the whole reserved chunk

 include/linux/migrate.h  |   1 +
 include/linux/mm_types.h |   2 +
 include/linux/oom.h      |   9 ++++
 mm/filemap.c             |  21 ++++++---
 mm/migrate_device.c      | 111 ++++++++++++++++++++++++++++++++---------------
 mm/mmap.c                |   9 +++-
 mm/oom_kill.c            |   4 +-
 mm/percpu.c              |  69 +++++++++--------------------
 8 files changed, 136 insertions(+), 90 deletions(-)
---
base-commit: 7f04048247a69019ccaa9c152002d3601b19453c
change-id: 20261107-mason-migrate-et-al-fixes-0494d34884c4

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

