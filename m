Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815614;
	b=V/uL2VErEzouGG3f7oZF9b1g0kiAiX/0fp02Cf5S4qomcd+3dxMWmrBiAGrRVWUpDV3G
	 WXTVfU8ui98bvu2ZwcRNVX2YXLqmFTDG5u5/RmVaZsyqCIRkmCWIemLCZ8/yeaXOGMqWh
	 1AoTBta2UpUSSxY9cpXam+npGTf7cxlzcXGKggNfRIpSJZ4F37nLprVF5U5nMUWatMOEt
	 F7dEAkMHcm7h8rwKVUrbnoQtv6EZKKMibG3Ca99o8uU6b8TAjT+vD5VSBrYylRpfymCR2
	 wFSSkk3uAnEtbRyQ5gC57emKtWqlai2edozSndhf0oNUWNrNKIN3w2B9Q/8uMYwCDsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815614;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9fbpbM7X1AxckMj2yliqRgM1IH/47mdKqKlhhj5YoQE=;
	b=rIHYJOeBPpT3tSZlbloyFGnAm+5LRjuD99jX2eFk+sY7GCMR83jzIiCzgNthm4MtZqxP
	 9EJDyo+87zNorqqpDRDXdXJOJjpjKbMj6GCDscBoL7J3D2y9q2D3c1c374OOvLPmcgY/d
	 Lx4JGf70ptZxbyeIUVAV69RMvwc8AUVoJtvPgQHQeZQCFo7lJZorfMMnsGez09EUgkt8r
	 R6dXqH0ClMMx5RGCxzm5LjaO9fOSeA1Jr+BjGp3miF0ryobvfGaDaVXyd/3uM1DwEQhSt
	 W2yb1nxvcUDj2JnvmPsr+RIy7M8/d58LGc7kPj0kMeOd6DbrhjaXVDX5Ry4HUaHgfEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=vS+yN+xh;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FFE606A32F;
	Mon, 16 Nov 2026 07:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FFE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=vS+yN+xh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794815612; x=1795074812;
	bh=9fbpbM7X1AxckMj2yliqRgM1IH/47mdKqKlhhj5YoQE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vS+yN+xh45FjP4Vf+s2cVQ3STeSN5yBi/MncLYIQjuaTJxn4uxmzbMQJujW4u8um6
	 CTdrkeJLIbz7wdUNNZjq541rObOsJgtRR/HnxIzfjMMHpDLyX4uQbOb3uKG1fh4yGF
	 3XlNaYlsU9+Cqq1975CH8bMqnCX/vnF0F941Zi/1+Z0zphgY6cjgxcMd2Nsfuq2YTh
	 LAcnMQglHlf8IX/RXZYQkVPp5ckMSE3gzhburvqlmAC5D1v0gNO8TDUSTnSiMsoTXf
	 yjkAmVN5vPq7JTgZGFvtXWVdH0ISpzTKnqCZGbQhWNzAsjouXT4ZC5ziaQziognGrS
	 8TDJcpfR51i4w==
Date: Mon, 16 Nov 2026 07:53:29 +0000
To: linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, Pontus Fuchs <pontus.fuchs@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Jeff Johnson <jjohnson@kernel.org>, Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org
Subject: [PATCH 2/3] wifi: ar5523: don't leave the command TX URB in flight
Message-ID: <20261116075305.234240-3-alex@becholey.ch>
In-Reply-To: <20261116075305.234240-1-alex@becholey.ch>
References: <20261116075305.234240-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 018af73108730a781325bb175fc8c6082a502762
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

ar5523_cmd() submits the command URB and waits on cmd->done. For a
read command, cmd->done is completed by the reply from the device
(ar5523_read_reply() and the WDCMSG_DEVICE_AVAIL/WDCMSG_TARGET_START
cases of ar5523_cmd_rx_cb()), not by the TX URB. Nothing checks that
the TX URB has finished, and the completion is never reinitialized, so
a surplus complete() is consumed by the next command.

A device that does not take the command on its bulk OUT endpoint but
sends a reply anyway therefore makes ar5523_cmd() return with
cmd->urb_tx still queued. If the reply fails the command, for example
with "olen too small" (-EOVERFLOW), ar5523_probe() unwinds and
ar5523_free_tx_cmd() frees the command buffer and the URB, then
ieee80211_free_hw() frees struct ar5523, which holds the URB context.
When the URB completes later (the device takes the command, or is
unplugged), the host controller reads the freed buffer:

  BUG: KASAN: slab-use-after-free in dummy_timer+0x154c/0x2d5c
  Read of size 36 at addr ffff000012a04800 by task swapper/0/0
  ...
  Freed by task 12:
   ...
   usb_free_coherent+0x70/0x90
   ar5523_probe+0xa88/0x2c78

and ar5523_cmd_tx_cb() then uses the freed struct ar5523 (with
init_on_free=3D1 this oopses at ar5523_cmd_tx_cb+0x150/0x294).

With an interface that is up, one unsolicited reply while no command
is pending leaves cmd->done completed. The next write command returns
before its URB has completed and the command after it resubmits the
active URB ("URB ... submitted while active" WARNING in
usb_submit_urb()); the driver then stays one completion ahead.

Commit b6702a942a06 ("wifi: ar5523: Fix use-after-free on ar5523_cmd()
timed out") fixed this use-after-free for the timeout case only.

Reinitialize cmd->done before submitting a command, and kill the TX
URB also when the wait ended with a completion. usb_kill_urb() returns
at once if the URB has already been given back, so the normal command
flow is unchanged.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: b7d572e1871d ("ar5523: Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an AR5523 device emulated with raw-gadget behind dummy_hcd
(arm64, QEMU virt), also on QEMU's xHCI. At plug-in the device answers
WDCMSG_HOST_AVAILABLE, then NAKs the next command (TARGET_GET_STATUS
with a 4-byte reply buffer) on bulk OUT while sending a 44-byte reply
with length word 8 ("olen too small 4 < 8"). Probe fails with -EOVERFLOW
while the command URB is still queued; about 6 s later the device
accepts the stale command or is unplugged. No local action is needed.
With the command accepted first and the same reply sent afterwards,
probe fails the same way and nothing else happens. The reproducer is
available to maintainers on request.

Decoded trace, v7.4-rc2-141-g9d66f26fefac (arm64, QEMU virt,
dummy_hcd):

  BUG: KASAN: slab-use-after-free in dummy_timer (drivers/usb/gadget/udc/du=
mmy_hcd.c:1413 (discriminator 27) drivers/usb/gadget/udc/dummy_hcd.c:1514 (=
discriminator 27) drivers/usb/gadget/udc/dummy_hcd.c:2035 (discriminator 27=
))
  Read of size 36 at addr ffff000012a04800 by task swapper/0/0
  Call trace:
   __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
   dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:1413 (discriminator 27) =
drivers/usb/gadget/udc/dummy_hcd.c:1514 (discriminator 27) drivers/usb/gadg=
et/udc/dummy_hcd.c:2035 (discriminator 27))
   __hrtimer_run_queues (kernel/time/hrtimer.c:2079 kernel/time/hrtimer.c:2=
136)
   ...
  Allocated by task 12:
   __kmalloc_noprof (include/linux/kasan.h:263 mm/slub.c:5531 mm/slub.c:555=
6)
   hcd_buffer_alloc (include/linux/slab.h:995 drivers/usb/core/buffer.c:134=
)
   usb_alloc_coherent (drivers/usb/core/usb.c:1011)
   ar5523_probe (drivers/net/wireless/ath/ar5523/ar5523.c:962 drivers/net/w=
ireless/ath/ar5523/ar5523.c:1666)
   usb_probe_interface (drivers/usb/core/driver.c:399)
   ...
  Freed by task 12:
   kfree (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c=
:6923)
   hcd_buffer_free (drivers/usb/core/buffer.c:163)
   usb_free_coherent (drivers/usb/core/usb.c:1033)
   ar5523_probe (drivers/net/wireless/ath/ar5523/ar5523.c:947 drivers/net/w=
ireless/ath/ar5523/ar5523.c:1737)
   ...

On QEMU's xHCI the controller buffer is not tracked by KASAN, and the
report comes from the completion handler itself, on v7.3.1:
"BUG: KASAN: use-after-free in ar5523_cmd_tx_cb+0x1dc/0x294", a 4-byte
read of cmd->flags from the freed struct ar5523; with init_on_free=3D1
the same path reads cmd->ar as NULL and oopses (dummy_hcd on v7.3.1
and 9d66f26fefac, xHCI on 9d66f26fefac). ar5523.c is identical in v7.3.1
and 9d66f26fefac.

Without the patch: v7.3.1 5/5 on dummy_hcd, 2/2 with init_on_free,
2 of 3 on xHCI; 9d66f26fefac 4/4 (1 on xHCI). The stray-reply case
("URB submitted while active" from ar5523_cmd()) also hit in 3 of 3
boots on v7.3.1 (an unsolicited reply after the interface is up, a
duplicated read reply, a reply to a write command).

Testing: this series (1/3 to 3/3) applied on v7.3.1 and on
9d66f26fefac, KASAN, UBSAN, lockdep, emulated device: without the
series 8 of 8 trigger boots for the bugs fixed by 2/3 and 3/3 gave a
report;
with it there was no report in 64 boots (v7.3.1 46, 9d66f26fefac 18;
10 on xHCI), and a well-behaved device still enumerates and brings the
interface up. Probe still fails for the bad device above, now with
-ENOENT instead of -EOVERFLOW: killing the queued URB runs
ar5523_cmd_tx_cb() with -ENOENT, which logs "Failed to TX command.
Status =3D -2" and overwrites cmd->res. Only a misbehaving device gets
there; reading cmd->res before the kill would keep the reply's error
if you prefer that.

Thanks,
Alexandre Becholey

 drivers/net/wireless/ath/ar5523/ar5523.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireles=
s/ath/ar5523/ar5523.c
index 734f0561cf73..51d8d998b07d 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -280,6 +280,9 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, cons=
t void *idata,
 =09=09=09  cmd->buf_tx, xferlen, ar5523_cmd_tx_cb, cmd);
 =09cmd->urb_tx->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
=20
+=09/* drop completions left over from earlier commands or stray replies */
+=09reinit_completion(&cmd->done);
+
 =09error =3D usb_submit_urb(cmd->urb_tx, GFP_KERNEL);
 =09if (error) {
 =09=09ar5523_err(ar, "could not send command 0x%x, error=3D%d\n",
@@ -293,6 +296,14 @@ static int ar5523_cmd(struct ar5523 *ar, u32 code, con=
st void *idata,
 =09=09ar5523_err(ar, "timeout waiting for command %02x reply\n",
 =09=09=09   code);
 =09=09cmd->res =3D -ETIMEDOUT;
+=09} else {
+=09=09/*
+=09=09 * A reply from the device ends the wait even if the device
+=09=09 * has not taken the command yet. Make sure the TX URB is not
+=09=09 * left in flight: it must not be resubmitted by the next
+=09=09 * command or freed while it is still active.
+=09=09 */
+=09=09ar5523_cancel_tx_cmd(ar);
 =09}
 =09return cmd->res;
 }
--=20
2.53.0

