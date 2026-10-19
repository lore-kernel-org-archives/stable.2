Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422958;
	b=2hG6nIWtb4kUh3lrkp3icqfChJo2cSvr4uEwuBqtIDDRfhnBKek2m0/G2/M8qwe04MhR
	 NOWpCVsNJ9KOII/3qZa6lr/n3rq8R3iKzJVFUgM/OjMl4sjgxrTl1dPalmfjyfxxGA1ty
	 T2rldwKZ2oHNllX+G8I0coqGUvtZebE7wkoyUWyz27AlB/6MTDLjoBH6kPnbjVb9uqXqk
	 9COr0nvaU2hl4Eayz8FBy0UNZzNAFSASe3Zp5HIJck9a+3QqZEgoSr1KCAygOKoyeNCMu
	 C/85fwbH/ppZa/y3dZeQBQzIgzblyDTKxbWYZF51sSEGz+HZsxOyUcrEn9igxELKUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2RZlDIC+aSZp6ZEEkfEcnm1WZOr/jDMCERLnAaOMTJY=;
	b=P98D4thk3IrpMUZRq2GpTLcC42FZxLzRg0mL5citL60qctHAI/vuqz6dcwV5obtS+MAX
	 CEwnRFeXdIVW1P8gK37pdSTR3yqOZ6B8JZ17I/g3y1rDfsXuXbgeBJuEdgmdn8oaWbRNN
	 lvXhkZtCCtELB3PgM8Syr3vXV+amEqbViLi67KQqNxguzJ4UHX8QdmbpOw4S7YsXjPczg
	 dJYFTkrmqA2mU9f4FPfSOPF15duW9+2ZGWdkOhS1g0SzJRnI3jZA58G2YYaXeIWlQtqMk
	 lInxiRiHzSw4O1PA1duaOYV9g555yUHXPNyBPYZIZkcxUcAWd4BwkojkLDmojkm8i4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pqshield.com;
	spf=pass smtp.mailfrom=pqshield.com;
	dkim=pass header.d=pqshield.com header.i=@pqshield.com header.a=rsa-sha256 header.s=google header.b=m+33W1RO;
	arc=none smtp.remote-ip=74.125.225.132
Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97925609F0C8
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97925609F0C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pqshield.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqshield.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pqshield.com header.i=@pqshield.com header.a=rsa-sha256 header.s=google header.b=m+33W1RO
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4a1ee98e9abso1204225e9.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqshield.com; s=google; t=1792422956; x=1793027756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2RZlDIC+aSZp6ZEEkfEcnm1WZOr/jDMCERLnAaOMTJY=;
        b=m+33W1ROqaFFvnsFtChESXj7bgxwEM75XdPoa3KtQNuuqY2KKkDB0gM4jcGeM5KzUl
         4b3KH3ZQaaLsHYvVTzJQ7E8xPxTXGXjBHQPoZWrzN7TxkQUoVGKWqPRZl6Peo5sgNANC
         Sp6YcW9m+x0vFQzLQ6RG5Ttqd5SiBIKCLVyyQuaMMN7hyDksOkjpTO1po0ra3pdpydJA
         bYtilFYdZbrIMX7LnEMf2oahltTQiZ4NS8b9GjYCUPHLvsi2MN+8tHo1IO5c3Ntl2L/J
         fhyRlt7dWr8WQpFvFkK6CdpkT59GBTLy/CWr5+GEY2JYmmw5oo53+XTXWMsBNcM7/cdL
         yCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422956; x=1793027756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2RZlDIC+aSZp6ZEEkfEcnm1WZOr/jDMCERLnAaOMTJY=;
        b=uMEcbGGzxKhgtXvrAwsCoi8W/ewPHUc7vXtERk/iPe+toDjkkvkiUG6tQZxZsuGU85
         1ax/NFTUWdUdw0WQKhMXGH93CERUlBTHjoHlFCOKtcZmG37UsdBMVo22pRIvFWAJnRkM
         GKdM3r/M+TyA7mqYFcR8O00PHniVxvRohIqhhA2cFALXw6wF9r6/nKjRvENbYWqiay8R
         QvhzKbtsC6OT5nvL3yFgwMPsDIwxq7U/b3UlsnbBFX9aw5vC4kQrI6Zgzm4AfLRM+kpo
         Zg8tP8V0sRmbIc2d1MCjyXiq1lsG7axsO1ZFQ4WyhEWw2Q87GFnFDrR3N3KdNapj0X1n
         BAYQ==
X-Forwarded-Encrypted: i=1; AKwUvBylm2ayCWX7ReCQKbzZk79v4mweCouAkxpJo5Fmou5+DONnWQ0ZgwDB04jmaywUu3LCobHnQM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3ZG3pWw3b9MY7t29BYDviOLBHcf4o+Bt9l1FJVbdcGSdDkO2Y
	z7WdZMHq4RECKVwUYzoNN9bxV0+fKU53jOhOnPfjbLe41V62ybMgFT9XZpakCxak3AU=
X-Gm-Gg: AYBFou2KKi6zEjxqGrbP8ywg472Gn60qtYuDNgU9qzjSli4Jr/laXN3W0tw6E/Ocj12
	9E9iQYR0jhKy6yp/6W76L5FAHtClPSLiPEqorf3akNh+bM7P2KgiLfKprV52n55+wUNndYUJcMu
	z9Yn/BZ6LKLSaNOyxCKDiWJckYELc1WXz2hH3P3ytBGF489tX6rbngP7xZkQcJ82H9r4nFB+gGC
	AtIPL00vLQn48Wa4ZcpQ0Ypg7bxHTflTuzS8qEX0BQKmCAAFpEO+gjwbGNI9X2rCBehAXhvhGZ5
	kyIFW+zfsaLUWyW4+LdS1e2q8r85AxpVX9xhRRAaJpDZjPY+tSVeJPyxf5uBkNrE1H4SawzDtk9
	QqF1NLFWlihQHczzEdUJUUwdbadbidn8JapUIHQuLpFgoSyaoF7eWfeZ1VB9oZXT2DMSfsZR2nJ
	H4OSeWcHu3mSIGnT2f95ZF2BtWpNK08jtvIDQOTK0Rhj+FP4OEwEH56q/OsubfhL1pfREqeFc1A
	LymxiLR6j4cg9ucXXsLB+FsNZSbq7vM2NoAPktLC3uJF/Gmn6PQdJrrPWa2nZ8KFVwN86dxDFMG
	HqaFq2P2
X-Received: by 2002:a05:600d:4447:10b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4a1d75fe19bmr123792525e9.5.1792422955492;
        Mon, 19 Oct 2026 08:15:55 -0700 (PDT)
Received: from lucas-pascal-pqshield.. (2a02-8440-5609-5d9a-864f-9c6d-db81-5e2e.rev.sfr.net. [2a02:8440:5609:5d9a:864f:9c6d:db81:5e2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e9423f20sm71083715e9.7.2026.10.19.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:15:55 -0700 (PDT)
From: Lucas Pascal <lucas.pascal@pqshield.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Lucas Pascal <lucas.pascal@pqshield.com>,
	stable@vger.kernel.org
Subject: [PATCH] usbip: vhci_hcd: store seqnums as u32 to fix lost unlinks after 2^31
Date: Mon, 19 Oct 2026 17:15:37 +0200
Message-ID: <20261019151537.112304-1-lucas.pascal@pqshield.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhci_hcd numbers every CMD_SUBMIT and CMD_UNLINK from a per-HCD atomic_t
counter, and keeps the value in unsigned long fields of struct vhci_priv
and struct vhci_unlink. On the wire, the seqnum is a __u32, and the peer
echoes it back as such.

Once the counter passes INT_MAX, atomic_inc_return() returns a negative
int, which is sign-extended when stored in an unsigned long on 64-bit.
Commit 15b93f340fa6 ("usbip: Fix seqnum sign extension issue in
vhci_tx_urb") fixed this for submitted URBs with a (u32) cast, but
vhci_urb_dequeue() still stores the unlink seqnum without one. The
CMD_UNLINK goes out with the correct, truncated 32-bit value, but when
the RET_UNLINK comes back, dequeue_pending_unlink() compares the
sign-extended value with the 32-bit one and never finds it:

  vhci_hcd: unlink->seqnum 18446744071562096407
  vhci_hcd: cannot find the pending unlink 2147512087

The unlinked URB is then never given back. A task waiting for it in
usb_kill_urb() blocks forever, typically with the device lock held by
usbdev_do_ioctl(), and everything else touching that device (open,
ioctl, driver binding, rmmod, reboot) piles up behind it in D state.
Only a forced reboot recovers. On a machine importing a few FTDI-based
JTAG adapters through a local usbip loopback, the counter crossed 2^31
after about 30 days of uptime:

  INFO: task fpServer:2209312 blocked for more than 122 seconds.
  Call Trace:
   usb_kill_urb
   usbdev_do_ioctl
   usbdev_ioctl

The wire protocol uses 32-bit seqnums, so store them as u32 as well.
The counter then wraps around modulo 2^32 consistently on both the
submit and the unlink paths, instead of relying on a cast at each
assignment. Adjust the format specifiers that printed these fields
with %lu.

Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Lucas Pascal <lucas.pascal@pqshield.com>
---
Hi,

A bit of context on this fix:

- We heavily use USB/IP on CI/CD runners, in order to have full
  control/isolation for multiple USB development boards plugged into
  a powered hub. So USB/IP host and client are on the same machine.
  Once configured, a runner host stays up ad vitam.
- I found the bug while debugging a runner host lockup on Ubuntu
  7.0.0-31-generic, with an uptime > 1month. The log lines above are from
  that machine.
- The diagnosis, this patch and its changelog were prepared with the
  help of an AI coding assistant (Claude Opus 5.5), then reviewed by me.
- Build-tested on x86_64 and i386 with CONFIG_USBIP_DEBUG=y: no new
  warnings (W=1 reports a pre-existing -Wformat-truncation in
  vhci_sysfs.c, unrelated).
- checkpatch.pl --strict: clean.
- The patch was tested in QEMU (virtme-ng), not on the physical runner,
  using dummy_hcd + g_zero in loopback mode (bulk IN read only complete
  when unlinked), exported through a USB/IP loopback (bind + attach to
  localhost), running usbtest test 11 (unlink reads, 3000 iterations), with
  a test-only change starting vhci_hcd->seqnum at INT_MAX - 2000.
  Without this patch: the first unlink past 2^31 is lost
  ("unlink->seqnum 18446744071562067969", "cannot find the pending
  unlink 2147483649"), and testusb hangs in D state.
  With this patch: 5007 unlinks past 2^31, none lost, testusb passes.
- The explicit (u32) cast added by 15b93f340fa6 in vhci_tx_urb() is now
  redundant. I left it alone to keep this fix minimal.

Thanks,
Lucas


 drivers/usb/usbip/vhci.h    | 6 +++---
 drivers/usb/usbip/vhci_rx.c | 4 ++--
 drivers/usb/usbip/vhci_tx.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 5659dce1526e..64c824c7d165 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -50,7 +50,7 @@ struct vhci_device {

 /* urb->hcpriv, use container_of() */
 struct vhci_priv {
-	unsigned long seqnum;
+	u32 seqnum;
 	struct list_head list;

 	struct vhci_device *vdev;
@@ -59,12 +59,12 @@ struct vhci_priv {

 struct vhci_unlink {
 	/* seqnum of this request */
-	unsigned long seqnum;
+	u32 seqnum;

 	struct list_head list;

 	/* seqnum of the unlink target */
-	unsigned long unlink_seqnum;
+	u32 unlink_seqnum;
 };

 enum hub_speed {
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a678e7c89837..c8a27778478d 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -118,9 +118,9 @@ static struct vhci_unlink *dequeue_pending_unlink(struct vhci_device *vdev,
 	spin_lock_irqsave(&vdev->priv_lock, flags);

 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_rx, list) {
-		pr_info("unlink->seqnum %lu\n", unlink->seqnum);
+		pr_info("unlink->seqnum %u\n", unlink->seqnum);
 		if (unlink->seqnum == pdu->base.seqnum) {
-			usbip_dbg_vhci_rx("found pending unlink, %lu\n",
+			usbip_dbg_vhci_rx("found pending unlink, %u\n",
 					  unlink->seqnum);
 			list_del(&unlink->list);

diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 32e6fabccf72..4b602849c14b 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -74,7 +74,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));

-		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %u\n",
 				  priv->seqnum);

 		if (urb->num_sgs && usb_pipeout(urb->pipe))
@@ -201,7 +201,7 @@ static int vhci_send_cmd_unlink(struct vhci_device *vdev)
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));

-		usbip_dbg_vhci_tx("setup cmd unlink, %lu\n", unlink->seqnum);
+		usbip_dbg_vhci_tx("setup cmd unlink, %u\n", unlink->seqnum);

 		/* 1. setup usbip_header */
 		pdu_header.base.command = USBIP_CMD_UNLINK;
--
2.43.0
