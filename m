Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451198;
	b=PBIft7a7+rpAjw8nQh2eO3mvCK2hmuWCywNeBqwdWtXlzKN1pOG8jVqU3s0lNSEJPPSH
	 uFIxijKsQ9toMzaVD/7XReX4LQ/mUGJNXhuncR8DdzsGeMCi4qvRRWNW5CSyJ0pi2SKhx
	 aRXMQ1Vhg/RvOsILOrD4vbGYq0ZibNvnp6B9siv3/40AIQz3XYdw0MyldubhRE+tWyGP7
	 ifujPtj/kivZSySh/3UbrqXDwKW9nALC5SAJgFTtuoVARNKmjiBPrNB24Iv5qxuHpc6B3
	 whfZ2OXo20TkjN0Z1Zqz9Q11MtorXnOZiSCLTriToxmJiK3z2ruunwjtZO/06RlGquw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CapWc1pE3puDcrHN3X8aIWl7trDhBWIriVHGxKG+vEc=;
	b=DhTIZstYFQSMuDQOhMsjcL6Q8e8dkwSoQKRUGaKoE1efRrTPf/HtZPEUh9ahva3SiSLa
	 RR2XglEA6tvlTH5l35ZcD+hgfAs514c81rzjXGh/9xR30hmAC9BVziH9G1IhQYL6biu45
	 jmGI3mog2munH1ljvjpryFirz3kZXXBHiT6R8XAMM35eSWQuAnDiHNkLIbK2iDmRYyXQI
	 TNtSfp1csFOk2QEOp0roeTBD/YB9zNBuayV/owbAm4N5GhRn1GQydj1+THLzJgj2ZxXZ8
	 Fm80JF0p+lsD1lJH0NdVG5waQN7VWWVy41RpjmwG4FeS8TiPFrWQT3W2C1Rl8uxuobA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ndw79KU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C7606A334
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ndw79KU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3511F00A07;
	Thu, 12 Nov 2026 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451198;
	bh=CapWc1pE3puDcrHN3X8aIWl7trDhBWIriVHGxKG+vEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ndw79KU7BFONndIpSt/f3sDJneDmQ/++YavlYoZZalcV53+rxSwbH/4iuWNCqOW3B
	 B86LkP9y5fVpIf/iMdACixxb+LJd8RaqSrroePRq7emCL7gyh/f/RKyj9wbI6I1ByF
	 8g2d1iJcvJcZABtU5gRPtNap4thNiYM19URufq/Nc3wEbWG4P8O1tDQH87Rp6Fsiln
	 9UM5EZXE55Bb07j0YnRXvdbz41WT7D2oE3XWpq9sYVbPRiUd5DyDfPLDPY6b4bEfV+
	 MTcDR7g1uXcLsjLLGFCWXXRnShQuM5YUF9fhgPGpyKddNl90ed7b8jJpES0DZ92ki5
	 3x5b8vggmYhDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Wed, 11 Nov 2026 21:39:55 -0500
Message-ID: <20261112023938.1396308-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112023938.1396308-1-sashal@kernel.org>
References: <20261109201138-failed-6.6-1f1f8e8c5176@kernel.org>
 <20261112023938.1396308-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang <q.h.hack.winter@gmail.com>

[ Upstream commit 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/cipso_ipv4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 83f58bb82c867..5ccc6f2524dd8 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2017,6 +2017,10 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
 
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
+		optlen_new -= cipso_len;
+
 		if (opt->opt.srr > opt->opt.cipso)
 			opt->opt.srr -= cipso_len;
 		if (opt->opt.rr > opt->opt.cipso)
@@ -2030,11 +2034,12 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
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

