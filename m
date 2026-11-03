Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709562;
	b=yc7mipLxgVKV0rUA4JO9gW87bye4fZ+foQ0SvDwcd3FnDiMGh4U80Ityv/3i71npCrI4
	 74txv8tHDvcojbjZl20+0rw6MAtUujy1+iNsnRLkkMKbwXp/8Mp07U+QWYkQW2HjwEzyP
	 f+shjNlk/siHvQYWHvnEP9lBLqwADeyJaBL7ShVrjWRK6jZZEZupxl/8P8tn+NJZ5DpIg
	 H9eDQrZWh9X6qMF2ffRYUzRe1g2rp6GViaEhYff1QcyNFFltcodJpPTE11m2/+WKnRB/z
	 i85+KaJrObc3Mu+23B31K1MSrormfTNKg4XJS8nJ9r8TyyUwykD9Ws3FS932ejkYkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
	b=gWD80FlgUBERKaBkXOHk6z0yG2u+FTJYmBijREeYRQcs+mZpSTVeQP9ySsP5K3X+m3mt
	 +xhRL1jnd5Qp9HCpUA5ve6il/vBDZWfV3BB9dAgTW7nBkgaKlycxZ0gTcDnn3lxSVn7Ea
	 JzjXheip30oGPwG6wM2cwP3qoiChbwxYEXQ6Sy/hVQt5OwD98aP35NSj/DaUNo0SFxgl6
	 pC52R+QCAV3VyOIgAmFbL4JdipEL+06p4jCk3x3RkSrudfBJjf3JYPMnERRCTgxniIh48
	 O37OgNA4nWs5Khc05zgvyNOvNKBGCsCRHJkFzUAEB5GB7B1mH27yaRB6UqwVBHavJ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A6+dP1o7;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADD606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5ADD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=A6+dP1o7
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0a28a720aso40258857b3.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793709560; x=1794314360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
        b=A6+dP1o7LKHX53X7NYKDXsomqh+efBMs3YZTGz135RsYdqoktqOF1UJ71Yy511EOtZ
         VKjD9LYNPt2mpq0+eEnzPrORUfJaB3i1HDakOSM1HFdu3r2bagSYYjR+VlZa0VXBlPoj
         SWxazgzOYjXPCYnPPDVFqjstVySEoIrn1pXJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709560; x=1794314360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfhgYc9ZnyDR0V+JU+Iip26bBIuO5bnj/fnxRw088+Y=;
        b=zfLeFpvdO4ZK9+r1d4zuq8DBXsfgbnZSaEN04qT5FvbL5gC3Qo8lF2jKWqjiJ71z7a
         nqAyJCdx59FeYgEIeRcV5vIrwi3JvhllTY4QW3ir0kcDlsjtpqrzTMbSpfVC/Vj3DXhP
         t8C6zImuxNxBZRPS/sg4W6rhlQBydHbeE/hWMBbSuqSwTGVGP7ZoIxCiLt9nvMWlTiP/
         jVuDShmZpxWE8VpQChXCCDJH6iy/yxz3PG4CkjZTM887ZztSlWU+/D2jqVAsatV9LTte
         hUGdP4IyiPhx9iEkhPrtVmeH0OknyaJqbavhi+gYuo0eMGidpUJ/QYboSXWsRSXjdZUa
         6Yig==
X-Forwarded-Encrypted: i=1; AKwUvBw8X+VntYgnyNvMu2Er91m+7CcDiVIapyd18OCzOkYTNAbmIu4pWqOXu20gbm3uBmM3U1MkVKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5hJCfbwPZj7mwtP/J/e/fQDPnMKVotLSJb0aBnzL12A4cHk0N
	mC6CbI6FGAb0A1RgShADu6OstQULZ2nhMzou7XludLKUyeK1Za3fLNFky3DzLoqK7iREwn34c5z
	syi8=
X-Gm-Gg: AYBFou0cifE5p7JuNiNjwqOx2f/vGAVS4stEUVnwxJQG3AJNxfTj/h/rT+IYwod4IHg
	BHtPxU4hF7zzoZldXvxAVg9u6q7npPBSjwOIT1naOH3r3QxNfdFP48H1ikHszv00v4IA8atLOua
	FITFR5LdM3wQuFfd3fWRVY/6kDPNCmR0SPjvKLPi+rI3xeHlNvxpv5/mw22SHYARHDeuOy44HtG
	picu9320IX+Ikq/AjDsziIhP97JQLNNhQWLnHyvPu/2jjABwtG/Fo3iGz9OE1pb0Rxtli3duq4Z
	T93JFZLxl3eoMlaSfWB5z4cqkzmtAUcE0R8NkQumhXLefqRpOOMcYRDVLj6/Ex7rgcV5OApRJJ3
	GwQOxlG1XeRUxQJetrrsBiQn/M1xfRjF4oo6yQmu/ItPL9bAITfwP/4MonHHEEdCbI/0QXlohOY
	RjF2GQctdwJwK9LO/c3x6nf3OYRaVj3+AZfhL2nYM9WMxT02MMBWPZvieY4L0At+Xir0vis0k2/
	5udSxchZ3ypGFI1sws++O97zjiy8VLhIHdkA3xfvaeGvFkQUjvUqkVhC9LC6uqfkKNHNpO01LO9
	5U/RL5H6Dnr5ClskDgAxBBll7+ZIa9+L8gGxUqOrBRpC5A9B+nN+s+932WHBuuMbI36LgejUvfr
	io0mT+XT1xT35g/o=
X-Received: by 2002:a05:690c:60c1:b0:8ab:3918:33d9 with SMTP id 00721157ae682-8b2b67ae0a0mr95022047b3.61.1793709559759;
        Tue, 03 Nov 2026 04:39:19 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm72011827b3.33.2026.11.03.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:39:19 -0800 (PST)
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
Subject: [PATCH net v3 0/2] net/sched: sch_teql: fix header-cloned write and retry strip
Date: Tue,  3 Nov 2026 07:39:14 -0500
Message-Id: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
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
Link: https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

Changes v2 -> v3:
- patch 1, no code changes.
- patch 2 corrects the conditions to recreate the bug: reaching a freed
  master needs sch_teql built as a module, the slave qdisc removed and the
  module unloaded while the skb still waits.  The message now says which
  part of it reproduces without the unload, and names the neighbour failure
  path that drains the same parked skb.  Considered comments from
  Sashiko (nipa).

Changes v1 -> v2:
- patch 1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour whose
  device has no header_ops, the shaper/eql/sch_teql class.  Commit message
  also describes how a master is freed.  Considered comments from
  Sashiko (nipa) and Sashiko (gemini).

Jamal Hadi Salim (2):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.43.0
