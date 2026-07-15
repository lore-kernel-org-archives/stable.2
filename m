Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45C3B27DE
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146574; cv=none; b=NLmg7ZHN9aX5o+hcXFRWJetvH0thQ4qbQcfk6ej96GOE6TSRFJurYC1HSKoHqaEeimSBzfvFe0tVNJrb1VtwHLTiZ2ywfhLuV851HIBfYJYuG5V4CNQ4wXQP9bf7/FKiyDWOSKXMDT7O6V3dfVniAz9GgXTllMg6tPRZZguFdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146574; c=relaxed/simple;
	bh=n+bMFVao45ucm9k9YTJMvbciupuar8u/LUExW4gdqVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLQNmEjNtukmlKta0LFZB92mnm09XLX4/C+jAQaoJ+MIN7DkkNJ27p3Qobcr2b0WSGszc9WDf6fJu0/DiDUJIuS1kBA53dC5vsURjC8owSgKJiKxKBVxe43Gmk5eqcHF0IcScxgbjcOBEDZqQsg5crP+nTMKwHOlXMBgOjpoQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLAfCvqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLAfCvqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A21F00A3A;
	Wed, 15 Jul 2026 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146573;
	bh=bwWYM8Bb+eutvxWySUHbUUZs+6OnH2/F2xUsMfxKhRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLAfCvqGNOGzzB/5VrpXeCr3zmiEHa7DqF+6fOd5P0RyGBP4atDzzYgGHwZfJgV1y
	 p/+gnlU71cbZXYyzdqDZHO7od8525M4uo5I9NyWEVeCRb4fzHRj8y4k0V/XgZHw8NS
	 8AXZkhLKW9JJ7LNg7Bg2iK8Kq97U5wJcDlmIkmIbuT/EFXi6PpUOgR+c9KCXrlUhB3
	 ANoNKmNd7KXs3baWbpZ0GjpOzRYqfE4fZ66XfDRTFC6d4uuMyncMyEmw/P+ckpYTGT
	 RNRdH2YpxM3YQFYVE4+r12w5Hy8iNUndBuy/r+thCmE3oowXm0cx6UCECIom0/Ebc0
	 KoG1MrNaP+a0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] netfilter: ebtables: zero chainstack array
Date: Wed, 15 Jul 2026 16:16:10 -0400
Message-ID: <20260715201610.64283-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715201610.64283-1-sashal@kernel.org>
References: <2026071334-dribble-bunny-03b1@gregkh>
 <20260715201610.64283-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit cbfe53599eebffd188938ab6774cc41794f6f9d5 ]

sashiko reports:
 looking at ebtables table
 translation, could a sparse cpu_possible_mask lead to an uninitialized pointer
 free?

 If cpu_possible_mask is sparse (for example, CPU 0 and CPU 2 are possible,
 but CPU 1 is not), the allocation loop skips CPU 1. If vmalloc_node() fails at
 CPU 2, the cleanup loop will blindly decrement and call vfree() on
 newinfo->chainstack[1].

Not a real-world bug, such allocation isn't expected to fail
in the first place.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index d8dda76ac14524..7417d46af4b2b8 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -920,8 +920,7 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc_array(nr_cpu_ids,
-				      sizeof(*(newinfo->chainstack)));
+			vcalloc(nr_cpu_ids, sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {
-- 
2.53.0

