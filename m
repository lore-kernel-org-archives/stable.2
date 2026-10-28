Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197053;
	b=r+gM/oxpSfUMO9/eIGes9TGbSkkmx+3Zy5CfQMg1X8nMq+kdiXekZ/fY0RuRNg13eriC
	 ye83LURQkQdmU4mEtwtLR7qqJMli4QuIpSDHPn/FI1OqS2oTB4XWAVN8SM966+YuBCk19
	 UX6ddv8s3MmJiONGsWxABDzbylGW3p4amn6DQiPOgeGfWontWDpQibsO0Nol+zOP03Lsm
	 TGZO+qFAEVBNcfbiJPKp1AXxZ8pLuOv05M21wqsRKorNfKnjxDsUXNZdfbd8y+5Tch8fZ
	 5Eg8DwOf5LivBHTj4mJVWXGdseylD2Vog99exNwrfVbeaV15fUkY0rgLA9HHVbXHHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0yPa5wbC5qsV5ePJc3qyfqSfwGtResrr8GiaQmPYPZk=;
	b=YnZ1GaIVS2qry9NVYWqJvPQ7UCUp+zuJvgnTmTgPRmq4bM3txJ1bWVLp6O2w2mTqVzzh
	 8UqM43Ybj9WVUcTTBFVI7i8Nn4Od+ZsLN3+h1RXXUPVON0snskEuqJkXckcyZP8st4TvE
	 rsNpdccZH29gHX8xiDI3jGJi9Cj9nnpYpe+SHg8zPj3M9BCIGIsvxhPbBPUbXx5YJb+jC
	 BW4FrpTiS1/L9ZOrp/Oaz89B2xhdRRWJDQZrR13HOzGAiI0yKGq1tkSnbB+rs2nFv2Zlg
	 9/bMlToFo3RtLjwAzdqs9Ace0hNqgajxi77P7pV3+k0MNJWuDKkOQ0COq0ctwAMV3uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZO3/k+0r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC1606A31F;
	Wed, 28 Oct 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO3/k+0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDA91F031E7;
	Wed, 28 Oct 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197052;
	bh=0yPa5wbC5qsV5ePJc3qyfqSfwGtResrr8GiaQmPYPZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO3/k+0rpGxjzv5FjESP8rdCYPHL0qIKSXYtMfk/WcjzeFRk0CxkzDIDcLvPixOzz
	 yOXzMWjKta0SNKf6DVx+eYL1ZsRKUiMRiQ/tJgCU/Aq8MY2mm6rLJld/ZIJ4Q2XYjT
	 c4vT4vI8X8+C8YkdZiP1Tic1uHVmk9V5FuxPpI5Q7KO7+kboZhWpl3FhaeX9iSLfbW
	 2Jlu8z38EAtvKzflNrl0CbJDKXLdcEsPguDC/MYxIc5BzHsenxBqGwAE2+5FA8x3j5
	 hQ2OWiY5D6JwD29cq3ADZ7HrkpoqnQBUBS8q6pI10dJwC9vR2mJgLn9f8Lu4ibs0cp
	 J0SC/B7f1YJ1Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Wed, 28 Oct 2026 07:17:21 -0700
Message-ID: <20261028141723.161776-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028141723.161776-1-sj@kernel.org>
References: <20261028141723.161776-1-sj@kernel.org>
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

damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
If it is for virtual address space monitoring, the setup increases the
reference counts of the target pids.  After the setup, the function
invokes damon_start().  If damon_start() fails, it deallocates the
damon_ctx object without decreasing the reference counts of target pids.
As a result, pids can be leaked.

Fix the leak by putting pids using damon_sysfs_destroy_targets() before
deallocating the damon_ctx object.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9a918f8e4c6bf..4b28bb9ba0a24 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2547,6 +2547,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		return PTR_ERR(ctx);
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
-- 
2.47.3
