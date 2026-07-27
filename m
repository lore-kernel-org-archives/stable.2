Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F503D4108
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191126; cv=none; b=Wq9kwO0B8EEJfAafs0M9+3mwumZsZXvQMZuV6k/gocHo7D8PMqzkqsBqSgk6aG2tawyMLWlTkxAc9X83NPrr+L9R6AVS9061NyPJT7nYjCxhxCqSKQkeVh3xbVdtmg7zEbe/+TQGf9yKFG6ju94f4bX0+HUoChXYVOFwRwwDwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191126; c=relaxed/simple;
	bh=s3ZEpV8Ml1G/UrCQY5WA4n22wSUoRbOOefTHP8GW85U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ginDglMNk0setpvLTJZiuPDJRdfjcFBZ274sL4kvfPD9RkiOGCndNiLRc7OJIwNFPwlWB3pMLhoeCcce88Jyy5HXO8d15Ap/UhMs5Lxpyxx7Hwn9FM7VsFUviqLmbEI2JBNtHeXW+R17XUpPGq//6dlgAMJlrgydEOzikLwUh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUScHWOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUScHWOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038EC1F000E9;
	Mon, 27 Jul 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785191125;
	bh=XPErj1XM/DbUqSswIRObVl8UIuhtc1DSMI2eOHU96PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUScHWOaOxZK+ywrGxNppETg961ChFWY7NG2Nb8RNB6G66n5ry2By7w/wdSoomOv9
	 QApoObrqUrx/DvEoErKwSdS6M1IZioKihBxLMjCApR+f3YOJ6olWsOaw6TZPTqmVKe
	 8GfLF/7KuvcoTiVpEKfVuTqITlEh6UemMwJHI+fUk1mZFk03sU9K416oDoRL/zicf6
	 ZibUY1ZN+Wcm2DrqoMR1cZSFOndyM7Z9I2IXA52BHJ1c5vLgADYR0L4DpPgzYzksrA
	 pan18x5hDQxO1gzlMeBreWBVkTNOFzg5V5hT0DTyY16L6zqHvjMYRTq079eAT8M/51
	 ccpX7qp0LHucw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-integrity: don't increment hash_offset twice
Date: Mon, 27 Jul 2026 18:25:23 -0400
Message-ID: <20260727222523.2142515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072050-unless-decompose-8395@gregkh>
References: <2026072050-unless-decompose-8395@gregkh>
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
 drivers/md/dm-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 227ed3b4687323..eb13b98ba0a9c5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1377,10 +1377,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size))) {
-			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-		}
-
 		total_size -= to_copy;
 	} while (unlikely(total_size));
 
-- 
2.53.0

