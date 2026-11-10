Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272794;
	b=SlTXnWFh/Ozkoy5Dm6ks3WM0y6n8x/HLoAuCTNn/QoR6+MZHRFMDBmprwsWEFyIcCgON
	 h5AxLPrgx3IyA0TXYtPvurduqkne4BarmCaRT89DES/HiJeTD+AuLbVgdIGeOwpgM/89A
	 EsYa+MnviPDwxncK6JVFUwOI9A+q2KMGoApRy2O8i9mpQc9grNEMoOyfGcIBQ4xa+pO6w
	 hFqpi3Q4kNPFPEpJRcgo/HPRZy//JYqcCgwQT9UrC0Ib3t0mpTCa8ZQnCCTuZC+uiWr9h
	 WxwZUx2hf9Fk8mxh9+wlAKTpMjgUnkL0VoYdIk66JOg85P+gQwxjqQ9DrsOHSiWIGuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2Z9oRNT4ZBqj8WyrasRckXSqHG5I7GGRuGHekQdAtfk=;
	b=rQMZGTGAzeIWGoCCGFSwye+0Ny/YzIeoUpjaX1/gdvDr/mxnFPOnCI1yjd+oEnNqjKMU
	 zrdZl9XlEO7Nd9AFddBpxqMvbncXsJAKj2BIZoh3QoX5iM6GWyNKooW80f3mLUKo59qQG
	 dHvvbSM0uRytzQpsrQ/6zVPUYUZdFpQKPm6vl1f7MqznLw+NrWOnO3F7INE1ye4Ot1wvZ
	 TEOUbFPk6GCDE2jiLa4Zdox7n7B+jbb7yyPiaDA/W+EN6JqCOGGWHw9BD9tIJEmIM1ztc
	 cm44nzDCyR4uTIF32jvONieYJgRgxHpwSxQhWTFcPs6qo7IVrxACnfcCB7rPs7u9G2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcqQ+qrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcqQ+qrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11021F0089F;
	Tue, 10 Nov 2026 01:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272794;
	bh=2Z9oRNT4ZBqj8WyrasRckXSqHG5I7GGRuGHekQdAtfk=;
	h=From:To:Cc:Subject:Date;
	b=bcqQ+qrjcASp7RqwXVQ36ZAvhB+QpAHZ0IBKCJZMrvaNgP9suVcVfbauPcs+pvzKz
	 Q/rgZ1KUEWzzRKvXz9hZtwaxBlI5S9RjFH/SJjlarNELH8urQaQKP4GCjlt/zgE1Vj
	 x72ptQBfTqCtG1soGNW0JYKjk6REk1QWT43tdNk1yHyxOHR1Fqx/JZM+YOg0FD06mp
	 ieQM7/n8N0KBgbwhH/emp52BGrSzhLV1C0jrlKI2/h763qC+7/RPi2ZfQcWWZEc6ch
	 aiEGjSMLBvMjN11U9v2oyFssML7jbW4fmfSL5FlAG8walVSgCTnqzgNEOuPOuIQTwm
	 x10K3aXhDy+KA==
From: Sasha Levin <sashal@kernel.org>
To: guolingxing@tju.edu.cn,
	wqu@suse.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] btrfs: prevent deleting the wrong subvolume by ID" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:32 -0500
Message-ID: <20261109200632-failed-6.12-1960146913b3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1960146913b31b288ed2cd607d103ee3b41681d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200632-failed-6.12-1960146913b3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1960146913b31b288ed2cd607d103ee3b41681d4 Mon Sep 17 00:00:00 2001
From: guolingxing <guolingxing@tju.edu.cn>
Date: Sun, 18 Oct 2026 15:38:10 +0000
Subject: [PATCH] btrfs: prevent deleting the wrong subvolume by ID

When deleting a subvolume by ID, btrfs_ioctl_snap_destroy() first
resolves the requested ID to a name, then looks up that name again
under the parent directory lock.

A concurrent rename can change which subvolume is associated with
the name between these operations. Since the deletion path does not
verify the ID of the resolved subvolume, it can delete a different
subvolume while leaving the requested one intact.

This was reproduced by repeatedly exchanging the names of two
subvolumes using renameat2(RENAME_EXCHANGE) while deleting one of
them by ID. The wrong subvolume was deleted in 9 out of 14 independent
tests.

Fix this by checking that the resolved subvolume ID matches the
requested ID while holding the parent directory lock. Return -EAGAIN
on a mismatch so that userspace can retry the operation instead of
being told that the requested subvolume does not exist.

Fixes: 949964c92843 ("btrfs: add new BTRFS_IOC_SNAP_DESTROY_V2 ioctl")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: guolingxing <guolingxing@tju.edu.cn>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 43a945345cbe1..847fdc19bd402 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2393,6 +2393,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    btrfs_root_id(dest) != vol_args2->subvolid) {
+		ret = -EAGAIN;
+		goto out_end_removing;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0




