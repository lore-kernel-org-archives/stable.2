Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F735202C
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419472; cv=none; b=h57Ag9VuBlylKWt/hqrJkH6Es3uBJj89MobBucwYFc0GCsJPXP5N7SvlZCoJOe7/MOm5K5ioL9I/9f8D44ZxJ28nFVAKIBhm6BBwFktvdr0Ct/BHpuOO561rBVFReTT+TcQaR7NBNtFY1ya86iZX6Q3hdNi9HogMTwV0RVfNqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419472; c=relaxed/simple;
	bh=pOiaLjZ9fpt+a+XvW0OXbQmtWskAHbG7Nale7iIf85c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpcCe+hUm1sFFzJwVIzWPbYrpMuntz8H8qxwOtR/H7DK44luKE/RJUrgvAST6r+iDd8mJyOqWFrERwbBTzhGwc1LlzjdQUY28Zz340r+yAAbY5o3J+A4qT+qoW0fFeMScCWMGLI94XJ0QRjd/yFN9irESowS+RjTyM+KL1vY558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba5N46fV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba5N46fV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d01663d816so17699745ad.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787419470; x=1788024270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uwXJyVRdsHqAOLn45dLgJGtrCpRhfgYFpCZ94p0Y+Ro=;
        b=Ba5N46fVGj+WNLVAWr0cxtMfwA2pfbfUYNiSy1RRusHFbsIoYpxfMQJB9ulC2jZkja
         Pd3dpLQr/d8Mokms60a0a339IV8Ck+CTHPDE8ePWjQ0a+6UxvHFwdQnq7h3PQ5OWUAj/
         +liuH7qy4fOF9lJPgvS+SLlL8hlGpQCAe0IJwnYPt0xb/EYkNmo/b+lAhk4cHl3SfIBZ
         fpJhf8jDBTl1uWAty9n1sA82fl4RU1NsLy+Hte5wxih6lJ3aHa3SZrSnviXog3/ao9J5
         eLvpHzKWVjYvLPM8fMjqJThSKdVfmW83AsVaGIzut503e9c/GsxPg3dUdU3ecq0VPkhc
         6aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419470; x=1788024270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwXJyVRdsHqAOLn45dLgJGtrCpRhfgYFpCZ94p0Y+Ro=;
        b=ju9g3K/pjjDSGVSC6/Tp8I5D1hmTdplyay9B4qxQDAFTgtXdUOVRwTplHFT6xGjIEP
         Z6C9/NtJp/PRzxfzglKdde51WuNNf/VI/5+tHdyyQs6MQA/F8R3T0tOO7pNt8VmR7rLJ
         osIp4cfUv5UAKkGkxrgRvunOH+4yvdoCaIghgpOPpfQd+WoDOYHCW6vnw0ZjlNouhFLy
         Yf2eQJni8vh1yJTQveJGWhgRuqWGVcQ/j/tR7dL44v+aTg+DqO5D2OLeBstDcUjghE4V
         G6USq3eduFMqwXgIq/bKqFJB+8+Ii4TrFwCWVsIufGHYhS8Il5xFq2mEKvChgHqobK3E
         U5Ow==
X-Forwarded-Encrypted: i=1; AHgh+RoCxi78bDjgRg25yz3xL9gBCzKUhq+jpjU7YP8srpZ3YVroCuEOjHb1i2ibbTcl4YFaAYvK/8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mmCeGQTK9SFrSftHRSMsTvMo0avNGMoKyTEHGgyfV3kf6jZRUt
	9ZppBCIPpwHj0lLGZbsit7g+9yNCmFbwf6ReSKaybRszUhLwbZQJmQUn
X-Gm-Gg: AR+sD135QeE6Rt3718YesmyoVY80KiczyE/JET9AY7e+cOLZq5dh7JNfS+QCYgUp04j
	To+PDIMnhG7S8L5x0eyFZzPE3RhoAY2j5zcMjjiGVKqKvyrgCSMzDb43jmaCe8rRBl5BehLeMKE
	knaaJ1CKrODTstdZNzwY98SRxv1alXQO3qHN4pL1LUa2OP38BUMoY/7WfUe6m6WHW23x5ksBcDV
	P0dN77KC31AZYyxQXnRCw2uBYJbHwKxfqFf/ZQFgnvvpYXC/BsNt2Nc4hApKWKzXUwvs6aMlBXt
	6z0c6wyUbChDTkYbtjg+LOsOXQJn1ynknl9LeCtYrpGNQa/UyWEklLUZmJco4zV83t9kdljFjPA
	mvdBfIB26c3yduMS8fvtFeLMFNQpcTsyLQEzHx7QD8+lhH/xIYoIwBW3PWymQm70y/rSfFx+abV
	1bn+ZyWeCdbpHt0Rzs9yrHn27ToZR8YyVU+xFfPTB/p8m57oqzF58o7Ux8XQziNzPb3dU7GFDrp
	sjmUr2xIy0q9+0jn1TCC3E=
X-Received: by 2002:a17:903:354b:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d64ada70cemr272498995ad.1.1787419470298;
        Sat, 22 Aug 2026 10:24:30 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.113.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767a614asm5220975ad.31.2026.08.22.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 10:24:29 -0700 (PDT)
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
Subject: [PATCH net v2] sctp: fix NULL deref on untransmitted RECONF completion
Date: Sun, 23 Aug 2026 01:23:54 +0800
Message-ID: <20260822172352.63025-3-bestswngs@gmail.com>
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

v2:
- Guard sctp_chunk_lookup_strreset_param() instead of NULL-checking
  chunk->transport at the three completion sites (Xin Long).
- Note the peer-only path into the same dereference.
- The src_out_of_asoc_ok latch is still not addressed; happy to follow
  up for net-next.

v1: https://lore.kernel.org/linux-sctp/20260820161400.2649968-1-bestswngs@gmail.com/
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

