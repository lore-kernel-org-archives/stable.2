Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606340;
	b=zyYeKBEvFFOwlCAMslMdM1tWW/voHFHziVttmok7pOyr7LsUDfQkRtmfTf6NC1its1Kw
	 vTSZFT6GZWzNzBbP6KSDUSZIQubYRezIyjSnpYfb2Kdi6mNELM4malBdFo+Y4CAc29xAY
	 PHrRq0fKMuTEC8aPf0uzHR48m71Ys1o5cGSiJFYJQgQEp3mrRdpUgszrrhpqfsgUit96Z
	 pEd1MfBwdLp9wnDF9aLjrZ8r+6lF2s2GApofPWqtSsFs2IlQwYmFuUlH9bYcyfeUA/GI3
	 4uLXF18Fs8DPLbveOFsIVtOSuXQYCdCykxciRn8hSkswheL0MnmTLz5eRYIAjyNjrVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606340;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Q0tWAXinCIgLv5dttmkNHUIbP0pSuN0NtpeU2dsb3tQ=;
	b=Lhbm+ieR11OHovjj+Etp/ySXecTdzIgeIpP+ueoNne9hEpGE8TJkDe1MCcgKZXjYIq9r
	 MUHLKNTtp/eKQp73w89y5eKof9rEK3jAopRme6mDeViE1oExk5AHIhPkzlfhq2D36RTqu
	 13LDp93hD+iLS14Mp08/AeOoJDWMLkAoFdAaSX0V1OgFvKkatiLkgjzFRPHlaf2L/nzbL
	 HvgwSxxwZK7e7VycEeaqGO15nHV8QLMCHbDKm0f3xZsSlp48j2CHsL1p/kxVV994sX1UP
	 zqq1yt0f7JEs/YGx/xFLEX/PT/MPhuiqaHzqtB6PJWV5sKGizqkuDMQ2o3d8mJveT/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fn8u7LCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FB606A327;
	Fri, 13 Nov 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fn8u7LCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40EA1F000C4;
	Fri, 13 Nov 2026 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606340;
	bh=Q0tWAXinCIgLv5dttmkNHUIbP0pSuN0NtpeU2dsb3tQ=;
	h=From:Subject:Date:To:Cc;
	b=fn8u7LCQR8nMJZBtx/n+P4sWBF0VR0jTAueDT0Kw27CAclWjmhQl2IpHuHNF4C8MM
	 ugt0dqKUv+L2lSkFpRfmzzIoPiUJA+wUdOXVRgo/jMskFOgwkLAOvm6vIFbMgxUt/f
	 iN4GIHbkW5mm6V9AY2D7zBp6NUhIMfi0bl6p2ixusZKmzFosVckwZe8aAf/rBKf4E7
	 RM7kbiY9hkwSbY2F/O9GLb7dvi1nr9hly4cEQmfCOgKzat8LvvGvf37BeXMgRBnFT4
	 ZYIW6LnHKVBtODdm1YOCKKbrAHtnM3cIbObeELAzVsf2nf1dgNm+3FZmMr/FsLs5VN
	 S77fwl6wjEP4A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 00/13] mm: batch of (urgentish?) fixes in oomk,
 cachestat, dev-migrate, percpu
Date: Fri, 13 Nov 2026 21:45:18 +0000
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TVtWRE9+R+GQ0NXaISWbAnRE
 P7dSjx7fDN5MyskFs8JrsUKwotPPoYM5lBA29vQMXqXGYwyldbqjKNNMeDoO7EzI89oB3z4Fyd
 UdCFXUl1TS5D9SXgvsn5vMvc+zVHe+9Wiv+lvVes/q4tGhaUzdKKyMly725Ml8HCM0kGzbdsHe
 25PYMMAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=ljs@kernel.org;
 h=from:subject:message-id; bh=YTbJV0/mNdYsHn7jyNW9SuR23YhuI1Yfpt13SCQKfeY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t3wNYrrWVpz4Sk/1zqKP3gzhMVUlRlVJBuJVCucy1
 +VOn/uso5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABNR0WX4K52k3XA4Vvzvvcvr
 n+bfuvhel/mN/HWuddtf2NYkPNa/4c/IMGPfLwdrdSFrlfTDftPYJONzzlXpHK/rOv1MVjw8ZZc
 XAwA=
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
v2:
* Propagated tags, thanks everybody!
* Clarified commit message in 1/13 as per Michal.
* Added a description of the fix and its performance cost to the commit
  message of 3/13, as per Usama.
* Updated 8/13 to also refuse to migrate KSM pages to device coherent
  memory, as per Sashiko.
* Added Gregory's benchmark numbers to the commit message of 13/13.

v1:
https://lore.kernel.org/r/20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org

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
 mm/filemap.c             |  21 +++++++---
 mm/migrate_device.c      | 107 ++++++++++++++++++++++++++++++++---------------
 mm/mmap.c                |   9 +++-
 mm/oom_kill.c            |   4 +-
 mm/percpu.c              |  69 +++++++++---------------------
 8 files changed, 132 insertions(+), 90 deletions(-)
---
base-commit: 7f04048247a69019ccaa9c152002d3601b19453c
change-id: 20261107-mason-migrate-et-al-fixes-0494d34884c4

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

