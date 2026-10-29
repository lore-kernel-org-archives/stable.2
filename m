Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306054;
	b=gsXT6BHyZKGlwXbqiaWShy5Sv4mI/ImA/rEKYH8sy2Pc5+1YBs2/+Qk0k7nbN0AilJjt
	 PL9tbR5ryJkpgZiESib42DyZQIiU51tF9nQSuKBo0S5JNoMXP+/GwVjCP1MoD+jg+CLYT
	 hP739jBLiw1VinbRfAPqCGih79a1oz5PeFQrPK3HRnVeih2mMJ4/TDAOzHm4ycz+R9di9
	 GNyGiEhMQhsErT+6hHx4axHUy4DK/C3iunn688+PvI49dEV6dUft/58A9aMgG9C6drbRv
	 5lsG8PFIzSrlLK+Blzp6oOi8hi/P8sEYUtR/7kiXd2qegNPoWUzzWqiJfi6uN3YGCvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306054;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IUH+yaBKom46Q63QM7iBm+f59t3sGZ4mQyL9p/SX3S4=;
	b=V5SeLI6SjYh55ovDZ/37FEa8Q6gPrSVh3svpWKcVQMw+hIcp7Y5KU7EANKHlXow04+xZ
	 bvu1ZAbj7yKsHcdczgUJvYVCr/T5y64qrypnDcJ5hbkhc3XrP+sJSaSItu/2GpA0Rnrdm
	 lgNN7fLgljezueff+lhEK6wFEbp8TjEVjHWR//C+TnKCLrg7k9LgjC+HDO0fVsrm1iZLx
	 vATyZUcdgvfGJfuEyScQ4S+teuC/6/pcmeL/TX7c7Zz9tZ5crxTaE3Mj2xo+VKpMeVk1j
	 G0A/F5Ght4oPV79jUJ+PZVB2Z24QIbQNyIM7cVbz2shYHm2urOEWpqMDzypVZ/C0a+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQKsyj+q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28512606A31D;
	Thu, 29 Oct 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQKsyj+q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F31F01828;
	Thu, 29 Oct 2026 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306053;
	bh=IUH+yaBKom46Q63QM7iBm+f59t3sGZ4mQyL9p/SX3S4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AQKsyj+qR4bxZGp8hAtyoQ1xOy4UZyL47FxstML+FqQX7G/y7pZ8l9SOf+5ou7WnS
	 AZ/MIxoJhVWJNFDauvFzu5zXAw5inOOKbVVHKcdXEUzqJPeX7wQfcuJQKHYfLV7cgT
	 DBS0xvxyeqIDcCB94oXE/FoCz/yzahtQW9be2ViknnFuUwiLNKNChtzZica7dWmXmI
	 rxJu6FqHy+hS0KRyeLYDs7SF6JTjHzt3/Fnx/dmoxM+iCSbUu0aeKsMfsauzJgHrdB
	 M2PNJNfSKISDgyTRDXYcWYfP+czRJ+zkR1pNBo2whDOaHlVJSA2riVVk0BtrRZThlu
	 TWT19hXESofoQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:32:58 +0100
Subject: [PATCH v2 03/47] mm/memfd: check for real shmem inodes before
 accessing shmem state
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
Message-Id: <20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3516; i=david@kernel.org;
 h=from:subject:message-id; bh=llGJ6NdJiWik0yJaZwx3srvBERv6b9fGHgw5NUViur8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21Ju85syDihqpSx8kZevq/BZ7vdCS+E9j8/nxLpZ
 /XE2Ia3o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgImo6DP8j8p2PfZIeerUF4kK
 Hjnn3G2C5wiVWez72jNt+fOvrBv2ejH84b6byOPtzq2/yLfz8kkfNWWZyr3pRUYsIhJrNjtK6AX
 xAQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

shmem_file() only checks a file's backing mapping. That mapping can belong
to another file, as with a Coda file backed by a tmpfs container after
mmap(). It does not establish that file_inode(file) is a shmem inode.

Seal handling and memfd preservation use this check before accessing
shmem inode state, so they can access an inode of the wrong type.

Add file_inode_is_shmem() to check the inode's file operations in both
paths. This identifies regular shmem inodes, including those used by
memfds and ordinary tmpfs files, independently of wrapper file operations.

Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/shmem_fs.h | 6 ++++++
 mm/memfd.c               | 8 +++++---
 mm/memfd_luo.c           | 2 +-
 mm/shmem.c               | 5 +++++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a7c7a96a7cbf..4996420cfe60 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
+bool inode_is_shmem(const struct inode *inode);
 bool shmem_mapping(const struct address_space *mapping);
 #else
+static inline bool inode_is_shmem(const struct inode *inode)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
diff --git a/mm/memfd.c b/mm/memfd.c
index 0f6fff004f5e..507c00ce0fda 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -211,12 +211,14 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
 static unsigned int *memfd_file_seals_ptr(struct file *file)
 {
-	if (shmem_file(file))
-		return &SHMEM_I(file_inode(file))->seals;
+	struct inode *inode = file_inode(file);
+
+	if (inode_is_shmem(inode))
+		return &SHMEM_I(inode)->seals;
 
 #ifdef CONFIG_HUGETLBFS
 	if (is_file_hugepages(file))
-		return &HUGETLBFS_I(file_inode(file))->seals;
+		return &HUGETLBFS_I(inode)->seals;
 #endif
 
 	return NULL;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..adaab98c8b63 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -581,7 +581,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 {
 	struct inode *inode = file_inode(file);
 
-	return shmem_file(file) && !inode->i_nlink;
+	return inode_is_shmem(inode) && !inode->i_nlink;
 }
 
 static unsigned long memfd_luo_get_id(struct file *file)
diff --git a/mm/shmem.c b/mm/shmem.c
index af21a89abb0f..0ca5b7f7a517 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool inode_is_shmem(const struct inode *inode)
+{
+	return inode->i_fop == &shmem_file_operations;
+}
+
 bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;

-- 
2.43.0

