Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785779;
	b=o9/NpunNcQlMD+d+hyAdf2YGT4ji77AO93vf3h0cS4XjB4PCu8C4y082+cFBdZsoaqhG
	 8VrqkKDKfgw4DhWwdZaDlP2iwm6ifX71QH/G3gbv5X+IMOFl/IdSsCSQcIJKN/9sR/TqQ
	 Cr+NZm+t7UQClX1Yr1tkpvMEFZQcvhaSDM77F27qHzXRv/nLoJsgxjJNQOJxbkN9ZEg8q
	 oRvTjzDqOXHzuWh7FVRh8xudKaFy17zbEgrecONpfC6llHu7M0DUxXrXqEgTmnkIp1Tfp
	 Ji2rhx00FgjBoWKpSMmBKTdMpXBtbDdd3VulETH8dKxssigGyV3KkBuJxbhRNeW5NvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Unsent:Content-Transfer-Encoding;
	bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
	b=AQ6kQ2cGKvox033vTs/HkHJTd2YX4n4Q/9Q4MhWAMdMQwvQyH37uLBmFuNgHKF/AGSiz
	 gmcSd9FGgMWU7QXPV1O2nSmCWIzIt1NE6LYMLKjVqNgqhO8qPSckh/NpwXQhY2kbfesAk
	 apk9rnhPjXNvQlKlX/FOhjp02m6lmOPGsK6tzkN5MPSouIYHdfX9FTUwzV45AfpuY2W25
	 9BKJsrPB6Ii9jIxrESaH3mif4koNepMpJxjG6dKVh52XtPVvDe855PzOqdrx2evfZeJyI
	 w3kBFgEV3h+0ZSFhHg3L1MSCI9FNpiRUyHspqRyA0QorF/XxqG98ozcT75ZuuDEA8Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TmAJ8pR8;
	arc=none smtp.remote-ip=74.125.230.201
Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51B606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B51B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TmAJ8pR8
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-934956d1044so115899285a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792785778; x=1793390578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
        b=TmAJ8pR8TcAnppZdDpMb6ouB4qgQBqJNWeQiamMrAcvfqW2akgRerpYovKNNnDP4lT
         On9QZjdzxznvO5K7okBJa3EIy+0dQT2GfXngT4Qnswc+amzxrKq+I5elTm4ClIa9pAZX
         aI7Fpin4aBft/DyyZ+G/zXDPPyZUYCVt2w/VIxDczlpHDn97M+Nz9Ui9uEYz98ArctQg
         ggFd0/230bB5kJ9zM76FEx8ql1O0Csv+w0C/dAGK5KfqhVqyMba6AtR/d582JgdmpZOH
         pKhD9hesP2t0/rL1e+zP2kyOKsz8s7PYeWNu6xB796ehbATkbBMPljRGNhdngYNLHwoY
         268w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785778; x=1793390578;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
        b=Wb38CZMyWE/ejZhe4QTl9k/hcOKz0TfYgnqib5c6kodL83GL7PPNQziBHaOdaCW5Yj
         15o5T9updlYRDWltjYkBgM8c/QUcfEZfcN1BwQ2aQKPQAOYSYukPbOkXKwXRbaBRFTzP
         Wsq4Hp6bbsTPhnj1OJ0ZyPM2ISJ9wj/Ln/KqUTYSR3+qPinHT8WnCGs8hmkt6yezlVwD
         Hv/iroTAU8juu9fHu4+/32ccTqC6YvMyxnODv1c+022i6smn+hdo2Q7ilizau0mOKhUZ
         BgcOdrc5YZLf1aHAKA6tVOGRFIspu56XJ5sqwngxudyXuICuD3KW8YT26zb5Wlu/zhVv
         Dcew==
X-Forwarded-Encrypted: i=1; AKwUvBxI+42Ndw2VSuQp8jdlZnEf5A0oIhcumr6bQbv6C2xMc+KzEfBWleQM+ZyI/NcEz/HG173uSTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYrCQkbz1w/Li0i/+MNTcKRna82ixiq8fJNOFNdRcP0RPiNphZ
	3FfZhBDqtCxSmZsVpatFXkY2NT6dX63IUeU7B/Pn9VZXnn0xzfzWS+9PQLzg87Egt8s=
X-Gm-Gg: AYBFou1PDI7AmXDF8qGKXN3LdS33aqLZqFC1bof8jdonTlztsFeurxvIBfNRfCmLUkv
	vuA2KmbK6pyJmpKapCREaU7/yy55QvOvtm0Pz1pY2h6rjC2TobgrooYKHeNYRChrGjk0Q2bqxA2
	hTIrBMq3lRcWdkQXZOqIIDM4VkvN8r/kyaAGGlglGWynzSjM6MbOB/Qqz/pbBXTBO6XJBrwq+YE
	pSC+Paixpx4npvr8BJ5WF94ZjFaaMDxxdcujR/nQE7KhgbiegP/08iIMImNIZASc3EqWGymP4Nj
	rbrV8FOnEtXGwxHlNRbJnI1dmnhtsI7+BdkLe3sNH3MJk85zG3aAxuHOrdWB+NE/jsAwTLzOn8C
	/ZujGYf3Cp5oMJpztozMjV5aGpLnhLYXQCU3sMTzvvpq6qsfl1GnwctVgeAg2N0H3W/GWf4iQU5
	J+H/tswR5mI+1yWZSGCSgpoTzv0bk0wydJblixEFkGGMSSRTQHRHgJzae+//2EZXZZG7zxKze0O
	Qkp1kLlSq17mJugqNMiZftVBd5p0pOUSeSrU6xSpxaTQgT8qO6bYRVOXapNW2GFv/T48+KFsTTp
	ocVYLI6yislQ4vUjOpvrUVq7mqkpe0Xkg53YPNvKrA==
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr18967485a.14.1792785778344;
        Fri, 23 Oct 2026 13:02:58 -0700 (PDT)
Received: from localhost ([2600:4040:2047:3600:ecc7:9b1d:4307:d6a])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9402ee285c0sm102122885a.1.2026.10.23.13.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:02:58 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Lee <david.lee@trailofbits.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: sched: prevent scheduling deactivated qdiscs
Date: Fri, 23 Oct 2026 16:02:56 -0400
Message-ID: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.54.0
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
X-Unsent: 1
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

TAPRIO can schedule a deactivated qdisc after some_qdisc_is_busy() has
reported it idle.

Commit 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
made graft deactivation skip queue reset, leaving TAPRIO's timer armed.

A late callback schedules NET_TX softirq work, whose dequeue path can
race the unlocked child-queue reset in taprio_reset(). The same skb can
be queued for deferred freeing by RTNL and dequeued for transmission.
In the reproducer, the TAP reader frees it before __rtnl_unlock() reads
its next pointer. KASAN reports a slab-use-after-free in
__rtnl_unlock+0xa3/0xd0, with a read of size 8 from the freed skb.

Reject deactivated qdiscs in __netif_schedule(). Callers' RCU protection
lets the existing grace period join earlier scheduling calls before the
busy check. Restart nonempty transmit queues on reactivation so suppressed
scheduling does not strand packets.

Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260805102514.740834-1-david.lee@trailofbits.com/
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.
Trail of Bits has a reproducer that triggers a KASAN use-after-free
and can share it if needed.


Changes in v2:
- Move the deactivation guard from TAPRIO into __netif_schedule().
- Correct Fixes to 47e8dbb6e763 and narrow the stable range to 7.1+.
- Retest with KASAN and check packet flow and temporary reactivation.

v1: https://lore.kernel.org/netdev/20260805102514.740834-1-david.lee@trailofbits.com/

 net/core/dev.c          | 3 +++
 net/sched/sch_generic.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869..bcd2d5197 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3478,6 +3478,9 @@ static void __netif_reschedule(struct Qdisc *q)
 
 void __netif_schedule(struct Qdisc *q)
 {
+	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state)))
+		return;
+
 	/* If q->defer_list is not empty, at least one thread is
 	 * in __dev_xmit_skb() before llist_del_all(&q->defer_list).
 	 * This thread will attempt to run the queue.
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5..bff425a14 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1280,6 +1280,10 @@ static void transition_one_qdisc(struct net_device *dev,
 	if (need_watchdog_p) {
 		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
+
+		/* Resume backlog left by a suppressed schedule while deactivated. */
+		if (!qdisc_is_empty(new_qdisc))
+			netif_schedule_queue(dev_queue);
 	}
 }
 
