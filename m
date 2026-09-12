Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39903515C2
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192418; cv=none; b=k4nhGVbfeFeyeTFM/rPm6vVWYb5JiBtY6xAejU50Lt77LwSHBZBR1e8B/2GNd+cBn/sD6cBVAB5FHnLvWvY0RoH9f1UMhZHMXrxG+NEnk1zlJwC0EL7PfcQZNv8gl4SOOvDHoqGbKeKxuRVLO8RStaOjIPOx3qdjSu3/uXSsq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192418; c=relaxed/simple;
	bh=ZA/mEuTnWP9Yf1QTb9eIl87hn0fA7R1TmKvlmFCboOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7QsIUHKuM0SekL6CRVzmXrVasP1f0bO/mw+fIQsSysgM9T8SFYyQ9I8ioMC9dqqpUYkhfe0pEQaiPQhXF+ei8sQkHlzU3K1LZggpqKSDXhrUC5ParFSDwJ5Iz++iz0b/zCke1nRxJ5WdKWFA8kZvdS+DmKeOBHAj4X33udjkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4V9UvQ2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4V9UvQ2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so7927135ad.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789192416; x=1789797216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKMf2bIuJqFJMvFCCQVxdoeJj4bhaPI/BZkTzVZCVyg=;
        b=R4V9UvQ21y6VvdTW2hXR3k1sykbXxOnOb5/SOtyjsxFazeX9y+iqDuNDdzgtUrEdTi
         +dzLa92wsSUckXOxHcsR4OIqDjpCMQqmibvWGOrScYHzfG0hYYOFrl8gVqd50Gqj6y/e
         Uh+kWao057NhF/MgRftpVjBVUvbVMAAVDyw0EqVlh/0OVcurtjwJnwdXgG9FSFp1dFKb
         K871aiQKP2jyJI7MjA7vB55veFyXklaM9PxB0PgogNN+aywTtuNRLHVQAYVV4+Ko0vzr
         7ph4WlP09zlG0qtu6qV5y3r7diTh7CC3njPD/GMPC81Vsqjl5qf2qrhZt8Lx1atsy5M9
         R39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789192416; x=1789797216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKMf2bIuJqFJMvFCCQVxdoeJj4bhaPI/BZkTzVZCVyg=;
        b=XvwtzmRddQRdBaxQJ+OLY/Dvb59Ld7hsINy3vgWMoohrrkfLvFFruBjA7Ul1pNlyG4
         M56xsy3bieLv6Vk/L9YFhFCWS/7MPf+BXwKHeRG8agP3zaxiqppw2CnjqaZxR1Zep7bv
         LtRnTXD/5bl0lSvBsiTpTqZeHPAPaCT40DIOfadeIwfZEVCIrSCNlPmaoeGw1ewukzBm
         KBuRMQdyFTqAspph/DZnY9HKzQAP1gz0FoAlPt/SiG/73Or6uUlW6JrRkjZrOCSJg4zg
         py2LVz+GtU9bTUHTzF9HkG+idmaccCZR/u1RtPNVU76lrzoH3U7cvurQWr35PfwYQBO+
         nbpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZW3oWGq7XyFP+1LOy2tKsblPrSEd+LtSP8+TzyFqUGu1jsTDE4kP4rZ5dWDVW3sHnM41yFWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mMM+EXBEun9EOi+/hWa1Yd2keI0Z4q3piB38yQx0YCikuH1oMK
	4POi53G+xaY1Z9wFXOCeLQDGC0PDgLWg67bEepTxpcsaI1LxC1SmCibm
X-Gm-Gg: AYBFou36PkImL1mnG5t0JDBQq4BKpFi9eJMYiwNH7Bm9SwsmirEEXa9zO1Tl4X8Zguv
	3rUjel/dGOy8C80N1Igghm3e5Wdt3d09SO08Rw0ZnxoJTAmbTpFrTKwifBn5K+LK22DNsQjPfYS
	TvIko87uf6SYl7VtcWWHnCLMsMXso+RhRjBxgylcIi4c4zOkFeFb5/8JjKbrwSCRN398l9ewaWy
	Y55ghXxb712wK1Qp1iqY2dVewGm95eGKl/OP7criMh3DJLzLxEipMCKwARjx80baCxfEg5EK5eF
	zQI+2+k7nRHKwClAwkygzwvO62MNyYvfn/J9Z7aGDb4/1QfZgzMCR8Eam0g3MTwKbbeOnDPE5oj
	j30wygxI9NCLAXYoRhwzZ9yf6H7NGvuAnts0O1ylq3LHhzgRH9r2PWqAgj57hbEYoYKCknqQiWV
	hUJIdtoR/SzcTu6w+7tbInmRC/oH4iDlT8xE9REEe/OCoUsOkBA/pvb2kb8uYWKxIl04SEm8sFr
	E70Bmk1Q/xyVO78cLKPC+aZr0kcROgi4O1Mkg==
X-Received: by 2002:a17:903:1a88:b0:2d9:4358:73ab with SMTP id d9443c01a7336-2dd2a4580d0mr132179525ad.19.1789192416183;
        Fri, 11 Sep 2026 22:53:36 -0700 (PDT)
Received: from Gris-Laptop (gia.grisge.info. [67.230.185.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm11779694eec.24.2026.09.11.22.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 22:53:35 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Cc: Gris Ge <cnfourt@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: ip_tunnel: initialize `options_len` before referencing options
Date: Sat, 12 Sep 2026 13:53:03 +0800
Message-ID: <20260912055304.1415016-1-cnfourt@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following command triggers a kernel panic:

  ip link add d0 type dummy; ip link set d0 up
  ip route add 10.30.0.0/16 \
    encap ip id 300 geneve_opts 4660:66:11223344 dev d0

  memcpy: detected buffer overflow: 4 byte write of buffer size 0
  kernel BUG at lib/string_helpers.c:1044!
  ...
  ip_tun_parse_opts.part.0.cold+0x10/0x10
  ip_tun_build_state+0x116/0x2a0

On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
`memcpy()` got 0 sized destination with request of 4 bytes length:

  static int ip_tun_parse_opts_geneve(...)
  {
      ...
      attr = tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
      data_len = nla_len(attr); /* == 4 */

      struct geneve_opt *opt = ip_tunnel_info_opts(info) + opts_len;
      memcpy(opt->opt_data, nla_data(attr), data_len);
      /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */

Fixed by initializing the counter before the options are referenced
matching what `ip_tunnel_info_opts_set()` already does

Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
Cc: stable@vger.kernel.org
Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
 net/ipv4/ip_tunnel_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5168d546ea2f..8fb4742aca92 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -711,6 +711,7 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 	new_state->type = LWTUNNEL_ENCAP_IP;
 
 	tun_info = lwt_tun_info(new_state);
+	tun_info->options_len = opt_len;
 
 	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
 	if (err < 0) {
@@ -753,7 +754,6 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 	}
 
 	tun_info->mode = IP_TUNNEL_INFO_TX;
-	tun_info->options_len = opt_len;
 
 	*ts = new_state;
 
@@ -1005,6 +1005,7 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
 	new_state->type = LWTUNNEL_ENCAP_IP6;
 
 	tun_info = lwt_tun_info(new_state);
+	tun_info->options_len = opt_len;
 
 	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
 	if (err < 0) {
@@ -1040,7 +1041,6 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
 	}
 
 	tun_info->mode = IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
-	tun_info->options_len = opt_len;
 
 	*ts = new_state;
 
-- 
2.55.0

