Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4843C05D;
	Wed, 22 Jul 2026 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705958; cv=none; b=DCn06Un4hH73HhpywPFJiIz8XqSJ1LD4uWchJG0mWR1EYQe8vJ0LQQhpL+K9EN/rOVpKKCaoISMr0P6cdzgC7Yyn293HJUKPOfOJr//+j4WeuPT0I4MDuL4s6c8ZsaOc5K6SGNgj11WIi41S7eUlvlsNSC9WYkONlWJOUtlSgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705958; c=relaxed/simple;
	bh=UT3XaSA+Z239xnv71RjhwxAFh9r0SAGxoYjw/a/oL3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YS65q7dYYW7xZmmdF9nOlfSZFVOVE8qPBc7jcb9ftgWcD7s+9wnOR0It0woDZ8k8rImL0iDLzQ6BMzLHM/MxI4963/wwUVDvkbW54tRnxkgecfNd44DMrEPUQYUiW78rj09y3ucph3+v7hXCIvzNFGTXk9gKVHkHl6iUIStob5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EgrZy3M0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EgrZy3M0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784705949; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=I1fbdHIk6ozhb04sLkolar3mN1MW2fEuJ8CZh+K6syk=;
	b=EgrZy3M02xM/dAGIgumWyInrgwct3HiY8MdsH6L4XU1Nz0GrHy/aUs3uIO5Zy+4BjPtut5n4pvpQhozwZ+y/Ic1I+AY8zai5Vu2SRp+Odi2bOp/W7RVUs41hPzxHKeZO5UDqZF4DxMHpGjA0azgOR/V0G+hSK5WdkxYuXppFKTE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X7ce7yb_1784705948;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X7ce7yb_1784705948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jul 2026 15:39:09 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: daniel@iogearbox.net,
	info@starlabs.sg,
	ast@kernel.org,
	lulie@linux.alibaba.com,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.6.y/6.12.y/6.18.y 0/2] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Wed, 22 Jul 2026 15:39:06 +0800
Message-Id: <20260722073908.72382-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport of the CVE-2026-53090 fix.

  1/2 ee861486e377, the CVE fix.
  2/2 e0fcb42bc6f4, selftests for the fix.

Daniel Borkmann (2):
  bpf: Fix ld_{abs,ind} failure path analysis in subprogs
  selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs

 kernel/bpf/verifier.c                         |  17 +++
 .../selftests/bpf/progs/verifier_ld_ind.c     | 142 ++++++++++++++++++
 2 files changed, 159 insertions(+)

--
2.47.3

