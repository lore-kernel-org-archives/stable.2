Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123B3AF668
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879332; cv=none; b=IB3PCDM/9q7vQyyGqmg5sznJY3g6MSTqCa0jvHbCouGkwupychmx00SXsyGybg5onKSi6jiOccyNi3WYgLaV1rQ7CgYnJPYBT/p+lZiVWib/juXNr5vv++x3RCk8KFsdPh+thHqDPWX/7PY1W08QGROPiLHaC58C/Z6rUpn3JrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879332; c=relaxed/simple;
	bh=fFk1U+4j9KhN+dnO3/fwlmEsn30+4NJ1B4HjaXJTksk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHHQdZD9paEINZM8IADDJeQ4hZ7VG27wlS9AacH+mCXuEihb33K9rVp94Mm94gZmYcLDSgyIQcUAUaOM0GJaxEEmohxlv4SRkzAERyGejmrQwv13S1sOms7DrkW2WxL5Zo6AhauFomB9AwdOfoo6j9JijMAgX1Og9v8CfO4Ebn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RyDUOn19; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RyDUOn19"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c159467cca6so7326466b.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784879326; x=1785484126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YCGrgBq88X6Ao02KH7mHgHqmuufOTy26hoLBxdlAOc=;
        b=RyDUOn19O5awY7a8ogBt/iOeIhQgtfXplm6UXtGl3/ZCgING/2WDtyb4/A2db9EST9
         cWDgSXDrMhqvZZDnhV+OCVY192n+6PQdsoGqa3YwJiy82Xum9fD3B4n6EiswFaDe88Qp
         s9hY+NlpgYdbThp9VFYbUkZ0hugAfh3coIjOZmNi3tDeOgLyjFhNkOoLA6E+7k/Gx8AC
         r221f6DgXunlsm6mpU5jwZrZCJQoY9FYRBeKDrnLhSRhZFh9AAAj3+nTvvu/OPvhrGJw
         fYnix1qDlV99rWC80pTNo1wIQHyZSYPUZiq8gM7pKF/mgWaAjT1EgtliuGV2lT16oVCC
         dI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879326; x=1785484126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YCGrgBq88X6Ao02KH7mHgHqmuufOTy26hoLBxdlAOc=;
        b=gSdVVzfR2Qrpz1JUsd9rNDt3MWejQl15Fn8om4l1EkGemmwbH2ijiZr4Esftwnm8/f
         Xw67/PPVaKaTwou7vCq7pn4xQRb3wWrMovW4VUVdM0Dx0BYSUj+I4RAdCyEZaftgXYRb
         PdEPrqpCC6Ea7NX6XmSX5tcO70Dz9/x7B6KwzMqVyMDe5Xjpgv2AXqA/SKvrb+yP1Cbx
         DCz1TRAlj2IrJ5RTumsmUd0ek7Hn/P+WjnzMTaubNz6Eka3Ov3yVyUQfxUDqyju9x9x4
         2WDgfNJAuOGVTOZGd9htIPtutminZBMZ1Mm6fp5lZguFTkLZMVj1gXZLSaoWI3yrY9Df
         F9Ng==
X-Gm-Message-State: AOJu0YwHOf4k4dFEgJRYdSLLJ748opVjApv2NoekVYskxpjbeJ92Fl/t
	NdOcMkvSwLbYYeA7VwB8KOIZ4/9fxFSjSC46+K8Op70MHpf+iidtLxe5XpDV8gBAewC7UcWcw0V
	INXWO81ll8SxRTSc=
X-Gm-Gg: AR+sD124FleVpzbVdWrWhpLAcCnRkIZLKzI41rirfZPzLKZWrkZY1MEWNfO7PA30gzL
	30gvmovb/hYqNMH2gdilrnlCGPFv2dEzrdYB1mT2w4EoS7RK8gEZeXHQ7qg2trf1RnqRknTc8+P
	65RP7DDVnBewGQzPA3isIU+QMSDWqsN5j562IgIY81pobYVXczWnCMR5wJJYOlcQV10RQ0eJHs2
	pw2TkvQFwPZ0/DH/+YEVZdPMM1c2TtXEvl9JMGLPkQChbDRVtLsn7bnXvB8PiQpGig+3OHNtZpn
	qW2OvSijnsHXWpV4Zg3uTXesnlYukZow6NZ5VErUlYuDocTcOku7T0kC4Awxeb5mP3h+L2bpFZM
	qXlO4G81UoYJN77qWaVjM9TB4timb2hWEGMZk9yGbXr68gSzk6YdEEeV4c6p0xX3XBBEPPTL+TB
	JovgAzjtEs2ydg+FFbnArDelyHrgAvejMsG5g=
X-Received: by 2002:a05:6938:a012:10b0:c12:67d2:3d67 with SMTP id a640c23a62f3a-c1c50965422mr201892866b.45.1784879326255;
        Fri, 24 Jul 2026 00:48:46 -0700 (PDT)
Received: from localhost (61-227-70-26.dynamic-ip.hinet.net. [61.227.70.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e2c36b12dsm2524243b3a.45.2026.07.24.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:48:44 -0700 (PDT)
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
Subject: [PATCH stable 6.6 2/2] selftests/bpf: Add simple strscpy() implementation
Date: Fri, 24 Jul 2026 15:48:34 +0800
Message-ID: <20260724074835.47479-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724074835.47479-1-shung-hsi.yu@suse.com>
References: <20260724074835.47479-1-shung-hsi.yu@suse.com>
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
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
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
index 10587a29b967..1e329f29f696 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <errno.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
+#include <linux/args.h>
 
 static inline unsigned int bpf_num_possible_cpus(void)
 {
@@ -20,25 +21,43 @@ static inline unsigned int bpf_num_possible_cpus(void)
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
index f68fbc6c3f52..aaae3452f7dd 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -78,7 +78,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		bpf_strlcpy(enable, controllers, sizeof(enable));
+		strscpy(enable, controllers);
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.55.0

