Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420909;
	b=u+RRs9Ah/km95QbEN/630mNW/qnQ/qq1xoZvZEBjAFLuupTjkTi6nvJoJ2MaQZfXBYA+
	 Uud4lTJeFHdAwLuyE3JhByrM6I3Dspyl5bVTVZvA6USZ0T+P+2wfWy0TggmXGuDq/Qlfc
	 9YJkGR38S14G+eOH7STDlu/jCIH6kLqXdKPqi63gFgA9VlYWiLz7y5XxNv69/5tun0BRz
	 x6SYwHuVGHnWNb9ZdAlBAoqLAiPl2hz3pOXLirrkpvI27wSZc3lwUaZY+wdcDkZhTRjct
	 yEN6MtdxzLfT86OY18HXxiqo5FtSqJkWVqD8g5ixq5g7tY1lVyl1m0RFyE0U0Js5iWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420909;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NaCGdAZFU1z2YSGcCoqnUOLBqNj5/a8OsE72YWxUAAw=;
	b=VS/cI905U6MTOy6QsTfixn1Ukp/F1EoXU7H6A4WOh0oIq0LLm4QvHJMiAoLXeUR/Iknp
	 zZxDdeDyOqLItbGaoP9fHHDDIRFgKva+//LRpJP3tpAgRsp1sAHbVCFUCzrIuZ/tWAClA
	 p/B68LD1icVi+6W7xsiybCt4Ac85vL3fMuQNDrEzKVPndUe+vNeZSBPE9R8bE91zUTw6n
	 HizJQOLXZck/Ew+3VFCeyRPzSI8zB+8ZTaI41YSwFwCcJadKdxR0ABP+XkfWWyjlZaH1E
	 TCJP2xqxBAnLgdWNGJeiTURG6MXdRJ4BxGhDi7OSc6o+f6jUbdRSo5DE8WAStUi372w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnPJqPlu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEA607013E;
	Wed, 11 Nov 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnPJqPlu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BA91F00A05;
	Wed, 11 Nov 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420909;
	bh=NaCGdAZFU1z2YSGcCoqnUOLBqNj5/a8OsE72YWxUAAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DnPJqPlu4G7knZgeHK4wye/RZiaNpcz1rdYnJCH5Se8RJTolf+zsB5C0WYDsPiaKp
	 NtNncTGwbiM3I+lHGCpYN+ZuKR7AVKoCIr72MLOehDdubOkD5r1vpnYdjUUNyzwjBZ
	 VP5p1i8f5XfSaO+eqNMpTEy/olsQJEjokv7GEOYrMDswpURevS6doBi+Vlc7UtPtET
	 b0fNxuqAnm33ZuTrlAbzJv8SNNPqmIAa+FlGwNq/uWwCfShq+P6wapgt0EuaYAwqgp
	 Q7EkYdhTY3uIqfMJOCHHJxttp0vv1bhrWU4ThZxRlHPbb5euj42t+ODQw2FJNTHMV0
	 p2pEs8ac20RQg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:20 +0000
Subject: [PATCH 06/13] mm/migrate_device: don't let go of the fault page
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-6-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=ljs@kernel.org;
 h=from:subject:message-id; bh=W+/JIRCjXf8mo6Ivny1TOt/IqNOFsXqGJrUphYME/e4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMi+HPonq1B9CYvOzr6G64tX9q1xWX5/S6b+zSNbt
 KYbsEamd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiB7Yy/I9vb7gcLi00xWP7
 JiPxCi+O1G4Gln9OT1POzl3t5PdT4yUjw6qr7stSH+xPtUwVnhi3JWSWBL/KNcluG4ONf65eCYp
 axQMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Josef Bacik <josef@toxicpanda.com>

When migrate_vma_split_folio() has split the folio of the fault page,
the lock and the reference which the fault handler has taken are at the
former head page.

It then moves them to the folio which now holds the fault page, by
taking a reference on and locking that folio, then unlocking and putting
the former head.

split_folio() has unlocked the new folio and has dropped its own
reference on it, so until folio_get() nothing but the page table entry
holds it.

Only the mmap lock is held for read, which does not prevent another thread
from zapping the entry with MADV_DONTNEED.

If this happens the folio is freed which results in folio_get() taking a
reference on a free device page, which the driver can hand out again at any
time.

In addition, folio_lock() can sleep here with the lock of the head page
held.

Utilise split_huge_page() which will leave the lock and reference at the
fault page correctly.

Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: tweaked commit message ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 28ed706109da..ae795fdf36f4 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -87,39 +87,20 @@ static int migrate_vma_split_folio(struct folio *folio,
 {
 	int ret;
 	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
-	struct folio *new_fault_folio = NULL;
-
-	if (folio != fault_folio)
-		folio_lock(folio);
-
-	ret = split_folio(folio);
-	if (ret) {
-		if (folio != fault_folio) {
-			folio_unlock(folio);
-			folio_put(folio);
-		}
-		return ret;
-	}
-
-	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
 
 	/*
-	 * Ensure the lock is held on the correct
-	 * folio after the split
+	 * The lock and the reference of the fault handler stay with the
+	 * folio which holds the fault page after the split.
 	 */
-	if (!new_fault_folio) {
-		folio_unlock(folio);
-		folio_put(folio);
-	} else if (folio != new_fault_folio) {
-		if (new_fault_folio != fault_folio) {
-			folio_get(new_fault_folio);
-			folio_lock(new_fault_folio);
-		}
-		folio_unlock(folio);
-		folio_put(folio);
-	}
+	if (folio == fault_folio)
+		return split_huge_page(fault_page);
 
-	return 0;
+	folio_lock(folio);
+	ret = split_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+
+	return ret;
 }
 
 /** migrate_vma_collect_huge_pmd - collect THP pages without splitting the

-- 
2.56.0

