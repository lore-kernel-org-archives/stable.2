Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606439;
	b=ViYP4K/hQZGgd/q78uk2MoqjhHwOUq8n6mUNZ/jnA4dHIQvVbuXrVdCqqqvnMqeZk7BZ
	 P3s395DJH3oBG0PZJtVhep/tnXPXAVt4iyyYdbmTBjWvit47Mh37RswInitg6/MA55leb
	 gNkvrylqpnm/Ig/rmzbF66Fjsub1FaJf4WJVmEDfSvUUrwxbNHe5djtfYCjyfczbzOoUO
	 eACrJN0dszUiFl32infgz7oyWdAnYe89ORjMB1FhMHTQjzNhl0+Fb0CdC+SbQ5AL2Zpyg
	 PMLfqUH46WY+8/nuScyglfsCEayBDJxbSRe7UIS+qd0ZyxaPyTZEhHBPCbUOChT40ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606439;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=E4Aqk3iT1Oi/fEczmw1TcDEWRUX7zaDgOrezCzbiQY8=;
	b=fUPTJlD9J60AP/1GXPyvrhGEcvwpZWk7Y5c6SOeAk6icb1PR9Qxl6G0lPeT/DCu6ri0d
	 krkbzAPiY8/E8QP3k7q8qaH4to9s/biV+Kjq326hACm+WTty3wcfql93N4fZu7rUFESBS
	 l5MtfTn3zBgFCmxW2ET0+fWXYYg3mViNFPNk4OYEMrhknj4D1edmJG13rBc4rc8lM5iHJ
	 Kamfepb5riMy3stDz7o3CKnKeP1qf/7tgN+eTm7uuwF3LmCLl4laNdddcvHmzvOgpz558
	 fhptyr6mx4mh8LazavdBMKNqUOiNAdOsm5SBB22fgkfs/Ha+Xe4eQakoNNJDkVVWn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpsKHxX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D73606A327;
	Fri, 13 Nov 2026 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpsKHxX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6D51F000C4;
	Fri, 13 Nov 2026 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606439;
	bh=E4Aqk3iT1Oi/fEczmw1TcDEWRUX7zaDgOrezCzbiQY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VpsKHxX2AU+5/DCbWoy2fUQ+wtOkI+t+IJ/21DZmhIGF/sU3wj9+7HA633/W2O4Eg
	 4JWFxHgH7IpvZuk3bBw3jCWGjJcOoAGtA0ObLmEVLuEAlJ5u4YP8LywYl96wmJuBzS
	 BD2jqHZqtWs+CeaAMQ6uRsruhfKrEyjcegVW2pLVPmZMKhLVEMObs7qmKYBMBJ5Wel
	 SxqnlEo6cGOzPyOIn6/C8hTAXsN8HyVFQuV3WuvRrCaLPZoGqVcrRqk6/8l7DWUznl
	 twTHtxBk0359K6MfoZ4wGUxh1QnBpRIraPTdjSAcHc7Wcqlp4Uwroi4UaoptVEtYjb
	 OW6z3EmId9CRA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:28 +0000
Subject: [PATCH v2 10/13] mm/migrate_device: refuse to migrate shadow
 stacks
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-10-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=ljs@kernel.org;
 h=from:subject:message-id; bh=d6aN2vWdVPIYwFHWomh3wqXyU/Zgbbc4Yfcyjsj4FMU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/x0cw362LHnkgK3WJHNnKD9mqxhFxM1X7+Tf/JEx
 HB+1gXNjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzkegPDP0vepb4v6oID7197
 sujayknrsrn/TViZvJ352LKgHe0nXn9j+CslJV9Xmz2hYEqWa9IagfsL3edmeMnfNmbXP+Zqsyt
 yPhcA
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
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: removed unnecessary comment, refined commit msg ]
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b4660eeb975a..e0bf6afe0768 100644
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

