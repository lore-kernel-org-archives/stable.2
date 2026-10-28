Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202168;
	b=yK6aEoaWjf++Xc6hMkWA8WrmdI8Yq4vLCdUhAQEdpoOVY5h4JZbR5zAbXh2iO/Ppilyo
	 ZJxa5CQsEtNCY5WPkkpcNC5iy2PHSNs3PA166fPIQNkQeoN5MNfO10xcQ73pGSsX/NrX1
	 XRQYE3yqjo5ykmJsm/+193EJW5H06Bhi2MP9XWXYyIPauFNhbAZ/Yr1PMZCt41BIDiD++
	 oxkBZsHm4b1t0ewjrVZej3qsWBtQA+kh8kiE6bxfReabiNe17boDkJn5D9x8i0IdBmNhQ
	 C/gZ12BS8MV56ae99qEAxwnQtzA7c4iJPZ2w+6DkmhNgncSjf420a8nY4txt4AQc3fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202168;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aLcHh9wVCNj0wy7JzbpEj3+SL2vMXcdXR22pTGdylzU=;
	b=1Ik/dLI/AeeoXAkyDl8hEMJwtwQTLD5EqIZIaOEzypHRCv25gfeHZJ75kd46vpFTKvjA
	 nV3c0rpTlJudkT6T979FOc1V8YFf74IVU2hPSXRMA8gjTckbmLwQypJ+NvA6ekS944q2k
	 9E8404hE7yS5qxl3hlvMpgVz6Hc2rVXcOyyHp2R+hpqCvrGA1XUuOJ3sKetwbIqIRSwSp
	 9K7eqGbGYzF4Vr3S0PzdPNprqmx6zAMeraGcagN0uH2RXRbnLJtkyITqmq+B/kc9J8Oqi
	 Qe1LSl0RENdOXbpI/wvNCRrBW7Df+KMafetT4e8uCz0yBHpytyC2cH3V29xtQpwZgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="E/BHRL6D";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB9606A322;
	Wed, 28 Oct 2026 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FB9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E/BHRL6D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aLcHh9wVCNj0wy7JzbpEj3+SL2vMXcdXR22pTGdylzU=; b=E/BHRL6Du+Fdr3+amsCWlylmKW
	+LQLxA7qkn4homkLKhl2qvDpFOgYBU1NZrVb6YWxzpe3IsRfZGMLDmLg9wRqqtOIfuN8yG0ccapFO
	Kxpvxtm6WXotTb46LS2rzAP9ya+rhkKEad1O8UWfRJ3aCmQ/0pWShBjH3VWzNmVGLPEV/7jCLLGLx
	IM6PQCtzKzhw2eErmBZwP4E3M+yhlSkZ/v6Pbnlf1mFBuxvefTl/8m1PQ31cXq2Y8hmBrOilEKwra
	9jnQ31VU+3ScBnnxNTxILEesGeROmYACWLMCIdsj87pzzZXl/sF78i6hy6X+ooibEmECOuOECERXK
	JBMtSBCw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5na-00000007Qpt-2enj;
	Wed, 28 Oct 2026 15:42:46 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] maple_tree: Update internal warning and bug_on code
Date: Wed, 28 Oct 2026 11:42:17 -0400
Message-ID: <20261028154218.1668182-4-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028154218.1668182-1-liam@infradead.org>
References: <20261028154218.1668182-1-liam@infradead.org>
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

When CONFIG_DEBUG_MAPLE_TREE is set, call the WARN_ON_ONCE() after the
custom information is dumped about the tree.  Without using the kernel's
WARN_ON calls, syzbot will not catch issues detected by this code.

Update the non-debug code to call WARN_ON_ONCE() as well.

Cc: <stable@vger.kernel.org>
Reported-by: Lorenzo Stoakes <ljs@kernel.org>
Fixes: bf857ddd21d0b ("maple_tree: move debug check to __mas_set_range()")
Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
---
 include/linux/maple_tree.h | 54 +++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e30e57f5f3df9..0f96f1f19eb95 100644
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
@@ -713,62 +713,68 @@ void mt_cache_shrink(void);
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
-		dump_stack();						\
+		BUG_ON(1);						\
 	} else {							\
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
 } while (0)
 
 #define MT_WARN_ON(__tree, __x)  ({					\
+	static bool __warned;						\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (!__warned) {						\
+		__warned = true;					\
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
 
 #define MAS_WARN_ON(__mas, __x) ({					\
+	static bool __warned;						\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (!__warned) {						\
+		__warned = true;					\
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
 
 #define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	static bool __warned;						\
 	int ret = !!(__x);						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (ret) {							\
-		pr_info("WARN at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
+	if (!ret) {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	} else if (!__warned) {						\
+		__warned = true;					\
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
@@ -776,9 +782,9 @@ void mt_cache_shrink(void);
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
-- 
2.47.3

