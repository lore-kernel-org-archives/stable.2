Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BE3FC5B5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052518; cv=none; b=PyzHgD7sVkEtm4PtkK+lyWsjz2NvbS/4nOWkGISBfwvo+3uFjMiy+TRKgpfSc137ur47Cx7x2aDE7iv/csmkd2jYQWc/jy99Je6Hcf+vzrDzrTh5RlYpwelBEDbhaV3qrmk9x9BKfVLCoF09cqGnvBKxRpLQcJuioTMoaj3egYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052518; c=relaxed/simple;
	bh=/X8htDvxCmrlmUi9Y/jSkzERBb9zgKFHr5IIpk6svSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hXp4xUOTcnQFp3uzyEJUMU1v6dg7upYhCsES9kStfHnTH+GR/v3uSMl9apNpBlXCoURNeusizb35iLJruTjTbNJoC37ejSjBW/yMm/gS53DqxqX0Y6fUVItxr+uzYb/yX1n8r0Zo5/oQn3BZLrkQBF8HaZlwyifx+OwnzjrdUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4j5hihh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4j5hihh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE1B9C19425;
	Tue, 18 Aug 2026 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787052517;
	bh=/X8htDvxCmrlmUi9Y/jSkzERBb9zgKFHr5IIpk6svSk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=U4j5hihhDGWxQoKP/WNqVJQHdRC38K/qVIBKPYh3pKk5XET8YitGpD8MaDoXj5ynG
	 YaaHkRBOMpwojOjV+Wzli6Fu0NoVl5qzUi4MEBn5w4K3YOOpXpjM5DA3aUhEwYDWam
	 CksnTBJS/Lsdca+HdQopM9hgnwaiXVhKPT3epc0n2GzlVimKpKEKXwhiwjNzyA//NV
	 wq8gRq1aSipj0fVNoqdb7/LtXWT+qRLtRn/P8ytEMllOzzkLga7482URBZp4TOS523
	 aZT8Cp8sZwE0IC347FU5gFUF5iVqwZdmtAXizG/jQSoQ0/Z2KPo7Ej+d6C/reCaKwb
	 sDcBgrKzv0cCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7534C5DF7E;
	Tue, 18 Aug 2026 11:28:37 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Tue, 18 Aug 2026 19:28:34 +0800
Subject: [PATCH 6.6.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-origin-linux-6-6-y-v1-1-c110e632c7c4@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAOFBhGoC/x2MQQqAIBAAvxJ7bsUMVuor0cFqs4WwUIoi+nsSc
 5rDzAOJo3CCtngg8ilJtpClKgsYFxc8o0zZwWhD2poatyheAq4Sjgspc+PQDE1ljSZnHeRwjzz
 L9U87IEXqhv59P0XIk2NrAAAA
X-Change-ID: 20260723-origin-linux-6-6-y-b9b917206a7a
To: stable@vger.kernel.org
Cc: jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, 
 JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787052516; l=3675;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=tHV/sXq3oNteaRPQ0IIbC7iEUf3F0E3LO1C/eGzGNV4=;
 b=K+XCBPvsFforUNkppCi8VLFq1Z4lnQ/NtA+ijqY3OJFNi1C8MdTCFgN0g5XHAKi9PjC867tyQ
 sobqyJnQnGWCw5Sqy0ylGU0Ow5ILCFaa9KDHX2WsVsDXMuOv8mR2a/v
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
index af1438277575d88c55d44dc35f214380fffd48e8..d068111436d799d732c52df0846ea10258e0ad89 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -948,7 +948,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page, false));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;

---
base-commit: d27334b2888c10d2b60c954c59b186182d833107
change-id: 20260723-origin-linux-6-6-y-b9b917206a7a

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>


