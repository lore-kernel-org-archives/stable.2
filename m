Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408147CC89
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243009; cv=none; b=tqeztFors+7oehvnMTYw5C9nEz8+9e2JMBmO8Ud7LaHboUk751YdtfBX+r8xV038C0KNd9k8gG7Oxlv6B+WkFR6+qRGsxeUH46Do42+4C6JhbHoqaqYRUiGftiEjgasu/MhMczYMEKo0jbi9Ykf6F4hEbjWkIwOR8226yynM9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243009; c=relaxed/simple;
	bh=wOpPq8J9xFk6jgQSnvisusIVhRRpuSYK+LEmi6Tqw/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBoHtRXf86KsG1WsxS+lhhPISjZMLHrqALnoGZzWo0sXfZ8zZDEOQpU8UfN6/Vdomu7SP8AeAvYrLd+wWig8y777vP67lrMw0mwv9/iKfpwV1s7yM1RuxVs+y/gFQxxoQtptBFrM1Ih5NjCNcfF4wBPjJivQV77P63h666y8ekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=strqcKdA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="strqcKdA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2994009a91.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787243007; x=1787847807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9hOE/x1CqgPd8sqR178LEmzWO/estVscP715cq7wwU=;
        b=strqcKdAVFhxaFF0NmV2/2rfCtdVRlnHuSZw+HlcrPJzuYLnp3F04dMIicOJ5qcmxM
         7ZtrKFXK57F3Ec+9HaICicRU9iHYR7Pr9czqKwtoYkn6A3b6GkTeuVxO7SoOYRMJc+CM
         IMXZvXix1+6wbJtXWvaf2Y7zbg2CL78DMQuDjt5pV4QqNnS1DH8pNpM3S2e8uockbnyk
         pBtkkeojqK0n8mygncst+0yFiht00lUtS1moxjElizdeCzians+tO5nzsWkkCnKVNa5z
         cKHxvW3XOfz2irMu9vLAb/FnKAjkJ43NXEhaSxfHHtOg0ep3+v7J//Lq+id9RhzmD5Lw
         mT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243007; x=1787847807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9hOE/x1CqgPd8sqR178LEmzWO/estVscP715cq7wwU=;
        b=qRmZhXHwoHC67MPaMntX82BVyxn1vyrrsm+75Gs9ZWfb0MUKfH0frlRDmuej2fFVdN
         g9R5tr4S1fBpZkDIcHGsTx2mvm5I4qhCGenOetc39Kcr9vhMvWhKgaJt4BqjxtBgU94v
         yXj6ELiLFj4mzb/Oi8BjFOObmWeCi4fvKmZeylnFbwBtz9Rd0PYcQ+AQ8ZVTZSdGGsr+
         OE1BsJd5zTcWhq581TyVKk3K3zNpr3fxUptPUIJIo10X/H/ljEVoiPveEQa1k+E4CAOB
         lfmPWR7+9xDta2XJIaNk1/uxuN/n5Lrj3oHk7g4GftPVfgEZO0hXnuREunADrDvY8XOB
         g9oQ==
X-Forwarded-Encrypted: i=1; AHgh+RpE5JktF/Uabpa7pdcpAHYGYqazXuQY+jFo5HoEI0niNL4QdbVlBAKSdMVrz8P8bo1ft9HrEAw=@vger.kernel.org
X-Gm-Message-State: AFuF++nfj2RB41OsqvCqRhh8y5gVt8AgT4guoP4Co2vVACTvcpwKFkf/
	4QbYUxKFmRKXq1U53ddtUHUUfw9xfQ4Rc24l/W4UoWp1/LoVtUqkWq4S
X-Gm-Gg: AR+sD116NqVtJ3naFHWoYQbuDAUmmp26uuwjx7jcJdtdMsfsnWVf5ALoiPlYk3gMypi
	cLpdMCJ1028x+XTNX8tZqvME2gd6uHBcG2nmTiucXtXusUCqF5TzAeiNf7aYEx1ZcK3Y7Yo8Ul2
	lOfHnEdV9lIJY4Xnny9kiyKkKocdMk/EVdigGxBKRipyFODMMzR5EE6H05hzFFbjli83Vsv/otb
	zBtS4czd3KjgQAfL2GC3RImHLLqF9GxFAKuMg71EkrhAt1HWmKEm91rGYbQRA/KCzoA2OW19IDN
	0aAMqKO8H2eFnoWyo1B7K0zRgEgsRhlEeTf8cClDAEW0YE5DUqOSHWlWr6cqwk89CcGfi45n03J
	Nh96W7nXAeCB90zuxV6FPIKF+HmJvFcxCBokaiG6pcGKZgHlL1ok9SEdrkT34JJU2Wcd9onmowb
	Y+szYAZ/GjZGxYeiEa12Xpm2nZeA9F8gbm08oYWmtUBpWvJP+2165i10Je6wzTUoRXuKvXhOEPy
	dd2KqNj8uWsM2FrrzL+
X-Received: by 2002:a17:90b:164c:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395812c6e07mr22875749a91.16.1787243006832;
        Thu, 20 Aug 2026 09:23:26 -0700 (PDT)
Received: from localhost ([82.40.34.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb3069csm8652740a91.15.2026.08.20.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:23:25 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: bestswngs@gmail.com
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix NULL deref on untransmitted RECONF completion
Date: Fri, 21 Aug 2026 00:22:36 +0800
Message-ID: <20260820162235.2668698-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
sctp_process_strreset_resp() finish a pending stream reconfiguration
request by stopping the reconf timer on the transport the request was
sent on:

	t = asoc->strreset_chunk->transport;
	if (timer_delete(&t->reconf_timer))
		sctp_transport_put(t);

On the transmit path chunk->transport is assigned by
__sctp_packet_append_chunk(), that is, when the chunk is actually
appended to an outbound packet. A RECONF chunk that was queued but never
transmitted keeps transport == NULL, and its reconf timer is never armed
either, since that too only happens once the chunk has been appended.

sctp_outq_flush_ctrl() skips every non-ASCONF control chunk while
asoc->src_out_of_asoc_ok is set and leaves it on control_chunk_list, so
in that state a RECONF is never put on the wire. The sender side has
already published the chunk in asoc->strreset_chunk and armed
asoc->strreset_outstanding, so an incoming RECONF that drives
strreset_outstanding down to 0 dereferences the NULL transport.

sctp_send_asconf_del_ip() reaches that state without any peer
interaction: when the address being removed is the association's last
one it stashes the address in asoc->asconf_addr_del_pending, sets
src_out_of_asoc_ok and skips chunk creation and transmission
("stored = 1; goto skip_mkasconf"). As only sctp_process_asconf_ack()
clears the flag, it stays set until a later bindx() ADD picks the pending
delete up. An unprivileged process that removes the last address of an
ASCONF-enabled association and then asks for a stream reset panics the
kernel from softirq:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc000000003d: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
  RIP: 0010:timer_delete+0x67/0x110
  Call Trace:
   <IRQ>
   sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
   sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
   sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
   sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
   sctp_rcv (net/sctp/input.c:243)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   ip_rcv (net/ipv4/ip_input.c:612)
   process_backlog (net/core/dev.c:6680)
   net_rx_action (net/core/dev.c:7959)
   handle_softirqs (kernel/softirq.c:622)
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Skip the timer deletion when the RECONF chunk never reached a packet:
there is no armed reconf timer and no transport reference to drop.

Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Outgoing SSN Reset Request Parameter")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Note to reviewers: this only stops the crash, and I want to be upfront that it
does not remove the state that produces it.

That state has exactly one producer. sctp_send_asconf_del_ip() latches
src_out_of_asoc_ok on the branch that stashes the association's last address
without building or sending an ASCONF, and sctp_process_asconf_ack() is the
only place that clears it -- so the flag survives until the application issues
the follow-up bindx() ADD that sctp_make_asconf_update_ip()'s del_pickup needs.
8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host") describes
this as a transient state ("the other chunks cannot be transmitted in this
state"), but nothing bounds how long it lasts: an application that never adds a
replacement address leaves the association unable to send any DATA or
non-ASCONF control chunk for the rest of its life, with the RECONF sitting on
control_chunk_list and strreset_outstanding armed.

I kept this patch to the dereference because it is what the rest of net/sctp
already does -- every other chunk->transport dereference is NULL-checked -- and
because it backports cleanly. But would you prefer the latch itself to be
addressed, or the reconf request to be abandoned here rather than completed
against a chunk that never went out? Happy to follow up with either for
net-next. net/sctp/stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..1cb30def2eb9 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -577,7 +577,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 			struct sctp_transport *t;
 
 			t = asoc->strreset_chunk->transport;
-			if (timer_delete(&t->reconf_timer))
+			if (t && timer_delete(&t->reconf_timer))
 				sctp_transport_put(t);
 
 			sctp_chunk_put(asoc->strreset_chunk);
@@ -829,7 +829,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 			struct sctp_transport *t;
 
 			t = asoc->strreset_chunk->transport;
-			if (timer_delete(&t->reconf_timer))
+			if (t && timer_delete(&t->reconf_timer))
 				sctp_transport_put(t);
 
 			sctp_chunk_put(asoc->strreset_chunk);
@@ -1084,7 +1084,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 	/* remove everything for this reconf request */
 	if (!asoc->strreset_outstanding) {
 		t = asoc->strreset_chunk->transport;
-		if (timer_delete(&t->reconf_timer))
+		if (t && timer_delete(&t->reconf_timer))
 			sctp_transport_put(t);
 
 		sctp_chunk_put(asoc->strreset_chunk);
-- 
2.55.0

