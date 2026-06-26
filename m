Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FA481B1
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490286; cv=none; b=hqnhFWsdTHKjKQWup5SYIb1Vb+2U4a1qvtBbNA6Hd/r9QYQ0iJmNe9ry6de2IzNSgOhYzuuv0XmJYmIqfylg2ZlX4it3oZAINwd5voeiPFFlH1y+cLoq2tRLg4WqLfa/pJDNFB7Nyba0gh/BhZ8kn+ZYqYK4YdGmY4yF0lj98Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490286; c=relaxed/simple;
	bh=+iEPERtC9Jis+yW9uhLo7GAfJpjFnj1gMS/yt5mJGHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0fSZfikx1skPo9NsyatswFghCYJCJcmC9pi4Q2xj5TvlRn2n8uPo/LpNwabgDlEtibLQOEwvi1j5gmxCj3kdDkcYe4HOOKouiE/wIXUKMI/Bi9IB5hAfAYhxuHI9oPql3JL1s5RW7v9/vHOm0kwmHRGwGVxxUZijcv3g8mG+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=wNYbdhtg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="wNYbdhtg"
Received: by dvalin.narfation.org (Postfix) id AAC4620019;
	Fri, 26 Jun 2026 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fkExP9JXqbY1uFrDaw03mRuVPlDM9XSNa0O5dXYEvx0=;
	b=wNYbdhtgQ1ELHKaz3gY5JaaQFUsZCK7OahhATsfqwFNecfcjaJWlH16g9ZxVEgEFp1NkbL
	C4UX2BtaMRxWkxyqIIfTCffdFaW7DYrKmBDvt3WPuTSFvvFjBGNFqOHY1WFH6AbcGD1iCX
	aJePP3y8ToA9/RCidRWm8N7xP6nPeZE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 00/25] batman-adv: 7.2 merge window fixes backports
Date: Fri, 26 Jun 2026 18:10:58 +0200
Message-ID: <20260626161123.124273-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg & Sasha,

there were quite some stable targetting fixes in the Linux 7.2 merge
window. Unfortunately, there will be quiet some conflicts for older
versions and some order dependencies (often to patches which have
conflicts with older kernels).

I would therefore just submit my backporting branch
https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.1 to directly
provide the backported version of each patch. If it is completely
incompatible with your workflow then please ignore it.

There is no urgency for these patches. I just want to reduce the number
of conflicts and patches which are accidentally missed.

Sorry for the noise. I hope to have less stable fixes future (at least
the ones which have extra dependencies).

These backports expect that the following patches from 6.1.177-rc1 are
present:

* batman-adv: tt: prevent TVLV entry number overflow

Regards,
  Sven

Sven Eckelmann (25):
  batman-adv: tp_meter: keep unacked list in ascending ordered
  batman-adv: tp_meter: initialize dup_acks explicitly
  batman-adv: tp_meter: initialize dec_cwnd explicitly
  batman-adv: tp_meter: avoid window underflow
  batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
  batman-adv: tp_meter: fix fast recovery precondition
  batman-adv: tp_meter: handle seqno wrap-around for fast recovery
    detection
  batman-adv: tp_meter: add only finished tp_vars to lists
  batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
  batman-adv: prevent ELP transmission interval underflow
  batman-adv: tp_meter: initialize last_recv_time during init
  batman-adv: ensure bcast is writable before modifying TTL
  batman-adv: fix (m|b)cast csum after decrementing TTL
  batman-adv: frag: ensure fragment is writable before modifying TTL
  batman-adv: frag: avoid underflow of TTL
  batman-adv: v: prevent OGM aggregation on disabled hardif
  batman-adv: tp_meter: restrict number of unacked list entries
  batman-adv: tp_meter: annotate last_recv_time access with
    READ/WRITE_ONCE
  batman-adv: tp_meter: prevent parallel modifications of last_recv
  batman-adv: tp_meter: handle overlapping packets
  batman-adv: tt: don't merge change entries with different VIDs
  batman-adv: tt: track roam count per VID
  batman-adv: dat: prevent false sharing between VLANs
  batman-adv: tvlv: enforce 2-byte alignment
  batman-adv: tvlv: avoid race of cifsnotfound handler state

 net/batman-adv/bat_iv_ogm.c            |  11 ++-
 net/batman-adv/bat_v.c                 |   1 +
 net/batman-adv/bat_v_ogm.c             |  23 ++++-
 net/batman-adv/bridge_loop_avoidance.c |  28 +++---
 net/batman-adv/distributed-arp-table.c |  12 ++-
 net/batman-adv/fragmentation.c         |  22 ++++-
 net/batman-adv/fragmentation.h         |   3 +-
 net/batman-adv/netlink.c               |   6 ++
 net/batman-adv/routing.c               |  64 +++++++++++++-
 net/batman-adv/tp_meter.c              | 115 ++++++++++++++++---------
 net/batman-adv/translation-table.c     |  12 ++-
 net/batman-adv/tvlv.c                  |  69 +++++++++++++--
 net/batman-adv/types.h                 |  21 +++--
 13 files changed, 308 insertions(+), 79 deletions(-)

-- 
2.47.3

