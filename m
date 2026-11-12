Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452410;
	b=sOsLnHSU9VlPW9d4LD4COqNQ1D92/315SKKtA5YB0hqTJJPJAoAvb9MdmxOWetulBNU7
	 hEpQtw9m/yLyVpQe2rHrtkgCUuprtGGLWuQTS6ACg1VDNo60A6lG2nY7eLmoKPBdTAVYo
	 9J/xRzDCFjqBIi9kk2mgeysWKeFZ0Sy9wUwIYU6GIsOuCq0xiQv11xmebzfnFGQZThdmy
	 +DqpK9czK65WyyILSmhGZ2JNts6ykAZJdgeqKzOkcURI5kHZQkCzEKqB3ou4JwnUH4TXN
	 sP3oMQ3mJXfumAmH/3iWzaVcfNrE7b45NmUGOC7WTKK9lcI2G/idnYbws2T7YIvrGiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452410;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h6rK1PKHyuNjiSIhduBRZY6nzbvvp2ADflCW/6GDGN4=;
	b=0N0y64lh06vcNn5z6E/csUANomSwYH/vFbJMfTC+0Py1sN6SsEZyJ3V1mJkkMPYBDBoa
	 QuQ2GEMHyQUKVD83hmsIg3l4Ruamhg3TsW+7dewiEf9qrvl/Q+uxtRc84u5dn4fUmB2QM
	 8URVG/+Ud9fY5CBwQoKJHHNOhrv3LuXcbTdNPWmS5zGqjRYmlj154e83xswjcZUJtBZG4
	 fwDVHwGljbxRcqnn6wXbQZH0FNiNq5uJWCh7BJHQkGZumMoZHFTALt70AQwNCWU/6y9Fm
	 0OtdTaIe7H7Bnj1qp5OdY17KkjXhYYhjitJIjv9OqtK1kNXIHY79/ktmJXmb3OK+qYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9JVW+e6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF8606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9JVW+e6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B71F00A06;
	Thu, 12 Nov 2026 03:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452409;
	bh=h6rK1PKHyuNjiSIhduBRZY6nzbvvp2ADflCW/6GDGN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9JVW+e60dKL8+UtIKbIA0QJfMKkrMHp+u7D6LIgQaZerCLu3mCBm5QVHVgEpqVoA
	 xl9L3mVsU8WqYN1WDRyYfgze7ZmKdlZDFkzARgI59AGJ/3RKOtSxgn0XZB3MKtfiHU
	 WAnWD0jRqGP/98ghggzkv+CBQ7u3lgwofEnKiJTBRj6L1mQI44SaeyiRgPb+KPv9iw
	 loKhhOUSgA+pYgiFoLPvYS60P6IM/cx2dWAmkZYuXFCC96w5zIzFJuKjukUn/pvO6X
	 YTv91Hs6l/mOkZgKfLzD8ISIqvwjqxFzir/7ZnQg215SCDWLEwyRe0Ky0hgaeK+8Gn
	 bffPCFhkeZtdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Wed, 11 Nov 2026 22:00:07 -0500
Message-ID: <20261112025959.1463117-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112025959.1463117-1-sashal@kernel.org>
References: <20261109202130-failed-5.15-1f1f8e8c5176@kernel.org>
 <20261112025959.1463117-1-sashal@kernel.org>
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
index 4d4600de92e91..13f2e7f0531d9 100644
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

