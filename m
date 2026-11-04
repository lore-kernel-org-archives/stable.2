Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764112;
	b=wj9Q2ExD1UeFFEZCZK2xqk2DoPKBYSwmDojtacG2cxrDu0nLowWHb4D/fC9iiZjRt45G
	 Qa+f1DdibL3SIDZGkRjhigcj/owHX1CgA8rNip0vh6nV+3yDy3Z+n1Tl8GWETypVL0lei
	 2ATqDer6UQNxdROzQQXMIZmKGRHc9XRiB335YJ2nYT/m4DJMsB98SF3LFsWu/5ow5TUeb
	 XARyeS/bVoH6mly1XfeX5+lfIlkpnaZXuELu+zK4Rh5zix9WZ2pEMYGxQk32FebOYFXae
	 PN1BAf59cQEkDYObOsE9rKuhigdAK67//V892GPcH0BNE16My9iZZ9ImvLCeaN1kDaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
	b=vTlOCi/C6MGGYK1iAypMQxGM+NxeS4cGALSGmORcqBcZH4/qpar2kU68ZZYprhzDd0sH
	 Mw/Gdd3AZBUiEg0pGMq9bVTag/iCUY9I8NIulT2r33BoG75M6PPk2wxcfYaxS4uVhMlIT
	 8PIENfOMLLUs09dscPc+GZ8cUbyoG1bko2L2biBzgvFvVFFGGODKSyF9JIuWGMFry9ijP
	 56lWk9/83nEgtsNGMjt1E5VLHvPBGL6Tz036tCdNWEsUzLh88GwyrpMaHFvBJjxTC5FHy
	 sHhVBMfbuTT6my6tjy3LxZnsgOJ3QPUWRodF89EyYfl75WrfbBFVFN6Tek7zLgkw0OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk5k7LmW;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A2606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023A2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk5k7LmW
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b092ea1afbso109687a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764110; x=1794368910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
        b=nk5k7LmWzDwaBnhbGoTmgRM0iFvyEupNwgAGriyG/o0TunbdbFZbJwKFJOVFnJny8e
         Yn1RbuV3xKUsMfZy+zHWF/Oh07amD9eATAnRu+OVJakSIkxtJZhtSdz+4JorFvBiRIky
         fAzxvJ8+4SL1K/zh2b9i6xGRhCi863sr0825+luUyDjqE7ekP4Xxme1ytvNnkf+BJrCM
         U++IKulCpBXCo29TbxkK0XqgBysw5c8cIaC6RBPVA0fHk0JOSOzNd33yjVx6U1/fA56q
         UKzRgO2WT1zxusZVTfM7w+Zii4BhfJMqH+2CwTsP351OuqKJ2eOyVHHGu7kgfOLajBgk
         6hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764110; x=1794368910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUeirx3i31936fQIuPQmzE4OuL+xRIGfpGiZkYr9/q4=;
        b=eNLCfGS46QpmsB0QdCZP77shkchsGApfXFgBmlg9o0TkQKg7FTMhn6fmm6nFOAdMsJ
         Y/YBFIeI4GIX5fy8AirMZaAyDYoNieBMuDwmJqe9Hdg1lRuhhdGY+q4/4p5+X2QdFft4
         J29OQlQ1p7xZ7P8BlgaUDIdVHxiwMdyMbrvyOKU7SERwSmMfGJTcMh8gfIodAFTQqYAw
         dCt+zumqw+y/E5yXQ5iC8KWPy83oxIxvYBu0L5Bix5/QkBP0R4y6qvdK7e9IQUG4xunM
         bMr4IY9+jkkGmKlkWBZMJRF7AAHciKUDm2P0MvODsK8FjCwZz//UPNc5ZYmc+6Yo7807
         Hyyw==
X-Forwarded-Encrypted: i=1; AKwUvBwXpACd7+ArO9Q36Z1oNDXztii7bbeR1j6Zd5M3kO3EEF3LYSFozDrggytaTJYquOmqp/vjJpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0nAHu89368p9Ogi5laXWqiobkvj6H6UV44v84/+Sg4c3hStYS
	Qu/2MSca02KZKBAwwzvnA/Nuvme0EZwHJ3yNhUNMXgTf25ordrVe3zHP
X-Gm-Gg: AYBFou3iNTU0/rSSs4+VpvI/AJkGDEbXLJ4H0/e8w62iE16VtBgluEFYFBCijhWCtbH
	hvOlzxHED+QqItDQugVWVJWEAHq96bLvEbXC+URjCa4jfE1+3dHLkeFEEVfoyEdEUH/J/vyFx6z
	pby/J+Q56KmJLbtYCIfmuCxzeI8l3pGWyvg1fs1dYnP7ykugMjw8dAgoAZi3MLbc4ncjm/jpZzT
	KCDRdfb5C91IYq6UkQV8WWVFK9x85G2+wNUasXCK8iKxMjvdenXVRXX/7Md9I7Y5WC5wu6HxULP
	ta7vzENac7P772alBP6Vm3xzzxYGyo322jExqwoALY8/8ReH2VS+ijuxEA7Dd6Vpnk3nQqOw6aP
	CFHz8nkuOesmxNRjqvIteCOHu4O1WBDMtlkuV4CV6y54xiGgckc8JHCZHenk71cGpQsT2ZpHj7S
	5mB6pM5GHOju84S62pNzX8gKDbqdEEFZa2hB0/nfC+j0sgl4WorPULbMUcl3PLhG4Mu8sZvLu7L
	j5voCaQ/w0oW7iOeIsI7eNGQt99AVaQ5Zrb+FIE3ReuWHVloRU/LlkgUqeQHn+qYh3xpSHr2jC3
	1xTPJjHBUBx79nFVqQlh8i5VMNq5BWqWc68xsANf8dyKSaEWshNHx7o/2gDUTk12xYyL
X-Received: by 2002:a17:90b:588d:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae8970ef58mr12252667a91.14.1793764110336;
        Tue, 03 Nov 2026 19:48:30 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:30 -0800 (PST)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v5 1/2] xsk: defer software checksum until the skb is complete
Date: Wed,  4 Nov 2026 11:48:08 +0800
Message-Id: <20261104034809.24545-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261104034809.24545-1-testwrzwrz@gmail.com>
References: <20261104034809.24545-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..27ec1d931fe8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1277,6 +1278,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		err = xsk_skb_sw_csum(skb, xs->pool);
+		if (unlikely(err)) {
+			xsk_drop_skb(skb);
+			goto out;
+		}
+
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
-- 
2.39.5 (Apple Git-154)

