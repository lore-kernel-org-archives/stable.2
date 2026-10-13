Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9D3F5BE3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902390; cv=none; b=keNYx3DTw4LqHeobILFvb+uszbmQaWqqb2sj0r1dHT0ZBvJ+/GJ52KBAVwPtSfaLYvzNDcUT4treY1JiH9TzB7pmkx8+eUEUGtKJCAzqvxaqUMnM4SEOUVOLiTLlJ5ypmbnaBXfCwFd3nSPuIsUxtRwIzbqBINz3nzICS/b+Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902390; c=relaxed/simple;
	bh=hKDpD60QyhzRnAp7wiX4EcjpKO6HUkuEN+YC0XVvdmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEoUqSiHBBF0lSprY59Kmyo9/4qngmPe7c80zY4PpFo8CD1izcFnUOsPFm5BlU9+mg76KyqUF40ZWGuQ5NcHN7wJsgFQaBMt2M2W24AksPGcLdUgKujCC8xu8D8JzQf7Y/2IA5X0OS1LpkZiytHYq27ioUxSEn+9mpUed8v5jS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQRLmpIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQRLmpIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416621F00893;
	Tue, 13 Oct 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902389;
	bh=Y+Mp+eEoHrqer6Tgbua+miYvpSxHH9viil22hd5TLK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQRLmpIRSiQXepi2W9Jx1/dJxQQkeG3OguRpf1XV8Bc9HgHrY4scPEhRyH4Dd9YHa
	 u/ib40r+hM2ffCyQoVkSAIA7EaOAtHBH2qhGhp77ts9T1VAG4u4Fmv8d8kwZlYm4ty
	 veuRAVlOYO63QOdVMz3dURvAvyaDiOV05m4qovIAajia2J1xn73D3Lmf7oYHwVDuDF
	 B633DlO9VllBy5Ulnl8AFdpZnz5k4cJYCkoVrFuJ7Z1JfHMpSgfI1n9YeREfEz7KPK
	 E3kunqwArPPUnxnoB662gSB4pKgVKqQRpOVpPX5yzVRr+1TVPPjYjUuWG83L2gBEvH
	 pMc8ABsEKa0Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] dm-integrity: fix NULL pointer dereference when the 'R' flag is used
Date: Tue, 13 Oct 2026 10:39:47 -0400
Message-ID: <20261013143849.4164284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101259-ember-outbreak-0e5f@gregkh>
References: <2026101259-ember-outbreak-0e5f@gregkh>
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
index 415e763041bd2..5ad2b85cef049 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3873,6 +3873,10 @@ static void dm_integrity_resume(struct dm_target *ti)
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
@@ -3982,6 +3986,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 		}
 	}
 
+skip_writes:
 	ic->reboot_notifier.notifier_call = dm_integrity_reboot;
 	ic->reboot_notifier.next = NULL;
 	ic->reboot_notifier.priority = INT_MAX - 1;	/* be notified after md and before hardware drivers */
-- 
2.53.0

