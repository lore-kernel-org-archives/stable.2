Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF33CFF6B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899895; cv=none; b=GQDZx4E2BIRuj2jIKpA/yq6EnQ4IhXkaj6dWV9svh/79LUEtVSfFjMUPBJ/NEsu8Xc2Wx3/8F+3/C+QK//PQ7l7l0s0q5r+N08pbkJw0g+9Qo7QOPImP0ZnJQE7xdt2JSw2yqJuINOMSpU4GOJlQvj8kkpeHwiIfiOSpP8RHXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899895; c=relaxed/simple;
	bh=ZC0B4txhFUgeUlk6OIyXjRB4N3NNCI6s0AAGNybQk9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U99aGx23wZA5Wbarwn1fBWyT6B51wWrapfPtP9cZGYcfi0YlR01frTzYHx5bn8WVPecfbBLqQlPZlYrsGihvFh1ItbM9iL2XeSAPrkOiIkMosQF0tFRgUyu0gVKbmstLu4sm8vxZb5UiPLFa1jdnLJ84GAyfb6YeGTML1S0gnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR1bzfhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR1bzfhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECAC1F000FF;
	Tue, 13 Oct 2026 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899894;
	bh=bziEosZ6KfD3wivmWOFyzquSMTXBjZiayxzR/dlJHZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZR1bzfhD5JcyQymGXz2MVL9WJIoJF1KKBSjMPRxgR1Oslf2pDrEg9sIr8ACUXytzQ
	 jPrGyrKLP8jo9JmmzJ5e6OqqTYlYQH/ZM+p1jau7yFeX8YntajALw5IXh9JJv3i69h
	 XdSDL4s5u80XprbRgLd35ujT8OI4J76AYE1vr6qiIP+q2VqfULqo1+HsMVeWdAdrr1
	 ryKQ5+yKvIDeaIqfcPbsI9StGwwz9evl8LHdVBQK7UJxkLiO+eoJN/4seI3+1NDfKO
	 zsDkZfDlGjqVOlKEgCMs1gsLfpFEAixpDxDEjp0GBuo09vuXPd69A4Q4H4crOnrrt8
	 sQnqZrL8XE+pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] dm-integrity: fix NULL pointer dereference when the 'R' flag is used
Date: Tue, 13 Oct 2026 09:58:11 -0400
Message-ID: <20261013135651.3952606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101259-length-disaster-0090@gregkh>
References: <2026101259-length-disaster-0090@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 7d4d4f3b668d708d94f62ecdd33ac330a6fd8a84 ]

If the dm-integrity device has the SB_FLAG_DIRTY_BITMAP flag set and the
user activates the device in the 'R' mode, a crash in dm_integrity_resume
happens because the function attempts to read the journal containing the
bitmap.

This patch makes dm-integrity skip any writes to the device in
dm_integrity_resume if the device is activated in the 'R' mode.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 468dfca38b1a ("dm integrity: add a bitmap mode")
Cc: stable@vger.kernel.org
Stable-dep-of: fc79aeb86a2c ("dm-integrity: validate the superblock on resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4bda7b5dba1a6..cded0607b39c0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3874,6 +3874,10 @@ static void dm_integrity_resume(struct dm_target *ti)
 	r = sync_rw_sb(ic, REQ_OP_READ);
 	if (r)
 		dm_integrity_io_error(ic, "reading superblock", r);
+
+	if (ic->mode == 'R')
+		goto skip_writes;
+
 	if ((ic->sb->flags & flags) != flags) {
 		ic->sb->flags |= flags;
 		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
@@ -3983,6 +3987,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 		}
 	}
 
+skip_writes:
 	ic->reboot_notifier.notifier_call = dm_integrity_reboot;
 	ic->reboot_notifier.next = NULL;
 	ic->reboot_notifier.priority = INT_MAX - 1;	/* be notified after md and before hardware drivers */
-- 
2.53.0

