Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475368;
	b=LPkyWU6psde/pfPtiq3rkqE3vIutNxpBk6WjPldEWWzDgPrp7d9iRcp3U0YXr4wHpR4Y
	 z/NTiXdC8rUjblwKIuJV4V1D6tog742uulMxReX2b8WCPoYxoi0XHx/PFSWea5TpCGUJn
	 yNJk/3zuaTaZZ4XGRSUDk2xtgbuoMowp1u/Kk6Ooa8HYLtGgQ5GA0y3Ztt8n9tp/S6LiP
	 EbvhfRV9tKMoEFj+GSljd8tgywp7pX9Q5d2u4qcsdrJU0oyZnXaeSXD8qAKYeC5vcm7ae
	 tyTYLSBMOLesf9iyUjo924yW2Fd8NyxYyYO4+IYO+DURIeAMZAwu7NEzEbiuAGNqB4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
	b=OE+Lfs6VVQDNHbwnbxp8siP3WF946uz4jZjl3xoFdkF6PzL1bcoFeVb3Fe6MavXjT3h9
	 mSKuyoUt1KjpJupJYEmTFwZnFPXHNbhG7WrSSANMQ/G2HlW+pCx3rdw40BIeANWjZNYFZ
	 ND0/ZhTM86aFmZajdhIi+3h22NxvZi+de5o2Mi3P++BCt0tw4Gp9ss6ac6rPVooPB6Wu+
	 8PUjeYGOGYsVndK3OtWGKGmc2eLeFLbhzEMujMa4zIe6hb4JKh7FGXdMT2Vour8lfwbIq
	 Dp/qqJazVepCuxaoj+70/JxkPJsFcAtqzTOAjRmfQYiNBXElKqwOKNJjP7sKwpXt0XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="d0hQ/Feb";
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8F606A331
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C8F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=d0hQ/Feb
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-945ae2daa66so12816585a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475367; x=1794080167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=d0hQ/Febmr/nIbkqWhqs3plBZGB8DwI12zp+mNMgaeR8/hFG+GhS6Suuuu5hRTDwwh
         jPvXI2Or3et9EJG1vSrW4s5ECw8h5gfYlsDlzcZ1HegSGSfV2/WU4bzgN+LwwrlW0SEu
         F9Nuur6c58FW1j6aXpK0dIKsyo/1IjD025+w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475367; x=1794080167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=AyQ6O6mkVvGBeYKxVQCAny0knZvshOOlwldISKHV4hAPdkzjbDv+XKMksI58bISAPo
         xBq0LJiMkiRGeNS9LcMa204TQAbtPy2aP+L+oBhaDvULCGb1LAfA8UIM+s1JnmMX6gci
         KLspJj53R+Pa7CT7H3lbYL6fVrFhZKdL+hhZa+FX6maJRKAzQfKu9Ax8zcAqg+ZO7XRr
         yN5mEp3339KHOAc36Dg4q1J9mbsSoWOcap2ZaKL0kG6YSG/jXNVS9R53070ce57vSPSx
         zSFN2EdTEd/6qrzc/dQWOIXzTN8/WjgTHAqeBjqlosWnsNPTJ6x1ZZrocKIYGy6uYipY
         E9Dw==
X-Forwarded-Encrypted: i=1; AKwUvBycJ1q0DwCUcgznaMGcLesTfBny8ycTfJaPxNXJbZ72KCecsaUPzNHVbzMlXwKuYSE7tGyWUp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM6vIGSCEMx+ytfLExo3+H8YjlR0jwk0afzLOgp0F98jYxghNd
	2tCb3Vud4q/hm0dgS03m+3ZA9VSyoZv2+1r5hgQpdTccFX/9ghcyqF7sgay2WJUciw==
X-Gm-Gg: AYBFou1hp4/3LcgsmJSyjs57nC9iW9VBdRfYXnvm8aJsML6MumL5+6+QCpSq9hXIEQl
	Ki6gSQT9HPSqnK+18ea+7L0sLffmih0NPTL9bkNl4syZOFLSp3FJ4Bi4EV84wyQdPQJsVAHNINS
	Gjngi6toH0MkFTr7PIKX/rixMzMXyugkpfeS92mExXBbI3MVSVobM2bYU2UgGNFDyO0MZf6av42
	SGo+fHsoQf79AtTj5yL/YTk0+RmxtfMQ1Tsst4Lmee9axgwItzA9z9Hc1BPK7uu8rs0H9UL+tqJ
	3Z+al6JTGwC5Lp9gVxBfKThR6a1bUHWF3ugDyudj2oa7TfB8wHKpiSKfPqubo9RuFPQFcztFfK8
	VkalM1anfQJDr1Prtmo/fBqdbr35YlNLUBmYwh8OPuO78DXzGyJ983zx7T28m4P9GVzfxreCRry
	kl8ok9s2dD1YjWF2sy+oC7+j90wdmKWZgJrJzOixNRwiuDnKUOmHBee0gWvcsp8TGFtxd4uq2mB
	QWqXggERTwYbe673gH2aYJljpok+RvYpx0OtPzTvkpCfoHmql4BgyDO71Jk+g+vOBIbD352hMap
	/4aGSQ8oDce3y/yL/c2gnDpW+fUyaUxuoBS/gEEWs7wMxaqGLp5dfqmE547GX72FIWfASdfolt1
	13cf1gz/UXgj/gcJuqIPs8wgtvJBXLflpBOhj
X-Received: by 2002:a05:620a:2b89:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-94421585ce2mr951078885a.12.1793475367158;
        Sat, 31 Oct 2026 12:36:07 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 repost1] net/sched: act_ife: encode configured zero metadata values
Date: Sat, 31 Oct 2026 15:35:58 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
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
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..0e6aba9aeff1 100644
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

