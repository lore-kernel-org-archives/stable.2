Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03414BF92E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601913; cv=none; b=O/hFhQ5uI2bBzl/69/oH3TFNFxpbxKwFmYE0uWg7qhdf5PKobRXtKid4xaUxQnCEcYe7jIGOn8ONC1YFaByDovB/fKx+q4o5m8CXmkEGlCCuCie1hk9ZFVRVlHAdLw3EY2RDKe3pgqQ91NE0eraovYZBSKOQkEj/osvFf/bhfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601913; c=relaxed/simple;
	bh=hMARLGXAcDtyi7/ghv8YnrqnZ0zG7q6e+5JguN4tTyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea9PgL8B7q4ljD1sjG/KAxY+Wa4mfoA6NpgbGLIRniyrbUu4gmoO85/ZsDgc4QBN54MfVhz+tnAI86DqqKY0VpbhY91ndrK8rJ0Ynjd67MLObEjj/U8PGkzoEhn3/62fCRGtv8402KubclBvd/X58d0KYl4AkmW9oCzoGWCr3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeNr1oGs; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeNr1oGs"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8496fd8c3so30083557b3.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601911; x=1791206711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZeRErcG1oGOMZVEvs5q13I33GHS43HVOMHGEPpqKWQ=;
        b=YeNr1oGsGb4TuutZWdsY4n/+3ACjLa6sLGTR349hWay37rMFgkC9GsyTwBIkeXvGJ8
         hYWjIUvy3zxHxWHsW3gQepvq/bgzmVKOZgTSSpYE6L7tTk14m9JWdq7hVq6QEE1Crwp/
         nkXny8tYMViFMPwoD5fmiM0+xOwTyICg9lhLD3/7e3g5KEubxWkhsIwHqjeGNHLhFmpD
         nJjbOBfUYCp0hiVNmePhL9JayOfybfh7GLuVH0vpEJmFbczC4VxcQAAoO5LzoY7+5lw7
         YPazct1efgNVmQTWlI3bBWHdXAtt2eg5yanznBxMFTiPv0s4c3+9U9uYG2HINk+OyMrP
         S/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601911; x=1791206711;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZeRErcG1oGOMZVEvs5q13I33GHS43HVOMHGEPpqKWQ=;
        b=e91YAORja2a8OSE8zwJmF6xl9eXFr+Eyp2gMV3559/1IRUAbrDeMBbJ/m//A3kvZIh
         uYvH2bnK1o/0/4uI5iz8XUpVpLFG2VzCu2UxEJClffJ43Igw37jf5XOfkSyNT6iYw2i3
         ElX7p3Wpbbxvfxa+F7tEL63A/gbGDYgB9VJTd3zcUkyaeWnUM5gHvJu7p3uwsoSEQWP8
         FiOY+zL0eUPwJDp1qwJEJShmpqbzcbjkw1q849PBcRKM28g7js5UnCXTtZfpQhyVp03A
         wa30zMekO5bMPOtN5anngffNRFU8eidDBcjC7KdQMlEcuUg3ggInayIv+OqmWk6RF8XG
         b9ig==
X-Forwarded-Encrypted: i=1; AKwUvBxVXmzsfOV68Bo2JAsXcWlR4BOmA09PptfR6vpPTKEkO7nSHXkIVCo9yy7pdSjWLUrh98WPY30=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTwVQj5xCoHaEYaBXNmUJ2p0Osq3GVttHuViOocqA8NLwmy84P
	6ZxDIKin54IgbMSr9Ha4Bv6b09HkGK8d8VmpSUi0kKcSgxI4a4Qk24mo
X-Gm-Gg: AYBFou18/MoxkpFfgFY+Uym1ewTPRJi63rHpd6YVGJ1ctkKe3vkBAKBkK0LTz6OmggR
	SibOAVCFT+5PtuAOoG4xcCcVQh30KDAIu+0Vppmwip354SsXMYhR69Zb98FL8Fqcm9SOIn3Pov1
	bR3s19vqf+vv4NFSyeQGb7rKbmMutSvTmgri7VIuwgXVfr+8foNIuR79/ZYvPYXoOIL3odb+G/6
	aqJDueK5LZ6ivpilU14Ayk3WaxdS8RIbp5T2eL4KH57INsjfzbSocOlSStKaBW+Y+6BtXvJGrQt
	KnEHQ/eebWyU9G/1ZveKldhE7Z5bCMHwOvnUwMBo5qyeNi8ES/veaJWR0jsyZ7ORJlH1awaV8TC
	LoPvcPHGRz0TCfvYi+nq9uobdRhxI+PsC6yMUylaDBGA3Zp4RISJ6/OH5Djil7urZelufAwmhHi
	O5Fqh+4WumlDjGazeIRbgFwRv0+AITeRA/skH/eTCI823mfEezX3j8ReI1uaLz7TQLlanM8+tLU
	EQm9qmtkdM92Caa5fjvM24y/at3teMle/bXGI4=
X-Received: by 2002:a05:690c:6e87:b0:8ab:3246:4abd with SMTP id 00721157ae682-8ab32464ca8mr4432007b3.57.1790601910699;
        Mon, 28 Sep 2026 06:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:94d6:8f64:6f66:fcd2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab391acfb0sm298087b3.48.2026.09.28.06.25.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 06:25:10 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH net v4 1/2] net/sched: sch_cake: fix shaper stall on segs == 0 in cake_overhead()
Date: Mon, 28 Sep 2026 21:24:51 +0800
Message-ID: <20260928132452.59996-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928132452.59996-1-ndaugoing@gmail.com>
References: <20260928132452.59996-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cake_overhead(), packets with a single segment bypass multi-segment
overhead calculations:

	if (segs == 1)
		return cake_calc_overhead(q, len, off);

Commit c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()") switched
cake to retrieve the cached segmentation count via qdisc_pkt_segs(skb)
instead of calculating it locally for dodgy GSO packets. If an skb with
segs == 0 reaches cake_overhead(), it skips the segs == 1 early return
and enters the multi-segment arithmetic:

	len = shinfo->gso_size + hdr_len;
	last_len = skb->len - shinfo->gso_size * (segs - 1);

	return (cake_calc_overhead(q, len, off) * (segs - 1) +
		cake_calc_overhead(q, last_len, off));

Because segs is an unsigned 16-bit integer, (segs - 1) underflows to
65535 (and is promoted to 4294967295 in the 32-bit unsigned arithmetic
above). This multiplies the per-segment overhead by UINT32_MAX, so
cake_overhead() returns a length close to 4.29 GB. cake_advance_shaper()
then charges that length to the shaper, stalling the CAKE dequeue path
for tens of seconds at 1 Gbit/s, and for minutes to hours at lower rates.

Fix this by returning early with cake_calc_overhead(q, len, off) whenever
segs <= 1.

Fixes: c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()")
Cc: stable@vger.kernel.org
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v4:
 - Add Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>.
 - Link to v3: https://lore.kernel.org/netdev/20260927131009.24250-1-ndaugoing@gmail.com/

v3:
 - Split from v2 into a standalone patch with its own Fixes: tag
   (c5d34f4583ea) per Simon Horman and Sashiko review.
 - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/
 - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/
 net/sched/sch_cake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..b0d604a7052a 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1420,7 +1420,7 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 
 	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
 
-	if (segs == 1)
+	if (segs <= 1)
 		return cake_calc_overhead(q, len, off);
 
 	/* borrowed from qdisc_pkt_len_segs_init() */
-- 
2.53.0

