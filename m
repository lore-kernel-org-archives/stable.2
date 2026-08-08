Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7834DF6C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204136; cv=none; b=ABLvloGzTXDfXHdrnswFJ+PggxXerVCQGSz6tL5dg2IY2KG6IKk0hYZzgj64gDrd85+tn43iUS6EqqsG3Kn80/vYxI1cSQpGVBfIvces8i4C7+Qa75QBn3ySTLQc+ClgvVSQ16qvM82ZONcjlBdkXualC+GVuWxPQq62OaQtUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204136; c=relaxed/simple;
	bh=FDbw3OFrdAvlezkDoUJkDlamDnEw78FJu9KE1TW+YFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMEZpKJZ29eczTpH49EQS1TI748OLC72fUyQYpVEUJbVjUlRoiLp1HgdVnYefUfJSKmnqMh+CH+bNQwOmANXyIoaEgMC+Ksgk7OWlpu7h7RJ7SMigUPr9t/XtrjZn2dozM7wGEf8NWzLK/vxqKdAOprbrDMw7x9lIO9ANrMPjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIaSvsr8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIaSvsr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C021F00A3A;
	Sat,  8 Aug 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204135;
	bh=EVhKFlYCdpCwMkhpE8jpfnq9Zpt8pUm25yZCnNVvNpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XIaSvsr87RM9k7ftxO3WZJSgjVESUaSUnjtgVPFPB6IFghn30vsALSwPhw6JQXRpJ
	 zNo/hXdqamFMMeiifRCKz6LyGnIDF9+eDjzDYOn/WBXoW9kY3sW5tMVib0GT/Uro9i
	 54R0cBMaNL8H8NFXtZKMG0NfmKx/xGOnDrCBMukXz52oLcEb1tI6KLRrAeAX+hFkno
	 JYmDrRD7SAV0Y6BpUICg0RI+yr8ZgIm52YXytM6oHrs5H+lqIgA4hYVR4j3FZawe6p
	 kTvxXTBWdvFXJdn8hknaTrnvVZPFzkfyJvrT5dBqZYWRC3ZFnyA1ufB02AcsVzHIWM
	 nyWSyd44aWbdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] super: skip dying superblocks early
Date: Sat,  8 Aug 2026 11:48:48 -0400
Message-ID: <20260808154852.370323-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808154852.370323-1-sashal@kernel.org>
References: <2026072927-mom-flyover-909f@gregkh>
 <20260808154852.370323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 6920e3388ba4c66b0468d43bb7a373f5fff15d35 ]

Make all iterators uniform by performing an early check whether the
superblock is dying.

Link: https://lore.kernel.org/r/20250329-work-freeze-v2-3-a47af37ecc3d@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 749d7aa0377a ("super: fix emergency thaw deadlock on frozen block devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 5aabfcab4fc7d..f1714752e439b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -925,6 +925,9 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		bool locked;
 
+		if (super_flags(sb, SB_DYING))
+			continue;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
@@ -962,6 +965,9 @@ void iterate_supers_type(struct file_system_type *type,
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
 		bool locked;
 
+		if (super_flags(sb, SB_DYING))
+			continue;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-- 
2.53.0

