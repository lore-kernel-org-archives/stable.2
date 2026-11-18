Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991781;
	b=nPZbZFeNqTvr2mKYKUiUF8BK6cibOxizxZqXUkH4Eb1Cj9qEZCtsuoebmr9+7qGO1Cgh
	 D68LdCp6dSjNkMw9kJ7RPS6NXKZlonQPA9s7OYtQ+zTAumQAA07JMjPCBdlDBSNzcwPrQ
	 1ID2rgcUkGg66aScJm2IM8mMtYk2KIxzb2m1ETG04zqalEA3eNIK1LGKQyCV/SlC8XFmf
	 Z85qXjj9ZrR54jvwanwEM4Q3WbFTHx9UUNoyUXjoIXlpC+/nO7ki7AvReCKm3fN6XZ24m
	 Lbt8qfz5wObvfdKT6r9PPgHu5nTBd3YrgDEz4YFdUiarJNU2pZE7IVkD+A+Aj/HSP4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3KSTlKXLcvFE39HjBxEy6lamoTPY2th5Ul1xhrdr1rQ=;
	b=CqkTSF8M5UzcEst3MCzqqWbmWBh5HILPJyXCeS1qOeB59g9g7WfAWPH/EM95iVpD3prp
	 4EKmSmUHGpNoytTZCk2RkmgtJznLdl+13iXu+IbB0jAokPrJD1ROA8G3H7xYB33E/k4wl
	 5sunGG63S0pcUmMEr5wE8dj/XrlNbANZooWLetizR4p7qYiRlHD7TdNnu5+lKmZhxGZoO
	 8NJTLj06+vkwAcEM5jsVhOb0bWK+m9eTIwrVhEqrGIq/bu1kAN5uU+89lWczCOP6O9BX8
	 1CGUdB7M2v18x4MXKAb/R/zbl9uuyWX76mE3MwDc9TSRjJNIXtjkGpcur4N8fseVDaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gf7oNAPC;
	arc=none smtp.remote-ip=74.125.231.129
Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD92606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD92606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gf7oNAPC
Received: by mail-oo2-f1.google.com with SMTP id 46e09a7af769-862af378b8aso148286a34.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991780; x=1795596580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3KSTlKXLcvFE39HjBxEy6lamoTPY2th5Ul1xhrdr1rQ=;
        b=Gf7oNAPCCRd1rqT09B1dAuM9Xla1krFFlz71lRsX5gHLceMZr9JWlhfxsSWEdIqvgu
         jWnLgVzQcjc79iyvGw2qLFrIkpOlzzBzpqPHUg8LPZzI3cCDMjbrijlo2UzPryjWkMSd
         utah1JJTmCiBlKbxSHGh67phkY9R+P/83bYqE26gvungBXtQ4gYul+WMZIbnGSJnmMzx
         hVHzsIMHGha3yRdHvRsFxV4dUpQdpTEsXdV5v+fD6k9XV+IuwpK5NtqTGrysvzPu1MnR
         yJULP2q2OXOC6D/Brdldgz4FAnRAv+kMP+ek4DuVITqfgc+r/O3hko0b3oNgJEZetGJi
         hJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991780; x=1795596580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3KSTlKXLcvFE39HjBxEy6lamoTPY2th5Ul1xhrdr1rQ=;
        b=SqlSI7yo3H5cEjke+ZwFt6fYASjtKW32fSVSGxRXSsRsjvz88cJFHwxBNEAWJLYuPB
         TSk9Ul1tUpk4ZoRF437PL0RCxtfH3rVoTaT80tOcz7a+vrJAmO6Qpwjh4kCRbXeb5tT8
         yPsfVg5jsUm0vF9eZRKEDlf0rbc/CMzQIxcMLIgyQKwPpEBdZJvMw6hr07oJ+6f9ofEZ
         pYjABAXeD/FiA8FHE3WM9OnY2iPSxnMeszblrR3IJN3LCSfRJQEQ7KINu4yxTaQHHFIq
         INHnx0D2ONVryTnO4zY1yCuHo8FkoWhRBokMVDKipUmMVCVB8ryhJVgpv9sxsX8d7dZy
         H0yQ==
X-Forwarded-Encrypted: i=1; AL+hErEm644CfEmVH8YVNVY6GHnXn9Ir6F6G0QM/hcbyVCA5CprsXzXiHmzntOd2zMkQdlhLuRYKsbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GFG/27kRO67kr8qWjQXxowHMIGnmJn4Sv13HRWBQc05wwbT06
	zwMaSnAeLVnrrpW5k8Ue9ASy16oUCYTZW4YE/FNFQXgDgRoJFL2owjfR
X-Gm-Gg: AYBFou2mlyuvgg8ZrV5fOPSGyUaEfbMGxHivpzO/5LM/fRZm0GUNAT2vuGq5bFlN8tf
	jnhRaZb4GR4EAFJu3r+1Exp0t0DQoOf2Dlz3d+vC2V9OfhbixB0Wcr2j/46bFGWlk8zbt5BGLX8
	L10knZFGJ2PQdQih/sKBsKK3tB5SahXxETE06vrWqF1yCxAQ2OKw3H/9D4I+Md1TP2TQaV+FCNQ
	VLbad3lXmipJLt846OC5lbTXHvjyxSA1BwIg0wFFG99x7bdLqDa4jlmjBuFllv6azfACCXDbttH
	H2HJoB2R7/YE7uK1eWS3FIU/gME+vKwOU4h4NWROzsdvWh1zOg89n3WO4DPS9B/YWAkLi7Q20EL
	lu/GFzAVT4bU+66I1yPA4pi6i8cCzLctcbBJCt9ivNjO6sWwIJMbAKk+luVMTizhNvXMOveTKnb
	cKmtYrw/9UumopUkvNIw/8ir0rFrJHcwtLGeww9x4UHYuoGgJpNXJuKSIrB0fSba4b/FVp2j5z2
	j2N7dtDBcZ0FP+9LpiWIIr0tRme7hlzwd0PI0gw+H5IPNqUV2iK9qDPsq9KsDuqlZzrIKiotj8j
	mFf5/hOSImAlNS0XG/zR1jBQJ4p5bV9uJjnxA6Pzq8/bwPz2XSrJnfhOmhe2zlVUaw4I
X-Received: by 2002:a05:6830:264c:b0:862:a7f2:6d7d with SMTP id 46e09a7af769-862f086c34dmr1737910a34.24.1794991779830;
        Wed, 18 Nov 2026 00:49:39 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01381f5sm1530710a34.3.2026.11.18.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:49:38 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: initialize sk_peer_lock in cloned sockets
Date: Wed, 18 Nov 2026 16:49:27 +0800
Message-ID: <20261118084927.1756747-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

sock_copy() clones a struct sock with two memcpys that both include
sk_peer_lock.  sk_clone() re-initializes sk_lock, but nothing resets
sk_peer_lock, so a clone created while the parent's sk_peer_lock is held
inherits the lock in the locked state.

The first getsockopt(SO_PEERCRED) on such a child spins forever in
queued_spin_lock_slowpath().  spin_lock() disables preemption, so the
task never schedules and its CPU stops reporting quiescent states; RCU
grace periods then stop and callers of synchronize_rcu(), such as
expand_files() from accept(), hang.

Initialize sk_peer_lock explicitly for the clone.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 35306eb23814 ("af_unix: fix races in sk_peer_pid and sk_peer_cred accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/core/sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index ad414878dc5b..b5e2a2a7741c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2545,6 +2545,10 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
+	/* sock_copy() copies the parent's sk_peer_lock verbatim, including a
+	 * held state, so the clone must start with a fresh lock.
+	 */
+	spin_lock_init(&newsk->sk_peer_lock);
 
 	if (lock)
 		bh_lock_sock(newsk);
-- 
2.43.7

