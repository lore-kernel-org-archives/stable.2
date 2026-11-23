Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477194;
	b=mxnI532ObZ0qgx77CAKb9JgdK74IwOfESumBAhmxA+33cFl7LoWzNKw5ZJxiyjAY+Zpp
	 d0ORj2df6Z+N92PU70MdthWC6Ji+1bo883Z1U0cbeyIAMoFGkY3S53FZRhHqJ0I7EmtE3
	 S2Z+YmEv5nE4fM2wU9x/mY7BA3ggsnybBshBkEr0rs7b5bcr3KU/Lz9BB+GyHEeXKN2EL
	 u6ZGsCWMrq3j3Khr2ktTztiHyz6bJgB+jmBHOqkr9PB8UFj4v+kIf0FDF6e+sKL9vbaGU
	 ImIswzwwqiPnUA6CjzTI2i8KJYAQTaXedAZ2HNNAnFuUzkmzlvnyImKz8zOSJzSAXag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477194;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GQphScNATQHHldgFgEcB68heOuz1yKCUAO9uOSn7l/E=;
	b=shMrdllPTn2ZAej1UaGZHVO/S4fY3MRMxAJghEOs+kEjGHhOyVfnz0RFfuYtlING26ET
	 3XfGMItT85M3BBy6PPnUPYJPPxmDEBrQu8ZdbFu06t8SokSWpjHCWLKCBPO5gFwqJfufa
	 oVTnAoGgjkWdy8I4WlrDRxQ9LbqN1qEK50hnqkYgvs4PpCHDWDEne1psjTTiG3FdM4NpV
	 L/dhvsHj82bpCFICtFEpHfRXXz8roWb/eZGh6vKp0uKNn30bAsnDRFCanXzJBf41J8HIe
	 9lvxFaEWwQiERyOCIBLni5XazX+pTLhD8dx0AE+BP19AVd1nswIHylLE9bFDycavOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DF42BqXj;
	arc=none smtp.remote-ip=115.124.28.99
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4466606A6A6;
	Mon, 23 Nov 2026 23:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4466606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DF42BqXj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795477184; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GQphScNATQHHldgFgEcB68heOuz1yKCUAO9uOSn7l/E=;
	b=DF42BqXjUdPkQLpCBC5CtznPLQOQTUGHZFL+h9zdNSlL6hvmVlslfN2+9T1AN8aFdDyCTn01AiPsF1WML9OU6BY/VLNjO8yXZfYpN2nLf8gomaaJ81EJwf/NpjftDJjfcJgDzuaDaf7lVgxjUQ6+KfVReX0uCoKs9I54yL5Uzsw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04998161|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00557952-0.000104749-0.994316;FP=12015874423884973311|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032112;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.k8dSJk7_1795477180;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k8dSJk7_1795477180 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 07:39:42 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: netdev-bot+sinfo@kernel.org
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	netdev@vger.kernel.org,
	Liu Haijun <haijun.liu@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lin Qiaojie <linqj@xiaopeng.com>
Subject: Re: [PATCH net v2] net: wwan: t7xx: validate PIT data before building RX skb
Date: Tue, 24 Nov 2026 07:39:36 +0800
Message-ID: <20261123233936.51601-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179545421789.3294.8652562780118952990@kernel.org>
References: <20261123171519.33975-1-fangxy@xiaopeng.com> <179545421789.3294.8652562780118952990@kernel.org>
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

The issue was found during a security review of the t7xx driver's
device-supplied input paths, assisted by the Hawkeye agent
(LLM-based code analysis).

It is reproduced at runtime, not only theoretical. No t7xx hardware
is available, so a fault-injection harness in a KASAN-enabled QEMU
guest synthesizes malformed PIT entries and drives the RX assembly
paths; this is a synthetic trigger, not a natural one.

On the normal path, a PIT data address 128 bytes below the BAT DMA
base yields an int offset of -128. The unpatched code accepts it,
skb_reserve() moves skb->data before skb->head, and reading the
payload triggers:

  BUG: KASAN: slab-out-of-bounds in t7xx15_harness_run+0x1a5e/0x2340 [mtk_t7xx]
  Read of size 1 at addr ff110000013bd000 by task insmod/71
  Call Trace:
   <TASK>
   dump_stack_lvl+0x55/0x70
   print_report+0x10d/0x5d0
   kasan_report+0x96/0xd0
   t7xx15_harness_run+0x1a5e/0x2340 [mtk_t7xx]
   t7xx_pci_init+0x9/0xff0 [mtk_t7xx]
   do_one_initcall+0x84/0x350
   do_init_module+0x29d/0x800
   load_module+0x510c/0x6630
   init_module_from_file+0x15d/0x180
   idempotent_init_module+0x320/0x670
   __x64_sys_finit_module+0xbd/0x120
   do_syscall_64+0xee/0x500
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  The buggy address belongs to the object at ff110000013bcd00
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 64 bytes to the right of
   allocated 704-byte region [ff110000013bcd00, ff110000013bcfc0)

A second input, where the u64 address difference narrows to a small
positive int, is also accepted by the unpatched code. On the
fragment path, a negative offset likewise reaches the page copy and
faults on an unmapped address. With this patch applied, all of
these inputs are rejected (-ENOBUFS on the normal path, -EINVAL on
the fragment path) and no KASAN report or fault is produced.
