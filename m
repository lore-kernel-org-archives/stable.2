Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452913;
	b=z8m/eX2zjW2btx9is8yGL8wEOZACYXfmaMjyRitRER8KuUKZ+g+oZebZCTkI2NDoXDzJ
	 znR9+39eqjA8tuxOD0VI0bGspal9T0AVUX2RbEjpIKccvouBhY6kZRdnM/PYjIymC1s36
	 FE4vpxLftK+DqK8hfJhIaW2mUJVmRCvhnWu2tV+4ScFt1WYtCPsAfDxfHDGo4DSNPbYSb
	 Ed9FoCmhdO8wmO5LjgGZ8JHUvZudUKV901A9vsVYAK1O6iBdN1lsziw7kGpzBnBUABHW+
	 IHoEpBTPmkE+ugB6ptfkO+L/8DOXmBjvBN0wfgNvrfVy0iQsxjpNlLiYsLMHPO+Z5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y0FnFMEvNFXXIV0VG/IpPmOgaTRu7ZYaBws+oUc+zBg=;
	b=knHCvPLbw7cFy1pY5V6eZjb5xmBWLQdbz4V04qG2cyFXHiCVKAUgoYLbFa3TFC+2vUti
	 43yuJBBn8nNoHxY3li6JJKOLNC5Eh5LD6yPD4C3xCb75CW1bFAKDHAyHAtnFTuZfP0IF5
	 +ycM7Tx4pGj06tWdA6w8Xbch0YBB1G3UvP7oXoLiGsJ+jxNcxRT8Wc2mgX9Yiq7tvDH1/
	 FPeyq5AWcTCU90TL7pNbwx/BMVVyKBWoZG903h2ERmOqhQZvaKcMym18Dw2KEQE/6KcEy
	 RxaCGCN+4i0eXi5GZxcJ0EcKLZr/+Afsd/xnBV2sKYDC6BovL8Mk2yQvELu3hhWzA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl8gK1VA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF1606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl8gK1VA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D671F00A09;
	Thu, 12 Nov 2026 03:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452912;
	bh=Y0FnFMEvNFXXIV0VG/IpPmOgaTRu7ZYaBws+oUc+zBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kl8gK1VApM9sdn7BUc5UifJooiQ9JCv1BeyklvpBt2uZVTQzCsYrogKV7rwwWa1bv
	 VgUbs3hMJfmzZ2SqnD9NifzpWVOEPj8RYU1FNx2b5V7SXfso4qQFfliT/ssSwgp27r
	 08kHXdMLanA/wG/BPnkHEHH1VlHTK4EsofJCl6aIJDZ2j9e5dQBr86ZsEuqnGavavv
	 0KjdHX0bqr+aXOICQof307HRa9cAqmaO6c8qmHSjOLRsGzUNUtRxqNmPz+bcdlf0ne
	 iKFGmXkp9y072p3xSJUQ6EZpkkjpTu/2Q4lSUARvSPnT33lxwzxW420AV/MRUlxvRx
	 VoBpOVp0Nwufg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Wed, 11 Nov 2026 22:08:29 -0500
Message-ID: <20261112030822.1482543-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112030822.1482543-1-sashal@kernel.org>
References: <20261109202621-failed-5.10-1f1f8e8c5176@kernel.org>
 <20261112030822.1482543-1-sashal@kernel.org>
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
index 61a8c742ffd0c..ee02f18e8298d 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2018,6 +2018,10 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
 
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
+		optlen_new -= cipso_len;
+
 		if (opt->opt.srr > opt->opt.cipso)
 			opt->opt.srr -= cipso_len;
 		if (opt->opt.rr > opt->opt.cipso)
@@ -2031,11 +2035,12 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
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

