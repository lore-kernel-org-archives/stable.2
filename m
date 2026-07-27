Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7993164B4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190816; cv=none; b=ZxOsy8Hkl7VlhAPn1rPvrR55EbcGw25KkchsqwHBIv469yvhhun5CbVxaAXG8gnFW5RW8T5gZYSP88D0j7MHQkGRjGFI+14/QP5dXvyz7UAlgtbrBQIswXUZuFEbovdltVY7ql5bb2J+gwPDHqRK9MrEVH4smtPuVnCpEPBjVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190816; c=relaxed/simple;
	bh=vAm4Dh8hVhGDRTvZy/J+RqjsZcURinoW/D1evZ26RpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8q0iVDudM8+5yga5ZGTLL7LIJtOuL05bFzA3rrxcwgtgo89ArNwyXqN3rxM34HJwan0A9uHDNspMGTJDvBDJJUWnKorFoB3muPEj0/oHEGvd/NrdNlqHFB0+36B2dOJideSCsgzpqD0/RMVW2GBk3JnKpm57RWOaxqx6m3QQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWHuO2zE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWHuO2zE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C551F000E9;
	Mon, 27 Jul 2026 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190815;
	bh=NgtlFWBPWUnhgDTw/1Rj/PQc/fTEUHFPtaqgeMn3ugs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lWHuO2zEYYjIXwp8p9r/+KOio1knU2sK9jixPLPlFm0hCzhiK4+O/ZJ8reCI8T67S
	 zMWWTEQ2FFeRc/SpbMDbKMYBQk9reP5ZLyT2sIh7lczK9F6KUkgTwx3V1Y1M9fi0Mb
	 xg9ub8+URV5iQAF3sNge+pgy3+S2igGNCnmK5+SCXjXQAvNlsPvgolV1sVMV0cGcSN
	 dWmvGjMYttwtCsdpU/z1MO4rX5MwDhTV9+iHaYmEu/xOfeIbffNrPRU99qJurd80rP
	 pwcvuvoseICfCNKS6VcXOioii36t88nagWXvbtTnwkN6Z9NMUi5zLA/2LXMyOfNoSq
	 fYTD6DOGReJvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-integrity: don't increment hash_offset twice
Date: Mon, 27 Jul 2026 18:20:13 -0400
Message-ID: <20260727222013.2117311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072050-accuracy-yoga-813d@gregkh>
References: <2026072050-accuracy-yoga-813d@gregkh>
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
index cfc3e82848d3de..cebffb0b5a1afe 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1474,10 +1474,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
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

