Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E14BF921
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107522; cv=none; b=Tp6OAXhSNG32tl9YfNXVgBYtJrUCIpNugxTXaTJYjOYO/ZpD67k8pZmIym3r7P0nRGW2t7MmK0rsYHltEoye69pwdAhVy4vRhNa8UqhRdzC7r15gUnCPdfU57ng6jK0w6oTCs4U/bZXpCPCJzZrhJVQvW36jdXhzGE04hfXIfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107522; c=relaxed/simple;
	bh=bFw02r6jaNHaixJWkVpkqw5kzInfhX7ALGYlfWx0JxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KugTb9qa6Y7eiAM6c6S0OMjl/XKNbN6byZPiE+vZUkTJIVElRV3KWoZRy7/a0xrh2onOmnGCl2CMBZmg+hxrMnPR8+K78/xn5h8ClmoSyZC7X7cJpwqqRsoFgYddyhynUDrkKUU30cDa5zZO4MdFsLcZ+mDy45nZZb2/KeajrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QBsn78Bg; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QBsn78Bg"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd05d97cso336631c88.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790107493; x=1790712293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uyRungl+NqmtYNgL/8dH71XCYpq6TtSAT/snP5PAQEU=;
        b=QBsn78BgjpJcmnggRqdiZ7VA86NmropjefaQcSEznCpE+jZdF0E8ppUsN7K5CbRgo/
         eJS6dp1tvQ4Blg81vhRdNxEp5Rp5V+6KlMu4CkdbolgDEoTrwxQzMmEth1OYSLDrEzDt
         1tcqlL2pwI2O0fZzM13BBwL1U0nvBhCNTsQf3FlbmvMWg7O2mvIc2AaXeSfCttefzLj8
         cAwtB33TG21cmyKWUvwxliR89HDKTgJL71dowMlM5+L7j/oMfuf3sZH1jjpGzo4lq7HP
         rmxcVQjGuHu9BlQXu5ySRMHRlYyc5x08J/TKoDeYirVbtNcOlQukJPmVC4s35rDEUMh0
         e/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107493; x=1790712293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uyRungl+NqmtYNgL/8dH71XCYpq6TtSAT/snP5PAQEU=;
        b=153cO6quk4RpceR6iJ6z12AaIvA1Ur7XLEp/u5OTAXMdrFO6K0J2QlXDtWsy6QoOHx
         qcjKhlfCOh28GC1jdnnV5XCX9cCZHyCLvTBIT5TLyUsUXU7AdyhYWY7t6ggNSe+4FjW7
         Mp7Es5UMywTZ58XS9rY9bWsHCCaAW2v6yuNlBPMEJT+AaEAIhfYZo+IO1TaEj19xPUZF
         AxldOGD/LdWTy62ltxLM7xwMmlOXOz2I0EUDuXYR8ExElkHOKtelWf8qalQ3O4igV4Hf
         iQHuQvOKaI4Eac8lg/KngTg/zBRZSIWovBql6VMyj8usyLcTeSJ1w29jn/dwJcskzToV
         4GHw==
X-Gm-Message-State: AFuF++lC4wPBb08ZEeH5KZ9AAoCCIdEsiYDstibklHwD0V5/19bpROG9
	YL3GkIXBTNRgDoiDUTReZck3QAQb2SgJT/2TlNJ/1Eo+Qcj9h/FKSAx2MEvprA6bv7WdXuwhLgW
	MEPBF4Nw=
X-Gm-Gg: AYBFou1dUnIvDO28SycGK4hYpEpdMtafgAwE4bSP/GFRvM1yhwoCwnhsi81MJIxC0r7
	jBUf+hKf9iqN+oS3mkxnkScWYmv9UqSpvOR21iM3OwbFGwYvOzj/fkEoJh39PJdlTBiEsFTzmVM
	0C63rUOcbN+NxlHEOcNk3QnbfWfXIh6qMXhIjx/k6Hm/kZERiXA5ku0pa09BoahoRdnp7irxk3I
	8MCor1A5by09AB5urUTk1sBlF/Tt+UAsQx8hc4N9AUbRE/zweZe+oIk1y/24oUHSR68zLpkV/g6
	CBX/4ppPtdQ3XB+L/Ngk91PqCb0qJ1adBqyKLHp2QwzjELa5Ls7RAPL2GifaCSBIFo5gFUsdEEB
	iNgUh3zb1aaXrNW8uWYyRdg6X84fLm3chDSNCI1PpnWpOxNMeYxi88PNsPvWsiqV+8eTEkST/o+
	OfWilGc0n8us99y0m0bimoS7DwknSx5H7is1vgfUMIsEOCHiRK/5BZTUgKSUnfdFTG6QFbNwCMA
	uOIfiwGQkgPm41KBt25BCMYksSq/Tbykw4+AfV2wdN+ctxSd75WcNVD8Qa6HdQq+SSo6Dw=
X-Received: by 2002:a05:7022:3a08:b0:143:4710:a84e with SMTP id a92af1059eb24-144f9186b23mr505519c88.15.1790107493262;
        Tue, 22 Sep 2026 13:04:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm852614c88.7.2026.09.22.13.04.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 13:04:52 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Will Shiu <Will.Shiu@mediatek.com>
Subject: [PATCH 6.1.y] erofs: Fix detection of atomic context
Date: Tue, 22 Sep 2026 16:04:36 -0400
Message-ID: <20260922200448.27724-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandeep Dhavale <dhavale@google.com>

[ Upstream commit 12d0a24afd9ea58e581ea64d64e066f2027b28d9 ]

Current check for atomic context is not sufficient as
z_erofs_decompressqueue_endio can be called under rcu lock
from blk_mq_flush_plug_list(). See the stacktrace [1]

In such case we should hand off the decompression work for async
processing rather than trying to do sync decompression in current
context. Patch fixes the detection by checking for
rcu_read_lock_any_held() and while at it use more appropriate
!in_task() check than in_atomic().

Background: Historically erofs would always schedule a kworker for
decompression which would incur the scheduling cost regardless of
the context. But z_erofs_decompressqueue_endio() may not always
be in atomic context and we could actually benefit from doing the
decompression in z_erofs_decompressqueue_endio() if we are in
thread context, for example when running with dm-verity.
This optimization was later added in patch [2] which has shown
improvement in performance benchmarks.

==============================================
[1] Problem stacktrace
[name:core&]BUG: sleeping function called from invalid context at kernel/locking/mutex.c:291
[name:core&]in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
[name:core&]preempt_count: 0, expected: 0
[name:core&]RCU nest depth: 1, expected: 0
CPU: 7 PID: 1615 Comm: CpuMonitorServi Tainted: G S      W  OE      6.1.25-android14-5-maybe-dirty-mainline #1
Hardware name: MT6897 (DT)
Call trace:
 dump_backtrace+0x108/0x15c
 show_stack+0x20/0x30
 dump_stack_lvl+0x6c/0x8c
 dump_stack+0x20/0x48
 __might_resched+0x1fc/0x308
 __might_sleep+0x50/0x88
 mutex_lock+0x2c/0x110
 z_erofs_decompress_queue+0x11c/0xc10
 z_erofs_decompress_kickoff+0x110/0x1a4
 z_erofs_decompressqueue_endio+0x154/0x180
 bio_endio+0x1b0/0x1d8
 __dm_io_complete+0x22c/0x280
 clone_endio+0xe4/0x280
 bio_endio+0x1b0/0x1d8
 blk_update_request+0x138/0x3a4
 blk_mq_plug_issue_direct+0xd4/0x19c
 blk_mq_flush_plug_list+0x2b0/0x354
 __blk_flush_plug+0x110/0x160
 blk_finish_plug+0x30/0x4c
 read_pages+0x2fc/0x370
 page_cache_ra_unbounded+0xa4/0x23c
 page_cache_ra_order+0x290/0x320
 do_sync_mmap_readahead+0x108/0x2c0
 filemap_fault+0x19c/0x52c
 __do_fault+0xc4/0x114
 handle_mm_fault+0x5b4/0x1168
 do_page_fault+0x338/0x4b4
 do_translation_fault+0x40/0x60
 do_mem_abort+0x60/0xc8
 el0_da+0x4c/0xe0
 el0t_64_sync_handler+0xd4/0xfc
 el0t_64_sync+0x1a0/0x1a4

[2] Link: https://lore.kernel.org/all/20210317035448.13921-1-huangjianan@oppo.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://lore.kernel.org/r/20230621220848.3379029-1-dhavale@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Backport to 6.1.y: the source change is unchanged; only its location
  in z_erofs_decompress_kickoff() differs. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and EROFS maintainers,

I am continuing backporting CVE fixes still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53231

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 66c323cbdd73e1..49b7c77488415a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1271,7 +1271,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
 	/* Use workqueue and sync decompression for atomic contexts only */
-	if (in_atomic() || irqs_disabled()) {
+	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
 		/* enable sync decompression for readahead */
 		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
-- 
2.39.5

