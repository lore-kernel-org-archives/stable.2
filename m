Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E183331EB5
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506154; cv=none; b=AB2Gipz4EM2LCkjtByeIGSmeCxqxvwCArqB0WaQq61xUUnR/bhoaVWpAkTdQPS+tEkX3a73kVxFdml4rxk/+xXpCTIPUiWucp/as1v/lSkb4Igv8r4/OsEzJw33e7cvhK5vIrxC6J1x3SQ2+kA1IQ3OEyM22nyG8CMb5LwPjofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506154; c=relaxed/simple;
	bh=iTKOf7uCI2/d91q6OlhbzHUwpygffkInnHb9WWl1Ops=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRiYT/5Mw7EjWS7pu8uYLKdTQTsCsgN+lneH/ePRsVldR6EQHNFXRyrkp7WVNYgMrFME5R0g7aBZIY9yraPYL2a7LfRk1vHGXy8bwaprowpRX3ekxeQGHDAXTm8TeUVPgOfbL7SmtgG2CMgISsHedH+snCG+SkhsdVFb3WRuNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWnCPnBq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWnCPnBq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1744299a91.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787506153; x=1788110953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uH7PuwtEATmQil0pCnUwHz2U63JqlbC31pLQWpx/cs=;
        b=nWnCPnBq3+vFqpFZmpCAeU/bXJVqkd9JPWlMQ4yT2/ynUAXzLEC1Apt6Dxt3khYOTf
         s6t8XckSwgg9PBTZypV1SHNDdPk79lH3W4oIEBtj1S09EVBW1eX+nLGAGxCAFf/lzAFC
         iAdPsg34LWwqtkdW7DMgdWoYLHgQEclgetUSyHFNvL5i7sjWO01Qa2JUqjlGTgKe7xFk
         9RSb3sFiMcgQydRzdo2eP+86ZmMBHp/BYXQNFnXNUiZHEnh+wO6vpBfuFzc0u5xZNCdk
         AHReBPvkjpPO6gb4tFB/OioxJIbHOGKfSUJp2PcLivhVxtZqdUVmMsUt/fr/p39Y6yQX
         KnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787506153; x=1788110953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uH7PuwtEATmQil0pCnUwHz2U63JqlbC31pLQWpx/cs=;
        b=eo86xwNePE/oYs5t4WnJkWaoAsvFJ1PeWq4/azcm3zGqFPJn/XiKtF+nl9eEsJu2UB
         v+f8RE7DZN7YzxDa2/RAcsJpHgz2SPaF5iV6tAFjS7I/YcGd0XAPbhMr3bPWBFs3NJ+r
         cvNy6LvPBgY+c7V6YZdlptm6y2VPkZoFNf2uIrWjcbK2r2Sw/R59X6HGzSMPStFjyDCa
         L0ypQlyfixIk6/Debo8iZUtiFHmYmKoPohAABalEBc0Ln54za9V6JXGncmVdwFZRdS2/
         dOPk8yHEuErknozNiTvBKkw8HhyjyViNBG2Oe8h/RI/668agpy8eMVus6hr//Gd5nAD+
         vG0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcWKa1GuJm7om9CTE+aoEZFlm/DFT992V2xeeXonW27mudk+YWScHn5e5d58Mgh6N/Vu7bT0E=@vger.kernel.org
X-Gm-Message-State: AFuF++mPkq6xe9bz10hOWQRgUTpmsLKGBKvyv226H431u1VdPWOt3e8H
	hGvCc4kBXOgf5UR1UwmKHVAZO7PL3ChCQrtT4tWy42JgaUo4AAJXduBB
X-Gm-Gg: AR+sD13NhaSbU4kQLIc0rDHi9sHGX2Kzj9l6g9ak8JPgaS3ep51HcAQhBR0ct/cYiVe
	FYi7adRZsyc9KiNncKSIFCdLyUAjoYhfGEN7MMsrL4A6LJ72Cl9CR6tN4YaW/Iy8gTm+QatdcoP
	XFSrIz7AhrgAxQhHRtZDtrp2pEbAKHO1s5dx8UQoW6rc5F7SOzQR7HsL9I/TjTSG4UvXGHXja4e
	V+Qq8fD3JWBia6/Mam1P19J3Ft7R0IKa4UDzXYHWgaBMlUVeprVPhBe2e8EWSjykORVC0Dkxzen
	p8i7ZvgDcOjQyEG+u36MIKinndqXobMNc1hfiuJadIaXbsn1xqtRfzdwtSBVOPyGJA8uz5JBmyC
	NV2PF6gOvMcXLocDadB/dHc5OwtWGx6Z0+lTw2oGhYINKC0S7Yk5meSLSJuN/TO4EM9SUPrEckR
	YdLlTgrdbXuvmalSLjC9Fnd5opczYX5SsHTjO0nN2aqTiL6VLaVRUh+kikNIYTjGteExcElqBbv
	BOpky66f3xSrx/J3INJE/U=
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-395c354d445mr33626577a91.2.1787506152714;
        Sun, 23 Aug 2026 10:29:12 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.113.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a1597csm6654547a91.13.2026.08.23.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:29:11 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] sctp: fix NULL deref on untransmitted RECONF completion
Date: Mon, 24 Aug 2026 01:28:58 +0800
Message-ID: <20260823172857.896146-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
sctp_process_strreset_resp() complete a pending stream reconfiguration
request by stopping the reconf timer on the transport it was sent on:

	t = asoc->strreset_chunk->transport;
	if (timer_delete(&t->reconf_timer))
		sctp_transport_put(t);

chunk->transport is assigned by __sctp_packet_append_chunk() when the
chunk is appended to an outbound packet, and sctp_outq_flush_ctrl() arms
the reconf timer at that same point. A request already published in
asoc->strreset_chunk but not yet transmitted has neither, so completing
it dereferences NULL.

Two ways to get there. sctp_send_asconf_del_ip() sets
asoc->src_out_of_asoc_ok without sending anything when the address being
removed is the association's last one, and sctp_outq_flush_ctrl() then
leaves every non-ASCONF control chunk queued; as only
sctp_process_asconf_ack() clears that flag, it persists. An unprivileged
process that removes such an address and then asks for a stream reset
panics the kernel from softirq. A peer needs neither ASCONF nor local
help: sctp_cmd_interpreter() uncorks the outqueue only once the whole
packet has been processed, so a reply built while walking a RECONF chunk
stays untransmitted for the rest of that walk, and one RECONF chunk
carrying [Incoming SSN Reset Request, Outgoing SSN Reset Request,
Response] -- or two RECONF chunks in one packet -- reaches the same
dereference.

  KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
  RIP: 0010:timer_delete+0x67/0x110
  Call Trace:
   <IRQ>
   sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
   sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
   sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
   sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
   sctp_rcv (net/sctp/input.c:243)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   process_backlog (net/core/dev.c:6680)
   </IRQ>

A response can only acknowledge a request that was actually sent, so do
not match asoc->strreset_chunk while chunk->transport is NULL. Guarding
the lookup covers all three completion sites.

Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Outgoing SSN Reset Request Parameter")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---

v3:
- No code change; v2's changelog linked the wrong v1 posting.

v2: https://lore.kernel.org/linux-sctp/20260822172352.63025-3-bestswngs@gmail.com/
v1: https://lore.kernel.org/linux-sctp/20260820162235.2668698-2-bestswngs@gmail.com/
 net/sctp/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..2012f61e250e 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -488,7 +488,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strreset_param(
 	struct sctp_reconf_chunk *hdr;
 	union sctp_params param;
 
-	if (!chunk)
+	if (!chunk || !chunk->transport)
 		return NULL;
 
 	hdr = (struct sctp_reconf_chunk *)chunk->chunk_hdr;
-- 
2.55.0

