Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319679;
	b=NSttMVMkP+r5QvlmTjrXt5dmoAML/MUZDzVdgR4nyWDG8H2Tcoh6aA+SA5APkrZX3f4z
	 PUFk3Xgg4ba5YcVD31E+40ONj4S5kP99chFuRlbOPfIC9f96Pfl0DRIZHeJDisrQ3yr7+
	 OLBH0+KCeIyi3Rpolctt7Z3j2yjdfLbe9p7elBcnD6L1Ho7FyZ0SMhd/hKvmt+geVFYQp
	 ErdF0E4K3x++FFtVlWGGFvKREiuYgeuJ4WgthOf/vXCuFaa2d2lRMpxKXhVWnVC6oGbhw
	 ctSfQe3TFSPoPiRVL+HVRRv6K0XCmYS3Hn99arrvcGBkObE9Sn5j6sdfolSYWcAWoTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3i4b2tOVq5V+jbPNFyMXIlRN/ELRvWnO8Kpd2bFoQ0w=;
	b=XtKFkIbnPrutwlIkLjN5pr9KSx18yPWlDLShIoEKvviWGIQ9zQaW6VTcPXe60rJQXTB6
	 43Wdo0ys4X0fo0RbTxuTlvm1kiYxjGJK23S/Oso0uYetXVq4KaxKGDhTM0cODYv8wjWvO
	 LqqqN6N4aMpjH81G/959wc641BNSkS/eD3HI7vcsbPnYAnPQN1nxyynYkmzmpQFyegGt9
	 vTXwVQmWdD/LeJlYPz4OERbk5jM6GUDBSctrxOY1n7HEoT9RXaDI8JQIRXhCaFpN/QCEF
	 aReFJm8+QEL9Xvnyx7hLiaxWsxzKnAHt9J/tiRDeUwOZtj7cBz0qxpfLx8fRHbehqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot5GQyhU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD11606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot5GQyhU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760BD1F0089F;
	Tue, 10 Nov 2026 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319678;
	bh=3i4b2tOVq5V+jbPNFyMXIlRN/ELRvWnO8Kpd2bFoQ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ot5GQyhU8iwXsDkQOk7mOM5CP8ZbkCZsKAie9X3gUjO664jF2GYA9BNNFSTcQP9q7
	 eYKPm/THwggd07qXnPxaiuKd0q2c988NutU6/2kaofxs7o5fPxmubnH843mORvxXv4
	 CLCNRBiwYDvGKQ+djHS6b4YCqJKIFy6Wu6NfRr+pddTdTepgj5mXukz/sO7jwm3NEa
	 EQsEkfhNFv8VMMzeUJzz8kVu5XXA/3RHQzm+GG2uMA3l3AysGO5XbYm6Tdgls5cXnY
	 JAwz9hceGoqc2/8AD4pPLnes+DlyOJAvwBRfF+yDuvfaptgdZAJHklZjM0ldlN+icM
	 4rMmMmAOwoZ8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-writecache: report I/O error if flush failed
Date: Tue, 10 Nov 2026 09:07:57 -0500
Message-ID: <20261110140733.1828251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061802-failed-5.10-78a6afc2999d@kernel.org>
References: <20261107061802-failed-5.10-78a6afc2999d@kernel.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 78a6afc2999d26e5a30a56db77db34c22b88f5d5 ]

There was a bug that if writecache_flush fails due to I/O error, the
error is not reported in the FUA bio. This commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: opencode:big-pickle
Cc: stable@vger.kernel.org
Fixes: 48debafe4f2f ("dm: add writecache target")
[ sashal: adapted the change to writecache_map() because writecache_map_write() has not been split out ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-writecache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 1b7d89794c6a3..f8b671299c854 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1454,10 +1454,13 @@ static int writecache_map(struct dm_target *ti, struct bio *bio)
 		} while (bio->bi_iter.bi_size);
 
 		if (unlikely(bio->bi_opf & REQ_FUA ||
-			     wc->uncommitted_blocks >= wc->autocommit_blocks))
+			     wc->uncommitted_blocks >= wc->autocommit_blocks)) {
 			writecache_flush(wc);
-		else
+			if (writecache_has_error(wc))
+				bio->bi_status = BLK_STS_IOERR;
+		} else {
 			writecache_schedule_autocommit(wc);
+		}
 		goto unlock_submit;
 	}
 
-- 
2.53.0

