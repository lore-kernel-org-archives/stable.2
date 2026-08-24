Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C2390603
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570987; cv=none; b=gwNKfehq6JcUdXbBlJhU/GhlueK2YxgGdHJMJUZoEv6mj2bBD7bVFkthfQhCnD0eCYYpHCv+IQfeC5La0mdVg/wKWOizycZBbuXQD7+4cX4HiqR9OK7rCTmfuD4sZJbDQp97ZKpfPGhLkA77RsyqNMv8dse/rNhwNBgNLvPB1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570987; c=relaxed/simple;
	bh=qAjbspjWR6RwB0+xOE/WuuhPIneJ3edg1UJSdtDQyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVycfYQHe+NErV+UOoXQSmRaDdU3qpPUeipeST5VwRq1h1DZxQI5u6jQ2IYYakhKCBSxDH3IA2qCauMTP2PrbUEl1oSE8YC+tdoMYKlkHxx5/uZ3bciuPqamw+uMkpl8lKGiDeA9t1w4DG13bPxjN9t0cYpcJJpUwMHCJ6o11+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsng2wB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsng2wB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D061F00A3A;
	Mon, 24 Aug 2026 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570985;
	bh=AFcHP0rqpfa8snxvw4xf83HOAh/T0gkEEyskfq1xLjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fsng2wB9rAUIkrmmgbxoehyfE9pmIecsbQiqTMZlblWTbS/gnaJeNgoza7faRoy+q
	 jgdEypEZpmIeaB2XdaJg8ndBzlqGX2vodI6ec+plhSBrYzGxIFwxT8B9AFGw9oT5wj
	 43IUMq2fx+Ugi/Dx+EYpyWe6LaytbCk3HgPW16VpO7G0IZYCtzjcTnWar+FnSQhJzG
	 +glYNULdYjOlYqS8Mm7BpeO9kDMkBPTdSPR0EV0K0pCRF6B3Jk5DXu2BJNRplP94qc
	 zRjbqubl39FrSgZstwntCDWgrCZMBlkIOZRwZ6MjvhwvOz+/g5VCUe0dLufNxxsl00
	 crIENGzZ7NJZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] libceph: fix OOB read in decode_watchers() via missing bounds check
Date: Mon, 24 Aug 2026 07:29:43 -0400
Message-ID: <20260824112943.529557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082055-disregard-education-f575@gregkh>
References: <2026082055-disregard-education-f575@gregkh>
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
index 2f1c461e0ffcc..1357793ae38f1 100644
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

