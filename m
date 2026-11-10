Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337071;
	b=ElUjN6gzGFzqw2kwYFuuG5mQ3fmXUHw/Isti0OT4q+7aBviZld6lciRxcDj9opFcpj+y
	 j0ClJ2fYBUBBb1Tpn4DfIe+TraPeIv/PGOxK4cDvSoWSzT6xxJFllVB5CiJd4YXEILDkl
	 pU/lZ43bi0pARBC5VGACyxUZFXsAZtLkbSY0DW9VDL4E5Ad9pKf9zYyB4A0I3cYSQFKeE
	 kyaYqU+aXVFh1fO8c4KKoE9/mD/Fv1WyORUkGWOXJFuC0FljoUXd6XLE8fQUIgzJT22jB
	 iTGpbzJjy95oxBSWjFuf//3eejUz2h0OsRRuqPVM9XNbbXZuQYoQQEfnUCNkBmxjDig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9TvkzRca3ayjkNNBbltueDL+PhH0Fgm8DbtD9iRO8cE=;
	b=XxJSklcQW7mpBLfqpK1fEhE7u1zU98+AtHMhuqH+qkZ+Zh+v/+Rbp1yuMIOXFNdCW2i6
	 FHlO8Lqfpu0ObCfVmKI74GHmoEQYBAFsoHlv8H3Gm1VJdYfrAdtUkEKRLUEKUk3MbBwaS
	 Eo4oU2MT3ATS5yViruBlTWNw1Fg/3/J7bfEaluxI2+Rkt7Pj+98KIBtU3zxafLpNFeU0f
	 lDeEiZmEgrsGIJzvw1Fcv3K/hSDY62rKCuR8YWBvr33ipoyEy/S4hGjaRyMYHUl6iMmyg
	 h2cHFzbI366SkE5rU2a040LrTHAWXihExlI+DNsgmFRkm9B//CvHjUg0PDgDfV8HmdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qu+ayXVp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF60606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qu+ayXVp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739561F008A4;
	Tue, 10 Nov 2026 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337070;
	bh=9TvkzRca3ayjkNNBbltueDL+PhH0Fgm8DbtD9iRO8cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qu+ayXVpmW0SRqYg/qaIYmokcHzOBXSd5XbxGQlL2Tclql/juuxOInKPmNlNc32kt
	 uTQ6ndloygM56mbkPCyN13dcFXLUTUYT9BYJVxrnidEJbKQRWQaeWeiFfwotu4RuvG
	 Gj+F1jaVHdFzd8RfYNDgsN0PaCgLEh6IAYpHemXhWOxrjVvq1xE5JXZy5i9RDTL1uZ
	 JirqYSlFq1qVKpSUk/W8UMXsQVR29MP2aAzXyYUnGTPaf7vAyvhV76zXZ+Vh0fYjqF
	 9CxO1/TuI9VeMBgwqmURB6bz4Xqg9bZ0R0IEMVmLvRGwHioE9LlT0P/sfHxzonDgxQ
	 J68iyT/Jes7IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Guenetr Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Wang Jinchao <wangjinchao600@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] panic: flatten nmi_panic control flow
Date: Tue, 10 Nov 2026 13:57:48 -0500
Message-ID: <20261110185733.3451898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054818-failed-6.1-75eb687ff2bc@kernel.org>
References: <20261107054818-failed-6.1-75eb687ff2bc@kernel.org>
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

From: Bradley Morgan <brads@mainlining.org>

[ Upstream commit 75eb687ff2bcec9fba31bbe266e5f91e5c283efe ]

panic() is __noreturn, so the else after panic_try_start() is dead.  Drop
it so the force_cpu path can be added cleanly on top.

Link: https://lore.kernel.org/20260916182957.7788-3-brads@mainlining.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Sashiko <sashiko-bot@kernel.org>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: <stable@vger.kernel.org>
[ sashal: adapted panic_try_start() and panic_on_other_cpu() checks to existing old_cpu comparisons ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e6c2bf04a32c0..e5bb4fd0aca74 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -198,7 +198,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 
 	if (old_cpu == PANIC_CPU_INVALID)
 		panic("%s", msg);
-	else if (old_cpu != cpu)
+
+	if (old_cpu != cpu)
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0

