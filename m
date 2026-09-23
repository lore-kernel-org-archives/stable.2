Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150613A3E73
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153351; cv=none; b=nJhuxAwp0PYCThFtm+YiNmWC5gvXs1QmO+EwpzENrk+0XLWP67sCc3ANBkQMhkbZiBe439Glvh9u218pHW+MTzj3kAKP8v4sjC5GAX7CJB/ghNwu5x2SC2c3sWdI/r2akQJR1tfWDt2ak65igHsIF74xho0KKuEzlgMh7xkyjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153351; c=relaxed/simple;
	bh=Inq5ZC2DcB/hR4v3l7r99Ns4RFfhInYkCXOVY7h5+4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kD99S/SO0N90nRVz4upsYU0BoABSt+XvD+paf1fwVAs2I3PGW/n3qDMOJPjAMDqHHvl8N/cc04ztDFbA+QlBCZ7L6nE5YlowZCybWKrdFxwSsRGpe3W/LC/WrIvZf3n9vL5JssugPRu7a4uLdBqgcxIj1P1D/vuEFsfTG68VKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ65Mx41; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ65Mx41"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed444so73439a91.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790153349; x=1790758149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25isk1T9lTeDXVlEdSd6pc8v7VoCNNgnnsyxaz1TEbg=;
        b=hZ65Mx41sOXB/ABAXsccOutY2S0mWJevFjJVhxk3OQMKd+Ptgv4IsHLrsCx1TdfBue
         5npFBEi48sbmMt6SfuzcY1Li42DkhWiHrr0yv0ttUhTz1GzLvIrvNn5YchMnlLrWEGsP
         W336zBgV+PzqNJgwbU6Z5RW2BJzj54jlFGI59JVNDR19pA4/l7dp8PuhZHNPF7UqlHFy
         fm5eB9SqGX84pGaqMLUtn/AUE1BzqMshAQQs3g3xhNBtL3Npnj35cqOb0Umx1MkrCC+p
         GFTPlAJkbOizePksiU4Hg7c4MOeOlQ7lhsQ0usJGJxk5v0cT8fHpsleS/upH15qPVLkj
         JZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153349; x=1790758149;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25isk1T9lTeDXVlEdSd6pc8v7VoCNNgnnsyxaz1TEbg=;
        b=uchdFkyBdtDKJ4705drP46Z1UKLYgac8D2iCn9sxoAlGjTswsmfz6hX4XHm4G0jBTJ
         Za2mgL8kitZYilh0anLyaZ/ckXAdjh23NsmOu4f5+10Kn00u9/oLEdullf1DTMffy7EW
         zUF+y16jFUMK/Mz0GRuAdRZK0Xbss4t3Z/ahj7STVgIA+sYoeyFqzaymy9IFk21dOI+7
         PPxpHpq9SM3jgkTtDGLjZfgu5VuVKN6UHfzIYXDjHcrBTkNg7yMlQtg94DjWRmgHpvmE
         Q1FqVOhxWOeK0nmrN+O04cPy9NVqLbi2NlCUBa5jtwG0zMz5PU4ihpLa1qvyNFIgfe/J
         kQ2A==
X-Gm-Message-State: AFuF++lOk9bPvZSkCFqwkMilMHEhFI6gYsNclV9qxxn+RK3N7rQoapJb
	TBDyTBnXHx2N01aFW9xIIDbGVEBLVG1Ol2/ReBNleZ5A4V0zlzz/FPdE
X-Gm-Gg: AYBFou0pmFRAIEF1YKf12JNtp0MF1ArMeVy6E+TWjasoj94XSrKtNgLiGrq7T1raV6D
	jiYhFfwoIu8ana0DGtYS0P+k7Ii5r/gbpCDfU0w1m6pEtKnO5PHd/r22Z7UEc9Y2QWcTflDDs8+
	fD3ATftr1ucqrNKSJNBmKKkJyYjXmon4aUq31OkWxiPRznNyptn9pLW4a6a1NVkd5HS4LV6+mme
	B/NzhnLGYl02Z0Wok4bel7acadCakdDRMOMOItRHoZta7KY3UwczAd03kkZBFJKu6M9fkPfvJYt
	PeanRPXCy96H2TGw5/q/DX8QhTnFZrV3Kb5XKG60iFje7l5X8qpfrXeiRhUEjqKm5k+/YSnk49M
	u6z8eaebQTYmOhUDhuUVHgODcJWPn36TSiBhtkugDdAVEXqV+B7HYUb0Br9dB3xpolOImid/NAc
	Z+VNEPxnJc1vZlc4ZEUql/xwn2JC3GL3H1uYwM+LoEFuzbPZR523JKgzlYWA3Z0OdE87UZuScPp
	ZSYieVH7USOqwBDULzp+4Ks
X-Received: by 2002:a17:90b:4b12:b0:39d:eda6:89fa with SMTP id 98e67ed59e1d1-3a07e54ba3amr2796408a91.1.1790153349313;
        Wed, 23 Sep 2026 01:49:09 -0700 (PDT)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc74977sm4041315a91.17.2026.09.23.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:49:08 -0700 (PDT)
From: Wenwu Hou <hwenwur@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com,
	guochunhai@vivo.com,
	yinxin.x@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: [PATCH stable] erofs: fix large folio race in erofs_fscache_req_complete
Date: Wed, 23 Sep 2026 16:48:23 +0800
Message-ID: <20260923084823.496741-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch is for stable only. Commit c37460cd9b2fc ("erofs: remove fscache
backend entirely") upstream removed this code.

xas_for_each() iteration can race with reclamation of an unlocked large
folio and splitting of its replacement shadow entry. Fix this by
advancing past the entire folio before unlocking it.

For example:
CPU A: EROFS completion               Other CPUs
----------------------------------   -----------------------------------
Find F at index 0.
Mark F uptodate.
Unlock F.

                                     Reclaim F.
                                     Replace indices 0–3 with a
                                     multi-index workingset shadow.

                                     Another reader inserts a smaller
                                     folio, e.g. order-0 at index 0.
                                     Split the large shadow entry:
                                       index 0: new folio
                                       index 1: shadow
                                       index 2: shadow
                                       index 3: shadow
Find a shadow at index 1.
folio_mark_uptodate(folio).

This can cause a kernel panic such as:
[1030374.432778] [     C31] BUG: unable to handle page fault for address: 00001846af017b01
[1030374.432971] [     C31] #PF: supervisor write access in kernel mode
[1030374.432973] [     C31] #PF: error_code(0x0002) - not-present page
[1030374.433543] [     C31] PGD 5a44f75067 P4D 5a44f75067 PUD 0
[1030374.433546] [     C31] Oops: 0002 [#1] PREEMPT SMP NOPTI
[1030374.433549] [     C31] CPU: 31 PID: 2425624 Comm: node Kdump: loaded Tainted: G           OE K    6.6.88-****
[1030374.434154] [     C31] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS ?-20260421_110423-CN.l65g09119.cloud.sqa.na131 04/01/2014
[1030374.434156] [     C31] RIP: 0010:erofs_fscache_req_complete+0xc1/0x1a0 [erofs]
[1030374.434764] [     C31] Code: 17 c5 c3 48 89 c7 48 85 c0 0f 84 af 00 00 00 48 81 ff 06 04 00 00 74 1b 48 81 ff 02 04 00 00 0f 84 b9 00 00 00 66 85 ed 75 04 <f0> 80 0f 08 e8 96 04 24 c3 48 8b 54 24 18 f6 c2 03 0f 95 c0 48 85
[1030374.435044] [     C31] RSP: 0000:ffffb8f2fc973cc0 EFLAGS: 00010046
[1030374.435641] [     C31]
[1030374.435642] [     C31] RAX: 00001846af017b01 RBX: 000000000000000f RCX: 0000000000000001
[1030374.436885] [     C31] RDX: 000000000000000c RSI: ffffa02ab337d468 RDI: 00001846af017b01
[1030374.437127] [     C31] RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000002
[1030374.437672] [     C31] R10: 0000000000000005 R11: 0000000000000191 R12: ffffa0060ec72300
[1030374.437673] [     C31] R13: 0000000008000000 R14: ffffffffc11b1990 R15: 0000000000007000
[1030374.437677] [     C31] FS:  00007f4928cdec80(0000) GS:ffffa07dc5f80000(0000) knlGS:0000000000000000
[1030374.437678] [     C31] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1030374.437680] [     C31] CR2: 00001846af017b01 CR3: 00000063d5356006 CR4: 0000000000770ee0
[1030374.437681] [     C31] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[1030374.437682] [     C31] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[1030374.437684] [     C31] PKRU: 55555558
[1030374.437684] [     C31] Call Trace:
[1030374.437687] [     C31]  <TASK>
[1030374.437692] [     C31]  erofs_fscache_req_put+0x27/0x40 [erofs]
[1030374.438900] [     C31]  cachefiles_read_complete+0x48/0x110 [cachefiles]
[1030374.440448] [     C31]  iomap_dio_bio_end_io+0x128/0x160
[1030374.440456] [     C31]  ? __pfx_stripe_end_io+0x10/0x10 [dm_mod]
[1030374.440950] [     C31]  clone_endio+0x123/0x1f0 [dm_mod]
[1030374.441550] [     C31]  blk_mq_end_request_batch+0xf4/0x440
[1030374.441556] [     C31]  ? nohz_balancer_kick+0x31/0x270
[1030374.441561] [     C31]  ? dma_direct_unmap_sg+0x48/0x1d0
[1030374.441565] [     C31]  ? dma_pool_free+0x22/0x60
[1030374.441569] [     C31]  ? nvme_pci_complete_batch+0xaf/0xc0 [nvme]
[1030374.442070] [     C31]  nvme_irq+0x6e/0x80 [nvme]
[1030374.442422] [     C31]  ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
[1030374.442428] [     C31]  __handle_irq_event_percpu+0x46/0x1a0
[1030374.442431] [     C31]  handle_irq_event+0x37/0x80
[1030374.442433] [     C31]  handle_edge_irq+0x93/0x240
[1030374.442436] [     C31]  __common_interrupt+0x3b/0xa0
[1030374.442441] [     C31]  common_interrupt+0x3f/0xa0
[1030374.442446] [     C31]  asm_common_interrupt+0x22/0x40

Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
For stable branches: 5.19.y, 6.0.y–6.19.y, and 7.0.y.

 fs/erofs/fscache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb57..fbf49f90bec12 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -67,6 +67,8 @@ static void erofs_fscache_req_complete(struct erofs_fscache_rq *req)
 			continue;
 		if (!failed)
 			folio_mark_uptodate(folio);
+		/* Skip the entire folio before unlocking allows it to be split. */
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		folio_unlock(folio);
 	}
 	rcu_read_unlock();
-- 
2.43.0

