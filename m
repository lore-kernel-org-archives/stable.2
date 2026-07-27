Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F53D6461
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181858; cv=none; b=dh2h8GJkR7CpIDBJGQR0DPZ9uW/8icLD1/QnTrSHXMpijMA1D5EnjgIagJjGWFzXcG95jcvJyF7xSSdeTyGvAAT71qGUZXZZRHwOC65xogTVVNS26q9cXwpncLEdmczkOOd1SlDKc1YsoTNDkVCJPLru0FhXyt9I/mPqTknDeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181858; c=relaxed/simple;
	bh=qPJrhvmrrssuHOJT2jiahnJmf4tSuoFE1OseTSs3sjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH+CCmtlb8RHB6Z82oGo2ZGrdCgF1zQOb79WURiDOfiGqLOlAgo1s54df6xDD+4Lu4AwWdYuVD0oxBblkE4yfpwyLKG9qhJ5dJjKQ5qUd9uhSQqAW7r5anWxNOAEQ5F16disldgpoH2p+8s5eGuqWOlfDQj6BIReajy+WjYJaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSI7jbTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSI7jbTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1202F1F00AC4;
	Mon, 27 Jul 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181857;
	bh=YYu4r0CAyyRuD2grDMgw4CWhB8s3OA9e9kNkRun610U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSI7jbTwaCG3ZnlVKeyW4G842Li7oMxWK02Q5gqfhoOeAfxAz1qeQCWY+K1yJWTAk
	 UFIL5SFQnFFJG2/owRuLrdTNxQ3nYo6z2bSnVWfBnWFpp4mUI6CCGZxZ72gj/JNSfw
	 5W03IpMUGgxTd/sHfqpSxFA5i6PTpQYWfy6AwQx53qumJKVvQ/kC+ZkJemFtXtVB7q
	 RaHUez5/8xNdPQsXasWmHjA+Kn7dH5G8x0v6dduQp6TW+Vpk+C5wuxNxczkU/PcY7O
	 MS+/bz9U4RwsUM+00qQWvmmOuXqGqDpfNZ/nMymzcezjn1TPPm1GUEQP151Tcu+eNv
	 W2mRgOI8gCY6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] dm-integrity: don't increment hash_offset twice
Date: Mon, 27 Jul 2026 15:50:51 -0400
Message-ID: <20260727195052.1774404-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727195052.1774404-1-sashal@kernel.org>
References: <2026072050-armless-fidelity-4a3f@gregkh>
 <20260727195052.1774404-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit edf025f083854f80032b73a1aad69a3c90db236f ]

hash_offset is already incremented in the loop "for (i = 0; i < to_copy;
i++, ts--)". Do not increment it again.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: 84597a44a9d8 ("dm-integrity: dm integrity: add optional discard support")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index be4d489269c179..f552c402b3c17e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1499,9 +1499,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size)))
-			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-
 		total_size -= to_copy;
 	} while (unlikely(total_size));
 
-- 
2.53.0

