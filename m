Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664545;
	b=EHzoYSGr6oI+jbMTkNocPwKYpEzSm2IweZLIJgvX7SXhvSwc6QL5h1khBtzXASUBBGgd
	 yMRKK1tCKuW82Dju9q1ZagWt5enPNBX6jPnI9Z5m5UkPeACRZu321piKVb0r0GfNF4gUG
	 2V6bJZLocH3Ormlc17ff70p4yQGHzAbz4RwyimZhUJl+asaz1qclPeCPchQm29SZXC1/H
	 SZNOuwg7cblHSaAbDmjVXzMyUfHJYmDh52vhPyic8NRlcs+fWTH6MWY2zdzH0APqGMit4
	 wjoWOWaxQRxOq1RrEjxY0M53MhkB+xbILHu98upOYbyBN1RrGVJ3ZxqQG082cyldddg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664545;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ASc53FTdCDNtqSiOj4VcLem5LqRvCYBOPA4aTaaWJow=;
	b=DGbk5CsFVsttz7c/Xq3Jxbmyu1uEE4qYoTtLd8gJAyT8Zhd0F15HzQGxAdGwBvk8Ndvg
	 mVveozH4SWYZ4vqBLnSMvK8ENLPYt/m+jrhCAARvN3iwmZn5kRH4CSpIxTG7c4zWB87zT
	 o7k8MdSVixHpYTp3XfjCT2MssaJ/5Ld9WjifJWoa+fmbvSgwTa8vd0hPHmnPC6tb+PDgU
	 nNwX98jgAnMPm57Yen3zBTszDUCuexm72PdBMgVVlfzhOTXG8KsZMkDGL52oO7j6ijuny
	 OVK4nrFBkVhO+Fj5Wo9F2fP0mD1SZ0jMpCODGfo4q07I1L0PKt/IVbsuIJdGeB2wqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nL5Fj962;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13D606A31E;
	Thu, 26 Nov 2026 03:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D13D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nL5Fj962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID; bh=ASc53FTdCDNtqSi
	Oj4VcLem5LqRvCYBOPA4aTaaWJow=; b=nL5Fj9622Rj8dx31cLHsrXtaxPFt87Y
	AiOhUNgrFK9w2+Yx7YiFSL3d+wKw4EJD56wHi62QNegRtu7xjFn6zhKtFGUggtAx
	y8LRMNsTB5x9kMtndf7YK6MDKJ6kCox3vTsnZq3UyfaTYr+8Fn0bsxlhYLC6lqMR
	Z+z3I97cDRYE=
From: shaos <shawnq1@163.com>
To: Mickaël Salaün <mic@digikod.net>
Cc: Günther Noack <gnoack@google.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Randy Dunlap <rdunlap@infradead.org>,
    Steven Rostedt <rostedt@goodmis.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Paul Moore <paul@paul-moore.com>,
    James Morris <jmorris@namei.org>,
    Serge E. Hallyn <serge@hallyn.com>,
    linux-security-module@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] landlock: restrict opening namespace file descriptors
Date: Thu, 26 Nov 2026 03:40:27 GMT
Message-ID: <179566442733.1993761.8053687674090289362@163.com>
X-CM-TRANSID:PygvCgCH74QrqgdrvLbtIA--.60447S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3KF47tFW7try8uw13XF4UXFb_yoW8GrykJo
	WI93WIqa18Aw43ZFyDtFZFyFy5Aan5ua18Ar1IqrZ8A3WIqa4SkF18Cw40yF47JFyrtF13
	Zr1xJrWFv3yDJa47n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxwvtDUUUU
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8g1SYGsHqi22iAAA3Y
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hello,

Landlock checks NAMESPACE_USE when a task creates a namespace or
installs one with setns(), but does not check acquisition of a file
descriptor for an existing namespace. A sandboxed task can use
SIOCGSKNS on a retained socket to obtain a descriptor for a network
namespace denied by its Landlock rules, then pass that descriptor to
RTM_SETLINK to move an interface into that namespace.

The reproducer uses a task with CAP_NET_ADMIN in its own user namespace
and a retained socket reference to the target namespace. It demonstrates
a Landlock namespace-use policy bypass; it does not demonstrate
privilege escalation beyond that capability.

This change checks nsfs file opens from Landlock's file_open hook. It
covers proc namespace links and namespace ioctls that create an nsfs
file. It keeps the current namespace implicitly accessible, consistent
with the documented behavior, and records fd acquisition distinctly in
audit and trace events.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
Git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
Source version: Linux 7.4.0-rc4
Compiler:       gcc 11.4.0, GNU ld 2.38
Test runtime:   QEMU 6.2.0, x86-64 TCG

The PoC, complete configuration, console logs, and initramfs helpers
are in this unlisted Gist:

https://gist.github.com/shaos26/b2c0b1e1951692b79d2bc2f9421abfbc

Console output:
https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abfbc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abfbc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abfbc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/poc.c

The reproduction script builds the specified kernel, builds the PoC and
initramfs, and runs the baseline, deny, allow, and invalid-fd cases:

    git clone https://gist.github.com/b2c0b1e1951692b79d2bc2f9421abfbc.git repro
    git -C repro checkout d2278bbd001f2c62b611fc0a5325cc4c8f7451b0
    chmod +x repro/*.sh
    ./repro/reproduce.sh

Two vulnerable boots allowed SIOCGSKNS and RTM_SETLINK despite the deny
rule: the move request was acknowledged and the interface appeared in
the denied namespace. With this patch, opening the current namespace
still succeeds, setns() and unshare() remain denied, SIOCGSKNS returns
EPERM, and the interface remains in its original namespace. Baseline,
explicit allow-rule, and invalid-fd controls pass.

Fixes: 15dd86021b57 ("landlock: Enforce namespace use restrictions")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

---
 Documentation/userspace-api/landlock.rst |  3 +++
 include/trace/events/landlock.h          | 12 ++++++----
 security/landlock/audit.c                |  4 ++++
 security/landlock/fs.c                   | 11 +++++++++
 security/landlock/log.c                  |  2 ++
 security/landlock/log.h                  |  1 +
 security/landlock/ns.c                   | 30 ++++++++++++++++--------
 security/landlock/ns.h                   |  4 ++++
 security/landlock/trace.c                |  1 +
 9 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 7cc5fde482623..b1e78eef17bac 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -598,6 +598,9 @@ that references it.  The covered syscall paths are:
   descriptor referring to a newly-created mount namespace.
 * :manpage:`fsmount(2)` (default): the caller obtains a file descriptor
   referring to a newly-created anonymous mount namespace.
+* Opening an nsfs file descriptor, including through :manpage:`open(2)` on
+  ``/proc/<pid>/ns/`` or :manpage:`ioctl(2)` operations such as ``SIOCGSKNS``
+  and ``NS_GET_USERNS``.
 
 Anonymous mount namespaces (created by ``open_tree(OPEN_TREE_CLONE)`` and the
 default :manpage:`fsmount(2)`) are intentionally covered by the bit even though
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 09e90e4a9cd7b..ae385ffb3a360 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -40,6 +40,7 @@ TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_CREATE);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_ENTER);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_ACQUIRE);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_CAPABILITY);
 
 #ifdef CREATE_TRACE_POINTS
@@ -993,8 +994,8 @@ TRACE_EVENT(landlock_deny_access_net,
  * @namespace_id: Namespace ID, not directly visible from user space when
  *                creation was denied.
  *
- * Emitted when a Landlock domain denies namespace creation or entry.  The
- * namespace_op field distinguishes these operations.
+ * Emitted when a Landlock domain denies namespace creation, entry, or fd
+ * acquisition. The namespace_op field distinguishes these operations.
  */
 TRACE_EVENT(landlock_deny_permission_namespace,
 
@@ -1028,14 +1029,17 @@ TRACE_EVENT(landlock_deny_permission_namespace,
 	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s namespace_op=%s namespace_type=0x%x namespace_id=%llu",
 		  __entry->domain_id, __entry->same_exec, __entry->logged,
 		  (__entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_CREATE ||
-		   __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ENTER) ?
+		   __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ENTER ||
+		   __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ACQUIRE) ?
 			  __print_flags(__entry->blockers_access, "|",
 					_LANDLOCK_PERMISSION_BLOCKER_NAMES) :
 			  "unknown",
 		  __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_CREATE ?
 			  "create" :
 		  __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ENTER ?
-			  "enter" : "unknown",
+			  "enter" :
+		  __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ACQUIRE ?
+			  "acquire" : "unknown",
 		  __entry->namespace_type, __entry->namespace_id)
 );
 
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 6d9e54f5deedf..ddd653b686d72 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -82,6 +82,7 @@ get_blocker(const enum landlock_request_type type,
 
 	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
 	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
+	case LANDLOCK_REQUEST_NAMESPACE_ACQUIRE:
 	case LANDLOCK_REQUEST_CAPABILITY:
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(permission_strings)))
 			return "unknown";
@@ -118,6 +119,7 @@ blocker_prefix(const enum landlock_request_type type)
 
 	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
 	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
+	case LANDLOCK_REQUEST_NAMESPACE_ACQUIRE:
 		return _LANDLOCK_PERMISSION_NAMESPACE_NAME ".";
 
 	case LANDLOCK_REQUEST_CAPABILITY:
@@ -218,6 +220,8 @@ void landlock_audit_denial(const struct landlock_request *const request,
 		audit_log_format(ab, " namespace_op=create");
 	else if (request->type == LANDLOCK_REQUEST_NAMESPACE_ENTER)
 		audit_log_format(ab, " namespace_op=enter");
+	else if (request->type == LANDLOCK_REQUEST_NAMESPACE_ACQUIRE)
+		audit_log_format(ab, " namespace_op=acquire");
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad1983..97b30fbffa48e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -31,6 +31,8 @@
 #include <linux/net.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_ns.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/spinlock.h>
@@ -49,6 +51,7 @@
 #include "fs.h"
 #include "limits.h"
 #include "log.h"
+#include "ns.h"
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
@@ -1861,6 +1864,14 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 	struct landlock_request request = {};
+	int err;
+
+	if (proc_ns_file(file)) {
+		err = landlock_check_namespace_fd(file->f_cred,
+						  get_proc_ns(file_inode(file)));
+		if (err)
+			return err;
+	}
 
 	if (!subject)
 		return 0;
diff --git a/security/landlock/log.c b/security/landlock/log.c
index c132b343f0ee0..fbcfa962cca32 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -390,6 +390,7 @@ static bool is_valid_request(const struct landlock_request *const request)
 	switch (request->type) {
 	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
 	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
+	case LANDLOCK_REQUEST_NAMESPACE_ACQUIRE:
 		if (WARN_ON_ONCE(request->permission !=
 				 LANDLOCK_PERMISSION_NAMESPACE_USE) ||
 		    WARN_ON_ONCE(request->audit.type != LSM_AUDIT_DATA_NS))
@@ -488,6 +489,7 @@ is_denial_quieted(const struct landlock_request *const request,
 			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
 	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
+	case LANDLOCK_REQUEST_NAMESPACE_ACQUIRE:
 		return !!(youngest_denied->quiet_permission.ns_types &
 			  landlock_ns_type_to_bit(request->audit.u.ns.ns_type));
 	case LANDLOCK_REQUEST_CAPABILITY:
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 5ca87870c7b78..dee55270a7b89 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -29,6 +29,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 	LANDLOCK_REQUEST_NAMESPACE_CREATE,
 	LANDLOCK_REQUEST_NAMESPACE_ENTER,
+	LANDLOCK_REQUEST_NAMESPACE_ACQUIRE,
 	LANDLOCK_REQUEST_CAPABILITY,
 };
 
diff --git a/security/landlock/ns.c b/security/landlock/ns.c
index 3d443599b16f4..1ef41ac4f977b 100644
--- a/security/landlock/ns.c
+++ b/security/landlock/ns.c
@@ -89,25 +89,28 @@ static const struct access_masks ns_permission = {
 /**
  * check_ns_type - Check namespace use permission
  *
- * @ns: The namespace being allocated or installed.
+ * @ns: The namespace being created, installed, or opened.
+ * @cred: Credentials whose Landlock domain is checked.
  * @request_type: Namespace operation reported on denial.
  *
- * Shared check for namespace_init (creation via clone(2), unshare(2),
- * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
- * when the namespace type is not in the domain's allowed set.  At allocation
- * time @ns->ns_id is already set even though the namespace is not reachable
- * from user space yet.
+ * Shared check for namespace creation, installation, and nsfs file opening.
+ * Namespaces in which the current task is already a member remain accessible.
+ * At allocation time @ns->ns_id is already set even though the namespace is
+ * not reachable from user space yet.
  *
  * Return: 0 if allowed, -EPERM if denied.
  */
 static int check_ns_type(struct ns_common *const ns,
+			 const struct cred *const cred,
 			 const enum landlock_request_type request_type)
 {
 	const struct landlock_cred_security *subject;
 	size_t denied_layer;
 
-	subject = landlock_get_applicable_subject(current_cred(), ns_permission,
-						  NULL);
+	if (is_current_namespace(ns))
+		return 0;
+
+	subject = landlock_get_applicable_subject(cred, ns_permission, NULL);
 	if (!subject)
 		return 0;
 
@@ -132,13 +135,20 @@ static int check_ns_type(struct ns_common *const ns,
 
 static int hook_namespace_init(struct ns_common *const ns)
 {
-	return check_ns_type(ns, LANDLOCK_REQUEST_NAMESPACE_CREATE);
+	return check_ns_type(ns, current_cred(),
+			     LANDLOCK_REQUEST_NAMESPACE_CREATE);
 }
 
 static int hook_namespace_install(const struct nsset *const nsset,
 				  struct ns_common *const ns)
 {
-	return check_ns_type(ns, LANDLOCK_REQUEST_NAMESPACE_ENTER);
+	return check_ns_type(ns, current_cred(),
+			     LANDLOCK_REQUEST_NAMESPACE_ENTER);
+}
+
+int landlock_check_namespace_fd(const struct cred *cred, struct ns_common *ns)
+{
+	return check_ns_type(ns, cred, LANDLOCK_REQUEST_NAMESPACE_ACQUIRE);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/ns.h b/security/landlock/ns.h
index 46d3bd17479d2..cdf6dc2f7326e 100644
--- a/security/landlock/ns.h
+++ b/security/landlock/ns.h
@@ -10,8 +10,12 @@
 
 #include <linux/types.h>
 
+struct cred;
+struct ns_common;
+
 u64 landlock_ns_type_to_bit(u32 ns_type);
 u64 landlock_ns_types_to_bits(u64 ns_types);
+int landlock_check_namespace_fd(const struct cred *cred, struct ns_common *ns);
 
 __init void landlock_add_ns_hooks(void);
 
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index a47fb10dec459..9d71b31e9c27a 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -83,6 +83,7 @@ void landlock_trace_denial(
 	switch (request->type) {
 	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
 	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
+	case LANDLOCK_REQUEST_NAMESPACE_ACQUIRE:
 		if (trace_landlock_deny_permission_namespace_enabled()) {
 			const struct landlock_blockers blockers = {
 				.access = missing,
-- 
2.34.1

