Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477905;
	b=QkZryrblG5u8X8mKYE6fjOGfr6aL1NUcg3Br3XWkdAAJJKzlKdMk6fpuR5GWl/fB+IqX
	 /M9qrPA+jbZmTFC8jw/jyBPC4lHGuOdCqWrCrfFD4g+OVjVBclQWsfwFml/7AeI6k90nV
	 X5dhFq2NP+BffBkswUKNmM6Om+cQdae8Qghpa3E9MeofYJCOEGtbpQmFFYKRSzE/JeacU
	 ck9nEZhpeJvbtLwD4ppn/IuHRFzjbJF//qNUIAE0e/gRwcGjk6DXNfIMMd88fqh/Kr3eZ
	 id8XhPJyxb+tqBKkj9c9nX6MUODdP4h4aj6fyq4KPtyvDeCY2hBlTQnY/lIXhWpA/fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
	b=haWXpzGVuBEX9K15Masw5UB5KJGIzmt/7Xhy56nrHmXReVR4JgK6muBKh1nXGN6qe0U1
	 KMdOFr4Q/++beQII7fFFGq4vOnKO0LZuGAfS4i4mMqwj0NI+7IwxVTkAonxhw/Qdbk9/1
	 uft031BTZxyVCOPjuQir5Xzef+qfUVjgScFLhCSpEBTmzamohVGf2i+43mcqraI5O4K3I
	 T9ssxpoPg5IOrmDF8olBB3MJvtP1OvczhAd9w+UdnvZ2rdSzAKLUBUh2kebRnz0pOw0nu
	 t6O9TsnRbiJSXD4iL1DeQIsk9ACxuribzHbLgKe/C/3yr1kzY7cxw3oDPYfS2rFkB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rbr4MBPx;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF3606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BF3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rbr4MBPx
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b8306b9f8so31620506d6.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477904; x=1794082704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
        b=rbr4MBPxngkpyiwGZJX6PN/PpZGMkU9qxgaA89cikLMLolO+tzAGd3gNGPqkgDhjjf
         24LLjBlARVJHE2yWYzhpDVqXRAtSE17vJNiFztL8cn2RsBm9Z0J8SfhikzDR/bBWOOlS
         xfj9w8qbXnzAXeN1J78n4V3At6C1FDNeUWSHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477904; x=1794082704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
        b=m/R27FikkdwSwfOSK8gN0XPfKTD9GyITG01O6cWl1oXXFpdislggsHNVL6t5D7mYJG
         hFGQdhtHlk7eWSFCJArYYJM9LCVcRFafdKJ44SZjArT1x6Whss9Pm5NDPViLDYEI8pBk
         omsCwT7H5pfn0xdc6puhV3MpVZbdlFFFs6B1N2HHB151rVApEpBkmtBfzeE9Lg7gO7l9
         00/3o+ToDNgHIqmSNrzFEJGHrQau1Y+Dn+5Ut1MDmAFM8ukXsbe3ZtgEnkEafwW2f+Ch
         elaCiy6RS0OUr4tk3fF3v0rxVMXKRgOsA62Hyett1m4CeGXbIEHHWumLu2LTFbkG8J1m
         PQVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbGgxZ8hTOD0BPiyuzgZemHb0xY+m+uS9oRT8wnAyEPKjlffefEXwa1q1kBfWfojabVOOPXU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9r1948+sp+m4bB1/NGN1UwQ+P4fHnSP2Z+BKM15kMfOFgsY8z
	jPisNA5xRJunpnFB+AfGGlYNPQxvpBeSnDitYfX3LPUjXP+3jWTLmRsMXTtDgOP+EdOdmxJLyuJ
	l3ks=
X-Gm-Gg: AYBFou18O/r+JlVS4Tsrz2ZL5E6YvoA3FAi1hXoCtOGuRRQePCadyX2TECa6ytKapBg
	7bZ08whjQM5S4EpNJAC6wIpvVzi6zIVkPMiUoUGx1hhY3m+Tp245gucZY0uGD1Kma54BTHJHAes
	zuACQFhg+2wFi5xhRdL9iMbWGX2OLjieascDqRYmeVTLvTAcQC8VpW+MBrIu+tr6e6biU85zkAC
	ygth+kSVlFY/IT+QZ1oc5fPbMZc6Sqy17UGKMIE8Y2d/wp+GmRkeXiFfSmzNmr9STcQtG7X01uI
	vRzJ159DcTV6Rp8Ud/fly6+9vP9QMqyyxYPk2o/94/qkuI+Io/EY42edyBSa7CGJx5DPp9g7UMl
	4kRDWAgKXg/5luNMoP03Nl6SC0SobaoVWIM+VrQAjQW4hACyIFUZXQvL+x8ogPV2EH6txoqILkY
	57E/Uo7NXg1YzyEC+mo+uEWYaFcbu8HUlLYZ+283/qbUu1cIs8088jPdS6wvDRYzlbDsvIpPamJ
	kdqqGLFX8ejtekSaZ9N/WdVp2kbTG+Ax0SzVx/daqnW6KNjFup3f8bPTDaXU9p8I/XBIeJxxq5/
	y61u+vcDUWY6jOwIj3jIm1O8AqX+ALbzFia97acCXBnhN+0lNnlV8mOa9CVF4VU1XcO2LBdbq/8
	0ekJQMSIoWbwcOP4=
X-Received: by 2002:ad4:5cc5:0:b0:91c:524:465d with SMTP id 6a1803df08f44-91ca4b33165mr97889176d6.9.1793477903732;
        Sat, 31 Oct 2026 13:18:23 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:23 -0700 (PDT)
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
Subject: [PATCH net 0/3 repost2] net/sched: fix short-skb metadata and namespace boundaries
Date: Sat, 31 Oct 2026 16:18:17 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

 net/sched/act_ife.c  | 13 +++++++------
 net/sched/sch_teql.c |  9 +++++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

repost2: the repost1 posting is withdrawn.  3/3 carried hunk context for
teql_qdisc_init() from before 8b2043279dae ("sch_teql: fix slaves_lock
IRQ deadlock"), so it did not apply to the current tree.  This posting is
rebased onto the current net tip; 1/3 and 2/3 are unchanged, and 3/3
takes the new lock context and is otherwise the same fix.

The series is now built and tested against the current net tip.
