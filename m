Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9263ED5BE
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287115; cv=none; b=SJXDvh4yDhK221kakGcwxWibmt00+1P7p8uctWk/BCBtyc95YNTM22Rk+9u+17G/vdTk2U/J56eD7E1dehZuhkaSbKwcqRtSjSew1EIwl/Fwr3r+py/+9Dqhn22awJiv/thjNeakfXMBn33Ux0EA7GShm1B4H9fuXVsq2jW0y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287115; c=relaxed/simple;
	bh=6eA+q2btWZI099dO3eEb1pPh+LUHvdLO6H+au8NGzM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO1RwAKsV2xg/SqHjLZC5hI+e93PfQObWU0aWd2kF6Mmd2UCt/d9U6dSQeVa46ZSnB86Cj+k0UpRHDlLeudSrVKtKj76JRIaszktnVzAdJ0MAfdBrSrWTG8t9jHnT64IftqJKmYCOB226rmwpGUniKvX4VtLys9Dl9+HNKZHZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9tYdMms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9tYdMms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1391F000E9;
	Fri, 17 Jul 2026 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287106;
	bh=vLhcV6BTOw9+o0Um36+dol59EOvF0zUQHjzJRduILKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9tYdMmsRzRr48GOblHU+bc0i5OmU5l7RP0NOda8utx5tBU4jPs6jB3rMeeoqG6X8
	 hb/w1yrngIXTQJuewMUCHxTz+wkkTyvfopvKQH+b1DBdE2/S5xa/Uh5WMh0/v8eNbX
	 DuUrKnmYW3ZEJPUPeghh9dpmPDEm/24QDULX+mhFVS+1EAdqRUVmHAHORuhhvxGuDu
	 qmaN449hNAtdCxkH5aKZ9cTrcu231v1/G2Pyt421fzEZx/PLJO/T8ocXQxLpLoVMiJ
	 Vo28LkZbKFsSK+Q41pDRU9gaoDI6hUKgY/iFiXy/xrisChPiddRNp5o+NKRDLsFID1
	 41BePtzUtdIqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Zhangjin Wu <falcon@tinylab.org>,
	Willy Tarreau <w@1wt.eu>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] proc: use generic setattr() for /proc/$PID/net
Date: Fri, 17 Jul 2026 07:18:19 -0400
Message-ID: <20260717111823.1573608-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071447-aviator-cresting-b224@gregkh>
References: <2026071447-aviator-cresting-b224@gregkh>
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
index 856839b8ae8b7e..78fac121d8ff46 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -321,6 +321,7 @@ static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
+	.setattr        = proc_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

