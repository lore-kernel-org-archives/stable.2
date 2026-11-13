Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603700;
	b=VlvSZpTkE0EGgvlKQmXYnGDbv9u9Xv9mr5l3RmKUufRf3tnfhslpvDV73gxlzbgvdCR9
	 pO1a2e+GwoKvoLECxcoOir9Fwt6JdIWsHRiuYxN/iJpoUQYU+BhyRoy7v9z/D+ug2/kIB
	 +7IvlKkdrtxiTBFIyUMjNHrP+BQUXOQVug7GuSYgyHPGbz92+EOBsO/fOte+Euk7OaNH2
	 j8MVbj4tK3H2enGVvIVy3lPM3CvjkHle73eEdvkWN5/m4ReGyKzqBjdddYK7bYQc1226y
	 hNcFQXTyQp3f8XINw/7i3+zOKu+k6QBmaZhwOHOm4RRZkrNuP5hFh3mO46bdDUjXJCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HaZnE72Q0gNnlC8fL4KmtglNgWDf78JmNKVaaW4zyUU=;
	b=atKJ52495IheQCQmRkFhPVXTlutFD889mW2Tbllc6f4scEYehiQ8Bbu4p513HXZ5aoAJ
	 xDUIMZT8Llqybcy8S85ao0c38imHHwWBi/28UI+yZLF8mFQyRZgetHNsDY/TbT6FeRndp
	 JHqbaZ0X94NQfi+o8FcDOlRDxhxAs+odTMSNYL9dgs58jQTtdammkBNpn7fszDnTwCNvL
	 n2qauhR6YdMQVdUj5a6aGPRg7n0JuS++1ZUo7F2Ly61tvYftjqJ6xuHnzZhMTyfxGO124
	 K86FaC6ELe91lrNCr6DpOUjaeADinbLRhs1G4/IOFpJfOIBvHKkYpPJoId6LH1EjYNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T68uoIzC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCF606A333
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T68uoIzC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BDF1F000C4;
	Fri, 13 Nov 2026 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603700;
	bh=HaZnE72Q0gNnlC8fL4KmtglNgWDf78JmNKVaaW4zyUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T68uoIzC/jhht4vLQ7cM9dz1ozLD9z8ZNqmz8l15yc6q6BurukcOrvg2HrOdVF+tH
	 3Es54fdWZi4atbMq/mINj/Z/Ebc8ww4MlHiResLB5/VY8sKszjpigPMDBTzJWTeG31
	 wIBHxYjLqfRPwTXpHSvYGIiKWKkQG4UFHEmWMYRJOBAXRTbpFOAJ6pVESnmryexQj9
	 2yMMTlE1kcDYDXG1SesxpNd1VITsaHYcBFoWGdZpjNmmd2P6UNOtQpcW61FBzCAIDc
	 71zfcc5pWzkRL9GfkN87GeflGfXYXG+1FrLdz5yDQ/I+j1+AJGkdlf3THfX/NrDDiz
	 7nO5ONOLhNOJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Fri, 13 Nov 2026 16:01:38 -0500
Message-ID: <20261113205811.2552513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200502-failed-6.18-05f64f211a25@kernel.org>
References: <20261109200502-failed-6.18-05f64f211a25@kernel.org>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 05f64f211a25f7d9771d4fde109aad97174a1cf3 ]

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: apply fixup from Lorenzo ]
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-26-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced bitmap-based VMA flag helpers with a scalar vm_flags mask and equality comparison. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d5467692e8c3b..afee33a97bc49 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2077,7 +2077,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

