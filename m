Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0C2F4A05
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787416869; cv=none; b=ZjA4KFXoH52M6w6ML3s/bUDKMFWQFVNekZbdwtrxNge6oScG01xNI535FttBswEgWupJlaCcEb2Evbozz3Byf1sUOV+wsHk/kCQyh0Eh5xb0IqaUy/ZXrQGmUBX7V5LpNNRDbaaNT/Ric+7nvhQEFWQdnEJumjeZGaCpn7kDiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787416869; c=relaxed/simple;
	bh=kP1cz0Wgy8H1Vo4OIydwD7cCtpRNRp7He/gqzqKUjIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTvIFYNaXeBZ/FG/okjQpKQ2TdEITR6xxWVgsSBuwacoKxib5g07Fy+k1yKttUbArY8Pp7c+b8QvhYUv7Gk80PlIQ11LW3npXbaezTmzBGTXI61/Va8BTNQmql+HWoF440tzcNFYaPdqawa5truseYxwuesJr7TFDT4inzs0xtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faXOmRpa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXOmRpa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbe4592c193so189401a12.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787416863; x=1788021663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5sYAzT/WtRiW1Ix2HTkpoXUx65zoV0tVj4oWbHryfc=;
        b=faXOmRpadohKzUHTIGVP3KXy4KgLAxTUGEBvD3IMZwehSlXZ/UPlHrmFCWrYybWih2
         R5v1gpqGxBwTja3lqPfU6in32uG3AFRNrh9cA1s9QJ8l16kUyvMXrNTcmHppcoSbJswv
         OtcQ1NsrtSufcYRCAvNdcuMhscyK8YAflrTpPcGteNhvBEVGtb9z11iegG0//c1xtmvD
         OQ57nyh6v7EMopgtS1TuRkWiX3BKnAy//wK0slUE4U2pEPF/dNATvH91xvRZC9PYTk73
         +7dlVNVbeVa8f9p2HoPeXtMn55wFty3lq0loZi+0vWih6yUzygTkDTBy/C7OAzXNq9up
         JtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787416863; x=1788021663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5sYAzT/WtRiW1Ix2HTkpoXUx65zoV0tVj4oWbHryfc=;
        b=csLqtxSMBI8R/M1gJYrDxokuEaXj4d8h/H2F3sbnzkrMMQAYXsVU85I4JGu3TB/3z5
         GKB2dYyD6sXTzqmFEm2JlPG6CnTWfgL3Kxg3GQv5wGQiOaz6FA2fN9+r+dIMyA8sVQK+
         xNaSwkuhYdGT7DG9FwiDkrsZBZ3ENMkQPuJowUeH+II7PDQdcHcY0dkwHwJkcxf2xMCX
         T62uLR5d9yLVF32dQ1Nkt9asZcMBPG50k8MogtFnEhpDz1pFPQv6ci17LYlPwqJQCZDL
         x6L9h3XLooUjddLy+CaG2hsG/EZATiPKDNPZI270wGMujjqDnupoyWYM+UTdHUFRAnyX
         xI/w==
X-Forwarded-Encrypted: i=1; AHgh+RoZob5gtiUPqWBmvrwodUVWsfc3CQaGiR5/JfQdfSqo0yI/hnsojJoYHBAMxJwYstN8cF+Wmrs=@vger.kernel.org
X-Gm-Message-State: AFuF++mz/3uq1/qdcT08yGKiI+2fx0tiuq6n3ZBF/HU1/x4tYtJF4Fbg
	3RhSDx/P2We5ldcBKqwgC4uMsFvxDRVsuMqXkNaem410EmK6PKqpiX9N
X-Gm-Gg: AR+sD12Lj2kaXmgMvwgJeG0A9d/wYxCrUfOCv93ANBiZ6Gm9ck9x47Wa4eSjfP988Ea
	GYH2Hc+xX8BYMJ7sXxeSq6Xu33j9r7ZcQJC5fOUkWiwCRrqZfb3DixsOsHBXrTBByOKeOOiRqXE
	S9VXr5gKsUDvfBoH2IITV5Gsn6XWd6XPHRMOdcQHEGnt8Vq78Y1jktgUFHbgbd9JbysF4DT1VoV
	tKqfDPVUtC9oxApLAS3RyXxaUxI3NmOWMz5Op/Kk5e9g2AF0Pwz6XB3VvCRZDrsIQg2pn+Yg7YW
	f52yM94iXVMDTho+42q6ovtT1Mx+Ne8dUnfDCHtXw2YhNF+iK2hdWjcUeD2R4mpq3Tl7491iweN
	jY+FfuPG3uYJlMUFdq0A17P98OJTJ5gq/05zlh0qV8+HJnwZFUfSbrwDsO1J8pTTn0DqNufoDhZ
	V1tffpblso/6XYYY7Wq0mYAWBj//Ayg/bXkqCBIxsnx9Yo+tKE/45Twe6r3wtIj6d83g97MANY7
	wXJ8YU49/1LXxQ+B/0Vp7uWMaST/LLvqoyXYMYLdCCK0uqBmYMFP24=
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id d9443c01a7336-2d64b13195dmr134518165ad.4.1787416863141;
        Sat, 22 Aug 2026 09:41:03 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm15580796eec.23.2026.08.22.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:41:02 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tuong Lien <tuong.t.lien@dektech.com.au>,
	Ying Xue <ying.xue@windriver.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: protect node reset trace dump with node lock
Date: Sun, 23 Aug 2026 00:40:55 +0800
Message-ID: <20260822164055.3750284-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
node's link entries. Unlike the other node events that request link data,
this event runs without the node lock.

This permits bearer teardown to free a link while the trace callback is
dumping it:

  CPU 0                                CPU 1
  trace_tipc_node_reset_links()
    tipc_node_dump()
      l = n->links[0].link
                                       tipc_node_write_lock()
                                       kfree(l)
                                       n->links[0].link = NULL
                                       tipc_node_write_unlock()
      tipc_link_dump(l)

tipc_link_dump() then dereferences the stale pointer. KASAN reported:

  BUG: KASAN: slab-use-after-free in tipc_link_dump+0x10cb/0x16b0
  Read of size 4 by task ksoftirqd/0/14
  Call Trace:
   tipc_link_dump+0x10cb/0x16b0
   tipc_node_dump+0x4bb/0x740
   trace_event_raw_event_tipc_node_class+0x258/0x360
   tipc_node_reset_links+0x14d/0x1a0
   tipc_rcv+0x13f5/0x3030
   tipc_udp_recv+0x4e3/0x670
  Allocated by task 0:
   tipc_link_create+0x1e1/0x1020
   tipc_node_check_dest+0x7d2/0x11a0
   tipc_disc_rcv+0xdbf/0x1430
  Freed by task 89:
   kfree+0x131/0x3c0
   tipc_node_link_down+0x267/0x4b0
   tipc_node_delete_links+0xec/0x160
   bearer_disable+0x107/0x260

Take the node read lock around the trace event. This keeps link pointer
loads and all dump dereferences serialized against link deletion while
preserving the trace contents and reset flow.

Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..127848e8a644 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_read_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_read_unlock(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
-- 
2.43.0

