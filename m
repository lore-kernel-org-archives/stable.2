Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492712;
	b=k8tGKrBw6SfXllGQlbwcaZE2KsHAhYcinWK9lxHRasPDWnRXe84W6GOAJO5JAL7RqJsI
	 UTdPERMm3A7DoukPwmasLkDVN7uPps8RnrqxLjieon3K+UKLQbP0PIqx81Q2pNZ+Bcwmo
	 NT5InqTcuxAK0mhqcVP4/I9Vz2U0v4YQBew6hOsNg3bFnaioNn1ck5wd1iIt3QM/AXvIs
	 nTTfESReHHgQ/yKpjw0gSzbK+C8w5BlnbWsMD7RGY4SIKLgbTGeLMacInuxKnTYH+oM3T
	 iS2GSbWjWQ3uA+cKis1XVRiGfiaoNvKmERh4ZpqP9px8uIKk1tdI98nd7TqPRR5iAHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
	b=rH5n8R5EbRbrOG7vj5dJY1gH1xiyz3oQtfId4Kp8BddW/XyaSGsIAet7uALEZH6yf5DX
	 uoAGIUFM9HeY1nx0QdEpcOTIPUir0ZTiuyo5XUOVhPJk8d7Ycn19vrYIEqnLw2sdTTgiR
	 5XaUYYQ0cCivu2sHJsQc4ay48m1jMIMeqsRAyMIXqZsE5foLiSgyy6fNwASCFXKmC463p
	 oHok1b1Pumf6MUXi9nKIaDUCPlDjUkg5VMRqTcpM+QF1K7K0c6U5Ldd9aXYdOQ13ebb4F
	 xmyPoOFQshVozC3JQLPtryGt7r29O9YOsAH1jkdsNdnEcLXk4XYuy98HkRhNDPlGPyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IqFYPZ2W;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA5606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03FA5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IqFYPZ2W
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b63bd2030so25181796d6.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492711; x=1793097511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
        b=IqFYPZ2Wi7GonAxMyMFIoibl+jVi76AxveoOfJHNVhz+99JjfPl23C/KRYMZPlz8XJ
         IS+bkmRZZ86mXGhGNtCQaXfUfX/G3vWcf4N/zh+Y+cfi/t6nRPpASQ23XFnfwROEY+nw
         8Vin2AFY1MPIFRhqnHqx1rVm+teL1mnn54pmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492711; x=1793097511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zmwZoifCxESn5tFMPkCRwr0daLGLZtL5qkvBzc0DLA=;
        b=rA4RdoRrRDWn9oEkaWydeKneAen6fVIifScqXN8HBuRgpTwOW4bodLuhx23H+YnNYB
         XN5MPoFh3pMhraxLvZjStaCNxf7xhVaVwgyJ+2qF1BA+mfW+QXNIxJEuNYKGULKdeccF
         YebnTuViw45GGmDOAJmZl+rvE9eqbjFh0j49xe41JrNqd7glM6qHqZ2kYwUXVIThj1CL
         T0gFfL9+oxTUHtWOFH6uzhOzH22+w66LL9QyVQYEOZx0CS5mdkjHKI1HiDwqI50SOdfe
         OQHRJ97xcRXs5VLmvHXFjRpgjrQD6QwZ2RJQqp2f29DxWTvMfwSq9JrK2J0o8pSsYav/
         dZgw==
X-Forwarded-Encrypted: i=1; AKwUvBy9zOYkqdk3AK+rZ6orOCnHBHVRFcka8mtlyjN3Yn3T/mgufxFiFzLVsowshsnm4MxVode9Pko=@vger.kernel.org
X-Gm-Message-State: AFq9FYIciTvY37h7z6HUggbyGuAKzswKe4xHiCK+kMkwZyDJPhLfv7JF
	7UiQMn+MHEZrP06sCswI2KgosRhIsjI24/+ulri8A1lGEnkYML6nwviuxjdf501NAg==
X-Gm-Gg: AYBFou1jRYRBlpgKBV9j4pn57N/KVNkecnXLE+ZZ4GHurGNtAEv2n333KfxcsFDTphi
	osnYNKzFQ7eRj6Pue4qg8OSPRZPcmRnDWBA+1ekmo3BBFPKrv1dAeuhz0ou5GtMrdIl6/QoZyoM
	LVmVfsLcpADtVfCq5FUmBaB+vwkJVzMm/rTcBdEGi3TaekimBshe5MMJjHJ1pilVGJAqzUdCxC/
	r64evfh2q8Ew7KmI2pF2c0Yo6D22IKIgGJKrs460yJa+4acAvFDUHaHJQpof8vOaBDJmCm4fxdJ
	iOElvfnLdKnKJ3W9yVEozUxBy9D917Q2tLAbec8chiLw2rurZqhUxnJn80KeOvWalpRTq6XVzmU
	r8SH4jTYEbxUFUOIGWuzSozLkFh8VhGZqHzXKVgUSmbwE2rvdlKQJ0dJb2+7fyKzN8ZsWPGXqKN
	dJ+k2Gw9UZWEEQbElR0ymZxL3jSIDgpc5Y46IcS6VvopkfZKn+jrrC6/J7R4w8iygdi/Rl3arFQ
	xSSpjdT7OW4HqDFs9V9kLA1ehoWeMKDChwFAPm6XqDU
X-Received: by 2002:ad4:5d41:0:b0:91b:8aad:79da with SMTP id 6a1803df08f44-91bdf127c4cmr175945416d6.28.1792492710804;
        Tue, 20 Oct 2026 03:38:30 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040b4915sm23275556d6.26.2026.10.20.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:38:30 -0700 (PDT)
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
Subject: [PATCH net 0/2 repost2] net/sched: sch_teql: fix shared headroom and header strip
Date: Tue, 20 Oct 2026 06:38:25 -0400
Message-Id: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com>
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

This is a repost of the same two patches; there is no code change.  The
previous posting went out unthreaded (patch 2 was not a reply to patch 1),
so this posting is sent as one threaded series: cover -> patch 1 ->
patch 2.

Changes since repost1:
- re-threaded as a single series (no code change).

Jamal Hadi Salim (2):
  net/sched: sch_teql: fix shared headroom and header strip on slave
    retry
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
