Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA663C4163
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277080; cv=none; b=q6gieR1+NNxz9CQMMxqzqtCd4LX0vkkUvgZ9TYyUXE9Cjeh9xojEPnvL3kzlpu7Yo/QM3dKyI7Mn7MOBhbofWof4marY/gDfR9By9UKkpR6xi4nv6dBGJZuIQ9yhvA69/TWYAOl6epEMwmoWQNIJVB9Q2tw0xYfwdNQHJJ5SkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277080; c=relaxed/simple;
	bh=i7xYdrHlx6FknLiT2Vu/I9cXx7oxq3yObuToiGBNspg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw0KaFPhZdVtRxtU9gMP1beAGpu9PPjHgyfFPD2PYzg3vbkvotKEKbOAhyGWRXt5iu4ymKbX2AYAZJO6QF603a7mQoX6tYeqElzucXHkF+iqAFpDGifniWlFmDPW+D9VzgMZ/s75UBysE1y2b0TSv4Bam0xkRwGZblTbJK3JRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb9ZGjPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb9ZGjPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCFA1F00A3D;
	Tue, 28 Jul 2026 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277078;
	bh=PSTMEuLvc4PdkK9Aqdf4WV5Wv8uUWzXHLn89Xlf/ZQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kb9ZGjPbIynfcmU/7oGSikW5LKo2yUOl8YcO8sd+Y1QQKXN0f5BA4A4z3UzWgTvir
	 1h1AxjLDParpk9mHbJAKEFXoUMdhSQkx2yFCtH1DlAAXVww+fmthcLoedRe4Y0yK+w
	 qI+fHeyQFuzaiTU+AqFuCW73KqmyY/rsG/rL+yl7ShoVckRgnW04jSSOYO1e2CdNox
	 5EnNWnZUwPcvFgM6BtaaTC1zq4x/wKAGgQAQoISOiK3bOfZCF01dQWWFJRPv9kZzbh
	 0IPVJ7vC0MTkqGdkKGiFoZnzWzvzekHoER7r1Xg6CftafM0g7eZtRKtV2VJP21mDRo
	 XahstDFsXtQhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net/mlx5: HWS, fix matcher leak on resize target setup failure
Date: Tue, 28 Jul 2026 18:17:55 -0400
Message-ID: <20260728221755.746200-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728221755.746200-1-sashal@kernel.org>
References: <2026072123-treason-bush-df20@gregkh>
 <20260728221755.746200-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit bb09d0e64ecaa0aa0f7d1133a1696ed74dead295 ]

hws_bwc_matcher_move() allocates a replacement matcher before setting it
as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
replacement matcher is not attached anywhere and is leaked.

Fix the leak by destroying the replacement matcher before returning from
the resize-target failure path.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
mlx5 HWS-capable device to test with, no runtime testing was able to be
performed.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260629064049.3852759-1-dawei.feng@seu.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
index 3fc3ada0166534..4fdffc20cd7829 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
@@ -225,6 +225,7 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 	ret = mlx5hws_matcher_resize_set_target(old_matcher, new_matcher);
 	if (ret) {
 		mlx5hws_err(ctx, "Rehash error: failed setting resize target\n");
+		mlx5hws_matcher_destroy(new_matcher);
 		return ret;
 	}
 
-- 
2.53.0

