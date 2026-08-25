Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6D401A06;
	Tue, 25 Aug 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659886; cv=none; b=iNPeJydJOGZGpmeyKgWUItbZGB96DdzAWoc+R+gpHUvcKXhKSDce3pHMMEYy+nnd0+hPiNysedxO4fifjX8UqlRqHE91V0R2AA4AcXC4WNcEUCxL/1vSvYFeDA37vVSauUN32YYYOhidkr38DkIcDerROC91bMsHnYIWycf1j+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659886; c=relaxed/simple;
	bh=dQaRpOMIuswA7J5htwHTLa2HNunAPIomcvWX9PxYhP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNrMk2t4gl4ZF2QXrG3SC0vJV62wHqYj0PDxw4gd2Oj1Kg8YZxd4dMrqq0+/3RGwaNbbPyXI5c7Uwh1Kih1mkN7B3eGNAlybe5qr1HXHYgTZHX8/m8gQz8ih9lCb6sCp2jtFniwfEE9frnnABfxgFqSCsT7RWt8+cQUz1KvDQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=AIeMc+7v; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="AIeMc+7v"
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id CFBFE80825;
	Tue, 25 Aug 2026 15:11:11 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:c6c::1:34])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id 5BbdxdOaJ4Y0-WVB3KhDk;
	Tue, 25 Aug 2026 15:11:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787659871;
	bh=1q40l4CajxPkvMjbZP7ujV27YbokKKHboNznAA/0BGg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=AIeMc+7vzv0pTLvmxx4hgauiH/WMBb5GDSExkft9MCqYY3W+0EWLoLXYH1+aWSJdt
	 KFvS4iPLtquKwu5EuAlMM0qen2+0x37jOBpIJ5k6bxhwddXf7Eop++7IGuIpwUF1qO
	 sfQEx0C8Ono5Un7sRwJOzWzumWsCvjyDXUkRwjsU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
Date: Tue, 25 Aug 2026 15:11:07 +0300
Message-ID: <20260825121107.2125-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 1c22483a2c4bbf747787f328392ca3e68619c4dc ]

CO-RE accessor strings are colon-separated indices that describe a path
from a root BTF type to a target field, e.g. "0:1:2" walks through
nested struct members. bpf_core_parse_spec() parses each component with
sscanf("%d"), so negative values like -1 are silently accepted.  The
subsequent bounds checks (access_idx >= btf_vlen(t)) only guard the
upper bound and always pass for negative values because C integer
promotion converts the __u16 btf_vlen result to int, making the
comparison (int)(-1) >= (int)(N) false for any positive N.

When -1 reaches btf_member_bit_offset() it gets cast to u32 0xffffffff,
producing an out-of-bounds read far past the members array.  A crafted
BPF program with a negative CO-RE accessor on any struct that exists in
vmlinux BTF (e.g. task_struct) crashes the kernel deterministically
during BPF_PROG_LOAD on any system with CONFIG_DEBUG_INFO_BTF=y
(default on major distributions).  The bug is reachable with CAP_BPF:

 BUG: unable to handle page fault for address: ffffed11818b6626
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
 RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:354)
 RAX: 00000000ffffffff
 Call Trace:
  <TASK>
  bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1321)
  bpf_core_apply (kernel/bpf/btf.c:9507)
  check_core_relo (kernel/bpf/verifier.c:19475)
  bpf_check (kernel/bpf/verifier.c:26031)
  bpf_prog_load (kernel/bpf/syscall.c:3089)
  __sys_bpf (kernel/bpf/syscall.c:6228)
  </TASK>

CO-RE accessor indices are inherently non-negative (struct member index,
array element index, or enumerator index), so reject them immediately
after parsing.

Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/20260404161221.961828-2-bestswngs@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[Andrey Troshin: backport fixs from tools/lib/bpf/relo_core.c to
  tools/lib/bpf/libbpf.c]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2026-45839
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-45839
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c6902c7bdff..e826557c45f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4554,6 +4554,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
 			++spec_str;
 		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) != 1)
 			return -EINVAL;
+		if (access_idx < 0)
+			return -EINVAL;
 		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
 			return -E2BIG;
 		spec_str += parsed_len;
-- 
2.34.1

