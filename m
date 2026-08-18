Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AD17BED0
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053209; cv=none; b=ZQ3CEunzMW+Z9VlSwuXorQFV522TwmcdZ2wR3D8jBmZqdYcGgoWROB+dlaqE97wyzn+ITI+FN91V2jZJMzNyRq4fSotu1Bjfl8ne4UwimUzi9k0Ql5JJCHI1lpP7yJ9qx5jd5G3Jq3XugTdeC4uCE1VoFsTd2wsQtSb8e1rVT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053209; c=relaxed/simple;
	bh=ayXa1HjRcltgoJkDVPk8cfmiiwmqyIVAVKZE14EvQp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cmGm7on7a237XfX6sGWjsUDztr4mzuiV1SYUDUk+4JgbALPp5ExnWstRhM/glFn3WwxsUusiFRquzItSg4AfYt43gh+gfkErwHPoH5QuESjEO74OFEoX679yDK0TLb/LxfnuoZpHljXjGF8Io/XKocseL8bvvRiMCFvVHFw06jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddKP+Y4J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddKP+Y4J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40EFAC19425;
	Tue, 18 Aug 2026 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787053209;
	bh=ayXa1HjRcltgoJkDVPk8cfmiiwmqyIVAVKZE14EvQp0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ddKP+Y4JuwQN1hdFLS1FKPVEvSu71jXwAr5TYdWSx4BgVmpj6lykDPMXGNuOEhBk/
	 gBhtC7EGWwS2bJX+NiqtJ75Xe3wxnZpXsd9DPsbc2eFzNcGBHlNNuVqwlNrVY6fmAx
	 81VRRykuJPUX/u3bVojQqG9VAs7nXJ4o9XCbYfvvpiG2Hc+u2NKuJ7og06b7UXzvol
	 +RtDBDgDHZB+mKxAslKqQdS1Fu1d60+K0q79eyPPMPp2uNKdKPcczeSurtYPME1FQp
	 i8QsUPc0dwg3Qe/7Fi/FehoOCB8oRSWrUYliktFXF1LiOiqsyp/U8OPeibC79qcHD8
	 qYj3u6i50XCuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D88AC5DF7D;
	Tue, 18 Aug 2026 11:40:09 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Tue, 18 Aug 2026 19:40:05 +0800
Subject: [PATCH 5.15.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-origin-linux-5-15-y-v1-1-aa5e9c007ce2@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJREhGoC/x3MSwqAMAwA0atI1kbaSKt4FXHhJ9aAVGlRFPHuF
 pdvMfNA5CAcockeCHxKlM0n6DyDcem9Y5QpGUiRVRWVuAVx4nEVf1xoUBu8kWhSNTFTNVhI5R5
 4luu/tmAKbYobuvf9ADSLJ0VtAAAA
X-Change-ID: 20260723-origin-linux-5-15-y-22d082ee27b6
To: stable@vger.kernel.org
Cc: jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, 
 JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787053208; l=3662;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=ndlZKDrxIhS1a2CAth8teODEBWhWS51oqIvWDYaKJBQ=;
 b=M1rbhdWglSELNl89qEU7/AuhshczWFzt50ceH/FdBC/1b0su5Rc2nFywLksTy3/0/P2UcBlWk
 pWMyzpW+JmMAw46afZGSX6fei7jjOUhxeK6ppfB4r7o1fkOGnI2ypYM
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reply-To: jiucheng.xu@amlogic.com

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.

As JY reported in bugzilla [1],

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : [0xffffffe51d249484] f2fs_is_cp_guaranteed+0x70/0x98
lr : [0xffffffe51d24adbc] f2fs_merge_page_bio+0x520/0x6d4
CPU: 3 UID: 0 PID: 6790 Comm: kworker/u16:3 Tainted: P    B   W  OE      6.12.30-android16-5-maybe-dirty-4k #1 5f7701c9cbf727d1eebe77c89bbbeb3371e895e5
Tainted: [P]=PROPRIETARY_MODULE, [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Workqueue: writeback wb_workfn (flush-254:49)
Call trace:
 f2fs_is_cp_guaranteed+0x70/0x98
 f2fs_inplace_write_data+0x174/0x2f4
 f2fs_do_write_data_page+0x214/0x81c
 f2fs_write_single_data_page+0x28c/0x764
 f2fs_write_data_pages+0x78c/0xce4
 do_writepages+0xe8/0x2fc
 __writeback_single_inode+0x4c/0x4b4
 writeback_sb_inodes+0x314/0x540
 __writeback_inodes_wb+0xa4/0xf4
 wb_writeback+0x160/0x448
 wb_workfn+0x2f0/0x5dc
 process_scheduled_works+0x1c8/0x458
 worker_thread+0x334/0x3f0
 kthread+0x118/0x1ac
 ret_from_fork+0x10/0x20

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220575

The panic was caused by UAF issue w/ below race condition:

kworker
- writepages
 - f2fs_write_cache_pages
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #1 into bio & cache bio in
        io->bio_list
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #2 into bio which is linked
        in io->bio_list
						write
						- f2fs_write_begin
						: write page #1
						 - f2fs_folio_wait_writeback
						  - f2fs_submit_merged_ipu_write
						   - f2fs_submit_write_bio
						   : submit bio which inclues page #1 and #2

						software IRQ
						- f2fs_write_end_io
						 - fscrypt_free_bounce_page
						 : freed bounced page which belongs to page #2
      - inc_page_count( , WB_DATA_TYPE(data_folio), false)
      : data_folio points to fio->encrypted_page
        the bounced page can be freed before
        accessing it in f2fs_is_cp_guarantee()

It can reproduce w/ below testcase:
Run below script in shell #1:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

Run below script in shell #2:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

So, in f2fs_merge_page_bio(), let's avoid using fio->encrypted_page after
commit page into internal ipu cache.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Reported-by: JY <JY.Ho@mediatek.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c74b27eba94b1e7ae2c07407b159d58f3a1f28e7..90cb8560af1d0ac0df2fe25cad34817ffd978be2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -926,7 +926,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;

---
base-commit: aabd761612dbeb7d40750d485da219d11433718a
change-id: 20260723-origin-linux-5-15-y-22d082ee27b6

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>


