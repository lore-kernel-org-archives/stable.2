Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0E238C36
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951686; cv=none; b=mQ4jFqwvlDmTiHlMIPXPpiRzaIecsJgbANyQLGOa0l0KPjEJXmQt0fgSAXZIaZ0Q9wjfQ/VTl19R6gRVIPIqR/JB6XFmzAPao/H7Tey9HXhGbVVFBi128WEqCE/6hGhlwUGDkbjBOVQW34imPdqAR2RUiJxUqm3WqohLW0Xkiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951686; c=relaxed/simple;
	bh=He2OiOE9H5/nuPE9AFmrALUhEz8HILfcCZk5gjshgS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ymrs6oke93M6hcBawxzd7rF1/FPI6MBAqikHObbhUu1mR61QOOx/cu4zG6KhBTydEVRrVHJqmSJFRPJhm78Fi7sVlzoKKHKPBBJHpobC5Y24Ry9uj9a+3FjvhJc4pQrLZxhGtGtCzUVqM86E6zGKCZA5K1H+yPAeUkqQYPerev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VKXuoLJM; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VKXuoLJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951656;
	bh=+jO9TuFcWkQaZp+oBPx6CQg8UJB0NYkxuDNULm37eok=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VKXuoLJMZMlCUnXy1GaYw4ugtc07tPYUB0BaACXwrODb8OuX88D7+jwns6kdi410J
	 Zr9VGeTEakTJtwwtBvneuDFkqV9JiFiBdDiDEokOgOdm8IYjFONqHw3H+H7bz1PtKI
	 sFhUg1VGmMK926bbxVJAamboiqy/reGG47RaB8j0=
X-QQ-mid: esmtpgz16t1785951637td74e8b6a
X-QQ-Originating-IP: Tuk/r7jISXOBq93gsgXJZ+RpM/JMJgBvhTMvfMB+QFc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:40:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14084121044963317815
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 1/8] file: add FD_{ADD,PREPARE}()
Date: Thu,  6 Aug 2026 01:39:52 +0800
Message-Id: <20260805173958.660310-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OfLzXF8J7Ricg+srmDNsIaEUR5OoTd0O7n9xegXjG+yXntg1A1GD1tUA
	JN8p8jMbpjqZK7wkoyEuZE6mQCpvTtitozFrB+sHDsdrOVbDNG5EGNS7FijPMMOahpZiTp7
	c1PLIqS0s+tbd/MzzlK/hnIn6432BdNdcWTGSaUJe2P6iGwYPJPPiqQJsIFBacWHCqrs32n
	6kHSjWgZTnRnsx6P2FrtvZYyzjMLwnxi/0Fvwv9oVx1ijQg1tb9kj7cHnSuoPbAf2IhmqOc
	OccoLpxUjoIYItEwPZ9HwWJohPkIAcPif+kzo7wN6S+fPQPW4xoaNV4YaC07IolECM51+q/
	jFUYL4MVF9BKgvVJVd0avzh65NBCkbVZ53gfd4iQZoDaM/pv44Ph896P+i9gmrqnljxqw60
	CjRd8H91eZE/6DB/vOaqsRlscT0hlzi9DU5779hgYvC7Z6OopDhtbGD2SjMPmYM7AdPomTr
	28ds73kZGhhhmPL5kx/r2Yu1mVzZ7875k37U0cVgPR2E86GjOqZurQlhuB3iq2/98GFrCHF
	kRVuAgoOhBL/ukLw0gtddjto8aHOi7oPUz13C0neIKkpHbTh/Y70/IPprGPyQUQg7p/esTz
	qJAA13Dj2BInCi0LEyoLIpMfjdnHStS/iWdgAVRII1Km/vVdgweD3ADTir5wIgQdyeco1+A
	IqQU/OnSRFpa9JK0kVuxAFPjA1F30RQqBEnqYyVjCbZV1sQItyVpHgLRCtkE2bJf+GD2FQR
	bQV8jhpiKYDPZy7lKJ6Im4TizkKaGlw2klKaS/gTF7x6Z3ba4MxwsRHerFWdLDfRckakO17
	6TmDr3vIki8hYnS0olt8t7UAb8lE0hvAGQidwwe9XyovanedaxAzd+2RDAxXmgX88Dev+FO
	cXkaGWBz4jXyZW8kkw5ylZKknl55FCO2Mw26JvGytu4g5zVOA0s6NmghxnUua6fCA/jnDuT
	zHSDsY7Z+LYAUTFidoLon/rLPdqduQu6FZ6hXgPUnLv93Eg+q0P7+3wUxgtbKwRDRPUpqI6
	PpXQnZbFk3d8JqwETlxebdzQIWMv2iRk/Hcfcfe8ZU1ddao3f+fyDt0ADFcpclTelcMC7JP
	cEcWDS/WiIf+zrzZbji0xFGHGOQDTv9FHv/Bn4xBrV48oxcwSyfHycA1C3HaWc9W2L4ZM+j
	Ea8Ekeh1RnbX1xeZI5vhn7QOC3e/z2sj3V3UfhzfE3PbGmU=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

I've been playing with this to allow for moderately flexible usage of
the get_unused_fd_flags() + create file + fd_install() pattern that's
used quite extensively.

How callers allocate files is really heterogenous so it's not really
convenient to fold them into a single class. It's possibe to split them
into subclasses like for anon inodes. I think that's not necessarily
nice as well.

My take is to add two primites:
(1) FD_ADD() the simple cases a file is installed:

    fd = FD_ADD(O_CLOEXEC, open_file(some, args)));
    if (fd >= 0)
            kvm_get_kvm(vcpu->kvm);
    return fd;

(2) FD_PREPARE() that captures all the cases where access to fd or file
    or additional work before publishing the fd is needed:

    FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag));
    if (fdf.err)
            return fdf.err;

    if (copy_to_user(/* something something */))
            return -EFAULT;

    return fd_publish(fdf);

I've converted all of the easy cases over to it and it gets rid of an
aweful lot of convoluted cleanup logic.

It's centered around struct fd_prepare. FD_PREPARE() encapsulates all of
allocation and cleanup logic and must be followed by a call to
fd_publish() which associates the fd with the file and installs it into
the callers fdtable. If fd_publish() isn't called both are deallocated.

It mandates a specific order namely that first we allocate the fd and
then instantiate the file. But that shouldn't be a problem nearly
everyone I've converted uses this exact pattern anyway.

There's a bunch of additional cases where it would be easy to convert
them to this pattern. For example, the whole sync file stuff in dma
currently retains the containing structure of the file instead of the
file itself even though it's only used to allocate files. Changing that
would make it fall into the FD_PREPARE() pattern easily. I've not done
that work yet.

There's room for extending this in a way that wed'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

Link: https://patch.msgid.link/20251123-work-fd-prepare-v4-1-b6efa1706cfd@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit 011703a9acd76edc7c85d80dbccb6e50dba53aad)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/cleanup.h |   7 +++
 include/linux/file.h    | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a1194e44b5276..bacefa0f1512f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -261,6 +261,10 @@ const volatile void * __must_check_fn(const volatile void *val)
  * CLASS(name, var)(args...):
  *	declare the variable @var as an instance of the named class
  *
+ * CLASS_INIT(name, var, init_expr):
+ *	declare the variable @var as an instance of the named class with
+ *	custom initialization expression.
+ *
  * Ex.
  *
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
@@ -290,6 +294,9 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
+#define CLASS_INIT(_name, _var, _init_expr)                             \
+        class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
+
 #define __scoped_class(_name, var, _label, args...)        \
 	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
 		if (0) {                                   \
diff --git a/include/linux/file.h b/include/linux/file.h
index af1768d934a01..cf389fde9bc28 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -127,4 +127,130 @@ extern void __fput_sync(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
+/*
+ * fd_prepare: Combined fd + file allocation cleanup class.
+ * @err: Error code to indicate if allocation succeeded.
+ * @__fd: Allocated fd (may not be accessed directly)
+ * @__file: Allocated struct file pointer (may not be accessed directly)
+ *
+ * Allocates an fd and a file together. On error paths, automatically cleans
+ * up whichever resource was successfully allocated. Allows flexible file
+ * allocation with different functions per usage.
+ *
+ * Do not use directly.
+ */
+struct fd_prepare {
+	s32 err;
+	s32 __fd; /* do not access directly */
+	struct file *__file; /* do not access directly */
+};
+
+/* Typedef for fd_prepare cleanup guards. */
+typedef struct fd_prepare class_fd_prepare_t;
+
+/*
+ * Accessors for fd_prepare class members.
+ * _Generic() is used for zero-cost type safety.
+ */
+#define fd_prepare_fd(_fdf) \
+	(_Generic((_fdf), struct fd_prepare: (_fdf).__fd))
+
+#define fd_prepare_file(_fdf) \
+	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
+
+/* Do not use directly. */
+static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
+{
+	if (unlikely(fdf->err)) {
+		if (likely(fdf->__fd >= 0))
+			put_unused_fd(fdf->__fd);
+		if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
+			fput(fdf->__file);
+	}
+}
+
+/* Do not use directly. */
+static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
+{
+	if (unlikely(fdf->err))
+		return fdf->err;
+	if (unlikely(fdf->__fd < 0))
+		return fdf->__fd;
+	if (unlikely(IS_ERR(fdf->__file)))
+		return PTR_ERR(fdf->__file);
+	if (unlikely(!fdf->__file))
+		return -ENOMEM;
+	return 0;
+}
+
+/*
+ * __FD_PREPARE_INIT - Helper to initialize fd_prepare class.
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_owned: expression that returns struct file *
+ *
+ * Returns a struct fd_prepare with fd, file, and err set.
+ * If fd allocation fails, fd will be negative and err will be set. If
+ * fd succeeds but file_init_expr fails, file will be ERR_PTR and err
+ * will be set. The err field is the single source of truth for error
+ * checking.
+ */
+#define __FD_PREPARE_INIT(_fd_flags, _file_owned)                 \
+	({                                                        \
+		struct fd_prepare fdf = {                         \
+			.__fd = get_unused_fd_flags((_fd_flags)), \
+		};                                                \
+		if (likely(fdf.__fd >= 0))                        \
+			fdf.__file = (_file_owned);               \
+		fdf.err = ACQUIRE_ERR(fd_prepare, &fdf);          \
+		fdf;                                              \
+	})
+
+/*
+ * FD_PREPARE - Macro to declare and initialize an fd_prepare variable.
+ *
+ * Declares and initializes an fd_prepare variable with automatic
+ * cleanup. No separate scope required - cleanup happens when variable
+ * goes out of scope.
+ *
+ * @_fdf: name of struct fd_prepare variable to define
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_owned: struct file to take ownership of (can be expression)
+ */
+#define FD_PREPARE(_fdf, _fd_flags, _file_owned) \
+	CLASS_INIT(fd_prepare, _fdf, __FD_PREPARE_INIT(_fd_flags, _file_owned))
+
+/*
+ * fd_publish - Publish prepared fd and file to the fd table.
+ * @_fdf: struct fd_prepare variable
+ */
+#define fd_publish(_fdf)                                       \
+	({                                                     \
+		struct fd_prepare *fdp = &(_fdf);              \
+		VFS_WARN_ON_ONCE(fdp->err);                    \
+		VFS_WARN_ON_ONCE(fdp->__fd < 0);               \
+		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(fdp->__file)); \
+		fd_install(fdp->__fd, fdp->__file);            \
+		fdp->__fd;                                     \
+	})
+
+/* Do not use directly. */
+#define __FD_ADD(_fdf, _fd_flags, _file_owned)            \
+	({                                                \
+		FD_PREPARE(_fdf, _fd_flags, _file_owned); \
+		s32 ret = _fdf.err;                       \
+		if (likely(!ret))                         \
+			ret = fd_publish(_fdf);           \
+		ret;                                      \
+	})
+
+/*
+ * FD_ADD - Allocate and install an fd and file in one step.
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_owned: struct file to take ownership of
+ *
+ * Returns the allocated fd number, or negative error code on failure.
+ */
+#define FD_ADD(_fd_flags, _file_owned) \
+	__FD_ADD(__UNIQUE_ID(fd_prepare), _fd_flags, _file_owned)
+
 #endif /* __LINUX_FILE_H */
-- 
2.30.2

