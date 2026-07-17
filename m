Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915D36E460
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306304; cv=none; b=LZNNT4KJ061fTyU2TCJuEL08wJf0fA2iyr0UjFI6erUOYG5jeJjtC39lyVL2EyWeC+cU2rBylQ143y6GtFRjAe5A5jMf2D5tabKfEcaDhQZVIaHntD1Z4qrnZdpqLQmujnkmk2QfzkNGm67CsTVZJPXHipB+bL8KQOVEB6RjvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306304; c=relaxed/simple;
	bh=nV4UbN97uzHCnTUXZBgwQ5NzmhjtXjruTUCE0lwQg9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOD+XBqUUQ798vxBJwBrpeZ4K44fY7Z1dgSBx01FitQ8Mhonmf/DKR19rTgarBsKvbNM7fXveUDBR27G8YZlQ3vbX30O4WuYm0dIiNFzcWvSXYdGoZFK6Rv7a9IOpgKb+q0xW+5ukh+rYqAaEDt7OyfmPCNh0xiitgFnFQpoRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdZG19qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdZG19qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F7B1F000E9;
	Fri, 17 Jul 2026 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306303;
	bh=YsVeeMNVksn8hcTPfweB7vfoVmo/sGJHKo+Fm32pUJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdZG19qo/S1xYN7vR7KgPtUHcRMEMGqZSV/7hpM/k7eSzaHVUEuzupr7gE80Eoub8
	 T3HDLP1Va8gCm4KWaDy07VvqRJBzy1jaV4YSbIc2ZdjkFF7RX0InF3us0fZ/Swq7Nw
	 o4iNm37dYGABGUvPn3Ndx3CtmgOqGq5hTfOE/KESDF+uZ11f51uMQdhHF+anZbf091
	 Pd6P56010TnCoQzvI+GKTGU++RFtpKNaygSgW+UlfWq+3bKJWFqUrAzkP1MGPEhSvk
	 CXj0mgeqRqf9/aJIyp7kfd/T1GzYDl3FPy8YPAjMBp0rg458za1B/yRnbyoG/vefoc
	 z0XEfdfEzGLww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Zhangjin Wu <falcon@tinylab.org>,
	Willy Tarreau <w@1wt.eu>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] proc: use generic setattr() for /proc/$PID/net
Date: Fri, 17 Jul 2026 12:38:19 -0400
Message-ID: <20260717163821.2035203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071447-magnesium-aghast-e41f@gregkh>
References: <2026071447-magnesium-aghast-e41f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 18e66ae67673f2c8df6f02428798b1355691f2a9 ]

All other files in /proc/$PID/ use proc_setattr().

Not using it allows the usage of chmod() on /proc/$PID/net, even on
other processes owned by the same user.
The same would probably also be true for other attributes to be changed.

As this technically represents an ABI change it is not marked for
stable so any unlikely regressions are caught during a full release cycle.

Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (v3)")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/d0d111ef-edae-4760-83fb-36db84278da1@t-8ch.de/
Fixes: b4844fa0bdb4 ("selftests/nolibc: implement a few tests for various syscalls")
Tested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Message-Id: <20230624-proc-net-setattr-v1-2-73176812adee@weissschuh.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/proc_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 707477e27f8317..b15b43d97dc9ed 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -310,6 +310,7 @@ static int proc_tgid_net_getattr(const struct path *path, struct kstat *stat,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
+	.setattr        = proc_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

