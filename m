Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795398519;
	b=SdBl+2GJoza6Hb9ir6cjW7ZnVKYpWLEe63cgPhwQ1CbX3Qxdnpfv+vu0EI51WaJGk7KG
	 2VYXt2AG3T/5+mpN75YrGdCkEHUXp/RWeJaew5HpXgu3OT9gg7qBRTAsVTi90i1JUjdFA
	 RRmbuRb3jNnyjssVw27enxmE/+Qfx7Sld22VodmnqybQvqJ7Zwpa0HANzDQC2415MLMRv
	 xEJNu4udr9SsjZIvL2gyGcVbgiEM3RWLnfkQsWPYYbtaj+p/NNiVqDVoGX12pcYPnIStr
	 PH9yxS+uMAF8P1fk7dju5sR+0h5C1qIefOmyVKmWQXzSe1yEnIcRkglDQlSHcwtpn/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398519;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4rKVRTer4CzQgI1l1KpR0Wzk2mE34h2QJHTpemb+Dyg=;
	b=ntKQfjssiYG6n4TgwnZ6ldOJ+UoASh5pZ3ghQQ6q8PK0oSY4yRbuhgX/pcyucehFrd/h
	 ZoIn3VQ7rHTmr5U6Cg1MbpjRwkDwN1B/arydK+CDNMTJlKHjg12ENsb9ozQHGcjbK3qSW
	 r2BzIyE2The+fH6tiCGKm7N61Zz+FuyA0jTzLlYoU92xykGYyD9+H6092YfqRu0JrwxRU
	 pH25amx8y1yU/SS3HgcvtbZIc6QH7uECZ7yxxOCkddKbd+8s0FgbW6gqXNQ2y/OS6naS9
	 AyUxtAKsvLEzBstpLwi8n4luQY8l51XLLxecm9oCqsp5x9kO5yzFoJxsW/MbTTz4ILQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZA9mYOp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF105606A336;
	Mon, 23 Nov 2026 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZA9mYOp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795398518;
	b=jtwMCTCr6/LsTnJpXpi4Ker+PqJm72U2aTlbke6VRqJfZKP/S26Wel1iUEIx5b1vi7EK
	 G3QVJs5lUfHcus9HvXVJZh4iQdNmaROCwebSnchfEzjh6Lq4x6qC4dvaVEKV/N7wmLsl7
	 l9LEhrsoszHDKk7Ff1GvfM7TWZ1GjY/rixoCV8qqcHBEQJ7RLUm8QRD1BrA704s2B845N
	 +isqMT4d63caQEkwO9BGbbKlQtLvsJDtOozCf4l4GqQQ1e5i9oCYBCUem0D+U3T/VjHdm
	 V7gzd9+TjTChlAm4y6e3xp7F9PH7MIMOpvKbQPk64Dpa8QO4NisfaltdE3De3VN8JQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795398518;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4rKVRTer4CzQgI1l1KpR0Wzk2mE34h2QJHTpemb+Dyg=;
	b=2CiTE7bIH0d67NJuQStzBqg06SIhCoCwZnP6LxAaWOiRyVczegTjzZY2V/F4HYiX1rbU
	 V5vaf+tCa3qT46/bV5mq5AsYYC4SVLBRCJJDrughKhlRmN8jnqNO6PA0ldDF0pzilZ5pC
	 W3vBKgI1Aq6PuHlFqdyDhmXybMr5vSWJCUHngiCn0RQ7jp1m5GS1kloOlxx1OUV8/z3Nu
	 kHaTsNaM4VrUx3a0wYrKSJbQ2d51WyEjitWHwYniOGhJVvrfoQW8ysIhNxiTZOXCcI72v
	 w0dOAqCMPtYifinUowSj/Ot/ZKvrqQy4tmWmfvIFPdmMyqSG8vKitmexSqTrSpXZkkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 564101F000CA;
	Mon, 23 Nov 2026 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795398518;
	bh=4rKVRTer4CzQgI1l1KpR0Wzk2mE34h2QJHTpemb+Dyg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=dZA9mYOp2PmCbykXpfjX6qZj92LtI+QwUvfMDcmV+JVbmYkB7Duwh7ZYrvrd+lUDd
	 pVnmye4IK6oIuiUCE1axbkBsypCVH9PsSNGBh27K1p4UJg4FmpyqFL8gWcLEL0uue/
	 xfwy5jqKy/DaZdkwdHPhzid6m33ZkmunVPLg8yOxD0p/EekFeQKRow8ozZ0tjUs4BX
	 OaYYfl8b00FJ9Gze6nxXQtHZvpeTx+RFfOq8JO1Uj1a0m7L6/AZN3jIEKOy+bavwZu
	 1aSbxwd8l2GIK4oaGAvYAaHHVUv73fa6N1IM0GsayDOySSoozaL2wnDMvugVO36INC
	 UHtkWutLksRYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A70754C2D4;
	Mon, 23 Nov 2026 01:48:36 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] usb: gadget: u_serial: Fix the console request's
 lifetime
Date: Sun, 22 Nov 2026 22:48:33 -0300
Message-Id: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7RioUIor72FYlDJADbTaUqIh3
 F2KF3D5kv/+W8GT0+ThmqzgaNFeW7MDOyWgBml6Qt3uDCxlPK2YwIDRkCMqa7wdCVt6BQqEXVV
 WqRQkSsVh15+OOv0+ru/1j31oHqTm+BcXg/azdZ+jvWRx90dmyTDDJs9bLgpR8Au79ZPU41nZC
 ept275CCr2T0gAAAA==
X-Change-ID: 20260928-u-serial-console-dequeue-f9790a8e87c6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Brian Ellis <brianellis@gotenna.com>, Ai Chao <aichao@kylinos.cn>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795398515; l=2723;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=4q+OL2Pp+81T8mDCCbfHbx15AB8s01g5DGT7D/3BdSE=;
 b=msZnqF6tq8kwSylurEXtKl6dBjwXtBDRB9BO68BQjSqr0PCzORB3mu6AZ9R18YeiOL3ZzPxyq
 VAtp/jAVcCpCdSzHF9YiMlScurvF2GtTD3czj1PDdiZRinuS5F40l9N
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com

v2 is a rework rather than a revision of v1. The console does not
follow the gadget API's rule that a queued request belongs to the
controller until its completion runs: it reads req->length while the
request is queued, frees the request right after an asynchronous
usb_ep_dequeue(), and can free it while __gs_console_push() is still
queueing it. Patch 2 frees the request only once it is back, which
also ends the "request ... was not queued" message that v1 was about.
It relies on patch 1: the configfs console attribute sets and clears
port->console outside port_lock, which connect and disconnect use to
find the console.

---
Changes in v2:
- Rework, per Sashiko's review of v1 [1]: instead of skipping the
  dequeue of an idle request, free the request only once it is back.
  v1 kept the use-after-free, and could still dequeue a request after a
  failed queue.
- New patch 1, for a race the rework depends on.
- Link to v1: https://patch.msgid.link/20260928-u-serial-console-dequeue-v1-1-b44d68585632@gmail.com

Tested on a Motorola Moto X4 (XT1900-6, SDM630, dwc3) with linux-next's
u_serial.c plus this series, built in the sdm660-mainline 7.2.3 tree
with KASAN and the console on ttyGS0; linux-next itself was only
build-tested. The control was the same file without the series.
- A host bus reset during console output: a slab-use-after-free in
  dwc3_gadget_giveback() at each of 20 resets without the series, none
  with it.
- The console turned off through configfs with its request queued and
  the host not reading: the request is cancelled and freed by its
  completion, with no KASAN report, over 5 rounds. Without the series,
  KASAN caught dwc3 giving it back after it was freed, in each round.
- The configfs write racing a host reset, with a delay added inside
  gs_console_init() and gs_console_exit(): one connect per console,
  and no request left on a released console. Without patch 1, a second
  connect or a request on the released console in 6 of 10 rounds.
- With the console registered but not selected by console=: no "was
  not queued" over three suspends.

[1] https://sashiko.dev/#/patchset/20260928-u-serial-console-dequeue-v1-1-b44d68585632@gmail.com

---
Fabricio Akio (2):
      usb: gadget: u_serial: Publish the console only under port_lock
      usb: gadget: u_serial: Free the console request only once it is back

 drivers/usb/gadget/function/u_serial.c | 134 +++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 31 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260928-u-serial-console-dequeue-f9790a8e87c6

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


