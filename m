Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907335;
	b=SDAPy+fT8rY2RFrwZi3IQ6wvzKkZRDZZtGZDbUVXymXAEz58kIXS5JmSErFSG+9CKMCa
	 RzYpkDc8VbrZ669SFd2ysCmqGBKSKhA9RanfQIuEQIc9Ov98dMA2+31hGb4tGuRpJEKrY
	 7Wlccsuu6aY2vfCJjyK9cbIqNUNT+3L6YH6mFc0gxnrhrMA5w1eGG8g6qQg7X+csbCM68
	 WUIzm+JSmfsljo6vls4BkXE6E7vUnqc30nCnuXv2EdBIYpcJvEBcUQfiOrgXN8Ud8WkRt
	 JwkjQ6k8e6a9dPHY7/fnFyLx0P0XS0mpzrW6Zzo7KUUCL03kc2rTORcZAWTmo5JnrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yb6u44XvrqgEBzrXu63168C9irhvj3KwyZom9iAK0aI=;
	b=K+AQ640kij+oQcSCWLPTg7VOcd0o7BLvvXoPe+bEqtrkBu7ZRzNUO6HeqzqCpIzvEnU7
	 i3AW667oSIp0VNC/VURjzXk7isEkvCEa9FHO5Rn/9+ZIW193FGM1pt7hdmjAC+d+w7HHP
	 Ovb2g/3+4GcrJvFIZFZMweUGC+oe7BYCY+sjQSYrRnGGQrNTv6PDJcZPiN7AagTgPz0AA
	 8XC5SVMHbL7xCSi8VSgbfH2veP+Zlb7Bl/zKkSKOolOM65MdzgHJ1kd69VqdlnkrzD3zp
	 y3uhq96zx2mbVBkQLP+9Ckbd536n0dB9d3v5apj0YpH5MIoD8ca80AL1q/ZjeSCR87w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCqxw8Rf;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D571606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D571606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCqxw8Rf
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ee1b65fdbcso14646425ad.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794907335; x=1795512135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yb6u44XvrqgEBzrXu63168C9irhvj3KwyZom9iAK0aI=;
        b=qCqxw8RfWo7pZ9gZK2/OOFzdFnddnZWU3F8BdPnBphFDfCGs101taaaQSeD5rdBBQ+
         WWOi72ECg/Vz8lwExssQ8I9wwrpTsbL6T0W91ZIJkuauFQrs4hoIz4SyWgmLdVlbkal8
         JPn7ufWZtXBn1YHNOtUMgNIOlXm5ylVPZfMQdbBwEumwBsCZplh8v7nwu9wDmva+hitz
         eAq4JXD+CQpg4za/tmnX0MJ3lxc7MibjysE9p+OvAWmxAjbF1+ljOcVwceuV1jZ/fqS7
         zYMYn8jxxFzrNOv35JyxMfkp1u8VrVnaEUNLG5MUYMVxddjzRTexmQbypcs7K2X+MkcD
         /Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907335; x=1795512135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yb6u44XvrqgEBzrXu63168C9irhvj3KwyZom9iAK0aI=;
        b=12LqNR9yvTxqqC8aLIiqNjt3+zCY/wp/Ze9LUxBsqczS2DJfVlc2KOh+jYuSzqO/iB
         PWCDTY/YcOkCntUnf57lor8PmVIv/VHptrvvSs8DQ3MuTmOWFIAzFqNn9Mrwis3pksiZ
         aXfvbFTfQbWfvFZwAs1WxOg72X3Iy3hh/dA2Pf1jRK1TVEdYyDW80CLADbLf+hywQX7t
         g74t87CIWVDEsrrxkxxeGJtVFrvMNX7BE9UZaW28qHRe+4HVfgK9EfpAHqa6qYlqHgnW
         xQSm18WCxrO7r8GDD1KraPqHnAoUTBWEiWJTXAD6E4t0fAZ9b7d+Hf16vg8GUo3tpzX5
         Fd2w==
X-Forwarded-Encrypted: i=1; AL+hErFP2gPuzmN1ovn2GVFKRXA+QrYZQiUjDtFxNUxIHjC1vkaPb7P0CmLNwLKnw5UY1tzsxBRZFRQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BPMip0/tmxFSfG3aV4av/9M7T81//OOEojz6O/elxxBC6gaqD
	8l0T+LczsojszUxM3TyYEKvrQiQsvszClMuQgXEKfuNyC/ydY7gGnLMV
X-Gm-Gg: AZFdTZdbZXECZK4amzXVD7eDYATw+vvbmi6OZffPj4WTT+F5nZztlXwFZcOJjJCIW4f
	Ox+rZdUbPKLFQ4r/PcocWj7jtVhwX1DKLcyr8sVoXrzOVvgDjKXQs6WELeEzOC2CdL+7KFJ+kdG
	hgdE92JXz7lCMg7fB25ELMTDBgZy7AgybhIScaiUN8hjBHiyk0meh4gmr1M38JnqTmMJpS03Io4
	V2qjIBPS5JwWjfFxl9jbBmcN4tHdhUmlFscrzai6mHUi+poLrIAa3F03vNcrQAB8HHiWmhFdqH+
	3nrY41nNZWNIsFhG1NhXMCDvjYUAfoTXC7yVGWPgsfNcwaJVLVmhudba2FbZNDsXi94gX5eRezq
	3KPsSBFOPQ9Od6J2QuM1fj/CSdrXq+JwrodcFz818Z++EDlVrmT/1mPuvAUCWzhXLcSzJoL5cvh
	LjEJ3v1YmQOb5bRu04NOYE2XyJnjgmUT+TjOUxnDFI94yIUPjQuIUGO8SMsA6Jh/ep2Aa0GGYRz
	cXz4tvfYrKnlPgniANKXx4gKUwpS4MpbbHmMnwN7mD/uZjcZJrOMgMtkagn1pP+VMZUS8XG62Nh
	y1DsErjfe51lFR+pmhZVZr6kyFh1FXbyrk29j9+b1f1CV5Kp
X-Received: by 2002:a17:902:e801:b0:2ed:1ca2:ea5a with SMTP id d9443c01a7336-2ee0dca839cmr135269225ad.51.1794907334563;
        Tue, 17 Nov 2026 01:22:14 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efe98cff9fsm1783345ad.33.2026.11.17.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:22:14 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: James Chapman <jchapman@katalix.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chris Elston <celston@katalix.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net] l2tp: reject short IPv6 address attributes
Date: Tue, 17 Nov 2026 18:21:57 +0900
Message-ID: <20261117092157.85513-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

L2TP_ATTR_IP6_SADDR and L2TP_ATTR_IP6_DADDR are NLA_BINARY with .len set
to sizeof(struct in6_addr), which only bounds the attribute from above.
l2tp_tunnel_sock_create() then copies a full in6_addr out of each one,
so a shorter attribute makes it read past the payload. If the attribute
is the last one in the message this picks up whatever lies behind the
skb tail (stale heap data unless init_on_alloc is set), which ends up
in the socket address and can be read back with L2TP_CMD_TUNNEL_GET.

The commands are GENL_UNS_ADMIN_PERM, so this is reachable from a user
namespace.

Require the exact length.

Fixes: f9bac8df908d ("l2tp: netlink api for l2tpv3 ipv6 unmanaged tunnels")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/l2tp/l2tp_netlink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 89ef04c78787..a07009d4cb00 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -910,14 +910,8 @@ static const struct nla_policy l2tp_nl_policy[L2TP_ATTR_MAX + 1] = {
 	[L2TP_ATTR_MTU]			= { .type = NLA_U16, },
 	[L2TP_ATTR_MRU]			= { .type = NLA_U16, },
 	[L2TP_ATTR_STATS]		= { .type = NLA_NESTED, },
-	[L2TP_ATTR_IP6_SADDR] = {
-		.type = NLA_BINARY,
-		.len = sizeof(struct in6_addr),
-	},
-	[L2TP_ATTR_IP6_DADDR] = {
-		.type = NLA_BINARY,
-		.len = sizeof(struct in6_addr),
-	},
+	[L2TP_ATTR_IP6_SADDR] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[L2TP_ATTR_IP6_DADDR] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[L2TP_ATTR_IFNAME] = {
 		.type = NLA_NUL_STRING,
 		.len = IFNAMSIZ - 1,
-- 
2.43.0

