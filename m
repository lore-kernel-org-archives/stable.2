Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082391;
	b=m/Z6brzJyY40ITuFh2/IV0w76FS9on5ixXQU2JlK/jRw9HBbaDvWDMXywN/V7IA0fkqm
	 SPrTbyBiNsf9BUjyhiZlAU2VKG845n3qYkT8DHvHyQObK7Pd4O1j2jHpXBguoUDquhl9N
	 +t05AZK5Kb43CenpcvHrxHV8cvaJ1alBIJ/zuwHQrlqZKXf4AjpB2MhGLemuA7+S5h7DE
	 /r4GO7rC2AcYUfWtaNPopY1OMt5BB0v4xUcD+fJXzudEWF04HWi7LMvfq8t4dVTFFIUim
	 WI9Mai0SogEdTzsBmE0+kWXorFLTHqfEhX+TpbEWrlXZy/WFPS//k7Z67/FyalIW6kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082391;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=40XBrj6ej0YXePVzHhKmtc1I2QrMmp0ldPmTPQTm2Hs=;
	b=P/2qPQcsuFdO4Y7kUxEkCl8yq47n7c/VxJUzTjRlS8HA1A40uD/FKmSfjoPSGfpODHRw
	 P0GHSOvIl1fW9DIjPGT+dMKYw8y/cVgzGsfpnXSQ/LA9dOVGobd9geoACGtSmnKPZO+sE
	 H35bwWG7hyLFuC5KmSipPDfrOs2aZAsuOwnB5syLGJdvpAPtmyBrCLN01bED/xkDPCqPb
	 YZO0rBLSN4kdCEJAyNbFolqWviQnFiVYDPfh/+f8txyM/NhaZBU6ksHlg7gK3i9Y3YqWL
	 0KLJgcx1LT/q9UL4mNT66uHegirudTkPhp7OTXR6uvWQJlWQWrU+SqvsPHn+QdB4lvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=sAICyc07;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF0606A324;
	Thu, 19 Nov 2026 09:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDF0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=sAICyc07
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795082381; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=40XBrj6ej0YXePVzHhKmtc1I2QrMmp0ldPmTPQTm2Hs=;
	b=sAICyc077UcTCUAaLmgiJ/iGYd8G03i7MunfiPiQRtnA4f7wj7PRXe5fxPPpkSM+jqHbNQ8TCltKT9Uz++yl/WddoQ67XsYaCfA+a5WKy1/oH2iebi7sSSEog1w4LmZwiovRi1CAbhfezmH0XD2xKpHPS3Fj0QzLtwnlCQGhSL8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04792612|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00993389-0.000208522-0.989858;FP=16627843036400666137|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.k5ij0aX_1795082378;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k5ij0aX_1795082378 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 17:59:39 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: netdev-bot+sinfo@kernel.org
Cc: fangxy@xiaopeng.com,
	chandrashekar.devegowda@intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	netdev@vger.kernel.org,
	haijun.liu@mediatek.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linqj@xiaopeng.com
Subject: Re: [PATCH net] net: wwan: t7xx: validate PIT data offset before skb_reserve
Date: Thu, 19 Nov 2026 17:59:33 +0800
Message-ID: <20261119095933.41076-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179506943682.3291.10326179398413921657@kernel.org>
References: <179506943682.3291.10326179398413921657@kernel.org>
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

It has now been reproduced with a fault-injection harness in a
KASAN-enabled QEMU guest. No t7xx hardware is available, so the
harness synthesizes a malformed PIT and calls
t7xx_dpmaif_set_data_to_skb() directly; this is a synthetic trigger,
not a natural one.

With a PIT data address 128 bytes below the BAT DMA base, the int
offset becomes -128. The existing tail+length check passes because
the unsigned tail wraps, skb_reserve() then moves skb->data 64 bytes
before skb->head, and reading the payload triggers:

  BUG: KASAN: slab-out-of-bounds in t7xx15_harness_run+0xa4f/0xda0 [mtk_t7xx]
  Read of size 1 at addr ff11000002095340 by task insmod/67
  Call Trace:
   <TASK>
   dump_stack_lvl+0x55/0x70
   print_report+0x10d/0x5d0
   kasan_report+0x96/0xd0
   t7xx15_harness_run+0xa4f/0xda0 [mtk_t7xx]
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
  The buggy address belongs to the object at ff11000002095040
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 64 bytes to the right of
   allocated 704-byte region [ff11000002095040, ff11000002095300)

The read address matches the corrupted skb->data (skb->head - 64).
A second case, where the u64 address difference narrows to a small
positive int, is also accepted by the unpatched code. With this
patch applied, both inputs are rejected with -ENOBUFS and no KASAN
report is produced.
