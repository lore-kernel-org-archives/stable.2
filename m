Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099746A5EC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298803; cv=none; b=F8nL5MpsLRb+AHiaq+gYhzp8Nuu/6pttAbI0TxEHgccmK5JUQmpJ3VTgWkKR+1IzM3QQ6D18f2VTLTuYmoEFqsYFWcHqVlW1RJLc2Q3oK9vOv6++VyJVuNMH61MqboB12vDjalAhLXw7wTl2gZpZOpibR7qjaP6BVtHi4HWI2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298803; c=relaxed/simple;
	bh=TpQNl9DbT737cmBgBP6QZeX0edXbQA8wj1Wl5gCqB00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bq6B5NNYxyI44JbNp2IoHyEPGHP34RIIi+rPPgrTlBUelImaKD6VNPuDH5iPQ9oRWvZNXr9Zn6knSbAmmzbYwknOw9fFSnLh8Q378LlqSpDShQHtsErTb1N4w8nm9F0TlqRezpRI1H2YtdBq5AjTqWOivHRezlGNSNe0NO3R38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W2EDEpmM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W2EDEpmM"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cd0e6fd80so3475716d6.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298800; x=1788903600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvsUEmfZ2TKaJs5KGDPg2m5xcrkKd2d3jmYqxtr6okk=;
        b=W2EDEpmM+/NBqx4HuujJJH5JV+ZnHGMYM56kmVh8BhLEx5Q1JTLsZyr/Ouf2VCU8x4
         U7PLv3aaEaL6yhDfC1oUe6SF3c/YraUN4qKFuVSOd4wpi16gwQva7KM5vaz1YkJn1gQf
         Y1l7vE+sIEi0oL2EeRY8y1QoGMpLEL4UyJZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298800; x=1788903600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvsUEmfZ2TKaJs5KGDPg2m5xcrkKd2d3jmYqxtr6okk=;
        b=MmuMujstHJx0Xw0ZXOM2oXed3BRbWF0YFl8BmnFe8asiomHRy4jV8lxqOU5j9tfbOS
         d8Q8MG15J2ppyHWHdF1CgaclkHQsdzoU7eDd4RfFPOF/ja2usyxvZL1olqeA0xx+hWTd
         hiV+lUu/8WX75OWUxn//PbRbLQuDKZzSSp+Gg0+0AxKZCpObPVPV3ijkGp8VK/T7e4yL
         VLlYAyH9/TWcwDM8fWTKWhJB0roRNl1PK5p75ulhi7O73QG6TAc/yo+ilSfrLuNk9aQC
         i5h1dltAgwfzCA+b9vBoLid5hjO/9rp3QGyDKLa0kHdegm8/WUYG2J6RCBU257wB2eUQ
         o8Zw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4fZzcg9qMvWtycoRiVY/WAITrkyj2zvPvRXgEiWlI8KqNxYXQGk6eAhj9nGhQ9GCpxnyp1xI=@vger.kernel.org
X-Gm-Message-State: AFuF++mKtja37BrM4SIQvFFmq3P3RhdSCg0a6EtALUXgBtWCprpcSkbr
	WSR3OuG+gfMzLdy2lOryNKWD2ci6uTsB+NF8OeH2i5YHlv4DJRnHB/l5jP0b9annpg==
X-Gm-Gg: AYBFou3xrpF25ppYxPvJPNbW80julWGDJzt0f3cVE2vuXiIB2y1IdltI1+hWUQY0nVQ
	bct97YWHdMwh9o7GDe6aeQnGnk2WmrHwoHMMzWjHTSJ9adXlszoqO9Q9x4UTAH7yDNOxxSIqNos
	r43YeLS4FikKOvbanp9hdYgdvv/FFPyKqiKa3Ig48Ur5/PU93ccGpjyGemLSdGHxvo+cKM1LG4l
	i+68RTZoac8NYuPGwpGTndWQmVsgQ644JU0JXv6DAfoD8nU8SjAW5OljWee8gHpFYhrmfPXCusf
	pPwL/aUHLjYWC0wqAKVpsLyz0BKKJFNP68omzye0e7rsa2tP44crUvHBBY008ja2GTuXEp2ALfk
	5esdN3rxqtH8YSO/Y8Asam/l/Qot9TEdon3WrvGHwASM3Cy6pGg6PoIdjvTJm8r/glSIJttSTeK
	NHNeiI/UgxIAesZXNhja4SQD2dWhh10VMXrV4ZpBW5CGM57hLysXLM27LC/a5LPSXzuv3wdaOOD
	oLSpEVqSZt6Nbps4FtE0p/6jzYLik+Gr2OImQ==
X-Received: by 2002:a05:6214:4a89:b0:90e:7fdb:8583 with SMTP id 6a1803df08f44-90e9f248577mr11782106d6.8.1788298799909;
        Tue, 01 Sep 2026 14:39:59 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:58 -0700 (PDT)
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
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 8/9] net/sched: ets: clamp quantum in parse and fallback paths
Date: Tue,  1 Sep 2026 17:39:29 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.9>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
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
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
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

