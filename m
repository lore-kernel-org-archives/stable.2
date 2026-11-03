Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671667;
	b=v0q2KL0Z1VVXxV8Bfh102Rlkir9a9aVoAkILdlA05za7Lrqf46bH8pIiHZQmtaMAUxI+
	 lFoKAENo7vAVn+axCcGIwYvi1ktB1u9Lp/RAdG1B1GhOgzPnO9zfRE1VAZDVR6Ctx0nIy
	 LbZYF0vHkt+MbaXz2MUygUpaN2sWSyiIFKUhIJw5zibaV2rXnDJ3pTE2gZDgU7Hf7u6Ra
	 N1KoJriqMIaTk07oa/NKehbw8+cerTHcUs2HApFX1vY2jVP2/itptBekXjlub3YnTzWlg
	 edUT0Tlp7hWQP92Ne+L2/Lt7eRjRPIE6lYRuD18jG6HR/tUwXiVOxQ6vmGxmyqycmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671667;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UZFi2mAWq4lB8sfvhCBMvmbDAWZypjFWJ5S9ABz2IMQ=;
	b=GeSc1BWm3ZXhS82ODvwP2Kj8/B7VboSEAOmwixQlfb4MBta3y7EHiMIXwIDLGj3hwotq
	 aUYDMfxGu0LoAXi/PIvZmBAK/IfZLjM/lYNrb4uRNpf7RsvzTGdw2ib/fVRzTEe/nzttn
	 PyG76wBt4ZkCalHHcMcw4NBHiue4tANH9YogwErQTYJhC75382mF024IbrSx3rkRLTvyY
	 deQE58LsPhwhKzUjTnWZ12tQJvdZHlb28H/DLEk2gtOvZ+fSZ+lXI5NIDuvFa99Pgh3aE
	 WUOGe8c4HlO0k3UpSnKHEPInQ1bxckFYPm/OSnOGoiVgHPWwwZd6nPeC2jSytXSofcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PLDr99jG;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139B606A32C;
	Tue,  3 Nov 2026 02:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C139B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PLDr99jG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UZFi2mAWq4lB8sfvhCBMvmbDAWZypjFWJ5S9ABz2IMQ=; b=PLDr99jGAHpZOPhy+SMGmYcYQc
	9qGVEjN70Wa7zfgxRDMiqCJLtSwU2mGacYQG7JTRIKjtooQhX1+kxk71XIgshMOnbNrIMmlSI8UBS
	xE2Sgj1RgcQ77yAZZ+2wLc1YrtzB8zcjyC3CJ0G5ddTBML2n9d1eIiHj4HYWXybdPO4R2SwlQ3zqT
	28gyvsUtpir+7LPw/+aYSd+nSeSz6u36d2RzRw9nVBMfhI2c2ytYodwG7vkYkBdhdL5bUh7jA9TU5
	CV0BiovbsHohoYKYdthwMNDblTVBpTwuUZDkVpNwqMZXSgWZAIYfKHquY/Pz2K1Xu/x2wtMwp6HBY
	07WMVa9w==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3w9-00000000qwc-3pSM;
	Tue, 03 Nov 2026 02:07:46 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] maple_tree: Update internal warning and bug_on code
Date: Mon,  2 Nov 2026 21:07:24 -0500
Message-ID: <20261103020724.2614498-4-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103020724.2614498-1-liam@infradead.org>
References: <20261103020724.2614498-1-liam@infradead.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DEBUG_MAPLE_TREE is set, call WARN_ON() once per site after
the custom information is dumped about the tree.  Without using the
kernel's WARN_ON calls, syzbot will not catch issues detected by this
code.  The BUG_ON variants now stop instead of dumping and continuing.

Update the non-debug code to call WARN_ON_ONCE() as well.

The userspace tests asserted on dump_stack() but only print on
WARN_ON(), so make WARN() fatal in maple-shared.h and have the maple
test exit with the result of maple_tree_seed().

Cc: <stable@vger.kernel.org>
Reported-by: Lorenzo Stoakes <ljs@kernel.org>
Fixes: f0a1f866aba1 ("maple_tree: add debug BUG_ON and WARN_ON variants")
Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
---
 include/linux/maple_tree.h          | 48 ++++++++++++++---------------
 tools/testing/radix-tree/maple.c    | 13 +++++---
 tools/testing/shared/maple-shared.h | 33 ++++++++++++++++++++
 3 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e30e57f5f3df9..3a9751c6689fc 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -680,7 +680,7 @@ void mt_cache_shrink(void);
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
+		BUG_ON(1);						\
 	} else {							\
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
@@ -696,7 +696,7 @@ void mt_cache_shrink(void);
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
+		BUG_ON(1);						\
 	} else {							\
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
@@ -713,7 +713,7 @@ void mt_cache_shrink(void);
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
+		BUG_ON(1);						\
 	} else {							\
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
@@ -722,16 +722,16 @@ void mt_cache_shrink(void);
 #define MT_WARN_ON(__tree, __x)  ({					\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (__ONCE_LITE_IF(ret)) {				\
+		pr_info("WARN at %s:%d\n",				\
+		__func__, __LINE__);					\
 		mt_dump(__tree, mt_dump_hex);				\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
+		WARN_ON(1);						\
 	}								\
 	unlikely(ret);							\
 })
@@ -739,17 +739,17 @@ void mt_cache_shrink(void);
 #define MAS_WARN_ON(__mas, __x) ({					\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (__ONCE_LITE_IF(ret)) {				\
+		pr_info("WARN at %s:%d\n",				\
+		__func__, __LINE__);					\
 		mas_dump(__mas);					\
 		mt_dump((__mas)->tree, mt_dump_hex);			\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
+		WARN_ON(1);						\
 	}								\
 	unlikely(ret);							\
 })
@@ -757,18 +757,18 @@ void mt_cache_shrink(void);
 #define MAS_WR_WARN_ON(__wrmas, __x) ({					\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (__ONCE_LITE_IF(ret)) {				\
+		pr_info("WARN at %s:%d\n",				\
+		__func__, __LINE__);					\
 		mas_wr_dump(__wrmas);					\
 		mas_dump((__wrmas)->mas);				\
 		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
-	} else {							\
-		atomic_inc(&maple_tree_tests_passed);			\
+		WARN_ON(1);						\
 	}								\
 	unlikely(ret);							\
 })
@@ -776,9 +776,9 @@ void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
 #define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
 #define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
-#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
-#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
-#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON_ONCE(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON_ONCE(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON_ONCE(__x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 /**
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index bfe4b8626c429..846c67e20e82a 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36502,22 +36502,27 @@ static void regression_tests(void)
 	test_spanning_store_regression();
 }
 
-void maple_tree_tests(void)
+int maple_tree_tests(void)
 {
+	int ret;
+
 #if !defined(BENCH)
 	regression_tests();
 	farmer_tests();
 #endif
-	maple_tree_seed();
+	ret = maple_tree_seed();
 	maple_tree_harvest();
+	return ret;
 }
 
 int __weak main(void)
 {
+	int ret;
+
 	maple_tree_init();
-	maple_tree_tests();
+	ret = maple_tree_tests();
 	rcu_barrier();
 	if (nr_allocated)
 		printf("nr_allocated = %d\n", nr_allocated);
-	return 0;
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }
diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
index 2a1e9a8594a28..5f827709773a0 100644
--- a/tools/testing/shared/maple-shared.h
+++ b/tools/testing/shared/maple-shared.h
@@ -8,6 +8,7 @@
 #include "shared.h"
 #include <stdlib.h>
 #include <time.h>
+#include <assert.h>
 #include "linux/init.h"
 
 void maple_rcu_cb(struct rcu_head *head);
@@ -20,5 +21,37 @@ do {                                            \
     call_rcu(&((_p_struct)->_memb), rcu_cb);    \
 } while(0);
 
+/* Make WARN() fatal */
+#undef WARN
+#undef WARN_ON
+#undef WARN_ONCE
+#undef WARN_ON_ONCE
+#define WARN(condition, format...) ({				\
+	int __ret_warn_on = !!(condition);			\
+	if (unlikely(__ret_warn_on)) {				\
+		__WARN_printf(format);				\
+		assert(0);					\
+	}							\
+	unlikely(__ret_warn_on);				\
+})
+#define WARN_ON(condition)					\
+	WARN(condition, "assertion failed at %s:%d\n", __FILE__, __LINE__)
+#define WARN_ONCE(condition, format...)	WARN(condition, format)
+#define WARN_ON_ONCE(condition)		WARN_ON(condition)
+
+/* Once state for the debug macros */
+#ifndef __ONCE_LITE_IF
+#define __ONCE_LITE_IF(condition)				\
+	({							\
+		static bool __already_done;			\
+		bool __ret_once = false;			\
+								\
+		if ((condition) && !__already_done) {		\
+			__already_done = true;			\
+			__ret_once = true;			\
+		}						\
+		__ret_once;					\
+	})
+#endif
 
 #endif /* __MAPLE_SHARED_H__ */
-- 
2.47.3

