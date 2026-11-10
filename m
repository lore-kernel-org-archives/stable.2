Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273100;
	b=C2d2nh4iJMtjeuoxQEUsHi801sBC3xn6CNw0LrfKC0XIc2SjuEaL8sDi8H8jPCpe0Sxs
	 lnTEc9h0/WsdFcF5Sag1ZQQTSXiXOPlh1ejkDu5KmFT3M/5GW3eKaNrqCKKA6eIGB/4eV
	 Lmo9U0SOUQksxXk/Ricqag/5DaSnS3PmZ0gM9Hl5wQoiIst02Vw6qdPf6fudrtowx4yl9
	 jOJ8yBPb4u3GQvBy7ZApMV6ox+FCQpJxjBJyCj3WS6uVit+WzRnX7++NdCggpwohqanmi
	 tO+5vMRJ0uOBB7yhTN0Gav+hJ/6b39z+6eH9Y5TSZkmCjLpeoaABS326jJYxHNeM6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RhzOLRLVpNaPKTKKWo5HlxAZaWTmQFk/LEw0QOSSj/w=;
	b=JTzp5oXOJrVuTyOHzMlwCfqqpgPNvbOQDOGCTpeF7flSoiNAsp7KHJ7BR95uIFNGKuwP
	 bX2jaCApYwVbjqPma8oAKCP2IODjD5027ObSABKA5LpOI7e1bVRjojVkzUYE9kN3vVu3I
	 oot0rS5PEXOHidTdTIgnV+0vL4P+7lDAyztPrXf3Ehn8NiQE6HTJkynQjDlcixjlyD6Io
	 nVjSvvH6faeid9RAketM+vkY+xEC3ODnrNTMotBPZiQ6I97QdUMBvlS0267MPyjhalfTG
	 ByDy1rkXpLZ4T9UfIVKEZoNfGALxU/S8HwNKfX+pMBfW8GhPgskf9uqDQcSQBQNenxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i00Dh+9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i00Dh+9i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF1B1F0089F;
	Tue, 10 Nov 2026 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273099;
	bh=RhzOLRLVpNaPKTKKWo5HlxAZaWTmQFk/LEw0QOSSj/w=;
	h=From:To:Cc:Subject:Date;
	b=i00Dh+9icd5CWwK2Dy42DeQ9BnneOk5FwmW7t5sTirP6ILmXpjYNDqA0+ATei1RMB
	 Zggon0owXJzROMKWOrrGWZP5TNqV1UI3lSeOBh29S+HhU4LW+2BzOaVrND1SKGMAuZ
	 Wvy1R+n9GJ29CLO8KPNamGqRC4+5AtNvOwmVnvVYDCb94o0Vf+PoeYkKizpf0g/AdJ
	 68C9l6mV8LR0ZPgFExtxHGB99CH9yO/E6jB/Y2m/hsurSUfnpIXRw79PlCMi4RsLzm
	 1kC8XQVE2/jhBzN0zLh0MauOFT/WSEz6Vi26INcvz+xgZw/M59ojL4ujHlrU7IDyH5
	 1amoQVZQUPJxw==
From: Sasha Levin <sashal@kernel.org>
To: q.h.hack.winter@gmail.com,
	paul@paul-moore.com,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cipso: fix optlen corruption in cipso_v4_delopt()" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:38 -0500
Message-ID: <20261109201138-failed-6.6-1f1f8e8c5176@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201138-failed-6.6-1f1f8e8c5176@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




