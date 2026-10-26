Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990094;
	b=g6b7TunECTuQKExR5OSc/Z/vaHX12DnHXYKedlSfbYqwftCm3+o/vKS2jSqYaZTNGmCa
	 xTVSQdQa163/jngyjSAeDpaWSuy8co7t9iQDCSDInZdbdJhuV5Ul1NYN6mfBT51upyZ5n
	 iUxzm/4IB0riswz1TxqcePNc0yXiux3pgKulgAg5AJ2SzM+kN/m7xfKwj+pvLHgxIWvC9
	 PA4vJBCQj9iRYVy3U9CgmgXjTPTMPlWMjt4tqg4Vm4Qf8OLOhIvzaPMH5ELT4XIVP9gDd
	 v3nd7SRVyD2u3XefGTAkvx7Mxl+HJfu+F+YcEh+WrB0JlUZsKWyPE/78rbvL//mSwNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
	b=zKMcIFTcgBdo2hxyGq7dEVkLkDxRlvcZRjOxm8efW0Ffa8t5lcfQcoDi/gfBb5tI6RIn
	 KPIO6WZ1q61xNkmIC+/UrK5OMUQNYPpdmdI2FbapQn5RzpCGE24yKFXr+b4AReiQHc2xJ
	 neuV5CyJv+UmYmkuGa+l7nrSXM/691PUwRvxtxAfvIboHia0/2C/cL5GjwDxIHn7coahm
	 Gzc0mjfMkPiSiZf54C0KC/OFvvg8lH5MJ1iJN1outdx5pfsQp1TAnUeJOUL7WYObC7dmi
	 VUMk9sFUYgyGKXkmlR6hfZDq7KK5UAHs5UIdteaTt7enjesjkPpp4XQ4Glga1AEyAIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJ4WlZTI;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66583606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66583606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJ4WlZTI
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e613f813b0so4026345ad.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792990094; x=1793594894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
        b=EJ4WlZTIcbgcuKmwpDrhJsKZFt4OasvMx1uaaMfnCbhaVB6Ea1F7Y+cZqMypQOXwiz
         kjbvhoR27SoMV2Qd5nAecC2UwvkICePmaWHKy4f7rsompsKYuHIM00xbm1QzYwo4Vees
         PrEiq48okHVRgJf2K24pzMrQ6avEYt5Efo8E9Pz43NvR8bPM1x2BrLud/DjVXhl1Bkbh
         LNht6Fx0WANuYi/OPP6T3O7Zt78LfSv44bnEz7hkanPLZERqvk1Ce9His2omPpYiNuIj
         S9Oe0yOmatN+pzhxEPHbYECcxbi51p8pmbigwifs9dKspLf2Yw6W1+h26/LqlenfOvCA
         Qgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990094; x=1793594894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
        b=gOv+chAA2ynoNLAojQnP2yFOgYVTLAjLf8dacnrOOLrAwhHXKQWsHjnz8/uB9UacRW
         P0MMoHbIzv0ZlAj6olljECPERZZfNqitupm0oO5ehzS5QD11jO0gbAJgQcU7LcPGyo6I
         EvcBhqDYq6ewapElS6jfl9oB0u9A0YJMUjv5ht5iPRiVOJsFGi7vjrDE9kqQ0DXb0MpK
         if6QTDqmIUXtTeYCythLJKC3OjNusBrXHx07702PvkWv3ez/D3aFf/6f+8qQx452bMyA
         8LvDm4KS9ASdXdYjQqMtIvgVPT5FDCuQKdr4+E5NLYBZ2TRVMSq3wRe1qkBrZxn0ROeJ
         Y/zQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsTj+IVcXav853a3Eb54qpNPxf0gJ1bYcc2zyU+wRtAUT9bjwECMSc8Z7mjWH+AqTkXHYqR5U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7lQQPqAxxq9dq6xiI4S5/4fdHCq6OpVQ8AFIWAOOLulBLXNg6
	yiMqR1fHtzjajVsm2lG6MX7Urk4YJQBsvfFO8eN2qQ0Sa8jzPMGHrGY8
X-Gm-Gg: AYBFou2HFTCu3AokS+Azli10zhrF3T4dqULO7WRhoSk3Zf+MLoYSM306X3x8DLPOpyk
	bscqRrxhcD1trU9gn9qXDM8vNwhMSbJauGnDQRjEBuXpZ1goDf+IOqB/N9eh2ukxJR98iT5BwzT
	K17nYS+jALIXZl46oSTg6NvWR/pJI6xdYDRjB7QsNbn5hBvhbNWlaQYmoRC1dscxp/W9HYqykfP
	8aNM9A00NrqZsd75t1UKoal7Z+pjzPhDIXbc1Ka7Yi6zCyFtkyBmPEGhSsCTEhD+bXXB+FVe92D
	85WR+1ej9OO93phmtIDq9dcCY6wHRjdDBMsFMR0/Ah+zGryIXVDgwqFXki3BJ1HHCrqEmWNNRQ2
	HLqiW9RlkI/U1loD25WzZn4b6dj58/5tW6ypGVpGbRYUiMEb3936kX/yK9WMk9EvfnIsBvkLxXn
	gaZQUrcmLVWuWy+JnWcSJrgkP4tM0BL4pIXlFnWInztiH7kwxlA+55USfmTinTWs41mrvon2Ohf
	FtmtR3UmwJcOnk6XyXXPGNVVwPMOjYE0XhA+5pTPQYOY1T0KNlgpPITML0oiXZ50v09K5Z69nND
	LDV0llTnRn7wr05hFak=
X-Received: by 2002:a05:6a21:880e:b0:3de:3f4d:f2bd with SMTP id adf61e73a8af0-3e7db876af6mr2824220637.6.1792990093603;
        Sun, 25 Oct 2026 21:48:13 -0700 (PDT)
Received: from LAPTOP-0A59PORJ ([119.234.82.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36e7fbc64sm858163b3a.24.2026.10.25.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 21:48:13 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Mon, 26 Oct 2026 12:48:08 +0800
Message-ID: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

rawv6_send_hdrinc() caches the route before handing the skb to
l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
the original route, leaving the cached pointer stale.

The function later dereferences that pointer for statistics accounting
and as the output device passed to NF_HOOK(). Its RCU read-side critical
section starts after l3mdev_ip6_out(), so it cannot prevent the old route
from being reclaimed in between.

Reload the route from the current skb destination after
l3mdev_ip6_out() returns.

KASAN reports a slab-use-after-free in rawv6_sendmsg(), with the route
allocated by ip6_dst_alloc(), freed by dst_destroy() from rcu_core(), and
the related RCU callback queued from vrf_l3_out().

Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out hook")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
Changes in v2:
- Rebased onto the current net tree at 7076f684d513.
- Regenerated the patch with git-format-patch so it applies cleanly.
- Corrected the Fixes tag to the commit that made the IPv6 VRF path reachable.
- Shortened the code comment and added the required recipients.

v1: https://lore.kernel.org/r/6adad51d.8fc0b0c9.1ec657.1868@mx.google.com

Thank you to Hangbin Liu for reviewing v1 and pointing out the submission
issues.

 net/ipv6/raw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b965258cf..bdea82543 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (unlikely(!skb))
 		return 0;
 
+	/* l3mdev_ip6_out() may have replaced the skb dst. */
+	rt = dst_rt6_info(skb_dst(skb));
+
 	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
 	 * in the error path. Since skb has been freed, the dst could
 	 * have been queued for deletion.

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.50.1.windows.1

