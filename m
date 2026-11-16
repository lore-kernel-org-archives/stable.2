Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825409;
	b=F7OS5zoXeORtDJymjCQpToTg3IR7izYYdre1Fxww14kaASA8eptN1ACUT/EoEq2VaOhj
	 zkNMFndimbHW4R2PkHtadwRcIwn8bs5KthpxJB021C+MymtHnPKlBrprOYuJFJy/iD2uc
	 ZVX97KnS7t2RdDMKYWTNAjhlyZ48jPiBDCtgl+A28orv8VgTOqI1I4wTuXUlJVG3vBp7d
	 kgdTaaZw8SJIoikOOq+rEUKkxCgMVJPMi0H8zuH2wqx7kjb45zNAkYCWJowNMjY5iwMBi
	 wrJa/GjNqZRSiF99XNcQ3C7Q0nJRP/cHpaO+kjWEztMxZ+muWf41NMxXBQe5zdNuy9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hrslb7xwY/P3caxQHjfg0Zlzk+SkRY2D0gWn0IfeX6Y=;
	b=J8NagitW29co0eS9+Ezf7JJJaFQYnN8cywKEyd2vcO/z+GkT46aJ5LM4PbSoX6T76o0G
	 tbKI3MuxUdIn3lvdTm/aeGj5/DbHibajX3kzwopLzsY4AtMflP8h6BRveHT62JQX2lO+k
	 8JcCFxeUXa9kJXcy0uTbNuPHDAZArO+DtGHFxCzxy2r/VOxHvCkYBjes1wDrlwZ0Xdksj
	 wxR2i16mzA4WHY5btI7n1cQ3ft2yY+a8Fk5uGb7OQ6uasw8alS0C74e/SWTEm0gHNZiIc
	 Wg4rc6XJP361mMhYOwW+GNSrMVRzaU0/9Y3NEvKqIRXk3naPeTlsMawYIXj850dDA5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="wC/Udj35";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF72606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF72606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wC/Udj35
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91f332a4b2eso23522356d6.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794825408; x=1795430208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrslb7xwY/P3caxQHjfg0Zlzk+SkRY2D0gWn0IfeX6Y=;
        b=wC/Udj35b3zAdFfaRatiA+UL2HEs+pGiySYusb1ax5IeScQOsVwYXfLUlInj0Thd/t
         xhPbm/hOkTw5FqqRRkx2tLUIEHZwXpOpR/AbU9dRtbOmUB26AFoe2IZQ37TjnYwZVYOd
         qKQfc/BJtjiC1DzCK+849keYhKb1hCNNSJyn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825408; x=1795430208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrslb7xwY/P3caxQHjfg0Zlzk+SkRY2D0gWn0IfeX6Y=;
        b=RyNzsfO3fzpRUE+XTGxL0ZhXq0CVhhLc3BKgJOolFtVvqeBwwc+1pm0C6obukQmyft
         HK4NcrKREYxnCu8PnwiEvxfpdwJaSRHv3V5YAj2feBlzsYDHQP97MBTHKCJa6ayqkwTf
         4ZuIyz1bdcWD1+MPLleinisQTwSTxtKV8iHtvXfl0N67meW2MeVzVvZ3qcz1pr0bRQja
         DR7yZa3yawLuMtqtV22VA2JXBilj4fmKSbkHJlydMts7tDizfV2emgAiP7+XfjeeGJPt
         L5vWAHNR33ntq/FkWi2CbehuNHWoGpeJ8jaWG4nuE725gm1hYXUMuQEcUTp70cM0Ndn0
         5yWw==
X-Forwarded-Encrypted: i=1; AL+hErFcuPvCGa/9660uWRiawGlr/ynrRZIyAmYHMAjq3+zG3fHwNGsifkebs4/UhNkz4F2GbZrRnTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jXt+UKuUUn3Bqm9eibzAcSdRYlaW4154C675ZncmQHsXrGVFs
	3fEuB8E87q8ihL9XvRZ329nkjBYiTVHgVDfk0rtPKmSDEdmD7sFtEWnRvel5kT6ydA==
X-Gm-Gg: AYBFou3t720XrS7Y71afv8W7ZZMPyFVb2fKV/ostEWk4PLUfJcfZmOuODjOrM9z85Dv
	xc7k78YF4R0vgE9o++gfXAQH0ZUiAj2nOrPZIUwdRLhXFeyyCGRlNiaICMIarl3tj7WsqBKBzx6
	nopb7TSA2+3QDyAwIw4VvEfiIfT0SvPn8PpYbHe8wbSszAeCLV+LMkaHl85+dmH23at8uypFC+c
	3rHZrGIzODsfIjYPnB0g0WncqCM9cG7CuIk7lTr9qsqzJPKfH0zApPCmLqP+4c6Y17rKSIhOQgm
	UZXF2l/5jXUtuEvAQKfAZi/sGQExlKj/G089GEJ6i+N3A7YtDtEjHAiNFeoEZSQ1b6y6qzzQOq5
	WSz/L2pZlAn5hjQWCd5eakpZgADd0C0VsRFn7pVt6E0IPuAANDXDTZv1Qk1aiCLn/2h6F9LX1F7
	2hrT6aeCIGahxX1nCHm5fuS7kdSYpAmA9c+s6QkcMPlRlLpLHh9g1kjWmw0hwsbDqCrd8oy5d2B
	dYpJ2QT9gQ9R1c0HQ+uN/MhJ14aQhvIfHecWqAckVIr04p8OR16vh6HyAJ5HCQSS3EyR+qNku43
	tpzOwWn7vr5Ci4x1rsfAE/XTuaFMI9Xht3mFKADUWs7emcScptSdgi9LvnxyxvPirHKHhi8+Ecm
	632X3a/vA+mAwHcuYmcgK
X-Received: by 2002:a05:622a:581a:b0:536:5a78:6b13 with SMTP id d75a77b69052e-55ac8880f3amr162945851cf.57.1794825408015;
        Mon, 16 Nov 2026 02:36:48 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm77778651cf.24.2026.11.16.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:36:46 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v5 0/3] net/sched: sch_teql: keep the transmit path's skb geometry and device lifetime intact
Date: Mon, 16 Nov 2026 05:36:40 -0500
Message-Id: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
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

Three pre-existing defects on the teql transmit path, all around
teql_master_xmit() -> teql_resolve(), plus the core helper they depend on
all derived from sashiko reports.

Patch 1 makes the headroom private before the neighbour can write or queue
the skb, and pulls back only the header that slave added, so a
header-cloned skb is not corrupted and a userspace-supplied link header
survives a retry.

Patch 2 restores skb->dev at the arp-queue reinjection point when the
neighbour's device builds no link header. It is the neighbour half of the
version 3 patch 2, split out on review so it gets its own commit
log and its own Cc set; requested by Jakub.

Patch 3 moves skb->dev = slave ahead of teql_resolve() so a skb parked on a
slave's neighbour arp_queue names the device whose neighbour took it, and
so cannot outlive the master it came from.  With patch 2 in place it is
reinjected through the master and leaves with a link header.  Its commit
log carries the KASAN report the unfixed kernel prints when that queue is
drained.

Patch 3 is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path") by Victor. Patch 1 is the
same commit's sibling on the successful-transmit path.

To prempt the sashikos:
- The pre-existing teql issues reported alongside this series are fixed
separately. For "the lower-qdisc drop use-after-free" see:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

- For the pre-existing consumer nft/bpf complaint see:
https://lore.kernel.org/netdev/CORE-9NOG.v1.r0.20261111073528@mojatatu.com/
Note: nft/bpf combination _has never worked_: it is a producer-side
mismatch on two separate entry points, not a regression of anything here -
hence the net-next target.

Hope the sashikos read these and dont complain again about those issues.

Note also: part of the testing of patch 2 runs for packets that reach
neigh_xmit() from nft's `fwd ... neigh` statement, or from
bpf_redirect_neigh() with explicit nexthop parameters. Both keep the
route's dst attached while replacing skb->dev, so the neighbour that
queues the packet is not the one the dst names.

Changes v4 -> v5:
- patch 1 closes the finding Sashiko (nipa) raised on the v4 posting.  The
  head is unshared before neigh_event_send(), so a skb parked on the
  slave's neighbour arp_queue is already private when that queue is
  drained and the neighbour writes the link header into it.  The retry
  strip fix is unchanged.  Considered comments from Sashiko (nipa).
- patches 2 and 3 are unchanged; this resend is for patch 1.
- patch 2 adds Kuniyuki Iwashima in its Cc set (nipa CI).

Changes v3 -> v4:
- patch 1, no code changes. Reviewed-by from Simon Horman stays, and a
  Link to the review of the v3 posting is added.
- patch 2 is new: the net/core/neighbour.c hunk of the v3 patch 2 is split
  out into its own fix, with the neighbour maintainers Cc'd.  Asked for on
  the v3 posting by Jakub.
- patch 3 is the v3 patch 2 with that hunk removed; the sch_teql change is
  unchanged in approach. Reviewed-by from Simon Horman stays.

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

Jamal Hadi Salim (3):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net: neighbour: reinject a parked skb through a headerless output
    device
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
