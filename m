Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295313;
	b=V2NnSgJZVoQN1khX6oG/FyhsyC1BFBovf5CQCV45YSSUnOIO86mAuwvAnHGpPBbcJeJb
	 y7cEcBZQIv1o7CvOaJDM2Ditchu4SUCTRswUhbYPquqnuoYP3/NIjAeXj879umWIFWPCK
	 PZWpRKXE/VQhimh0mZe4k9lFKjYDYBqfBtLmgOYdyS2dRBmvr4UpXcZ0yF8fj2dssV4hn
	 id45OnNKO0lnyAY9YQ9JRvQI0DMEmRKtY6lCK86JdQaVKkvlG3EuzwLCARDomfaPABBtB
	 4iNhdNnrD2D4KgSDsjgju4tY1asWjKtiBmYiYfzVGJZpJOmNCsbHl3ftsqTj08qz0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295313;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=BZAybHKPrp5cabZgbPg7Wb9TVLxchkkoh8bos8p+zE4=;
	b=ucdQUzO1JNwYHUbPE6KuStHGRvoA6/BBteRduu8jkZwhxsSU0D3sCAbHh8utRMz4QQxj
	 03b3eppGL58kYInv1GCcSZhOROBrdnQZYDbp3ZOyNiSI2VjUtbbHXIHSKAeJWAbKB3prY
	 /P0dBKjS1IS3djdXbnn2P+GKDM3iIGQZvRqeZ3gbSa5+pSLanliZUQl17GMFFmP+Wn1DV
	 0nDY6SmNZywCCYmTMKk2OcsjrMA+PEfsQv/GBD1WB88sysQP6/KuA4QEF+7mQzSe56LEx
	 fdga8zEE8xVjHbC00hXXySgWivAsc+IHtFW/jMwN+8fTmyKNuRmrNRkU/FWtVpii3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2815606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2815606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8468290b866so2423919a34.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 23:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794295312; x=1794900112;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BZAybHKPrp5cabZgbPg7Wb9TVLxchkkoh8bos8p+zE4=;
        b=B1I5cLzj9en7A72jJdt1M+13nEtR9ndAGjy5GJlKnwdV2k7lUwQX2TslqTGuyPD8rP
         ItIvQ6VdeXQz6TuOyTMjo5AoH/WBavKatSZwHoS68Q05u64U7Z9tCJ2wtxcZBrba4FWW
         Ktwj6Kpan3wnOBKM1pBGbxKW8xFe9eCwaW0Vnp/zCq7uOeEiPAk84Qiq3g3zRYsisTCa
         7fMZiX01Et6mUG1mqpBNgXAiBpl6MKSTgyJptabvjecRttO/jFLY437BxkuGl7METj2i
         SiRgQW9o0Q5cArBVhdo6kXL5BP+Bj+05HXQnJWNa7+Qospkxa7YjmVZPbd9dGDQOifNo
         lwyQ==
X-Forwarded-Encrypted: i=1; AL+hErHIEM2/Iq2dg2r2tbDw1BES2vNYRjgWzFxYAR/lkzfVVFz1iMSwoCyZc/OUZhOYPBj9Yu4n9Bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9j/HiWS5Z04LbdDnPbK/JwaFiW1W9Vi3Ng7cyaV0meBlMJlPz
	cy0B/1wI8cV5O6AaLUO6RP2DMmm3+QUIdQuEdMs4i1zz//6BS4n1FQmD7jiVsGPIQ0t+0AeoZm/
	4qHbBlj9esfUEbPs6C+tQxLMwkv0BdX0wsN7z/Gr7tk7C5Ruz/LdF2Kk4XX8=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a6:b0:540:5827:6d8c with SMTP id
 5614622812f47-5683cacf790mr1530702b6e.57.1794295311977; Mon, 09 Nov 2026
 23:21:51 -0800 (PST)
Date: Mon, 09 Nov 2026 23:21:51 -0800
In-Reply-To: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af2c60f.5a668245.1aceb6.02ce.GAE@google.com>
Subject: [syzbot ci] Re: xfrm: fix IPv6 atomic fragment policy handling
From: syzbot ci <syzbot+ci38d3d40fc327a9e2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, herbert@gondor.apana.org.au, 
	idosch@nvidia.com, jeremy.jean@oss.cyber.gouv.fr, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org, 
	steffen.klassert@secunet.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] xfrm: fix IPv6 atomic fragment policy handling
https://lore.kernel.org/all/20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr
* [PATCH net v3 1/2] xfrm: fix IPv6 first-fragment protocol decode
* [PATCH net v3 2/2] xfrm: fix selector matching for IPv6 atomic fragments

and found the following issue:
WARNING in __xfrm_decode_session

Full report is available here:
https://ci.syzbot.org/series/9d92ff08-0b82-4440-b345-9628353f5181

***

WARNING in __xfrm_decode_session

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      2d2200551ccc3b9e444aecb59c4b53287e169266
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/fe2ead38-2a3d-497a-9bae-e5da0ee59933/config

------------[ cut here ]------------
len > ((int)(~0U >> 1))
WARNING: ./include/linux/skbuff.h:2856 at __xfrm_decode_session+0xafb/0xed0, CPU#0: syz.0.121/6184
Modules linked in:
CPU: 0 UID: 0 PID: 6184 Comm: syz.0.121 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__xfrm_decode_session+0xafb/0xed0
Code: bf e0 00 00 00 4d 03 3e 4c 89 f8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 11 03 00 00 45 8b 37 e9 33 fd ff ff e8 c6 c7 30 f7 90 <0f> 0b 90 e9 8c f7 ff ff 44 89 ef 8b 5c 24 20 89 de e8 bf c9 30 f7
RSP: 0018:ffffc9000e926b60 EFLAGS: 00010283
RAX: ffffffff8a9849aa RBX: 1ffff92001d24d74 RCX: 0000000000080000
RDX: ffffc90006ec1000 RSI: 0000000000000c7f RDI: 0000000000000c80
RBP: ffffc9000e926c90 R08: ffff88816dd8bc00 R09: 0000000000000002
R10: 000000000000000a R11: 0000000000000002 R12: ffffc9000e926bc0
R13: 00000000fffffff8 R14: ffff888105f226d8 R15: dffffc0000000000
FS:  00007fc136da96c0(0000) GS:ffff88818be0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002cc0 CR3: 000000017256e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 icmpv6_route_lookup+0x44a/0x610
 icmp6_send+0x114c/0x1b50
 icmpv6_param_prob_reason+0x32/0x50
 ipv6_frag_rcv+0x927/0x2b40
 ip6_protocol_deliver_rcu+0xe8c/0x1680
 ip6_input_finish+0x191/0x370
 NF_HOOK+0x336/0x3c0
 ip6_input+0x16a/0x270
 NF_HOOK+0x336/0x3c0
 netif_receive_skb+0x278/0xbf0
 tun_rx_batched+0x1de/0x790
 tun_get_user+0x2b78/0x4470
 tun_chr_write_iter+0x113/0x200
 vfs_write+0x612/0xba0
 ksys_write+0x150/0x270
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc135f6974e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007fc136da8fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc136da96c0 RCX: 00007fc135f6974e
RDX: 000000000000004a RSI: 0000200000000700 RDI: 00000000000000c8
RBP: 00007fc136037f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc136226038 R14: 00007fc136225fa0 R15: 00007ffcfeaad798
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
