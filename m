Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416817;
	b=BhKZSDDfxb5zAHPUNJzt8dryFYXK8YZ/O8CoOPuyClaC1GMsy4NLkAzghsD+dtMJsV6x
	 S36Y5wAd+6diz3Hy/+RL2/yCcBZqVsF8dO32SSb57f4V9h5NuQubxLFboO1BPB4Q5r9nX
	 tHAct1txt2B1gy5iL4clyDwqvmZhDmdEm2axCmr0btDrKiRORJpa71Yx6DZVPa9uUglJR
	 N1doCQvGikVasp9Ptr1tT587cibfk4lXhR/rNivSBPKf5GgJeMK9jBz4YUi7B4mn0rSKd
	 6UX6zfP7BNfH5idq/z8pD0Shs8ekj7rg7kp2gSt4f+g3R63yQ7eKu6UfY/keiN+wWXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
	b=VCbBs8VUuW2kESb0X8qJS+YZ38L2RZ0FmSqaXUfTYC9ZfGci9v8VvV5d1MowfiBvg5EP
	 rrdc4uljv65ivnUnJQiA9ofiK+Tblr8aBfZ2f0ld24RecOKziMC9eqZFMVaQeKPCMoX4G
	 VCwwaZMljwNVkVVJkkNRMAfnrwPtXDJJvENEqb69V8zeyL89ulVSC6V0NFHrNytrDH9Qh
	 OIMKhj/FRYlmhFETcifg6DSWeAKXuNuEGJ6ZLIPOEi3XgmrM5vKmcZEwCsNasEeai9o5x
	 1NAlFq/c8h0FGdYMMDbp/DzFcWd9ED1zPrCMLs3zuMw4iVEwIXsP8paa/Ky87VzZSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbmojHWm;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02A606A8B6
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B02A606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbmojHWm
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05b210703so1781978b3a.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416816; x=1795021616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
        b=IbmojHWmWD70omZcaVCBU3b2W6NUiCjIa+IrJtazBOuwzFIQceMskZjfN16dYaqWZ6
         CxswnpmLBmfzKvCU6kXcO1hbDMh6hzwXXM1hSxZT/vNjrk0O5eZ99M1XDQ/E9KFfaE3k
         XkfHU/7oBuP4ua0kzM/7hh+lf76behzLaDXzQAUIdBJ30Ay01n8Dl5LpZFhTcBHjz5B6
         G07uRZMTBpihE03hkQ+eLytZG0lKOF9rN19d3+rpmxWwVNndqrDNk1fHMYnEL6JPsVNv
         6Zgi2Wm8u619S2db1cNeIkt+txLvd50wKvx4yNIw5QOm0oXTSVdoihymawXrTlM4dbfx
         ssTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416816; x=1795021616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
        b=F0B0v3tH7XCt6MB93Eeqk6vKQfsWqdv0SYVFLboPyXRHQqQQeftknk0fMtm5DMbr3q
         k8N/zpbCqbGK44evNdmQjhMuCToI3Yzkrj2s7niP+4AeUSQW/CGgfKPUqpcKeyZvZIwa
         Ggd0wo0/igYa+6LJQNdD7Qlfo13Zu0TCuE+j+6ZmKAhTDHmQKZNAHiVDDQmewPTlNDc1
         1WT8eUSeN1SX7NRsbYC41L5EZ1JNSHg6TjEpEdVqUn9/km9Jg0HVeeMb2+J36LTtH3mS
         MwMVbwUs2Ry2myx5QEIhcUrvsplBrYmSfCgLljzj1nhSvoWodYFG3w2KKBXqON5hNEpP
         Frcw==
X-Forwarded-Encrypted: i=1; AL+hErEY8ozYq/fK1W5uZR9EydE2LHQ79QRCtzn5nFSa5ezJgC22eMWJhBO16k3op0MgzhYJvHfxDKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UFsLhqXNwQN0NQBRBUR8sZqVSN0qArtlS4DY/EIM+GNGTrs6j
	x07iuZ49qGG2vOTk1+zub8380zn5buFJYr2ZboLr97HQ/K+P8scCSGsl
X-Gm-Gg: AYBFou1IeFZexQyaSI+CQDmsapCJCWeTp1q8cOWiOHfOP5u3ezpMw2SKGvpaJcd7i7s
	UAcwjUPDS7oaiIQ0L0U67dT8Yf9e7l/pB5V7nyTJgJCZSOpYKD5mr4gaN0GpsQTlgzJNuLtXjkr
	+EOSuDzrjdGQxJj/iDl3UFoi45w45nNp7yn/k5eEQkqbti+0UFI7GifBW1To66K6NQhijhrbVxb
	g4MZ3Knl5Y5QKyLJnLJIxQVFMFMLJTXIem/qaaQ69E+wmHydm3dyvIrUvHz8X5T1ulSZiyTLOky
	Ppex8ty8IDhm9VN7hiXFLfLoJBORMaDeZpntn0ru8/lJ5o5E+YlmDKNmEx9atR7MYBcnWmEZF7W
	JJWfdKD30+GD5bCJngchjZksQVTQuR3uS9FibRpIA4Du0UBqxitEe1SNmhpxQSUCvi3NF1UUuN8
	RCzD8n100MDDo/V3xpw3+1BoQIYnaNGMjYl6gq1quoBz1POsifsogAc+agn29IWMy8W6+z28Dn6
	pGqhAl5Z4UsVNhQp0YBFBxbcn85HSl9ENwydM7Yy8YhlglSCjQlgGGvDt7f86JtnCVNMApPwhYi
	xzbG0g9azBSMaPXsmJr6r5wN2fyXpk1v5CgLcMKMaZhpz1o9zA0OLWRn8ZBfAc5x8D8BPJLgys4
	Kyg==
X-Received: by 2002:a05:6a20:ef01:b0:3e2:4bd9:683e with SMTP id adf61e73a8af0-3f2feedf34emr2685736637.73.1794416816286;
        Wed, 11 Nov 2026 09:06:56 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm2347806b3a.5.2026.11.11.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:06:55 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+beaa1ed2d7aaec16@bugs.sh
Subject: [PATCH net] net: initialize ICMP error queue opt_stats
Date: Wed, 11 Nov 2026 09:05:30 -0800
Message-ID: <20261111170528.495116-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ip_icmp_error() and ipv6_icmp_error() clone a received ICMP skb before
building its error queue entry.  skb_clone() preserves the complete control
buffer, while the IP receive paths initialize only the portion aliased by
sock_exterr_skb::header.  The two functions initialize ee, addr_offset, and
port, but leave the final byte containing opt_stats and unused untouched.
A TCX classifier can leave bpf_skb_data_end::data_end across that byte,
forging opt_stats and making __sock_recv_timestamp() pass skb->len bytes
from skb->data to put_cmsg().  For a non-linear ICMP skb, this reads beyond
its linear head.

Initialize both bitfields in the two clone-based producers.  Do not clear
the whole sock_exterr_skb because the error receive paths consume the saved
IP control-buffer header.

  usercopy: Kernel memory exposure attempt detected from SLUB object
            'skbuff_small_head' (offset 72, size 59964)!
  kernel BUG at mm/usercopy.c:102!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: usercopy_abort (mm/usercopy.c:102)
  Call Trace:
   __check_heap_object (mm/slub.c:8146)
   __check_object_size (mm/usercopy.c:258)
   put_cmsg (net/core/scm.c:276)
   __sock_recv_timestamp (net/socket.c:1061)
   ip_recv_error (net/ipv4/ip_sockglue.c:550)
   udp_recvmsg (net/ipv4/udp.c:2034)
   inet_recvmsg (net/ipv4/af_inet.c:896)
   sock_recvmsg (net/socket.c:1159)
   ____sys_recvmsg (net/socket.c:2918)
   ___sys_recvmsg (net/socket.c:2961)
   __sys_recvmsg (net/socket.c:2993)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  Kernel panic - not syncing: Fatal exception

With HARDENED_USERCOPY enabled, the reproducer aborted the unpatched kernel
on its first packet.  With runtime usercopy checks disabled and KASAN left
in report mode, the same recvmsg() returned 59,964 control-message data
bytes sourced past a 704-byte skb head.  Beyond offset 1,024, 58,932 bytes
differed from the prefilled userspace marker, including 6,288 nonzero
bytes.  The patched build completed 2,000 packets under both configurations
without a forged SCM_TIMESTAMPING_OPT_STATS message or sanitizer report.
Networking selftests were not run.

Fixes: 4ef1b2869447 ("tcp: mark skbs with SCM_TIMESTAMPING_OPT_STATS")
Cc: stable@vger.kernel.org
Reported-by: <co+beaa1ed2d7aaec16@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>

---
 net/ipv4/ip_sockglue.c | 2 ++
 net/ipv6/datagram.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec93..3ab84a4c31e5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -429,6 +429,8 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	serr->addr_offset = (u8 *)&(((struct iphdr *)(icmp_hdr(skb) + 1))->daddr) -
 				   skb_network_header(skb);
 	serr->port = port;
+	serr->opt_stats = 0;
+	serr->unused = 0;
 
 	if (skb_pull(skb, payload - skb->data)) {
 		if (inet_test_bit(RECVERR_RFC4884, sk))
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index ca3605acb433..85f646f8d059 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -330,6 +330,8 @@ void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	serr->addr_offset = (u8 *)&(((struct ipv6hdr *)(icmph + 1))->daddr) -
 				  skb_network_header(skb);
 	serr->port = port;
+	serr->opt_stats = 0;
+	serr->unused = 0;
 
 	__skb_pull(skb, payload - skb->data);
 
-- 
2.56.0

