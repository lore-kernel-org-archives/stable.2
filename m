Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0612BCF4C;
	Mon, 22 Jun 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146444; cv=none; b=FF8YHMGjowH1okuKao79yoYXyqGl0ZttKCxDBEIYOR+XLsi/0gMK0Gd0Dgs/2/99QMO3CmWm7fZY7Ao1gDm4HEBj8iXacEVj7XcpsuaqaEIF922Vxkq8L3DmtvQzFaQHUDwLoN48mYiP1tYbcQVX3gH8BVfKfBn4QuuwOvs3KL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146444; c=relaxed/simple;
	bh=DCP3W9YLiAc31JR3edriHXrEEtfmniauBuuh65ADoVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHSKG37GdQxJ0WNjQi8MPzQWOSl/BV/ZT4VDz9DgaugYgg9tfyZ6HuSRnihptWjtszTu2Oa9DR5VaM4305MhJLK38QquHRkbmoVdrbe0xGKp7k/vzq+R/NJHhAJs0OOzISHWiLeUVm2uXFfAfe5Mjw0XDkhoTShQMaKBTu8kRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=XI5JEL8E; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="XI5JEL8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782146439;
	bh=SRSnCm+XvgkWvcngWiaeNCja7gM8kd6UVrJXrvVEfF8=;
	h=From:To:Cc:Subject:Date:From;
	b=XI5JEL8EdY7Mcp4yP1SnriH0hpzdlBsM6mw7Ws/LPhUY3wcHCwLIXUocYDHzERzcO
	 IH8nPDtq2iTxgmebn9aVWpomaKV84CQOoXP+9iz33PDLqel9sxpO2dOiC7euWtUNlA
	 Kr/XE/KltGiPB2UNX5IErucrcXUGAbTYjz5GlVvc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkYpv6ryQz10vh;
	Mon, 22 Jun 2026 16:40:39 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkYpv1zwZz10wc;
	Mon, 22 Jun 2026 16:40:39 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	ebiederm@xmission.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH] signal: avoid shared siginfo namespace rewrites
Date: Mon, 22 Jun 2026 16:40:29 +0000
Message-ID: <20260622164029.11474-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

send_signal_locked() rewrites sender ids for the target namespace.
Group sends reuse the same siginfo, so one recipient can affect the
next.

Copy the siginfo before changing it.

Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index b9fc7be1a169..d72d9be3a992 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 int send_signal_locked(int sig, struct kernel_siginfo *info,
 		       struct task_struct *t, enum pid_type type)
 {
+	struct kernel_siginfo rewritten;
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
 
@@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
 		/* SIGKILL and SIGSTOP is special or has ids */
 		struct user_namespace *t_user_ns;
 
+		rewritten = *info;
+		info = &rewritten;
+
 		rcu_read_lock();
 		t_user_ns = task_cred_xxx(t, user_ns);
 		if (current_user_ns() != t_user_ns) {
-- 
2.53.0

