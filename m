Received: from a11-135.smtp-out.amazonses.com (a11-135.smtp-out.amazonses.com [54.240.11.135])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A343440627;
	Wed, 23 Sep 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155247; cv=none; b=Pp/LR5O0whK5J6d4FM5pdZZu8k6xJ+rRlSpV9Epn51dYHHHbr15Tve5G3gGG/yYrFAO0VDewe6kz8qfSmOpokgwaz1ggWRcA6uOeJjo3zJ5yvolw5HZ0+TSGwks//gLJzx4+APAxNbcseC3ZQ6zOJbtFk4oa5dNyiYL/8NHpRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155247; c=relaxed/simple;
	bh=56F1tJzddi4oAdTxKeSfMiGnCGolC5XbQMVUsr+70Hc=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=H+iNsGdTdz3jFRh5uczYWlBwIp7eZ68XlnPfiOPLN2GcCqDP9Opz6jhljkZmoXqIKVux62iBC+gunFjuhZkUDGWgkZP3WQoc9p9Bh9uOIsa5DeN4tNMDrO2UB8b5icmmVUemYilChz5aQETuCjd+MEoBXxazUrRE2lL8IltEjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lollipopkit.com; spf=pass smtp.mailfrom=rsend.lollipopkit.com; dkim=pass (1024-bit key) header.d=lollipopkit.com header.i=@lollipopkit.com header.b=RohbW00V; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=cX/GmMES; arc=none smtp.client-ip=54.240.11.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lollipopkit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.lollipopkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lollipopkit.com header.i=@lollipopkit.com header.b="RohbW00V";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cX/GmMES"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=lollipopkit.com; t=1790155245;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=56F1tJzddi4oAdTxKeSfMiGnCGolC5XbQMVUsr+70Hc=;
	b=RohbW00VcUwfyMeiba5fg0Va1a5qi6ippFlwkvG/AGjDPF+QqUuJRnLqzvvwXp/6
	vAnd+DmPvAXP7PaZcnioK9805aqgYOSvAGAAhFd+L048MJN1rfhjkuP+9QWsm90N1DV
	z/3QOu8KdiAPXP7a6r80eTR4Uu9vqfN1mYzRmgBI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1790155245;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=56F1tJzddi4oAdTxKeSfMiGnCGolC5XbQMVUsr+70Hc=;
	b=cX/GmMESvqFk8Q1N2q0pKmfdmCl5Bja8faBj1yDvEPr7yFUApM8YJlbf1yJi3xmq
	DBqwdMW/qjefYwKKk2CWQMnVqbGcmhl8sz1DSqo0QDeJ0hCi5iLx+aoKPUkc/9ru97e
	yids3lOTf7iprx++u01+OiwWnbF864xlQdAkV1Ac=
X-Mailer: git-send-email 2.54.0
From: Junyuan Feng <a@lollipopkit.com>
To: asml.silence@gmail.com, axboe@kernel.dk
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, a@lollipopkit.com, 
	stable@vger.kernel.org
Subject: [PATCH] io_uring/zcrx: requeue multishot receives stopped by a
 local resource
Message-ID: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 09:20:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.zZXFpnRVb5v1SY0SyvHElzKYQkSXQPjo9kw1iCidPP/Xszxq/qqJllW0Ln+LCaEVNlbpfAg52fU51cAASENW1Yt7Egb17owWO1eovAvE1fqwD1XvbfSSHmutcmP6wAD73PZKmFk7PoV+NG0E0ET7/U+JZim5HeuAl2eGafhS4Uk=:1.us-east-1.pAEstvQcjyhQNKGKcgSlzI7SVR8ZSG5wSmKwiz/A8Dg=:AmazonSES
X-SES-Outgoing: 2026.09.23-54.240.11.135

A multishot RECV_ZC can go idle with unread TCP data when a receiver-local
resource runs out. An empty copy-fallback niov freelist returns -ENOMEM;
a full CQ returns -ENOSPC. After partial progress the stop reason is
lost: io_zcrx_copy_chunk() and io_zcrx_recv_skb() report the copied
bytes, and tcp_read_sock() drops an error from a later call once earlier
data was consumed. The edge-triggered request is then not requeued, so
it cannot consume the remaining data until another socket event arrives.

Record in io_zcrx_recv_skb() when a walk stops before consuming the
length it was offered, and requeue if the pass still returned data. The
failed chunk is first on the next pass. The resource is usually still
exhausted by then, so that pass fails at once and ends the request with
an error CQE, which the application must handle by re-arming. The
request does not spin, and the stall becomes a visible error. Keep the
existing skb limit and SOCK_DONE handling.

Fixes: 11ed914bbf94 =
("io_uring/zcrx: add io_recvzc request")
Fixes: bc57c7d36c4c =
("io_uring/zcrx: add copy fallback")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-sol
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Junyuan Feng <a@lollipopkit.com>
---
Reproduction and validation (measured on this revision):
- Loopback CQE-face A/B (mid-skb path), v7.2.6 + this fix behind a =
test-only
  runtime switch (one binary, both arms), 64 connections, large =
area so the
  pool stays healthy, 64-entry CQ, 10 runs per arm:
    fix off: 10/10 runs stalled (allocation_errors 0 -- CQ ring, not pool)
    fix on:  0/10 runs stalled
- On header-split hardware an skb usually =
carries a single frag, so resource
  exhaustion is expected to fall on an =
skb boundary -- the case a multi-frag
  loopback run rarely samples. =
Validated on GCP c4a (gve, TCP data split),
  v7.2.6 + this fix behind a =
test-only runtime switch so one binary runs both
  arms; pool face, 64 =
connections, 4.03 MiB area, copy-fallback path, 3 runs
  per arm (numbers in parentheses are stalled connections):
    fix off: 3/3 runs stalled (1, 10, 9 connections)
    fix on:  0/3 runs stalled, 64/64 delivered
  Allocation errors were =
7141-14995 per run with the fix off and 4796-5213
  with it on: the pool =
was exhausted in both arms, but with the fix
  exhausted requests end with =
an error CQE that the receiver re-arms and no
  connection stalls.
  The off arm behaves as upstream (same binary, fix disabled), so this =
shows
  the fix clears the stall; it does not separate the boundary case =
from the
  mid-skb case.
- iou-zcrx selftest (test_zcrx data path, =
zero-copy on the bound queue) on the
  same kernel passes with the fix both=
 on and off.
- Recovery needs an explicit cancel: closing a stalled =
receiver fd leaves the
  socket established while the ring is alive; a =
cancel + rearm recovers it.

 io_uring/zcrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git =
a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b3b11405..beb35077f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -374,6 +374,7 @@ struct =
io_zcrx_args {
 	struct io_kiocb		*req;
 	struct io_zcrx_ifq	*ifq;
 	unsigned		nr_skbs;
+	bool			stopped_early;
 };
=20
 static const struct memory_provider_ops io_uring_pp_zc_ops;
@@ -1899,6 +1900,9 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct =
sk_buff *skb,
 	}
=20
 out:
+	/* Bytes left in len mean an error stopped =
the walk early. */
+	if (len)
+		args->stopped_early =3D true;
 	if (offset =3D=3D start_off)
 		return ret;
 	desc->count -=3D (offset - =
start_off);
@@ -1935,8 +1939,9 @@ static int io_zcrx_tcp_recvmsg(struct =
io_kiocb *req, struct io_zcrx_ifq *ifq,
 			ret =3D -ENOTCONN;
 		else
 			ret =3D -EAGAIN;
-	} else if (unlikely(args.nr_skbs > =
IO_SKBS_PER_CALL_LIMIT) &&
-		   (issue_flags & IO_URING_F_MULTISHOT)) {
+	} else if ((issue_flags & IO_URING_F_MULTISHOT) &&
+		   (unlikely(args.nr_skbs > IO_SKBS_PER_CALL_LIMIT) ||
+		    args.stopped_early)) {
 		ret =3D IOU_REQUEUE;
 	} else if (sock_flag(sk, SOCK_DONE)) {
 		/* Make it to retry until it =
finally gets 0. */

base-commit: ab394388d05977f369e8e8d1beceae47fc3c5e72
--=20
2.54.0 (Apple Git-157)

