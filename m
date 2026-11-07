Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050284;
	b=PKK1C+g+2sFpBqF5luGNxSTsgSgj6LT5YOjD2ozMNMdzLmjW6biKu2LFWZrH/WXuRIqi
	 IGTjRzJ/+pIZLTYb83uIcv7R+vWUpblYG57cgXa5jwvRTOX/E0BUSx9yS6HOIYucpzoUo
	 MawsWW9CZcKTNQtw9FihgWvSZ9ptyLFAYzMo7VBG/tgl+e8HkNIJCMVboKJ9S/YKY5cL8
	 mTZ8kzZi3a1NWxu7yEikY8WS9KO/BQ/nWz7KUc9RBdC1wFfQ2XUGMi2nxslktY3gXCceJ
	 o8UqQbGilnz1uxPpB/G2AhJz53/upifieZ5irsPsCh3J4naBhoko8rlcwr98OaM9KZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8W+QcK2aF+Vapr8vtpPd5ceWP6lw833Rfsd84Lvx1UQ=;
	b=fhC5eizcFVfPaaOQtIClHP0RHZLWHWm6qJXQSFPVVIJ2Zm4kIwFa3wjtfq4qI8kIvIUS
	 xhjKTyHamcwP4D5hO1T3tr4SCLxA2JTav76bKvRSnTOW6dginXXIPI2KZETYaA79jcgWe
	 Waya9c7bYAaLK0SLyf2BBUhCAxGMkQDavFpZaW/alfEsT51heyX648Y/I0iYDN2MNufVl
	 i974Bf7R4nquqwomOVR8NNbYcNwPTamp8eRHLG2q5/6MsH2yHdJJw1zVWmPSIE+WXBk7O
	 YylW0g9E/20EMqTHpuXaN00gQYNy1h65slIkmcR7Je6afQYm4E90Ld+2O6zJLBuevRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abQUVJvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abQUVJvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7E51F0089F;
	Sat,  7 Nov 2026 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050284;
	bh=8W+QcK2aF+Vapr8vtpPd5ceWP6lw833Rfsd84Lvx1UQ=;
	h=From:To:Cc:Subject:Date;
	b=abQUVJvgC7bsryufLZogvNFEgzUCMth4icyAAgUfnUMKmB3yVNaB30a4TN92w1diI
	 sVKYtsQbzc1rxX7oTcjQaZvwgBYjC5UhkKO+U1GDUBLqw6pLvTxbpz9Q2RumPaNOd+
	 kGABARCpWGXjUdKgKSXdDJR00VohBzsFtcF+JIo2I3O8D1dXKxBM3Le8wFCntsn1n6
	 IgnyhvUqOOU3jELgbaTqTIZE/CHi9i88DorxqSp37iV7o9Ln+1K8JHPrhziekU+NpL
	 HhQLhCJXWWZ809fVWq1R5I7hgDkKOhn/k7Tmgqo+T0ibsWqJ9h1RMCS5L9qOzLoU01
	 uinfT/a9//MlA==
From: Sasha Levin <sashal@kernel.org>
To: mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm-writecache: report I/O error if flush failed" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:02 -0500
Message-ID: <20261107061802-failed-5.10-78a6afc2999d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 78a6afc2999d26e5a30a56db77db34c22b88f5d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061802-failed-5.10-78a6afc2999d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 78a6afc2999d26e5a30a56db77db34c22b88f5d5 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 30 Sep 2026 21:38:25 +0200
Subject: [PATCH] dm-writecache: report I/O error if flush failed

There was a bug that if writecache_flush fails due to I/O error, the
error is not reported in the FUA bio. This commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: opencode:big-pickle
Cc: stable@vger.kernel.org
Fixes: 48debafe4f2f ("dm: add writecache target")
---
 drivers/md/dm-writecache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 68e3fb300fc14..e278359cb268e 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1494,10 +1494,13 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
 		}
 	} while (bio->bi_iter.bi_size);
 
-	if (unlikely(bio->bi_opf & REQ_FUA || wc->uncommitted_blocks >= wc->autocommit_blocks))
+	if (unlikely(bio->bi_opf & REQ_FUA || wc->uncommitted_blocks >= wc->autocommit_blocks)) {
 		writecache_flush(wc);
-	else
+		if (writecache_has_error(wc))
+			bio->bi_status = BLK_STS_IOERR;
+	} else {
 		writecache_schedule_autocommit(wc);
+	}
 
 	return WC_MAP_SUBMIT;
 }
-- 
2.53.0




