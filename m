Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C841A789
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296820; cv=none; b=N1SnCLJzDmzcLHO6/tEiDbNWEANRTtS4EVhCxGCZcnArUg88MUwfHCbi4O+I4UQQoa0CC3d4OGZNHaAO+1x9ao24D/SGFkNNi7ERfBHTfpRxwM/UIEl+s4OxhCRwmJKoRJaLGps+iqWbzoCas+JU71xos1AFguE0bwH+tbf7g6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296820; c=relaxed/simple;
	bh=FcWUqCq7/zPRS6HtlsoAeH8tY2vTw43+bpQs80YahFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r30HinoZpoVkcVCJwxNmex4gEEJt+fE4cvPyERYxqaIsuISF40Pkti16ONIjfLY1Maa83fH7OW7zod7mo70PjOljeEF41MKm44Dxe3uSkYtzQyq7LFBuJr3e9eQt3yiqKrurPSboLB0lw0BhNSVblDJW1cjLkw2+hJ0i5dekx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAkPYx59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAkPYx59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D931F000E9;
	Fri, 17 Jul 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296818;
	bh=uIlQKQc/IUG2LSeWYmbIvn7WFbA2oToTRWwMLrmj4Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAkPYx595wHiGntb6MSzwj/k71/2ZqUKTIQqXBFlh7gIGkzmSvPs6x6s+xxHfbRIn
	 HokHtngBSA2/DvL1daccj8A2khu9Wyh1w9m1ZtvzOBwb39NQ5229ebWMeTRFxp/zEG
	 Wc701ZrPGtB5w+mUbOHd/DLTnbWrYs8HbwUfOdpL+5oB1CI2frYpoX1W+boXiG7X5g
	 eCAkSU/HYXHLk/kp+lJAo9m0tyXvf+3w50QuK2FoXuN7GzewLsAMO9nBGH6dQerCv0
	 4aWWEKcIePaHZ2x5E6+DEIWl2dyuj2tP3MvenBSx+qXc2MwjCK1PJCjXDCvQMk+e3O
	 LQap5/91kvQyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Zhangjin Wu <falcon@tinylab.org>,
	Willy Tarreau <w@1wt.eu>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] proc: use generic setattr() for /proc/$PID/net
Date: Fri, 17 Jul 2026 10:00:13 -0400
Message-ID: <20260717140016.1717138-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071447-twitter-wick-5966@gregkh>
References: <2026071447-twitter-wick-5966@gregkh>
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
index 123e3c9d8674b4..06ae48da253c8c 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -311,6 +311,7 @@ static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
+	.setattr        = proc_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
-- 
2.53.0

