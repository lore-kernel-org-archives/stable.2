Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80BC2C8;
	Wed, 16 Sep 2026 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518446; cv=none; b=O3iq3Yqw3AjVS6/9wFk3ogxzTdENlMtkk3TN2+uXKRclfbk4RRjwPMZbH660Pys9nefHCDL+hIJChAnxbMkSTWSwyT8JXgY2QLuov8YNP+gzh7q0i9ZZSvv7B7/pOQz289z9BLycuTTSFr8/pWuEQ5XLlR00lSikTvNhSYqUd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518446; c=relaxed/simple;
	bh=6dVQttjCF1mlg5PLWwUrd2x5hJmqDrnhWId6eYBZF5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1Nr4a3d3k4XsbPIsI2Km5iNXtQEk7oahFF6XU+/2ATOUb9InL6qBg4K1P/7vpdnXjyXf6l0OCFlVDAk1LWtqnZW7vNCzKo6Q1/6YSSqyDuOpAUZudogk7C0VP25msJbIP6NEv6zWwRz7AibshmMg0X3HT7jwGa4KkpOcfLa6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NC3G/qJW; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NC3G/qJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789518445; x=1821054445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZnSiMtMZxoC3fI+sO3WE5tGkD3rF+rW3RAilPAikGA=;
  b=NC3G/qJWOMS6wm4j6ZyDoBFqrEXNuFRiC7lhJ1/qcSidHc1kUGNpEOYc
   nn5LLsriPy7ObNiO8GbzCeVTox34ZYQuw6JKH83/Vr+blzUBYqgICxJYu
   KanNt8vH/2ZLfUm1MZ0gO00eBRzsmCG1VgfL1oqetU57udURIJL2OOIXy
   eZgPNTzEJ9I0GbAk2EUupNx6GE++EteBipnii6rXjDOjeR8iffZ6jhPQs
   A7CTYNHsnBcHZm2k9YTUr0BuWoOXEWR4dZvQLK9wKbnzfXeB4yIucvq2H
   9ywjwvALE+jzApIG3nd+8cShURvldG5f+Syn/RpYRNgtd+GoMdusfBDVa
   w==;
X-CSE-ConnectionGUID: DnTmCs91ScaCyEBdPa63+w==
X-CSE-MsgGUID: ruF3tJcUTL2rqOS3sauYUA==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28578037"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:27:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:27942]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id 597fed03-e9ec-4700-bffb-fead9ac07d05; Wed, 16 Sep 2026 00:27:24 +0000 (UTC)
X-Farcaster-Flow-ID: 597fed03-e9ec-4700-bffb-fead9ac07d05
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 00:27:24 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Wed, 16 Sep 2026
 00:27:23 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <chenyichong@uniontech.com>,
	<andrii@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] bpftool: remove duplicate free_btf_vmlinux() definition
Date: Wed, 16 Sep 2026 00:27:18 +0000
Message-ID: <20260916002719.27379-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915235834.20559-1-surajjs@amazon.com>
References: <20260915235834.20559-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

v6.1.188 backported

  660a19e46942 ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
  [ upstream commit 66d7e39e49b0 ]

which re-adds free_btf_vmlinux(). However, the prerequisite cleanup

  52df1a8aabad ("bpftool: remove function free_btf_vmlinux()")

was never backported to 6.1.y, so the tree still carried the original
free_btf_vmlinux() definition. The backport therefore produced two
identical-signature static definitions in tools/bpf/bpftool/map.c and
the build fails:

  map.c: error: redefinition of 'free_btf_vmlinux'

Remove the stale pre-existing definition, keeping the one reintroduced
by 660a19e46942 (which also resets btf_vmlinux = NULL). This matches the
current mainline end state.

Fixes: 660a19e46942 ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
This is a stable-only fix. Mainline is not affected: 52df1a8aabad
("bpftool: remove function free_btf_vmlinux()") removed the original
definition, and 66d7e39e49b0 later re-added a single one. The duplicate
exists only in the 5.15.y and 6.1.y trees, which received the backport
of 66d7e39e49b0 without the prerequisite 52df1a8aabad. There is
therefore no single upstream commit to cite; the fix restores the
mainline end state.

 tools/bpf/bpftool/map.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index a77bf45d6f83..748b3def6b2c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -817,11 +817,6 @@ static void free_map_kv_btf(struct btf *btf)
 		btf__free(btf);
 }
 
-static void free_btf_vmlinux(void)
-{
-	btf__free(btf_vmlinux);
-}
-
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	 bool show_header)
-- 
2.47.3

