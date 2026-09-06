Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0637DEA8
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711120; cv=none; b=UxgH4vy15ZPNMmbEcWa2UnUZXdy7KXh2LXaygH/npCKYk4MnhLoNAD/4ynF+FFHg0q+Mp6YEHgLSoqkquRraxE/2RbQN+Pc6Y7sL0XlrzNsLqfbLXb1WZmU8b9RjPw9CEsQv6wzJ6ky5ujX/epXKT+Ix/7GCNxNab8gvKiO5xCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711120; c=relaxed/simple;
	bh=jqneVVGVdSo8SnX0ZnT+ylumXDGHo3FW9PQxg5rfILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teKZmAgIEkJ0XBCiCkhdlzB8O5rCUioLg5sScLb/hxLCS1LjEBZdNb7WDcZV9iRLGOPcYciMDVYgGPzNrNOYMEbNt9DYEntI4L6KoWo61meqJfxNej3z3OFaTV4C1QDHuOv7AY9sxQKi/0xGPMdY0RhgTZQC8nzEbX7v/le8NCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wivd9kC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wivd9kC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462221F00A3E;
	Sun,  6 Sep 2026 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711118;
	bh=TMGku8m/5wCvkCKGfvWGeDVaXLwg4rpxUAar3XrZo1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wivd9kC8RGqDZLrDsOfa4ZUzijg8N7cCmUyl0vbU1eflSBpulAGeobWVkfA5GR+bX
	 0TblzFVi/X/rFjxw+Ib+BleKzO6zEDShWq06gkV9oMPtFh9oGkGhUQcXRXwDfk0awd
	 l0OSXYV7x5qJRgWVHBh6JX1Y6iXegnZPAQtMzQkcrDwXh14C9S/lXjiZQ8QbuN6FwW
	 xTUI5UMoOwRve06LYuZzgnKo8qjKRn2LnwKSfUxLlpCUE1Pe9R2f16kAGxgNe4dcjo
	 LKlIWpKHpMhNYFjx+dYTnjJLu8AOI2m6VQ5G5M78Dkpaj86U6Q/v5idx6xgfoS/wC6
	 zGk1R1n7xtonQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] btrfs: rename ret to ret2 in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 12:11:54 -0400
Message-ID: <20260906161156.1545411-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906161156.1545411-1-sashal@kernel.org>
References: <2026090359-float-gamma-d28d@gregkh>
 <20260906161156.1545411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit bd0d9a619a870f8c6745d2b4f57508bc5106e282 ]

A preparatory patch to rename 'err' to 'ret', but ret is already used as an
intermediary return value, so first rename 'ret' to 'ret2'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7034bbd007106..d5bb29d316346 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4221,7 +4221,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
+	int ret2;
 	int err = 0;
 
 	path = btrfs_alloc_path();
@@ -4356,9 +4356,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	}
 	err = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !err)
+		err = ret2;
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);
-- 
2.53.0

