Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EE38655A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773629; cv=none; b=e9I0njF07oiT+D2oiWmi0jWhgqgStE6kwZYdS/nk8ii/H6/X3Sv9wKolc0ZSAhtujJuJWjBJD+yFZGfPOD6rq4XQ3LDHc8NvmVggjMYFFp18dG1AGIvVjIWDfITRhJjyyeyepYuNKPn5rSP0DLTlAbfUrQDDUGAJdHsaaB11Osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773629; c=relaxed/simple;
	bh=wFiyNTApVzbmOJ8YmXiKHbbaMqMlzCEPxniykvKVWG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEHBBFxfNBQztDa0X1GlKzoEk6+AvSY/B53Qzi5n0IC1jXcQ7BmBkq+mNXCZ45oLB4kSEWBcJv3e94fO8tiC48H2BR60MOaJtLgAoCkqyoZCzmKz1WaRyGm4nm/YwLdWHTVvD5L8mI42yPJvdbuwjs3bWZ5KtZouLGxDUeZF9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZJ8vIDN; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZJ8vIDN"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-8262eba3e93so1227541a34.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773627; x=1792378427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMmN5wMCsEP96yCvuuKED5eMtVAoO+7UVDbMSBVHpgs=;
        b=JZJ8vIDN0TG1Yk+D0bf4tFn9BLlOLXbsDcgIK3Al1K9viyvwKLF5ZoWFXMnr8eiPAJ
         3go4x24XFVbbX5QOkYc3SkDjHp4v2yBCf7XoAxu9Km4sVJh5L4NGJXvJqakUSwPBwsbL
         lOTiSNiePfHuGCub2zWZRp81BKhN6hM3nDzTQYXVek/Q2zwj2XsqpX41QFi/0zotO/98
         hT6ifez8bjwbWlqGxU4/ff9suvtRQskYKcUUqstccb6zlSZU5wa3/p6BklXEJxDKq9+g
         taQ8r+q7bP+CFRDrl5Tg1CRNkNIhpEIlsHSIxlnTZvZeggb+90gCV0W96+hNS1zpU83m
         yiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773627; x=1792378427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMmN5wMCsEP96yCvuuKED5eMtVAoO+7UVDbMSBVHpgs=;
        b=by5q5ITwjdhNRj4oKFon3EUfsgffknWMrAsCpz8AN3r9q8MmDU/ApQhRUdoJEvJQB3
         xAHfLtP684JdVDGtCpyv68yJua/mz6OlIxKzW5hvCAQqCFs2asB3SRdSOxizPreov+Yr
         pEc6r7it9nTf8d5XaZhWCT3ZCBAvwfSp1RSOGaOoFcICQJ8GD89EaA6FRbnHi6otZEC/
         MC9DyU+L7b1vSQ5kHxjkYWAgIhOkzrixD+co0FqmYdDoPxpdstfBlnzJ5l7Jzc4st4WH
         lOoNAAGQnRg8Y/NGOH5NcFYEVFbdimEHy4f1gWV4JJeXqXYKuovVbVWmS8YK7kiWk48/
         6G2A==
X-Forwarded-Encrypted: i=1; AKwUvBxxQR+edp9QOIAb0R4p9ylUc2g8wNbZlTSPju8Q69VXkG2DUlU64qoAeRXX8LHJpgvzk3DdC9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoGcmE3fpLRnqwg2rOmjFPeyrWBRROiAdNGsWmmlBOxaX3nMhx
	2t2ePaw4KhOWj9QzxoJYWMv9optu+icQeY5I0s83C+ggGqni+8dtsK4H
X-Gm-Gg: AYBFou3HPiZKWtFyR7N4R6/w6QY1MFeM9uhAe4B7eoNMbvbEvGoKkmJtWM6KGLFheKO
	SRFKMMqL/6xExzyFrnDNSnFN3UoeE09PBc8/Cm6GpNuH9DyjkngXFXIETyI2+xNs/3K12cV0F+m
	m/WyuDrQ1Rrim5SYclTStX/lwdohlIhu0n6rChjOWFzcm10NA0xsdeF9HqEfxwh3D5Gadd03Ek7
	kfB1Eki4QPer4U2Lp8qnI4sjRvSEC8iB05qppCINuF71avLQ58jaXe0/0ap+YbJETMaNedjzzDo
	/TJnfOSFlVm1xyNoPfFVxBFgkLB8uZegH3nQ2JdNxsRoGe0G35hrRr/7crgGD4REWu+2VoH/C4+
	PSpFyJ1Y1FKaedrUMR4MntbtTmXXtZOHUC2RkII3MbV7jWfTryQqY4/bN6AeGsysN0h+NWgMXGc
	BJzt5QHQMtjpMu4OMS0gAAfAem57Ggbfdf+nw2AGLS9AxPMU8Mb3vPQOy0tzihFz86+St0oyEG1
	oPpysfaVoI9lcbA+2stNQ4kho42i7kcYu+wAQ==
X-Received: by 2002:a05:6830:2e03:b0:81f:acdd:bd0c with SMTP id 46e09a7af769-8309555353bmr10160987a34.12.1791773627182;
        Sun, 11 Oct 2026 19:53:47 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f76fsm8621722a34.2.2026.10.11.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:53:45 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	Paula <pamoutafpro@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] rds: fix out-of-bounds conn_path walks via handshake exthdrs
Date: Mon, 12 Oct 2026 10:53:36 +0800
Message-ID: <20261012025336.54756-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the lane and the connection-generation negotiation are driven by
extension headers in handshake packets, and both are processed
unconditionally, even on transports that are not multipath capable.
A non-MP connection (t_mp_capable unset) owns exactly one
rds_conn_path slot, so a peer claiming up to RDS_MPATH_WORKERS lanes
makes every subsequent fan-out walk conn->c_path[0..7] at 504-byte
strides past the single allocated slot (KASAN: "Read of size 8 in
rds_conn_path_connect_if_down"); the generation negotiation opens a
similar out-of-bounds walk on the same array.

Only process handshake extension headers when the connection's
transport is multipath capable, so a peer can never make us walk
lanes that do not exist.  Both call sites in rds_recv_incoming() are
gated.

This is a port of the Oracle UEK fix for the same issue, picked up
where Paula's series of the same change left off.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260825120132.51636-1-pamoutafpro@gmail.com/
Link: https://github.com/oracle/linux-uek/commit/2fdeb0513f18
Fixes: 840df162b3eb ("rds: reduce memory footprint for RDS when transport is RDMA")
Fixes: 905dd4184e07 ("RDS: TCP: Track peer's connection generation number")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Replace the two allocation-bound clamps with a port of the UEK
    t_mp_capable handshake gating (suggested by Allison Henderson),
    correct the Fixes tags and link Paula's series.

 net/rds/recv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 6204e577a90ae..93ee4546ae362 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -379,7 +379,8 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		rds_stats_inc(s_recv_ping);
 		rds_send_pong(cp, inc->i_hdr.h_sport);
 		/* if this is a handshake ping, start multipath if necessary */
-		if (RDS_HS_PROBE(be16_to_cpu(inc->i_hdr.h_sport),
+		if (conn->c_trans->t_mp_capable &&
+		    RDS_HS_PROBE(be16_to_cpu(inc->i_hdr.h_sport),
 				 be16_to_cpu(inc->i_hdr.h_dport))) {
 			rds_recv_hs_exthdrs(&inc->i_hdr, cp->cp_conn);
 			rds_start_mprds(cp->cp_conn);
@@ -387,7 +388,8 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		goto out;
 	}
 
-	if (be16_to_cpu(inc->i_hdr.h_dport) ==  RDS_FLAG_PROBE_PORT &&
+	if (conn->c_trans->t_mp_capable &&
+	    be16_to_cpu(inc->i_hdr.h_dport) ==  RDS_FLAG_PROBE_PORT &&
 	    inc->i_hdr.h_sport == 0) {
 		rds_recv_hs_exthdrs(&inc->i_hdr, cp->cp_conn);
 		/* if this is a handshake pong, start multipath if necessary */
-- 
2.43.7
