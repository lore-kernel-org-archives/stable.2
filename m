Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595C3ED3BC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533640; cv=none; b=bq6NrUef/vvJ/xVT7fKzZfzZvm3RsmZWSQhZtvSWooi5XmDQPPxErtQhQ3hGXPxrI1DLIhaVUqlE1rmGsqTgtMn37lXkOW6WgyBUgky5jWpHEtAuf3doXjrI62zGz7LTQcgJtGqQwQbpZYVVv8ncVSDD9nh6LQmTkJyCmR5G9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533640; c=relaxed/simple;
	bh=W613WYRcTGVjWg7HGGBevYBG8FLJIeuGAk/PTVRupTQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uh29kiihCEzdb3t+y23pfkpfN0DTAf3jeUmqO7MAbohinn7roUFQ5B2JAXTEVa430QQeDFRT5c3tu1hOPcUbynOacLHmgPM6VFucogWjeSZK33+/k72mPM9LZR8UgMaa9XLqiQpzX/ltQUtFos1FThPxiSgbVrno1NPKCFyHKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6p5gznF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6p5gznF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A01D1F000E9;
	Mon, 15 Jun 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533639;
	bh=dsLOJzEbb4bMr5Qn8HJmBS4Z2gjnDRTazH5Hw2x798w=;
	h=Subject:To:Cc:From:Date;
	b=c6p5gznFxs3CtkSOPYbrHttsZJ2E6pWg+8iQDwbO+r8F1qhSqaYged/kvneYQFBcl
	 SRv14x7f4lmLPC7smcXeHQrGLScds2cm9LTVdMEQdFV4AVOscfOOZqxEH7QOYJCipg
	 HDlObmslZgK6R8aPUnMTR07xmPvyfldRXHnL1UAY=
Subject: FAILED: patch "[PATCH] selftests: mptcp: add test for extra_subflows underflow on" failed to apply to 6.1-stable tree
To: cuitao@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:26:08 +0200
Message-ID: <2026061508-freeway-cruelly-dade@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 06fd2bec7aebf393288e4b78924482fe170caabc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061508-freeway-cruelly-dade@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06fd2bec7aebf393288e4b78924482fe170caabc Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Tue, 2 Jun 2026 22:14:13 +1000
Subject: [PATCH] selftests: mptcp: add test for extra_subflows underflow on
 userspace PM

Add a test to verify that when userspace PM fails to create a subflow
(e.g. using an unreachable address), the extra_subflows counter is not
decremented below zero.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-6-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5acd12021e6e..4b3f71e66609 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4100,6 +4100,10 @@ userspace_tests()
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
+		# check counters are not affected by errors at creation time
+		userspace_pm_add_sf $ns2 10.0.12.2 10 2>/dev/null
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi

