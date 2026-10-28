Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163551;
	b=UZaKa/9Fue1xSZFu/jb+0dsvhX3APzgeRZC9pZlN0xyBARXvLz+9pjHsb9Ztep4m8XEW
	 on2HgGpC2QComvu/6f6Psu7OKIeO5fdNvrHb2oqeZ5LVTDZDRf9lW5uRsqJghb8XJ25xD
	 zADreQ6XVM+bKqixyjaBck2wBc8dtVEVvw7tp9gWPw8phQ7QBnxuhgFIHWiJSAHjJfqcC
	 9C7bDAEgXcGhAjYyzvSSx2IPG/KydbIySeoSs6BhDhhDYtmbDg4XGUMw0eLaa0aEiYIxl
	 9hRhcQ8CRTvq69/ko3O+L6W92ZLOJcEvVccnWzdGA10mn8gNyjxtZZ/PMaMZNIsRt7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cnCdwdKLIRu22zpmh++d3j4s9fK6gxqvvFFUcjcNhTE=;
	b=1DF7NBiLx9y/OLud/zR7zCnVndQxAYIeb44GixISvq/r+/LuGlvsfaJ69kGDsgUTRXEq
	 4cjRHDMHLXBHsLS7npByNslX4miaCZGJexzqo5oPZ9p0sREVmyF5in06NLFzZFhuobSIH
	 Tmnt7lPuNTdP4K6FKp3MSFMO3k+IwvOHKZbetZvv5k4yG6A3U9SgKGWwV9sizB4GhyJqH
	 SLXKU3kjWeEN0oW7L04sm8QiWebtfy+G3UG96FjhZ6Gd2Ww/hkFh0r6Qw50bFMyKhyjYq
	 cVdeGSJ+0Hy0azrVadT+p5Wp9KGGOBbDWryNOoXfmBSw98nPHyJgikVKsKmCgN9bQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfbsglmg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B1606A31F;
	Wed, 28 Oct 2026 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfbsglmg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339C21F031E2;
	Wed, 28 Oct 2026 04:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163551;
	bh=cnCdwdKLIRu22zpmh++d3j4s9fK6gxqvvFFUcjcNhTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nfbsglmg0+TZ6THLVRX0qLqt30DIt0C9NinjEXkc87nzikN/MBclOKSoN4EZdmdLz
	 aNhVwpFXcsp3OJRBYSf68s3HbpgGD+u39Yotnh68vcoPDsRPN5EAl/EHLCvCxWCKgm
	 n+Gfok7s1IY645SH/EHgPYZhmRAaRjuR8o5ZolHbLoKEHlUUq8kJMomgC0BemNntKz
	 rT31BLcvYCutKTRgYxM6FxJqhCCr5x2tpCA1RxJqX49TZLQkGd7hgZqeeT1J12OJO5
	 uxV8gN67OboDQMHPRicSd3jfFiF9HJByiscymUDgpZIUDc1Bg2hnFnbQVKsVJaEp7J
	 7IH9jqKpL2QDg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Tue, 27 Oct 2026 21:59:01 -0700
Message-ID: <20261028045902.148624-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028045902.148624-1-sj@kernel.org>
References: <20261028045902.148624-1-sj@kernel.org>
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
index d95fda1054a00..f830b873d05fc 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1433,6 +1433,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
 	}
-- 
2.47.3
