Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6B3750D5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542494; cv=none; b=aqdDttHqurARUuzqDzMd51m+y1hvzUFeg5scPKDflkFOflkhFtQFG82zOrBjZ0ty2Bixk9l0VkJs1MEOcPi1dr3ex7KYzK8BYZuRYegWZsqGQIap03/lHRp5vzWA4p9RmYJEr6qJy5N7JpTE+EXCV4XNT2CeT3wV0Z7Ko4wzofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542494; c=relaxed/simple;
	bh=tXbprwIsw4+TnWQEjWhGgnauvC05A6g8kXeB1lZBCK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNLHj7hAQIerGYgqk3kDxmPRIkEQjKa+j40Cbm6b1Ud/sWi6V7JM4kyMfNGjI8Xk/YNIDOsUMczIyUOz5IOaC3KTScpXU4JSdnAQQTqwabAHSZ09+udQWytqX5KpRrz9DhTSIcmPOwQK+z1riAqKQishOOQkJC4pLwWUis88/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5rp0jFo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5rp0jFo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2541246a91.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542492; x=1788147292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZjZkSQf+Zktufc09rNjCOpfzvoTH5+6Bb0FnK3Vps4=;
        b=G5rp0jFoCjnG4bg8/dOC+KBVRCWYOQxDWcKFKxH5EWfeg4ji9GHoKUNNNE07W/LluB
         qD+MvkprQQmp083+qbwWLN51UAwGVaqXaQmw5rMa+LkI9E9Op1CETnumK1pOopshgyuf
         wROyb0ZdZzzBwGNxvAKpFJqLwD4yy0STfJalC1eNYOpwPeYn4Vbq3gVjt3R8SNSJsCox
         wgmTfY4lpPhenREZIJTCTBfJRqRb/xDVKKA5lzPs2iBtbXf2RgL/fb6VEdJhIeWDznWk
         lF85YvoIlfPjs4BVLHB7bvNICwpLeWEQstmdtzsVU71wvzyRdIvyjEoUOP7yt8A3Iqq1
         HybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542492; x=1788147292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZjZkSQf+Zktufc09rNjCOpfzvoTH5+6Bb0FnK3Vps4=;
        b=YdSPhyiwQH7Au9V7XCaroMl+0UmXw0CsHzzwzHfCUPUhaZ6D1Fav7xQZwFbIBqM/5H
         OHTS3+JrIv7Gq45FdyeEF+VYtQVj5cOK82QIyaSlPFpTb6BPzLedh7M6tPSyAQX3/fvI
         P2Xt75eAw1gDxdCQI21/Ek7DaWw0QX6cqY2GBenQxlxwFN4r6i+wmdrTBv/J1KfNzWPE
         4fuc+LynHvhEfgDDzQRG2xUlMntpDfAaTArhJQr/NrQOO6X295IbhNxxj93wpHCGpYVS
         +WOAc4d8CGDM8KzgCvxFSwhFKp5cOz1VkwkY9lbwCO+0ShTw1KM5wcqSd5fUYgiyCElK
         VdrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhscOXQ9zZktFGk7V77C9xK3areXXyctMhqDUCqO0AMuzaJVL+lk/N9ilLXJk8MTzgtRFYJ5s=@vger.kernel.org
X-Gm-Message-State: AFuF++nZVTDmnepcIbmNOQDCIFWoPBfY+Ep4o8lYj5EAzEkmMX2NiX4+
	dAH6DA4uZNIl9VEyuXrG3RDnrvtMUzmKd+79v3Civt6SYWv3k9p5bob8
X-Gm-Gg: AR+sD11ueC+M+irhiXWPWee24H55wKMCwpU+Nr9lK6rlnbEuE5it0GU7aQCGijzQ3tW
	PbHDVhPTNM9riZHWiuIuqI80Iw59n6aGm+M3Dan2Ec1mCn9edPUR1Be0jIHwBFHIgTt9EnDAiTe
	EMY5trAiyB2TjYpCFdX7zSe16d0w4/zt+eFj3WKos4TyHjG3pIhjHWoMqihzoHnAfgcsrWk4Mil
	tOtOzCS7P3N7Nu/mmpUcTq4hsBkCyDGn4XCXYGahXedZ3ZjVBBlPyJUcKVBGtifrDwX263lBM4M
	Wyc73yX+oN1Cf+G/sRh95EgezeQOEMevMGbAvXDGMPwV5pF8h3wisrnN1IPa3c2OXT5RbnrVMVU
	d73Lf/Tg2iRCM4dJqEeOQEVR3Lrq7hj3/z0SyTGBBUaLJTbNB964N/ZAD3i7KajW6Oy/t5WOfWO
	6rpTjAcK4NTtqxL6Sn6R3BNIQw/o9Bp8x3KHPprRhCA1duFgsToz7bUllnYap0rlNtebwTWiguo
	X/So2GVjyc=
X-Received: by 2002:a17:90b:4ac6:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-395df13ced5mr26345382a91.8.1787542492202;
        Sun, 23 Aug 2026 20:34:52 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:51 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 8/8] tcp: do not inherit retransmit state from parent
Date: Mon, 24 Aug 2026 12:32:52 +0900
Message-ID: <20260824033331.1084971-9-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child gets a copy of the parent's retransmit state when it is cloned.
On a listener it is all zero, which is why commit eb2c80ca87b1 ("tcp: do
not clear packets_out in tcp_create_openreq_child()") and
commit 5c701549c9a6 ("tcp: move retrans_out, sacked_out, tlp_high_seq,
last_oow_ack_time init to tcp_disconnect()") dropped the initialization
of packets_out, retrans_out and sacked_out here. lost_out,
retransmit_skb_hint and highest_sack have never been cleared here.

The parent can morph from listener to active session while a request is
still being processed, and connect(AF_UNSPEC) followed by connect()
gets it there. tcp_check_req() does not hold the listener lock, so
nothing pins the parent's state between the TCP_LISTEN test and the
clone. The child then copies the counters and the two pointers into the
parent's retransmit queue.

sk_clone() sets sk_send_head to NULL, and tcp_rtx_queue is unioned with
it, so the child's retransmit queue is empty. That does not help.
packets_out is set again as soon as the child sends anything, and
tcp_xmit_retransmit_queue() picks the copied hint over the queue head.
When the parent disconnects, tcp_write_queue_purge() frees those skbs,
but the pointers the child copied are left alone. The child then gets
an ACK, enters the retransmit path and writes into a freed skb.

In short:

  socket(AF_INET) -> setsockopt(TCP_DEFER_ACCEPT, 30) -> bind -> listen
      // a client connects and sends one byte. the kernel processes
      // that segment while the steps below run
  connect(AF_UNSPEC)              // stop listening
  connect(peer)                   // become an active session
  send() repeatedly               // lower IP_TTL so the peer's IP_MINTTL
                                  // drops most of them, and let one
                                  // through to get a SACK
      // parent: packets_out 6, sacked_out 1, lost_out 5, retrans_out 1
      // retransmit_skb_hint points at an skb in the parent's queue
      // the leftover request completes and copies this state
  connect(AF_UNSPEC)              // those skbs are freed
  listen()                        // or the child is dropped
  accept()
      // the child sends data, one segment is lost, and the ACK that
      // comes back takes the retransmit path to the copied hint

KASAN log:

  BUG: KASAN: slab-use-after-free in __pskb_trim_head+0x66b/0x900
  Write of size 16 at addr ffff888008141530 by task repro/76
  ...
  Call Trace:
   __pskb_trim_head+0x66b/0x900
   tcp_trim_head+0x69/0x540
   __tcp_retransmit_skb+0x14e/0x26b0
   tcp_retransmit_skb+0x1b/0x250
   tcp_xmit_retransmit_queue.part.0+0x3b1/0x970
   tcp_ack+0x3382/0x7430
   tcp_rcv_established+0x631/0x3a00
   tcp_v4_do_rcv+0x449/0x960
   __release_sock+0x1f2/0x2a0
   release_sock+0x176/0x1d0
   tcp_sendmsg+0x30/0x40
   __sys_sendto+0x316/0x380
   __x64_sys_sendto+0xdb/0x1b0
  ...
  Allocated by task 76:
   __alloc_skb+0x11e/0x890
   tcp_stream_alloc_skb+0x2c/0x5c0
   tcp_sendmsg_locked+0x1377/0x3df0
   tcp_sendmsg+0x26/0x40
   __sys_sendto+0x316/0x380
  ...
  Freed by task 80:
   skb_release_data+0x554/0x810
   __kfree_skb+0x42/0x60
   tcp_write_queue_purge+0x6ef/0xf40
   tcp_disconnect+0x2fc/0x1e10
   __inet_stream_connect+0x6d0/0xdf0
   inet_stream_connect+0x52/0xa0
   __sys_connect+0xfc/0x130
  ...
  The buggy address belongs to the object at ffff888008141380
   which belongs to the cache skbuff_small_head of size 704

We need to make sure this can not happen, by clearing them after socket
cloning. A listener always has them zero, so an ordinary passive open is
not affected. Clearing only the pointers is not enough: the counters
would then describe a retransmit queue the child does not have, and
tcp_fastretrans_alert() and tcp_retransmit_timer() warn.

Very similar to commit 8b485ce69876 ("tcp: do not inherit fastopen_req
from parent")

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7fe318d9e0aed2..2fde196dd302f5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -660,6 +660,12 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	tcp_ecn_openreq_child(newsk, req, skb);
 	newtp->fastopen_req = NULL;
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
+	newtp->packets_out = 0;
+	newtp->retrans_out = 0;
+	newtp->sacked_out = 0;
+	newtp->lost_out = 0;
+	newtp->retransmit_skb_hint = NULL;
+	newtp->highest_sack = NULL;
 
 	newtp->bpf_chg_cc_inprogress = 0;
 	tcp_bpf_clone(sk, newsk);
-- 
2.43.0

