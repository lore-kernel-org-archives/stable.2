Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FB2E7F20;
	Mon, 12 Oct 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787986; cv=none; b=NfVSV/XP/qZdCALiyX+xGFoW9VzG8TZU1hutEbOv7RsiaEOy6ksGyoJaYtqBBhJSb/Xmwp/G/eEYu00rUEhgkbo2kmqpY4Gj1o0BjB6dpsPDQkk4NvcYQCGhcDasxaIViQCnQq3MiiKpMY48VDAxudb5bMKgbgPhUKFglXvWuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787986; c=relaxed/simple;
	bh=ZsUjgo0WlY+H61lQ311ZjHzAJQeqGUjjQXwIHxUSB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDJscW2F49XNyd93u0hwJqR74QL/jVNgKvzMGLPdXPPqRiW8FhXWk/cjI606Lhs+gDBQuuJ4qCA/rHGy768P1a8uoHvurZ0NuhT8n1YHKeGSdWgg9GwI6aDjYknKxVjLC6uvvUfKIH1a0Qx3QJjjDj6BsVmTNwBgdtWoUjZwIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M0HVyQ7B; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M0HVyQ7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Df
	J1McAY2jEIEEvSf3XwJXhUslP4ugRJIclsZHeut+g=; b=M0HVyQ7BitNXjKCqtZ
	F0XGid2VFLWmRzj5eE/UZ6/fcLBx1ccrVt8pKrowbYp99owYtc6bTgwQZAkL6czM
	WtAIPly/4vrBeZ5xGgABHnWXdAqGNTZOtAhEue6OJUFxiLaJqRJ5BN+LMyaOy5j7
	ecUqPTGbxXDUCVSlTy0BVS2AM=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnT0dig8xq4PyMEA--.52573S2;
	Mon, 12 Oct 2026 14:51:16 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sh_def@163.com,
	stable@vger.kernel.org
Subject: [PATCH 0/2] sched_ext: Honor SCX_PICK_IDLE_CORE in CPU selection shortcuts
Date: Mon, 12 Oct 2026 15:51:12 +0900
Message-ID: <20261012065114.3516902-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnT0dig8xq4PyMEA--.52573S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13tryrZFy5JFWDCrWxZwb_yoW8XrWrpa
	90va1Y9r1qyF42yw43Jr4UXry3uF4rC3y3JF1fGFn0kFZ8KF48tFZa9F17ZryUCF95urya
	9F40grsxCay3ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piUGYdUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQTHJ2rMg2RGOgAA3Y

The restricted select_cpu kfunc path and the normal WAKE_SYNC shortcuts can
bypass SCX_PICK_IDLE_CORE on SMT systems. The first patch skips the WAKE_SYNC
shortcuts when strict-core selection is requested and validates restricted
candidates against their idle SMT mask. The second patch covers the restricted
path and both WAKE_SYNC shortcuts while retaining the generic smoke test when
no SMT pair is available.

This series is based on:

  [PATCH v3] sched_ext: idle: Respect task affinity in restricted CPU selection
  https://lore.kernel.org/lkml/20261011173100.2090211-1-sh_def@163.com/

Testing:
- x86_64 KVM/QEMU: all three restricted/WAKE_SYNC differential cases
  reproduced the strict-core violation before the fix and returned -EBUSY
  after it.
- The sched_ext selftests passed apart from an unrelated dsp_local_on
  environment failure while opening system Kconfig.
- The strict-core test passed 50 consecutive runs; non-SMT coverage retained
  the generic smoke test and skipped the SMT-specific cases.

Hui Su (2):
  sched_ext: idle: Honor SCX_PICK_IDLE_CORE in CPU selection shortcuts
  selftests/sched_ext: Cover strict-core CPU selection shortcuts

 kernel/sched/ext/idle.c                       |   6 +-
 .../selftests/sched_ext/allowed_cpus.bpf.c    |  36 +-
 .../selftests/sched_ext/allowed_cpus.c        | 316 +++++++++++++++++-
 3 files changed, 347 insertions(+), 11 deletions(-)


base-commit: 9a2d086eba0f331eb5940d6a91efa7caa39080ad
-- 
2.55.0

