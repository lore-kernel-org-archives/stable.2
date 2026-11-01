Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550482;
	b=O+GDXbHlUdbQppACTJ/yN/xyzVO+rhcOHdy2J68FO/UembsCDONpWQkFb+zWD7HgCp0Y
	 5RW1+ihM/ZINrQO3mzAnRuQS3OstK39iRnxizPuO6HuIkSPJUwoa5N5+pXoBTzWRFe3Nf
	 omU1TRVFlym5g4ZpCYBhQ54xKIDyTuswDZe/WnPcKfhm5sR6uM7HdWDXsNdzGL9qnkH+s
	 6EKarresaGdFHfMwg0DAY8SWY+hTW7ql+UtEsuWqJRnhIfMmX9IcPAKuJLd1t04e2CWP/
	 v9k3siB7ZFV7QAIDszn7hSWXmCeDcyk1r0UgitZyVcLXO3fhC1COV7nopnTyU1VnkeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
	b=KEkeDFSGRtW9dP/uZkSTnxiK5IQ6IFeT3UQhvtnSYJ0S26CulVGqqnnBAgdEwqois9JI
	 qJiJgRd4hT+iGQ2zh32+ZVVcnwbeWxpiu8+ju2rjQ+nmxJzLOzmEKg6vA4Mp369Kc+2sx
	 IXqMSdUwhqU9mmBdQeKRUyGtb8sjiWXcG8pJyUSzba66Ozaam6J6JoYIwddX7ehqNHWdX
	 7XAjHYloe517Esj4lAWeyRhHPk/4nQECG4keYEbH43h+V41lV4lZCx9S/KQxJ1U1EtqH4
	 abfsHKCTgGH69PEXCrPNE0309n6wZQjRwELyWQ5hpIX8ZLfsAYW86j/i16hg5bROoyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BM8MWJb8;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223F606A329
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9223F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BM8MWJb8
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f2b8cf037so200099985a.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793550480; x=1794155280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
        b=BM8MWJb8yRjyOSFmqDyHfMEenCfct9zV1vZNmTrKqDDKSwsLz365hkyNP5/G9VZccd
         jlqwTb2pKaeCgEbV4liLAqWAr3eCJNSj3UML2BP6ZQDgqSIcgE0OV9dUqkrWORM2+UvN
         R7HFZngYxh5Juk+BlTWwcDTWI1BTX4wT35OWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550480; x=1794155280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ATEqm11WHdDrquS0a1up5qn5OVlPNfvdSMdlSxlBoU=;
        b=PscUTupNI4RZHVFgZwI59Uc/ZurdYejA47dPNBaVO3XFP+95TNx46bmuYQwt1crH8t
         Vs+ECqIr3MNdIc2lnAJRKP6jIOJS/uoWWZX/0JMHAYl9jJP96IFiziWNrhOZj01YlX5C
         nQdnqOuPRfW4Teuw3G5P90aGFyHKWpe8zlLpQ3oiohhWdluL3udTV2dDzksPUnDs23K2
         h8Dz9tSEDgzdHieeBEJQuFrKHK4hQlOC18eFfCc5KYkibxskypaFZgRY33pWWyklbqBH
         S9SdRJmxSxboHch+YuBiVc7PpPs2jVunAfeE1M7U2hzrwouhPN7I0xZHMYmd6gsDEPhi
         1upA==
X-Forwarded-Encrypted: i=1; AKwUvBw3s7Hr5h9YnmhEtGFMT1gNCMl91sgFzQcImvHIskkwZ6/idN7M3TSdk4HpUNokGFP5xJHkOKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvl7YNT4AZXGBeJuOqmR9XXcC84GfthHNJHpniRlesn1qwDTJ/
	INxCIbRLTfg7I+qYJOrvm4IO5q12zzO64G1RnGNODTA09xNLU386BxJ8ViSPavkudQ==
X-Gm-Gg: AYBFou1e/l7w50vAmqpncV92TymzM1RdBiWurE0ZPuMmynRYvPsaX6O5IAFnx3HjKch
	Zosv2t5nBVFzPeZUmAV1YKulUus146NkL1yzGGY7zWqYouD/l+md8B7X8VOZ2+xH67gBMn0tVqv
	K906F/QEdzTvoq7ANMzNJvIjyKV9tTRl9pEAh8SLciCvdXETzL4LgIldtUu/pYQCj2fp/kuxMrJ
	jFKXtSEMEXcKbTI3YuU42YoBB9CrLnWPvd080QzzoJRVP21R4zw/BYNbvZdPv3GVGD4p+tXOjiB
	cjbbPrCS97t2dxWjImWN9kT2/C9F8Vkji8CGYeb3dBUYFGQR94UsLD2WLNShVQOPAWD8T1RJqIw
	zdk2fYatfhUULSG1ZFFdX7YsbzOPc3kZvFaV26YsADyIpjBCd4UVRnyi5devDOil2lHoaIKqlI+
	ZErK66i0LZ0XOVULHOh5Z2OKjjlEFX4pPVIdKwPRaiOYjUuia5RHqo/X7rp3iObj+YLvhs9OOC/
	ukZg9w/V9m16GHnyzDpTiSj8iGM+Q9wjv8xjkfsKlw5dcjj3MznMX8H3Vjc3AaGVijqHlBgZk2z
	ayA7/l5sv6HIt9f1oQ+cpxn0u0VZq42gdOmpHTDDolbADaUO9hh3hl3nJAKSuZzEz7uxNd2hq9f
	RSXIyhq+aepKFDDQ=
X-Received: by 2002:a05:620a:6019:b0:939:6dea:4f1b with SMTP id af79cd13be357-94421776a20mr1272077485a.49.1793550480416;
        Sun, 01 Nov 2026 08:28:00 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm627354885a.1.2026.11.01.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:27:59 -0800 (PST)
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
Subject: [PATCH net v2 0/2] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Sun,  1 Nov 2026 11:27:54 -0500
Message-Id: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
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
teql_master_xmit() -> teql_resolve().

Patch 1 makes the headroom private before the slave's header write and
pulls back only the header that slave added, so a header-cloned skb is not
corrupted and a userspace-supplied link header survives a retry.

Patch 2 moves skb->dev = slave ahead of teql_resolve() so a skb parked on
a slave's neighbour arp_queue names the device whose neighbour took it, and
restores skb->dev at the arp-queue reinjection point so the parked skb goes
back through the master and leaves with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path") by Victor Nogueira.

The pre-existing teql issues reported alongside this series are fixed
separately, not here.  In particular, the lower-qdisc drop use-after-free
(`NETDEV_TX_OK` vs `dev_xmit_complete()`) is fixed by:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

Changes v1-> v2:
- patch1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour
whose device has no header_ops, the shaper/eql/sch_teql class.
Commit message also describes how a master is freed (sashikos)

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.43.0
