Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7C45000;
	Wed, 16 Sep 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518446; cv=none; b=UNQYuo//VtTQIuDcHKHmi+hACgJuGx6kXK9MqdcDJlfojxJTtsvE0fFDL5gw41MDQw18s5JcPUbLpu1MFN8J2Mpl6qoQVgLeVODMB1mrhOxVqstOL9hzUtilydhpGOAgaHTCYTEcuH4nLwfu5cbWZTuw5Mru2Z34sjDxP8csd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518446; c=relaxed/simple;
	bh=9DiO8DC8YiipsoBzfO0djsTPM8Ohq+uD8FuBud+YRoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbsXXrzHpL1x/38awf2sBx0inNTXlOt3xgS5oJaa2pQWHqaaoKRMtW8SS7Eny0y0Bspcu+azq5ml5b70N6Pp+P1qToJX2A1ds1fmizb/VA4I2oxB11EkBacdA8flqUbJx6MsgHNDRMYrcSuJMnrsyD4t+6Oic7oaMY+nNVXNBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XLcAfhK2; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XLcAfhK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789518445; x=1821054445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZU4oGgJZoW0Mzt4cLDg/JTRPZE3J3gFucIQkBM7X9M=;
  b=XLcAfhK2TRch5WtasZJrDBL5nvCL9XVSvgQ4PZddu65U0Zg2pLr4owjT
   Wt90QRobcRM0OPaZReFSaeJ39CSoqHicw6z2a7pPUA2IEO3HCh/p3nBNi
   QZ7lJ1XiNyZoZ4J7FGbRvX/1yWohztuB9kPJba+BYs5GYDA7WmWwvitCG
   odN9e/KeiEweqfvoJzxCKJEpjZloCJZ0d80PSeGQA91nMuoAOtpE/XbVq
   I/tOmoUrwP5vwcFCT3rM6zoEiIA3ikAnLMNzXuKoKQscj7YDM4YoAeuo3
   kc5gOvsT/J+psN06R9aC8TBOtaBAKZfckvknf+UQ5+ed9af0lfhCR073g
   Q==;
X-CSE-ConnectionGUID: rfe7VsDoQWCX8QzUShGfVw==
X-CSE-MsgGUID: SaOB0e4RQhG8VEFS6Mi2hQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28542908"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:27:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:27942]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id 68c87c4a-8c2b-4f6e-b1d1-4aeb7d35ebab; Wed, 16 Sep 2026 00:27:24 +0000 (UTC)
X-Farcaster-Flow-ID: 68c87c4a-8c2b-4f6e-b1d1-4aeb7d35ebab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 00:27:24 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Wed, 16 Sep 2026
 00:27:24 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <chenyichong@uniontech.com>,
	<andrii@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.15.y] bpftool: remove duplicate free_btf_vmlinux() definition
Date: Wed, 16 Sep 2026 00:27:19 +0000
Message-ID: <20260916002719.27379-2-surajjs@amazon.com>
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

v5.15.221 backported

  a9e2496111aa ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
  [ upstream commit 66d7e39e49b0 ]

which re-adds free_btf_vmlinux(). However, the prerequisite cleanup

  52df1a8aabad ("bpftool: remove function free_btf_vmlinux()")

was never backported to 5.15.y, so the tree still carried the original
free_btf_vmlinux() definition. The backport therefore produced two
identical-signature static definitions in tools/bpf/bpftool/map.c and
the build fails:

  map.c: error: redefinition of 'free_btf_vmlinux'

Remove the stale pre-existing definition, keeping the one reintroduced
by a9e2496111aa (which also resets btf_vmlinux = NULL). This matches the
current mainline end state.

Fixes: a9e2496111aa ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
This is a stable-only fix. Mainline is not affected: 52df1a8aabad
("bpftool: remove function free_btf_vmlinux()") removed the original
definition, and 66d7e39e49b0 later re-added a single one. The duplicate
exists only in the 5.15.y and 6.1.y trees, which received the backport
of 66d7e39e49b0 without the prerequisite 52df1a8aabad. There is
therefore no single upstream commit to cite; the fix restores the
mainline end state.

 tools/bpf/bpftool/map.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index cf257da20195..54d855ac5408 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -828,12 +828,6 @@ static void free_map_kv_btf(struct btf *btf)
 		btf__free(btf);
 }
 
-static void free_btf_vmlinux(void)
-{
-	if (!libbpf_get_error(btf_vmlinux))
-		btf__free(btf_vmlinux);
-}
-
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	 bool show_header)
-- 
2.47.3

