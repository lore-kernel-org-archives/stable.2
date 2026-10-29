Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302566;
	b=ecDuTzavMGXmGQ8W7GSrbYKuGVhVXz0Rpy+2duHaHKbhbRqkSsVzRLpyrtjEEMGxmsij
	 HHZGE21xvHmyx2YXfAkR52AC25Eet/8yL+UB5AvvKEC23VlsEgj6vlWZNywGbbwIE5sUR
	 ptthUUxWurV6jSTzACsFMJ2ItvXsedRogpqg+xt1uNHllOVG96x5Bxdm5fKpFX9r0zwhc
	 MbTKFvkw1xjEfjqDUmB6ocry8eCwjwePMYIjfhp3zzMhgPRgtr7rrQCf1aCxiGaXJmcYH
	 Hrys0XEFIGwsNX3UeJ8c/imkTCyfsCoyhAKijkYGVCF7GwSfHA0koMvoWkuBFoIWUtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302566;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Q4H5t+eODJaHqBUAWhEmblQLDww9KM17vWg0h8HbPP8=;
	b=Uv352I4Thnl42Np+reQmMXMQSxoQb+k/2B0pyZhXjtBvg5vvvVWUlohiXJN512ery8pn
	 Bg1NACFiI7xlnmRqg3/2CFPqiDQCPhXneDl9WoTgnBE1u/q3clgPnMmE+7Dc5lN1GlVK3
	 gvGL6ci/9ysIk26ICt9O471QpcrrPkXttAAW6fq2+1/br/fVl7XOaDKyHn9PSkMLusfN9
	 4KfpwMDR9xHfpFEB2T6If+QmoDK1Hfc9teLdu8CMYnVLPpzlE8alK8JLUJjUjPDEv9Yu5
	 AgVb/V5Hdv+/PsHyN8HTEeW9c+wIzXxKYgY4XX6th5gwbHkY3izR+46wQ/pZvNdlIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=I7Fv9Qde;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151E606A320;
	Thu, 29 Oct 2026 19:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A151E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=I7Fv9Qde
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793302559;
	bh=IF87MDnSXrW+lYPzzhk7yjJ+lXPArYF61Deoz9hSDnc=;
	h=From:Date:Subject:To:Cc:From;
	b=I7Fv9QdeVydbmcUPByzLLR5JuTPgdyloTvDuidZeaGUAmRKJmzmIT5Se8W1V39mfS
	 /OtKPpfvoRR3W9hNqPfrAlvrpqyvaOiFM0FU3XmKqEKMCrz7xnEzE8+5AwIxBtykPm
	 sqpACwYIt+f4bu2qm/iCavcCKE3mwxdao0LQaQRw=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id C9E3D40112;
	Thu, 29 Oct 2026 12:35:58 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Thu, 29 Oct 2026 12:35:50 -0700
Subject: [PATCH v3] ipc/msg: fix msg_qbytes truncation in IPC_SET
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
Message-Id: <20261029-ipc-msg-qbytes-v3-1-fc3f4307c85b@gentwo.org>
X-B4-Tracking: v=1; b=H4sIABWg42oC/32MSw6CMBQAr0Le2hpe+bWuvIdxYaEtbyGFllQJ4
 e4Wdi50OZPMrBC0Jx3gkq3gdaRAbkhQnDJo+8dgNaMuMfCc15jzhtHYsmewbFLLrAMrpcJKFth
 WqoYUjV4beh/D2z1xT2F2fjn+EXf7cxWRIRNC1p0q8waNvFo9zC93dt7C/or8f89TX4pOmIYbL
 Krvftu2D33uOl/tAAAA
X-Change-ID: 20261027-ipc-msg-qbytes-49b15931c5b6
To: Shuah Khan <shuah@kernel.org>, Lu Shuaibing <shuaibinglu@126.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christopher Lameter (Ampere)" <cl@gentwo.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Manfred Spraul <manfred@colorfullife.com>, 
 Jan Koester <jan.koester@tuxist.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793302558; l=7105;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=IF87MDnSXrW+lYPzzhk7yjJ+lXPArYF61Deoz9hSDnc=;
 b=lboZtgg0Qa3KJETmsvMvZGd0acv/vsc/TuhfKLs3dWxW4e9vSPbwJYzDsQVBCHXtQNJEaIxNf
 OCpvK2Uz1jhCk7HmpdxPOtLtY4NT19WMjlv47bxAnzC33882DnCy/rq
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

The msg_qbytes field in the struct msqid64_ds userspace ABI is an
unsigned long. Commit 889b331724c82 ("ipc/msg.c: consolidate all
xxxctl_down() functions") passes that value to msgctl_down() as an int.

On ABIs where unsigned long is wider than unsigned int, this narrows
msg_qbytes before validation and assignment. For example, an
unprivileged queue owner can request msg_qbytes = 0x100000000. The
conversion to int changes this value to zero, which passes the
msg_ctlmnb check. IPC_SET then succeeds and sets q_qbytes to zero
instead of rejecting the requested value with EPERM.

For callers with CAP_SYS_RESOURCE, values with bit 31 set are also
incorrectly sign-extended when assigned to q_qbytes. In particular,
UINT_MAX becomes ULONG_MAX rather than the requested UINT_MAX.

Keep msg_qbytes as unsigned long through validation and assignment.
Also preserve its type in ipcctl_obtain_check(), which passes it to the
unsigned-long audit field.

Add a regression test which drops CAP_SYS_RESOURCE and verifies that
IPC_SET with a value above UINT_MAX fails with EPERM where unsigned long
is wider than unsigned int. Skip the test when it is not, capabilities
are unavailable, or System V message queues are unavailable.

Fixes: 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down() functions")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Changes in v3:
  - Correct the analysis: msg_ctlmnb is unsigned int, so UINT_MAX is
    already rejected for unprivileged callers on the unfixed kernel.
  - Test an unprivileged 64-bit msg_qbytes value above UINT_MAX, which
    truncates to zero on the unfixed kernel.
  - Skip the test on 32-bit, where unsigned long cannot represent the
    regression value.
  - Remove the incorrect queue-limit-bypass and memory-exhaustion claims.

Link to v2: https://lore.kernel.org/r/20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org
---
 ipc/msg.c                                   |  2 +-
 ipc/util.c                                  |  3 +-
 ipc/util.h                                  |  3 +-
 tools/testing/selftests/ipc/Makefile        |  2 +-
 tools/testing/selftests/ipc/msgctl_qbytes.c | 84 +++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 62996b97f0ac2137dfc2fa109394d6db1fcb4a0f..116126f1235cd6ce9b819cfd317ef039071b95ca 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -399,7 +399,7 @@ copy_msqid_from_user(struct msqid64_ds *out, void __user *buf, int version)
  * NOTE: no locks must be held, the rwsem is taken inside this function.
  */
 static int msgctl_down(struct ipc_namespace *ns, int msqid, int cmd,
-			struct ipc64_perm *perm, int msg_qbytes)
+			struct ipc64_perm *perm, unsigned long msg_qbytes)
 {
 	struct kern_ipc_perm *ipcp;
 	struct msg_queue *msq;
diff --git a/ipc/util.c b/ipc/util.c
index 1737d776bc089e27495e810569bf302069db3712..c435b2d93a12e92e930358a8bc53a06314d065f5 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -718,7 +718,8 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
  */
 struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
 					struct ipc_ids *ids, int id, int cmd,
-					struct ipc64_perm *perm, int extra_perm)
+					struct ipc64_perm *perm,
+					unsigned long extra_perm)
 {
 	kuid_t euid;
 	int err = -EPERM;
diff --git a/ipc/util.h b/ipc/util.h
index a55d6cebe6d3b0974548a497fcb889248aed0f87..55a76f94667cd4bb248fbcea26323db8d2778a44 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -180,7 +180,8 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
 int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out);
 struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
 					     struct ipc_ids *ids, int id, int cmd,
-					     struct ipc64_perm *perm, int extra_perm);
+					     struct ipc64_perm *perm,
+					     unsigned long extra_perm);
 
 static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
 {
diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index fad10f2bb57b0f06f0c741fa89f0489f6952eba6..930a334747a6353c86bebe1f4a521aeee3fe8228 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -12,7 +12,7 @@ endif
 
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := msgque
+TEST_GEN_PROGS := msgctl_qbytes msgque
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ipc/msgctl_qbytes.c b/tools/testing/selftests/ipc/msgctl_qbytes.c
new file mode 100644
index 0000000000000000000000000000000000000000..5549229a25eb6852898fdb6cd8e89f9db78444dd
--- /dev/null
+++ b/tools/testing/selftests/ipc/msgctl_qbytes.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <limits.h>
+#include <linux/capability.h>
+#include <stdio.h>
+#include <sys/msg.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+
+static int drop_cap_sys_resource(void)
+{
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	unsigned int index = CAP_SYS_RESOURCE / 32;
+	__u32 mask = 1U << (CAP_SYS_RESOURCE % 32);
+
+	if (syscall(SYS_capget, &hdr, data))
+		return -1;
+
+	data[index].effective &= ~mask;
+	data[index].permitted &= ~mask;
+
+	return syscall(SYS_capset, &hdr, data);
+}
+
+int main(void)
+{
+	struct msqid_ds ds;
+	int msqid;
+	int ret;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+#if ULONG_MAX <= UINT_MAX
+	ksft_exit_skip("requires unsigned long wider than unsigned int\n");
+#endif
+
+	if (drop_cap_sys_resource()) {
+		if (errno == ENOSYS)
+			ksft_exit_skip("capabilities are unavailable\n");
+		ksft_exit_fail_perror("drop CAP_SYS_RESOURCE");
+	}
+
+	msqid = msgget(IPC_PRIVATE, 0600);
+	if (msqid == -1) {
+		if (errno == ENOSYS)
+			ksft_exit_skip("System V message queues are unavailable\n");
+		ksft_exit_fail_perror("msgget");
+	}
+
+	ret = msgctl(msqid, IPC_STAT, &ds);
+	if (ret == -1) {
+		ksft_perror("msgctl(IPC_STAT)");
+		goto out_fail;
+	}
+
+	/*
+	 * Without CAP_SYS_RESOURCE, a value above UINT_MAX must be rejected
+	 * rather than truncated to zero.
+	 */
+	ds.msg_qbytes = (unsigned long)UINT_MAX + 1;
+	errno = 0;
+	ret = msgctl(msqid, IPC_SET, &ds);
+	if (ret == -1 && errno == EPERM) {
+		ksft_test_result_pass("IPC_SET rejects oversized msg_qbytes\n");
+		msgctl(msqid, IPC_RMID, NULL);
+		ksft_exit_pass();
+	}
+
+	if (ret == -1)
+		ksft_perror("msgctl(IPC_SET)");
+	else
+		ksft_print_msg("msgctl(IPC_SET) unexpectedly succeeded\n");
+
+out_fail:
+	msgctl(msqid, IPC_RMID, NULL);
+	ksft_test_result_fail("IPC_SET accepted oversized msg_qbytes\n");
+	ksft_exit_fail();
+}

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261027-ipc-msg-qbytes-49b15931c5b6

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

