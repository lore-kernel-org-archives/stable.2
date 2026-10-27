Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087813;
	b=kV6FaqYipOwPlIFk7ybw6GKH44HyFk6gnZ2M/IXHNavaIIqMYSOC5U+a9ehGU2fzOT4y
	 Hrxv5NYAstvAGe8DrwHCEIlLkkMKJTODW18Dg3IqayiWnydem2uBlP08Py4xXquazYhxT
	 QcEpIoFFVUOMLWpf0xSzDE8sd0DABMm0ZKSPFLBABjOUVy34e492k1r22KMwKlQv0HKka
	 4aLGHudYqUBkDHiSmUVmzBF3bvGmAus2L7k6QCl5y9JfUWSpeEHkDf/4WPSm99g5Q+sy6
	 QhU7grfWfbE708OMyQkuzv072yinnS++Ah1QwEwHPW3oZLc67/HYMB0oyFrOeD0d44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
	b=WhDuMhby6bEZt2uLUYnKsbMWaEJxX4qVW10b+V3IwovjDwCcM1R3VS2aPoM8OJv0bsYm
	 YlcMg1+6fu3p+2u5Pwlv3AnyHXKotODZl7rn7kFRxyFcVqHsh43tGGV7HUDpMVkxJAWPm
	 xHfUe1w+wKO3txopNNv97f+5mc2nJoKIX1HKMedQFFcUqwTAPT+01kX+Lm0TJi+JkJnMw
	 ObKJsFhXzSBUkmHkdAiUVaR4fDmmkWEaWVEmW99qATuZJbYDhqsXV43t8zMnZXTtjlwvo
	 JzR8jbreNu3ofG9lHGl1K5Uv1oT+tnMJKqeSou9mPrR04N2DB1FuR7TZhE/rZBe/UcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kbAktSy4;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70F606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B70F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kbAktSy4
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e635220b4so325005885a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087812; x=1793692612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
        b=kbAktSy4Y4Ph0Zz/D3olPPlFSxivFRApKf0kf2j6SoZFtbI4KELhjoUtozjkB+Kxbt
         3Xqlf2QmdyOYYnCvIcd4EmSNjsW8oOrocOgc15LG7/tQn7ZrGzR7zwL8WQjUtpiY60ts
         EPZdSjMl2oJ/3UbppCs52d3cK4GyPq++1r1rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087812; x=1793692612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1A1q98MDq9vsGC0QU9m9r9Mp0Eo1mNt5bymoPMbu+28=;
        b=AY+ry4vJOPCkqFtQQstomNsX+1gI1eOgZ07iE1NHE6yuJbgtpN4Qsf2k26Py3nSwrj
         D52/YEqpi/fioLWbF7pt67WV74lFT50S3ZZv+uY5o5EIhFt/44t1DF9PD3ptuUNrB/Ou
         pT4dQjKQZU1lwnfu60HlpfzwEsdDt8VAKXhNrsNCy+tCw3TWYr92xHF/XvUAmiHCmzYw
         1GZaIKRHUnPtQBuvorhywAUCw3Wfb5TpCGvQU/+pr3GxwtB+cn2CrHlqPROJsKgn4aH8
         a8UU5+vA+nLI24ACuKoS3aSl29+uyyEyVkCOMJyi0EuclBlAMdks4C7rW97mvJrDZjXe
         j70A==
X-Forwarded-Encrypted: i=1; AKwUvBwUix6A7IzhSd0zTI6MgbJfvsiaUmWuLYqZK7fMbVcDI3rxsQoWD0g5GXwM5QMD8GKPmRhgrdM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHvbTetcAbWu3HPgV3vSu6cNr1yaxz7H1pwfNXQyPGJUSuQKaJ
	1ICjn6Q025WSgEhaURsvVaOH73YYQhvlxL8jieXDhqxWVWZmUKyIRYYyhNturINONw==
X-Gm-Gg: AYBFou3Wv93spHXjrr3mG+IigSszb465GhEgvBx2ZdrJ3jZkENbyR21TPOiNaQHzqZb
	8uD+PcG31u7OUp6FQ9t5nzRJKWvxSD9N+Z+/HCV5MF7jfOOaFpBE+VDxl5AZ9ZAwgUTf1z2nWRw
	5zD1XJcHCShPjLdv/+FZlcvYcOQ5BvPOI3zNFz0PFQauDUQ+KKWfcEU8oFQzwBNP0nNgAuDIVIE
	N0h5qKCSrt9Ypaoi7Wo7NwSipc2RGLravvThMq/z27hWG3AXVlqk5B2fTh4dp79nJTTJBv4m7Zg
	07YjomBsSQ+j9RF2tbo2Z+A2eFFTSlNdDRO7SZHPeRvTAWr1vTOdtcPdojDJLPRUh6KYJAXCkzj
	wWwgU+YQm2MAPEuSDUC5bWN+kKJjKggk4bD6JGIEWXyMJR69OjAizDnNrAUlrHRNY/2G8CmnuE0
	/JcqXiL0Fof9UmbBtBJsapK1xPiyGFQfi664QFMrrOiy1RpsBITb+5IWR1j7YOKxHls98PGnjk0
	M3Qf7GvmgKXdvAYDEBh+6h8KLbVOKGRZy76y5tgmiMwVbxh6yed+P+nsO7oLuPk3FOBhOUtWfZV
	s1C3jB3/+tpFvRD+c4XvPrh9ugJZ+3Fi8221/Zbakg==
X-Received: by 2002:a05:620a:4151:b0:93f:2ab9:72a0 with SMTP id af79cd13be357-940ef94cab0mr1365449285a.70.1793087812145;
        Tue, 27 Oct 2026 00:56:52 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:51 -0700 (PDT)
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
	sashiko-bot@kernel.org
Subject: [PATCH net 0/2 repost3] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Tue, 27 Oct 2026 03:56:41 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
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

Two pre-existing defects on the teql transmit path, both around
teql_master_xmit() -> teql_resolve().  The first makes the slave's
header write corrupt a header-cloned skb and strips a userspace-supplied
link header on retry; the second leaves skb->dev pointing at the teql
master while the skb is parked on a slave's neighbour arp_queue.

Patch 1 makes the header private before the write and pulls back only
the header the slave added.
Patch 2 moves skb->dev = slave ahead of teql_resolve() and restores
skb->dev at the arp-queue reinjection point, so a parked skb names the
device whose neighbour took it and is delivered with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path").

The pre-existing teql issues reported alongside this series are fixed
separately, not here.  In particular, the lower-qdisc drop use-after-free
(`NETDEV_TX_OK` vs `dev_xmit_complete()`) is fixed by:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

This is repost3 of the same two patches; there is no code change.  The
only changes since repost2 are the commit messages: the patch 1/2
message now says "header-cloned" instead of "shared", and the patch 2/2
commit message now describes the reinjection behaviour change for
bpf_redirect_neigh() and nft fwd ... neigh instead of claiming the
restore is an identity for every parker.

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
