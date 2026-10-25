Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955942;
	b=S/LYFLxAFV9r15/K7yRrSx7U/8bnq3e+p8+0VcGfdKY6WLVAilApMaQeXg0At58/DQL8
	 K0j40uz+i2jEkIZTsRpLtkc6BB3zuk/rDuldCg845s9hsZInT9CchbCuVxc4PWLzzHWiP
	 LtpoomySNP2VhHNwaerW/GgwTZnrfd3QpQUGFrtpcFaK8zlw/XaqkGuJKrT49TJbawA7b
	 0xCJ/QX3TIajjSfYx0RwsZJ+tuOZFuYZRnifQ1ocPsprBbHENUn1qGEeoyZATCaRy+DQe
	 XuspKCrIBqvFPab4zoNiCSyVMYjITYj4S+lDdN+gkRPxivXRtVUCZHQ/aA3v0g/i2Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Autocrypt:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Byu/Ivu2c/RQxf7NoTMxN/pvEQ2Ryga8K2B0J0WdHLg=;
	b=hNNK/OW2EsJDCZerxcgl6sBRjbOuaNTDtnUnxXweK3XjWm0g0ZGLehi9ljDbODURb01I
	 EJwXSJqMUSxPPSOqLs79rbeoTIeiWXiVx5pe6VqUdLKsy7miIzP3IZnIjeuMMv9VRoJlZ
	 tuTBYLJvKU20BBjOvSLmSsAnNPzzNKO+atpVE1l99m7/OdGRr5vZ3LvdsFt3pNvL6vmap
	 fzAbBrcYKJaYPIdNrawwdTahyHBBXrIa+5hmlBOk18H3VpwktOWMXnUF24wR8r3l/uyok
	 h8Fe0aiYktpn3UPnCqnW2r8x6v13sjX4ttFcl7NQY+T9nVzSZoUrTqP2K4fCrhhxzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LH4HKIAq;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C27606A31F
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 19:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C27606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LH4HKIAq
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1180631a91.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792955942; x=1793560742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Byu/Ivu2c/RQxf7NoTMxN/pvEQ2Ryga8K2B0J0WdHLg=;
        b=LH4HKIAq454DMkN8kSv0tkEn9xxcxcTgd+1RD3rzi+LVJ+JIHhmN5APLQ2qeOX9Y1+
         A2ikD5jD/Xwn240gmnW1fFkgYMPwcRlH0BvKQlf6eT2guHs8JDP3NXgoUZuf8VHDRE9g
         OzOqai3e1cxE390XkqXg/MUQBgXwETteJz7ydewtXGtUL3/Zl8nGOSVeLMjg/jDy3i9X
         O2w4OXOpFVPWlzQ02RvLZKeCCDI2YiqyAtynpl5Y2uQMVFjyLks92v5k7lyWUa5BKzsH
         wYgiVAXWAK8M7+4swsFnPDq+OIDUA/YHXaTbVk1ccKbsyo41GpPQ2G28upANRBZp4Uv4
         IYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792955942; x=1793560742;
        h=content-transfer-encoding:content-type:cc:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Byu/Ivu2c/RQxf7NoTMxN/pvEQ2Ryga8K2B0J0WdHLg=;
        b=AMFIIPL6j4SGpEnq2RhghvRAVKXKaBePoB/IUKqSOcJaVL/IyVRdl5dHuTQ2CnmPYd
         1FS7nprEwlKCINl1pUHjR64QoVOJiJaV6ysfih07OQKr/tGY3D/foGdSzR2UlvMhQL+q
         HnHc4M3GR5yA6teL7Oe6gcnFrB4wnR/mTAp1Zw7R4C6H7e7uLfrFx39unf5PryEyGyTL
         OfKX4JpDjjW5VQ9lbaYLXKSeCFqhLYAEmAV+6Ga0Q72Sm8hCukkmdMqtwMiS7avWWjYV
         A31o/eDWMWMbXFL4htFSGgzubomv4RfKTisgiiQhzRoJSNjYWnpLLFv6Xdjz2tUbfSdk
         8mhw==
X-Gm-Message-State: AFq9FYLW7XCodkdFU6vr1vMXQCAgsGtfOPzWjQObgvD7gNkXOItONXUz
	eUNMlRXyYLGTPOW/IvELLM0HT8p6+sPDOTgXGOw+xEtWBWh7RNBuG7QZq2rmLg==
X-Gm-Gg: AYBFou1p3e0j+RbIy3ndU5RMgeUl9bpo0J36sjJ/iw9YJ7onzhpd2mDXBl1OvUX/DS6
	88lr392Afavq1hVC1do+Rf6Bb6XrbU4OmbllNPPVb8pEpw/DZ3JX5mlBXgQrJ5rYvsJ6pXatOVk
	soM/sH35iqW4cLdOH7i7KRbrD7WhFCsF/VThZsER9+SmNZUrDep+188Cr13bzc8WmVqjONXBgpC
	1JxAiVtzMp+ZEm1NN89iCnXPbXA5iZa4uCqgLR0eHefwyWtckxI7w0r0qndp7u01AgSU5Ya+/xh
	ItUnX8ew7LgHtAU67x0rXDnA1lS/NOinEOvOF4JSBSOWpZZ2syLBBl5REJ9awuqudLLupUG13gN
	nzH4yE3n7qHDTFWP7ckshdSt8KLoKbhOYPmFUCdwaVSvLVS/e0foqgu+HI/IBHHiW0D0YS82NGO
	guU6Xg/ij3E1LYf/n3pGiQxRd6Rb1v7b4ZaT0NMnz+vqEl0IMxoW9sZD6COHzjRM26brtUeR5l7
	F7t3h+JOhNdJ/O0HdgAnQgJkhmhGWS6K6zEtlcc2tM/2mXxe1DbbiAZlfVCo+n2t4/CMOBjT0Ip
	Z3HgAvR9MvTBvOfUlOzP3NxBCMU8Zg==
X-Received: by 2002:a17:90b:2646:b0:3ac:9a03:20bc with SMTP id 98e67ed59e1d1-3adeae6db08mr4191584a91.47.1792955941713;
        Sun, 25 Oct 2026 12:19:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca7casm5711641a91.4.2026.10.25.12.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 12:19:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <49da816c-8082-46f1-bb12-f0d6187bb06a@roeck-us.net>
Date: Sun, 25 Oct 2026 12:18:59 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Tinyconfig build failures in v6.6.y and v6.12.y due to "srcu: Use
 irq_work to start GP in tiny SRCU"
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I see lots of tinyconfig build failures in v6.6.y and v6.12.y.
Current release candidates are also affected.

Example from v6.12.y:

Building csky:tinyconfig ... failed
--------------
Error log:
/opt/kernel/gcc-14.4.0-2.47-nolibc/csky-linux/bin/csky-linux-ld: kernel/rcu/srcutiny.o: in function `cleanup_srcu_struct':
srcutiny.c:(.text+0x2a): undefined reference to `irq_work_sync'
/opt/kernel/gcc-14.4.0-2.47-nolibc/csky-linux/bin/csky-linux-ld: kernel/rcu/srcutiny.o: in function `srcu_gp_start_if_needed':
srcutiny.c:(.text+0x60): undefined reference to `irq_work_queue'
/opt/kernel/gcc-14.4.0-2.47-nolibc/csky-linux/bin/csky-linux-ld: kernel/rcu/srcutiny.o: in function `start_poll_synchronize_srcu':
srcutiny.c:(.text+0xb8): undefined reference to `irq_work_sync'
/opt/kernel/gcc-14.4.0-2.47-nolibc/csky-linux/bin/csky-linux-ld: srcutiny.c:(.text+0xc8): undefined reference to `irq_work_queue'
make[3]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1

Bisect points to commit 58dd6e92725f ("srcu: Use irq_work to start GP in tiny SRCU")
in v6.12.y. Reverting this commit fixes the problem.

Problem is that IRQ_WORK is not enabled with tinyconfig in v6.6.y
and v6.12.y. In later kernels it is enabled due to the unrelated
commit af92793e52c3a ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") which adds "select IRQ_WORK" to "config SLUB".

Adding "select IRQ_WORK" to "config TINY_SRCU" also fixes the build
problem, but I don't know if that is an acceptable / desirable solution.
If so, it should probably be added to the mainline kernel since the code
only builds there accidentally. I'll leave that up to RCU and stable
release maintainers to decide.

Bisect log is attached for reference.

Thanks,
Guenter

---
# bad: [9fb48106e91d81010e61a7fa0b09aa6081ff1a2f] Linux 6.12.114-rc2
# good: [7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e] Linux 6.12.113
git bisect start 'HEAD' 'v6.12.113'
# bad: [fbf5bbbfe00526982e83b55a3aebed9096503646] netfs: Clean up some whitespace in trace header
git bisect bad fbf5bbbfe00526982e83b55a3aebed9096503646
# good: [27d90b6cd0a460f1f3a9678ef45312b803a0ccb5] mpls: Add mpls_route_input().
git bisect good 27d90b6cd0a460f1f3a9678ef45312b803a0ccb5
# bad: [86baeb912a990effd375019875fcf39fdabf56b5] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
git bisect bad 86baeb912a990effd375019875fcf39fdabf56b5
# bad: [78543c82d93b6bb10c7d6527138b7c99ecb2c2c3] net: stmmac: fix oops when split header is enabled
git bisect bad 78543c82d93b6bb10c7d6527138b7c99ecb2c2c3
# bad: [5c95382ad671b086e361c5bb94678754512bfc59] media: chips-media: wave5: Fix Null reference while testing fluster
git bisect bad 5c95382ad671b086e361c5bb94678754512bfc59
# good: [4e2cee549890df21dc0d06f9bbc2df98e8dbc60b] irqwork: Move data struct to a types header
git bisect good 4e2cee549890df21dc0d06f9bbc2df98e8dbc60b
# bad: [568deb5ecc2624ea189ecda36162962725bd6827] wifi: iwlwifi: fix 22000 series SMEM parsing
git bisect bad 568deb5ecc2624ea189ecda36162962725bd6827
# bad: [d0b39dc7649b68bdeaa17c71c76d58eab59a35c7] btrfs: fix zero size inode with non-zero size after log replay
git bisect bad d0b39dc7649b68bdeaa17c71c76d58eab59a35c7
# bad: [7dabc9bec015ccad262d8cc37e8c00328f555691] btrfs: tree-log: don't use token set/get accessors in fill_inode_item(
)
git bisect bad 7dabc9bec015ccad262d8cc37e8c00328f555691
# bad: [58dd6e92725f9afc375ccb11d3ef04fab0a4b4af] srcu: Use irq_work to start GP in tiny SRCU
git bisect bad 58dd6e92725f9afc375ccb11d3ef04fab0a4b4af
# first bad commit: [58dd6e92725f9afc375ccb11d3ef04fab0a4b4af] srcu: Use irq_work to start GP in tiny SRCU

