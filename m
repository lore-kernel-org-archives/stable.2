Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697105;
	b=OzNzxVD8OGwlJxyz3cxcjnbtUVaCVfGid7fW74GJLyqQ1HMTg1kxDNustpsAl21Z5NGU
	 WVppSaR3xl3WEI/z6OBm2PJjohb0PzEMt72YsIMqXOE18u4yHOn+bKUxmIeJFtl2Gsild
	 72PGW1wxiaTVzCrhNYIu2ic+uHUtAUy6H30oMRm1EeaQc+Ku26epN8tcu00/86Vu59Dbj
	 TAE5mDtBGBKQI6PMBvo2Be47IQBiw8DJpgwVqardQrFkyRyw5lryhmjSQ8+zVzPCWbkz/
	 zDmnzNth5/GbtYNzKMqqrEPn3LvDCvnKu/wSf9EbzHqy1X9y1MXV2Gz6k6AgFUFpJXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697105;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=O/DqJv5AvbqZu3M8ux9n2zYKBDJZ45iyRtXO1K41Q/A=;
	b=soPJGLSxukmIlMCF7D7Dz7c4xeCF8EEqjwXv8AKEZulBWOu+dzbcRKwQ0KKHuXkuTPHp
	 cbLLRgrw5yCFKbTTXeHKUUadtqrVIxpMyWsg7xy9GHWeOsGUUSFiz/591gMp+KOSBDnd3
	 1TZCZxM8bjL8qAi3gDepyumR6gqtyf7w8kSmChy2Yhk54pHioRPG37/K0VtWmEhpiEVdu
	 Y7BVVIPK62TqXAs0I+WAgYiLfaXyu5S5nLR/FpaXKrx9KgqE42BXGBTcMdS1cs3sn3IoC
	 ogYruMAVDyy03r1k+aJwoyJ8roAE7v/AIJLWTRRpEj0A0tc1DxFFrFeA7Jz3f0viBoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpc3+zy4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859E606A32A;
	Thu, 26 Nov 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpc3+zy4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795697104;
	b=D6F/COjKFSwISueVaXJv3UYx3f8yrnHFeCbEJ5IPwaoCT0PHVNk6n0lbc08KM9xQpqQ8
	 +UCV01nVwEXe8HJJXFlFranM2QObh4Aq0fYgZDTsCinSB9y8YbMkfzus4DAYqKGrFQhGp
	 ZkSuQ1f3VzhBWT8zkC9I8k+p2MCXO7HZfvRBgw8T/YQ/6w7nFyxZLuRZAvTl7z9TL0abk
	 xUjaNts4mTvRpvaiAUUNmQ3HgGWx3DwEeyGg/JJBCDpMWfUHAEgzgqcrJC7UK2x0pelbN
	 NRlEjVIcRiFt5oNiamUMSTEeAvTdVrXD0ILsDfyRb3UG3RRzzSWgJ/DfEdy2mS6Uuow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697104;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=O/DqJv5AvbqZu3M8ux9n2zYKBDJZ45iyRtXO1K41Q/A=;
	b=oIHZD1pZBgZ2t/2ieVVB3nbJsOb87/kNDe0zLqUcd+Jv+xSwXIPUbrTclFhiPU/tT1tm
	 VEdR7jhPRvnj8aOzguxgjpM5ICCB5gWg3/KlwEfWszxaVK1KW8JS8CWPrLmC4I9kp+ick
	 82wnfyGGeYcUvtiowSC0pazZMeyCTJ/HN6CRNUCJFVUMzzDaJJKkZmYhfxP19HO6tCX5E
	 Oul9p1owdf3iNdAtNub7fgDFVK3KXgaQOIVwOkoAyVGhFOfH80J5O1DI3ip3fQ9lDPxyZ
	 8JWIZmbpNCE2bdZtKMm9Jn6ITM92IS4WpOjtz7iWQ9d+7tpsK6WCUg19aF1rGseQhOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A96A1F000D1;
	Thu, 26 Nov 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697104;
	bh=O/DqJv5AvbqZu3M8ux9n2zYKBDJZ45iyRtXO1K41Q/A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Gpc3+zy4HwUOZjDGs0ZzHGRl7HlqA+ayAF12CpJBa5QsGmAwUl9FQU1qscHN6NLj9
	 PkuK85GG4f9oiOEh6be7PBwBJAUFFGdOtzAXMe+XHgBG9wjOPxeNS1x9EnmY5WfENp
	 86h6n6YVgVRhpxUAh1O15rE+XABJOO/qFk+7ci4kT5fs7DU6T79HWJun0aRt34XI/y
	 fGSiXBrGRMnXMquRXMy8tRdbLB3xQQQZG6supnhdAVQKFfT/+5nwRiPdapcMjIvAMm
	 63i1JeT+183wf+GL1cQsgUmhn6cw1umXnIacFe9JJhngU3FXqFBvExEbEGaWnMRbnm
	 qoBflH5MXSvhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C8CE4D4C4;
	Thu, 26 Nov 2026 12:44:54 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v10 0/6] usb: gadget: gadgetfs: fix ep0 request lifetime
 and control races
Date: Thu, 26 Nov 2026 21:44:50 +0900
Message-Id: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAMIpCGsC/3WNQQ6CMBREr0L+2pq20iquvIdhUcqnfCOUtNhoC
 HeX4trlTN68WSBiIIxwLRYImCiSH7cg+KEA25vRIaN2K0ByqYWQmjnTOpy7yHDirLNSKnXiypw
 VbJMpYEfv3Xevfzm+mgfaOTsy0VOcffjsh6nK3B91qhhnF9GUurQadSlubjD0PFo/QL2u6xdFh
 /U6uwAAAA==
X-Change-ID: 20261126-gadgetfs-ep0-fc2255305a75
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795697092; l=3154;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=p1lLMpmlt9kkScFn61Zfzl16KKY6YuNALR7PHkXUvx8=;
 b=O2mkzLygLtk7Y+w9TR/AvEQBl0FICi95CRZek/N04F0038+LYWq54dOzcil2PtA9CW21UDMWg
 jkq+vZAmk/rBO/iBDl1L6DlTyvyOb49/gunXuwmramUEgmalvDJ0V67
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime on unbind, control buffer and
setup_abort state races, lost completed control-OUT transfers, event
counter underflow, and the const cast in gadgetfs_setup().

1/6 tracks active ep0 requests and waits for completion after
    usb_ep_dequeue() in gadgetfs_unbind() before freeing dev->req, while
    keeping descriptor buffers out of kfree().
2/6 copies delegated control-IN payloads into a private memdup_user()
    buffer before touching dev->req and drops responses superseded
    during the unlocked copy.
3/6 fixes setup_abort tracking across ep0_poll(), gadgetfs_disconnect(),
    ep0_read() event waits, and early returns or in-kernel requests in
    gadgetfs_setup().
4/6 preserves completed control-OUT payloads until ep0_read() collects
    them, leaving ep0 unqueued so the controller NAKs newly arriving
    control transfers in the meantime and replaying the deferred setup
    afterwards.
5/6 dequeues ep0 events before dropping dev->lock for copy_to_user() to
    prevent dev->ev_next underflow.
6/6 removes the const cast on ctrl->wLength in gadgetfs_setup().

The setup() callback runs in atomic context and may not sleep, so a
mutex cannot serialize it against ep0_read() and ep0_write(); shared ep0
state remains protected by dev->lock.

---
Changes in v10:
- Re-check setup_abort and dev->state in ep0_read() after waking from
  the event wait before jumping to scan: (3/6).
- Track the active control-OUT request with dev->setup_out_generation so
  ep0_complete() ignores requests superseded before completion, and
  check setup_generation in the ep0_read() control-OUT wait path (4/6).
- Recheck dev->state and dev->setup_generation after queue_ep0_req()
  re-acquires dev->lock in gadgetfs_do_setup(), increment
  setup_generation on disconnect and unbind, and verify generation and
  state before calling usb_ep_set_halt() in ep0_process_pending_setup()
  (4/6).
- Link to v9: https://patch.msgid.link/20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com

To: Neill Kapron <nkapron@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>

---
Jing Lin (6):
      usb: gadget: gadgetfs: fix ep0 request lifetime on unbind
      usb: gadget: gadgetfs: isolate ep0_write() buffer and reduce setup race
      usb: gadget: gadgetfs: fix ep0 setup_abort tracking and reporting
      usb: gadget: gadgetfs: NAK new setups until control-OUT data is read
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 551 +++++++++++++++++++++++++++-----------
 1 file changed, 399 insertions(+), 152 deletions(-)
---
base-commit: 90d6263e867be7089b3d3323bef8d2accd327c77
change-id: 20261126-gadgetfs-ep0-fc2255305a75

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


