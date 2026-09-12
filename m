Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13941F35E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211825; cv=none; b=D2FA+o3jx9MlI0vCmNOhs979esvJOdErW5h0c+Lm8QNdu2HFfPIPGgKehMR7pHHDACwibfWFfNkilK3HJQbVT5O4AFcSmwo/jFrMLqbzphk5GZkRmeFCR2TuNiq3Ow7YQ/qsa6ERPoiO5A7c/FBKsmK0wpNzUohnllhO2Npg51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211825; c=relaxed/simple;
	bh=U8i56jWFmR7fzFnXT/vskMPCZ+bQSzEy8e2MaIr4EuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no02S0DDIoA8JCSGUZ9L55EkK8eOus2P3gFPDg7ZyuS5yaK4q7XMJQqpzSIJJKxOQeml2saZUoq9+LyyMBwFUc6BcF1S8xMFD1LSkQmJ4LPodRdcXyutN5ohGZrTi0A+wICyu+C5oJRYocPnUTRcmUusUVsKHT4ASi/ioSrkRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILbqctjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILbqctjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7591F00898;
	Sat, 12 Sep 2026 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211824;
	bh=11ITM5L9JMmNAEk/dX56U6u1c+vALd8YMYIkFHekqu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILbqctjOr9HqWO0nhhO4WHJ8RxNzZmF3hiOmpQRt3eZRWRgFCBjizfMoILIclAdUH
	 dVpOQLvG0DDspNVjZzjcHkT1+UjFMPtMvRktRqCAzmvQrrrsBKewrFTtbU1LrWRrE8
	 xT5NQoTrp1r/rmFRxCxeQv6yq5FCDGv9nky5uN2m8C8qv6OJka6SeW58QvzKp6K2Qz
	 94jSaa2b6hRWm/qYZoSsEJTZA4+wMgEJtfp2Y/xdrjKFjroyZ5mzQqqgT+EZQLNkPN
	 UzWtHdXKa2uJguu6fd/qvnWXg5Z8j4r5gMP9PXJLlD6cs1OVwJq1PKkgO/i8FNF8EF
	 WuJwDv/Otu46w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] f2fs: delete f2fs_get_new_segment() declaration
Date: Sat, 12 Sep 2026 07:17:00 -0400
Message-ID: <20260912111702.2280721-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090947-hardwired-robust-7d28@gregkh>
References: <2026090947-hardwired-robust-7d28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit e24e8333d0f3110473c6e6a20afd51911984e901 ]

Commit 093749e296e2 ("f2fs: support age threshold based garbage
collection") added this declaration, but w/ definition, delete
it.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe17f10257371..09da1f3440a8b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3482,8 +3482,6 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
-- 
2.53.0

