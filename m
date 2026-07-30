Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC238DC58
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785383597; cv=none; b=UslPXU7zho+cHGSPAIPBMmwZznAw4uHELGn7c89MuldDC4lQDKuZWDLjNbIcgKTF6/15xCSE0Nk678PzNwB5kVdFzKXFvTS96UZhR8aW9fnnZzRnpy/4N/TTDLp5SrBF8ozlqCHt6Xz3puz5DOyukDhV2S4oSQEHME0AY4i4dRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785383597; c=relaxed/simple;
	bh=98/Zm+4X6FjtRx3S4N46Xjpyceyc/g1u5+NVl3ahtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGL4HdQTtcKbrWMGD1Yd4TICUHkOYHfIwnZBYlSlhJQz8Z1aUq08eQTN7anW0FhzcYJDjae3UO4/ZEF3NAqjO5CG2Hn+egZfmTaynoXcBeQmgcaaQpAnG2MwOffSggfkjCq2aj3uhPP34EBkjRezSXWfOk3s3URYSxqEpzlU73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKMCGZxP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKMCGZxP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfff5f88dbso19136135ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785383595; x=1785988395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nftFX/SYLuJBbL79K9Nl7EIHq2QsHnleVpWoc6Vases=;
        b=WKMCGZxP2/IRLSdBBspCeLPxcVQmG2lkv3bG1e0mCEPNoS7GnquWCo62X9Nm42k3/E
         Z89wYmi6jSHOuc9U+Hrb3E1pYV4dd/2A1uembwBiwHxofYRavP2JMa+wOR2SvdS0/CFn
         ib75rLr/TlwjqOTeNl5P3PZVKH5rJ/U0/Dy5TDd3xFThS7+8/OuFLOSTXjTT8mdfTott
         6DxgvFAYFj2VqvKx/MJKbwypOg2EDAYFrm2F1ZAKO4vmqtNu0L+2XOkyLPCJRF5KXtOg
         iojK8JptnaF6EdFpXk6NhbnTsiB1NBzSRrf5ozGUJTUsbKiC3qyCb1MULaHKQ4g1js87
         i4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785383595; x=1785988395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nftFX/SYLuJBbL79K9Nl7EIHq2QsHnleVpWoc6Vases=;
        b=Z9ccnQP2evxzPV7n1jKWDnqaqEw31gyNTKhZLfGb12/aUgCqmcBh6gjvsAzOMrqeF0
         NZ4gmJk0+oPDyoavbFHTv/gcv33aRhALwP6ylPg15VDtxN2T5eLF+5jJFnI09Rhv1l+j
         Lx1dhaZF12tzcGDNrEQAg18Rp6YMxf/vEHOq1QBs+z9SYUkZ9hOWixC8g1B7dbs3LP4o
         iB1P5iEzfp4bDe+y0EpnoTIukkVLDwpYq12DddSHR4tz7edo908H7eIfBLQsH9S5gh0S
         sidqn0tUAhprGnNKLf4MNe/6LMJfUEoRYDi62jMzyWE3fRbEXqYoH1Qyo8wjvRz+gt4n
         tiwQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4FS86rwYQrN0YegyZ4UzMz+7nYNrfk5RrDIxqLEtR/cJlp9tCgHsUg3PLPojgJRqYG/ZnVZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1oqFWU2iLZzeVNCcMD0ArAFufZjJ4EXJdMfHtU/nr5Avrot5
	RlZsfvwBKxt9ANH5AVTMFlqu35tG4MDfVi1c4Hj0yBzmclKWojHB7nb4
X-Gm-Gg: AR+sD13KR0tEV7tqreNehR6K5jLaIBrtOjuecWr+plC5oHYZiuh4D3rVqbqxzTKQqso
	JlRsIk6ijXMS81ytAN3QS3RhIjZBv/GKti2VuDSVFnb4Z3MTkTlj6JwVdHcQQM2OXWy4gRNZrOV
	ZVp+v7vD9ekpdVvQCzYkoYcwVM9tSNHQb4Sw2rmLHY1cQC97/pWAfEQXanCw33+dY+/Mx2Jfw6P
	lzdH2srBkr+lwHz5Z/zT6Hx0kf2b6y7G39RJrgtLdm84Ebq6IVvaty+K/m8pPb2K75K3uXfOm59
	H0mDWCdVdG+QR+VSn9gYCFTnXb+pMO2DyFQIkHLc+XQ2krlo2a3iQ4zga7iOjTk2KJWkxVpNizA
	r2qTm4wiiiWeoZ7oVx6MUcUiDbGRAagNPEG+oBoc/vBFzfbx7SY1Gjv3GD8kw/0K8YPeZnU0MTy
	rlnS9dq6a+d5tpAFpzl4O4wC+DGJ6JTkAD9B0ZHHmYBDrVgnMjBuJg4/3QnzsDasgCZzGie+9x2
	MkPXhbjrVwafZ5S2MlA
X-Received: by 2002:a17:903:8c7:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d035bedd6dmr11609825ad.9.1785383595452;
        Wed, 29 Jul 2026 20:53:15 -0700 (PDT)
Received: from localhost.localdomain ([103.216.73.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a6a58fsm19327935ad.34.2026.07.29.20.53.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 20:53:14 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv6: fix Route Information option length validation
Date: Thu, 30 Jul 2026 11:52:32 +0800
Message-ID: <20260730035310.74584-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_route_rcv() validates the Route Information option (RFC 4191) length
against the prefix length, but both checks are off by one.

rinfo->length is the ND option length in units of 8 octets and it
*includes* the 8-byte option header, so an option carrying N bytes of
prefix has length == 1 + N/8.  RFC 4191 section 2.3 requires length 3
when Prefix Length is greater than 64, and 2 or 3 when it is greater
than 0.  The code accepts length >= 2 and length >= 1 respectively.

ipv6_addr_prefix() then copies prefix_len/8 bytes out of rinfo->prefix,
so a Router Advertisement with (prefix_len=128, length=2) or
(prefix_len=64, length=1) makes the kernel read up to 8 bytes past the
end of the option.  Those bytes end up in the prefix of the route that
gets installed, so they are visible to userspace:

  # RA with a Route Information option (prefix_len=128, length=2)
  # followed by a source link-layer address option, 01 01 de ad be ef ca fe
  $ ip -6 route show
  2001:db8:dead:beef:101:dead:beef:cafe via fe80::1234 dev veth0 proto ra
                     ^^^^^^^^^^^^^^^^^^ the next option, read out of bounds

When the Route Information option is the last one in the packet, those
eight bytes come from the skb tail room instead.

Reject the option lengths RFC 4191 does not allow.

Fixes: 70ceb4f53929 ("[IPV6]: ROUTE: Add experimental support for Route Information Option in RA (RFC4191).")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2:
  - drop the stray blank line in the tag block; no code change
v1: https://lore.kernel.org/netdev/20260729034806.58923-1-syjcnss@gmail.com/

 net/ipv6/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fc42d67e5822..5968ce5ad150 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -988,13 +988,13 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 	} else if (rinfo->prefix_len > 128) {
 		return -EINVAL;
 	} else if (rinfo->prefix_len > 64) {
-		if (rinfo->length < 2) {
+		/* RFC 4191: Length MUST be 3 when Prefix Length > 64 */
+		if (rinfo->length < 3)
 			return -EINVAL;
-		}
 	} else if (rinfo->prefix_len > 0) {
-		if (rinfo->length < 1) {
+		/* RFC 4191: Length MUST be 2 or 3 when Prefix Length > 0 */
+		if (rinfo->length < 2)
 			return -EINVAL;
-		}
 	}
 
 	pref = rinfo->route_pref;
--
2.51.0
