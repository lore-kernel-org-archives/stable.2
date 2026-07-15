Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483854CA279
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146567; cv=none; b=IWDX7P6hkYSkHSETbftAqh3NuXXqH4Gy7tKMda3ubaiIgzRq0e1YeOxDZwM7Y/69o2F6QmQLb5gyVoeX4fjAgLqCy/1lS6eKuq+Q1h5FKE1R8SXyI4fwgjeTsb6uRV1749SuK4bqB++zdnqu1blDQDPt4FIBJMLrL/lEgyN1pV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146567; c=relaxed/simple;
	bh=qa4Nr14oX94BLIu02YFOg50NTNAAy2vWVG8KrA8u5m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHJCtrj/HWz5spzNC8lD6axdiwyyRWefOR1iVsQolx0sxHMhZoJF2CpJu2QIZzi9hoIuCiRpbPoowNjUj6m4HJolwskygSbexEAI/IMM8fp7rxnH/sKDESKAWuz88FD0qlpK3J16NxABEzygIuxs+0eOGUWwKqSdXmfmjEycdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpK4uTTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpK4uTTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8F71F000E9;
	Wed, 15 Jul 2026 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146565;
	bh=Sz1Pz2UtIvL2K5YVY+rQ8w+73VKD2TE0N1uMcpu4etc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpK4uTTAljD3mq4/kq/C2yRYGWhDtnyyjNVgGD92LjfbLQr/dlfiWpQmrmTMksVjE
	 JGEwO/PIFIDnKXJFZvgIlw4zL+/FN05aub/apphEaYYLY+AvBpd1bnUyR76TgCovvT
	 cU+NSi+s/1NPcXkKHFpxSXLMRHKHx8N0L4D2LeKeWZrndQ1VRItQGDJ5M8Ds0ytPKu
	 XSL8YQL/SvAhuO594ZVz3WTVtJWi6RA1/RQgM8+wDM0R2nrmR/BPIa70Z1o+HfViX+
	 yDNIuDI8mxd8pfZQHkMQ3GlhvrHFvfu6IVv4o33m8HVtW+ULd0pqfO2DBy6nN0rNG8
	 mJnx0yQwLv6mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: shrinkers: fix debugfs file permissions
Date: Wed, 15 Jul 2026 16:16:02 -0400
Message-ID: <20260715201603.63084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071340-handed-risk-625c@gregkh>
References: <2026071340-handed-risk-625c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Keeping <john@metanate.com>

[ Upstream commit 2124f79de6a909630d1a62b01ecc32db9f967181 ]

The permissions for the files here are swapped as "count" is read-only and
"scan" is write-only.  While this doesn't really matter as these
permissions don't stop the files being opened for reading/writing as
appropriate, they are shown by "ls -l" and are confusing.

Link: https://lkml.kernel.org/r/20230418101906.3131303-1-john@metanate.com
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e30453c61e18 ("mm: shrinker: fix NULL pointer dereference in debugfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shrinker_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 39c3491e28a3ef..6133c8d00f116b 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -198,9 +198,9 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0220, entry, shrinker,
+	debugfs_create_file("count", 0440, entry, shrinker,
 			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0440, entry, shrinker,
+	debugfs_create_file("scan", 0220, entry, shrinker,
 			    &shrinker_debugfs_scan_fops);
 	return 0;
 }
-- 
2.53.0

