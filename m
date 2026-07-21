Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACB3BFE31
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624313; cv=none; b=YUtnEQN3VxdIrbW6EUTiYoqOJqUSPOgIRDQytxJuqhRC8XRK+p2JIGf7XQ9sivKICKqV88hJ+nOez6n/zxIKD3JFoByuHUVXfRqM/gz90MPnm1nSNVQfHP7IG7zEUowQASAhfFuoHmqyxjRoIHJz9oMwOaduUFQAZqDFxbxS5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624313; c=relaxed/simple;
	bh=MrBP0fhWHpnH+Pu7G4XRKMhBZzdvojqQh9dvIYV8Fe0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qjtZq/Ji/FB8kUMm34XIJDXqvPi5vBhpILnbDvlDg46vilZWkbUwS38Iss53JRTuz7bmJomjeJLB9CRho2NvDyG1mj9xEPYtwCRHwXiXG8ZOZ+VbLR0KRYwn8exZxffVUIJLQjwkbsV3ladIuIT0XPXyA/6xWOl14JOZvbvKQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3KxQBQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3KxQBQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FC71F000E9;
	Tue, 21 Jul 2026 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624312;
	bh=agC+Z7WBUbir3HnkUQuNY+eDBY6/ItHlhRRsIMrtXtI=;
	h=Subject:To:Cc:From:Date;
	b=d3KxQBQGCATu/46mN9aIH9udVe8xgWqU7N+/wvqnFjMdEqi0vYpJ5Hj4ne8Cbg63I
	 MG4PAwDpioUS4Uc+7ik4B465ODtyCyw5nV3c5WcTBo1sw1Fl2AhrTToYHVzywyp4zk
	 0xxZCWExVnW7jPHGw4J5uWSnRjdPASPP/QGAGjYk=
Subject: FAILED: patch "[PATCH] net/mlx5: HWS, fix matcher leak on resize target setup" failed to apply to 6.12-stable tree
To: dawei.feng@seu.edu.cn,kliteyn@nvidia.com,pabeni@redhat.com,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:58:23 +0200
Message-ID: <2026072123-treason-bush-df20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bb09d0e64ecaa0aa0f7d1133a1696ed74dead295
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072123-treason-bush-df20@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb09d0e64ecaa0aa0f7d1133a1696ed74dead295 Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Mon, 29 Jun 2026 14:40:49 +0800
Subject: [PATCH] net/mlx5: HWS, fix matcher leak on resize target setup
 failure

hws_bwc_matcher_move() allocates a replacement matcher before setting it
as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
replacement matcher is not attached anywhere and is leaked.

Fix the leak by destroying the replacement matcher before returning from
the resize-target failure path.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
mlx5 HWS-capable device to test with, no runtime testing was able to be
performed.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260629064049.3852759-1-dawei.feng@seu.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index eae02bc74221..3bcf412a08c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -205,6 +205,7 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 	ret = mlx5hws_matcher_resize_set_target(old_matcher, new_matcher);
 	if (ret) {
 		mlx5hws_err(ctx, "Rehash error: failed setting resize target\n");
+		mlx5hws_matcher_destroy(new_matcher);
 		return ret;
 	}
 

