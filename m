Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406942;
	b=JYUls9kjb6GuXAXCZOawvAYCBJ/0adPaW9qUpFysrbFQDZBR/eONIn2yrudqFU1nt52Q
	 WhS3EnUk6pkqO9/0CRhDurjl+/hBtXirD48mUYAkt5gL66cEPxZOd2rFaC2OV4zpOnwJv
	 m5vAr2B7qYYhhkivQzWGF/JKGTZedTinM2IOQyK9q95aQ4WI88we6T/y+8Hyks31JqiC1
	 0MnJ92PCUKlLM5RC90JgkTptei/nXSnNbi0OvVXJGx3jsSECdhhjRoDvIc6VTIz4bYZpY
	 um1gpPPigCoNU2oTIsA8gv81066nSQHbwAJFhLXECBz7xpEutCLPtC8LqSbe2c6g4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r8E3PoseFnyxw9EQuTlyTaJAaPz2HNKBD52yIZC9JSM=;
	b=S6LHJfhS4DDZxe9xeIkhFQMOVfRRUnABEKq/UbKYE57tmGU6U1ChBvqSB8ku7i2ex3rA
	 j+fc5UG0jxufjasdhBSynHWQAeKYwRW2cKww5vhemfx5RmtObQA9F0qepA0s60XUAdWS9
	 WlxliUjQVJNqpTfU6cFd7onIlUQWzsPc4fShsa4qn9X7+/Oj6XQ8kWqFhomMAL2IW0JSc
	 L8aRWzB2UvPYKeGdtEy4wv8B6hZLkuwcgB4A0JWEF0baur4Qp8+jcy7XJm3rCn6633j2C
	 HfhbDPGB1tY/TnoOTh51Di/jHwvl1yNRSS5ULSF6fQKdO00ergCVnKGB4kqfYCJrsKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpdXRY5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E28606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpdXRY5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8CB1F00A0F;
	Wed, 11 Nov 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406941;
	bh=r8E3PoseFnyxw9EQuTlyTaJAaPz2HNKBD52yIZC9JSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpdXRY5LxXa+vaMR1pA5AsWIGa7d0xqqUfeA+/6x+iBu1uCbS32ZQsQypeAW8DsFY
	 ckkIKXNDqNxTABHkOYI9p6hTnG+RilIIcOLxSk5WQg1yNxbQCAaV2f+bv1rpF5+wGB
	 Qq/M5TlrOsqliRsN+u3Nhc5o/f+Wvq5q05G2Tb3woCL99uNGCbDQwYnxHXxmm391rd
	 PEJYFt35a+G7ISDci6/TK7Vt3XbiZTCddV8uZh4/ID1TPeElFJSvSCnzjLilX2PkTm
	 EZJLHI7lViKS3iM3LbqwcoqweJRgJHxakN3VshqZHBuauJwJTyAr6S5vTlkV6/vYaC
	 Z/QG8KYH1baKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] mm: add RCU-based VMA lookup helper that waits for writers
Date: Wed, 11 Nov 2026 09:22:17 -0500
Message-ID: <20261111141158.1650349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050534-failed-7.3-7135a05838e8@kernel.org>
References: <20261107050534-failed-7.3-7135a05838e8@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit d96082aa35043cd1856e2213e683db778482a7d8 ]

There are basically two parallel ways to look up a VMA: the traditional
way, which is protected by mmap_read_lock, and the RCU-based per-VMA lock
way which is based on RCU and refcounts.  However, per-VMA locks will fail
if the lock is help by a writer and therefore never waits.  In a number of
places we need to wait for the lock and it's done by falling back to
mmap_read_lock, locking the VMA and releasing the mmap_lock once VMA is
locked.

Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
waits for writers.  This is basically the same as the existing RCU-based
lookup, but on a failure to lock it temporarily takes mmap_lock for read
and waits for writers to finish before locking the VMA, dropping the
mmap_read_lock and returning the locked VMA.  This has some advantages:

1. Callers do not need to have a fallback path for when they collide
with writers.

2. Its fast path does not require taking mmap_lock for read.

Basically, when applied correctly, this approach results in faster *and*
simpler code.

While at it, fix the comments for vma_start_read_locked(),
vma_start_read_locked_nested(), and uffd_lock_vma().

Link: https://lore.kernel.org/20260831203056.838265-4-surenb@google.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Stable-dep-of: 7135a05838e8 ("mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmap_lock.h | 19 +++++++++++++++----
 mm/mmap_lock.c            | 35 +++++++++++++++++++++++++++++++++++
 mm/userfaultfd.c          |  6 ++++--
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b8a13b8d36a45..084fc66d7f904 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -230,10 +230,14 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
 }
 
 /*
- * Use only while holding mmap read lock which guarantees that locking will not
- * fail (nobody can concurrently write-lock the vma). vma_start_read() should
+ * Use only while holding mmap read lock which guarantees that vma lock is not
+ * contended (nobody can concurrently write-lock the vma). vma_start_read() should
  * not be used in such cases because it might fail due to mm_lock_seq overflow.
  * This functionality is used to obtain vma read lock and drop the mmap read lock.
+ *
+ * VMA can't be detached while we are holding mmap lock, therefore in practice this
+ * function can fail only when there are so many readers that vm_refcnt overflows.
+ * The failure case is very unlikely and is already annotated as such internally.
  */
 static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
@@ -249,16 +253,23 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
 }
 
 /*
- * Use only while holding mmap read lock which guarantees that locking will not
- * fail (nobody can concurrently write-lock the vma). vma_start_read() should
+ * Use only while holding mmap read lock which guarantees that vma lock is not
+ * contended (nobody can concurrently write-lock the vma). vma_start_read() should
  * not be used in such cases because it might fail due to mm_lock_seq overflow.
  * This functionality is used to obtain vma read lock and drop the mmap read lock.
+ *
+ * VMA can't be detached while we are holding mmap lock, therefore in practice this
+ * function can fail only when there are so many readers that vm_refcnt overflows.
+ * The failure case is very unlikely and is already annotated as such internally.
  */
 static inline bool vma_start_read_locked(struct vm_area_struct *vma)
 {
 	return vma_start_read_locked_nested(vma, 0);
 }
 
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address);
+
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	vma_refcount_put(vma);
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 898c2ef1e9580..f7f1c6ae25910 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -341,6 +341,41 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	return NULL;
 }
 
+/**
+ * vma_start_read_unlocked() - Find the VMA covering 'address' and read-lock it.
+ * @mm: the mm_struct of the address space to search
+ * @address: address that the vma should contain
+ *
+ * The fast path does not take mmap_lock. Waits for writers to finish if the
+ * VMA is being modified by taking mmap_lock.
+ * Use when mmap_lock is not held, otherwise use vma_start_read_locked().
+ * Nothing prevents VMAs being unmapped/mapped before or after the VMA is
+ * looked up, if a stronger guarantee is required, take an mmap_lock.
+ *
+ * Return: If a VMA exists which spans @address, return that VMA, read-locked.
+ * If no VMA is mapped there or, very unlikely, a reference count overflow
+ * occurred, return NULL.
+ */
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address)
+{
+	struct vm_area_struct *vma;
+
+	/* Fast path: return stable VMA covering 'address': */
+	vma = lock_vma_under_rcu(mm, address);
+	if (vma)
+		return vma;
+
+	/* Slow path: preclude VMA writers by temporarily getting mmap read lock. */
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, address);
+	if (vma && !vma_start_read_locked(vma))
+		vma = NULL;
+	mmap_read_unlock(mm);
+
+	return vma;
+}
+
 static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
 							    struct vma_iterator *vmi,
 							    unsigned long from_addr)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc37b60fc3e81..bbe921f701594 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -130,8 +130,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
  *
  * Should be called without holding mmap_lock.
  *
- * Return: A locked vma containing @address, -ENOENT if no vma is found, or
- * -ENOMEM if anon_vma couldn't be allocated.
+ * Return: A locked vma containing @address, -ENOENT if no vma is found,
+ * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
+ * overflow happened due to high number of readers and the caller should
+ * retry later.
  */
 static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 				       unsigned long address)
-- 
2.53.0

