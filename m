Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451891;
	b=eMrVFcHFQhWbRmGHRhGmFfgTdsIKKO/fZvDoEQoKKLsKxHD3WvzPHrYTfVAZXLQ3i2gv
	 ULFgoWGcn7cNIHkthcQ6aMYC6F5TLhm6ZsupoKd6OeQmt/nTxaUUMvHJBrJPStUm/ySmn
	 oMh21t1jnVexuuRLUp3/zlQZPM9n28aEgNCvKfliQs51IYwLHKpUZsGOWvvDgRAoGhRiv
	 Rm3GKFj1AxtJb2CTqOEJCDOaAZeW1T5b2hHULb6IRIfV+0cfGD7AG+QuSAA7Qmp1iIv8Y
	 iGB+zcS8qHKHSclAJaVAfWBfhauAxgKCM1no1QussM8KUSSu/Zi1kDU3toG8a1E/XLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451891;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/ts/au/KJpKoNidMcJnphVRMJT1c+QZAMo1n3A4EG7Y=;
	b=06ndtljrw2A5njYqAUaOn8/Vs/HqScfbAOHNLMMv8hRTggEoxk8P+D+jjVbnBV4kQS42
	 QOmTQ1SDRgjB61/NoUgFuU/qI0et3owNT0fA+2XdVqDzVVzr5L+b+iPtfNLJozAXLmolD
	 tzznGYqccEs48hRDjONsQ3T+wQ28uTjm4w0b6D/Fq0Uggsfj0dYLmyTlkOlXJKhpFek2i
	 ZSLYtRJYRNdos0iWZVxNTbYoxhyrDwaFDCEi+NHewV9WK1FRvnIic05kfMKZRBgED7HAg
	 7GjGMMjjPdST6w31xalogLVKfwy+/HrwSsTIqBLkUxV+vf+Dl6de9R2tYYcjchUf72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J23ED3NU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52E606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J23ED3NU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860B1F00A07;
	Thu, 12 Nov 2026 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451891;
	bh=/ts/au/KJpKoNidMcJnphVRMJT1c+QZAMo1n3A4EG7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J23ED3NUFTlzdPXxTtthA4Ou1ztISAqzQw0JFwEhONLoClebpUSwp3Vhg7XfRARsh
	 5ZyndGeumxqFK3tnAeZPxbGlmU37aiyQpkoDjD4P0qzXlgej/aQMudxhYdVNQUrsto
	 rOoBaEjukiTw8B5RhLtTWxVbTvXM+ll2VyaeYUqlhFOPyON7exAKq0sRo2mIGiiyQa
	 +IR87oBsOPR+RL55jWM4uYdmVaAqJrDVHRxAl5w1Wu7cvwymF5TJEGf/iJf5itmjHH
	 IvkraKzIiRZpAoUF+ZIzAzIxdYLvv7sP/tF3J9lV9/tWvj2u5W8uEj1nxMB+VbJOrL
	 euclZ6rhHYtEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Wed, 11 Nov 2026 21:51:28 -0500
Message-ID: <20261112025121.1435065-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112025121.1435065-1-sashal@kernel.org>
References: <20261109201610-failed-6.1-1f1f8e8c5176@kernel.org>
 <20261112025121.1435065-1-sashal@kernel.org>
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
index 7229833d08612..cdd751dd3c989 100644
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

