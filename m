Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207056;
	b=B2smALC/SNNU52DmTBu3YANvoaLkZLsD2ryJkGmu04l7kTZPHxQsPgkukP28RJ+o6rml
	 oWnzcVMR+aDFIsllIpycMQV5dkqiCMb5BVzz010yD22OJu4W2Wuyuybm5hoQvvYgFa7ls
	 7Nc0QiTU7xGQaB2iAdDH851kGPoAfqzW4k1D7dmqP46a9mNGwE0NnKDCjX8jrfNQUOL2I
	 BHH/13RvelCJFmK0qwf6zbbG5/+5usKzK9JM0XLPRaLKDcjpQCwc5eXlPdo2lQwxxdgc1
	 ur4EmFpPqjcV2TrTIrjUWkRIL1SUL5ybljEkZ1MGox+zkU3BWpZA9vslbUNsFeYa1fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207056;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3SDvB1sMsDhwkfmxbIGNI4BkEESH2HQdgWZqJmrcNzo=;
	b=by/t0GrSjf8rXBqyhBOP5+OezbR65hTYQ9GYaBTCYFq4Ao5LoPNiQU4eeg2mAalcwRrd
	 Bv+T9GmCl8RAsmBTvZyypThX/howPgKC2HAJ0BnSGGtbV6Hx803I2pxGyQfSAExZ2jbZL
	 8FsJQ03HpQaNEpLkwwFm8/oUHLZZyOAGegbep+4AbPAUSaWE2RJ3hmxEDgpvtl8Sh25Si
	 jEqlc14FeWVaCyx+kdqV7/kiteNu+u0x3vbBzZm5jkMuxVgnypbHOlNbOgXOYi92BtYpI
	 j/diNUanWvyzrfWsLy1UqLLxMZEem0ogqKAz+ZOZH7Q2l3ly5YQO4RZA2ot5C8Vo0vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duJghk7T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7A606A32A;
	Mon,  9 Nov 2026 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duJghk7T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794207056;
	b=c2ICeqW9oLuRVD5uc/crrqmMo99dsTSutH0w69OckxF70X2+/ggdLCSlOI9mRCqaVDT2
	 6KVgOVSAgI4K7kGq/z6s24UIvg90wGHUH58eOx0fsga5tIOtRYk9nzXtfQUaamGaw2wYZ
	 27W4+VnRsNHIRzHPBf157UYUiuUOJs4nApN4EeLGbdFpfkt6aNQKkcTFHCcSxibLXf6Zk
	 j8zOVL4kiY3BQ5JjXYEhVDT+v7lZp1C0IpVptFeV27YMEFVDLli4M0EqoDtLNJLAiQQHY
	 F1R2wgb6S/X/Vjpv7jChnhtvtmo4fSONNOmRbZ0z8PI4WSGzqGsnZW3hngcePpnOlHw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794207056;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3SDvB1sMsDhwkfmxbIGNI4BkEESH2HQdgWZqJmrcNzo=;
	b=jq+ywmyIJEcFjJePuNEz4PEVnsbAQnWmcUkPn5zMBILolrCCwjlQ7hEERq8whOAO00R3
	 uXlElEEk5K/CW/cpEa4WR3icrL3uYqkMQtlvOfimWrXD7EDeUUBwyQty6787l1wPK9FiN
	 DkQMZApJ48spNJPE7evWvs/YrF1yaMvgNwIuwGjHnQBfQdyR0dwkSVKSNOM+Ff+SuTBSK
	 KqVi/zasgmQ4rZlU/TaVty0lJwq0OprdF6Um9zrgOQKobyC56u1ouUKZjLUB3b/IhChHI
	 7cVrLItKyfVr0UiAasaCzmt7MqHcG0tXHtzC6psy9C7tH+EWgCCxL/MjHvPD9pDVoGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0395F1F008A1;
	Mon,  9 Nov 2026 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794207056;
	bh=3SDvB1sMsDhwkfmxbIGNI4BkEESH2HQdgWZqJmrcNzo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=duJghk7T2tTmCZ4K1kXyc3XV7qFLTLpa8eQ1InBhjudisJDAAKotAcRzx6ievbJ5A
	 241dMHgkC8YSNvFwmSwdx6IvD8SvMcnolZaaP4n3W/1cn/x0U06uUBqm2ICXjeiX4Q
	 ZyxjAx4KI+1w6O9D5goqInT6bU/OpSyJ8/i2+bpnrkBnF3F4RAs460mooiFl8/zkAG
	 sev3jnB8IbbgBY5XSVmTBPm8AhpfEZQLO9HqT6cfikkkK68E4SXjfCzinmRfcpr4tq
	 uohBaN4pvuQVXZPtXFWK/ZgtvV4Oxi7zza0UBvammaMncl/wZ0WJclckLvO1MOIv0t
	 g8oFWz1tQkduw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5DD7D48306;
	Mon,  9 Nov 2026 06:50:54 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v6 0/3] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Mon, 09 Nov 2026 14:50:50 +0800
Message-Id: <20261109-b4-gadgetfs-ep0-v6-0-b410e3dced89@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/2WNwQ6CMBAFf4Xs2ZqWlAKe/A/DoS1LWSOUtEg0h
 H+3YDx5nGTevBUiBsIIl2yFgAtF8mMCdcrA9np0yKhNDDnPlRBcMSOZ063DuYsMJ866SkgrZCl
 KXUNaTQE7eh3FW/Pl+DR3tPOe2Y2e4uzD+7hcit371eu/+lKwdCFUy42SlbH51Q2aHmfrB2i2b
 fsAPAVoAMAAAAA=
X-Change-ID: 20261106-b4-gadgetfs-ep0-f814c14717a9
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794207052; l=3526;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=GcCNUmekM6wbTbyIEB2gC9FjsQCMbBNAVPMPCFSA7gc=;
 b=xY6KpBmdfqXcFYoORjdxjDbtG3KNbxbwbb5sVpu/YA8FeWCJvLyo2SNs1TWgVIGz4kt3G0pAl
 kPWNG6ttuKTCCBiWcE8DRWeIuq+hLgnNTetaOdTPCMpDX+T7QeFLt+7
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime and the shared request buffer
races in gadgetfs, and the pre-existing event counter underflow.

The first patch covers the request lifetime and buffer ownership
problems, the second patch the event counter underflow, and the third
removes the const cast in gadgetfs_setup().

Changes in v6:
- Only free the buffer that setup_req() allocated.  Descriptor responses
  point req->buf into dev->buf, so clean_req() must not kfree() whatever
  req->buf happens to point at.
- Wait for the asynchronous usb_ep_dequeue() completion in
  gadgetfs_unbind() before freeing dev->req; also restore req->buf before
  the request is destroyed.
- Detect a control request that arrives while ep0_write() copies from
  userspace with a setup counter, and drop the stale response.  Keeping
  dev->state == STATE_DEV_SETUP for this would also make gadgetfs_setup()
  skip in-kernel responses such as GET_DESCRIPTOR.
- Wake an ep0_read() that waits for a delegated OUT data stage when it is
  aborted, and make the abort part of the wait condition.
- Consume setup_abort through one helper that restores
  STATE_DEV_CONNECTED only while the state is still STATE_DEV_SETUP, so
  it cannot overwrite STATE_DEV_UNBOUND.
- Link to v5: https://patch.msgid.link/20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com

Changes in v5:
- Expand the first patch's changelog with the concrete interleavings of
  the ep0_read()/ep0_write() races and explain why a mutex cannot be
  used, as requested by Alan Stern.
- Add a patch that clamps a local copy of the control request instead of
  casting away the constness and writing into the caller's setup packet,
  also suggested by Alan Stern.
- Restore STATE_DEV_CONNECTED when a delegated data read is aborted by a
  new setup, so the following event read is not misdirected into the
  control data path.
- Link to v4: https://lore.kernel.org/all/20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com/

On the submit/unbind window: every ep0 submission increments udc_usage
under dev->lock before the lock is dropped, and gadgetfs_unbind() sets
STATE_DEV_UNBOUND and waits for udc_usage to reach zero before it samples
ep0_req_queued.  A thread that has set ep0_req_queued but has not yet
called usb_ep_queue() therefore keeps unbind waiting; when unbind
resumes, the queue call has completed and the flag and the endpoint queue
agree.  The request that is still queued at unbind is then dequeued
before it is freed.  With a test-only delay between setting the flag and
calling usb_ep_queue(), close() blocked for the remaining delay (610 ms,
versus 3 ms without the delay), confirming that teardown waits for the
submission to finish.

The series was tested with the syzbot reproducer and with targeted
lifecycle, request-reuse, wedge, stale-response, and event-counter tests
on arm64 QEMU with dummy_hcd, KASAN, and lockdep.

Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
Jing Lin (3):
      usb: gadget: gadgetfs: fix ep0 request lifetime on disconnect
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 265 +++++++++++++++++++++++++++-----------
 1 file changed, 189 insertions(+), 76 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261106-b4-gadgetfs-ep0-f814c14717a9

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


