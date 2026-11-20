Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196478;
	b=VBcwFL5coDI0YsDXmU3aak2ebU03Xp83AJn/lRReRe3PdViJolQs/cAdGH6I3CjIF6tq
	 n+KfcIq5ADFiebq8hNfVzXs5zBaHVYW6cqG3zKNZs/keZW6LCdRGfNTQdyX3HY9IuLtSd
	 pSaFLPBI2047nzHRdSYYQm7D0U7ZuEvlpT2lAPVY2D5MF1fOT4Fv36kv/7DbT0YawKoHP
	 +k9vlVoYNIY+j03h8zw6jtvysHyguJN++rPiCUwRtfUf63ZVpc5jh6sK04YtR+ZnbVyIG
	 vRSHxshCMdeh3DOkrvuEoWLi8KTg2gJ5dqJv4Ea42WVHkX+L0esrWR40VDVD67ZZ6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196478;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=y49/Crf+SDjypQqR3zzyQXujbdpIG7OI0HDN3f8+Tm8=;
	b=kDkXDhAxteMgjjQ2QqcHaUVSuDm/eXuSMmdFlqXrXtfF7u8QhFmhtHV0KzqAdf4NvQgT
	 QbW5cM5S0qZPreD8RNAENAntbq7pCV6KNSB7nIfh9BMJqhKKivUTpJ1ZzYeD7xwzIiVWH
	 layrSabjpTLy+HCdJtKKRD/F9H5ZVfQxy0gH6yl9xx4iegP6Or5LeYiqLqEtsRKzU7GJQ
	 IFY2fDZvCwyHth5W4I8xaxQUQRbSBqnvBzPkqpcZynmJSjHmRuPDeUNUbHVD2ogb04VbP
	 VIg/HICIdHD5xP+FyAhLrDELheqLqzA5VElmgsY8/4xDnQ3DnNzftF2KgMaiwX3t+qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+HC2qSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DC60A5BCF;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+HC2qSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB2A1F01563;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196478;
	bh=y49/Crf+SDjypQqR3zzyQXujbdpIG7OI0HDN3f8+Tm8=;
	h=Date:From:To:Cc:Subject:References;
	b=H+HC2qSJuDCpXhWYVyo+uEojl+HitmglDsHJ5pyvVl+tE1MNZrmBs4aZn5M5hVkwa
	 e/43UdpOXLqS/eAGS7ohABXD4fO1/zH5lOs95ZARxbmLR6ItLSYw1vUhBnzFWY6Kue
	 SZvzm07ko82m3pyJLcWyBu7B4YnNScAZs/dmtaa/8MIQm8ARb6d3HKyHcqY1hm060d
	 H1OMq0RFQ7bmALyCdjXDaQ0xP7Y9ByEkj+zuOKxdc/UaFQuGKDBU533a4AvDwf2Luv
	 QT6w5U2Kuyhqt+CrtvYP1gqnReoiZtupyLNuiCrwSiRHro2AyZCdrsXgnGK8b92UWg
	 ESUJ9de6nIF0A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbt-00000004aNj-1hs3;
	Fri, 20 Nov 2026 12:41:17 -0500
Message-ID: <20261120174117.241262344@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:09 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 17/32] tracing/user_events: Dont free an event that a dynamic event still
 references
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: David Carlier <devnexen@gmail.com>

An eprobe takes a reference on the call of the event it attaches to,
and kprobe, uprobe, fprobe and synth events all refuse to go away while
trace_event_dyn_busy() says such a reference exists. user_events never
checks it, so a user event can be freed under an eprobe:

  echo 'u:test u32 a' >> dynamic_events
  echo 'e:ep user_events/test a=$a' >> dynamic_events
  echo '-:user_events/test u32 a' >> dynamic_events
  echo '-:eprobes/ep' >> dynamic_events

The last write drops the reference on the freed call.

If the last fd of a non-persistent event closes while such a reference
is held, the delayed destroy now fails. Mark the event persistent then,
so it can still be deleted once the reference is gone instead of being
leaked.

Return -EBUSY from destroy_user_event() in that case.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261031212453.16116-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..ea6a20a30cf5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -256,6 +256,11 @@ static void delayed_destroy_user_event(struct work_struct *work)
 		 * attempt to delete it later.
 		 */
 		pr_warn("user_events: Unable to delete event\n");
+		/*
+		 * Keep it as persistent so it can be still deleted
+		 * since nobody own this event
+		 */
+		user->reg_flags |= USER_EVENT_REG_PERSIST;
 		refcount_set(&user->refcnt, 1);
 	}
 out:
@@ -1506,6 +1511,10 @@ static int destroy_user_event(struct user_event *user)
 
 	lockdep_assert_held(&event_mutex);
 
+	/* If there is a reference to a dynamic event */
+	if (trace_event_dyn_busy(&user->call))
+		return -EBUSY;
+
 	/*
 	 * Detach the fields before removing the call. Removing the event
 	 * frees the field list memory (trace_destroy_fields() is run on
-- 
2.53.0
