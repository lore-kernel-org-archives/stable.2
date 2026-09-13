Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0383909A5
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290557; cv=none; b=UmBpQpuwTv48kqih7iqPiG2T/dH1hhK9aammeIAfhfQ8Wvd2JylIvoV4Tn0ubFlvV1cl462Enjtbt2kjIJc/MYbZ8v0inUZcqcsVKv9BzyQIve7bEmXaHCKH21nVoxuXiX4kjAS0A+aUf/CCgi4ZFNareQm8gslGWobtg9CCkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290557; c=relaxed/simple;
	bh=azu3uLy0Mux7GpCyqwyRDXjjYjMQ9/gZOf8vjQLgseM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0KARmTIe1vXxxCN32X8EGv3v26Xow+PQDi9HWmoCdqJJ/m43jTIFbEqGS81uoVbcEKSzrr9xkH0KAerketqDXXu5P9u5RhZLIpaDlFD6yCNwWLwi4JXpVGjSq0vP35bQvPKdtQtPf1uN+Htfnyu2ufBrtB4Xg7NhiSvwFxKafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6Ew7KoU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Ew7KoU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8f265cbe6so22572435ad.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789290555; x=1789895355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFJlL+9O/jXoy6I1rLj9f7uyrPfSM21JuJ5Ws/dqJiQ=;
        b=k6Ew7KoUyTssO/21sbBg54LSSdxnRMvRYHm/x51jFDsGbHnJPRP9SBwCxr31xfK+LV
         u937QnroBRg0S6CYTx1EatPpf2KJeex+T0L/RIPBZyGuIchEKpuddryze7cdy1i/ivRH
         MhXYW8U7MNIJ06TCyxpvd2uBU0Zhz3JMUiiB7m4dibPMQAClkxIviHQLO4IJf3ItAzNI
         fQg+ZHPkG3cvq6KWpZ2OszapxObv5wC+owjnJAxsFA2GRt7RrH1JXLAG477DW8UwYgJj
         lngY8boHDZuU7t0tXusI0FpQEgYj5qaYLlvYEodXqodPhn7yDVDa54Ez2U1L2cEGbl/c
         rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789290555; x=1789895355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFJlL+9O/jXoy6I1rLj9f7uyrPfSM21JuJ5Ws/dqJiQ=;
        b=kUBZGAMrxNqKIundYuitbokuOrgy3WkNznsgeg997Y1YpXUtchvyYznoYBmREr5a8k
         WVqh3XQb2ybrJ4uH5GvrLy6P3pGPkC2OKHXhW9Genfr16erQocTCD0D4FcF2lJIrqe1F
         J9iNVdn19pxeT9mbasMu+VUgnEc8p4xW3ZdTu69EgRJAApxUZVYdrB61BATFnKWhZbKl
         s+pP7pIrC4IQHPaQ3eiDPvFVZ6rG+MkHbHtnFZ+ZvTWFtQg5HkM3bRPINW18/a5MF62P
         aSH2ubuTUlYPD5RX8G12SbqFzrNdvq/YijZINzkBjDRGjwbNRwR3XtRgmhMyZX5n5F3H
         7dWg==
X-Forwarded-Encrypted: i=1; AKwUvBzfbJf3TjVbZ29sRUTg6P8h9ELUDc1Eqz3mTQZ/gRQh1DMWcVZm0pns/2+8G6MjljpJxJAAduk=@vger.kernel.org
X-Gm-Message-State: AFuF++lXCCPOVmVEHCkR9RO9vMzuRRK+8cURf30VCvd0l8+emwtPyq3k
	EL41NgQnu+UOWkUwJ6dH+5DxbQMC2D4JXpx+8sOTyLSm1M9c0diXg/pp
X-Gm-Gg: AYBFou01ACLne+uP4fatgkEWrt2HoVenoiH7OycNBSJlZohgSnH4arFqo52P1U11Qxp
	X/5MmnwLnyB2z311ZXz7ca/g/E0H8KAbIThJga+3Zz8JR4vAztch/eIg80aP7yPHKP1O4Alkj5Q
	uXXGfw9KWNn/kB3M8nBdZaz+cWOrPbLzRrtiFOMsKiz7uR/2IIaLMEzeDKG6T2qWdsAY4ZvSOI/
	gaf9pyzN17ktHE/NfjkDaTmmlHHAsIsmGNZSd6wo61CJV9WvotIEDiSsj3rcX8q74CREZGEl1Ls
	m+h/Hpha++/mH3JJD9GFabMqm42lrNr6L6uuPbix7VzLQ5i5XDcDe7vYrWCRVnFGI7JHcuOcXve
	ZkrisFX5bAz788c2PPjmqskrinpodedj2S3D2KCz1dDxuqVF9Vu/Mp26Wf706LG9PV3rl+um2pT
	A4tEZhRvoeBhJj+KSskwWivNgGCBjVq8nb4+1f30NMMRI5zKqdXQkbF3BuveSWOnmP1rS2Ntwwp
	cmRkwfHQO1ygNHDNMv0CSruvrpE8UrzI7w=
X-Received: by 2002:a17:903:1b04:b0:2d8:d4ce:9f37 with SMTP id d9443c01a7336-2dd2a470a45mr200065545ad.21.1789290554993;
        Sun, 13 Sep 2026 02:09:14 -0700 (PDT)
Received: from Gris-Laptop ([14.31.107.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03ac1ecsm6570186eec.10.2026.09.13.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:09:14 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gris Ge <cnfourt@gmail.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net v2] net: ip_tunnel: initialize `options_len` before referencing options
Date: Sun, 13 Sep 2026 17:08:50 +0800
Message-ID: <20260913090851.468216-1-cnfourt@gmail.com>
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

Fixed by initializing the counter before the options are referenced.
Matching what `tunnel_key_opts_set()` already does.

Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
Cc: stable@vger.kernel.org
Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
v2:
  - pass opt_len into ip_tun_set_opts() and initialize options_len there,
    matching tunnel_key_opts_set(), as suggested by Eric Dumazet.
v1: https://lore.kernel.org/netdev/20260912055304.1415016-1-cnfourt@gmail.com/

 net/ipv4/ip_tunnel_core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5168d546ea2f..bab42b9e277f 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -680,8 +680,14 @@ static int ip_tun_get_optlen(struct nlattr *attr,
 }

 static int ip_tun_set_opts(struct nlattr *attr, struct ip_tunnel_info *info,
-			   struct netlink_ext_ack *extack)
+			   int opts_len, struct netlink_ext_ack *extack)
 {
+	/* `options_len` is the __counted_by() annotation of the `options`
+	 * flexible array, it must be initialized before parsing writes
+	 * into it.
+	 */
+	info->options_len = opts_len;
+
 	return ip_tun_parse_opts(attr, info, extack);
 }

@@ -712,7 +718,8 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,

 	tun_info = lwt_tun_info(new_state);

-	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
+	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, opt_len,
+			      extack);
 	if (err < 0) {
 		lwtstate_free(new_state);
 		return err;
@@ -753,7 +760,6 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 	}

 	tun_info->mode = IP_TUNNEL_INFO_TX;
-	tun_info->options_len = opt_len;

 	*ts = new_state;

@@ -1006,7 +1012,8 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,

 	tun_info = lwt_tun_info(new_state);

-	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
+	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, opt_len,
+			      extack);
 	if (err < 0) {
 		lwtstate_free(new_state);
 		return err;
@@ -1040,7 +1047,6 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
 	}

 	tun_info->mode = IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
-	tun_info->options_len = opt_len;

 	*ts = new_state;

--
2.55.0

