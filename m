Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0B46F493
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038518; cv=none; b=NdyWvrcwxjxSpewlEcBdowkKp4T1kShrxDQjPp5C3I2w5l2K+aRkWSqhIQBr+IqlRJlJWhsSphEH0Au6qw+as26ozPYjbwQFJUmQUJ8uwc0DkobFSFLeCmXrrHChB85h5NYbJ1l6YZIraXw9mVYSkdqFYQq1JZkiAL9dR7mnAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038518; c=relaxed/simple;
	bh=vwGl2mAv1DV/BwHQXkRRHvZAkk6d79+2CxK9iB2yoP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqG8mstvhuqqN0dsBoXNoRv5jfKZn9K1jBInBiP6sQnEhadE2zinvM9sZvVDzNK6gGNI1XAkJGEE5meu0Q2bRV3rwXqip5N2ZHBZN5ylf5S82FDVckGIu9P4CzGKHYQhz9oCHSkf89ktANwnnHH1qWBG5Bwx9i8e88g9ZT+W3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjxGB83t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjxGB83t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF11F00893;
	Thu, 10 Sep 2026 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038517;
	bh=XZLUpo7VxxOHQdqfeRRLWdgCelyxIOf+Ep/EuHH6u64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjxGB83td+6IS/6uzmNhMRaAJ+J8RzgVNBQcmA0bjlmim2o8NZAibvyz+5S1hJ1kL
	 eCWlcvJukYIdRwTzqsbbBzareGHJzPv7qLBGfLH1IT+ZN/XF/34cTjJPF2QbTWhDns
	 ws55WF56ahUnnz4L3PCkG+NO4Wp1snjxBaK/1U3NkrKasqQFyyKwxTIRtvIl5sK/7s
	 xvCWB7+xBVGbNDpVzBU9oIzm83T/BaJB2OvuRb1DAAo0R/oHNthfjeVCzD/2taHlWL
	 44W5sI+OTMrF8XDXo+V6kZtvkNMsnKBot/ezmgfyljMKDgGgb8/GrGCDYqD/ZG7BqN
	 c4Nxr5Mk8v/nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/7] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Thu, 10 Sep 2026 07:08:29 -0400
Message-ID: <20260910110835.4144700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090804-parakeet-recolor-7d74@gregkh>
References: <2026090804-parakeet-recolor-7d74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7965bea0b2c80..a1be5af740d34 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -269,7 +269,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (t16 > asize)
 			return NULL;
 
-		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+		if (le32_to_cpu(attr->res.data_size) > asize - t16)
 			return NULL;
 
 		if (attr->name_len &&
-- 
2.53.0

