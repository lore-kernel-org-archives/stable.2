Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794119252;
	b=nke+9D5nX0V+3vfpTRxQyg4vm+y4vIFIYfxfn9JWibFcyhbuz2xGqNsumyYgx1rhYsXV
	 341LcYTjO1jMIp1YveROR9q/+RnYlp4xrYCdzu4Bq9K++n6CnWW7bOiMIWWOOv52fuxr1
	 zThv/6GZ4V7ot7z8sxopcurMmGP85tkfK4cSrfPDp1piBO33h4APPeKKeABYcV9/PaW7m
	 zCJ4OMVvrKgWPFg+7yhyvdULsPioIO/FbMyTBtgx4rxO0ijkPbhpn29fL/Rg9QBl75E4j
	 BctIVZ+vgEtNzim9muTDwV8BN1RvrwkcChY0Z40u854wJJT5x3PEsjJZw4GB252ft/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794119252;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pSY+VxPFlCMt//V68AJbYH6L3nbsVs9zToOlbvaVAWQ=;
	b=ORXmRf81KN/cl39SMMVOS2dv59Nk0h0wHpUXAqIGpLfIRcSn5I+3bjDLPI7c9xQ7xW7N
	 knUKso8UpvrGVoJh3Ppkbr3e1j93ZsDkw/66fCtP5OqAzeTGiBWDmidurbo6JR2nMkYfV
	 ErwBOgahQjIrViHZKkg0mK/VhyY5CahTGWjH4Gh9arpCFENwmGHIMWRHBvAxLuyRr8PLb
	 6WtP+Z4p3vCtKjbLg9BBLSN13TXAZQzMUCds9IqQpwsLC/nnYZ+atjRloCo79RH44gLuS
	 StwUnt6ltaM9N3vJUrfPh1uz4xWF6M8rK2fBKY8CvtFm54N4EkjaTzbPzpfLF+FQz2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B0606A31A;
	Sun,  8 Nov 2026 06:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jMjd60Y6sz5BNS0;
	Sun, 08 Nov 2026 14:27:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A86RF1u056768;
	Sun, 8 Nov 2026 14:27:15 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 8 Nov 2026 14:27:17 +0800 (CST)
X-Zmail-TransId: 2af96af016453fa-26b09
X-Mailer: Zmail v1.0
Message-ID: <20261108142717400jIBOCPqLH4K8NFVss_YdS@zte.com.cn>
In-Reply-To: <bc095bd8-ee9f-4bab-8333-8f2333b2590a@kernel.org>
References: 20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn,DMP795RB75PQ.1XIZ1QUJ51Y0H@nvidia.com,bc095bd8-ee9f-4bab-8333-8f2333b2590a@kernel.org
Date: Sun, 8 Nov 2026 14:27:17 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <david@kernel.org>
Cc: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>,
        <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
        <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW0vbWlncmF0ZTogZml4IHNvZnRsb2NrdXAgaW4gZG9fcGFnZXNfbW92ZSgpIHdpdGggaHVnZSBwYWdlIGFycmF5cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A86RF1u056768
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 08 Nov 2026 14:27:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF0164A.000/4jMjd60Y6sz5BNS0

On Sat, Nov 07, 2026 at 08:11:22PM +0100, David Hildenbrand wrote:
> Right, and I'd like to see an actual reproducer, because we sure have a bunch of
> cond_resched() already in migration code.

The existing cond_resched() calls are in migrate_hugetlbs(),
migrate_folios_move() and migrate_pages_batch().  All three only run when the
pagelist is non-empty, i.e. after add_folio_for_migration() has isolated a
folio.  For an array of addresses that are already on the target node,
add_folio_for_migration() returns 0, the folio is never queued, and
move_pages_and_store_status() returns at its list_empty() check.  The loop
body (two get_user(), mmap_read_lock()/unlock(), folio walk, put_user())
therefore runs without a voluntary preemption point on PREEMPT_NONE.

I reproduced it on 6.6.60, x86_64, CONFIG_PREEMPT_NONE=y, CONFIG_NUMA=y,
under QEMU TCG (no KVM, 2 vCPUs, 3 GiB; I do not have a bare-metal
machine that can still select PREEMPT_NONE).  move_pages() with 50 million
entries pointing at one page, all already on node 0, keeps CPU#1 in
kernel_move_pages() for 42.9 s and trips the watchdog:

  watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [init:1]
  RIP: 0010:kernel_move_pages+0x424/0x820
  Call Trace:
   <IRQ>
   ? watchdog_timer_fn+0x1ad/0x210
   </IRQ>
   <TASK>
   ? kernel_move_pages+0x424/0x820
   __x64_sys_move_pages+0x24/0x30
   entry_SYSCALL_64_after_hwframe+0x78/0xe2

(do_pages_move() is inlined into kernel_move_pages() in this build; it is
followed by an rcu_sched self-detected stall on the same CPU.)

With this patch applied to the same tree and the same initramfs, the same
50M-entry call completes in 44.3 s with no softlockup and no RCU stall
(ret=0, all status entries 0).

The 10M figure in the v1 changelog is from the do_pages_stat() report (6.6-based
arm64 with KASAN and function tracing).  Without that instrumentation this
TCG guest needs about 50M entries to stay in the loop for 20 s; 10M finishes
in 8.5 s here.  Same code path, only the machine speed and instrumentation
differ.

I will send a v2 that only describes this reproduction in the changelog and
keeps the code as is, the same treatment 8e934ab44389 got for do_pages_stat().
If you would rather not carry this in mm at all, say so and I will withdraw
it; a stable-only submission would also fit the reachability.

Thanks,
Shao
