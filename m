Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794284015;
	b=VJtqVGmVGJBrfe/j+c85M+Mb0b3a0anEaoxh4BjaQvzY/KhWhBb0aD0tbpfHElad1mBI
	 oPPUSrnYLK6Lc8V5Ds16YrDFj0qEOWh+pj5wI5jMItvZ2CsVQEaQPgRgQ8Kzvt4cnY1kY
	 UpvP4X3TIJ25FLTHMbiAC2tiY24cc3IWGf8KSZQ6lXr2i/3eqseo9oU6Fb1IXZGgeY6t+
	 PkYFSOKUs0mP7P2XldoB6A86en3b48dRDVsc2G9bxI4KIcwUADIzrx6ZwMA87uDQYPAMd
	 eO1Avtd4JlqZnAibUt3xRq9fxWQAe4XrTNp+v0EZMM0I1FSKD4f397KsfCq3ToBpv0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284015;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=sXdcuMnWSW6xTJfls848K2GigRKYiWPGbVeFV2DOeV8=;
	b=o5XBfbC0WUWXbQzhhSg3Z9Hjf8DBnNiFxngI3nvi0mKyR3xjm1DpZnAGVT6MyOGYYCcn
	 sY+x5TYhLqjzZZ/S7WP8GXghIrQuNBXgyJrVGc/g8OjEw2um3cz0HXFD0bPENMti1Zv9L
	 ++UOhP3OR2DSC1XFZhruMsEhWVFAkh2sE8RZG/lHvNbsj0RwWmQEgydhWow5reu1O5xP+
	 h6vcPb5IJ/tvItjRwTGMMnXxfx2+ku6l6apNl1T6+VzBd2eIRf33YHNSXG3DqawGKLWWk
	 PzJZUIUMbi2pNKGH3nmUe7oyiLg/AZIjx4y5NaKLSuXGPc5+TohHlpNpHNm61ygcbMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcLdr5pe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4E606A31C;
	Tue, 10 Nov 2026 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcLdr5pe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794284005;
	b=MVF5diAG3Ww3PBYgk6m9sD7nDYZrL/NDe+5O794C/EGOvZDSGnaXAISbgogfWZ8+yszN
	 oDyVpN3FWg3WfrQ2wjY+1uWAK90+BAG6ptJ80klfovBNlhhCxLnwVma+xTpKyxBciOROC
	 JGCV7irgW7CaHh5CAQzDQZZdnouoCwkKvudAGXZbvbTVP8C26wMFfcD4N6/AHAIQNSpri
	 ZXf752dw5ey3U3ZdeE6Q0FVx4GuZbc5yWlJBwFIgGiHyko9Z+6aRftsn8HhFmg0/foL34
	 HSQDmCavUTmw7NktXCldOFe0il8GLcIiC29iEaOFGCLxla/lazrMj5RIoI/vdnBafJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284005;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=sXdcuMnWSW6xTJfls848K2GigRKYiWPGbVeFV2DOeV8=;
	b=chtJ58YmATZqxdnOQJhbsWl6HpVal1w4r8mX6M1+EJKlbZt7kXPqF+KTyV1AOxlrKF9v
	 OHr3sAQuhg2kN4mMEh5Bz7N8C7hXFSertMNVY/rlDFH//niMEPeYcIDsl4CaK7qVuIaNH
	 bogGjq4YBHG9c+/uLt20BH/tUv8cmY47TvGYj3xpG9NRFCmFxTOJ4VEwtJM/DXAeK3QXF
	 10ujRK/1YygMXGfX9lkfo3QTriLPqaHmlNzoifwZ6KQa+I++oynjNe2RbnOZtpTZiVEG0
	 LQ3BpqDX877ekUJKLooPP9M/xnE+TRWTaO5sYsbjT9xEZnufwNHLRjola1kWNlhQfOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC84C1F008A1;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284005;
	bh=sXdcuMnWSW6xTJfls848K2GigRKYiWPGbVeFV2DOeV8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=kcLdr5peUVuJzBCLtIUbTR/kHpzEojp5p8tg3vjF7Y/B1vzRwyyX4KCvMkPNYhIF7
	 nRUOGghQSaLFs2SdajJsyDO5O+VEwfFbE0lxTK2vk3ukArBsYB8YYKwKOmQA8/tTCv
	 mWSSRFXP4nMNLOoQ7BdjOey90romGdHk5S8v4RaRwz9DNA8JeelpP0iErjEwpnJaYZ
	 s/e+u9hkesDVH5+c1tzI0rvj+K69NlyqOpD75tgDaiK9aIosp4JPSFmsJSdM148tl7
	 VzT8E9uvOp0SQcY5+bmZ9Vtq9hdtIRvttBLpEM7UU0S4POMGI+aywRoCChen6uEm5O
	 iKV1LMFwtuChg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5ECBA487E1;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v8 0/4] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Tue, 10 Nov 2026 12:13:21 +0800
Message-Id: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/22NOw7CMBBErxJtjZE35F9xD5TCOBtnEfnINhYoy
 t2JQ4s0zZNm3qzgyDI5aJIVLAV2PE87VKcE9KAmQ4K7nSGVaYGIUhjVGfK9E7RIESpx0WWmqMY
 8RQX7arHU8/sw3tofu9f9QdpHTWwM7PxsP8dlwNj7Yw9ljBRFJ/NM1loXqK5mVPw863mEdtu2L
 zAAcB28AAAA
X-Change-ID: 20261110-gadgetfs-ep0-v8-3c74ae91521a
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284002; l=2061;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=BlzA0Qa2znzj8wOnyhlzEGmT96YORddPRspoCgok8lU=;
 b=5nKStOoz1gCplPEVEFe9tOPU3HcgunCLaLVMgYZnJLvw+/cZnU7WnwhxUSSPhDHyIgu4gb3sS
 wuwfRcze6m0BRRhpNWs0SPgBjleZKUcf7zIZKrautxqq6U1qI61BBi8
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime and shared request buffer
races in gadgetfs, and the pre-existing event counter underflow.

The first patch covers request lifetime and buffer ownership, the second
the ep0 setup abort and unbind state races, the third the event counter
underflow, and the fourth removes the const cast in gadgetfs_setup().

The setup() callback runs in interrupt context and may not sleep, so a
mutex cannot be used to serialize it against ep0_read() and ep0_write().
The shared request state remains protected by dev->lock and the control
payloads are handed off through private buffers.

The series was tested with the syzbot reproducer and with targeted
lifecycle, request-reuse, abort, unbind, stale-setup, and event-counter
tests on arm64 QEMU with dummy_hcd, KASAN, and lockdep.  The syzbot
reproducer still exits 137 on the fixed kernel without a BUG, WARNING,
KASAN report, or lockdep splat.

Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
Changes in v8:
- Discard a queued but uncollected GADGETFS_SETUP event when a new SETUP
  arrives, so userspace cannot queue a response for a control transfer
  the host has already superseded.
- Link to v7: https://patch.msgid.link/20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com

To: Neill Kapron <nkapron@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jing Lin (4):
      usb: gadget: gadgetfs: fix ep0 request lifetime and buffer races
      usb: gadget: gadgetfs: fix ep0 setup abort and unbind state races
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 437 ++++++++++++++++++++++++++------------
 1 file changed, 305 insertions(+), 132 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261110-gadgetfs-ep0-v8-3c74ae91521a

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


