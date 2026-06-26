Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B243F928E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490207; cv=none; b=uQj4coSaCWIks2LAc6Tl94PAiOyEF91aP4/lvn07Jpb+xkfWqe3z7tzod5iF6qq2wubrKu5TROYb4f5if++IY0g7ghH/CUC/ZjCcUO6/kXAmLsbLAssurup8zSzdpbbxNMrD915yc42HCXCCcVwOpKVIC0Plo4Gr1blgEvNryiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490207; c=relaxed/simple;
	bh=ugbq/DKPyWAmAxKcS0WIaj6MVa13B1ZXaI2CsA5+sQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7WDiePpPpAzT020oCD+cuX1OSZg+jxSFaZgkYfpMZla5CNcr1vVxXSqxl1DU+Se1HgPlOt4EXTCfMPEpHBr64rNlt1CceOEwoDiPvmsA3n5hAaSmVdx7s6NlFcVHx7pN9LgbnxXCf6/6bvyq+Ryh4kiQLLlajJReIkVZn7vfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=tcRBOpxy; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="tcRBOpxy"
Received: by dvalin.narfation.org (Postfix) id 9B2601FDCC;
	Fri, 26 Jun 2026 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U612Am7Is7RyItEWXhC196n8WdcuLShcbz60a5gWpcw=;
	b=tcRBOpxyMaOB2ohxkAhtBOTQT0eCVwhA6oGYlXs9Kh8q32r2uwbwwenQCif2Fae/K2LeZP
	h7IBWxfv0H5d4CV+9tkDjRv38lCAKTzJFRuAACu8YmqmF3oy87GkgdNq83zkXZm17c7diA
	MTS4JwZFT/cfzUbCYEkcycFDsbUxfwU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 00/23] batman-adv: 7.2 merge window fixes backports
Date: Fri, 26 Jun 2026 18:09:29 +0200
Message-ID: <20260626160952.123713-1-sven@narfation.org>
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
https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/5.10 to directly
provide the backported version of each patch. If it is completely
incompatible with your workflow then please ignore it.

There is no urgency for these patches. I just want to reduce the number
of conflicts and patches which are accidentally missed.

Sorry for the noise. I hope to have less stable fixes future (at least
the ones which have extra dependencies).

These backports expect that the following patches from 5.10.260-rc1 are
present:

* batman-adv: tt: reject oversized local TVLV buffers
* batman-adv: tt: prevent TVLV entry number overflow

Regards,
  Sven

Sven Eckelmann (23):
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
 net/batman-adv/routing.c               |   3 +-
 net/batman-adv/tp_meter.c              | 115 ++++++++++++++++---------
 net/batman-adv/translation-table.c     |  12 ++-
 net/batman-adv/tvlv.c                  |  69 +++++++++++++--
 net/batman-adv/types.h                 |  21 +++--
 13 files changed, 248 insertions(+), 78 deletions(-)

-- 
2.47.3

