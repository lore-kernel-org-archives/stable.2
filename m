Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393848CD49;
	Fri, 14 Aug 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730789; cv=pass; b=ntRu74fv255jH4jnlPnUHTVDyR9njPNeXcd4JDF1k0dMQ1a7dI4YlxNboxnPS4F6MrqlPqngRiARnyHI8hZZoxmh9QX868afENLyjn86jyesMv5FmwViHlXTXypmRckY8SSk9Ls90pHexG3RVALltFK2fI/HSqsTf+wiw6aIUF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730789; c=relaxed/simple;
	bh=9Wg2z10P/JPDhyMUiBaENmbShHgAaG0R4mqck9BVFso=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ApJ1kR90rRdGQPXQ1AXfI3K3vsch2l55bkESW2hzzkYeWGDh0WVeZHu+IpWOUo6DPXZv8zvQ+hP9T3ErfA+ToA+OgX/nfbLLz1ms7a0npkLxQXMh/GuZoN0y8Dg6Ibmnu0vak6RKvEtuLkJr69GjyM5+/oAFfh9as3+oR6ebcFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev; spf=pass smtp.mailfrom=ikuyo.dev; dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b=nKIRvKFb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b="nKIRvKFb"
ARC-Seal: i=1; a=rsa-sha256; t=1786730770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R8SEzLxhr8tlovf/vA7sCUknbJZ6cR+6eRgn8VR0+3rgf2Vmo1CBGjhohfSF0++cIbjDP85GjxikPpvqDrwFwuuLPEjZY+AJTPqPciabOXcM5SpKQYKtAHvG+qC53uFBrBrQkI4vhLKndwzCLK6KiCm3kAaI7MYCaE62cW01QVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786730770; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bj5r7TGrEOkal1s4P7Tooqa7GDq1ZOp7zfALtG6DHE=; 
	b=eqMaDNHzCQ3SaZHk5+na+K/JFP2o6+YNas34x12IkNQ9WBg3mh2UdSL7ssknhUoP6xIOgW8P+QWRM/Tublr9P43KjV5MK0HcPI7hIYswoqYQRc/WF4XqcuRLgFIU5A4js+Uy4XLP12nMh7jevJJwMlId0AzAGPDq6A+XFaAZhqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786730770;
	s=zmail; d=ikuyo.dev; i=eritque-arcus@ikuyo.dev;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=7bj5r7TGrEOkal1s4P7Tooqa7GDq1ZOp7zfALtG6DHE=;
	b=nKIRvKFbsC5eP2po/TiAR6pJqm6152/iu7S/QCVOyoWXI0FlABDCmgzaQBHwoltY
	v3xVLIV0xxP6uzRWkC5BR33Gk1xYKUCNB5SSHeMHIoyVeATefLo2zKdGqKnWMBlSu7j
	gb/V+DcT96gF9oQOPhpklt+8iY0P67XgPm606JL4=
Received: by mx.zohomail.com with SMTPS id 1786730768111139.22764151832507;
	Fri, 14 Aug 2026 11:06:08 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
Subject: [PATCH 0/2] can: fix two missed siblings of the kvaser_usb_leaf
 receive-walk fix
Date: Sat, 15 Aug 2026 02:05:45 +0800
Message-Id: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3aTgqFBX8V4WNsBlkM1XSEYw
 rtb9Phl8s9GhqwwulYbZSxq+kwF9amiMEoawBqLqXGNd13dcpDEsMjjJ2bhXlcYd17CGYL+4h2
 V8pXxG0p4u/9t82NCeB9XtO9ftdBhrHcAAAA=
X-Change-ID: 20260815-can-esd-hydra-fixes-86ac3eaef960
To: Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yiran Qiu <eritque-arcus@ikuyo.dev>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061;
 i=eritque-arcus@ikuyo.dev; h=from:subject:message-id;
 bh=9Wg2z10P/JPDhyMUiBaENmbShHgAaG0R4mqck9BVFso=;
 b=owGbwMvMwCW2M2qh3ooTh9cxnlZLYsiqj2RX/OaxSZvB1XnyIV37/b8CGuWWeb46s1sxT0vs4
 KqT++wvd5SyMIhxMciKKbJMN9ixmLPdmm2ZgUQozBxWJpAhDFycAjAR10uMDB0fn3svXZ58yEly
 moDYoz0ar42KVz+W0pp1YteO37MKymoZ/ifnzey9nFZ2qS903v/ctimNlxZtW7p9j/2paYabCz9
 EuzIBAA==
X-Developer-Key: i=eritque-arcus@ikuyo.dev; a=openpgp;
 fpr=9730B8A309873B06A6301855B95AA12EA8C8C3AE

Commit 0293dd153f9d ("can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd():
validate received command extents") fixed an unbounded variable-length
command walk in the kvaser_usb *leaf* receive paths. Two sibling USB-CAN
drivers have the same unbounded receive-buffer walk and were not touched by
that change:

  1. esd_usb: esd_usb_read_bulk_callback()'s only length check runs after the
     message has been dispatched and @pos advanced, so a short
     ESD_USB_CMD_CAN_RX header near the end of the buffer leads to an
     out-of-bounds read that is copied into a received CAN(-FD) skb
     (kernel-heap infoleak), and a zero-length message spins the URB
     completion softirq forever.

  2. kvaser_usb_hydra: kvaser_usb_hydra_read_bulk_callback() takes an
     extended command's length from the device with no lower bound, so a
     zero-length CMD_EXTENDED spins the URB completion softirq forever.

Both are reachable by a malicious or emulated USB CAN peripheral with no user
privileges (the driver auto-binds on probe), and both were reproduced with
USB_RAW_GADGET + dummy_hcd on a KASAN build; the per-patch changelogs carry
the splats. Only patch 1 (esd_usb) is memory-unsafe; patch 2 (hydra) is a
denial of service (soft lockup) only.

These were found by auditing the neighbourhood of 0293dd153f9d for the same
receive-walk shape and then reproducing each with a raw-gadget device. I can
send the gadget reproducers off-list on request.

Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
Yiran Qiu (2):
      can: esd_usb: validate received message length before use
      can: kvaser_usb_hydra: reject too-short commands in the receive path

 drivers/net/can/usb/esd_usb.c                     | 69 ++++++++++++++++++-----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  9 +++
 2 files changed, 64 insertions(+), 14 deletions(-)
---
base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
change-id: 20260815-can-esd-hydra-fixes-86ac3eaef960

Best regards,
--  
Yiran Qiu <eritque-arcus@ikuyo.dev>

