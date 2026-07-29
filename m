Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BF42EEBE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329381; cv=none; b=OB88iCV1bB3aPDwCAUsJwAV0GLKD1SLRM/sA8dt6AtMtnw52R4z5GLNPDDodQucqxbcTwNqTk1mTOJtytmsf6Hm0O66USwDga6hghjS/v0l9OW0Mz5RdhKuf7OH+G9Nxfr1FJPkQspPobL5OMeYzucoVoOvcoc8eCNq4jzVeNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329381; c=relaxed/simple;
	bh=dMdTSc3Tl06nw6OzYIROsHnUf57ucn/iJeZtWzjvvy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXg7/E+I3CMl6dNx+Or97Ci0uqbdu/hZw0+YZuykqsWIEKnU5qdzkJIa6/bPgzujkb38bWCmZZS4G14xHOIFnkFODRnjWKRAZUQKEDn7OgWctMqDkXyUVMl7/hYN9Hyyjb+O2VdCw+KC9pkuHPDLkjWbaKOTj8eTRkZauMNMI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=j9I+6Z/i; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="j9I+6Z/i"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e55b62640so52079685a.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785329377; x=1785934177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sibTfHUhgDSEqAJ8U27DkLL8Rr1uOtqg41a+d4rH7xQ=;
        b=j9I+6Z/iCdtA5TjdVLfrJNg7bTQpImHYzEkia9XJgbz4Vzsz8KhfdcC6dZr0rrHlOX
         5IsZT71tM2KsbOi0ZD56I8CzP1r5oymaPQrCaP6oM5HUSoJM6dsEgLpZjtzr2MAqAk6Q
         Mg8WIxw09aRdG5gxuTry1GeVqMdhK8Wnp7/+PxIJmc9odmAEpHCCAOyS10QOFph2r8ba
         Uw1K9DawowncIj/BZT3kT3Ja2Uz9q6CEasZ06YqCArK1dE1nVCrVKYdHU0k5U0c+8SHT
         3X7n5+vTp22qKSpg/Xqk3mKDLKAWWqeMgb6eHuVMsQZ1U2Spyjj4ZV2UX2BXhsxIoLFT
         It9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329377; x=1785934177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sibTfHUhgDSEqAJ8U27DkLL8Rr1uOtqg41a+d4rH7xQ=;
        b=CW6X53X9jNPVsOIYYTy4+bC5YbACN9PFanIm4PhvNyqHlcW0BExHdOqrBn/FE6avAn
         8C/h099O4FpCXPSMh2rrhIFXmKILoa/Bg50Mp+NNG5YVMcPt1G3ASIjhtgw73Uoh6xEw
         q3HV3IXQJ5PsJheMMjr8bIWDdu5UjmHTTMYj2nd1B96ikiECP4cvC8S02stbGZsv3p/B
         n3SmwYW6osBMkyEAtWcU6x/wkVQYhEYPbgQO/YdndpFZvTiI4hZCM8G0Dh36Qq3a3DGX
         f0uQIDycQwxkvt84L3ss/3Ev22rE3sfFRhccZ/lxzevInwSyn27Cg/745Mdx9DA1cWiH
         zw0g==
X-Forwarded-Encrypted: i=1; AHgh+RrJJu2fo6CgblCZGs80FecOn/AKdJf5pHLqv5tnRudAyGbzxTzdkSIloArG3LGQfYjWGi7+zQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8osMdyX1O9UfOcyhEX7tt7oQU8trcvokv2utHbwyl/ZVzWnuk
	56Nl1BRtEfqRT9vtBo0xVkW3y5zzTVJcwjA3wRzC7pNrrzceiKITzPVrjPdwg9x581Q=
X-Gm-Gg: AR+sD12WBOuKnwHrqkAHciNBsQ1Ovg0jlVjFVV4GqRi9zykozqWoi2py1Ypay/b5WGJ
	cHBHFoCUO1tjutRYBcnhWU5YP9DR2q5Mp+KwleeMjnI7KMo+i+GaXlzjjNxJLpUFcMqn83NZS/z
	az6EDNbjpUexEwxBghEoHm3polIkClBwb5v8CFX838yPDjWHw3LZ3VOpVvJaEOq6qKEk+VTiX2r
	yDlSpyNHL4sIytY+RxG68/pT4YIve2hclmxFgxal1Fgyk9kIEpSu75Ie1Y1iy00E8d7Nfcbz78O
	rc4HGJ7uNi2mjsqJOk5KslnVB6mr0xwHsRH/QYPM69G0Gsauy+Z44nUXtywlo9pKsyv/OcRQ/qY
	UAf4Y8/UCk5AnOYI46G1cr5UnUMu4ykur8mRhtbMmEEy+CnC7riFuc6SS1yGpHtlViprXLQMxZV
	4mtObJ2d1WRqT4O76GBJK19R7pTswO5QIrn1+ZhETItCyuVSo6rKG6HYY2dLxZaV7u/vGR6NLR6
	/+nqNINR+CdomuASbt0QkOrsJc0JGMsHAoViDrV0nJzK0y6tj5az7SiHlRMfqbh+HMiwhyddiMn
	WBRftU7KYca3XMRRSg/P7npeykji5OwcyhsHG1E6
X-Received: by 2002:a05:620a:1729:b0:92e:5f90:c0de with SMTP id af79cd13be357-933026efff5mr662962785a.22.1785329377284;
        Wed, 29 Jul 2026 05:49:37 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3257522sm160393885a.11.2026.07.29.05.49.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 05:49:36 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v2] sctp: keep chunk->transport in step with the list it is queued on
Date: Wed, 29 Jul 2026 21:49:29 +0900
Message-ID: <20260729124929.5885-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726060453.42730-1-baul.lee@xbow.com>
References: <20260726060453.42730-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__sctp_outq_flush_rtx() moves a chunk onto transport->transmitted in two
places but only one of them leaves chunk->transport describing where the
chunk actually is.  The ordinary resend path is consistent because
sctp_packet_append_chunk() rebinds the chunk in
__sctp_packet_append_chunk():

	list_add_tail(&chunk->list, &packet->chunk_list);
	packet->size += chunk_len;
	chunk->transport = packet->transport;

The gap-acked path has no such rebind.  It parks the chunk on another
transport's transmitted list and leaves the stale back-pointer alone:

	if (chunk->tsn_gap_acked) {
		list_move_tail(&chunk->transmitted_list,
			       &transport->transmitted);
		continue;
	}

So a chunk can sit on a live transport's transmitted list while
chunk->transport still names a different transport.  If that transport is
then removed - sctp_assoc_rm_peer() from an ASCONF Delete-IP - the last
reference goes away and sctp_transport_free() RCU-frees it, leaving the
chunk with a dangling pointer.  sctp_assoc_rm_peer() scrubs the
back-pointer on peer->transmitted and on asoc->outqueue.out_chunk_list,
but this chunk is on neither.

While tsn_gap_acked stays set the dangling pointer is not followed, since
sctp_check_transmitted() skips the flight accounting for gap-acked chunks.
A later SACK that reneges on the TSN clears the flag, and the next SACK
then reaches

	tchunk->transport->flight_size -= sctp_data_size(tchunk);

a read-modify-write inside the freed sctp_transport.  KASAN reports a
slab-use-after-free read of 4 bytes at offset 216 of a freed kmalloc-1k
sctp_transport in sctp_check_transmitted(), freed from
sctp_assoc_rm_peer() via sctp_process_asconf().  The removal and the
faulting SACKs all come from the association peer, so an application that
speaks SCTP and accepts multihoming is enough to reach it.

Assign chunk->transport after both list_move_tail() calls, so the
back-pointer always matches the list the chunk is queued on.  Doing it on
the ordinary path too keeps the invariant local to the move instead of
resting on a rebind that happens later and only if the chunk is appended to
a packet.  Fixing it here rather than by scrubbing more lists in
sctp_assoc_rm_peer() covers the chunks that were already migrated before
the transport went away, which a scrub at removal time cannot see.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
[Reported privately to the maintainers on 2026-07-10 with root-cause
analysis, a PoC, a KASAN log and a fix; posting to the list was requested
as the follow-up.]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2:
 - fix the root cause in __sctp_outq_flush_rtx() instead of clearing the
   back-pointer for the retransmit queue in sctp_assoc_rm_peer().  The v1
   scrub could not see chunks that had already been migrated onto another
   transport's transmitted list before the removal, which is the case the
   reviews on v1 asked about
 - correct the Fixes tag: the inconsistency is as old as the code, not
   introduced by df132eff4638

Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.lee@xbow.com/

 net/sctp/outqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13da..1b2d08f2e 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q, struct sctp_packet *pkt,
 		if (chunk->tsn_gap_acked) {
 			list_move_tail(&chunk->transmitted_list,
 				       &transport->transmitted);
+			chunk->transport = transport;
 			continue;
 		}
 
@@ -715,6 +716,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q, struct sctp_packet *pkt,
 			 */
 			list_move_tail(&chunk->transmitted_list,
 				       &transport->transmitted);
+			chunk->transport = transport;
 
 			/* Mark the chunk as ineligible for fast retransmit
 			 * after it is retransmitted.
-- 
2.53.0

