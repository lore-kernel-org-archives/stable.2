Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196718;
	b=GX6DrWdnCZwxbO19b03d1/eFKncWq9O30agOHOpWTdFuRknJHo14hsOgg3e1lo5vaps1
	 Ks084q3EbhP7vTiYkU1jP84L7EF926KWeUgSEjLtvMN0ezrGdqdYSKJvMCJZ4e7H4wnsq
	 Td3vpL57JOkw/Y5Ijpbix4alWfIDR+n5exvG/WC1Vd53hjTBAbVMQFB5FRBccXu7OYsmr
	 hWv/P99SoorZrFfOR+NodEJ8KnIOeb2VSo66nEKIKwpKNUKuLsAAqJi9wmsh0eakY8G0B
	 PR9fjChzqpoTk8au8xXO93NE/YXEvcrUdLDLjZhssg4aX4T8WCp049hQBJ0wR3xMXIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196718;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BHxSttUyt/DDMdmQXBY+0M0nVJfrKzZZx/1K6D8VwE8=;
	b=qKmk0xwmWk+76+Tkz+2iaRQDBBWgi/i0uT+uevQGULDrzyi/6rP5sK1GMDvNcnQMNkzb
	 2ZYJST5YcxI2rXiALS6Zcq9+Gpsv7V7WRyeKFvMPR2UHhBLNhi8daqGwrt+W5RPwYydAk
	 L5KIMs0YBiAHpxfgEvayvj5AHszwyVJr0gFpMdSWhVeNEl+6N916cPhbbTFEZfZ/Bb+PH
	 JuH05hTu/oPkYkep1xktFTcyrneM0qhvG1ge0rtNAbyqF6isgsVBJ+mU4Gwz12+VCNDNI
	 6lzEUqsN/PmxnTp3n7slokhYeADMMhodV2wPds1UKZnFHjVRsLxNt0+b4WWhnJEzhxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fffz/3+h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC40606A32C;
	Wed, 28 Oct 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fffz/3+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A20E1F031E7;
	Wed, 28 Oct 2026 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196718;
	bh=BHxSttUyt/DDMdmQXBY+0M0nVJfrKzZZx/1K6D8VwE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fffz/3+hlpCka620g9LmphQzhp3kkMlWlle0p5Vl5pIcRUoj0KLcOv9O18184MaP0
	 PQad/5mASfBS6X44wPxAQevH8dvPtHrrXn+1JwcFACn392mxeR+Hr0Ic8guGIHS9lh
	 sfo0TSIBeUpKhmzKL05HnRBa7bAY9327nl+7CYFmPnAtSOFAXp8gmdLoksXRXqewnf
	 1yE5a9nyDaLSSWyOynxOs2C0zaK1Z/RalUFq2A71K0tIb04czNNX0/12NsXASDHM5I
	 b5NyLlvuCerC83s8C/JIz+dpjDkhlSiS5PgBb92NmrpCY7SXXSaA2rK8q8Ds0gmFDs
	 nQejANlh9GRlQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Wed, 28 Oct 2026 07:11:49 -0700
Message-ID: <20261028141150.160711-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028141150.160711-1-sj@kernel.org>
References: <20261028141150.160711-1-sj@kernel.org>
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

damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
damon_ctx object with user inputs.  If it is configured for virtual
address spaces monitoring, the setup also increases reference counts of
monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
deallocates the damon_ctx object without decreasing the reference counts
of the pids.  If the failure happened after increasing reference counts
of pids, the pids can be leaked.

Fix the leaks by decreasing the pid reference counts before deallocating
the damon_ctx object.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org

Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separated function")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 107a28557afe2..6ae35f55764d5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1486,6 +1486,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
 	}
-- 
2.47.3
