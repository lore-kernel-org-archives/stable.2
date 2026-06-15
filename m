Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE57080D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545583; cv=none; b=o9DUoZD8wRhPXUkUPjPChT34kkY4ZxOYrc0mvXEkA5baA6Zoqe6/KNNDF2uD8w5wcdeBaKFCtlK9zxy4COJpZ6yOK+2nCUfRUqU0b3anSEMoGgfGk1qnaHSst9nk46A558fcnEsgu4WnXqvEByVDur0lssO++kVzAMjjODzZF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545583; c=relaxed/simple;
	bh=ocWgTOMXwjI5TVoyjUAYU/X/PDgJy39gHQDLgMO3Sw4=;
	h=From:Subject:Date:To:Cc:Message-ID; b=YlkGzQL1lU6io0K8psMq4Fk8Q4DhZ8m6A9UWgp4OR35+I6A5bT/2zIe3XHLVb0fMoDMb4voRqesZu+0GJnjDe7rKxnUFNKnRRAMaS4YnpWqLG8SSEWGBqI5sXpkJJGM8ZYf45qu+UfcmpNO1rnsVeHqyfRfEIhZs3oQFEFXjrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=On5wCwtp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ankey.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b="On5wCwtp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423efd76c8so2645489b3a.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545581; x=1782150381; darn=vger.kernel.org;
        h=message-id:cc:to:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qetJH6uAcYEaNA7WIluzKnDC7IXjgavBC++l+5U3BLA=;
        b=On5wCwtp1pRC//8FxcyVQdPIIYJ8md7OxsbdrFC5TeeDB+qJ7En0EZ+l+966KKogis
         PV6pOh2cf5bcGKzyuu6B3v6MR+Sld5jzWd3xZLfm4YEkBIIT0dvK1gm+NrgwXX1D+3C3
         LhEwApg4gRtFX5dO3cdJw4SORuHloUcsTwI3bKFRIsaOEMvWbhQrrPQrK/jHn05fzEZL
         TkzDLxpziMM/K6Cbq202f2v5FCiqU8tHX5hkMTQPmIlmDfvkcVn8oeMO8nmfmiCtm++F
         q86y4EbPVZ9LWqDMAi/vT83BO7qLwrKhlDSzsig8m64AtvMeG6YCQaEb/DIKGDeRb/U7
         IYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545581; x=1782150381;
        h=message-id:cc:to:date:subject:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qetJH6uAcYEaNA7WIluzKnDC7IXjgavBC++l+5U3BLA=;
        b=QkKlgqRKIgzwF94ZK3AENiuEQdXQX9Ru+iaskrn/gneIPpDcTcciauXoVrMpsDg4KG
         7O2vX6X5d7SWT17GlH/48mF5w/DEyu3lg7wi/04eJ4YR78C+3XD/5rxnDwylcHTnxJVV
         ElQjSHf1CD3ZdMPpNC492yze5c+R2G0VKMAxu1lx2+IafoH6yQ3JiCyXgyks2tLGnKaH
         ql+MwAaGdqmKnieCUH0WsMJnpVoKt7wJcFK11huvvYWDIHLj9MxfKM+Meolbzq7mtF+f
         o+k9n2H0WeQDv0yxsnb7J/Loc8XBcaOogwabmqNgta+GqA+PBr2GpWsxJDvNcL1zX3By
         KygA==
X-Forwarded-Encrypted: i=1; AFNElJ++WRmkq/L84b23g9RKMhvBkplRb4MrgVexXuYHNYViipRs/AkUNPPgwpgzf79vZjmwqj+49pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeZZZViABzNnJ7wnUbfsxOMqxNFVCdXy0Bfroed299EUVaYtv
	GNc1ab1r4ITJgD4q2xVTFxmTh96g3v4eDaxCcfbFL3IIIMV5D3+GuPcJzQiPbo1kmg==
X-Gm-Gg: Acq92OEgQqsRIlKDhnvIUKK+pxR431Uq6wuwyb4ewB2FcFo7mm8BSOopnlgcBIQnlbb
	8rkBjIz7D/kh4DeyOhp2CVKadxG0ajB76SOIekwjytKhIwGUDpoc/pedGA/019FZHUm7Yu5khYX
	7EZzMYUVL8ys0hGsTL56B3A7gDQ2Pxv7mVdqOU+FJgM3h+N7WJZc+IEHeRpLE3nGcGmBUZQoljZ
	pXy1I59wcF36UxrWG4jPsQAK6dfruhqBQmyDTNPy1+08Junajlljl/WQOVM3vVJV5aBYk2lNaEL
	sUN1BRti+ibze0cOB5pxvktF36EuSH2Osx3ofa/dKxvjsftiyJDob7f3vwFzDPr6UKpDzwMk215
	HotQC8z9AT7EBw/E19ivCy7FdCBqSfjvgRVAxCdzykHuUnJS8nMGEZjd3wgnLg7gSay5fuV/YBU
	LiwzMRRe27yncwKMDq4kbm6AoRsnXk8AWdqvLMYFPgnY9vqye8b3Q0+J5BtvxXCJOKsxDejuze4
	jPWrBD5NqoovVczRWgK8BXJxf5zHpq7HB3Dy6Z1Urx4oQI=
X-Received: by 2002:a05:6a00:1311:b0:842:7867:430b with SMTP id d2e1a72fcca58-8434ce40e46mr16487940b3a.29.1781545580609;
        Mon, 15 Jun 2026 10:46:20 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:19 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject:
 [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6 RDMA-CM connect
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

RDMA-CM cannot establish an IPv6 RoCEv2 connection between two NICs that
live on the same host. This shows up on hosts that pin one process per
NUMA-local NIC and let those processes talk to each other over each NIC's
global IPv6 GID (e.g. a storage daemon with one engine per NUMA node on
dual ConnectX-7). rdma_resolve_addr() and ib_send_cm_req() both return
success, but the destination NIC silently drops the frame and the peer
never sees the REQ; the connection times out.

The bug has two halves, one on each side of the connection:

1) Send side (patch 1, drivers/infiniband/core/addr.c)

   When the destination address is local, addr_resolve_neigh() copies the
   *source* device's MAC into the path record's destination MAC. That is
   right for true loopback (same netdev), but for a destination that lives
   on a different netdev of the same host the destination NIC will not
   accept a frame addressed to the source NIC's MAC and drops it in HW.
   The fix resolves the netdev that owns the destination address and uses
   its MAC.

2) Receive side (patch 2, drivers/infiniband/core/cma.c)

   Once the REQ does reach the peer, validate_ipv6_net_dev() rejects it:
   rt6_lookup() of a same-host destination collapses onto the loopback
   netdev, so the strict rt6i_idev->dev == net_dev check fails with
   -EHOSTUNREACH even though the REQ arrived on the right net_dev. The fix
   accepts an RTF_LOCAL route when net_dev itself owns the listener
   address. This half is only observable once patch 1 lets the REQ arrive.

Both halves are needed for a working connection; patch 1 alone makes the
REQ reach the peer but it is then rejected by the unfixed receive side.

Verification
------------
Measured on two RoCEv2 ConnectX-7 ports on the same host, each with a
global IPv6 GID (port A "src", port B "dst"), driving a cross-NIC
RDMA-CM connect (rping, src GID on port A -> dst GID on port B) while
tracing the destination MAC resolved in addr_resolve():

  without the series:  resolved dst MAC = port A's MAC (the *source* NIC)
                        -> frame dropped, connect times out
  with the series:     resolved dst MAC = port B's MAC (the *dest* NIC)
                        -> connect completes

The kernel under test carried c31e4038c97f and its dst_rtable() prereq
(i.e. the same addr_resolve_neigh()/is_dst_local() shape as for-next);
the change applies unmodified to rdma.git for-next.

Note on stable: the Fixes: tags bound the backport to where each construct
exists in its current form. Trees predating c31e4038c97f have the
equivalent send-side gap in the older IFF_LOOPBACK form of
addr_resolve_neigh() and would need a separately shaped backport.

The patches are independent files but should be applied as a pair so the
connection works end to end.

Alex Timofeyev (2):
  RDMA/core: use destination netdev MAC for cross-NIC same-host local
    dst
  RDMA/cma: accept cross-NIC same-host local dst in
    validate_ipv6_net_dev

 drivers/infiniband/core/addr.c | 22 +++++++++++++++++++---
 drivers/infiniband/core/cma.c  | 15 ++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)


base-commit: 20ff9350862468af21b46cae2c22d17d6ec637f9
-- 
2.40.4

