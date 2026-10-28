Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197053;
	b=j+H27GXCTPqRS83EfE+PywQRWDR5uNYPTg55MtNkxGeYPAhrjZxyXcDyKNcjV6VvAvKN
	 9kvD8LudvzLeIJimOwb7pUVVB2HrpOYmX0F7z/7BJj6Z4U1L9oeg9j4dCG8gT2J6zzFtn
	 hoW5Cbr2YH9d25BMnAxgUGRhrioC9CGAlNN1Y0Zhw1zksL3/BG2VEsezSNk88Z02vYh/b
	 7DQFA803Z1OuFfxNleLA8wCCH2XE3DDCiDZs7bZdXKsVNBOfqGCu7gsHO8vrYYlH4y0y4
	 O8WZIIIk4VRYfW9oHz/C63dYPTPTFry/GtlMXZCONd93C0J1kabmok9hfT+fjLGFR8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DUbseAYEE+G1IqK7aQUzVK/2OJ86R8Gy/7HvczyR3XM=;
	b=G3F0pjDMozR4zkDKx18Eu1HbT5GFIZyGETY3e3Fa+kQz2a6J2RY00CdyxTbSphq3rhnk
	 QW9sGeho3vgkJAX8OOGQiTs60k6xaRjcO/QPq1qA07DQULIqzubcve5C4DMXOU9cBN+LO
	 Ieuy+yg/L2NDH6O0Sg/VDDFIO/3z4YiqCuzdSt3Jb5VX5olaSQ66t7Lwfz8D1geclVfo9
	 CntH02CBIpG3yV542Pc16o3mvVo9N7P+qWWBQEn+qWzSZ78oAhePsZVMQy4FwkzSKNUrA
	 6pp9CVzesjLLn+JddhKmkn2HRdxS5pMItJlopCyNpam4BlPwtroCL8Dksu3VssN2Z7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GudBJxJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F4606A330;
	Wed, 28 Oct 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GudBJxJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C701F01829;
	Wed, 28 Oct 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197053;
	bh=DUbseAYEE+G1IqK7aQUzVK/2OJ86R8Gy/7HvczyR3XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GudBJxJECT18SsAT7M5dBTcs011v5Nlen5Ty1iKBKpiR177AhkKzX8MCtFWXuCfHa
	 GttY9KcyJEYQdYiPlxXb8nDjqzHNjouwLRnhbkdnpJd3Ez8xLHvSXDpAmFiNkHMaPo
	 Zq9aiUoyQCjODugW1XuRXFS2E3JVMi2yxx+UoTbcc2NzqzHWLy+YtfpQMRpkkiOD5d
	 aJhqYyUMnYZJ0yAioyn54BRknp6YF8cuPNOk+7Wb3DX7JZOLvNOo76Dwra+4deTQyF
	 sJCc04eJjEuBvEsVFehq3fkuLa1RvXGj6GNI1IJph2H7MhPMGezkeZiy82ly9F7/ph
	 RuLQDHd3TDlfQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Wed, 28 Oct 2026 07:17:22 -0700
Message-ID: <20261028141723.161776-3-sj@kernel.org>
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
index 4b28bb9ba0a24..b9b80d58e5bd6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2515,6 +2515,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
 	}
-- 
2.47.3
