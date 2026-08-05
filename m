Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0C3DFC6D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921320; cv=none; b=EN4GC8cH/XOfpT6L9ycMJpsJYWlVd+JU3Ep7EdUfFA3Ynl9qKgxM94Q1ohKVadU+WL46dUjfb9EkR/kAWjSSNatXxgMhYpQZgYjbRQz4Cwj+0Jzs4kdwEDdRh0WNWpJNYFpyIftU/WJS3J5FjXD2O3HHy/6lbMAs9HxbSmeMNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921320; c=relaxed/simple;
	bh=He2OiOE9H5/nuPE9AFmrALUhEz8HILfcCZk5gjshgS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ+e6xWvanE59lKeIQFMx8+9wUMbTnOSlm4K0XDWS8AKQcjEMArnniiaSxDkJh10OLQflCtAjCrwKBv3ErB7tZqnYo51tf4Wiv3ocR5xTtffinmjfuip0If0O55O2NsLYgDiifpzcCSv/eVYFd2wFn68zuxc97fRTEQO9QnS/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jvQLjETR; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jvQLjETR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921292;
	bh=+jO9TuFcWkQaZp+oBPx6CQg8UJB0NYkxuDNULm37eok=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jvQLjETRpFuUU1p+QVBgChfWC3SD1mQOmz8mTblm4NMgiUfGKvmfZN31vYBuQjNja
	 vhcpJDVTO6jey77Ho2fnjprTRf+irZr7qE1XdGaPWEzRQ5d8PKILqNqn+I5VHnsCDo
	 JHfJfCEJI6MoZvrq6rEzmhWaIiyAjLKEPW/Kb/78=
X-QQ-mid: esmtpsz21t1785921270t650658b2
X-QQ-Originating-IP: YF/2yp+YTCfU+wkQri5eHQooXygyGETHquiz/gTXePM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:14:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7302259380473738030
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 1/5] file: add FD_{ADD,PREPARE}()
Date: Wed,  5 Aug 2026 17:13:46 +0800
Message-Id: <20260805091348.609325-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805091348.609325-1-guanwentao@uniontech.com>
References: <20260805091348.609325-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MpJmQ90V4eWU9xveY056whHfSYdHyEbMA4kWvVHNk5xdDDjP3scdXSzo
	0vOQeKdbXG2DYgSiQFaSLSryphrEOYB7oYxKO9wdCZL+Yihy8ID/1mkmc0trlbetX7GuDGS
	8g5IWHuUUZKZy0oKqH71JNu8lgL/BzueBqrl5s4g4Hg62uHSaxlfhVT/9bwf65B66UcS3I4
	DFcOKnI0F6ZC9kdZwD5c+VIz4E02N1lc+Gl7mIOodtPA93lAHZFZJIDG/f69VrjBzt2DaS8
	8VllA5QBNJFKMAzO3FcUwzGR3zITGyuxOLVmHmAQ83uG33OLOPESYY/A3cxh74h6PwaWdNy
	dEWXf9bWvGoTz6oK3X30SuGApoNRtZnJ7/a1K9xtgfGRsAJs3QnmpgIN6RzbnzSKO1gX+Fk
	XqlTzd8/+5yyXf4V8WZ/yaVQrykzNl2BSltF4Uzu+SaeAf8NITKDebuZfKVTK0R/7GMruJw
	xz6blErllyyjUoxYNmTzJBCNO1Dv1r6QYiKJOtqr3PQkDV7rIqwh0ZaBVUhY/0KXfo/tb0O
	NRh4IEAT3zMpivlFLNkSGFLHtYtoCa8/5jmlDqjHN59nPbQicMvcBQlUoXb9ACgKL3/naW8
	q9lhkmRR+BR/ElfEtuS+yubVwIxdInMNfurBK1eVOqUkIGlOLhFoWAJmthvCFfuc0kksCO2
	eGIAsHyd9JSgfJtgetTfEOSeVLzlKWAwyqyLsjfVO6L1vI0Re8UCfH8TBhRdzziuwVsu/DO
	9FaGSs3alflTBQjJx/XseoXB+G0Q2/PafXEogEOYdP4wqf0DjqX+UuCXwYvif1Jo5RgFjfe
	GcEZUfVXTs9395hwsy0qJtWqkomDpXgW5F5VCJ8HjjTd7oDQ6JzBnzR7zonhDpkAcBBZBMJ
	hEZrq6VDjldJNxTLTqWHhpVl4Aj0+SKMGipJTHKYndRJG0nbHtHmdITfQE3OWdeXLGb55uM
	TwEh/Zva2LYWrZ8zzZBue1g6D+CjKIZwGluCicgrZD0RzQRZwj5KdUbYhM9wp2gkfn85qN3
	s43xfyfzUhTa5npRWQOg2h0MfTXiLTHR1pbeqFDyx1/YWw86Fd2qpCM3W+INeHO7K7SRpXr
	I5LhGIo483y37zyjGb2LPU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

