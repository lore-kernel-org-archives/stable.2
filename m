Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808753;
	b=prLLv2cU7Uln7T5DLBzSxr+NihgrnWPtl3LiPM8Sg6DYBTTgznUCv6MyvPlfv8YUrwUP
	 7V/m6GL6RrX70UfuYYiOBRyU+UqlXVMKPz97gPy2fGbh5I2Rfgzupx/yqv/Fz8NV6Pm9J
	 SlbswK6b16/6hYidZthcQDpX+wI1JJ9cDLasRZ6AnBQ/s3Lgks3++ZTb7EQTyxFOX+JL7
	 TgrxY/orIhDod99orbZh7RNkxZDKYwltcYRPfNaIsZHhRry2EaU1HT1ekIKcmKU1BaAlG
	 yphlW/hdHmPkZtCb20NtKEWtRHJeKXus1Blv+j2opX8OVwq+GjDUDAugta0RTVvk9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808753;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ccqqo8bkY7xL+HYcO0JWuLLFtKCJUhxP0ky2YEXw5Wc=;
	b=rsu0oxHDoOHNifXAzXBBjtHAi6xDfdFvSkGVdpBuNxG4VCZcSFxA+i3lEBKXjrZl/kn+
	 2XWeXniVom7+HHV6/ZehkFAhIGjvLbb7IN3zHeW5Nb8Qk8mgNL8+d2Kn0TQvuOJHeG44j
	 9HdvBZQZpd3bC9qyat03aImq65BAcH6rJS+tLO63mTgJBziZwU+mrP5hJF17+5xZ2G2fY
	 7QAdzLgWg7kAel5unbJnXni3HYQCsn/Fn1BiV7eGruhHAEadC0KfJ0df8acWTsw1AEhZS
	 2hJ35arCSM6oG6+8wDfBW85Ay86x7Bts3UdvLhpiCVCX7wPbT/xQBCIU8tmeS4ACA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1IJVo42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87850606A31C;
	Fri, 27 Nov 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1IJVo42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E441F00898;
	Fri, 27 Nov 2026 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795808752;
	bh=Ccqqo8bkY7xL+HYcO0JWuLLFtKCJUhxP0ky2YEXw5Wc=;
	h=From:Subject:Date:To:Cc;
	b=U1IJVo42+yjUoLPOMPFgOCbISQ+dYclpD5Wc8wo+oDtr3dO/WJ0X5NJGF6QfhT5zC
	 afVN8BrYB2sSCkOLwhh6NVXWXeNFW9uj8RepxTvndcHK+8bTDEAB5hEIKKjE/lVW0D
	 NfoV6+saJtZsP/ssWkugYBjUH6nmTB2iXjgZzJIF/m295J0HQ+vwvUxOI/xifuNzsT
	 YRkRvKMFg004fYOQNepBRYO0icOTiiJyimCc6Sbl5zqFATngKBNAoObE6KKxCRZW8X
	 UAxa9ZacZGlg4NI2y18B/hYfUEL0eUCMIJe0J+Ln5SN1X3aSHIfMLdUXaP48MDKir/
	 z9IOtQ4GVGyFA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/4] mm: AI-generated fixes for coda, madvise, mprotect and
 PAGEMAP_SCAN
Date: Fri, 27 Nov 2026 19:45:39 +0000
Message-Id: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3JQQqDMBAF0KsMs3agyaLFXKV0kcSfOtgYyYgUx
 LsX+rbvZENXGAc6ueNQ07ZyIDcQ5zmub4hOHIj9zd+d8w+pn5YXqXE61CB1621H3iWqFP3CBAU
 plZgwjpkH4q3jHxzo+bquHzj3+N9xAAAA
X-Change-ID: 20261127-mlock-madvise-mprotect-ai-fixes-efebbfabe99c
To: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
 Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
 Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=ljs@kernel.org;
 h=from:subject:message-id; bh=aeycByJuRD6O/7hAo/Q3yNzTpVZuppfVH7qRNkz4Ftk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5777YO2/KyWkxJqtOXjlWKXDuh/yZT2k1C7boac97V
 as+89ftjR2lLAxiXAyyYoosz7+I7w8SCZvXecHfDWYOKxPIEAYuTgGYSPAsRoYHQa4OVmuFvZn0
 /19aL/LFm2f2mwfX2xfJzV+3apHTozV7Gf6nt08vEvR/eG1pxdxnq7SsRVZEabRkrzRtifyakB0
 TacAOAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The usual stuff - glorious gifts of AI goodness transmuted into a smoother
form by your's truly.

Please check for any insanity. OK wait, let me clarify - in the patches.

The only one that needs a backport is the first coda fixup, whereupon, in
the unlikely scenario of a container manager doing something rather silly,
we might end up with a dangling pointer.

Whilst unlikely, that one might be worth sending out sooner rather than
later.

The rest are the usual edge case stuff, one involving the truly cursed
'guess what it's possible to map at address 0 if you're crazy enough!' type
thing.

I shan't talk about the evils contained in the last patch. PAGEMAP_SCAN
deep inside your soul ye masses to find salvation from PM_SCAN_WP_MATCHING!

Anyway, as usual, please review! Thanks.

(Also note that a lack of Cc: stable is not a mistake, rather it means that
 I think the fix doesn't warrant any back port shenanigans.)

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Chris Mason (2):
      mm/madvise: don't declare OOM for MADV_WILLNEED swapin
      mm/mprotect: fix unpaired notifier start at address 0

Lorenzo Stoakes (ARM) (2):
      coda: never point a file's f_mapping at a container's mapping
      fs/proc/task_mmu: write-protect only with ptrace attach

 Documentation/admin-guide/mm/pagemap.rst |  4 ++-
 fs/coda/file.c                           | 14 +++++++++-
 fs/proc/task_mmu.c                       | 47 ++++++++++++++++++++++++++++----
 mm/madvise.c                             | 19 +++++++++----
 mm/mprotect.c                            |  8 +++---
 5 files changed, 75 insertions(+), 17 deletions(-)
---
base-commit: c6f53520f32302ea64cbcfd7cc25a31081e34548
change-id: 20261127-mlock-madvise-mprotect-ai-fixes-efebbfabe99c

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

