Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D93515D0;
	Tue, 15 Sep 2026 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516720; cv=none; b=mNN+A7CLIUrtSo7wNNxOjXuyuXUfn9Vl7IuleBXhgGw0EpV8AYQ1RVqJikUDQ/ge1ttX+m/5eIH6HBfrukflSKRKam2aWNT54BNjlzwCKJl5YXt6JFCJvZU7fUanGtWpQp5JKuSakZMEX/tPflTpkD1RhMLwm6d/cU9izjLuspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516720; c=relaxed/simple;
	bh=DCvst1yYbdhpjU7c/fmVI2EYWBw5faQnvtGB/RGBgQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gB0Ww59dO4fi6D6Bb+ojcpk+rcdvrAgT37/lMmf9m2/EbnVqrofq5ACiw/UyUo2iBNE9X4LoFv9lrKosokZuzyLxAbOqTQOxzPDq50PLv1oEd/nyLz/rVMg2JTPFOZfkHuiAqlJ8HgHZGd8OHOoLbkfPr5DWZmo+4I7wXONrmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mBVtjrbh; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mBVtjrbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789516718; x=1821052718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odap5gdV04/t27HraMBx8bD0KEBu67w6nTFvWHfmhCA=;
  b=mBVtjrbhR5PioGNRrlJNElT9YQZXMBU/q+mPv3PUIopssizOpEDB9mIC
   P/uZCWf/mmo1aSwMbUjk2YoV1odDKo3LCkBQaXygm6xj/0+nKrsJm+Nic
   edca3W7GZpFrmEUG8Ws3xsYvUNNK/twxt2Ob8UF07aE6dYv1zxlWrBRMb
   d2oS0wO3KHMBXiOo5f2A2cY33gVee3y7D6YHyogveoCr7pM8Ik5yFP+aB
   uASQsRK5Ug8cF4p2LofPU0cc929vy/0HXPKr9gNihNyVCAY78QPu/501e
   +2DZYT+Q5yJOOSNlUeOEpDjKktIwYw6dceJuYdPRzePvVqOPnMJrEoNNL
   Q==;
X-CSE-ConnectionGUID: BXyKZk6ESEyWgZe6FrLc7g==
X-CSE-MsgGUID: GHdLMXppRBODiNyDAC1VGA==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28676298"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:58:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29530]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 7fd5a7e0-7d17-4795-9a70-a21049c45c2c; Tue, 15 Sep 2026 23:58:38 +0000 (UTC)
X-Farcaster-Flow-ID: 7fd5a7e0-7d17-4795-9a70-a21049c45c2c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Tue, 15 Sep 2026 23:58:38 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Tue, 15 Sep 2026
 23:58:37 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <chenyichong@uniontech.com>,
	<andrii@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<regressions@lists.linux.dev>
Subject: [REGRESSION] 5.15.221 & 6.1.188: bpftool: redefinition of 'free_btf_vmlinux'
Date: Tue, 15 Sep 2026 23:58:34 +0000
Message-ID: <20260915235834.20559-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Greg, all,

Building bpftool from the v6.1.188 and v5.15.221 stable tags fails with a
duplicate function definition:

  tools/bpf/bpftool/map.c: error: redefinition of 'free_btf_vmlinux'
  note: previous definition of 'free_btf_vmlinux' was here

This is a stable-only regression caused by a bad backport (the fix is
correct in mainline). It affects only the current head of each series:

  Tree     Broken      Last good
  5.15.y   v5.15.221   v5.15.220
  6.1.y    v6.1.188    v6.1.187

6.6.y, 6.12.y, 6.18.y and 7.2.y are NOT affected -- those trees already
carried free_btf_vmlinux() in its current (btf_vmlinux = NULL) form
before this cycle, so the backport deduplicated cleanly there.

Root cause
----------
In 6.1.y the backport of

  660a19e46942 ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
  [mainline 66d7e39e49b0]

*adds* a free_btf_vmlinux() definition. But 6.1.y still carried the older
definition that mainline had already removed, so the result is two
identical-signature static definitions in map.c and the build breaks.

The same happens in 5.15.221, where two commits applied in the same
release collide:

  a9e2496111aa ("tools/bpf/bpftool: Reset vmlinux BTF after map commands")
  44f58f0c5202 ("bpftool: Use libbpf_get_error() to check error")

the latter keeping the old guarded form (if (!libbpf_get_error(...)))
while the former adds the new form.

Reproducer (no kernel build / .config needed)
---------------------------------------------
  git checkout v6.1.188   # or v5.15.221
  gcc -fsyntax-only tools/bpf/bpftool/map.c \
      -Itools/bpf/bpftool -Itools/include -Itools/include/uapi \
      -Itools/lib -Itools/bpf/bpftool/../../include

  => map.c: error: redefinition of 'free_btf_vmlinux'

Suggested fix
-------------
Drop the stale pre-existing definition and keep the one introduced by the
backport (which also resets btf_vmlinux = NULL, matching mainline
66d7e39e49b0). For 6.1.y:

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

For 5.15.y the same fix applies -- remove the older
libbpf_get_error()-guarded free_btf_vmlinux() definition, keeping the
one that resets btf_vmlinux = NULL.

Happy to send this as a formal patch per-tree if you prefer.

#regzbot introduced: 660a19e46942

Thanks,
Suraj
