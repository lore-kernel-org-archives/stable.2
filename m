Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997083;
	b=cKXeC2NbYF428kM3wHpSHN9mq8cRVidrmJI+s7T/Y1Q0TY3Ols3zQERi0cwHB9c1/Qwo
	 WewzUFE8V8Gf9Zz+LMHgZRBhSRS9+i4P0F3qEgxyRWO0Hm45dpWQpZOMEpjhsHhlP6Vj3
	 rWg1TcScrBuw6qxqLkeTyX86ziY8aXHeR8LG4czgupthT6CbMERciNJC3WoIiLLkj/5VV
	 Wv1wsoblgYmAQ581PEwhnLKuuUSTN92Zectk28M7JlybA82ugcZmKGDI9FT/vN/8UrsbR
	 9p3Kh7TLWc9Te5Ws5ekzVCKPE3kri3Ym5sorG4NlRyJS0MZqv/uQdhyH40maHNn5pjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TMFZcDH6aQIFtxqkM360mGsHK/mRi1dMwYrjxUKwiNQ=;
	b=drT2YBRmOmfZmenekr0admvThY1SSABGY4Jfy6yD0ToRc30bZQbGI3M7i5QjMnSBzHJ5
	 vDZfSHaMl2QtbnSLj+IHbt6qxtZzkhsFLwX6UWDgR7vjiPXIQMIDVgYomV29dmuuhMVl9
	 x+Cgw4EYSn6flr3OpXvrRSakDK/dyWU7lbHDWhoFtyuHdACUEJ7BHHCEKox0gImJi3AOR
	 yWNfE+++CMcCalISE2HxEknXJ3w2BaOIVZTNlWgiBektmPiGsFpBHYa7VQbIZEXDTt9vf
	 oAXIuv4K9NQLzQNn8kT/zFAmdh7y6CJeMrq+WSdOE9Fxy/NS1aGEL6t9K1l1yHIn31g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNHHFZO2;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1C606A334
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF1C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNHHFZO2
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-862aa241d77so273877a34.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997082; x=1795601882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMFZcDH6aQIFtxqkM360mGsHK/mRi1dMwYrjxUKwiNQ=;
        b=uNHHFZO2ZWTl6wjsCFAG/t3isVNM5BUArcyiCTu8msNqQOHHSJHOQeDcsjBiDZryVl
         Qa+xjH6lLze0MKSlm48eQtg/RIuygvNvD611LMDbqxqF3T2iKHL1neKXRI2f6MwQl0Wf
         Nf3jcxNOmbWeMJlnhS+c4rT14GEjZMHBWNb65i5PBUn4Mej7/RhGZ/KRp0Rc6+eqRiV4
         oNioML4frdYcY2ILpjSZmIIHPjooXe66RirHa1Gi03EKfEdtD9sUpHxDCd9fdJdFl0bK
         aq4glU9iuVkSG5Acx73BnMjhGZ3gVTz0S6kjvaRrsV8cec1ibV/I5IKjSbwKfM3HT7Zh
         rM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997082; x=1795601882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMFZcDH6aQIFtxqkM360mGsHK/mRi1dMwYrjxUKwiNQ=;
        b=oz2mHavlU5rs2xxu2k0W0OlFmZoWdiKd6hzLOU7fkwdcWWDIkAroZ04oUCMqkca+ZH
         ZItAQ0jPzknGJJXyTeZcKz1isnfNvbzzvCakSeg+Ak6rkrubxUlwpTuKf8GUSuiAqn/6
         hWd+5oZ/WMBG4CcE63FawdP5z+8MvsANjnP1kWj60uhnquKqnNOuO8OTfELAlKEjXD2V
         F6XuCfNBEfQxh030nEn5c12HqEtGgeNvPl/z2/PuZjxsvR2C36o+WMtryNuT4bFW1vxa
         n/JBu3aWXaah6LqVeuBVHJAZr8eqvcXssS8UksZMkOMa3XyTkR7eqxs1elJKZym6oLJh
         cOag==
X-Forwarded-Encrypted: i=1; AL+hErEEsQ1m0wWX0bVKU2I6bhOT02dMhmaz3FuaHh3RncIgpA15ialcBMRFsvhawBIkj2T6AMIdKig=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nEccVrwpi8koGuSXXoAGpghxowz3paeakP16Ndoy1c3v/HLiZ
	jFmIQIUQz6ykQO4KbGG4ZDgpz+h1A/ZhTH/BevnAGFfRsIDmD9OtgxIm
X-Gm-Gg: AYBFou2r+KbYk3fOkFGhW6FOo2ZcMMDtlnV3086vgcVAUBcSLJ99SJusrDmRFfDJ4cv
	yNqtQl3xYdQNCPhdMkJxzCnIokanNhywDp/2RGuNuRUzAqYJanY1Nk2wc09z8/hwstj4apLAl51
	G5/2UHkNw/8vWjUz4MoZCbYIkcKpl59dGvD3KMQaAv5VH9qdz+QxYVQDXWBwOrNmR0xiYMS/2JJ
	Bw4ta5Us78VDpaH9mzA/N+h07t32Dawlly4rOjU0Djc8h9+0ydn+wZ4nprir9QvSrwRoQWScbvQ
	UUSTKlhIEUdEcp45LDmnduhVEz6y6Cw3Phq4w6WPlT1w3+erUW7rmAnuVoWkzuema0g5ZGrMuZg
	k/9D2K/1RwYCGFMxTaD7xZyPFDldsYRJZF7t/T2/ab9l+qkW+nkr9e8nu3lQAoThAFZNlX3ysl2
	sFORaO/f3cLgmqyiY4zvX4endi1NM1+N244iY21Q/Ov7NGlf8ee+oxSl0AD8TA/+XYIf/cSWFoX
	AvosNGQfoUzc6s3tJ+g+am8+ju7jo6VvSZon3cISHbupqPs5awNeiks7b3H7zRwD76ydErGi8vH
	Zi9g/Y3mKUqrSEaEpa8+0JqI/50hdDRFuj9qWDFD7he/gNTA/nRZ0oY2HblRrmwnNy1/zfjiWd9
	McePetWFYjoi4
X-Received: by 2002:a05:6820:2306:b0:71a:ea63:ac2c with SMTP id 006d021491bc7-71b18657f8bmr1251461eaf.84.1794997081863;
        Wed, 18 Nov 2026 02:18:01 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm1889777fac.6.2026.11.18.02.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:18:00 -0800 (PST)
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
Subject: [PATCH net] net: initialize sk_peer_lock in cloned sockets
Date: Wed, 18 Nov 2026 18:17:52 +0800
Message-ID: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
v1 -> v2:
 - drop the inline comment, the changelog already explains it
 - use [PATCH net] in the subject, as requested

 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index ad414878dc5b..ebc83a466d91 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2545,6 +2545,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
+	spin_lock_init(&newsk->sk_peer_lock);
 
 	if (lock)
 		bh_lock_sock(newsk);
-- 
2.43.7

