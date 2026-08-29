Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3D396D09
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991180; cv=none; b=IXZ8vDEcd/TWmgd+uYCu4ubL8qEsLwz+/GxJMLqDiWyp3Rq7fcQo9jmSPHleYYKvDIyL5GvKQam9S7zJeE0FWmeRNrGU5c1l/x1gHQ104zYPONf7o47cP8lf2RLUz4107UQwncS5ef6NNkmUCSCGLOyvbvJ1zkbc0d5rdqTHZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991180; c=relaxed/simple;
	bh=tgM+/vif4IndBdzYIROMPmudyi+lnEmy6tRTUg0iENk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcZZyiVhGOBeQZpUdvvSx3GEV8eOHKXe0wxd2aPdnkKZTqnqoSzgQkuAZiDZ/Db7w9n2TIu8vFQvdg415ADRRJtenlJuTCh/2FekvBvALsO21V8KvsUzvWkuDFHyAZXjcEd0aXs9xkz/cElA5BKWqXQO6V6DlR8I12upRhXIk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bZGkzHsE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bZGkzHsE"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9382fbb1208so167197885a.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991177; x=1788595977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2Wk3KDBvf+xhI7Wj9voFZqhuogoicBGWeUleikTbVo=;
        b=bZGkzHsEDU1FjVYAY8G2uO6JzaXXkxIZQ8nYDn74roZEaDVd/hjUcF4DCLWJodUHr5
         /lgU2yFNd0j8yK2bGgzUnHV/VhHs39if02gEXgTFqMZBeBLMOb0wufh1pA18G+uY0oo7
         2lF+amawgqUP/I2CRyh0HL7XJZEn2qID0SfM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991177; x=1788595977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2Wk3KDBvf+xhI7Wj9voFZqhuogoicBGWeUleikTbVo=;
        b=ggO3gPzoF2cSZgZQfLE2vkLmOycdcKETpSvR6FH3ssxJMuEnMpsc/7Bx+CQoelcHvd
         g7o+QWRXnpfyZFW7efipRYnUwhRifPG8sbQEs/BttGtm/oT2RXQVKAg/1Okc9cJArQzO
         HL747xCUaA1y0+MJwPlTmGDW2UlZdg/xMyGlfYJldj7djPcEdCF997292TtwApbdm8sR
         DjS5HU3fWVrPoE+svWyr3GrpYoI7B7n6p2ziGP0C6D82g1HqM0HXEEYyCcMRDC5Fg55R
         JdUgUsiFoX1w4Gwb4pSHEZVY1GXPnqGEuJTcAPTrGohOLd1Tv+hNK37L0F+1b0eQSNkX
         X2zg==
X-Forwarded-Encrypted: i=1; AHgh+RrrPVTPfSBObFGNCwDo5SNbi6SfMogzSe1ksNMb8Nf8epnwac3/5I1a005TPRTCr8Z83VTWyYE=@vger.kernel.org
X-Gm-Message-State: AFuF++nlEnf0oKP5l4f3kaaI6P9S1PdsGyySa9Tv2Et+lAGfmM/2PTrv
	jE21iVrnO9rTDXjCIyh13iGQpuMftYzXOgpy22MctqTrLFmfTwqe/6XD+jtsB1Js+Q==
X-Gm-Gg: AR+sD137c7rHdFYfo2qdscXkkD2ssex4uJnFoWzA6Gwey5Log4gx83dojKyDTZyjbqp
	Gtj8bUh75dwewSxm4J1kE2jAbGym/MUK4JyN3LaxRrNsWNfM065XpMCBPldyP1zHWGrzk5F/Da+
	WPOZi0kBCiCKtaegkm4qo+C3nYfR/ofTHB5N6AMLDKeu07KZIBx1A7B1glCru92oz8/QOhFyHHb
	yMIDFD5UTRgkD2GRonYomyGUW8Vi2WiqcMCj2XPE4sDrZbK1ckR/CDr/pzN6KLadllWdUDQImVx
	Uk5oXTwVAPwNQZuIWZMeIJLJP1q2ABFUQg+Tnp62dbmgvOEe1a38e8yiLAg5h6tUxvinJ1UtIE2
	uVqQ7ETESxzXwKIE1RjbAj1YLQf3D552+vc3FdrzWj70bFoWn8ig+LNhkLQcT4/zJuj0iIkoNbL
	RjOjJz+qRwq0OMIRLXIX5muDhvq105Qz5oC66aMV64oTW+VMVAX96Ry4gtrW+/823pdUUcPjZd8
	cFIifRQz10BsLUo4DzUwBgVWUT8+VQxCUC3JLZ8K4sILirb9ixY/tzA4s4idcdL8Qk6VkWU3li2
	a3z8o/YL5vlJPX3ZC9L/4BE+GD8=
X-Received: by 2002:a05:620a:1b91:b0:936:ef9a:deea with SMTP id af79cd13be357-939138cb02bmr1583948685a.28.1787991177464;
        Sat, 29 Aug 2026 01:12:57 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:56 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and fallback paths
Date: Sat, 29 Aug 2026 04:12:29 -0400
Message-Id: <20260829081229.81708-9-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ets_qdisc_change() falls back to psched_mtu() with no floor for bands
without an explicit quantum. With a crafted size table qdisc_pkt_len
reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
deficit-refill loop spin under the qdisc lock.

Move the floor into ets_quantum_parse() so explicitly configured quanta
are also clamped to [256, 1<<20], not just the fallback path.

Conditions to recreate the bug:
  CONFIG_NET_SCH_ETS=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1

Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_ets.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 25fcf4079fec..6cc902a03838 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
 {
-	*quantum = nla_get_u32(attr);
-	if (!*quantum) {
-		NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
-		return -EINVAL;
-	}
+	*quantum = clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
 	return 0;
 }
 
@@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			return err;
 	}
 	/* If there are more bands than strict + quanta provided, the remaining
-	 * ones are ETS with quantum of MTU. Initialize the missing values here.
+	 * ones are ETS with quantum of max(MTU, 256). Initialize the missing
+	 * values here.
 	 */
 	for (i = nstrict; i < nbands; i++) {
 		if (!quanta[i])
-			quanta[i] = psched_mtu(qdisc_dev(sch));
+			quanta[i] = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)),
+					    256, 1 << 20);
 	}
 
 	/* Before commit, make sure we can allocate all new qdiscs */
-- 
2.43.0

