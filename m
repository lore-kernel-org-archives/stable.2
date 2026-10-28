Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164274;
	b=5boaLkqUCrOoyOGVqEQ7MetngqudJIGQg0VchFxAInB7+czZPoCuWwWamnqr1P/zrXXg
	 VPncG1Jt23kEnrYkxsqJfNDM+SRe1V4hA3Tank8n3/OHLLKvoeo3JcojgAvwpFPWFasbx
	 A1Zif2ILGTmskdx1VOtLN//haoKnRyReXpZIUm2uE8DvQWZ/yzFba0/c9xnkV1wcAj9cx
	 cSjoBNKMVbfTfsgqK+qf9Kj+Fs+pyRzhksyFj7qNK5h6ZdjTXmjUmVoJuBsiIgaoRIpi6
	 x7rIHBFKYxdtlDBDS2bzjCLuTOwg5PEb6RsVjS+UPt79Lwn2/4Ff54hX6O0qgYhS5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0yPa5wbC5qsV5ePJc3qyfqSfwGtResrr8GiaQmPYPZk=;
	b=t77AH5AUtRZU+ZIxTU+Et/wg6iJZV36sNGdZf/LErOJ0IpCfqC0ENlWBhaSq6/4UGDnf
	 K0YnMf8MFA1+simQm1S48n4WlTyZSuoOVtvS/28oKVKovEefSytGKWuFWk5nNvSZKEkKB
	 8T9TraoVcFuNcjkoqu56GzVoZGW6eO+TZd8TuV7FKfrguQpSRfoqosumAeBpqyr+7/1ZV
	 zyToMDpUo5qVQ6kCShuoonwIVjGup7k6jGx2da4ux7oBfA2ufjlgd/Ryo+X1jyqCf0iNP
	 CAArcTPENvbyMPGklLBMOrOO/gDYq/tElXkw1+PCFZr1xwhgKhr6+GFkdnp0vegQnPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9KbJE7q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6C606A31D;
	Wed, 28 Oct 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9KbJE7q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3651F031E0;
	Wed, 28 Oct 2026 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164273;
	bh=0yPa5wbC5qsV5ePJc3qyfqSfwGtResrr8GiaQmPYPZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I9KbJE7qEqPtgy/TkRldcESI2Y5OZDrBs8NI88jwDvQ2YVPKxYjEw29qZpRZtjInw
	 rcXln9rEdUnQynv6msdUInEVFzxX4kvlsE9GEnzU0cmw9B3W+5jDlollM0eCkdaigx
	 4Sp9MZA06d2kisL2q1wJWpZ3c0k6rc3rJZcogW6wg54ksbbA4rw2XSDxh8Jqc7lbSV
	 Bma5ScdcjYOJaDvf7DQzUF23jT3//145nYk8ixnMCGFt4ydV+IB6xmXPg4wjJJj11y
	 2dmPfFlZeTWzPMC9cOiTrTtwkCe0IG7EPrl0eIsPXQS0O57C+SjYj4EDQt449wxS0d
	 tFo6Oae4voYiQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Tue, 27 Oct 2026 22:11:02 -0700
Message-ID: <20261028051104.154232-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028051104.154232-1-sj@kernel.org>
References: <20261028051104.154232-1-sj@kernel.org>
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
