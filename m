Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169777;
	b=vRgC4VNS0Q9uzUSUa0uvWvbW4/D+VBItvUH5YAeFylmMvnjSwtFsSX1NcfD3jo1XW6g8
	 n/hfKGdJyv3EtjqSaLTla9OmDXQ4A5GIxqLMND5paAx8t9sQqNKNO0EruPoNDsl+3Bsg/
	 R06x9HfpNvbiTSAlFtpr19SWMjEANuCp1Iqcm7/rC6jAbEL9ulkAs6jDDGPyIrXEsqhtG
	 wnYZeQUlOiIx5ZHF508EDPmq1EmHXwlwNDPwagHglY8+RWJJAECoZDHz2qtUPotARuZhZ
	 EATmX1dMRJ+PNGfHkBdjcyZIkD/WqHDAFjTsYD4Rq80BzR52CrRzjNS1IzQ7UKRjYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169777;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Q6G3nxFD05ygIwY6v+3uq58Goki6iPih8OOteYGgxqQ=;
	b=Zh0b4op1RLTvp3pA+9GVNbzD25liiOvGkK9QUXUF0tvGzTahx8OimJOVZ9unVouga8qP
	 sQvHgCszPapjCq4uW0t0Z6lqT1iKz+rgjkTpCp1HlWmQNgjR7aujwar02/utz/xcCqVsd
	 2CnzMODInvm8AKVOdl8yEXrBbtkw1m7zh90j0a0F7jP0hP+L3vAfQu9LX3Tf+TmlK44jH
	 yxzgq5PzMIEnLzL21kHlGGnH+MWxGHhsXYWRvw8VDn0uZRHjxsgxcPHIooXVNDpGAgafP
	 Z8aWxqouCHXIoii/faaL8mnYGvdstMXQ3ndI5mOD81DvUquuOKpnx0EwxqKqXa2mDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=ex8kivjK;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B11606A31A;
	Wed, 28 Oct 2026 06:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B11606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=ex8kivjK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793169775;
	bh=aLWh42rcMNKepHGFb1obkzRcUt2M03VEF2PDUV87Fpc=;
	h=From:Date:Subject:To:Cc:From;
	b=ex8kivjKpCVe3SEW/De1KV7FnRgFJh2XCInhoOieVVGrc3KwwoWpNg71yG4NuLLjL
	 V2Q43qxbDM2xGhboyKUa+6W4Xs2FD2eoX+qJQ7LpJDiA3WrMMJ0hXAYclVaLJf0UxD
	 x7NYkedzR/OIceuvbWG9xxv8KmaPdF7AmwQBQp+4=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 8FAB94006C;
	Tue, 27 Oct 2026 23:42:55 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Tue, 27 Oct 2026 23:42:51 -0700
Subject: [PATCH v2] ipc/msg: prevent msg_qbytes limit bypass in IPC_SET
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
Message-Id: <20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAGqZ4WoC/3XMyw6CMBCF4Vchs3YMU7nVle9hWFgYyiyk2BKUk
 L67lb3L/yTn2yGwFw5wzXbwvEoQN6VQpwy68TFZRulTg8pVRbmqUeYOn8Hiy2wLByy0oVJfqCt
 NBek0ex7kc4D3NvUoYXF+O/yVfutfaiUkbBpd9abIaxr0zfK0vN3ZeQttjPELLUAjPa0AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793169775; l=6756;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=aLWh42rcMNKepHGFb1obkzRcUt2M03VEF2PDUV87Fpc=;
 b=dRyGaRLst+jniGlRn6ywhZXdc0t6tj9NAKNv4eIKRbJfLNzdmnYSwGFrWBeHuMFjOsKRR/6/9
 Rlc5Y557XZsAQJyNyRwK3phWekbMlkY/8q4iCQuFhzGtb4WqJ83aZw3
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

The msg_qbytes field in the msqid64_ds userspace ABI is an unsigned
long. Commit 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down()
functions") passed that value to msgctl_down() as an int.

An unprivileged owner can set msg_qbytes to UINT_MAX. The narrowing
conversion produces -1 on supported Linux targets, so the check against
the int-valued msg_ctlmnb sysctl does not reject the request:

	if (msg_qbytes > ns->msg_ctlmnb &&
	    !capable(CAP_SYS_RESOURCE))

The value is then assigned to the unsigned long q_qbytes field, setting
it to ULONG_MAX. This bypasses the CAP_SYS_RESOURCE requirement for
increasing a queue above MSGMNB.

It also bypasses the effective per-queue message-count limit: zero-length
messages consume kernel memory but not queue bytes. An unprivileged queue
owner can therefore cause memory pressure or exhaustion beyond the
configured per-queue allowance, subject to other resource limits.

Keep msg_qbytes as unsigned long through validation and assignment.
Also preserve its type in ipcctl_obtain_check(), which supplies it to
the unsigned-long audit field.

Add a regression test which drops CAP_SYS_RESOURCE and verifies that
IPC_SET with UINT_MAX fails with EPERM. Skip the test when capabilities
or System V message queues are unavailable.

Fixes: 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down() functions")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Changes in v2:
- Skip the selftest when capability syscalls or System V message queues
  are unavailable.
- Describe the queued-message-limit and memory-pressure impact.

Link to v1: https://lore.kernel.org/r/20261027-ipc-msg-qbytes-v1-1-8896db4071f9@gentwo.org
---
 ipc/msg.c                                   |  2 +-
 ipc/util.c                                  |  3 +-
 ipc/util.h                                  |  3 +-
 tools/testing/selftests/ipc/Makefile        |  2 +-
 tools/testing/selftests/ipc/msgctl_qbytes.c | 81 +++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 4 deletions(-)

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
index 0000000000000000000000000000000000000000..152e3d91557198c468a8d3bd3b05dd82e7e99a50
--- /dev/null
+++ b/tools/testing/selftests/ipc/msgctl_qbytes.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <limits.h>
+#include <linux/capability.h>
+#include <stdio.h>
+#include <string.h>
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
+	 * msg_ctlmnb is an int, so UINT_MAX must require
+	 * CAP_SYS_RESOURCE.
+	 */
+	ds.msg_qbytes = UINT_MAX;
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
base-commit: 8a36f53fd5ec3eff01f1b637d42cbdc3821d0493
change-id: 20261027-ipc-msg-qbytes-49b15931c5b6

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

