Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8837A843
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677006; cv=none; b=VYGUOez1Jcc+kAkLseqXdFI9Jc6gmoASP6hx2lSq6rCG6pMsWJW9ydJl2hAxMHonVUgAYJdbGjDPYWPS0bqn01+UE0QwR36h0lOFR2xEoAThsfPMEWAQb3oqp+Ur5TqdbM6SGgPxuMGDigJ5FhThLMx/Zd5DjCMU3eN1q0K06DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677006; c=relaxed/simple;
	bh=HO3kMzX3++941hDd+4FiOnTVZEiTsHEAJWUsba7xzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KnSe7rdX7XKM995imbP/bnwRdOkiiS4tDrykogd85rbM0QnZgcYFytcQs+C8L9YViW4yT8qBW5BUQJR/2NAykIzhOe29FOuxTJ/vIPWEPt+8CKAI4Lyvt3dI5Yiq8nm8EqGEEcSgdloZ29FPXCi5nkXYDuoweIMjVX9RVcC2Vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ufh/hhNC; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ufh/hhNC"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b3acd242adso709127137.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790676989; x=1791281789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=Ufh/hhNC6Wgp30e4S0p5ZET/FX37yjeOVhmXJfr0zkrwaQmZTqtU/VT5LKX8s41Zo/
         vzjrJyYbk389H1v7jYR4y3qJvpYuZ7S3ha+uUfKDTQ6eJ5bHbRbjfljmSReZNiLc/V9v
         c6OMy1DPyyD6BevDFZpq/2iBfgzDwH1wb7E1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676989; x=1791281789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=TFoWofoRofvSy5pHt+327UWL4sgBrnACB5NQ7Xym8caiR52iCgUMLYl+b37EAUEu5U
         jMVHBmYg1x0FDIpjqxm0J871L8TWoVE87lY6jBeH46nYPTc2pGIQxX19MNvyq4Xr4Xj/
         NKEg4ce0X1Gcn4VRp2Y5SshNm/dPugtcIyb59SauCwrh1WFCso+s/2fW4cRmN4qCS/D8
         nI5pwXPL7H3yqQWideslGruzUaOP983LT/37JBpvieSu3gpxWblVXXoZsn1VZ8Q5G+0T
         yKnpZ1MYCSzvjcZXbXcTGsBj2UbQC7af/DBr847TDxtltZsGgzhMIoGg9tol2yub4Qru
         4M6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJJJ5/T2kYbmQ25QIoXCFUsfq98kVTVieH3WgUgx2EqgMzyU7P19O3ZuoCt1sqSPnp8HgQVbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK/6uGSqn30ZdKrfcftaoWY3dSxAEm6u040aAq1KH6oKsYBQNx
	P5RVc0nffYOL/SOy5ByevX8P3rMbyHkksEQaa97VgjbPTqlAVM8xPedDSHbCtVUprA==
X-Gm-Gg: AYBFou2yhtHdllclxrPlrK/xNrnGKowPFjwDlRVtw/VFSalqgJqEv+0hz4C890wrfKc
	dm4P3VGUR1uX889XJ0aQkbGy60dnygiPF8oicnBcYPwAS0OY6uB8RXSegEWOg73FKw1S5NAM0jN
	eo6+ID1w+tftQT31Fa8Ef5UZyCJVG2bRL6qIZqtVapx4Pb+wLi1U8SD2yHllAOtN57lDQHl70WF
	oh91BvZzcZfL3L6GEWRkDJ9PKxwQqzOXI2TugPUPuKZWoPLcSYet+OKok9qNngVKcAg7ZhQvYmF
	3tvt+Bf2iaUYOX9a282JFIZ+smHBzX2Ui8DCt517FCSLu3E3LMDMw6Pgd7blXeGbaSlHNrP35G9
	ewAJ1c81OpSV1T4McIndlOS/u5BWVMh8JFP2jzpRJ+2Ajta+NoWcEaorje5xCAQLYKTgwvvG+V5
	c8lqZd68XiYKpTcV75yyEap6E00yVUD2pXlsZ/yDtzGK5CkmFy+zIrR4IZCobIJOVVWmDSEe7/2
	+Rj5doi/cd657u8x3Z+mZ1MSohEmi3Tk2Px+0m9QUaH92qutA==
X-Received: by 2002:a05:6102:a53:b0:7b4:740b:9b6 with SMTP id ada2fe7eead31-7b4741a67c0mr1736414137.26.1790676988044;
        Tue, 29 Sep 2026 03:16:28 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm13134189137.5.2026.09.29.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:16:26 -0700 (PDT)
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
Date: Tue, 29 Sep 2026 06:16:12 -0400
Message-ID: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260929101612.1WFW_KNa_AcaNSXi8zeurVg2F0bKcbxsQicEDHfQkSo@z>

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
