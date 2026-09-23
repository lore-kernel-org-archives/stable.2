Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A903400DE2
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175392; cv=none; b=I76phTa17WI04qiS1EFPdbGFpWKXUs0i9e2KuTnB28c2zEXXTqFpn58EA1fPcZbPryG1C3Q27Et35vFGmm0tU5iauhAaNFs9Zxf6jXDj12lPaLFciX3zxIZZBlItR9F/tIxBiiikwYhDGtuKaNQa7TX724JzbUu4qW81cPyc+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175392; c=relaxed/simple;
	bh=KLL1CoeBe+d6zkr4xAjE59UTUGfIF4KDbTLJ/l6GE10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAH96d+i5iiw6B7X9VZa9tUfMOFEim+tuMDgEndYoptg96fLBPCm/E0iWTg1unEUqvCx9J5G1SFgpgE6kAfkjLhU9ymb60HxQcJbFu/eHuwPvDF5JrIJxtJ1spUjPlqmQAWi2bwn76zxBOIqOjC5m0MHEjrae9F25LE1ozKRZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddnGgU1Q; arc=none smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddnGgU1Q"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a3552563d7so6219191fa.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175388; x=1790780188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQsvAgfzLtsJnXkdBUm8r2goP4FuulbfN7zU4oyNzHQ=;
        b=ddnGgU1QF9WjftCwQ9P/AsIJhSTebWI3RHjDGdLb5r6c7ugad/G6fyCJDNrTB6AGxd
         mTftwM5gCvW9hgVEkJ81jzh2P5apTevcSh7kh9nLbjY8Yxmy8T1wwQnRKdQ1yztB/Zsv
         ff8fQnHCmMgg4ragjTuV2+rdcC6X4WVpejXKsGVYmJx7yEGyrAjYV02s9/70k0/QNNNp
         ksOfqnu3YsOHOXvjHTlI+jMI7ILkJv1uRyipPFzGwroRXrzdFXEq1/x7U9hbHLAEJ57S
         A1RuYNgFOyke4f6Zy7lqypU/kAvna2B4LmWA538S1fGvqhl4sUb9GuvC0zRM3+hnThcf
         62HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175388; x=1790780188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQsvAgfzLtsJnXkdBUm8r2goP4FuulbfN7zU4oyNzHQ=;
        b=BkVkXRN9A7PS/kKi2Y2HUIufPNu7CFO2uYmBPoR6HrAu8sdM8WpW/+E1s9X2H5q/EG
         hCuQlaRjS8Q/mZkq2VwUIOn1AtJGcldKS4WcbH5HSfluwkJsCKjbxeHecU7w+F40Ze8/
         8IpkdcyqZrw9eA9TroPu9criXH5nvkkUaO3Ybh/I3hg7RxWzuuW9zP7xqaf2Oku1tAmD
         22WuWQrAc/n1Gcoa0y07SA+ifWVk88OSfJwvjLkWI70/95M0PvseFK1sS/4+m5p4CvHN
         M91tmZ7wrA3ETDIutm3GV+tPXxxz1aECViVW/eu1CveXbPTFpVCXADMRUrRSmNWBEoXO
         0/Tw==
X-Gm-Message-State: AFuF++ntB930hK/MoXKv4i6LKTQnO6XnPRdzc20Yc3zCXdDGsv+plc22
	o04ciFjF0YL2rZW7pqMfpdSxE97SJCzXPDNfdtRavOu0oJ1uYJGHE9P3zWUYrTDPzRQ=
X-Gm-Gg: AYBFou0rrHXJVT/JedLwO+AEvBnroNmQVdaFKeupNvx6xhTf5xhdjXiGmqig+prZgE3
	s6bYUvO/m2uPjRqO/qmFK9aM9s+vo6D1GVf5sXmOBv3zn+5Mp6WQXGLhj0FlxP1gUxxp6bGr6Sk
	L8lOPYHWmLt1qCNYmgP8Nkr9TOvxKIfehqZ0nP3ME9ozmq+Q+4g1aFGEyKLnINpZ5Ju4uFST8mn
	nLdWzGl/r6PD1YPsmUF6ElL9P0Zsho8Wj3IvDRiZOyhCJsRjf//oCgOOWGM+52GCirprC8mexBN
	DnTK0/66RZWPpwnbxVPBVsw2JjPkyJ8QIVu9GVrZF7PjBZdh0fV8mYrDfLzP80Blbwe+607lqa0
	06lOdkJnHHFr/13kM92uh1Ism/nV9iBOCozI4bz0dtR/0VlrrtqaGwsiDMHnjweW4GZymv5r2Qt
	OsN7ux4u23ZJ1Gr9e4dq/tmYviHUXQ7bhe2SRo/u2LKjOQq6QtfylKIfRhsGXV3mKcPIx6q7tfe
	XZ30JwoiuczdhkR
X-Received: by 2002:a05:651c:a205:20b0:3a2:72c:cde9 with SMTP id 38308e7fff4ca-3a6305ca196mr5197841fa.4.1790175387706;
        Wed, 23 Sep 2026 07:56:27 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:56:27 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	David Airlie <airlied@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>
Subject: [PATCH 5.10 1/3] string.h: add array-wrappers for (v)memdup_user()
Date: Wed, 23 Sep 2026 17:56:18 +0300
Message-ID: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

commit 313ebe47d75558511aa1237b6e35c663b5c0ec6f upstream.

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-3-pstanner@redhat.com
Stable-dep-of: c833d6c7199c ("drm/amdgpu: Limit BO list entry count to prevent resource exhaustion")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 98b053d9c700..85efd2b738ea 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,6 +5,8 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -13,6 +15,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.53.0

