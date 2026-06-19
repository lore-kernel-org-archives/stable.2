Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74762382F01;
	Fri, 19 Jun 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874660; cv=none; b=QQfQcJjG7sQzpl4Nm6zuQL14C6I3ONYWtnrM6AOnMCtnIQMTocdG9zsnzdVubMhPoNc6x8k7b+eJS40EaJ8Lx8Nk00TYrQ5KD68ZNPNKHrDJe6Nq16Ec5fvYH7crET00fXTga7yWw8qrrrjwt8/5AA6EYtobPgmhaefgdiL9/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874660; c=relaxed/simple;
	bh=HRdwRR4CSd3817zTzkZ6p9dlpsYCA7qFPjbEh3VTooM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDBV6PWeVxZaGUEakHEMZP2pe28Abr7j5xp2Iao3aSWQ0XaW2LNZZW5fD/G1fxP1KBjE5FaBjg5prcvMQtCbfQPagdW/FhwOfK1fzvBnK4MV+gFcyR1gXLk+C8YX/VOsBz6YyfP6wRWWkv6tfs4RUDMeWuz/tMcByUWl+b4UnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Pt4TW7bW; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Pt4TW7bW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781874187;
	bh=nRD4jHbayONtNkiYwwliT2YhCmG0sIGASUm/hwOFQoo=;
	h=From:To:Cc:Subject:Date:From;
	b=Pt4TW7bWZeEtGE9iFzUis6s7T7pJbz7gfEbIswBcLfSyXB93kFAm51AFBz4MR82Ej
	 Udk0P8xd8ckinEF7f4hK8+0K1JvmBISROk0rqrjNPqAQcnjVrmD0yS9hRroscCxm/p
	 BxlpT0EXeD1CwKLaSJb0qheiO0U+Omo+4FqIe3vQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghd7H4Ph1z11N7;
	Fri, 19 Jun 2026 13:03:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghd7G44QHz11N1;
	Fri, 19 Jun 2026 13:03:06 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Florent Revest <revest@google.com>,
	Brendan Jackman <jackmanb@google.com>
Subject: [PATCH 1/2] bpf: lsm: disable xfrm_decode_session hook attachment
Date: Fri, 19 Jun 2026 13:03:03 +0000
Message-ID: <20260619130305.27779-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF LSM programs can currently attach to xfrm_decode_session(). That
hook may return an error, but security_skb_classify_flow() calls it
from a void path and triggers BUG_ON() if an error is returned.

Disable BPF attachment to the hook to prevent a BPF LSM program from
turning packet classification into a full panic.

Fixes: 9e4e01dfd325 ("bpf: lsm: Implement attach, detach and execution")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/bpf/bpf_lsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 564071a92d7d..1433809bb166 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -51,6 +51,9 @@ BTF_ID(func, bpf_lsm_key_getsecurity)
 #ifdef CONFIG_AUDIT
 BTF_ID(func, bpf_lsm_audit_rule_match)
 #endif
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+BTF_ID(func, bpf_lsm_xfrm_decode_session)
+#endif
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_SET_END(bpf_lsm_disabled_hooks)
-- 
2.53.0

