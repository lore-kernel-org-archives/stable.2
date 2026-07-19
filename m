Received: from mx1.tpz.ru (mx1.tpz.ru [109.236.72.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89F192D97;
	Sun, 19 Jul 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.236.72.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466692; cv=none; b=OJ8nBhcqlCrDyPV/0wKm10qGRK+Ho3Ivpvs2UbJpbTE03K19syS3SwK7TnLVXa21+dxryDlCFZg0U3oFA/TNJkQ2K3lh4X3ewN94N3S1iuZKpxe+vpHFc2PqhfLVbxr4b0QX/IQAcQvXemjo7bgvP8wSDEhHOxvDKaljUrGLJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466692; c=relaxed/simple;
	bh=FNbPMJnWPTLOkifM1VCNpkwMoqA1kP7gULYL8i15SYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZkog4G6P/3NrP7+gen3jRowsfcZYThzrozqSTJvTJWfjoAFIFHKoz0UD/LMTPBUjOMtLpkJm0ovPr89E4SClKiNhVqsZQAtdLqSJDpQLx4iK1Atcicu6tk/B/qwhvNs3OS8JdNfaLKcu6egpLgTl5/Pu0eWEgp4zjurfOgvLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru; spf=pass smtp.mailfrom=tpz.ru; arc=none smtp.client-ip=109.236.72.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mx1.tpz.ru (Postfix) with ESMTPSA id 4h33gX0Bb7zvQHm;
	Sun, 19 Jul 2026 16:01:27 +0300 (MSK)
From: Ilya Krutskih <devsec@tpz.ru>
To: Alasdair Kergon <agk@redhat.com>
Cc: Ilya Krutskih <devsec@tpz.ru>,
	lvc-patches@linuxtesting.org,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dm: ioctl: reserve space for NUL-terminator in build_constructor_string()
Date: Sun, 19 Jul 2026 13:01:03 +0000
Message-ID: <20260719130105.79838-1-devsec@tpz.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reserve space for the termination NUL after the maximum 20 decimal
digits of a long long value to avoid buffer overflow in sprintf().

Fixes: f5db4af466e2 ("dm raid1: add userspace log")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 drivers/md/dm-log-userspace-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-log-userspace-base.c b/drivers/md/dm-log-userspace-base.c
index 9fbb4b48fb2b..fda97368a72b 100644
--- a/drivers/md/dm-log-userspace-base.c
+++ b/drivers/md/dm-log-userspace-base.c
@@ -139,6 +139,7 @@ static int build_constructor_string(struct dm_target *ti,
 		str_size += strlen(argv[i]) + 1; /* +1 for space between args */
 
 	str_size += 20; /* Max number of chars in a printed u64 number */
+	str_size++; /* For NUL-terminator */
 
 	str = kzalloc(str_size, GFP_KERNEL);
 	if (!str) {
-- 
2.43.0

