Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196476;
	b=Ru+iGyRBHVsf0Glp/w4F0ozToh4DjDYS5y3ASSSwywJY30UBOW76YZaJw9HmkUricj01
	 qQOAKdJB5EWC3JaXvqRMScBYByeAZqIR0gGTyAiYTWWM8z0X1Nh139LEXNmyKOZ5d2/CD
	 +sBwbuNiyk+K/vkbnxZA3Urovtp8t5Gj5BnQUW27xOJVmCuX/NaIVs71MnuZ3pMMksclV
	 EZZ26bt3G4VTHKiUAhNPaSdoHbUcSIn901Y6yRaI+nCpHOXKz46+3g9NXYBcEwbrbNgqz
	 jm2MmUcdoIifqUaZ3f7Kuy+8VflfOCh/namMJYe5UURJmGuk1FIrJ62WgGGZ4fcznkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196476;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=m2PcBLDLD5ZZLl6H28kWSWfz+4CGzRjCH6p4VGFL04s=;
	b=TWBls84PTsB57liXFHKZmgiUBMR4zgowVmrv5sFhS5DVsJEimMPLA5WsD4XaJrMiWyiX
	 r7r8eRLkH+CYbax+NZfFMTc5/P2sphvFim0ABP92XOJqX46gsCsfvEj7ONwiKF20bq9xq
	 Lxq+DMICD3HVovV/gUAnvQ/Ou5YRUfeYowc09diOYbcektulelK5z4Cd8HDteDAcGzqvm
	 vA1brLxBykBYAYewmyTB0eWnU7DWgX3RL6xtrJPI9OTkA8MJ7Wc2ZrVyiyLeq/JwFBVQi
	 6LlBq9u0MifUodWy6czQZN5N1uvZbHPoccYnL4/9/BrVLK5KzCDJ1bcpHUm0gpJle0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtTNf9Bp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71CB60A2636;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtTNf9Bp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9BF1F0156D;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196476;
	bh=m2PcBLDLD5ZZLl6H28kWSWfz+4CGzRjCH6p4VGFL04s=;
	h=Date:From:To:Cc:Subject:References;
	b=GtTNf9BpdcMU65yYqbJNmc7LTD6aTxOeF0i19BaVnA0v77fa9fw2ppsdlJu3Nv4b6
	 rkA4FfTMxV+cH0RF4rci543SfOF5XZtL0NKszqR22nakhUKdePp3Bw56PzMORZQsQO
	 pkRfVuqC38L7FtgeadPDKkMlHZSevblKaovVQR66Tsl+qKut6/VnrXi9R+VMDQWUUM
	 l4rBPid83ZMgLVBCF/2b2t3KsOsxrdAc3/Ok2lqdwYzPdz4c7tTL1ImCnlb3wBtkGf
	 XRXhGdW3cvYKOzd0Ou6NPqdbJIjO3anTaaxBPhxnKMeEAnQxBFFMU+jR+d9AK9pZ96
	 l2mDA4DRKr3dA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbr-00000004aJE-3txy;
	Fri, 20 Nov 2026 12:41:15 -0500
Message-ID: <20261120174115.769874972@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:01 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 09/32] tracing/filters: Handle out-of-range CPU for OP_NE in cpumask
 comparison
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In filter_pred_##size##_cpumask(), if the event's scalar CPU value is
out of range (cpu >= nr_cpu_ids), it unconditionally returns 0.

However, if the predicate operation is OP_NE (e.g., field != CPUS{0,1}),
an out-of-range CPU cannot match any valid CPU in the user-provided
cpumask and the condition is satisfied. Returning 0 produces a false
negative.

Return "pred->op == OP_NE" instead of 0 when cpu >= nr_cpu_ids.

Cc: stable@vger.kernel.org
Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
Link: https://patch.msgid.link/179323787340.740114.14434420599496956193.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d2069ef554d6..1b960cfdc69d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -758,7 +758,7 @@ static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
 	unsigned int cpu = *addr;						\
 										\
 	if (cpu >= nr_cpu_ids)							\
-		return 0;							\
+		return pred->op == OP_NE;					\
 										\
 	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
 }
-- 
2.53.0
