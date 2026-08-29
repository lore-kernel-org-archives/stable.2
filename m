Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD83955CA
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991178; cv=none; b=IKcGcFCB5rWXwwb++72fOg7nWgpknvwyNbktrOFDVRaHxC9n2OB5pEAoGngKXpDdtimvWFFsco0q3deU1wGeRMpSb1yizG7zWHzpVpu/Rw7Ltop4baSkTWeEBhwGGD5L9z0pUGMg34nnFx18IqqhsQ4zivukd5qnYWHujcCSemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991178; c=relaxed/simple;
	bh=xJJq+qu59CIgAFBX70OoZF0QMFnunCrjGpr/OQ2qaXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW5IqaOa41bC3OGA0Jx854ReXJBEEjV8+iCUJ7PbRCWufEDRomjkgZKC7UVYD7VnkS06Xcfp3rVDLJBdiMEMzwDZir3yVrEAULrMcfZTXWqy1KvtI81eKH7DyorI0Ar1y+eBxEFJh3L2UTUCCvVwdz8vcge7a+Oso6A/5HVTjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=baSNxptB; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="baSNxptB"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-939094306b0so138577785a.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991175; x=1788595975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewXN4Cy/MCA25PIkx/8RR/jYTJiHRqM+WzCcLA5hBW4=;
        b=baSNxptB5iJVR6ROiaOWy2OqrwodyJ3wVZJmsE1Jeg/bydKwjXM0eAuMJt98TMcX60
         Q57ehHG8jEK4zPXPtTTWoCSYhQcgEfUCSJfXNbEY02tTaRfPyEn+j3gkdFRoxmF76NjO
         8pKNQVApOXeZwO4s/zqmYEy/gMgro9Hmwrx8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991175; x=1788595975;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewXN4Cy/MCA25PIkx/8RR/jYTJiHRqM+WzCcLA5hBW4=;
        b=ZLFcChAXAVk0fED7zjJqWLLpc+9GAGJV8skXxizPIbsaARl3t1pHODpCtVOsxzeoT1
         WeypF6HZZiegTpZS3nBir/aetpdwnVeelc9PwE8sMkM/xL9r7tKmW+BtSb5Oh7RlsvBs
         obA3SZKO3aiUKq4xaFpDav9uJe4uMfv6n+WhhJzoLG54hi2QDzphMVf1c74E+LfLhHTV
         4Ec3f6YxzmBjez7HeFupifH6uj+Tm9fZEtoY2WEroaJgbmpPmC9CGxKQ1igIyvWXq4HF
         n/3HLFtSNCh2xhDOpez2vvBBnrPUhCblGNoR9/PHOt3250BAl31aCMrKFqEcpL5H9+IM
         Q4uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNO6ileS5gbaEH5v4Vo75gcl4PXQhV+j2sfepNKARDNAVdsov3jrlGs7jucjzR/jMAt6fQeAc=@vger.kernel.org
X-Gm-Message-State: AFuF++kVb9q8CG6QKI3VYRs9ah2dNLolAkwgDmHbs9FUhRpBGu2qupu7
	AzPyfmPi0NhUAJlXDc+DWKqdlrxd0tanocN3HFUTP1t9hFVld1CwukkmmSJFxKI1Mw==
X-Gm-Gg: AR+sD12sM3jpLhc1/n11zLGM1FzWfPez05dSo9QgLd7GhGwwpFwCLTmqqmZV8lEFXrQ
	jGqWJW6mqIhyZuFzIdq9inswaBFk1x319LAl90cGj1+zDEEWXPZDLHkLXq6VSSV0SGTCbuEostM
	q0vKvX1QpvHvt5/ndApKjjeyGhaam5HeG2XUyHym0rJfhRl7Tc1m2uUxF4RLjojLUTcPkrO+L68
	sOwxpzgZ/TDRwIhw22BA5tfautzNxi+eWBvWgahAviQDsPG7cCtSpybslzzy2dI1hTNmQcrx27r
	b1l7HxIFi0Q/0+NekwqyTGizCtYPbTsaK9APtncCRsq4beRwrChRvlC5516izxSipht1nkOkT0o
	TWCdQjRH9PIAPmV953vlZVpSBIxbrHyPGWu58GmIm5ueCa7UBeq9BIAoBKd3T8/UxS72s77XH4m
	LObhnDAfMKtTcQ2tLuD0NVbprI1bLRRbdH/JufUMikGnkUbRNjQouUZ6ez5guwaR4qkgVVvpEWs
	htaOYtOeQh2G+C66htkVZw551I1CUP4LeOY2xw37FaxMEsoX82z1nGRUc8otCD8uuWHjq0GNRIc
	IZvZ/AvxM/QIHeVCbOICIqfHGdke6cDYIRUgvA==
X-Received: by 2002:a05:620a:4553:b0:934:970a:beb2 with SMTP id af79cd13be357-93913904111mr1384267085a.26.1787991175573;
        Sat, 29 Aug 2026 01:12:55 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:54 -0700 (PDT)
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
Subject: [PATCH net v2 7/8] net/sched: drr: clamp quantum in change class
Date: Sat, 29 Aug 2026 04:12:28 -0400
Message-Id: <20260829081229.81708-8-jhs@mojatatu.com>
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

drr_change_class() rejects explicit quantum==0 but falls back to
psched_mtu() with no floor. With a crafted size table qdisc_pkt_len
reaches ~2 GiB, so quantum=1 (or a zero psched_mtu on a headerless
device) makes the deficit-refill loop spin under the qdisc lock.

Add clamp_t(u32, quantum, 256, 1<<20) after the zero reject and on the
fallback path. The explicit-zero reject is preserved.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DRR=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root drr
  tc class add dev dummy0 parent 1: classid 1:1 drr quantum 1

Fixes: 13d2a1d2b032 ("pkt_sched: add DRR scheduler")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_drr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 91b1ef824afa..8621d057edd9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
 			return -EINVAL;
 		}
+		quantum = clamp_t(u32, quantum, 256, 1 << 20);
 	} else
-		quantum = psched_mtu(qdisc_dev(sch));
+		quantum = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (cl != NULL) {
 		if (tca[TCA_RATE]) {
-- 
2.43.0

