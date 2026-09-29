Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5E3DCD99
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657726; cv=none; b=NCTeZDuTptmm76ZiuI7k2yJOmUD48rUf/BgEGCTWBjvt9yBEQFkbssZ23nTg68F1qWwWA7CHwqJjBcQD2VMl6PWsmV/koKDRH8AX0AWA2iXhD2OyABq7J0FglUUgBHzLyrxYoNb1wTI+FBsufkOJmMlnlfW6tADvhD4d1OtRFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657726; c=relaxed/simple;
	bh=DQy9kMeP46ETkmDAA5NHAlK2UZeyCZDRJAADxhAESiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3w7+B8QxX5fkrMkGHoSU1uvNZGpYbu7yNu4pSKIaSaz0PvBDcLgeHTtYXUEPKjOHs+izdhJVmWgCd9+1Hi0SdXukxaErHK92IJlvdTMJhOmgLHs/npHIXuO8/1YqUW2j0jruorFB1ViLJ5Or1tnWQCP4P6lLhvaMiIK5bbcczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech; spf=pass smtp.mailfrom=lolli.tech; dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b=RLXnHLDl; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=3rZUOArk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lolli.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b="RLXnHLDl";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="3rZUOArk"
DKIM-Signature: a=rsa-sha256; b=RLXnHLDlVdsRyqYcSA6XB+bss/sVXboUDxzKw9R2b9MhnTg/SzsRXAF9uE2cPO9BCYV0eZiaQYEZmuMoypBlL+V7ZgWu7ZCT0qr+FeBcIczl+PH2UyLSuetMSqo9lvZPXArnYJOg2uybOA9+xZs4F0aNxrVjdU4hA2C04VmRpUdyol/msIPH6LaLhTIcoNyWRoc3ED+hARUQFocmS+mJEH6EiQvGrc0xvBdf4Uy6Zz36EQMZu8BHEM1Sjlb9Yh/JP/t4iUKpPgmVsL+IIgVUvSU/HYAdZZ0ByJ+ADyRR+GlPuWaWDtfp523a6EwuAwY5casUH5TUdqnsbJlnoiWHNA==; s=purelymail3; d=lolli.tech; v=1; bh=DQy9kMeP46ETkmDAA5NHAlK2UZeyCZDRJAADxhAESiE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=3rZUOArkBleziwM4FQ5wYPYkk6gZZRmDmiigk8AaEVHGOW1vSpyHccBfFu9ChDwyzy+yq+U04Zt/c4fM6VC3g/5KhNwVqDxQB/tGmsq/nJKFhrhlFBGNtRiGpHhAXsO8/ZrWDeFHfbsk2pwUEd98YIjqc3qXODeKgo8Yi95+G6hTzkfaZk9+fy/oX/hIBdgi6ByndPkdlU7lIQ9eAhVF3OK77RSOwly5jgJNCs39pgsKOdK9Whei8NF0V7SXP8wfzet8hSzAakQBgi9KUuniC6jrvELhuJG3Vi5/5pjp/ElLmZDHihuXblJWryYXheBy/CKZMLxITNxsNbg4mUI4kA==; s=purelymail3; d=purelymail.com; v=1; bh=DQy9kMeP46ETkmDAA5NHAlK2UZeyCZDRJAADxhAESiE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1437734:55302:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1755747678;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 29 Sep 2026 04:55:08 +0000 (UTC)
From: lollipopkit <a@lolli.tech>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lollipopkit <a@lolli.tech>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs instead of requeueing
Date: Tue, 29 Sep 2026 12:54:33 +0800
Message-ID: <20260929045433.59435-1-a@lolli.tech>
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

SOCKET_URING_OP_TX_TIMESTAMP selects error-queue skbs with
skb_has_tx_timestamp() but extracts the timestamp with
skb_get_tx_timestamp().  The two use different checks and can disagree:
a skb the walk accepted can be rejected with -ENOENT forever.  When
that happens the processing loop stops and skb_queue_splice() puts the
unprocessed skbs back onto the HEAD of sk_error_queue.  The rejected
skb is selected first on every following run, fails again, and blocks
every skb behind it: new timestamps keep arriving and keep re-running
the command, but nothing is ever delivered again.

The disagreement is reachable without a race.  With
SOF_TIMESTAMPING_BIND_PHC the walk never looks at sk_bind_phc, but
skb_get_tx_timestamp() converts the hardware timestamp through
ptp_convert_timestamp(), which returns 0 when no virtual clock matches
sk_bind_phc (for example when the vclock was destroyed after the
socket bound to it).  ktime_to_timespec64_cond() then fails and the
extractor returns -ENOENT permanently.  Any skb with a non-zero
hwtstamp is selected while SOF_TIMESTAMPING_RAW_HARDWARE is set, so a
single such skb blocks even the software timestamps queued behind it.

Measured on real hardware, an I219-V (e1000e), using
/sys/class/ptp/ptpN/n_vclocks to create and destroy the vclock the
socket was bound to: 22 error-queue skbs generated (16 software + 6
hardware).  Of the 21 extractor calls, 20 failed with -ENOENT and the
one that succeeded delivered 1 software timestamp; deliveries then
froze while 8 further sends kept re-running the command, and the
remaining 21 skbs (15 software + 6 hardware) sat in the error queue.
Both control arms (vclock kept alive; no BIND_PHC) delivered
everything.

With this patch applied on top of the CQ-full fix ("io_uring/cmd_net:
end TX_TIMESTAMP multishot when the CQ is full"), A/B tested in a KVM
guest from a single kernel binary, with the new behaviour behind a
test-only runtime switch (the switch is test scaffolding and is not
part of this patch).  The guest needs no special hardware: QEMU's igb
model emulates hardware TX timestamping (TSYNCTXCTL/TXSTMPL/TXSTMPH)
and the igb driver registers a PTP clock, so the guest reproduces the
same failure the same way.  The two arms are separate runs with their
own sockets and sends; the device holds one pending hardware
timestamp, so how many of the 16 sends get a hardware skb varies per
run (12 and 8 here).  Switch off: 28 skbs generated (16 software + 12
hardware), deliveries froze at 1 and the remaining 27 (15 software +
12 hardware) sat in the error queue.  Switch on: 24 skbs generated (16
software + 8 hardware); all 16 software timestamps were delivered, the
8 hardware skbs the extractor rejected with -ENOENT were dropped, and
the error queue drained.

recvmsg(MSG_ERRQUEUE) already treats such a skb as skippable:
sock_recv_errqueue() dequeues it, returns the error message without a
timestamp, and frees it.  Do the same here and keep the deliverable
timestamps moving: drop the skb the extractor rejected and continue
with the rest of the list.  The CQE-full case keeps its
requeue-and-end-multishot behaviour.

Fixes: 9e4ed359b8ef ("io_uring/netcmd: add tx timestamping cmd support")
Cc: stable@vger.kernel.org # needs the CQ-full fix above
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: lollipopkit <a@lolli.tech>
---
This applies on top of axboe/for-next (3769bc31a5b7).  The CQ-full fix
is 3a3d93070c5e in io_uring-7.3; the two touch adjacent lines of the
same loop, hence the stable note.

Reproducer: a single-file liburing program that runs the three arms
(destroyed vclock, live vclock, no BIND_PHC) against any NIC with
hardware TX timestamps, plus a KVM guest setup using QEMU's igb model.
Happy to post it or turn it into a selftest if that is useful.

One behaviour change worth calling out: skb_has_tx_timestamp() and
skb_get_tx_timestamp() read sk_tsflags independently, so a concurrent
setsockopt(SO_TIMESTAMPING) can also make the extractor reject a skb
the walk selected.  Before this patch that skb was delivered on a later
run; now it is dropped, as recvmsg(MSG_ERRQUEUE) would.  With a thread
switching sk_tsflags about 800k times against 20000 sends on loopback,
this patch dropped 320 such timestamps.  Reading sk_tsflags once per
run and passing it to both helpers removes that case (0 rejections, 0
lost in the same test); it changes both helpers' signatures in
net/socket.c, so I left it out of this fix.  I can send it as a
preceding patch if you prefer the two together.

 io_uring/cmd_net.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
index 90d4ec7cc761..406fbe8b7d52 100644
--- a/io_uring/cmd_net.c
+++ b/io_uring/cmd_net.c
@@ -138,6 +138,21 @@ static int io_uring_cmd_timestamp(struct socket *sock,
 =09=09if (!skb)
 =09=09=09break;
 =09=09ret =3D io_process_timestamp_skb(cmd, sk, skb, issue_flags);
+=09=09if (ret && ret !=3D -ENOBUFS) {
+=09=09=09/*
+=09=09=09 * The walk selected this skb, but skb_get_tx_timestamp()
+=09=09=09 * cannot extract a timestamp from it: the two use
+=09=09=09 * different checks.  Splicing it back would put it at
+=09=09=09 * the head of sk_error_queue, where every later run
+=09=09=09 * selects it first and fails on it again, so nothing
+=09=09=09 * behind it is ever delivered.  recvmsg(MSG_ERRQUEUE)
+=09=09=09 * frees such a skb without reporting a timestamp; drop
+=09=09=09 * it here as well.
+=09=09=09 */
+=09=09=09__skb_dequeue(&list);
+=09=09=09kfree_skb(skb);
+=09=09=09continue;
+=09=09}
 =09=09if (ret)
 =09=09=09break;
 =09=09__skb_dequeue(&list);

base-commit: 3769bc31a5b79ec406df085592fd9dc14ce7df12
--=20
2.54.0

