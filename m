Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1634657F2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195230; cv=none; b=PAV3efd76hpSeXhSxIzudNAtMYevqoQ+F/Jo36qic+Gi00k3bGOIDfNRw/0A82+1hYbKniAIz/o4Cu5O21R/g1vKYwTNIqkxXbYfw0X5a+NYT4JZBl8Yv3BiYthXVRmLYyWiu2WZ6MszONYfiywa08f37LprsM3PkqwYsb4BicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195230; c=relaxed/simple;
	bh=mh2gqleXEi7Y5D0XVIi4Ok8knfL8wf8EX0ktbvOaihM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HXja+faAqURjDRuK3V3YRmT1mV2czZfQqz2DUgl7DJQKR4n0CCdaP4alZOE/c0pwXS0pmp2bTzydhFF18skA5WxSRvy0fyaQdv6unaknh8uuNTym7HT+AoYyT5FLY3ppyOqJJD6PuqrV7ltEiSOaVj2tBW30QuqP7oHCGXTz9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/KBTdAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/KBTdAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE92C1F000FF;
	Mon,  5 Oct 2026 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195229;
	bh=JY7TOsQMWhOSUA3+j7PwDmCG+lyBKC85QfFIofUBpz4=;
	h=Subject:To:Cc:From:Date;
	b=f/KBTdAWF4NbeoVHmAiHFlxTvMPgCg0oUS6UI1fRDheT6oIRRiGyEE0Woer9VNwyT
	 6112uk65f645+2VkgBlV3Dzo1ojzqvtJKhjSaNT3IDyDi/d5ndox5O2Fc58iWKthcB
	 zy45jXbeuZavQVO2OU8+uYk7YIZeoKDeDzxQQ8HY=
Subject: FAILED: patch "[PATCH] perf: Require kernel access for text poke events" failed to apply to 5.10-stable tree
To: zcliangcn@gmail.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:13:18 +0200
Message-ID: <2026100518-claim-liftoff-8d9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 357e8a77a501d96c9517f01f4a211eed5e9c9184
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100518-claim-liftoff-8d9a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 357e8a77a501d96c9517f01f4a211eed5e9c9184 Mon Sep 17 00:00:00 2001
From: Zhengchuan Liang <zcliangcn@gmail.com>
Date: Mon, 28 Sep 2026 10:59:35 -0700
Subject: [PATCH] perf: Require kernel access for text poke events

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3aa223595e7d..7846d70be57f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13906,7 +13906,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();

