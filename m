Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C94FDA63
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676313; cv=none; b=u7avHY/3go2K7qwsJ9mk4Wjs0pW2BVjN8494ToUcsH7e77/ldn4D8afyihP3Bo4DrCnVhwUcVrzIo57hd1PGiiL/Fr8uGMmnr3oKKFys92sBB4oZzeSlcchIL5M8aog3rc3Y9jJuSi70So1iQp6W3z689qfFdcG8mBbqy0MG5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676313; c=relaxed/simple;
	bh=HO3kMzX3++941hDd+4FiOnTVZEiTsHEAJWUsba7xzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzQzPsXzfy64bCAnlWcczB5FYSHNicicx6SAawUMTjk5GiyA+mndnd5T60S/6IQnz1imVakuXtLyaaPZuwKTezM66UTz3CNByHQKwRPdr5Qf030AU1TKtr3v7ML6jQ5zX5kct77P0ONMHIuTs9nHiPAass/9YWnnsles5ATHKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EbKRY/5q; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EbKRY/5q"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-795a0ab5227so1249837137.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790676304; x=1791281104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=EbKRY/5qx2mTAd3MdnsYVSSU3iVPaZ+hMxYWQBF/ZXQuvXovtSYpijcgJF1/wxg9O5
         Djog+TegeUqewO6V3C6aIhAW+Zno4FcedSfBj3ds/aLurjUGBSkYA4CbfW8EgmEJoKVp
         5jVy2ykFO3UjywNAD+g68FV2NtJrhUWi2XYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676304; x=1791281104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=PQmPqxcO695zfE1SE7t6RA8UwZwiX+k4cFXLgrcL2lqMAxx/jJ+c/FKHQT+JppFjaO
         dGsrP8wdXhNzyboK5BqubHMDlinsiJZerN9zO94DT7IRlxG4KajY9A5JJ7+eF8G33YjM
         03PHy32ETayiNy/EjEprSQ2GS3iLis7+aomtH7NVw67EdpYfNn7b54+xCp4/Rr86hqOH
         gUb0EczPjz1DZhpc5CqUMadXLxCEX8wEcEe0soeokF5AAEVWgew7S92HW95vUNIlFivT
         W+0dd6RUo6GqPzpdTGulPr4zrihvOLL8CojjkzVW3dkEpWSSvnTMIg0l2/gTRV5J1vFh
         bDpQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/d7tdWBTNFwNdRVDAlu9+5Hs7adOrDdGbNySvKbJzI1+KRCgE/YTulKSwNyQ6M+FKnACiN6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhGGeesPULc8RMskPMmb1k3luOnIuaaoq0fxnLc/XyOd13JdQF
	hEpOcXSjsIyoEoxZ87zcFQCEVdLT9IT+mHeUnL+w2cQdXIqBd4CKW3Rhp3iK+GPaAg==
X-Gm-Gg: AYBFou0B7fTdV10f/JFB1OQI88rZIx3o+wl0wkHFxUT5KVawAn16YTNW9tde1gUnbs5
	F9IsCbbW8Wr+v9kLCJfLySSKOIumYKHh2eokWUniuknVJW3pI8wUFwVm7+denty1Xi+yq5wLJMH
	yS2wuReDlMksQyoKU/6SZ8IQZT+Cg0tL1e4YRFO8/PmtB4sy1tXISNIepn0shfau1uOXkgMKiDh
	vr5uPz6wbA8pA4wn6pvxifLzSAgseoo16sqIhJQ5mxBB7kLcrd2BPsq93jRR6zUl0FAywRuZuCM
	XlV8etXwWV8PJdGpZyWrO8tqbz490NIGEG90Pws1she/mGyaXHSRCOCcStAW9c3QMViOdhOtvfq
	mG7tfgwYVSkVUu++W0Fyl8m7/Z871r+eq/Vg+ZJ9FLWGatJ0H9Zkc6D258AQ6NbwDraf6A9szct
	ozM5WKRHQOoYqbRW862t2jizKlvnr+sK1Y/wUmAz8ZmZ8ORr5Uu9zaGgDLxQ6HQKEpGHmtqfebJ
	tmlC/wk0Y1LLMITRoc74+XjIvyOP3+6fpI1d1a1gBegHfGsAw==
X-Received: by 2002:a05:6102:3ec3:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7af1f621049mr4571207137.37.1790676303901;
        Tue, 29 Sep 2026 03:05:03 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm12764792137.7.2026.09.29.03.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:05:02 -0700 (PDT)
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
	stable@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 0/2] net/sched: sch_teql: fix shared headroom and header strip
Date: Tue, 29 Sep 2026 06:04:47 -0400
Message-Id: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two pre-existing defects on the teql transmit path, both around
teql_master_xmit() -> teql_resolve().  The first makes the slave's
headroom write corrupt a shared skb and strips a userspace-supplied link
header on retry; the second leaves skb->dev pointing at the teql master
while the skb is parked on a slave's neighbour arp_queue.

Patch 1 fixes the shared-headroom write and the header-strip on retry,
tracking the header length the slave actually added.
Patch 2 moves skb->dev = slave ahead of teql_resolve() and restores
skb->dev at the arp-queue reinjection point, so a parked skb names the
device whose neighbour took it and is delivered with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path").

Jamal Hadi Salim (2):
  net/sched: sch_teql: fix shared headroom and header strip on slave
    retry
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
