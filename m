Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7873358B9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260357; cv=none; b=qywsxOzG19qUF7ulv6Bku3rNghsAbwjBhbFwprsGd63wy9KbNTSTu/exDSxBwsI53mCAmMGeNo3cjyJbHc4J8/T+SaG0zHmo/mgECqRYZqFPmUKyVRTutjwJgb5QEqtMbRjeUKlvmbUAMfe2WGsdX9/kaYIl0aFwyM6vvIiNUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260357; c=relaxed/simple;
	bh=IUIjM+/BDlwgfTCitIc5yQkJXw2dv0wqW9f+Tfa6cvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efK23Xn6tdDSydQ0sGqnrqEbI4zpxIIbk5ogri1F3Thjpq8oAdTzSO2TEnpn8flshDWB9sVO9P+aWq3tRIUGJjgBVY8/OrK+jfeMM6lrOIcIsDkaTgBrW5JxuLImWK8AGLOWQFBDlMyYucxfS97nCfD927c2g4Q4t5a+dOJOgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=gQMObAym; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="gQMObAym"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso784777a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788260354; x=1788865154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgotDXs8rciErqJeBQ99tQj7lZZUpb/FdO1kZjixoqA=;
        b=gQMObAymwpLQHISLa55JGizM0QeTtvcPsXvr8nzt8kHA7aZ+/6f31i2RrzOodkblCg
         WnsmFECZphnCux57GhvOqRtNduAhqma89pybgf7vUgzhAyDiCqBDe1avMk5kmc5FRNlG
         B7xYE3Vxri9211Ht7jbbkrVYWpBWk0weLOY4N7TAzKbX/2/DUYAPaU8Kf/H/Tz7tX9MJ
         QALliwjuu+UnKlfA5jImaKeuzLSI4vNzZ0CLco2VMp/z9746OwZTz2veXrgayj4hxyPZ
         q68lpdl3Rr3q0jpAfp3p1Z/J7mgqXWw3jZDMJxV1TgDOneZ/E7VzXvE1jyOv02AzZPNB
         wvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260354; x=1788865154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgotDXs8rciErqJeBQ99tQj7lZZUpb/FdO1kZjixoqA=;
        b=StIhBaEiSjeuzCSPmvhjPyDk/L2qQCMYMG8JQdS3dFTNBxhc9EvlhPgBZ4y+ATFAr6
         yFTtbb6ZDYSxrOT6qJwm7kFJaMX1DdkerxazJPRB3IkqT4iknxGDZsHdCYgCXXQPgxgf
         Eaxxkq/s5/o9gMO0VNqXaX4lmW1ORw8MVgjnBz11kXEWzj0OmK1pteqltkIv029KrvQd
         udtOwhqboZoIZGYKv58d7HWKnVlmWOZAfaev702DJkclhiXv6UXwM1VTPiUC/BpX/FIQ
         sUPOo1rfC5DaPS+FIANLOSY1MoEJTDKCyKlOD4LKR2vSRrXg5AmU8X1J1hLhuhkMusIZ
         ZBHw==
X-Forwarded-Encrypted: i=1; AKwUvBzAO7QWXTwiElKGFHn0zn3R9M1bLxOc/ybZLHZMZH3RcfkY6qISpriqwYLHlvwCx6NMON/gKFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mEVi4WrdqofjSZWXXOLoeGSUsM9ym5bKsJlcLXWjZoOFE5Bk9t
	symQhMSvOmEWwdroP5uiL4P6Gm+qLW7ltM2XKKmvPTymM19V2Q+1slhMCl0r9yrsgBdC
X-Gm-Gg: AYBFou0MKqfYRaOrr2PLMlgUnnjVtyEZFYL2xv/lUHxamdboVvnIC0IMQvvVn9lCY86
	B9Ii4iOhdE/zGsRhS4tz/JtwRqK1f9deP6OkwucYoswwU74oiYmR0gmssaRJ0kMtGrQJKD2zhhf
	J+o8odybmhRiuwTpDcpMOgcynWG3i29We8i9zSeFOOYZtzxlQNlG9gdjS79C0F+qM60AjPkwWML
	XSmCD21ZEOynddIz5XmXJB3NqIX0iWmO8lH4c1WNLEkhlH+qds0DV3WRy7St6dAtenwvL5tZemS
	uYeoNWbKQmaITCho3gKABo34bcEE3hdJvJ8o/NHo5IEgav2RsAM1LDCqF+qkIVS74wv6kD+TPM9
	lsgSH69aGTr6xWHfzABTq6tXVssiBGF8YE20/7VfcELTDv3/VxNdzR4sqcCIa10v8+jmDYFsMvF
	KJKJDCoO580Vj5nm3WR1F+amvtf/VWlBEWwxObr3R2iJdVx6mYoegP4EOViCQjM1Fe/ksrK4PW3
	mJv8zADA/Ecd12YCYwOPX2MU2pC7Bo=
X-Received: by 2002:a17:90a:38e5:b0:398:990e:1587 with SMTP id 98e67ed59e1d1-398990e174fmr24164522a91.9.1788260354060;
        Tue, 01 Sep 2026 03:59:14 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d22eacbfsm7895604a91.0.2026.09.01.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:59:13 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v3 1/1] ipv4: fib: bound automatic table ID allocation
Date: Tue,  1 Sep 2026 10:59:04 +0000
Message-ID: <6f2f2a7a136aee005512a2e1ac8ede62ac8c7bb6.1788258884.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788258884.git.zihanx@nebusec.ai>
References: <cover.1788258884.git.zihanx@nebusec.ai>
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

This changes user-visible behavior.  A table-0 rule previously
received the lowest free ID in 1..RT_TABLE_MAX (0xFFFFFFFF).  After
this patch the search stops at 4096 and the rule add fails with
ENOBUFS if that range is fully occupied.  Explicit table IDs above
4096 remain usable.

The automatic path is unused in practice: it is IPv4-only, not
documented by ip-rule, uncovered by kernel selftests, and both
NetworkManager and systemd refuse table 0.

Fixes: b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
changes in v3:
  - Spell out that table-0 auto-assignment returns ENOBUFS if
    IDs 1..4096 are occupied, while other functionality is
    unchanged.
  - Add Reviewed-by from Ido Schimmel.
  - v2 Link: https://lore.kernel.org/all/7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai/
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

