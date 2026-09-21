Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A678FC0A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789965629; cv=none; b=Jin2MJqTI9finl4ILqedlejoE+FyXK4CrHau6C8xEpyg+w4DlZUGlTCYcCMlywjJhlAHAtFgXNGBBWgxUkiV4hebrjzyOAq8+3mFcHTQgm5GvQ7Id5OdJEEIK8IELkM33jJeugDaT07muuRIgJZlf0zUZ/nrBnD0eME33+sM6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789965629; c=relaxed/simple;
	bh=jeC4LaMsBa3akjQWVgKWMCdJPuYMgx9lSJHwCRiT4fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAMglN29HNXLv5RjVqYXzmxi9DXNIlnYfaJn6RwGxRKDWcgO91Ok8vIPW0AOriiLweAKnVek2neQoOPLX9jTBLmU5bZGKDXElfF/CzzuScgcqMkC9Ola7ZfgvGzmGva6I/3D4SoDfRZ6GfQ50/n+gxXyqwEjXQnmIAtBaZFOWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIMjhW0t; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIMjhW0t"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so2157728a12.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789965627; x=1790570427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2spstPPyYxdRmmq2UEhNRiouajEznMuECBtSYufh90=;
        b=GIMjhW0tg7wnSBN09CIB+VPoKDSQOr6qvD0MJMQsFfOWZi8lClmTEkK28k8fnV04Vf
         w9VknH0liSFpmq52cIutcJYLEp684xjO5dgWbglFZKOd6msHT/KgNT1bCrt6UBcd+nny
         /6Dd79RpibYmPaswrzOXomXPUUFn4UpvSDt2QPoFbW7jHSAzT+rhy7ljR+qUyV2iB/Fg
         d5uz/A+8FYKIf19I+s4N43/cgWls3lvph99N0EpWdFjuP+JRdp6R81IIXosUuVEyyzlA
         PXu6mdSOkA8RdOFV+10GjiTU94G0dS6aavPyrCEWLATGmHT+olLSEtFntICFhmXSuW03
         q7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789965627; x=1790570427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2spstPPyYxdRmmq2UEhNRiouajEznMuECBtSYufh90=;
        b=qNEGFonxJi7txqEIlaOEvC/E7XXdjWBhAJVU/rM45bjH97xBOFuwX6/KRgg5wY+xFF
         qaa6b+H3SuciJSPPsMGKWXHaJ5pvD7atHXMzbhzfEiyjbHwWetfBAvj5R9k8qzez/yTS
         M9p3NYoY5ZYWNAhU3xZGCemi0JdAq8VY816lgZiXzP1+k5MBUL6owCYnRELxeC98xfRv
         vXjnxcEhGK4/mEy9rTQT52A5hsiHQr+Hm2+wZjciehwEN3gm4BJYottzusULp4NfL/pp
         sPDKvmiFU8SIlcXioI/R20PECsl3Hoiu7j5hhZsdVWUD/IDpfBQctP8k1UTfjt3AN0+q
         7Xng==
X-Forwarded-Encrypted: i=1; AKwUvBw8euF2lkbgWWu+0jTIn0HF7lH5/5YJE27yItVajIkxquW6AUy7ETaBeLGcgCynODLvJ/CoE+4=@vger.kernel.org
X-Gm-Message-State: AFuF++kBxGFgxQ8EWl+R18zdrOdtHNj98Ox/1H+yRRqNvCw8roGVKEWS
	1b96S7RSP6BRR75zlMmLPoAHaf7Cb8SWpRn6zOSuLl74z0OGkEs3CWtA
X-Gm-Gg: AYBFou1l3IGZzkrjHLnxHt9a1PP2SQYQVNCJ7oeUUCwdSpdmNIimWRciubswK4k5uGx
	RvPSbReXayml4AnEtCgABbg7g6e7E1eqldtdfAfmoxtgAzMYzfzvkilnMvbMBL910XK1eO+lkwL
	+O1iuZcWUsAbOoAnAkOe6FBVKjDlMmPSC3eVsTq6yUXKOfFuseLMThDK2CGTsxvdK1Tvyr1dk44
	1Hx1STlxjK26uRW8ACvvhMymgHgiMYhLID9p0ssOOmGd7gW3ADEeXg/A4Q4cT1fA+LbnsdnZH2r
	0hP98+tcwPHfQ6DC+n6m1zpo6WHalX4TnHfSIpcSJupL7VvqGZaH3TQ331RwKpR5LW4nyO4/obq
	fKkm221Nn6PLFbKQyjjb7nTnpDD5XW8EBY2B/silTxu/A5ypsTCYxyF02We+Hrw7Lcb3D0V4bk5
	z444+HM2rKN9ONwSCX7HfHKwZBkM8DgYX6QJMAMLB9D5sfURpQt2CGnoNujdF/g9xGPmI/UMqJT
	HntYWbkYOkG4orujq1TTOtYFUU7brihpjn/1KfG9VKRRxgHc0hjfRwG/wsmz6v0gPk0uas/8cds
	IH0+iZngQrEl4RIrsRva
X-Received: by 2002:a17:90b:2e0b:b0:39e:6c69:34d6 with SMTP id 98e67ed59e1d1-39e6c693688mr8433324a91.58.1789965627199;
        Sun, 20 Sep 2026 21:40:27 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02526e27dsm4604260a91.0.2026.09.20.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:40:26 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2] ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
Date: Mon, 21 Sep 2026 04:40:25 +0000
Message-ID: <20260921044025.1535982-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <aq-E5MPYZS5s9_bk@fedora>
References: <aq-E5MPYZS5s9_bk@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
.len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
maximum payload length and permits shorter payloads (e.g., 0 bytes).
When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
skb->head memory, which is stored in sdata->tun_src and leaked back to
userspace via SEG6_CMD_GET_TUNSRC.

Switch SEG6_ATTR_DST in seg6_genl_policy to
NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
validation rejects any attribute whose length is not exactly
sizeof(struct in6_addr) with -ERANGE.

Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
uninitialized kernel heap memory (tun_src =
836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
-ERANGE (-34) and tun_src remains zeroed.

Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
  sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
  NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
  length, as pointed out by Hangbin Liu.

 net/ipv6/seg6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 62a7eb779202..8c2b156c227a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
 static struct genl_family seg6_genl_family;
 
 static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
-	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
-		.len = sizeof(struct in6_addr) },
+	[SEG6_ATTR_DST]				=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_ATTR_DSTLEN]			= { .type = NLA_S32, },
 	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
 	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },
-- 
2.49.0
