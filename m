Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915265;
	b=vCR6bjM3axzTAIZ+EantkgzzGjZZRy29zjVHsGv7VVat2DAJ6zveFId2QLzlog6zPWx9
	 A1gWVtPFFM0/TTeSt0rAbzHjML0qaZb6LjYMv7j1BPbcin+TdMIGisAyCnoEDwbCkOOP7
	 V5IugVmiXd9OLMlmXui4NuUNvvJzvhdaKSX7Gj7XMEweluRnax+NDWVHjCa+DIlrQMLjA
	 rXQxEdxCeuG0clCi9bB9blIVkJ/nODzVPvIToXOv2jPd/3auBbcktKZ9Lc5xBfRWHh0nx
	 5bu7/HsldiHa/HpG26AfhyZ0Mt4mFf/9QmmK+TQQBy3tX9Z4TzH2f3rUKR7Tg2ngs1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+K9CkvCA3OlKWwDUexCGkgRgdQU4VGZAviFEBkAbsLE=;
	b=HNRjS6hu0bQ0pDNakheLNsJVMiFkaOKXVzORMxCJd3BsgnU2VkjCCKVs/8dW6+XVzXLN
	 ctX6Nz65gq4OfHMETyObZDMuAIGQvhFctCsguuKDbm9txdXdSksmg0GD/ttoQjQv3b57b
	 +iBlZBy8PCpMbOu0oHpeOnT/cWnpIS+WF4YRK/pUFpox1rIA1sTrN+mC2ZlLeel9BfPfE
	 P7w6zD1tzna4nCS4at3Wd4E0jy6r0EFBSLg5br+Sgvps46RBJwCWVThCBPGbtTwQ3KKTo
	 b09CNp67ERqVbpaHqq5h7QIf8BHwyYZPCvpChJNly0iyZMbRflX3LxvAq4x2ZCyb9HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b="Z9a1I/jm";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B5606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9B5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=Z9a1I/jm
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so4588994eec.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793915263; x=1794520063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+K9CkvCA3OlKWwDUexCGkgRgdQU4VGZAviFEBkAbsLE=;
        b=Z9a1I/jmFxNeUeUMG5LUHf/SWNFUaPxyJpqZGpvhk0TR5g3UJxn35EnGJaVT9sbauG
         2bMbPnmCUqUZM7T8IICk1hMr2xn/Cgabulq89zLANoNiM48w01W0pk1kWYX6p2iwB0bS
         uVNrPvPXYdMeqvqnXrn2DpjfTIFyX+CfanC0djo7yHmMnD0unVt1fjMJDokKHHJV9nHS
         aLHs5rEtcO0GeUWXRgon0hfoxXO7mGtsIB7d5Nw5jfrX9oHHL2koD9v/3i6VpHqzPznG
         0WCAJkjrqegQmmruJSMAgxzLp7KPZsmYfcYY/IPsoFusGhcvYoGsVD5uwxvPNSIA86oD
         VEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915263; x=1794520063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+K9CkvCA3OlKWwDUexCGkgRgdQU4VGZAviFEBkAbsLE=;
        b=CVAVUlWbAoi+7WueGE8pFsKg2UamiFd/A1TmOIBJnwnEoIwY9bSZ2GeB45t4IU3Rg9
         /0p8F3NHjWhWtYZ2zr5Vk7843F7zJGs8Y4110lZpYhXdpR3svJCVcxrozBwA+yekt2np
         LmWkV8l/oEhG0pGOKLlPLMkYLoX0uPGAOlVhvgEKwNmVvS+vS7b/hp6kBD4DRBrlzFp2
         WvzQCSVBb+8k1Rx+dbpwK/WWjqcVCbwMoQLtSSrVTnItrdF1jXYBGe6AxxD1bkSAOgRQ
         u0LFkDSGwUstsxdNhlSmxZFNxqknlesKubz+ca2BtPQRLbirw9V73e8+2mYTQDPkPheH
         35tA==
X-Forwarded-Encrypted: i=1; AKwUvBx9ns40K8R+DsSL9YjCOky5dvdXAvXEY6/WUbfEgZiSQpQc9gMGBNLc4yjGrgNwdZDnx9Ck6/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QGQTKzGNqlrX63p0mLHtKWHd2VQN+qzTLoDBYpFM6lNByV6L8
	gXeaAMF/X6GzLH3apGKulGrE4kn9iLtLRlMr+3YtZNu2oWvB9U9yu2hsOKUa3pxqTg==
X-Gm-Gg: AYBFou2PSJZuwR1DkOxxJgvZfBdumwL5SdLgGM1MkXLtZVAU4oS4XpmguXcFkeimFRW
	LWdCpqLOEv6AiF1adzYhJGXPo0NDveXNdNQ0pqesmXZeo3kMsMTBL8tb9Vf/Xia52LlLzE0I0wL
	zochZksTQcQDv+j9J88XGzBybdny45vAvZr7NFLJr5d3vgMeNpM68rxgwfCsQGDHCuJriPyY0gb
	Z19FX2O+fl7K+V2n2+4hDlZtJ+i111o7hKOVajauskyr/0vdmDJieWjwWKot5vftUCt1plMklmm
	/ajv4vx2AS7pyUs+Ff3cCfel+Hk+kZ3J+EUyBK1J9EdON7FM+XhFCM6xRU6Cq3yUJHvKlAb7Ra9
	pUOFgCwOuhGQsLs1NYiqHd2/byS/GOXiINcL1be/cJwREVWhWg7TMVfWE8UUMJst4kTr5oR6iT+
	I3/CzzHg3r/Ust9qMio1muT/efMDBFQxia+R+8bYED+Y+m2xirp+uJ3jZo70uUTrEu3cVumE0Fq
	UYEZ+CQ2ArV46vZWbtxHWBDzcqv2a5JBWF4dkfBI4rG70CqP2mqdNgMPX6ZtRonXUkD5Z03MEDO
	ogDBegNHyVl0cQrPHdCjc2fvfsOClXR1COwe
X-Received: by 2002:a05:7300:f195:b0:369:f420:8679 with SMTP id 5a478bee46e88-36f784c065cmr803770eec.38.1793915263163;
        Thu, 05 Nov 2026 13:47:43 -0800 (PST)
Received: from localhost.localdomain ([206.206.222.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f71a25c1asm2036943eec.27.2026.11.05.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:47:42 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: dsterba@suse.com
Cc: mason@kernel.org,
	josef@toxicpanda.com,
	wqu@suse.com,
	fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>,
	syzbot+dc9291cf132691aeb478@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] btrfs: overwrite a leftover balance item instead of BUG_ON()
Date: Thu,  5 Nov 2026 14:47:37 -0700
Message-ID: <20261105214738.111967-2-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105214738.111967-1-smish149@asu.edu>
References: <20261105214738.111967-1-smish149@asu.edu>
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

[BUG]
A balance ioctl can hit this BUG_ON():

  kernel BUG at fs/btrfs/volumes.c:5088!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:btrfs_balance (fs/btrfs/volumes.c:5088)
  Call Trace:
   <TASK>
   btrfs_ioctl (fs/btrfs/ioctl.c:3523 fs/btrfs/ioctl.c:5650)
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe
   </TASK>

[CAUSE]
btrfs_balance() expects insert_balance_item() to return -EEXIST only
when a balance item is on disk, and a balance item to be on disk only
when fs_info->balance_ctl is set (a paused balance, or one recovered
at mount). So for a new balance it uses BUG_ON(ret == -EEXIST).

Both assumptions can be wrong:

- insert_balance_item() inserts the item, then commits the transaction.
  btrfs_commit_transaction() can fail without aborting the
  transaction, for example when btrfs_start_dirty_block_groups() fails
  to allocate a path. Then balance fails with -ENOMEM and
  balance_ctl is freed, but the item stays in the running transaction.
  The next balance ioctl finds the item and gets -EEXIST.

- When the transaction was aborted with -EEXIST, for example after
  "failed to run delayed ref ... -17" on a corrupted extent tree,
  btrfs_commit_transaction() returns the abort error, -EEXIST, and
  there is no balance item at all.

[FIX]
Mount turns any balance item on disk into a paused balance, so a new
balance can only find an item left by a balance of the same mount that
failed after inserting it.  No balance owns that item, so let a new
balance overwrite it, run, and delete it at the end as usual, as Filipe
suggested in [1].

For a resumed balance -EEXIST is the normal result.  Any other error,
including the -EEXIST of an aborted transaction for a new balance, now
goes to the existing error path.

The BUG_ON() checks on the return value go away, and the one on
fs_info->balance_ctl becomes an ASSERT().

Reported-by: syzbot+dc9291cf132691aeb478@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dc9291cf132691aeb478
Link: https://lore.kernel.org/linux-btrfs/ZNzE6CFOzu9kDG+G@debian0.Home/ [1]
Fixes: 1bbc621ef284 ("Btrfs: allow block group cache writeout outside critical section in commit")
Cc: stable@vger.kernel.org # 4.1+
Suggested-by: Filipe Manana <fdmanana@kernel.org>
Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d4ef6725..4a8e5078b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3998,6 +3998,8 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      sizeof(*item));
+	if (ret == -EEXIST && !(bctl->flags & BTRFS_BALANCE_RESUME))
+		ret = 0;
 	if (ret)
 		goto out;
 
@@ -5081,17 +5083,17 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = insert_balance_item(fs_info, bctl);
-	if (ret && ret != -EEXIST)
+	if (ret == -EEXIST && (bctl->flags & BTRFS_BALANCE_RESUME))
+		ret = 0;
+	if (ret)
 		goto out;
 
 	if (!(bctl->flags & BTRFS_BALANCE_RESUME)) {
-		BUG_ON(ret == -EEXIST);
-		BUG_ON(fs_info->balance_ctl);
+		ASSERT(!fs_info->balance_ctl);
 		spin_lock(&fs_info->balance_lock);
 		fs_info->balance_ctl = bctl;
 		spin_unlock(&fs_info->balance_lock);
 	} else {
-		BUG_ON(ret != -EEXIST);
 		spin_lock(&fs_info->balance_lock);
 		update_balance_args(bctl);
 		spin_unlock(&fs_info->balance_lock);
-- 
2.54.0

