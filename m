Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420947;
	b=BIVasuBifogIGfQmBR3GMAS9Iegh9YjQr33FkE4s3XCsHuM1GPc2U5rHXuQbVqQl1mR9
	 ZvvhS3wZDG8NaDzUB5V0hINTRDO8ngoNPYqTbN0SD47w028Vy3lAoUsbtRkfC0m7wMe3u
	 oMY3W/PY70ngPEC995eWPmkMunHxZkkLxIsFDq8dixyfDbP5pSbvceHKrmL3bug/JBXBz
	 0AKiTW+vREr/MK3073km+Yme4TqSz7u7WkyTIiFBV6kHvxW+9UU6EpInm3FdKTBTQfPRf
	 IljnThiPpbt4AgbAp232NEYd83iM7ujaJ5qVWvLCm9NDbDv5PMm4GNaBiIpxSUuHRgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420947;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=h5THLcBMLeSTN5K3PiMki3R6in5uEjKDjlZfoIyutMo=;
	b=GYvBbL1sPLZ8+WxceeZmz3JSX9KyTJBEQ0KgGmO0DkcudSYG86OqZhrPO6jlMvLa1rQm
	 PavJZWs0I3VBm2106Xblfjk8U9PUR15e9t+qXN7V7MAGQptquic7cPkgV3qv9buOOKCi/
	 hI8+5cF48uyvnefblXsUr7/5w+qvhuyeAyscu+1HkLxoR/6lNh2gl1ygo/QBMF4vYKiWQ
	 cIJnE/kVMstylMYCFctnuyALdCu1DOnTm3nb3LCR7cYpfdFdH1Ok+HWAqxuMIiGxFrXPe
	 rktnz/ae3mXYmU/ALYxs0xS9vs+QyDxh2SQfA5emj6GfHF3Ag2FB/IFc9Xe+oCPtkbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqUyIhVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0982606AE24;
	Wed, 11 Nov 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqUyIhVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9AB1F00A06;
	Wed, 11 Nov 2026 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420946;
	bh=h5THLcBMLeSTN5K3PiMki3R6in5uEjKDjlZfoIyutMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kqUyIhVMNg0ENWRKdyQc8N8j33+TGLGVIncqmNZ+vBtJ+7MWKgecLJZTcRZr0NYzA
	 EzwRv/U4qhhZNRxt/3BImeIrJ1AO2hWC0D+qCzXomrCIVcETdfHqQWqgclbJ7+RCV8
	 aNGyS6AgyZbx5pCIwNvZ17pvVbzgKMeZcUZXaLlk2BgjEkN6gJuYQFXZ8JNFDg674B
	 iUwDMVIrF0bAypSzyKgWOGX64GoQ2eQMO2gs3GWIpiZebajQE9dweskDOIW6toaZIg
	 cyQT2j5kW6RImC9NpPXIZ5bNkcsoeIb6RKIf01tBXjjLLroIRmYEdSDpG/qhLjUwse
	 Uaz7aZvEwK2/A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:24 +0000
Subject: [PATCH 10/13] mm/migrate_device: refuse to migrate shadow stacks
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org>
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
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=ljs@kernel.org;
 h=from:subject:message-id; bh=HHmymWLilfGbiIKGsQADYadldeCxqCYd2QRpmZM8e2E=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMj5vWSa2KLz1dauO05K6Z3KEtijvmTOfK11z7T4Z
 3Rt/bZ6UUcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAmwrKB4Z/lU8MZm4x/vDys
 deLU1yeRp+7s9jBJThIPlxf2Eby49zgbw/8aBblFpnmTK9+aPWg48PD07xOpOzbZ9HbYv7YP4vx
 qepMFAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

The kernel blocks ordinary writes to a shadow stack. But pte_write() is
true for a shadow stack entry, and migrate_vma_setup() sets
MIGRATE_PFN_WRITE for each page where pte_write() is true.

Notably, the nouveau GPU driver takes that flag as permission to map its
copy of the page writable for the GPU, meaning that the next CPU access
migrates the page back into the shadow stack, and the page then holds what
the GPU wrote.

Be consistent and disallow this for migration.

Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: removed unnecessary comment, refined commit msg ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 5fe11dd01291..a59864f2e9a6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -759,6 +759,8 @@ int migrate_vma_setup(struct migrate_vma *args)
 	/* The migrate_vma page walk has no hugetlb support. */
 	if (!vma_is_mm_backed(vma) || vma_is_hugetlb(vma) || vma_is_dax(vma))
 		return -EINVAL;
+	if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
+		return -EINVAL;
 	if (nr_pages <= 0)
 		return -EINVAL;
 	if (args->start < vma->vm_start || args->start >= vma->vm_end)

-- 
2.56.0

