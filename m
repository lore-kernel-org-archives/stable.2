Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DC3C199C
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495023; cv=none; b=j8O7amu41dzOn6Y3rcFd/CgRJmXiJvlnQg9z57LpaubwbO5Iwq29JhJfTKugoszd42cpwFh03Q9HkMDBqHSOeVFT7yufahimXQCzvXy5ZEVi68t3OjUL90uVEo1qzg6A2MhALFEPW4NGNdqNBk7SuagIWFzkLcq7JQkU2qUbtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495023; c=relaxed/simple;
	bh=ZbJO8Gtrr3QowEw+MFdg2SPLU/ydrrRt2AYrsm/huDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YtLSc5UMt5TO/v3iUJVRRj7Cy0ErMOaYanldfEdyuNMS3mzZ1LJvV3R9wLv4/sAvCj9ptBGMTxDlFECXwh8MEPLZIrTyAvOayvqckdg3pB5xqARHK216O9aLqpy9pAypjPOR8lSEsJoDVDSEfbkpanhd8IjZcDLk5ZiWxQgfseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech; spf=pass smtp.mailfrom=lolli.tech; dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b=ZkSjVc6J; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OIKR+Ycz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lolli.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b="ZkSjVc6J";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OIKR+Ycz"
DKIM-Signature: a=rsa-sha256; b=ZkSjVc6JvujELKTTw8Rg505Q85zmMnPqB6GGGRZnZ6Rz4u2Gh/vUaRWBrizCO0NOCvKTf/3Ews8Y7ByeGH23NoM+1lhaW4wtJJ1U0uoXJ5TYwbk0BWOMTIU/cBg4QT+QCIoC+ydXFUZCMi07eAiw1UXH9B673oZuOoKiy0DpmajQbtN/49WUT2HiEBEEjjpJ9yMM7VXPF0J2QcHOHgxF2Esm9jGJtRZ35UG8o1Wzj/bqK/74qNPzNyzX94aOKYR6b0W6wxWLRO6rcZcbfSOMPEEMzhy9JGHU/CxBtbFd2P4VbMvwIAzzRlWxwrpEqbH7Jhq86tu5yIVgnij4MWFkag==; s=purelymail3; d=lolli.tech; v=1; bh=ZbJO8Gtrr3QowEw+MFdg2SPLU/ydrrRt2AYrsm/huDQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=OIKR+Yczu5cgkTudlEkr7RCHcU5fOL0v+kFFZRWRW5/ocNhJC6rRhP9TTnxTFDZnT0IbwEGgIVIHOXl7Sfx7qS7kpDzO0R3Th8D2WmUvZTka04YkfJ3hia6xsfmUXO82ehvtx/dTLIXJPeotqSceth5EaPZpONblmf1DLzsEUDWD2/fS68cMqKZK9UAu5a+lYvjNW0UJzBWUR5V6VJeVSlqHPnAY3ePzJcGXCLnS2SvpWczhilAW41pMJuBZFJajApSxWyQKtGDNmIzt68j6pe7pH6KSDZiLnQ1zKMuEzsOldqHZzND9YWa1PTNrKBVA8etGEWT/h9iFn4eKjv1O0g==; s=purelymail3; d=purelymail.com; v=1; bh=ZbJO8Gtrr3QowEw+MFdg2SPLU/ydrrRt2AYrsm/huDQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1437734:55302:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1801541329;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 27 Sep 2026 07:43:08 +0000 (UTC)
From: lollipopkit <a@lolli.tech>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lollipopkit <a@lolli.tech>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/cmd_net: end TX_TIMESTAMP multishot when the CQ is full
Date: Sun, 27 Sep 2026 15:42:06 +0800
Message-ID: <20260927074206.65427-1-a@lolli.tech>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

SOCKET_URING_OP_TX_TIMESTAMP arms an EPOLLERR apoll multishot and, on
each error queue edge, posts one 32 byte aux CQE per timestamp skb. Aux
CQEs have no overflow backing, so io_uring_cmd_post_mshot_cqe32() fails
once the CQ ring is full. The loop then stops, splices the unprocessed
skbs back onto sk_error_queue and returns -EAGAIN.

-EAGAIN is IOU_RETRY, so the request goes idle until the next poll
event. io_arm_apoll() forces EPOLLET and draining the CQ does not re-run
the command, so the spliced-back timestamps stay queued until an
unrelated later timestamp produces a new edge.

End the multishot when a CQE cannot be posted, as multishot poll and
recv already do. There is no partial result to report, so complete with
-ENOBUFS: no CQ space is left for the timestamp CQEs. This command does
not use provided buffers, so the value cannot be confused with a buffer
ring running empty. The terminal CQE still reaches userspace because
request completions can go to the overflow list. The application sees a
CQE without IORING_CQE_F_MORE, which it already has to handle, and the
first issue of the re-armed request delivers the queued timestamps.

A timestamp that cannot be extracted keeps its current behaviour.

This was found with LLM assistance while reviewing io_uring multishot
handlers for the pattern behind a RECV_ZC stall reported earlier (see
Link), and confirmed with a reproducer on v7.3-rc2 and an A/B run of
this patch.

Fixes: 9e4ed359b8ef ("io_uring/netcmd: add tx timestamping cmd support")
Link: https://lore.kernel.org/all/010001a0cd914529-23df2f94-bbe0-49cd-ae5d-=
05922356fa12-000000@email.amazonses.com/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-sol
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: lollipopkit <a@lolli.tech>
---
Reproduction and validation (measured on this revision):
- Loopback, one process, software timestamps, CQE32 ring with 16 CQ
  entries, a burst of 200 SO_TIMESTAMPING sends. The filling edge
  delivers exactly 16 CQEs. With no further sends nothing more arrives,
  although the application drains the ring and keeps entering io_uring;
  more timestamped sends release them.
  A burst smaller than the ring leaves nothing over and does not stall.
- A/B in a KVM guest on axboe/io_uring-7.3 (a3bdf68feecc) + this patch,
  with the new return behind a test-only runtime switch so both arms run
  the same binary, 10 runs per arm, identical numbers on every run:
    switch off (upstream behaviour): 10/10 stalled, 184 timestamps left
      queued, no terminal CQE
    switch on (this patch): 10/10 terminal CQE with res -ENOBUFS; after
      re-arming, the queued timestamps were delivered

 io_uring/cmd_net.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
index 7cd411fc4f33..90d4ec7cc761 100644
--- a/io_uring/cmd_net.c
+++ b/io_uring/cmd_net.c
@@ -69,8 +69,8 @@ static inline int io_uring_cmd_setsockopt(struct socket *=
sock,
 =09=09=09=09  optlen);
 }
=20
-static bool io_process_timestamp_skb(struct io_uring_cmd *cmd, struct sock=
 *sk,
-=09=09=09=09     struct sk_buff *skb, unsigned issue_flags)
+static int io_process_timestamp_skb(struct io_uring_cmd *cmd, struct sock =
*sk,
+=09=09=09=09    struct sk_buff *skb, unsigned int issue_flags)
 {
 =09struct sock_exterr_skb *serr =3D SKB_EXT_ERR(skb);
 =09struct io_uring_cqe cqe[2];
@@ -83,7 +83,7 @@ static bool io_process_timestamp_skb(struct io_uring_cmd =
*cmd, struct sock *sk,
=20
 =09ret =3D skb_get_tx_timestamp(skb, sk, &ts);
 =09if (ret < 0)
-=09=09return false;
+=09=09return ret;
=20
 =09tskey =3D serr->ee.ee_data;
 =09tstype =3D serr->ee.ee_info;
@@ -98,7 +98,9 @@ static bool io_process_timestamp_skb(struct io_uring_cmd =
*cmd, struct sock *sk,
 =09iots =3D (struct io_timespec *)&cqe[1];
 =09iots->tv_sec =3D ts.tv_sec;
 =09iots->tv_nsec =3D ts.tv_nsec;
-=09return io_uring_cmd_post_mshot_cqe32(cmd, issue_flags, cqe);
+=09if (!io_uring_cmd_post_mshot_cqe32(cmd, issue_flags, cqe))
+=09=09return -ENOBUFS;
+=09return 0;
 }
=20
 static int io_uring_cmd_timestamp(struct socket *sock,
@@ -135,7 +137,8 @@ static int io_uring_cmd_timestamp(struct socket *sock,
 =09=09skb =3D skb_peek(&list);
 =09=09if (!skb)
 =09=09=09break;
-=09=09if (!io_process_timestamp_skb(cmd, sk, skb, issue_flags))
+=09=09ret =3D io_process_timestamp_skb(cmd, sk, skb, issue_flags);
+=09=09if (ret)
 =09=09=09break;
 =09=09__skb_dequeue(&list);
 =09=09consume_skb(skb);
@@ -145,6 +148,12 @@ static int io_uring_cmd_timestamp(struct socket *sock,
 =09=09scoped_guard(spinlock_irqsave, &q->lock)
 =09=09=09skb_queue_splice(&list, q);
 =09}
+=09/*
+=09 * Aux CQEs cannot overflow and the poll is edge triggered, so nothing
+=09 * re-runs the command once the CQ drains. End the multishot instead.
+=09 */
+=09if (ret =3D=3D -ENOBUFS)
+=09=09return -ENOBUFS;
 =09return -EAGAIN;
 }
=20

base-commit: a3bdf68feecc57af5c11fb599f860ac9790ffad9
--=20
2.54.0

