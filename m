Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA840F74B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581301; cv=none; b=RbyTvTscf+Kbb868p8RpXpX0vCFag+sV/al+qmnucM81SpfWLME59mJ3HxvVT7Q7/JzM3D+UC0XcW7Yp4Co9tF14QiUMQc/JR1E/NemDGbXs1OTcFEaybHe49VqC3GDgbmP5JAq8VeL3xbLQ+zLI0ZjK6vQWjvNr4bc1VRN2HK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581301; c=relaxed/simple;
	bh=iloOwjuIdAtToP2DzY1qg0L36othTjD9dTOX8jsXwbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke0PGMf3Dhv8kh1Kun3xWXqye42MPbTwD0nqWg/pv6SYkhbxqDix69kWVMNK5O89xv/tsvHpxiXUDkIbvcL1+Jv8DDSASsPZMNB0HO8cuc1Dx3uBP5lF7noLJE1J4eiA/HaP+8lZPxtWmK5YZIvgmDLfJz4Ybq4Ibe8T9Wm57MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzlxNfcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzlxNfcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6466A1F000E9;
	Mon, 24 Aug 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787581300;
	bh=qp7yQRHioGx7WZpDZNzGkyPOp4VkpUD+c3O09d6Buys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzlxNfcTtBR7WIxPq9kM5ratLyulYs7obJeCZqx56fAzmIrmmAmjW8vmh5Hax2dRO
	 WzYTS63NLYKLyFUs3ow79mAy9VbjSaZ4Fcz1BmeAypsg+DehcGF9P4orVCkRGcZvVG
	 TiZnbUm2A1PioipFNA66uAD1dJ9hS9ZfnkEJ+3PcdYnu3gtb7CrSkfnx6Wz97rmpCY
	 uD+HhKyZu++9bZfkmRdq6RkfxeAeTLPjnO5+/aeqXZcam35dJAzc2v4Iz6wlfuvHuB
	 mlcMakDPIIrlJ7/YyWinpwE/aPflXrjCYupZD/OiC8QS1kyyNXtpjPgC+n6GrzmOlL
	 2Ydg8HSyNo+Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] libceph: fix OOB read in decode_watchers() via missing bounds check
Date: Mon, 24 Aug 2026 10:21:37 -0400
Message-ID: <20260824142137.3354227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082057-overload-cycle-4a9a@gregkh>
References: <2026082057-overload-cycle-4a9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavitra Jha <jhapavitra98@gmail.com>

[ Upstream commit 00ead17c7de137a692edee59f2772e6af687e8eb ]

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() as the watcher count.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, bad), consistent with the established pattern.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

[ idryomov: trim changelog ]

Cc: stable@vger.kernel.org
Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ kept the tree's `kcalloc()` context line instead of upstream's `kzalloc_objs()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osd_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a4ec9f61ba045..76194a9e59f08 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5001,7 +5001,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5015,6 +5015,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0

