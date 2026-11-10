Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273692;
	b=dILqlxcOsw0/8nsNf+qXk0IIwTFu6IGANe7U3vAspOv5mfNqQDGf6LSeq//92XR0QfRc
	 SfHQZIKsQpN15bJHBSWho6Tzo3XOzKgOBV2Zwrau6va6oTgJH7xEWDI+oV1G4IeqzFpmX
	 rGCX8nv00YUHq74OSdAvmVMvF4he02qMoD3z+98GtE3yojMUCOx7av65dmbbiMq3li37e
	 sYKKjfVexGt9egPMoV65HpqeIO9edRFj04SJYvNGlkdBzmYi+77346+v1DAfTKQOEOkRI
	 Q8zoAHecGvojXAsy5s8Fc10D3Ui1/Istsjh45LWkP5OJKSaQ6Xpb+onm0noDz75vT6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9PC6LwOoCjhP9t8PJwVZ+cLXbaz/volTEIdy8k2ovQ8=;
	b=uzSZG0KHvfLlKTbJRbM5DnVtosF2cMHCDR/6j+3qFDbSpeS5doQyUkj+iL47ASFT1oUl
	 UnYaYe8WIJqmv1igjEV0y618ZZ4Pmr1qCY8U1+5OGuZApNzh4Gt14Xu8iZZIvo2VbMbZP
	 XhdaWe0bGc67eNmPjiE1wntrTKvKyQ/hXGjJmUJmRxIjgW61sLQWyFx9xDzd4o+qd8eT8
	 VZia3V8sFgpuD8/nVvprglliP5dnwWL0ADJt0vpblJRDf0S7DVbH4DJDgNDGQ8QpOtUIr
	 qrjWVevTzp2xwEfe7VNbwECBgkigEPmB2WNXmTjzglHYpO6ELWOOoW3hg+tQz/rS+yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH9y3nP1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH9y3nP1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A72C1F0089F;
	Tue, 10 Nov 2026 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273692;
	bh=9PC6LwOoCjhP9t8PJwVZ+cLXbaz/volTEIdy8k2ovQ8=;
	h=From:To:Cc:Subject:Date;
	b=EH9y3nP1eWh1vXSLFTjAk5xsbVOrLipIY4V5SJafkiCilQQO/ie/tgsxQA7dn/O/C
	 HKpK+UvyRejkE67B3FMgJgAU98i5ntCV4ffm6c93RkXJYWnBlKAHTgl/xjyYZ5Abll
	 ztdRbnZdBfq9kpO+a+13zfPOxTbVBYFhTEpGp8/rjSQ8F7mVTlVNQd7YZTFpIxl61H
	 BlA48MBwgTDUhOum5oEYuSsiB0GQAkRRHFdsJf4QNsHZMtqvI0YRio9RJzGDl9av1/
	 66d25MwoXvRTxFq52El6db04AxNXLfUKGeFU/ol1opYffAyY7QaFU58QdbfP2r5tqB
	 tlCFSpKGDzK0Q==
From: Sasha Levin <sashal@kernel.org>
To: q.h.hack.winter@gmail.com,
	paul@paul-moore.com,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cipso: fix optlen corruption in cipso_v4_delopt()" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:30 -0500
Message-ID: <20261109202130-failed-5.15-1f1f8e8c5176@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202130-failed-5.15-1f1f8e8c5176@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45 Mon Sep 17 00:00:00 2001
From: Qihang <q.h.hack.winter@gmail.com>
Date: Thu, 29 Oct 2026 11:39:42 +0800
Subject: [PATCH] cipso: fix optlen corruption in cipso_v4_delopt()

cipso_v4_delopt() recomputes the option length by walking the option
buffer after the CIPSO option has been moved out.  The walk then reads
the stale bytes at the tail of the buffer as option data, and a crafted
setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
length, increasing opt->opt.optlen beyond the valid option data.

The corrupted length stays on the socket and is later used as the copy
length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
where it exceeds the size of the buffers they copy into.

Compute the new length from the intact options before the move and
subtract the CIPSO length, and fill the padding with IPOPT_END.

Assisted-by: LLM
Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection endpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
---
 net/ipv4/cipso_ipv4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 1aacbbeffbc64..e65a3f29d2caf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2013,6 +2013,10 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
 
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
+		optlen_new -= cipso_len;
+
 		if (opt->opt.srr > opt->opt.cipso)
 			opt->opt.srr -= cipso_len;
 		if (opt->opt.rr > opt->opt.cipso)
@@ -2026,11 +2030,12 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
 
-		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
-							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
+
+		memset(&opt->opt.__data[optlen_new], IPOPT_END,
+		       opt->opt.optlen - optlen_new);
 	} else {
 		/* only the cipso option was present on the socket so we can
 		 * remove the entire option struct */
-- 
2.53.0




