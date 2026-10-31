Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475367;
	b=vqoROrv+U9i2HN35xVEbkoodi5qGniSV3/U+in9PJo+nx0X8hGrGFCfOaSBMjMzjQ1ec
	 QIoNwdQL2k2R1hG/6xoPs4RWGOQ/V8eLme4cKzCIOE+JV9jKLUQDsHNgnzLxQ0lJ39kWJ
	 R1spAGWu05YG5J4AIbgqLDlKZMselGDZ1Bt8fKwWrVhDKV5C5oKvDgCtirGqTAAXLPE5Z
	 5fUPAJcUFK9TpattALm30Slg6IRIX6RXH7d15LVZvdeQu5vTFmemKks/E4D8JJHC/nM9n
	 fce5kuZvhl4OR2iXGmFg2uEHbcLg/j+PezMt3GEFTnCRWyviZcmiC5LfOUIhBzDfznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
	b=HW6HpVyxd1jMBrl8ny3V+09krUxnQ8XzsPny00vuJHhbik7Rav0f6VqUv2NaGyz3Ttc/
	 1pIJyoNiu3UOB9Pfe5omIL64p82PkE6DumEmoLRIUtD3O3i/1bFLnvS7JFZ52ia7z8vrf
	 R56thQTlpT5tWqXIC2LGrovJ18QG761qvQbdQAl8CNTWu8woTW6i6c8HSHhHjzYXZihwN
	 9gv61YoeCT9PPy3fXaA6OtTnTG0X2393mpjT0DrvzuOICmJ0+IsRxe837C30bY8D/yv+B
	 M9K5LbPTolNUBR2k9G+4ACB/yKbTN2lnXJQmThwglOM7fl6EUnw9/UFvmJim/Z/WVJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eBCqAneR;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252B606A329
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A252B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eBCqAneR
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93efc0452b5so118671385a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475365; x=1794080165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=eBCqAneRFI+RfXKoey8DrqbVsgcPFCFEbextDqCDUvKwj+iI1EAeacEigL8Mj/lE56
         WsZU40Yg0muBrXpN3yHg7WGeJvagMn3vyhKVV7ULktWsY/FxsDMpsWPQKz0rwzlkt9LB
         YffDbH3m5WfEAITuyigOC8Mayjc8OgBWQHAjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475365; x=1794080165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=UsUgRQ1pXGuR9hoYe7Zkn+ZAZIYZiEzWGVFgEeaznLodGE+YUdi9rVKdWZB6VpvpFe
         Tfu9EDT9d5TgVzEaprkcvzyvcd9CbCO6KeBrrzYYgQpX+V6bdntDF2lg/wFNDRE5n23Y
         CqRy1a+731zEJ7WY+K7iNqk1Akjv3FcOhaDCKE9QtfyxI2+6XquU2JzV9ooQFgtxyG4U
         KT9Df/V2bHWHSTt6C8FykW8F0Yif2opeT05p0m0se7uhYYEOV+QKipuunpXAEaRg/5PM
         hDt/gSzg+PO24hqWN4+ysWRmvWKA/ZwZSUGeujHV8cfeRFUOv0zka93MxRVt9aodtRo9
         a8LA==
X-Forwarded-Encrypted: i=1; AKwUvBy4bk3ixUG4RdWXEdo87lwlfzhxlVcFrWD8NUOLB6B5k2Uj7vIdUBBd8jBqT+0YXk/YE+8Gvto=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBVARa8kMa1b23Tk7Qy/YcktaIAibWQlRSwdRBRZd5d3ApojV7
	NcPkk85TXuPsL7HW3cmPFTdRf9ANgYz9B/36vLFshTfl2St538+lQXAuT43rcWGSow==
X-Gm-Gg: AYBFou3+/x2UiaR3SRao73ZCvniErMxgbAT07LDb12IN9J4pOT5Z65mTvrhbYRwdmQr
	L+rrTl36rO7hU87iauXf+Bl86Pq2+ym0i7rpmOLyZ58bxZba6d2LAi4BNOzPEru0by+gyrK4y4R
	fM1v9AOnLtIAeUMHaCdqTI2L5gDz9UsddTq3ZN9jVPb9xm6IoyRBhfzcIor9AfvA0suCSybzudJ
	rfcEhr0Og/9kSDGjQftquwVRVjTi8E/mU8a70hVOKIG2xc3G9a5O71QNy/eFgCPhrAlWT17Ru8K
	BoT4viaKO+EWQ6Zv30ODFKbi5jm2NyR5ZY1RYsOgcjd5WsF5sIq819sJZpDqnNxaoartlLctlCP
	LYr+153s9QuLVtt1OHfV/WtLrYAbDJsTnqvqbDE4yBRXgtn39k0oLhSPTgBcx0+pEu/IdkU1kOV
	UBi+3cL6LrEpogltBgXyaCzJxXi28MKv6y3CWvyjZvHGd4LL5igck/etQ6bt9oY6pzyNggu/qAZ
	w/T0gI1Wr3KvQp5pKDBHtE3+GM5E8imvCCFn3GA3F0QAMjBBj5rRXXB4xDxaQSUDdV5ro8A0qNV
	0YGUxx2ehFgoT62DJkD8nPLlrBnBmI01bOV1bqDjMy/3m6SAo9Y7Dmafp+vAaoK4LwWRLgA/+EK
	GCRUcQQwZ0GFG3DM=
X-Received: by 2002:a05:620a:27c3:b0:93f:3576:d428 with SMTP id af79cd13be357-944216b0c4bmr918024685a.22.1793475365487;
        Sat, 31 Oct 2026 12:36:05 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:04 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 0/3 repost1] net/sched: fix short-skb metadata and namespace boundaries
Date: Sat, 31 Oct 2026 15:35:57 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes three independent boundary problems in net/sched.

1/3 act_ife: encode a configured zero metadata value.  ife_check_meta_u32()
reserves an 8-byte TLV for a configured zero value, but the encoder
returned without writing it, leaking stale skb headroom bytes.

2/3 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/3 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

Origins:

1/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/3: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The three patches are independent.  They target net and carry a stable
nomination.  They are sent together because they share the short-skb and
namespace-boundary review context.

Jamal Hadi Salim (3):
  net/sched: act_ife: encode a configured zero metadata value
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace

 net/sched/act_ife.c  | 8 +++++---
 net/sched/sch_teql.c | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
