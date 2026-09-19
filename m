Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47F364EB2
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807551; cv=none; b=cutcU/Cm6j+PzfnB6BncDdouqjGS94FnohSZOww0nppr0IWGJPTkBT8rzqM8nTQxiJj+U4Gsq/81Rndke9s0adoAOsqMEr/M3NCupT9s23AlzjW3Nqw1jefa5rr495zCuKSg99zSUI4Sqx7cGJfCgRFuH8FVQtyjpfZ63rB1YfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807551; c=relaxed/simple;
	bh=43gdm0Nnpkz3bJkYMRpVvXqQJooqOxG/D7hwUBNzYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyfdmr5XkGDJXxWAR6cES9HU1j9c9USdiw2bqgq67hv9xsb6L8Ykx9l2pUy3wwbTMguUbwjZG51TTEWPaNpsG8XbKU3DYsiB2HB51KLd0HEqoVvyHlb8s5Ls0H8YgJIq4NpxckKJLEPbwxPFrttJsG2NMktiIEcecr3DUCmMEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldmw6Ygv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldmw6Ygv"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso1260796a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807550; x=1790412350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZw6BN7peM6OKAlthhp4XpSn/Dy2zIL86nDdON0s4nU=;
        b=ldmw6YgvFt79yKXmkbtdavnsfeKbft/e6SeoVz4yLodESOiYfwbUhU+avPtRzukYUJ
         YJay3H6ID9HjJ3QeM1Cs7tKwXASUFcDAlTe976Q2DrQGCB+vFCav1DWRiffjE1tbnKls
         6rzd5HIMP6P7grxB97Lj29qLANc4fFw0AqV6hHA4S8PJ/JCCACMNYL9gGGDSJsqNDtj1
         S4RjOq+uYr076SnX0dZP3zWMuRzGsJz1bF7f87h9Tbal1pF/s0JMDKqhhE1GIqpM7QO7
         KfR1IbyBBB2gnCn2rLf9cl24LRHYrp0mB2kQLInpjoJiIZOxqtZN9bpAxUJVP9E4gPfP
         P3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807550; x=1790412350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZw6BN7peM6OKAlthhp4XpSn/Dy2zIL86nDdON0s4nU=;
        b=ppJWHgU1H9eIM9CyuO9m3pTYl30kq2QcHJOoTnoxTRkeOEh72La17Z2v/kxNeRbvR/
         prOhXhenHM+cG1cAJfy2Pp1kAQCPAOPHkGnZgQeA5N7fOOdu4KJdAJOqTEx75o1uihA6
         EiD5Fk1NQCW/Q2efEPJULEwQcX/bRk5Ow7GXC3zBdD9Y+LF49Qo05j0Lp1ZAv1AhTw38
         iYsgFTobroMdDPSoC5Hgauvy2MH/DxZYlca7U9v7cNdfo/ccrWJXQ6HY5+rcaF+BqOca
         mz1hQapmtYucsxRxdnV7qs1MQ5e/GbHtGTeyz8HnsotMU4J4RJ6X+RO0Z7K5hB03yeWI
         Fhxg==
X-Forwarded-Encrypted: i=1; AKwUvBz96B5sWvVebl1e6VEpqbpPrNK/7HtILNpOvOwMAr2WLIafkLzv3qatax/oWqolN7UMzoZapVg=@vger.kernel.org
X-Gm-Message-State: AFuF++kpKXNZXbe8z4GWnYsPdpYJDO11hFKX0B0FEB52752YEZk3+lH4
	PTuWW/w7cOrtE3H+j1RzvRbZ11RU1bEt331Up93jW8QtdesyPxsVKbvV
X-Gm-Gg: AYBFou3ABBE+SEUCQTQBo/2KWLK/JtvoE+8XnXDj4E11VBtdgACd/oRw3XsNNfzKg4w
	KbDMMK0gspm1ps9m9fwnmq5hbyZJv6gsmqNPFjKz2Ssa7LudWlVOUBY6+sfjZYkxhAs78ZaXkEC
	WlIB8zu3rQbaIb2O6wKwmm2uVk2N64TbJv3WTppoR+yIbdD7cSAwNZ+hu1eUJOIw+xCkZtfno4O
	pCU5ImECQcwo1WWwlURCvZy65l10lETbALAfDAO7fO17KerxN1eroZsiLA8mzrtoo0MHoSHoWpr
	XraHxtxri+RY71k/VpslM+PCWJ0QfNv8Wx8fiobDJxnCI66Z8lqp8a8jFYSJV8X5l0/FMgdNd6J
	y0EbRYpxs02v0zjpIEGhtM9+c/sb/hOXTmnsbqwvWWHBkYua6GT08YCibGtHuprYaQh4+uUIetQ
	dvlAXlFWxHWhfZz+4uAHvAYyEo6r1p/SDTzxM7gl2JxQg2eI0NNyFHqyAHgobAAvD1Yz2rsF+K9
	M6c6A5f04cMMtqLQ5ySwllFQn3zVr3AGoqqNStCHZJRsSqBvljXzJUJUlUhtcLWtlE3Fw==
X-Received: by 2002:a17:90b:4b86:b0:39e:21a7:5dfe with SMTP id 98e67ed59e1d1-39e54c5a1ecmr15157325a91.3.1789807549695;
        Sat, 19 Sep 2026 01:45:49 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm3346698a91.0.2026.09.19.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:45:47 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net 0/1] net: ipconfig: bound DHCP option construction
Date: Sat, 19 Sep 2026 16:45:26 +0800
Message-ID: <cover.1789798023.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/ipconfig.c.  Triggering it
requires control over the kernel command line (the ip= and dhcpclass=
boot parameters), so it is not reachable by an unprivileged user; a
root-controlled boot or a malicious boot configuration can still turn
it into a boot-time panic.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ic_dhcp_init_options() builds the DHCP options for a request inside the
fixed 312-byte bootp_pkt.exten[] buffer.  It writes the hostname
(option 12) and the vendor-class (option 60) options by appending
type/length/value bytes without checking how much room is left; only the
client-ID (option 61) branch looked at the remaining space.

The hostname comes from the ip= boot parameter (up to 64 bytes) and the
vendor-class from dhcpclass= (up to 252 bytes after strscpy).  Together
with the 18 bytes already emitted (magic cookie, message type and
parameter request list) they need 18 + (2 + 64) + (2 + 252) = 338 bytes,
more than the 312 available even before the terminating END marker
(255).  The vendor-class memcpy() therefore writes past the end of
exten[].  CONFIG_FORTIFY_SOURCE reports this as a field-spanning write
and, with panic_on_warn=1, the warning becomes a panic during boot.

The patch routes the three optional options through a common helper that
checks that the option, its 2-byte header and the END marker all fit,
and drops an option that does not fit.  The helper also rejects a length
that does not fit in the one-byte DHCP option length field.  With short
options the emitted bytes are unchanged.

Reproducer:

Build a kernel with CONFIG_IP_PNP=y, CONFIG_IP_PNP_DHCP=y,
CONFIG_IP_PNP_BOOTP=y and CONFIG_FORTIFY_SOURCE=y, then boot it in QEMU
with one NIC (e1000) and the crafted command line below.
ip_auto_config() runs from a late_initcall and builds the DHCPDISCOVER
packet before any server reply is needed, so no DHCP server is required.

  HOST=$(printf 'h%.0s' {1..64})
  CLASS=$(printf 'v%.0s' {1..252})
  qemu-system-x86_64 -m 2048 -smp 2 -nographic -no-reboot \
    -kernel arch/x86/boot/bzImage -initrd initramfs.cpio.gz \
    -append "console=ttyS0 panic_on_warn=1 oops=panic panic=1 \
             ip=::::${HOST}::dhcp dhcpclass=${CLASS}" \
    -nic user,model=e1000

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.  It is a
boot-time trigger: CONFIG_FORTIFY_SOURCE plus panic_on_warn=1 is what
turns the out-of-bounds write into the observed panic.

----BEGIN crash log----

[    2.349975] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    2.383902] Sending DHCP requests .
[    2.384513] DHCP: sending class identifier "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
[    2.385144] ------------[ cut here ]------------
[    2.385241] memcpy: detected field-spanning write (size 252) of single field "e" at net/ipv4/ipconfig.c:736 (size 226)
[    2.385345] WARNING: net/ipv4/ipconfig.c:736 at ip_auto_config+0x924/0x1120, CPU#0: swapper/0/1
[    2.387029] Modules linked in:
[    2.387710] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc3-00339-g6c096bb08de9 #1 PREEMPT(lazy) 
[    2.388052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[    2.388442] RIP: 0010:ip_auto_config+0x938/0x1120
[    2.388743] Code: 8d 4e 02 49 39 c7 73 35 4c 89 8d 50 ff ff ff 48 8d 3d bc 67 ac ff 48 c7 c2 a0 c0 4a 85 4c 89 f9 48 89 c6 48 89 85 58 ff ff ff <67> 48 0f b9 3a 4c 8b 8d 50 ff ff ff 48 8b 85 58 ff ff ff 48 c7 c6
[    2.389258] RSP: 0018:ffffb79f40013dd0 EFLAGS: 00010293
[    2.389478] RAX: 00000000000000fc RBX: ffff971101181000 RCX: 00000000000000e2
[    2.389664] RDX: ffffffff854ac0a0 RSI: 00000000000000fc RDI: ffffffff85913240
[    2.389847] RBP: ffffb79f40013e80 R08: 0000000000000000 R09: ffff971101dd316e
[    2.390026] R10: ffffb79f40013bc0 R11: ffffb79f40013bb8 R12: ffff971101d56000
[    2.390235] R13: ffff971101dd3010 R14: ffff971101dd316c R15: 00000000000000e2
[    2.390542] FS:  0000000000000000(0000) GS:ffff9711f7b6f000(0000) knlGS:0000000000000000
[    2.390755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.390910] CR2: ffff97111d555000 CR3: 000000001ca30000 CR4: 00000000000006f0
[    2.391206] Call Trace:
[    2.391913]  <TASK>
[    2.392196]  ? __pfx_ip_auto_config+0x10/0x10
[    2.392453]  ? do_one_initcall+0x84/0x3c0
[    2.392580]  do_one_initcall+0x84/0x3c0
[    2.392800]  kernel_init_freeable+0x202/0x260
[    2.392955]  ? __pfx_kernel_init+0x10/0x10
[    2.393086]  kernel_init+0x1a/0x130
[    2.393204]  ret_from_fork+0x177/0x240
[    2.393328]  ? __pfx_kernel_init+0x10/0x10
[    2.393551]  ret_from_fork_asm+0x1a/0x30
[    2.393711]  </TASK>

-----END crash log-----

With the patch applied the same command line boots without the
field-spanning warning and without a panic; a normal configuration with
short options still sends the class identifier as before.

Best regards,
Yuqi Xu


Yuqi Xu (1):
  net: ipconfig: bound DHCP option construction

 net/ipv4/ipconfig.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)


base-commit: 6c096bb08de97cdca051fecddad22cac6a1fd275
-- 
2.55.0

