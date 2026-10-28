Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164274;
	b=iwR3zLEHC+09cGUIrG2xlJsS/g4InDZ8uHPQMVywK0QIU17f7qeU6NyJCapXf0qjp8os
	 +OYeZB7nrQkwPBYAqACqSieh21sYyi4ohmPbbFsIkybqeorlhAbs9fY6GuwoooxyWNELp
	 4AY0BPWiwBXgkgtNKEMjLGADXXCLI/8c2b3bJGrZDpswYcRZZRM2ae5ba8YjKvYKMj82E
	 1/HGysU8NqvzrCFHbGw9z97SkoRHSiCYYd5CDT0iyT1p0gGi3aBgzPlgKVVEo7Qy1R8ov
	 wU+jDJawdKGaMP3H4Vs4QjqUNHKJuYRgxuNwc6iy8vmisrzcO9cXp5UCgDd0GgFJJZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DUbseAYEE+G1IqK7aQUzVK/2OJ86R8Gy/7HvczyR3XM=;
	b=qqIDHEnumgEx1h5pjSWGBHiyNFXRQXzrjN3mv/ktK4/tGZOcKp+K3/Fx0i8E+eBaqlQB
	 MgAM/lSZGgYEiB2brgz3UJjB9mVWPRBfYaF1kGJsAlBGkKp0tiSFmg0r9WusXLOlX4oIq
	 YhfXr+r7JgPAqSSt54cbLdG36nwFETK9tD3QSbivxb+loBnuSGRFburD8CAPQTV4mBlXj
	 hsBwb85KS93S1wubjzzXOXFZEZK+fmw7ronYfSREcEhmZSQ7Mt0n+AqEk0bIkGazeiVT3
	 7U9Hw6J7VS787NNvOEIIVlgdCdpVT0nA5jP3wFdY4IcB32BZFHTfeA0cCeg+0PYWKYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj0smSbf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A7606A321;
	Wed, 28 Oct 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj0smSbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E22E1F031E1;
	Wed, 28 Oct 2026 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164273;
	bh=DUbseAYEE+G1IqK7aQUzVK/2OJ86R8Gy/7HvczyR3XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kj0smSbfq765ieYkOtcDNKd21m74Hmrgr9h4jcU744iWhuoJ1yOnbBrSOso1/1DPR
	 Ra5iRzvNxojssI+OjwgF0qYzn/xHQLvquuKVW7yUskugHLlEw0wh8ny/eqLSfGBLTF
	 nbvjfhwZp+4GdHwGUjydfITMVQNO/CJrovr2mQkjfe2r4ZqOcD93WNGxYBwJUff8LH
	 uPW+lAI2IqkPN0CfwOy4P6Sz6W0O2FiLBITI7r6RzPoqQ+5Bfl66eqGDDUgKhMlyiU
	 CHfPcVEM4RyMzEJpxRoomp4o7IGm5NOoyZSUyi1vOpPawVWceFme2fyWe3ZvcUAlNy
	 qZoaaWZEGJ+IQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Tue, 27 Oct 2026 22:11:03 -0700
Message-ID: <20261028051104.154232-3-sj@kernel.org>
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
