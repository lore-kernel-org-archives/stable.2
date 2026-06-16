Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F3413631;
	Tue, 16 Jun 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598662; cv=none; b=ChbDxn6L++XSB0f++mCuCxvCQ4axIZkmDx/BEBc8u7+vX30d5kY8fYToOknUWAONXxj5AQxxoXeug06N+MI4VosCse+vsV/egLW3Ap+QSBcq9r+nBMZHunwRzJOFyaOVPHiSAqkMZQPYbLDymHme2dt6vvhRLEFvctQhK1IP/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598662; c=relaxed/simple;
	bh=CiwljDGoc6RbyU9sTl8Z3dxgwHvAqYr7TMMn6g43COQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Btoxz/FQIwdHKPXU3zBzjO3mDBNPFEIkJ3+02iCS74lCxA/e1MP42Gcal/1IlRxrMyT8/hI+wHXRstcr666tkBWl23ebKfpGtG+IoWpHPICogDDJInsKKVGMyqY7DshOzsyijxtdQoNAWAv09nVfdzc0tVETPe53xbBkDXXn2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pik0QyHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pik0QyHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF331F000E9;
	Tue, 16 Jun 2026 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598661;
	bh=dht2mQYv2tY+Sw7HgOyeWCGT/1f1dV2Zet7OuaIS6NQ=;
	h=From:To:Cc:Subject:Date;
	b=Pik0QyHZjMSBX1E4TsL6kOgTdC+BWBIcI56Esb3pER+PA7DtD8lkg93Z1247Hg6iY
	 E4zNXlzVq9zXPSM2qhs3NW8iZXwPZQh8icasxUh8HtaxMAl20NALgRbo+QVk35x0IU
	 af/PbrC/dREK/SC8rV3bsBA20Ai8snlMmnkasQB52VgGmfDB/H8a+HM3bO3EjVoFIX
	 DXX5+ZUGYEwpFVvOh5JYJux82oM+vXNg4drO9MYK93sH391NhAAJ0qRdw3dPDncSrS
	 OqFUQQnceFnEMb0E/MTHMK3aKHKooS2wLCcihYumAAzlXlUlgLhqtBl7ynYfK00ORK
	 K1aovhgjKlIvw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
Date: Tue, 16 Jun 2026 10:30:56 +0200
Message-ID: <20260616083056.405652-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by sashiko we use __get_user without prior access_ok call on the
user space pointer. Adding the missing call for the whole pointer array.

Plus removing the err check in the error path, because it's not needed and
also we can return -ENOMEM directly from the first kvmalloc_array fail path.

Cc: stable@vger.kernel.org
[1] https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.org/
Fixes: 0236fec57a15 ("bpf: Resolve symbols with ftrace_lookup_symbols for kprobe multi link")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.org/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..75495a5c3507 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2376,9 +2376,12 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
 	int err = -ENOMEM;
 	unsigned int i;
 
+	if (!access_ok(usyms, cnt * sizeof(*usyms)))
+		return -EFAULT;
+
 	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
 	if (!syms)
-		goto error;
+		return -ENOMEM;
 
 	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
 	if (!buf)
@@ -2403,10 +2406,8 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
 	return 0;
 
 error:
-	if (err) {
-		kvfree(syms);
-		kvfree(buf);
-	}
+	kvfree(syms);
+	kvfree(buf);
 	return err;
 }
 
-- 
2.54.0

