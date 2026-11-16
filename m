Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815622;
	b=qJF2om9KK0ssP/DRhdsShTq7dVjxqhQiSjuV5JhqS7CyX8Ftq3HPtvmYQZJ5nmrRGZ4v
	 C6NugQqzDw5vaGivg1PjfJraMGy2ILqHzv9+ZyG067JdF0/DWifHtoKkb7mESep3tc8Nd
	 b89FIoNuf3opxwSZVG6bYq/81O1J3EAe4jKGxlDi6FqIHkyGRuPYSO6LxhT2mhMwGbAQw
	 hIxQIr+t7OIlerOk53SgL9jGoSitRQWf4jPzbsUCHYsKATfvpTaJD5SHYP0Zc7BvvuCU2
	 s1XfpV09kD1rHZ9fLYE2WqmXAtoMUbn9V5LngYkSlbNFbLbikg/KC13KtzaTwhwTbag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815622;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2F33A6bEP+OrAPizEB3SP5t3+1ZxvV6gi8weCwy4N3o=;
	b=mSwuoLOEldDkejofEGKD4atQfX5htAb9bkWqe5tqCupjntXWjUfxt4mAqKSXDLGZIeny
	 1LISm+kQUQM95kioIgKsVBYwdTm8lLTu6mVwsLQxXObLB0yhnh68pU8b7P2LpYOH1WhQu
	 C9S6uxLKO0OrbQwV2t6HQfPZEEkuVuBxiuzFn0QMTWa7C5C8oDfNLLfWTVQK7A8MQW7NW
	 7wIu8G/hmGR18Akz28z7HizjD4X+p1N2o4JQyAS23Rpl4iZGucP1trW8QqLgNLCnbTnoB
	 uH3LMCqphdMFRptwnhGBZxxMnIQpVeCff7+AKejDnrXqsCGuRnRct0XJRlK1IXSR56g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=SRbxBv+q;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1A606A31C;
	Mon, 16 Nov 2026 07:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=SRbxBv+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794815619; x=1795074819;
	bh=2F33A6bEP+OrAPizEB3SP5t3+1ZxvV6gi8weCwy4N3o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SRbxBv+qnzS1kkZy8F6psPNvhLJubA5zxiH7HxmBXrQufvd3qQBGesKwVlxpKUYTQ
	 DLK83IPReAHb5T9Au/ny3rzicA3/LxFYo2An9K8ZaAI18bcAqh/IUVbOFJrsRiA5hU
	 luSkeNpGgBFX43dxKcZVvVhcF3UBWpn/6ykHz3N/rOfnWsHyX4wR63rmSZXqsZ45HH
	 PgceWtQ9xbHMvEYpise3gfkV+DqhANMMV7HbQfbW79Ltd9tQwJ5IJNWr4vFH7gBowY
	 jG8mopUac/aDEo2iHVavNqSn+4Y+TJXwnynad2961U7hTgR880/kiiJApTGiGVZa4P
	 EbMGob+9U+dkQ==
Date: Mon, 16 Nov 2026 07:53:34 +0000
To: linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, Pontus Fuchs <pontus.fuchs@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Jeff Johnson <jjohnson@kernel.org>, Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org
Subject: [PATCH 3/3] wifi: ar5523: don't leave a stale reply buffer behind in ar5523_cmd()
Message-ID: <20261116075305.234240-4-alex@becholey.ch>
In-Reply-To: <20261116075305.234240-1-alex@becholey.ch>
References: <20261116075305.234240-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 586e1d5bc4976e3e42fe7af22bbd370381dd1771
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ar5523_cmd() stores the caller's reply buffer in ar->tx_cmd.odata and
clears it only when the command times out. Every other exit leaves the
pointer set after the caller has returned: usb_submit_urb() failure,
a command TX URB that completes with an error (ar5523_cmd_tx_cb() sets
cmd->res and completes, e.g. -EPIPE when the device halts the command
endpoint), and reply errors such as -EOVERFLOW from
ar5523_read_reply().

The command RX URB keeps running after such a failure, and
ar5523_cmd_rx_cb() copies the payload of any WDCMSG_TARGET_START
message, or of any read reply, through cmd->odata as long as it is not
NULL. ar5523_start() passes the address of an on-stack variable for
WDCMSG_TARGET_START, and when ar5523_start() fails mac80211 does not
call ->stop(), so no further command replaces the pointer. A USB device
that fails that one command can then write 4 bytes of its choice into
the stack of the task that tried to bring the interface up, at any later
time and as often as it likes. With KASAN, after that task has exited:

  BUG: KASAN: vmalloc-out-of-bounds in ar5523_cmd_rx_cb+0x2b4/0x980
  Write of size 4 at addr ffff80008c597480 by task swapper/1/0
  Call trace:
   ...
   __asan_memcpy+0x54/0xa0
   ar5523_cmd_rx_cb+0x2b4/0x980
   __usb_hcd_giveback_urb+0x350/0x64c
   usb_hcd_giveback_urb+0x3c8/0x4a4
   dummy_timer+0xdd8/0x2d5c
   ...

Clear cmd->odata on every exit of ar5523_cmd(), not only on timeout.
The callback tests the pointer and then writes through it from URB
completion context, so clearing it alone could still race with a reply
that arrives just as the command finishes. Protect the pointer with a
spinlock that the callback holds across the test and the copy.

Commit b6702a942a06 ("wifi: ar5523: Fix use-after-free on ar5523_cmd()
timed out") fixed the timeout exit only.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: b7d572e1871d ("ar5523: Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an AR5523 device emulated with raw-gadget behind dummy_hcd
(arm64, QEMU virt), also on QEMU's xHCI. The device completes the probe
handshake, so wlan0 appears. A short-lived process brings the interface
up; the device accepts the setup commands, then halts its command OUT
endpoint, so WDCMSG_TARGET_START fails with -EPIPE and the interface
does not come up. After that process has exited, the device sends a
36-byte WDCMSG_TARGET_START message, which is copied into the freed
stack. A variant without the STALL answers TARGET_START with a
default-path reply whose length word is 8 ("olen too small", -EOVERFLOW)
and gives the same report. Bringing the interface up is the only local
action needed. Without the failed command, or without the late message,
nothing happens. The reproducer is available to maintainers on
request.

Decoded trace, v7.4-rc2-141-g9d66f26fefac (arm64, QEMU virt,
dummy_hcd):

  BUG: KASAN: vmalloc-out-of-bounds in ar5523_cmd_rx_cb (drivers/net/wirele=
ss/ath/ar5523/ar5523.c:160 (discriminator 27))
  Write of size 4 at addr ffff80008c597480 by task swapper/1/0
  Call trace:
   __asan_memcpy (mm/kasan/shadow.c:106 (discriminator 1))
   ar5523_cmd_rx_cb (drivers/net/wireless/ath/ar5523/ar5523.c:160 (discrimi=
nator 27))
   __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
   usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
   dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:2051 (discriminator 1))
   __hrtimer_run_queues (kernel/time/hrtimer.c:2079 kernel/time/hrtimer.c:2=
136)
   ...
  The buggy address belongs to a vmalloc virtual mapping

Without the patch: v7.3.1 5/5 on dummy_hcd and 2/2 on xHCI, the
-EOVERFLOW variant 3/3 (1 on xHCI); 9d66f26fefac 4/4 (1 on xHCI) and
the -EOVERFLOW variant 1/1. ar5523.c is identical in v7.3.1 and
9d66f26fefac.

This patch is written on top of 2/3 (the only nearby code is the else
branch 2/3 adds after the wait). Testing of the whole series is in the
notes of 2/3: no report in 64 boots on v7.3.1 and 9d66f26fefac. After
this patch a late WDCMSG_TARGET_START message takes the existing
"Unexpected WDCMSG_TARGET_START reply" branch, which returns without
resubmitting the command RX URB, so the driver gets no further command
replies until it is re-probed. That is pre-existing behaviour for that
branch and not changed here.

Thanks,
Alexandre Becholey

 drivers/net/wireless/ath/ar5523/ar5523.c | 27 +++++++++++++++++++++---
 drivers/net/wireless/ath/ar5523/ar5523.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireles=
s/ath/ar5523/ar5523.c
index 51d8d998b07d..9569bd3bc090 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -48,6 +48,7 @@ static void ar5523_data_tx_pkt_put(struct ar5523 *ar);
 static void ar5523_read_reply(struct ar5523 *ar, struct ar5523_cmd_hdr *hd=
r,
 =09=09=09      struct ar5523_tx_cmd *cmd)
 {
+=09unsigned long flags;
 =09int dlen, olen;
 =09__be32 *rp;
=20
@@ -75,6 +76,7 @@ static void ar5523_read_reply(struct ar5523 *ar, struct a=
r5523_cmd_hdr *hdr,
 =09} else
 =09=09olen =3D 0;
=20
+=09spin_lock_irqsave(&cmd->lock, flags);
 =09if (cmd->odata) {
 =09=09if (cmd->olen < olen) {
 =09=09=09ar5523_err(ar, "olen too small %d < %d\n",
@@ -87,6 +89,7 @@ static void ar5523_read_reply(struct ar5523 *ar, struct a=
r5523_cmd_hdr *hdr,
 =09=09=09cmd->res =3D 0;
 =09=09}
 =09}
+=09spin_unlock_irqrestore(&cmd->lock, flags);
=20
 out:
 =09complete(&cmd->done);
@@ -97,6 +100,7 @@ static void ar5523_cmd_rx_cb(struct urb *urb)
 =09struct ar5523 *ar =3D urb->context;
 =09struct ar5523_tx_cmd *cmd =3D &ar->tx_cmd;
 =09struct ar5523_cmd_hdr *hdr =3D ar->rx_cmd_buf;
+=09unsigned long flags;
 =09int dlen;
 =09u32 code, hdrlen;
=20
@@ -156,12 +160,15 @@ static void ar5523_cmd_rx_cb(struct urb *urb)
 =09=09=09ar5523_err(ar, "Invalid reply to WDCMSG_TARGET_START");
 =09=09=09return;
 =09=09}
+=09=09spin_lock_irqsave(&cmd->lock, flags);
 =09=09if (!cmd->odata) {
+=09=09=09spin_unlock_irqrestore(&cmd->lock, flags);
 =09=09=09ar5523_err(ar, "Unexpected WDCMSG_TARGET_START reply");
 =09=09=09return;
 =09=09}
 =09=09memcpy(cmd->odata, hdr + 1, sizeof(u32));
 =09=09cmd->olen =3D sizeof(u32);
+=09=09spin_unlock_irqrestore(&cmd->lock, flags);
 =09=09cmd->res =3D 0;
 =09=09complete(&cmd->done);
 =09=09break;
@@ -254,6 +261,7 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, cons=
t void *idata,
 {
 =09struct ar5523_cmd_hdr *hdr;
 =09struct ar5523_tx_cmd *cmd =3D &ar->tx_cmd;
+=09unsigned long irqflags;
 =09int xferlen, error;
=20
 =09/* always bulk-out a multiple of 4 bytes */
@@ -270,8 +278,10 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, con=
st void *idata,
 =09if (ilen)
 =09=09memcpy(hdr + 1, idata, ilen);
=20
+=09spin_lock_irqsave(&cmd->lock, irqflags);
 =09cmd->odata =3D odata;
 =09cmd->olen =3D olen;
+=09spin_unlock_irqrestore(&cmd->lock, irqflags);
 =09cmd->flags =3D flags;
=20
 =09ar5523_dbg(ar, "do cmd %02x\n", code);
@@ -287,12 +297,11 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, co=
nst void *idata,
 =09if (error) {
 =09=09ar5523_err(ar, "could not send command 0x%x, error=3D%d\n",
 =09=09=09   code, error);
-=09=09return error;
+=09=09goto out;
 =09}
=20
 =09if (!wait_for_completion_timeout(&cmd->done, 2 * HZ)) {
 =09=09ar5523_cancel_tx_cmd(ar);
-=09=09cmd->odata =3D NULL;
 =09=09ar5523_err(ar, "timeout waiting for command %02x reply\n",
 =09=09=09   code);
 =09=09cmd->res =3D -ETIMEDOUT;
@@ -305,7 +314,18 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, con=
st void *idata,
 =09=09 */
 =09=09ar5523_cancel_tx_cmd(ar);
 =09}
-=09return cmd->res;
+=09error =3D cmd->res;
+
+out:
+=09/*
+=09 * The caller's output buffer is often on its stack. Make sure a
+=09 * late or unsolicited reply from the device can no longer write
+=09 * to it once we return, whatever the outcome of the command.
+=09 */
+=09spin_lock_irqsave(&cmd->lock, irqflags);
+=09cmd->odata =3D NULL;
+=09spin_unlock_irqrestore(&cmd->lock, irqflags);
+=09return error;
 }
=20
 static int ar5523_cmd_write(struct ar5523 *ar, u32 code, const void *data,
@@ -969,6 +989,7 @@ static int ar5523_alloc_tx_cmd(struct ar5523 *ar)
=20
 =09cmd->ar =3D ar;
 =09init_completion(&cmd->done);
+=09spin_lock_init(&cmd->lock);
=20
 =09cmd->urb_tx =3D usb_alloc_urb(0, GFP_KERNEL);
 =09if (!cmd->urb_tx)
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.h b/drivers/net/wireles=
s/ath/ar5523/ar5523.h
index 9a322a65cdb5..9db606332acd 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.h
+++ b/drivers/net/wireless/ath/ar5523/ar5523.h
@@ -61,6 +61,7 @@ struct ar5523_tx_cmd {
 =09struct ar5523=09=09*ar;
 =09struct urb=09=09*urb_tx;
 =09void=09=09=09*buf_tx;
+=09spinlock_t=09=09lock;=09=09/* protects odata and olen */
 =09void=09=09=09*odata;
 =09int=09=09=09olen;
 =09int=09=09=09flags;
--=20
2.53.0

