Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F63D3CE2;
	Tue, 21 Jul 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609912; cv=none; b=C40rtheppvgQb5p23rtTWAZqb2kRifsb9XcZRUQT8BANGCs4kq/naA7yTYbSawrMaoAGq3K5fJEdY4juY6vSP2xUh6lzuPY+SSlHbu8GY9qfYaXpMBbqhAQSzbTcujE4BP8WmXKrLSI7E8hZtoptLon0vAqqgseIbp2WM9ovSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609912; c=relaxed/simple;
	bh=dhRmIlMGJZePgOKLMaQI4oeLcAHXn7W04wGzlY70/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLt41HuWTuOMMsAHfvden817hOEcojQiUbO+UsBh3UVd5jqeHYSpdyylnOVInxI/7ikNzlnomR2G8wFwhc57wQW0iyjN6vrbxiOuFfx2h2bWO/XKKq3COwGrpY1yeKrhv8sfnG5iwCwOeWROnd2tUwjilGClLZA3gFe1rgdPvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocO/Dr6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocO/Dr6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D003A1F000E9;
	Tue, 21 Jul 2026 04:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784609911;
	bh=J5yQEBXGQYKlXTuJWTKJ5jl/uKM937zNduRrrgh0V/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ocO/Dr6cQVX/++uEVTH2tHTKGZk/vH65Qd90HfNjM8e9kJNj+rzg8iNsx0/n2irXq
	 m3K9OvHpvc1TLubL5tDHq8/DLAC6IhWlgrc7zoB82amCrJ+t0zqTfgqAkY1yP3wA1x
	 u42ivEkiO7V4tcUR5cZ/iEMU+TypM6mjr15N1F9MNlMqZhNgFx7EsyeWUMJfrY7EOA
	 rIvuGn/aP1SUbqqVnCiDkgjrKcJBADl/tVAroP0jcbfbHFoQkKhYZnW5cAfeGYmOOP
	 rjUoiKcr9by4SEv4XZ95ZzGmIm047HpzM54HfEHqDQdVJoSBf6CH19hqYweuskEFhc
	 hjlVyCWzuXcbg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: make charge_addr_from aware of end-address exclusivity
Date: Mon, 20 Jul 2026 21:58:17 -0700
Message-ID: <20260721045818.157773-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072059-refocus-lizard-6528@gregkh>
References: <2026072059-refocus-lizard-6528@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

DAMON region end address is exclusive one, but charge_addr_from is
assigned assuming the end address is inclusive.  As a result, DAMOS action
to next up to min_region_sz memory can be skipped.  This is quite
negligible user impact.  But, the bug is a bug that can be very simply
fixed.  Fix the wrong assignment to respect the exclusiveness of the
address.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260428042942.118230-1-sj@kernel.org
Link: https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org [1]
Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5a2d162e22bf33eb89d53e802d0fc1ec422e19b6)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d293200d824e9..4b434ebd37c53 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -803,7 +803,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			quota->charged_sz += sz;
 			if (quota->esz && quota->charged_sz >= quota->esz) {
 				quota->charge_target_from = t;
-				quota->charge_addr_from = r->ar.end + 1;
+				quota->charge_addr_from = r->ar.end;
 			}
 		}
 		if (s->action != DAMOS_STAT)
-- 
2.47.3

