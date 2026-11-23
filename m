Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445733;
	b=WueVqT3LenPzR5MfABJJjrWbmLAdEyMNksFTigwBF80zvMzlMUbFjfEjvQdMa9+vbXYS
	 vgNzEl1bpNsl3+QWF3hHV7kYudv6qKjXDzLx8D+le8/enSjmYos5E/gPxiQDOSpVXAYYQ
	 QoPAKKlnsapuhkeHKb+ku5bGb1HmZagVkuHx2/NLcnGoCik1HQ6BbaV0mUp34ABJ6O88m
	 mB+6BWGxx5XcyHvosNNcEDKNBFphgFszWkcfQcKn5WXD7wK6QQocRUjyWqd15Z6vLYAxM
	 YZ1MaQIi2pk0JXeFiilo8ry53XFTFsyuf7F6H/DPcMQaXb/mAXMKF4+KEK47dhEWskg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
	b=4u4Mm2RH0rNpAsQN5NYnpcEHyKHjIAArOnOnY3WJgLZRnHmppnKDABxEpF5Ce7wmKcrz
	 usdflK1iNpZ0+KEAisvV7/3q1qx7uuIdAGsqvuFSd9BFbrwwPX8KLIo9PyWf/axTy2ebg
	 wUak2/8PcTzMGK42y4aHlXh6hS5wA+Zf4fA1bDh4rYp/NlQgIT1Bx16pUhDk6djATvm6D
	 P99E2zCmcz5AfIPQRVJ/D/FfoiVayg1JQhYojwXA3bd3UgcsRnlLvdwdg4dYEvEJ7CffO
	 bxKyjAmMdnZdcTVzg1OE3khhyYZ+QRllF6cQFHWwCSIkCSWXTIq+8bq1xEnvsKy3NiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLZgdLRB;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721D606A6A9
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B721D606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLZgdLRB
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so1624967a12.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445732; x=1796050532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
        b=xLZgdLRBDIuCGtdRIxV+Ip/iCWMiu1iEmSDQrTS5X5hBRkKQQ/+cg0fnhAWJ3yKHf/
         kY1UGUzVBZQn0Jzng9r36P5ttTSpUya/rHIRBjaLmBFew7lNr7EAO5PYs1lxMCvXqOdC
         WK+DlLcbS5cT3Bh/TOk+mGXUGwmQsgk3XUfIQJ4iNKrwsluFO2QSqGk6uUofRhi53sAI
         XAfIdzVaFaQjIjGJ8oMnGsME49XAfDy4XNKkGCMJahLRuqnn+R5oLbwHFfE35rTXqOTX
         No9eLEuoonB42yyxGnk4YOkXXsikY8zsDCHFjy4J59ioH3fS2o29i600pi34XlIko2DZ
         wQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445732; x=1796050532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
        b=mdo2xvx2MKnvSIS+xLMg4Xgsz6KpXFtmpL8dek03kivD1iMy1nFmChxQQVODPR3oXS
         98YWvU6t7jFdOycxl+b4sjfyaI3whG1cpVxw1J0FrualcFr7g8z5Eousw0Ne6njkUeFL
         U6bJHOsrCWaoHeOxAKbN5tkF4ioOur1YTfPtYsnrHuOP0k3Vl9dRb56AesyIiB2E9krk
         LEKilKudV0ad6aJdrlzXwmpgCHfCGMjaUVBed0zdOEGbQCi4d16bdiijnwqYsI9XZKxO
         36/B7aH3PhhrxuxA9HHCGk2QJ1K5bzYRkc9+WVFoZj+RS6m8R2bHQ2V840StOFlfKhG4
         VS5w==
X-Forwarded-Encrypted: i=1; AL+hErFC7c4f9SefJuiDxCa4YgJhkyY7cEMrNUvUtgddlVcPWJgB9enyqbPeMMHypPkbXE22pqfxxTQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hWr1mXoihI9hqGeqCRb3hGRKxVeiJdA/o25Mal3kTaNqzqbfq
	f4SzN3Fx2Vo8FtXbdqup4KzKr0hd7IQbVrwND2vYM+IYttTy1IUsfX/e
X-Gm-Gg: AZFdTZeLwL2i3eWVeFdCaFBKHDmcji7Kft3mOCQAn9IW2ZeGVaVsMzr6enNtXu2uGOo
	foLCPxvdpLHJSzg52NjNkWRh6TPjlhuugMvoSaizGLH14wDddNzIE5z4tTMPdxRaRnWpgg94LZ/
	+ZzSwDsPe3eY+gp9pVpdDIWIpa7SwjFLgz6RQPRa8IijMzNU6yLMoX0B5qSNp151k1+DSfT5qVE
	kLWYMj6UXczePkxlv6nWoD8C5y0UYrHWavVIPTXRWLQtLwoNacnFV5bG+b6XdfMVtNnNYWA+h01
	9OFxeqxZc0I4DuHxATZVYjgyhDcwco1hHRJ8cqK3i4/RldkbdkiK9jpu9px0ZgxbAqCdKwDOnFe
	UJhpNXfLHXx4EmY/DoUD0uxDjTFGGsODEgeMX7Vo9HtbO3s0U1fdYkK5T78/OvpwWBM2ARPSIyz
	3SQHZFoFjraOpVN5hlrAUDu5fW0Og5bb0EocK4fOB1RtTGUR9SR627OC+JS0CamvD22sK8x5IEZ
	vL/3OGs1VINQrgjeztk27mer0XsUdnswW6OAvw9PKSY4GTgyUatG96b9FAhtuud9iNed85JJeSn
	QI/8CxsFM9Hm8jlXdAocC/Ns368fEZv+YPyVSEhzhC75KOl4r2jSDJCQ+CHP4HiZvCzk8YlTRLO
	sJilDcNLZNvqh5a8cEMbfZi1BB/8q2ZR0Q6i/TUatSRTHvJbfsM/BNhw=
X-Received: by 2002:a17:90b:3f0e:b0:3b3:b6c3:ff5b with SMTP id 98e67ed59e1d1-3b41c9059e1mr10329390a91.36.1795445731883;
        Mon, 23 Nov 2026 06:55:31 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-82-37.dynamic-ip.hinet.net. [1.164.82.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfcadffsm5405516a12.9.2026.11.23.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:55:31 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	stable@vger.kernel.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't request private stacks the JIT can't provide
Date: Mon, 23 Nov 2026 22:54:51 +0800
Message-ID: <20261123145450.12725-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4f8b122848db ("sched_ext: Add basic building blocks for
nested sub-scheduler dispatching"), bpf_scx_check_member() requests a
private stack for ops.dispatch(), and later also for ops.sub_caps_updated(),
whenever CONFIG_EXT_SUB_SCHED is set, which is the default.

The verifier fails the load with -EACCES if the JIT doesn't support
private stacks, so on architectures whose JIT doesn't, like riscv64,
no BPF scheduler that implements ops.dispatch() can be loaded.

The private stack is only needed when these operations nest, which only
happens with sub-schedulers. Don't request it if the JIT can't provide
it, and refuse to attach sub-schedulers in that case. Root schedulers
then load as they did before sub-scheduler support was added.

Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
Link: https://lore.kernel.org/all/20260810031418.95364-1-rgbi3307@gmail.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
On riscv64 in QEMU (-M virt) running for-7.4-fixes,

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # ./scx_simple

  libbpf: prog 'simple_dispatch': BPF program load failed: -EACCES
  libbpf: prog 'simple_dispatch': -- BEGIN PROG LOAD LOG --
  Private stack not supported by jit

With it, scx_simple loads and runs.

 kernel/sched/ext/ext.c | 3 +++
 kernel/sched/ext/sub.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..3248ed57c2bb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9294,6 +9294,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	 * sub-scheds and sub-scheds themselves but I don't know how to access
 	 * struct_ops from here.
 	 */
+	if (!bpf_jit_supports_private_stack())
+		return 0;
+
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, dispatch):
 		prog->aux->priv_stack_requested = true;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d2a20114eaa2..7c069a289766 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2246,6 +2246,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		goto out_unlock;
 	}
 
+	/* nesting ops need private stacks, see bpf_scx_check_member() */
+	if (!bpf_jit_supports_private_stack()) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	cgrp = cgroup_get_from_id(ops->sub_cgroup_id);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
-- 
2.56.0

