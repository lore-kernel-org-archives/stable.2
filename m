Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE49282F3E;
	Wed, 29 Jul 2026 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287992; cv=none; b=N+tI/Qhuyz25t3tbmSDeqjusmaFKuO/ocCVuCzpE4tcTFb7wgJZYWXz/C6g9j+k9F8Fcy3oAVDg+7K9caWQNUri7+SNo64hbP9Y8RrHZLugjfkfa2fi55aVyPtC1dG7YPnEsrjWGTyaMiuJIXD+To9xn/hR/qY77u/XbqzR6YtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287992; c=relaxed/simple;
	bh=/fpHilKjJsEhcKhWb37zjAEH0pC3uFY52247twwOQ3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeMqhigrMgWi9ikhMUl82pdlpyX4g2ITUlATEdLik89gu26opTzmpsQ5h8K6Ns01OvqxRfsXnVZuKf+egkdVaHWASED5fEb4TUuiYE5kstyHqUmTfyVHg9aWUCA/FbflfovBhUKb3WGkk6lXRKzUEqKb2XwbXXqMZVQ0zSmDi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=X/P3Fl0x; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="X/P3Fl0x"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SNOk9L3377823;
	Wed, 29 Jul 2026 01:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=f2kIufiB4zAbCnVLWmpyvqi8hJVXX0+A852NGL+OOm0=; b=X/P3
	Fl0x03/E0qQQPYDVxS1pspDLVGsFmTIXrFPB4eJB9WTcgcY49UPWkZkDRwKmPIwW
	xMfdI+t8lA+AOdZ4kaehKWxiPtjbzqv47sBW5PSmEUVmV3Zvfr7k1TtZExfgtBaL
	esO0o+tv4bLL3IJxCKHew35ks9Ru5kUNahm4h+eAUKETsSdxGc9g0sBvc4IYPGiW
	adrNtSunVthhDyaI6Ac/6EekSrpCvcRDqO3W+jObiEeFjQDFz1nw2Bfv7QH61dK+
	9vXvAZYQ0X4RtmTXMPv3+OOIn95QbtzjUI0xqp2gc9/KPm0QRgxJSkmEX5LNYMt0
	1phk6lPNQi00SHyzJA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fq0cphtx2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 01:00:06 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 29 Jul 2026 01:00:04 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <song@kernel.org>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent test
Date: Tue, 28 Jul 2026 20:59:59 -0400
Message-ID: <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=P9oKQCAu c=1 sm=1 tr=0 ts=6a695096 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=Nk4PlfOtfY4ndHm_82AA:9
X-Proofpoint-ORIG-GUID: IZPvcgRUVQKASWsSYjAMUX_5FwqoQpV1
X-Proofpoint-GUID: IZPvcgRUVQKASWsSYjAMUX_5FwqoQpV1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX1q9I4cw5M7o9
 ypU9Cgetysbj0A6dtCbml1TQz1RZBbsm6Q3H0XeSjx4NCUUwOquC8sXoGMuvOPhmCEkuE411qgG
 Y2fu1AWOWwl+gBWO6JnnlgWxHFzlJqh6Fe1cGB9JQMb7ec2jHAHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX1YzYYI+QFcFS
 1dYwOlzOUgyJPRy+M0mrXPV+7qYlYICiByonPD2uh2hDU5hfBdJuLPeAxty8NUEHLy0Iofq6zye
 tfvyByYDfcY/q7pDgtSbbW2/NyhaydMUpcFT2+xrgYfAkJmoh97YB76wyT5xkqGEvfNvRkjbqTJ
 UzffA9S69LtE5qAkqI74kzKUCGdPSw45KWo8qqtAre1qpuk0YjbVW63k6iSi67VA4rZUv1GMWlh
 kpU/1StCbTkagnx3pW7bgloGB2JtXHcLij8Pcg03BNIV/APhmyyJgX161BDZ/mCT4rqDz0BnEVn
 MqpssIiCeChKdk2XZPAu3Dq/hdAyo8e3LNvDrTR8ZLfBOgsiIp0lypz0a3h87Ua80BJZUOoHCXM
 ZJguQRe4AFCdMgftOxm1lMonNUkQ/czUGpAmF1hhcvb235/rfdu6+65rTBkYg2NpYab9hn0FEm+
 4GsCCOG6D1JJcuVhX/g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290005

Cover the FTRACE_OPS_FL_PERMANENT fix on BPF trampolines and
ftrace-based kprobes/kretprobes: attach a fentry, fexit, kprobe, and
kretprobe program in turn and confirm kernel.ftrace_enabled=0 is
refused with EBUSY while attached, then succeeds once detached. Also
confirm a new fentry/kprobe attach is itself refused while
ftrace_enabled=0 is already in effect.

kprobe.multi/kretprobe.multi/kprobe.session are intentionally not
covered, matching the production change's scope.

Skip the kprobe/kretprobe subtests when CONFIG_KPROBES_ON_FTRACE is
off (e.g. arm64), read back via skel->kconfig->CONFIG_KPROBES_ON_FTRACE
(same __kconfig idiom as progs/test_fill_link_info.c).

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../bpf/prog_tests/ftrace_permanent.c         | 144 ++++++++++++++++++
 .../selftests/bpf/progs/ftrace_permanent.c    |  43 ++++++
 2 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
 create mode 100644 tools/testing/selftests/bpf/progs/ftrace_permanent.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c b/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
new file mode 100644
index 000000000000..dbe78009a291
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike */
+#include <test_progs.h>
+#include "ftrace_permanent.skel.h"
+
+/*
+ * fentry/fexit/kprobe/kretprobe now carry FTRACE_OPS_FL_PERMANENT, so
+ * kernel.ftrace_enabled=0 must be refused with EBUSY while any of them
+ * is attached, and allowed again once detached.
+ *
+ * kprobe.multi/kretprobe.multi/kprobe.session are out of scope.
+ * kprobe/kretprobe subtests need CONFIG_KPROBES_ON_FTRACE (e.g. not on
+ * arm64) and are skipped otherwise.
+ */
+
+#define FTRACE_ENABLED_PATH "/proc/sys/kernel/ftrace_enabled"
+
+static int read_ftrace_enabled(int *val)
+{
+	char buf[16] = {};
+	int fd, n;
+
+	fd = open(FTRACE_ENABLED_PATH, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return -EIO;
+	*val = atoi(buf);
+	return 0;
+}
+
+/* Returns 0 on success, or -errno on write failure. */
+static int write_ftrace_enabled(int val)
+{
+	char buf[4];
+	int fd, n, len, err = 0;
+
+	fd = open(FTRACE_ENABLED_PATH, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	len = snprintf(buf, sizeof(buf), "%d", val);
+	n = write(fd, buf, len);
+	if (n < 0)
+		err = -errno;
+	close(fd);
+	return err;
+}
+
+/*
+ * Attach @prog, assert kernel.ftrace_enabled=0 is refused while attached
+ * and stays at 1, then detach and assert the disable now succeeds.
+ */
+static void check_blocks_disable(struct bpf_program *prog, const char *name)
+{
+	struct bpf_link *link;
+	int val, err;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, name))
+		return;
+
+	err = write_ftrace_enabled(0);
+	ASSERT_EQ(err, -EBUSY, "disable_refused");
+	if (!ASSERT_OK(read_ftrace_enabled(&val), "read_back"))
+		goto detach;
+	ASSERT_EQ(val, 1, "still_enabled");
+
+detach:
+	bpf_link__destroy(link);
+
+	ASSERT_OK(write_ftrace_enabled(0), "disable_after_detach");
+	ASSERT_OK(write_ftrace_enabled(1), "reenable");
+}
+
+/* Attach @prog while ftrace_enabled=0 and assert it is refused. */
+static void check_attach_while_disabled_refused(struct bpf_program *prog, const char *name)
+{
+	struct bpf_link *link;
+
+	if (!ASSERT_OK(write_ftrace_enabled(0), "disable"))
+		return;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_ERR_PTR(link, name))
+		bpf_link__destroy(link);
+
+	ASSERT_OK(write_ftrace_enabled(1), "reenable");
+}
+
+void test_ftrace_permanent(void)
+{
+	struct ftrace_permanent *skel;
+	bool kprobes_on_ftrace;
+	int orig = 1;
+
+	/* Save and always restore ftrace_enabled. */
+	if (read_ftrace_enabled(&orig)) {
+		test__skip();
+		return;
+	}
+
+	skel = ftrace_permanent__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto restore;
+
+	kprobes_on_ftrace = skel->kconfig->CONFIG_KPROBES_ON_FTRACE;
+
+	if (test__start_subtest("fentry_blocks_disable"))
+		check_blocks_disable(skel->progs.test_fentry, "attach_fentry");
+
+	if (test__start_subtest("fexit_blocks_disable"))
+		check_blocks_disable(skel->progs.test_fexit, "attach_fexit");
+
+	if (test__start_subtest("kprobe_blocks_disable")) {
+		if (kprobes_on_ftrace)
+			check_blocks_disable(skel->progs.test_kprobe, "attach_kprobe");
+		else
+			test__skip();
+	}
+
+	if (test__start_subtest("kretprobe_blocks_disable")) {
+		if (kprobes_on_ftrace)
+			check_blocks_disable(skel->progs.test_kretprobe, "attach_kretprobe");
+		else
+			test__skip();
+	}
+
+	if (test__start_subtest("fentry_attach_while_disabled_refused"))
+		check_attach_while_disabled_refused(skel->progs.test_fentry, "attach_fentry");
+
+	if (test__start_subtest("kprobe_attach_while_disabled_refused")) {
+		if (kprobes_on_ftrace)
+			check_attach_while_disabled_refused(skel->progs.test_kprobe,
+							    "attach_kprobe");
+		else
+			test__skip();
+	}
+
+	ftrace_permanent__destroy(skel);
+restore:
+	write_ftrace_enabled(orig);
+}
diff --git a/tools/testing/selftests/bpf/progs/ftrace_permanent.c b/tools/testing/selftests/bpf/progs/ftrace_permanent.c
new file mode 100644
index 000000000000..ca706d8edc23
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ftrace_permanent.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
+
+/* This function is here to have CONFIG_KPROBES_ON_FTRACE used and
+ * added to object BTF, so the userspace side can read it back via
+ * skel->kconfig->CONFIG_KPROBES_ON_FTRACE.
+ */
+int unused(void)
+{
+	return CONFIG_KPROBES_ON_FTRACE ? 0 : 1;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_fentry, int a)
+{
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test2")
+int BPF_PROG(test_fexit, int a, __u64 b)
+{
+	return 0;
+}
+
+SEC("kprobe/bpf_fentry_test3")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kretprobe/bpf_fentry_test4")
+int BPF_KRETPROBE(test_kretprobe)
+{
+	return 0;
+}
-- 
2.34.1

