Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794429762;
	b=oJqHE/siarz680lmmHxsn0UhYzDYnniYALH6Rlh8TlPz59Lx8R8gpIkvHigFlW42tv5o
	 WIlymStgtLkq8tYybCCQgVPfa9j5A6HPiVMJ5jaGPCsU5JtGZfTlLcpzA+XuEuXOJ4lYn
	 yQOEryFDt9e+IBMNDsQ4F0jaOzUJ2QHJ0Bqs6E+GtnIh/cP3tJql67C/no/yGhI6AGDse
	 OFV7J23cXdx1TOFExwjrNLahMXnAZY83bytz7RdhiATTkwuRYLGV7BGoWkUhJNg1+6mxs
	 Qyj3CWG5l7U2jzjhTF6KWWrdkdpyl+HOAWjcVScGYO9wG5yrbvw3G6tKSdj0bzjmUlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429762;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GhK0bo2B6oCuaiQEsr2GTPPmISVOHS/nD1fMDLB8M2g=;
	b=K0YJNNozyFL8tZMI1iuXIGOmVCn+ezVTdLDsLSXvNIYAMX62sVp+2tRIq92UPWTYznl3
	 HPWIF47i0LYJV6EbpWL7abAH6zOZUOEVhdloQVDlRg9yxwFemUbZ8+pBNJFuVQ298zIR0
	 Wf2kNRymuzRAGJ2RY2mAf8nurm5gwuvMIFhBZmQUMJx7/au1TaVUPdtGs4l/U2Wb9Iyyu
	 GaRTwPwbHhWyZ4cUrboxNQ5wr2j3rjURwc7kRJNlCFeYIwbAi6qUDLTl+BV+Sjq2CeRZ0
	 n9FUC8CqbZweqah2ewMoKrKTVgvY/gsRIqpd/fW1i7qk6/1oi/3t7TESzgUl2JbU5qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n2/EMPMg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E6606A32D;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2/EMPMg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794429761;
	b=buokIFsHIY+w/k59CyNHw1FMv1hltg6CmD1ezoZXpLtwqBLASI3grE2awAdiL/jf/D8Q
	 p22RvNYd5lbE0rGfSM6u08edcdPaIbRn3wvWM73hoMzd0b1wHuOK9YSwpo45Y/FmHp740
	 y2Aa7NCTebqO23BdMYUQAbj1zhMvM6Xs0nvL6DFhUEqqeb1AAabLPARSwLfOvI2q0mFlC
	 K/nhP6mr2c+/SG/isVsgAdNEodzi8F4PBif4uspmd3DGVUKC2sPjLizDetpwN/enSm9cI
	 Fp8wfkl06nVIkrPR2faIGWTCjggbGv3b5HQWV4MYNQWBxCitt+wHE9bVWBPhl8E/cHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794429761;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GhK0bo2B6oCuaiQEsr2GTPPmISVOHS/nD1fMDLB8M2g=;
	b=t7KYz/7VaroibgrEO+K+QEP6wwkzB3AIIVojZml3n7bHe6S2xPThBWB3D7IYJEtBRT+Q
	 YijQ7at9G8aiaogb95x/wTFUuyK2z8EPYCaPzWesjCH00Bc89aCJcOhoen/WfKBT+x7Ts
	 8LRMK+jofsf0htscUiqVYD14clOvkCOUHjmRMtqS8D658hpay7loskGObOGMm52HLoUNv
	 OPE/nqmAukSq43bExXdidrCi9rxNHiUwvhiANWo1n7U0SPTn0OKKk3BPQftf4ixXCuGIa
	 kzUxaehjUKid1w2MNi2VawbjzE5ZgZ5S+LeKRJpPqpBk+tlUnNgMSMDTcFBC2fN0BBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1B46E1F00A05;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429761;
	bh=GhK0bo2B6oCuaiQEsr2GTPPmISVOHS/nD1fMDLB8M2g=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=n2/EMPMg8fJ/YnGChG6Z30bHL/2XStZ5JZfHF9N7kmU8LMX1TZOeDxD9EDt12XZuz
	 a3SFoJzzqvitbdmp6GI94wy5KfZuMdBHT8F6UK8fRILHiyY+sHOIwQ72TLK9Lpo4S+
	 4T5hSg2tHlkmZPWfRA4oXgKsWljY4UHp5cF/z7eN2FXAfGCyom45EOWftkCsCX9Sfb
	 j8twl5ig+nYFzrgcEo8BRL+llvLuFuWNNsy8FM0eHiDKn1l/rv8xhJJhE0Aun/TTf6
	 hHH6uZvc/UJnsVwGUmA/fYIlkPcgmJglzBK6T0aWOUGe8XvFt9s+WLK1dBTBI0k0tA
	 xBTkhJDtzBaPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 663C2490FE;
	Wed, 11 Nov 2026 20:42:40 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] nvme-tcp: consume TLS records without application
 data on a live queue
Date: Wed, 11 Nov 2026 15:42:38 -0500
Message-Id: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBBFf4XM2jEtj5K68j8Mi1JHGMMrbW00p
 P8u4Ae4PMm5567gyTF5uGQrOIrseZ42yE8Z2N5MHSHfN4Zc5EpKoXGKI2GwCw4cCW1wgyOLZVX
 oVhdaFELCtl0cPfh9dG/Nj/2rfZINe2w3evZhdp/jOMrd+/cRJQos69YoqWpBqrp2o+HhbOcRm
 pTSFzrVZGnMAAAA
X-Change-ID: 20261109-nvme-tcp-live-ctrlrec-4539b9390301
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794429760; l=3589;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=hXXbItxrwv78xxvvG5U42pKUfzgkaD4CVGRVQghqOfE=;
 b=uUgeHVoq6upcSqsLQTRCBiHyy6V7OpTLIhbE1iuAKvsd7x//4JeG41nwTbFP9gxBJe7lRmNAn
 eESbXznFiNtAW+EUYZn+tHxzIyyl4PfOIzvZRTu6uei7Al5uEn3+4QL
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

After the TLS handshake, a peer may send records that carry no
application data: a NewSessionTicket, a KeyUpdate or an alert.
tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
It returns -EINVAL and leaves the record at the head of the receive
queue. Since commit 288cfa187208 ("nvme-tcp: start error recovery when
read_sock fails"), nvme-tcp then starts error recovery, and the
controller reconnects.

TLS 1.3 allows a server to send a NewSessionTicket at any time after
the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
time.

Patch 1 aligns the control message buffer that receives the record
type.

Patch 2 moves the TLS record read loop into a helper. No functional
change.

Patch 3 reads the record with recvmsg() when read_sock() returns
-EINVAL, and handles it by type. Handshake messages other than
KeyUpdate are discarded and alerts are logged. A fatal alert, a
KeyUpdate or another record type fails the queue.

Patch 3 detects a KeyUpdate only when it is the first handshake
message of the record. A KeyUpdate that follows another message in the
same record is discarded with it. The next record then fails to
decrypt, and the queue fails as it does today.

All patches are tagged for stable, because 288cfa187208 is in 6.12.117,
6.18.63 and 7.3.4.

Tool use
========

I developed this series with the help of an LLM coding assistant. It
drafted code, tests and changelogs, and helped with analysis of the
kTLS and sunrpc sources. I reviewed, edited and tested all of it, and
I am responsible for the content.

Testing
=======

Host and target in one VM (virtme-ng), on 7.4-rc2. A test-only change
to net/tls makes the target send records on a live I/O queue during
I/O. Each case writes data and reads it back with O_DIRECT.

  Records sent by the target   7.4-rc2     With this series
  ---------------------------  ----------  --------------------------
  NewSessionTicket, 64 bytes   reconnect   queue stays live
  2 x 300, 2 x 1000, 6 x 64    reconnect   queue stays live
  close_notify alert           reconnect   queue stays live
  warning alert (90)           reconnect   queue stays live, logged
  fatal alert (40)             reconnect   reconnect, logged
  KeyUpdate                    reconnect   reconnect, logged

Data was correct in all cases. Also built with W=1, with and without
CONFIG_NVME_TCP_TLS.

Poll queues are not tested. Polled I/O hangs in my test VM, also on
7.4-rc2 without this series.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Changes in v2:
- New patch 1: use a union with struct cmsghdr for the record type
  buffer, as sunrpc does. (Sashiko)
- Patch 3: on a poll queue, nvme_tcp_poll() and nvme_tcp_io_work()
  could both read the same record. A queue flag lets only one of them
  read it. (Sashiko)
- Patch 3: drop a log line that repeated the error of
  nvme_tcp_try_recv().
- Link to v1: https://patch.msgid.link/20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com

---
Martin Belanger (3):
      nvme-tcp: use an aligned buffer for the TLS record type
      nvme-tcp: move the TLS record read loop into a helper
      nvme-tcp: consume TLS records without application data

 drivers/nvme/host/tcp.c | 175 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 144 insertions(+), 31 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-nvme-tcp-live-ctrlrec-4539b9390301

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>


