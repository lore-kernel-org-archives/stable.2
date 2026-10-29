Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316466;
	b=n5bIUGrwo9KHxppPgqz4qclVS3/BQZecXtIa5k8sG6Q2vl3E5N9TBcq9HjL/Myi2snKh
	 ZRcyHDNz9mn0qyyYv9RyFHZ+a8wTawCnlecIfuIWy60W0Tw4W/Stvw5Wovrh84B5tWmpJ
	 e+9c9FbLkcCO8l4QCOfWIPO0cQKTQIQPqVuU/94uok1CpMMJ+jwMez9xsDDCHF/58ABGH
	 KC1lGfa1SObXlCdLoQtziLrsdkkbX0DIE7EEMKGH+OhVEoz3D5b9BWBmbn6W+IDuItHcW
	 KCor7DAA5HBjYY5fso5sLFpFr/6PWaeQs8JH2v2ErcPq6/XqCKtKJed5V/1SYHniH4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
	b=Tg9Y+GZGHp/rWevVzYpwQH1oj3H7qWssRjKwFK2ZiUmyHjY7YFafyeQ3fAvdO9y++JJo
	 OjJUqizhDp0I++dvuQn7P/Wg3e5bmIBJWv0RLxMz4Surp6//sQDUCE/54ozXHV7+84pN/
	 B0YjAW11zR+0a5w+jtwLYW3d4juFCEaluGJLoqf+9j8w82Jc5RgG+EF3TElc3Uql/edVC
	 pmOc3pFkXsxgxxhZYmvQp6te4DvCK6ixPYED9/LC/p+g4cOYD006UIAtBDh7jPlHZ2U/0
	 wsf/vnQS0vXTQKXjhE8rWGnMNWeWRUEwcWXDDo0E+aIJwt2QHea3swkb44XzrbvZRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Kzyg0Hlj;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B8606A324
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Kzyg0Hlj
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f30660e69so5650385a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316465; x=1793921265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=Kzyg0Hlj8a8YIkwjP2dUbAFX5M3Ac/IbvOLgmVwBCdqwuxZ6KnSmsGVFIBoxh5Y6hI
         4zFXRfLIifkYMaBU8iyR4lWBpbn11/hrkZ9WssTBJ/fPLDpfHO1GT8kIjAV72/7n2Jfz
         va8YZm1ynVIu4go6+DccVlJwrolgS5nKI/I4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316465; x=1793921265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=grk5NIkQsXzvNUGacikXa6URYsP4TlUSzxfOeSTeJQCnxGAYEQtq0iAzpqjTjGHDK4
         3ok+F+fBeaHY+iLM3DzzwtDLH9EQy0btu8P2o8cw0u9bptObL8zIcWOWVsi0ZhitLCJT
         PG0koKLLL8xao4HMjIwkPB1GVKdhcVu6zLIhD3OLCEATwehFqpdCbwRSHWF3lgoajwT7
         chrDVT5vkaeUylbS6H/KAW+fO2mTqtHDM8UIfzI6k5KHqaDocec2Ji/WlYUwitwZniVV
         AXU50eKMjpol8vnV6to+fIFlsUq+xlEQEFhFCTkGNlqPU6alnOMX+sireZkaGC6EuqWt
         ayKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6YXchJ02HfqWL5FJ9EAvWyBy3nRI7TeiQpVnhLii6ACE6Z/4/PVveuCgHHXUE/jTAt+sEvB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYId4G8AB+Rfz+yNH2KUUzlAwsC6gflhjgtC/GfXAKxOMECvcGaC
	qqUHs+OAta5xq3a+VywvbsOusAuJCu8m8WQ4uTfxy7GzFWpIzJdU82t8JeX2FwISsw==
X-Gm-Gg: AYBFou2ZjOPXmdO7W1SOJADKV09dzN4rl1B5tEtCaD7mpu1eAJXdyILZqsxlEePdaQE
	+h87O8ChtNIsvzdph2ovTT1C+SpAjTfJPPnaVLJMXAeL3Er+iVWgWZktJaJU8jtjgP6JbE7JVBz
	c+l/1MeF0dQWS4p4lLf5mOBhNi0na29MvYHkC53pK20UVB1dTIA9i31nCPD6D1bTYxsMfVR7K1f
	umQs2Ly547qoE8ghWoe+IHXQFAhMvfA0Hagfj+PH/NUlO6R6kdjuVnyFWerUungxO/xfhMD29Q3
	+Zg64mjh3dXBEXsOlILfiEOiOPXlUsNk5bBP7cOmiRyznDxzT4irYkzrVBSf3xusx3J0FX+OBXX
	YXuPK89mOjcdmFNF2QnNWh4szYJnSCEls5Jm3zJpvjg3bsuo1Do232fqw0GimHXYUyGKDxex77k
	lqiuKeVagFnntCMfl9ZjziRQvkRBPX+ZK1qD+WCUb3Qs3z6XkN4NPDlUp/OiT1+7dOEVfNHxySS
	hJYO83YEDVJj1n/LkY+AfKRAFTZtMogH0y98iAAGO7Gtmulyd5CpH+TJOI8RKWYLDJi1eDnPphz
	nFeWkBYbvUwJD5bLt1Rxv9JG/KQntCoiw61BUCz8IqlhVc7D9WoTHszAY+cD6hCParD1VvxrX64
	=
X-Received: by 2002:a05:620a:3190:b0:939:761c:4f59 with SMTP id af79cd13be357-944216f2a8dmr128857985a.16.1793316464807;
        Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
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
Subject: [PATCH net 1/3] net/sched: act_ife: encode configured zero metadata values
Date: Thu, 29 Oct 2026 19:27:37 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
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

