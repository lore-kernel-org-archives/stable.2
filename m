Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF93E3158
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790836; cv=none; b=qB5iIYMAW+qNuR0Eo/+vV/xCsUWEGx+aqLGGJMSAut/aev0BUB9tZY7QcNuPdt9DCAqSl4Hkh/FR0gSW7ki6WIAyqeGZNvYYqjVtJlrMuB6m7klP2DpfSXCvXGRInZTiIe/4frNZApSHHRGezIma672P2JVqw5/cyL/Xz1qc2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790836; c=relaxed/simple;
	bh=aNpBgz6kAi+YKWmm38MlKbSF8AJ8++pYJHbe79zTnos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHmtFoNbRLGx83CXjpfgTAbALa5C63a3aGEyo+KDeqtF9rE1jhOT4W12bsofbGwGKQqxXQZ37AMmztTpTvgjZFtCAyHhnVmOO1+jRk9itYG09YTnCfTJ3GvkAt35e8TOUf1se0CBoLEQCactzyt9R5W5KAM/O+5bR7IKBAOvM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E+/HmTa3; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E+/HmTa3"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15ef474e72so20468666b.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784790827; x=1785395627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ThLWtG1nh3kD8QEoASf5pfPr+wAR3/+04tRicQCGRsg=;
        b=E+/HmTa3GBN3gYACLbrJkHDi39oL54Hsf0EbHsiWwZk8zyPsIrM24ayz1wFajNFu9m
         ObyCBiXDZSCrcoJJcD6hp5DRQefhD7Nd9ndw2s7c6YRdjKswrNXq5304QZDZ9QNHQ7T7
         C+kBFygRNV7xgn0ldPNy9djnJzW5zBXGq3XC1GRUp3JUUP3K9fH//9wnu8zr3VMCgN8a
         yuHjNHcImPCJkWfzwJYua1vBiFtHYfiTQ9AHpZODRhS4jPrzEpT1Tf841kEUDZ3KMd6t
         +QnV6euqaLMZKTDq/Gim0mUj5DbwuIuMahSw4p2waeXOWRz/Vu0Hgbs3oMRwq39DS784
         UMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790827; x=1785395627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ThLWtG1nh3kD8QEoASf5pfPr+wAR3/+04tRicQCGRsg=;
        b=pZCYCoSFPzH5TS8Ay399kZyiM5lj5JFCsGpP3l2uTUAu7tXPUZGX9WOsw+BV0vSG46
         sezSep8Tvusyg90obQSEy7fWHNCWImHwmoOsL3/O9Q+Yp9wcgUEUls8uKCyDZQ8VBFhw
         w/si0Tlj9fZAeQjfBQYKM8LBspHP3l5R7kYzp2DGGpoIpNEfDWyVvPk4E2xrLzB3ZpRM
         URRl+nbkrFa3oOWsW80rWAEMZfMGPQ6Fq+YEd1D1GoFjSlcAr6P3AnWj//Os+FPwfSL9
         C55Srac/MO4jBfcEYijoG+03OXewYSiFb49U8WMLNhrXC3jwpQxzRO7AMTbDNJh0T6V1
         rTMQ==
X-Gm-Message-State: AOJu0Yx5kbIeTRg/kKPk4uZOF7irGzlamf/xGPnqnSdWbnZl/AjEOtGH
	O7LSfCsmM4JVlhf55GvDQahZBrVKKjK1T4SamPu/ARegkTvO8Ilccv9oR9CH0TEBCAe6hmsaUrf
	PWu+EKxt8oBVXbjw=
X-Gm-Gg: AR+sD10dhptGua+oQ+FAsN5VRaXVh/MRXNKKHlPVezbc6VHImdi+izTYRdV96SpsPR0
	7a9ddB91WBrnBgFubF4nv8DWyhrvsD8JJRRxIVcifJyXiPq32Ul5+qTdnJotztBG53KQe+5w0Xy
	HZy2IQtjRNu3Pu8Gp1w0lhtLx6F+bxq2cZ0aw/xnJfYDWtDO1OwrwrgZPgAtSnnHX8tz/jR94W6
	GU7h0G8VNOVBFV+u5IYPZDnj40IDI4vW2kQ/d0synSGMkpf2tZHVtp3NgnstVuFKyGnx8UzLOn6
	luYvus6MoqZictrWGxAu7er2soRNoYlnnAqQ9vDEBG+j+n5hWe3uHDrJRV0Xww1C1OByc8ccSOr
	TI21rjkBncSVjUMMBJ7WPzzHukpBrouPYyur7aw/wy/PfsA9cgp2jRUSHkYxCcpSGPJg1NGCeFI
	Im72p3VjhSkkELE/mLpvYe01PuXKva13qRKjoc
X-Received: by 2002:a17:907:704:b0:c15:fd85:c5f7 with SMTP id a640c23a62f3a-c1c50b41152mr91893766b.4.1784790827057;
        Thu, 23 Jul 2026 00:13:47 -0700 (PDT)
Received: from localhost (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175ce455sm2537071b3a.48.2026.07.23.00.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:13:45 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 6.6 2/2] selftests/bpf: Add simple strscpy() implementation
Date: Thu, 23 Jul 2026 15:13:32 +0800
Message-ID: <20260723071334.39630-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723071334.39630-1-shung-hsi.yu@suse.com>
References: <20260723071334.39630-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@linux.dev>

commit 63c49efc987afefc6b9bb7de083eb8748e0b1789 upstream.

Replace bpf_strlcpy() in bpf_util.h with a sized_strscpy(), which is a
simplified sized_strscpy() from the kernel (lib/string.c [1]). It:
  * takes a count (destination size) parameter
  * guarantees NULL-termination
  * returns the number of characters copied or -E2BIG

Re-define strscpy macro similar to in-kernel implementation [2]: allow
the count parameter to be optional.

Add #ifdef-s to tools/include/linux/args.h, as they may be defined in
other system headers (for example, __CONCAT in sys/cdefs.h).

Fixup the single existing bpf_strlcpy() call in cgroup_helpers.c

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/string.c?h=v6.19#n113
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/string.h?h=v6.19#n91

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Link: https://lore.kernel.org/r/20260223190736.649171-2-ihor.solodrai@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 55ffbe8a15b1 ("selftests/bpf: Initialize operation name before use")
Closes: https://lore.kernel.org/stable/al8dSv_OvhwxFCar@u94a
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Confirmed that BPF selftests successfully builds on 6.12[1] and 6.6[2]
after this patchset is applied.

1: https://github.com/kernel-patches/linux-stable/actions/runs/29986297264
2: https://github.com/kernel-patches/linux-stable/actions/runs/29987147891/
---
 tools/include/linux/args.h                   |  4 ++
 tools/testing/selftests/bpf/bpf_util.h       | 45 ++++++++++++++------
 tools/testing/selftests/bpf/cgroup_helpers.c |  2 +-
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/tools/include/linux/args.h b/tools/include/linux/args.h
index 2e8e65d975c7..14b268f2389a 100644
--- a/tools/include/linux/args.h
+++ b/tools/include/linux/args.h
@@ -22,7 +22,11 @@
 #define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
 
 /* Concatenate two parameters, but allow them to be expanded beforehand. */
+#ifndef __CONCAT
 #define __CONCAT(a, b) a ## b
+#endif
+#ifndef CONCATENATE
 #define CONCATENATE(a, b) __CONCAT(a, b)
+#endif
 
 #endif	/* _LINUX_ARGS_H */
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index feff92219e21..33486c460913 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <syscall.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
+#include <linux/args.h>
 
 static inline unsigned int bpf_num_possible_cpus(void)
 {
@@ -21,25 +22,43 @@ static inline unsigned int bpf_num_possible_cpus(void)
 	return possible_cpus;
 }
 
-/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
- * is zero-terminated string no matter what (unless sz == 0, in which case
- * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
- * in what is returned. Given this is internal helper, it's trivial to extend
- * this, when necessary. Use this instead of strncpy inside libbpf source code.
+/*
+ * Simplified strscpy() implementation. The kernel one is in lib/string.c
  */
-static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
+static inline ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 {
-	size_t i;
+	long res = 0;
 
-	if (sz == 0)
-		return;
+	if (count == 0)
+		return -E2BIG;
 
-	sz--;
-	for (i = 0; i < sz && src[i]; i++)
-		dst[i] = src[i];
-	dst[i] = '\0';
+	while (count > 1) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Force NUL-termination. */
+	dest[res] = '\0';
+
+	/* Return E2BIG if the source didn't stop */
+	return src[res] ? -E2BIG : res;
 }
 
+#define __strscpy0(dst, src, ...)	\
+	sized_strscpy(dst, src, sizeof(dst))
+#define __strscpy1(dst, src, size)	\
+	sized_strscpy(dst, src, size)
+
+#undef strscpy /* Redefine the placeholder from tools/include/linux/string.h */
+#define strscpy(dst, src, ...)	\
+	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+
 #define __bpf_percpu_val_align	__attribute__((__aligned__(8)))
 
 #define BPF_DECLARE_PERCPU(type, name)				\
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e4535451322e..23bcf1aca76f 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -85,7 +85,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		bpf_strlcpy(enable, controllers, sizeof(enable));
+		strscpy(enable, controllers);
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.55.0

