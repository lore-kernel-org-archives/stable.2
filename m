Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB94AAC5A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576474; cv=none; b=dZTOHT8uXuXQXp71nvqwGY/T4enCOdknmLT/I0hHu/Z1LqO6bX2EW8uISXucye5+lHZO1PXW/GygLSBvoPTtHGf8aTHeyO7yBxySdN5qdtJnMfeQ0az7bWPovihqvFggzgUFPHZl90od46JtR0GKAg/n4mHBgTo7ZYcrzJKkBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576474; c=relaxed/simple;
	bh=5c1yM0EeZUhZ6d3u9BXWlHt+4oYyXmm/oJ5daMd9zI8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L3ovlIlqogzFFDL+BGE2Eqz1+3Ej4Ghof3icsjfKxajjjjCToIfaoTv13yu1mjoFPuor2oSUCb9Pdsv4R6QQyNHsovfDT7it0qocT8O2wHbEWrs6qVKzFZeSxSv6BiIJsGfG5tgzfPktaX32SsAyng42QuHihSV9BQSV1QtrxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bI8ufjNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bI8ufjNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EE71F000FF;
	Wed, 16 Sep 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576471;
	bh=ePzb94HiMlM0JZWa6RtREALIf2UiPjvGLHT9hh3/UPY=;
	h=Subject:To:Cc:From:Date;
	b=bI8ufjNd346pwlTjCM7Pnc88ZmvZJ+0d2ASmO4wEEuf4xQmr2L6XLBirQRlbnyG8T
	 K4LWPchWnbGEK+pE1ZtYQvDGcyZ5B9XFAPRSjuaZM6rbkjxcCv0WnGU8Y24qKhXv5X
	 f8INK/hG24+VkN9o7ZHWYelxYIqgXMv8H/raocmQ=
Subject: FAILED: patch "[PATCH] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused" failed to apply to 6.18-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:31:13 +0100
Message-ID: <2026091613-definite-creation-7022@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f968190c0b42ea2004dc1426359a53ec365a7a37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091613-definite-creation-7022@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f968190c0b42ea2004dc1426359a53ec365a7a37 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 8 Sep 2026 16:07:14 +0200
Subject: [PATCH] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused

When an ADD_ADDR entry is reused, the timer is re-armed, because the
goal is to re-announce an ADD_ADDR, and eventually retransmit it if
needed.

In this case, the retransmission counter should be reset as well, so the
re-announced address gets its retransmissions back instead of relying on
what was left before, and possibly not being able to retransmit it.

Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
Cc: stable@vger.kernel.org
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-9-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c5..b0b71adefb8f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)

