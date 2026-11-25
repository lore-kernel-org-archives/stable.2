Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613221;
	b=5WtgTM+vp9O2OZJoyM3mhvW6mM598JKYlQB09B+yKPyb1t3qYeGqTraljsXos42G0TFq
	 kofo287HMbdPYEoAu5somuGywUapfc73oryP0z4NXZn4XgyIvjEr230GpI3skSabXHCe/
	 SbLpIgy2/oVxtHWvGRbGtCD8KDnk8UaL44sl5XMfJc3mRTzxApqFBMy3OZoXlNcPJ8wDB
	 5jM6kbL11/Lwj0yYdVfPkzHsixsBERdbJPpKYeI9NyNp9N6phU8hX2Fg/ECTnAVaPn3gK
	 CcNnlHUwxkvqv+ZoVm5vahoJCbpwbFLe+fN1lvF4bEC50ZRMyDmBsKiU2KqBfoV+C9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PCdnJD0xJk+LrDGLHGrRYeT85fqOhY1wR1tEr8GB5+M=;
	b=hEaYek3DUKgZ07kEVmdFH90LWzccukofAAArBxHvV3tC50Il4MyHhYXg647NiuVJZVnn
	 V8hiTGsW0rVOVJ0dNWuWx+7nOmS18IT65najAf5NrAsbGwlGuXoXPB7yUOBLCrC5sOeaa
	 lqb9p0Whj5Sdu2QD5792m3aV5aLGE9paVol9dieDwu/JsRU0U8QbcW1RvhBaNNkQu1VNg
	 T5rlc0PlyyloPLy9nuraJTaFfxLFReMRGaB8HjkTZpbStsLGKAZIqpGEWS/MjHKnOC7Nx
	 8oThxv8sykmcGJJwLp/KwcxdRMetzE5XAsa5+aDnCpp6SYihyoJsQqc6i110nuP6ULQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMjeLH99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C1606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMjeLH99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D11F000C4;
	Wed, 25 Nov 2026 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613220;
	bh=PCdnJD0xJk+LrDGLHGrRYeT85fqOhY1wR1tEr8GB5+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMjeLH99YKtN/zpAsN2hXVQ9AMu1qUzjGnrnT+KbR1hhKPIJ1gVqMwTenh646adCc
	 6IT9F4zXgWl/mxbGrC/T9Br63YkpjYvspat7BNVNuHWeHSfqSgSdL+hMwnWy/YMroi
	 RRsT93XaIviQDEAQT21g4o55bKCtIJbu2uEKVrCKmBy4a4zVkOLRQXMKa7EO25vQKb
	 sA4Dz7nRNSDv7nLq8wnd/pQBCVDzMG5ME1rW1jc7xkIKAZuRNrUFDyAlKs0lI9ldE6
	 G4xxKBSmrIlSK3jNQnkQfYB28vTLYhUUuYggq3PyBeO+gNSaGcCtibfMG8VtzVbvQ4
	 Ms4WhLJAIpnIA==
From: cem@kernel.org
To: cem@kernel.org
Cc: linux-xfs@vger.kernek.org,
	hch@lst.de,
	sandeen@sandeen.net,
	dgc@kernel.org,
	aalbersh@kernel.org,
	bfoster@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] xfs: move _right_neighbor_result trace before erroring out
Date: Wed, 25 Nov 2026 14:26:28 +0100
Message-ID: <20261125132634.113144-2-cem@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125132634.113144-1-cem@kernel.org>
References: <20261125132634.113144-1-cem@kernel.org>
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

From: Carlos Maiolino <cem@kernel.org>

The tracepoint doesn't help much if we find an invalid right record.
Move it before we validate the record so it can still be printed even
if we end up jumping to the error label.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/xfs/libxfs/xfs_rmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index 14aef87837a9..5f88aa9f12cb 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -1082,6 +1082,12 @@ xfs_rmap_map(
 		error = xfs_rmap_get_rec(cur, &gtrec, &have_gt);
 		if (error)
 			goto out_error;
+
+		trace_xfs_rmap_find_right_neighbor_result(cur,
+				gtrec.rm_startblock, gtrec.rm_blockcount,
+				gtrec.rm_owner, gtrec.rm_offset,
+				gtrec.rm_flags);
+
 		if (XFS_IS_CORRUPT(mp, have_gt != 1)) {
 			xfs_btree_mark_sick(cur);
 			error = -EFSCORRUPTED;
@@ -1092,10 +1098,6 @@ xfs_rmap_map(
 			error = -EFSCORRUPTED;
 			goto out_error;
 		}
-		trace_xfs_rmap_find_right_neighbor_result(cur,
-				gtrec.rm_startblock, gtrec.rm_blockcount,
-				gtrec.rm_owner, gtrec.rm_offset,
-				gtrec.rm_flags);
 		if (!xfs_rmap_is_mergeable(&gtrec, owner, flags))
 			have_gt = 0;
 	}
-- 
2.56.1

