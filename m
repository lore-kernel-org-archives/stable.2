Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5458B6BF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886284; cv=none; b=TxJ9uERcZ30s/7urM2utXlwRsmCpTkuI7ka46ighWHH2OR6gqjxCiOyGGJotOlFyipOI9O5QaH4GD+pwj4pNXCzWbbVRF+9pX7Fg6aV1RZ7StIJHEza6ik/qjyrdrRbo+AuQpUcaQmOIUMgskoAbtqq08cOj7SkAPPbGkndbpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886284; c=relaxed/simple;
	bh=UfQvBvSuxFTjQyo4ge7nD5KznVnWw+/9dkfp9bppCVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkDBm1UQRZP05lwSdyakcE8fvmj7p7UN9+UjGobM1A2Py+6IjujTjCkKU6NAEgp5uBqGDWwCEtZm+c3dvq4x2La+MxcTNVPGxfgiwW2eNdLsJCsKS78JocJ+N+Ps/AxjSDyUOovQICa3jl5yAeOEpbvuaErPjBdoHqPfgdgVT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+C5l1zo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+C5l1zo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-853e2610bb4so3642223b3a.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886282; x=1789491082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=llq/+G51IPyNePo3r5tJVqAdU0RXFNXMCuQq3OACrvE=;
        b=L+C5l1zo0hlH7lW+ewtEA7Bl/X41puccls3vD4KXP4PTteMTnAKdvEgXBF+yyeAdc7
         kgvBOF4VueGQZXDuT17ZKm3MwyA7t07zECLeFWw0yo0c6tup5EGG8Wi+RDsV+trwhDD8
         /don2ozN9KwpTBDO95zO3w7VDSjIn7xM+cNWmW23a2pmb7Y5VqhIJ8BF+VAyv3Hlxe9t
         1AZ0GKWeqcr7DuSjhDid6TsDoQeM2KpW/GrVsreXYCzWE1erEuvt2s1R/h/Lp8i/+12/
         YK1bSfGkg4okeUZTZotEW1DrQ9+noqHaWOwsjNEc7yJksBT8CnuPw7KRv5ShxIbMTU6k
         oRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886282; x=1789491082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llq/+G51IPyNePo3r5tJVqAdU0RXFNXMCuQq3OACrvE=;
        b=Y6hpme5fzX9nM367UUcH8JJcGXE9KwzUs6mBHLaJKi+OgAOorCQ1BXmtENE5ubRggO
         zXmXlUM8T6w1lRMfkD3oSBk8zwkoHhQMrQvUuIGTqUKW/GrUMZ9P7/a7PGD01RXdjCTY
         mtA6hdYCpN/BClfjb+0ZrzQ4hiPPKLJPXwJrn8+HoxkJVutqe42T8vcnvPS1k4z70NU0
         aoi6EBLedmV6UDwp2jEbd8NzlDfyRJeSAA1mF6FQZRiI9rFKHlbMzi4lK7OGMjN/X1ee
         lKTtVdAdSptyjMpTtP78NIeo9t3KI3EumlcnR/hFHjlXi0NkqyTqgkWK8ksch7QAUrJE
         Cr8w==
X-Forwarded-Encrypted: i=1; AKwUvByVJJbGu95/lxZe5QP+cjY/xjKTtHzX9k1NsnedMm6oxf81MEUSWmZidvEaH5uKSi4cYlD98co=@vger.kernel.org
X-Gm-Message-State: AFuF++neIiATssf1exvxwxiSOXZM9ccoGAWIycQTft70/wEPufRpiFTN
	qdxgA9nOGJ3QMtQxrBGHoFT6lm/DPKVe1JYxzj0QGAy24b2CF5bdwvu0
X-Gm-Gg: AYBFou1SlZroGL0EXhpQAvX4Ol6Mzoc4RAM2OcWyzpoFmBSGIYZulGvXjc2nh3gmvbB
	aQF+1Rws/Tbd7qFjYqTep1I80QftH7DWe8jkVbPzpDRqdVGfCUp/ZQYGC0O+PvuOKq6s6EbZwMF
	YWixd5T4t6tFKd6s6x/z72yAvpzGnwEXWX/fThdr8mUGPPqAlR3xwFaImNODfL3QGeI7wDClRah
	d198Vhikx87JTwmPNVui8OaQ8ncyrBAoL0myEHOdummPuPmi17QSV6eVGxDnmMq70Yr7GpnzX0s
	Bdq06By77liGcHT47ocgIuN2vEofukce7w5Y9vRFMGC4Q7w2tfClAFjtT8F7byyEaLKX09O+OGi
	uGa8YoO3Rr68/OT7qoqhfGiFgglkzIqzswtOd/p5ulmRP/R7zb8qjH3F07AIr5MgUkCufTojDyk
	Hr/zEXJqM+OFuTiyBPWb5OreApFZfarlBOzieL2xobgKsEKQdD6P/WjwS4jqy/ulesXQjS0bMQn
	1jQI3VMuiYkrjrp5rvT
X-Received: by 2002:a05:6a20:cf83:b0:3d2:ee7a:eba9 with SMTP id adf61e73a8af0-3da213cae76mr40530496637.4.1788886282481;
        Tue, 08 Sep 2026 09:51:22 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cc455451bc0sm5851334a12.19.2026.09.08.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:51:21 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	co+28eef7d8af9428e6@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_brcm: legacy FCS: request needed tailroom
Date: Wed,  9 Sep 2026 00:50:47 +0800
Message-ID: <20260908165047.2786340-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy FCS tagger calculates the CRC over skb->len bytes starting at
skb->data. When a nonlinear skb reaches the tagger, this reads past the
linear head into unrelated slab memory.

The tagger appends an Ethernet FCS but does not declare that tailroom. As a
result, DSA leaves NETIF_F_SG and NETIF_F_FRAGLIST enabled on the user
port, and nonlinear skbs can reach the CRC calculation.

Declare the required tailroom. DSA will then clear those features and the
networking core will linearize skbs before the tagger runs.

A KASAN-enabled dsa_loop test using this tagger reports:

  BUG: KASAN: slab-out-of-bounds in crc32_le
  Read of size 1 at addr ffff8880397086c0 by task exp/135

  Call Trace:
   crc32_le (lib/crc/crc32-main.c:38)
   brcm_leg_fcs_tag_xmit (net/dsa/tag_brcm.c:343)
   dsa_user_xmit (net/dsa/user.c:942)
   dev_hard_start_xmit (net/core/dev.c:3937)
   __dev_queue_xmit (net/core/dev.c:4926)
   packet_sendmsg (net/packet/af_packet.c:3110)
   __sys_sendto (net/socket.c:2281)

  The buggy address belongs to the object at ffff888039708400
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 0 bytes to the right of
   allocated 704-byte region [ffff888039708400, ffff8880397086c0)

Fixes: ef07df397a62 ("net: dsa: tag_brcm: add support for legacy FCS tags")
Cc: stable@vger.kernel.org
Reported-by: co+28eef7d8af9428e6@bugs.sh
Closes: https://lore.kernel.org/all/jH6u350kaBRuqklDjd3k3BW4nWzp0tYRjq3p%40bugs.sh/
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/dsa/tag_brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 411e3b57d16af..b7c49822ca888 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -373,6 +373,7 @@ static const struct dsa_device_ops brcm_legacy_fcs_netdev_ops = {
 	.xmit = brcm_leg_fcs_tag_xmit,
 	.rcv = brcm_leg_tag_rcv,
 	.needed_headroom = BRCM_LEG_TAG_LEN,
+	.needed_tailroom = ETH_FCS_LEN,
 };
 
 DSA_TAG_DRIVER(brcm_legacy_fcs_netdev_ops);
-- 
2.55.0

