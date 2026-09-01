Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA73D648F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231622; cv=none; b=MMKiTW4fwTIOieUBB/ZPHhUZ2110n9iIDrLGhTRA5/rkY4Zxf/kKB9wgvNJHoCWsJ0Sd7aaXCIkYHd36J5QHaNwcN97ZWxQQhEUHgZ/zpcqHRzw9GmazvlW7IFklvTm2EFf6Ii7uxbO/Sx4F+diH0ly5tJcSPpZIFDcWf5t8gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231622; c=relaxed/simple;
	bh=FE5OPgwnnVq6/EkJf7a+/zJUwDgjDRqkwrS4uw9s8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpOEtt5cSMXdjqpwpfD7nOJ5qdkWObnnbwtj9h+r4Kyx3xkbrjRS2AQ30ZrFvZh7x1owSgBiCjMrAuyfjBKi/S4wRusJmSZZROyth77rwnJxBj/rjq4FsTsU3iWeS4Vc8p2F/jsK+odSKfAYoJeIxSq+vNlxfpZTRqa642tdOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IYW53Xw7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IYW53Xw7"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so4498756a12.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788231617; x=1788836417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQXrMd6szNFFZL5zIyMougTL9fSbFjixTSxmkZ29BaQ=;
        b=IYW53Xw7/V8QWarNBp5AoNm1nMNs9AuNqq3rZgBhYRQjycxfQLnZ+iG3H52yRbrmpH
         xDWKICHRZcZqEFxz847KS5VcQbTdUTLShJweGpdQQjMp0M1bvJLW/Lz4iLVvl6T+/0Yz
         /IK8p0bOEDAipSs5z/G2Zom6NIw5BAE44+tCgjhZLIGo+L+57RrDjHQw9MDY2ZZI9NYB
         gzWV349H1Y8JE8QVmAubBQZtR7XuborCNIcUDyRtZyUpfg1CPDQNvIgO0CRj/rcuBCXI
         SJC2CfcMbmrtnCZn0xEBM9gL+297RFQhtQ4HLxoR86ybZ5L0NnYHHqUnic6BTcdux7ro
         0RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231617; x=1788836417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQXrMd6szNFFZL5zIyMougTL9fSbFjixTSxmkZ29BaQ=;
        b=BGr3dJfSg9maR4zaq331RDXJpBB+S0iSuO8gh0D06pTssX+rLACUV13i/nN7eiKgTQ
         DljlpHt4vriRBR9N0GZs1T15/pCZ63ofX703Hww0f8hJ3uq0F/OKHUIcuu0u2+35ljWK
         tYnMbVnbyuiz6Ul+RTknF2EpuK3KvcX8c8NFV2QKk80eZ3pz/sly+GPepxSiaCHlsl1e
         5Qk2TehHjK0wUlui5NmegouqjtTvZIAJFNxyoGqvuCTCusOY4YAAA/CjoyGfDsvc4fEH
         McAZwO81HIzQrTRGFU2IU/UpwsYP+aKmtMQ2W1dm4L4C5iQV2IzwJQo/lR3tM3KTHhUn
         Mb/A==
X-Forwarded-Encrypted: i=1; AKwUvBwtsfn8jblePMPvAW4r2Q6ZKOXK0pXoPtQdeeWR64yQjmkoYZ8mWYfolwnAmihdZU9c+cV+8PU=@vger.kernel.org
X-Gm-Message-State: AFuF++lrtWKtMzES0JcVqlONhDIVysHJchbSybBFLc6PRZuKzTLK1FJf
	TtmPHjwPtHQAeAIoKeJoZ4+94cf0/p5x8Sf+czZjw4fgtEBI/uPChj4GKNNWOSMAAbod
X-Gm-Gg: AYBFou2Ea9xqEerl0Vxngpy3YAo17FyGz7whyV1WbLEAflZAkJ80Lxu0J9BZ7gABT4Z
	pfZY4dEi6clpPyNtZKVooUqc6HA8AAiOK8OsWAyn5KAdGCQMCbVUqeXe3gQr71jIybZCI2r/JtY
	9WlhBsF9nwj6qvVTVK6WiG+HX0SdBBRwbRlzapnvKwf81CgnywAV6eEoBwoiRyEAlSYIOyi5y6w
	FmjzKzB86VHKNvb/Jx9t2+Z1X/fx4tayXWqJWHe9ChDbNdL2GXJga6sPMUhKp/RDC0jvL9hwXb4
	Zv7SkajMqMIAyweXLWHOUaZZ4p7LUUq700Ipn/e5gj4EWx07rInRAEA1VRaDsi8U41P3uUNthnl
	PCDpGZjAx11DC20XcUWl/T+qRTsQTrjqGJEYpjP2BeD4hQd//+4wy2ifkAmoE9nthOoKkU1EmLT
	F7nB4nZK/wL0SprwfjzQ2MjR41svFF/NDZfAMPKyq519auuDNJyB0M58BZ+rB2QRwHN+0kVs9gv
	WCsn09TN42+Dwh45p+QNolxkB1ZMA==
X-Received: by 2002:a17:90b:3b41:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39907cd4e1dmr5994892a91.6.1788231616458;
        Mon, 31 Aug 2026 20:00:16 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990baaeec3sm2909012a91.0.2026.08.31.20.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:00:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] ipv4: fib: bound automatic table ID allocation
Date: Tue,  1 Sep 2026 03:00:01 +0000
Message-ID: <7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788223735.git.zihanx@nebusec.ai>
References: <cover.1788223735.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_empty_table() probes every table ID from 1 until it finds a
free one.  IPv4 tables are stored in a 256-bucket hash table, so a
dense set of IDs makes each probe walk a growing hash chain while
RTNL is held.

Automatic table assignment ("ip rule ... table 0") is an IPv4-only
legacy path.  Bound the automatically allocated ID to 4096 so the
RTNL hold stays bounded, without changing lookups of explicitly
specified table IDs.

Fixes: b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Replace the bitmap-based O(N) rewrite with a 4096 cap on
    automatically allocated table IDs, as suggested by Ido Schimmel.
  - Point Fixes: at b801f54917b7, which first raised RT_TABLE_MAX
    to 2^32.  1af5a8c4a11c only switched the probe to a hash lookup
    while the scan was still capped at 255.
  - v1 Link: https://lore.kernel.org/all/0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai/

 net/ipv4/fib_rules.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 4edb0dca7be8..060501b376a8 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -214,6 +214,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	return 1;
 }
 
+#define FIB_MAX_AUTO_TABLE_ID  4096
+
 static struct fib_table *fib_empty_table(struct net *net)
 {
 	u32 id = 1;
@@ -222,7 +224,7 @@ static struct fib_table *fib_empty_table(struct net *net)
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
 
-		if (id++ == RT_TABLE_MAX)
+		if (id++ == FIB_MAX_AUTO_TABLE_ID)
 			break;
 	}
 	return NULL;
-- 
2.43.0

