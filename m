Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852460;
	b=S+pd+8YRO9pEi/gTWGGN25WQziu8wzd2VvX3K9P7HtPnmIaTgNIeAONexUqhOs/9dp8r
	 rS2X4WgGoO8oTiJZ/UMboNNUdyk+97rcjDWRRxyQeu+2AcHrPLUgXvlfNTa70o8DPuJmy
	 nmXi8rqJUp2BzvH/j0NkZgpmKXaUL+YTpOLuPC9vTY0/Hl35jHm9PrMMnUJ1OmUjpFZD6
	 2Y2Uc75cZJYlUSTr3gxj1AccmL9CK7stmpb8GMjXVcCRytpUdvJP4kQDNMbu+0FeRAKMM
	 vGj5W3f0qKdKgwc5dnrvTZU5SfATsNnMe7U8G9FAoPCa4RiOM9ASNml+dDJWKY9E1YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
	b=Vf6QWByHt6X+/5M9SRH/HfA+SgAjOHCkhRir+M+X8Loe3qlDTMSpFgsVEgWNFX+RxUz9
	 7sGLh9s8sHHFQj3p19Kj/mJ9QXUj9L5q4FcTq2ERtTQBxg9G4AZo2z04w5411nQBEce9l
	 Hnm2Zt5swz/OCA0vSLBeEEZ+zFnWohpAYGFTVmOUvGtemOoHuPJiZhR0oR1PcRe+Zd2vz
	 HGAxBqgKofK0ntc0cSwDxp5QhX5Rueq3wXNXXJcrjGRu/eqO8ZzmM85kcr0BVq/xL5z0r
	 JgRUufgZZEgVRa399B40+cb3MQrofMP0gYOOuTNv9L5VoaJdYNN99xA/w9eY1QwQabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="hmwnA2/O";
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A24606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A24606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=hmwnA2/O
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c3fd7bbdeso16920546d6.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852459; x=1793457259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=hmwnA2/OJ9n/xncS/E3SJjMDVSDSH6oacFhDMtufChcxgndQrzMsi5sNCPTrsu5rRB
         IO4KLr+vFQBJmC6DvF9xoXxFGWLZzHko6ToSCXi0PbkrPUSwJwvRjL5rTtQxHR6JbW3V
         skNKXUbDDIO7e83+gtiqvAJSE+NW8VoQLs+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852459; x=1793457259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=RgmCIcHquqC2vlhQeV8LWvENXEYoYjEncQjFvDUqTcCdBH7DPdnlLcFe+QYKsA4Rkb
         vIH9LfAk37PpubJEghnzWQAueg3FQYQG/0vdCT6Ced5BOi0pAedvisMQvtEsBjTC+hBu
         FC+Q0sUtrabW9xpysURw+UWIkW7cXmXV9A/l+Yan7tkwwXdQMPMUh3gLPH/eSONxFRbh
         Kxil8zAYrBlfD0kl5CWDrdes5kS8YqZL2jcvW4Udm6o5yCnZ+89G9t5PWWoXpnsBjqJA
         Dg8R8gYr5CLZ9RkL2la2A0y4niykUaDosRlt8Zka/kbKddyN9cutvXMCLQu1M0oT5rA6
         SMgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+zq6b5jEyXmzaDtGyNOhMpwiuyiarznYGK/UntcgiD/bey8br9UMu3blNjXxTdvKLVCDCwIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVpJq8FiBmMbN0q91JKMedQiWBFuwikhliRMLLjxVLjFTUr0PP
	+8PHA2l94QJlfM4aaftTMc9U375tyOBDQmsTSJmA/5bjUMCPB9h9PwdtgO5r+LTlSQ==
X-Gm-Gg: AYBFou3AsSneUZpG9GYQc8EAAPMLTyW8lBD2iFgoxISUurD6aGEce863wOoCfL3qJwE
	nR/eQ4+axnqFDvjDEERCa/q8u5pUVT0Kko6QnXX+7UEo3Sjk0lOMyB1gUaGTuEEd9BsKN03Cd/j
	WQjTeIAgqB6984IL/yjehs1JDVuIH59TtcunD1El5ZPrU5JQVuMKE7RVecgGG3geG9T2BtRg/MF
	A1aR6FZNDfErXGHv0Q9iJagL72UoFm0O88nsVs3UzgZg3lznHBtuCMG8zHGmZhd59ustIvh//m5
	84Ql4PkKV3uOCvafSv954+kVNiGJ8650Uxear2na/TwjITbz7PFii20APjNSYaxzKxoSAY2ou5q
	ud1+0oK8dluFRvNS3MoOVRTj6EgNoOJpUMydI/Vou4mbtNZlu9I+M+i46yDMd7YNW6MfM1U+MeP
	S01BbTkQggdsrYR26bdNHL2IwngQoYClzlLkWvkgn+zsObaQlFeZtxPA/d2AuR23Bwaz5AqNaCU
	rC63m0JXzAFlJkRo/DsDSlXTV3NrCxnktdH2ZbuNTVA6eRil2wgDWERINnJxAYR8JwT2LzXxoOs
	kegt7i2s45WNT1fBxVL6pkfj1J96zZQcXt6jOVGY6ak=
X-Received: by 2002:a05:6214:da4:b0:91c:15a6:ead5 with SMTP id 6a1803df08f44-91c48e56e21mr32544566d6.36.1792852459348;
        Sat, 24 Oct 2026 07:34:19 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Sat, 24 Oct 2026 10:34:13 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
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

v2: resend of the two-patch series.

- Patch 1/2 is unchanged

- Patch 2/2 now fixes the drop accounting raised by the Sashiko
  review of v1 (both providers): only NETDEV_TX_OK and NET_XMIT_CN
  count as accepted transmits (CN can accompany acceptance of the
  current packet); any other consumed result, e.g. NET_XMIT_DROP,
  is charged to tx_dropped instead of being counted as a good
  transmit.  The skb-ownership fix is unchanged (Sashiko-gemini).

The v2 revision follows the review of patch 2/2
(https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/)
and Simon Horman's request for a response
(https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/).

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK, and stops counting
those consumed drops as good transmits.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 60 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0
