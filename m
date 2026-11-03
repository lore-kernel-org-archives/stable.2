Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706640;
	b=DEHgWmQLVc9TvG9zO/RCl1R2RGLSq0PTt5zOyX94XA/Pr4SZiyL2WnpV7f9GViZ9MiIf
	 5r6MNt8JxrUYuNMNa1wQQ1Tu0TuJvRmHqPrFib7ROI1ZmYMsWb/l98ghRG6GGyvauMc2r
	 5kLHzQj9r4H3BUpqVi1up9Y++fHo5rkf+UdzHUjuDM8UPkmY/rZlYzjadYRuAO/MsbvzV
	 E1jegYeHizIKANEI7qt2y5D3/Vo3WwWTGsu6MeUSVFGz4zcN57wFC2kiW4jVbIVXztDct
	 ifeYkuKr1WKEsktpXiwqmGctZQpuXvEMw7HRFkJBZlKZwV3iV6Zfwvxvozk8S4XLMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
	b=2m7iF7mIKL481oUaX8MahfhJXdKvnLXzbryk4vHMpfxwC9qdxP7vURRlcjHjqO27yq3R
	 R+e0T/LKQfCV15oLz1Z93g1qy+hAEeAgxIaBQrdPURP5M1/ABen3HYzXsELZz20nHIIpf
	 pN8RvlAYxa+9W4ih75iqR+FWjlgTpC8fxVv6iVffi+aKpEwnT0xAonzljW/VnwT2pgRL1
	 tjILJZKqI+mI9hlTBt2x+O4r4mdnwJG69WC7tPSCYdJjVnvb/sCC+/mNOSUnSkllJv3e0
	 Ac8LITUGERlwjTqNUG7vm/3kbRaA02hMgYdBSWsKL1aKJXYTBbAmptEKrv0nj3ZqjPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZhKq0YTO;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E88606D80C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E88606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZhKq0YTO
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0e21048f8so33789907b3.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706638; x=1794311438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
        b=ZhKq0YTOYst5OXIjfIseOpJStVSCeld+b/HsVmXwh+rBqD+6+31JgkfoIbgHnHeAWI
         8cqUuI1rTyQzjxie2xAf1JZSHnzJBxwzd4P6nJtlXhwS/7MkvTDFdQIrufIqnxZUbinQ
         4qA+jq9YwSRtIpGT++FYdSkViv78oNbb2UvXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706638; x=1794311438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
        b=my02y3IUs7cpKgxGIV5BU3pyGKZlLuAfmjB71GQfQUFN2NsVoHi4OiGzYdwLlhq54A
         1d1DQZ28wyBgzrxhVTelLs5grZBfQB4VF1TS2IlupDDyP0rWqsTexy1/scpLY6vjzAzU
         lLUjHCofQW/96keA8fRZhpFkY4olHzSTvxOTkeXMHa9aRVd0ZSrTZkP0hpZ544zZoxSh
         GGIbKZoMOAUIkRm94wGRACh9pqDzqQiovBaH3ASX+63xfh+C03V3bRfJIxqtGbP+4rIp
         GV2oFb72fCXT6phenUfYnKsUhatbrqf+PM0HIvHfXVj3JK8oUMqggUQI6t09cnswJEZO
         bRFg==
X-Forwarded-Encrypted: i=1; AKwUvBw48lCw5ZCnvWhWfHnXI680oQLJ6SbKhXOy/ONGIBN1hVRAGcQsFHJ7RtaQ6CrnOeO4OKFfaYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vwLcTuPEIqLjTq2OQi1iu/SsBQmKMKEzELhNidCs3ETS9RapN
	KiowGThlD+ZuAxjB4d2uPPoOVMuGRelTWS2ec1JxvACM3ksqj1tEgJ9s/7kVzjUFzw==
X-Gm-Gg: AYBFou2eyrSvPioczwxvsUZXULHMpHg+f65O2jCu7dFJPe1JpLx9M04/FaOm+PanZg1
	nvoelNa133kawXHU8aKfN3rgO6c+8poaajZ6JDiQ2kOT2IMo3pdJ0Hw3EcqU3fX+azsqu2Y8pbD
	lOG6SpNZx89LXWEAEP0ucMbEG64RPBIUK+12GMDzq+6san+1XNwpDqsdaZsKMbYQL6Q4AI+Nh+S
	ORXoFhiPXEQIJWY9D7kz9RIL3QXxZJpI7r9URSy1lfEWyUlddW2EKjV6ppHnV7aDreO/RkPagGQ
	WY1qsIaUq4EIqg1og9F2gO29pLFAKnpsZLb7tnwOBqa3kuJRTA2F3jCrPwss4ojsiDNlRe4+kK0
	RWd4nrHKdKIZCh+XIRxgO/wnt0w2tryiscWnJO7YqbjT1FjyolHvX7+DEcVTlG6x2UKi4JILe12
	lIGh+J7n134MhBcO1KkQEp3GZM9OuzV/087Yn7WgLnuqU8P/F1qgSSUQPpIsCxYh0wtwKa223b3
	65YK1nk/2UgAgYidL86rZtuUorg3d5GLaw0LLictjeaeARJuuZBwzUH8akz1U7VJ61muS3tdVKS
	Wf3ReEY4JZcIQlyqqvyuD/pGiCudrtBxqVLAIVuXHaJoFNj6nUk9+U9ip78QsLAeIFq0/2AQ0ZK
	q6kULM0L/5EG8WDxbMNE/3xbyBpDmNnXcJY4H
X-Received: by 2002:a05:690c:e3e1:b0:8b3:573:b2c with SMTP id 00721157ae682-8b305730e42mr197407b3.23.1793706638338;
        Tue, 03 Nov 2026 03:50:38 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:37 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net v3 1/4] net/sched: act_ife: encode configured zero metadata values
Date: Tue,  3 Nov 2026 06:50:29 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer for the 32-bit
case, which was reproduced and verified in our test environment.

The issue:
ife_check_meta_u32() and ife_check_meta_u16() both reserve eight bytes
of metadata for a configured value even when that value is zero, but the
matching encoder returns without calling ife_tlv_meta_encode(). The
encoder therefore writes neither the TLV header nor its value, while the
enclosing IFE length still includes the reserved bytes, exposing stale
skb headroom contents to the peer.

The 32-bit helper has been present since the IFE action was introduced
(v4.6); the 16-bit helper was added with the 16-bit metadata helpers used
by the skbtcindex callback (v4.9). Both defects predate the oldest
supported stable kernel (5.10), so they are fixed together in this patch.
Each hunk keeps its own Fixes: tag for provenance.

The fix:
Encode any configured value, including zero; skip the TLV only when
there is neither a configured nor a runtime value. The runtime fallback
is unchanged.

A raw TCA_IFE_METALST netlink request is needed to express the
configured zero: the IFE_META_SKBMARK attribute carries four zero
payload bytes for the u32 helper, and IFE_META_TCINDEX two zero payload
bytes for the 16-bit helper (not an absent or zero-length attribute).
Stock tc cannot build these requests; "use mark 0x0" emits no mark
attribute and "allow mark" emits a zero-length one.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_IFE_SKBMARK=y,
CONFIG_NET_IFE_SKBTCINDEX=y, CONFIG_NET_CLS_MATCHALL=y,
CONFIG_NET_SCH_INGRESS=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y,
CONFIG_VETH=y. In a fresh user and network namespace create a veth pair
and attach clsact to the egress side. Install a matchall filter whose
ife encode action carries a zero skb mark (or a zero tcindex) in
TCA_IFE_METALST. Send a frame through the veth and inspect the IFE
metadata in the received frame. The metadata region is eight bytes but
holds neither a valid TLV header nor a value; it exposes prior headroom
contents. Setting the value to a nonzero one does not trigger the leak.
The namespace needs CAP_NET_ADMIN; no additional privilege is required.
With the fix the zero TLVs are 0001000800000000 (u32) and
0005000600000000 (u16).

Fixes: ef6980b6becb ("introduce IFE action")
Fixes: 6a5d58b67e20 ("net sched ife action: add 16 bit helpers")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144739.61342-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 3946a9589bb8..6b23a3965121 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -50,8 +50,7 @@ int ife_encode_meta_u16(u16 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u16 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htons(edata);
@@ -94,8 +93,7 @@ int ife_encode_meta_u32(u32 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u32 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htonl(edata);
-- 
2.43.0

