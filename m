Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61FB435AAB
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580360; cv=none; b=nUMkIxbCwhYHtu/CWHEqvDKD0ZSqbuJ627awk2vzOBKKgFUJOdB9aKkY8LKHLkzWQi03WB4Jrcm7QPAVmhqzUYBk7pzwyX55fx6Im2Qhre9UzANC+4W0tMENynMR0tFRpB442lRJEwKXY3ZHGYjyGCBagR6GGhO9TDhY7Pc7dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580360; c=relaxed/simple;
	bh=ojioM/5vcoMdFGYzi5thN3sX1XFzYeVv3UVADOzKXCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHIx8wxsn7UiMZm77TG5O2Cz/VsOvV8aeYu712xYTgSHovzHTTlwxO3ahv3VHD1o1a0ESHV9p81QBTxIa4wEQq5x1u7ISmRjpVi99tRqZXKGyseM4brAF/kvJ98MINLMv4emYcbWaALSudfbn2HSdVQOgg5btHN1oFMR9NFKffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkCJapoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkCJapoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A9F1F000E9;
	Mon, 24 Aug 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580359;
	bh=dhOjSHkVuzZQCZbeFg1E9dSzdoEEGjgoqbHEo32Tdls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UkCJapoCAVigiwlOr4X/PTT8GIyUPdV5xsZjQyD1LGBnCipYO/lk+hTrgV9a5ZTV/
	 0E5RXfUwC3VNOnmYpyXLy83eUbNk9An/YSH1SDUvktbnRA6pCr8SvDOBVfQ2ADupH0
	 UCFv/d16DVolWDLhJZqCa6q0SJqe9VjtP7MUU3eq/f1zpS67OCNM8V2T2CTJ8przGQ
	 WzwjNCwF7AtlcUSW/2fF8s6SZaZxjYXLTDwJ4dPkz3F71RLwd1iJlpfqsCI9ffXco/
	 EOrHqugrioELgwWs54u2rUenqi0I0PjZ6XaQ2l5iAjzC7CyRFK2s5Wk1KRsTflbtLm
	 LepJZd/UeecRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] libceph: fix OOB read in decode_watchers() via missing bounds check
Date: Mon, 24 Aug 2026 10:05:57 -0400
Message-ID: <20260824140557.3098009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082056-tingly-moonbeam-e4a0@gregkh>
References: <2026082056-tingly-moonbeam-e4a0@gregkh>
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
index a86ba8b785754..8c1678f10440c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5090,7 +5090,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5104,6 +5104,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0

