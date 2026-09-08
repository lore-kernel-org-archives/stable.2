Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA123EA83
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853392; cv=none; b=XoIR7NzZW2LZwF2CcM7tvi9dDvra0nblsRQvP65Z/qOXuNMvoN4TOb4s3xnD9U5OeMT5onnZuzK0y2JIZIIxkDXv7hRlqpb31xSgS20Zy+s6RLSSZYmJrfxP9PqWTBxlYArpZeHvsxTEef7GXKMM6S1eglFO8jjfW7OnjaV0xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853392; c=relaxed/simple;
	bh=y+kZoY1MgDh7ZkVxBdhh/1ay6+k1Ll1rHWzk6k7pSuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICUVx/lQoRW6gtfDhr9Cn3LkmZAyz4lip5PnLkt7zSBls9W/8fCK0jeuBMnV16PRfEUi3zZpPl2tPfrPo6osBBx2cmCpg0Bd3VovPt4zv5qDyzL0sawqaUXYiOEYONAMRieVR6TgwloQCS5jnBh7bj9iISoN0D5yXKFGYjWvV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=V8FdP2ad; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="V8FdP2ad"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8525efa7274so2911341b3a.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788853389; x=1789458189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5gVOEWG5ALyzgg+hgM1J1OcPhbm1svDb4rhqpye/dcs=;
        b=V8FdP2adaD9JX+z59B0asd4OLNYDWsNTl2u0at7c4hLR1JnFdHUqzAuuSl76JRWOhH
         fn2UXH4JCDgUYdYSGF8bSEebWsfGCNtU9qTpnnuuDpKD4Ogwb49EcnkzryfndBXHIrq/
         hrlSVLOG3GymT3a30lQZntGNxrnQGsJbwxERDEeX8QUE6RUwOyW6SUrRD/npSGmLExGc
         JZvA8Z1Eg82LB2qP/YYV1TNuMRMGkzZutF1iBj377RvTLOIKaOLNAfRsGJwo8svGE4Ad
         9GDIcC9A1pZJaSbGP98QB2S3ogHxAxwQjttRu5zII28M5w/UgKVpAXD3k3FxlndRZ1RN
         K+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853389; x=1789458189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5gVOEWG5ALyzgg+hgM1J1OcPhbm1svDb4rhqpye/dcs=;
        b=sGSpNM2wef9Jq93eCWikWfRqcxzqw+DpdNq4rhMis0Wb+atPH7ANf5bAyGkBUdGQW7
         LO8mHSNAmSUI34VDOt0aNtQ5kaN6VXzjauCmAcPIS4t0VALRQ0FnTsPZTnlq/gg1klW4
         w5/PhVuwuGtCLWOQsWbemirYyNqgECpdr4CBLTVf6xBdRTtPgHStEf28LjCqn/o3BDKF
         R+5G21M6p93jnuA+ihXOnVWbx7HaiZZjbyZS6fkJwsREIIgYlQ1hOfKPpkZ4KmTh0W7m
         bI5pKjJyfFLKbqHOZ+KvPJT/NB3drwqVfK0miYZrh+KTzXxgXqW29BGqnRyi1558LzuC
         AOXA==
X-Forwarded-Encrypted: i=1; AKwUvBzON/DN9svccrEgGjhc4MtuY5ckuBUVLoFyfAtTyJXZeZni3D8bGlIrSv0sK835DAywu+3jtjY=@vger.kernel.org
X-Gm-Message-State: AFuF++lofwDuijWgh2Kg6F2nWZFIzONZzA+MhxdCmKjsLABt5M7k9iAV
	sKZZjfwpgTaaE/gY9vtVrlvEXatjiOY3ce1sg6O7pw6TtjLOWXmP/p7MnyrAW8xEUurc
X-Gm-Gg: AYBFou2JVGkg88NEB6y0KO5KRxVMGfeihaViDmpMK3doH3kYdavLw56Sf4J4YOmbHsY
	ULbhtBX2uRy1hVVj6CdrpTyZGO2DDLIDL7xQbYd7Nm+XD3hsOS6LBEcSkOxo/LpvGsz5sqlfOwe
	U+0VwIcWupRL79kSQOPw8DWZ+hMDVZFQke0SyTXMjMMBQSXYZ/iVsFVSEeq+os4gCg+m2uNXHL+
	Lk7l9PheX2mYp00TgBiSutAK04m3ILsbKYX2ivm+RtZKoEhcDohW5b65jWRqEKGW1uj4TZpGSsQ
	l09vfI8t4IxIoPeRj6IaivlqJ4MfjzXxhQRn4UJJl8vLMtHIWKdtGvphSWZtiQ98pplaDuPxFCl
	xYX60vvSdsJyVEaEqvfnWACIxs0DL14eFxReat9jvygCIVzF0X2uU26swP2Y+dlVTliUqPS1k6v
	ZExqNBh3GCmCcYM/GLftJ3vx/Nmjo91hw08ehk9IZL8Xv6lVnvJqn09H3x1PfOlmiHFDT6OvoPe
	dlpHESYweY5vXSIBazxfVRIbNlkCA==
X-Received: by 2002:a05:6a00:2c94:b0:857:727c:a1f2 with SMTP id d2e1a72fcca58-8616907f6e9mr40004970b3a.20.1788853389137;
        Tue, 08 Sep 2026 00:43:09 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8633cc0f7e2sm3499943b3a.37.2026.09.08.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:43:08 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net 1/1] ipv6: fix fib6 walker UAF on seq stop
Date: Tue,  8 Sep 2026 07:42:56 +0000
Message-ID: <89699735763f6c297584d7c2ff106239cc1e8ce0.1788837093.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788837093.git.zihanx@nebusec.ai>
References: <cover.1788837093.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_route_iter_active() treats a walker in FWS_U at the table root as
already unlinked. fib6_del_route() can move a still-linked walker into
that same state when the current leaf is the last route at the root,
so ipv6_route_native_seq_stop() skips fib6_walker_unlink(). The seq
private object can then be freed while it remains on
net->ipv6.fib6_walkers. A later route deletion walks the dangling list
and uses the freed walker.

Use the list head as membership state and reinitialize it when
unlinking. Keep the existing w->node check so a never-started iterator
with a zeroed private object is not treated as linked.

The same stop helper is used by /proc/net/ipv6_route and by the BPF
ipv6_route iterator. The BPF show path only widens the race.

Fixes: 8d2ca1d7b5c3 ("ipv6: avoid high order memory allocations for /proc/net/ipv6_route")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv6/ip6_fib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 3e382ba1573e3..9ea75703b38d4 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -85,7 +85,7 @@ static void fib6_walker_link(struct net *net, struct fib6_walker *w)
 static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 {
 	write_lock_bh(&net->ipv6.fib6_walker_lock);
-	list_del(&w->lh);
+	list_del_init(&w->lh);
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
@@ -2760,7 +2760,7 @@ static void *ipv6_route_seq_start(struct seq_file *seq, loff_t *pos)
 static bool ipv6_route_iter_active(struct ipv6_route_iter *iter)
 {
 	struct fib6_walker *w = &iter->w;
-	return w->node && !(w->state == FWS_U && w->node == w->root);
+	return w->node && !list_empty(&w->lh);
 }
 
 static void ipv6_route_native_seq_stop(struct seq_file *seq, void *v)
-- 
2.43.0

