Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623378;
	b=F83gQHabltIv/0tEbwR3CunYwb5LSWHFAZAjCQNO4pnp/UBqD8yI4VJPZe8Irce1C9g5
	 khPlT1JTcsY/IyDlXWJBnA02nzl2Kvh8YYWbSMJgGVgZKkWxc8hNpO31ECldKEE73wpJt
	 +WF42INGe/l3dulxgYQXEN0Frn3U5BEaLTokd/RLeXeJtxFmajvxJIMiwW32wpiNrUmSa
	 AbRwjJ23ckUFEl4P2zNIqaFhv6zRnOPA+YmgxF1BZBXCAXdeIpFzyYli0O9dRtPGpkvbG
	 XGXLIxJgL9uSFN+l+PsN+IstUsTK1X0H9pmcbkSVytXgbbNcRK2dlMwqOnFvK8ZPg1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623378;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IwYR7jxyy0oU38HwdJ0V2hMTdj58xBYLEDilB4VyrlY=;
	b=zQ9rM+jWytUoQ58cvhF1Bc/rwgLb6KNwga1321zWVAWhu4gWXAcETqzcFy1KAbvcSo4U
	 GfyAQgb3qQbq5LCQSs3uIA6eGCApKainTzb47E2nADbeUsC23Dge0MsHap8BI/O5GtXnY
	 anQ5hRa6sTwbfvxDQMzvBmg0Og1keBk0h/6XPBqrSpGHARPHrk46IWdKUZOBOABUbTDuz
	 M1NJXoa6rYrCa//HOs93//oXm7ydP5QxAkewvSerbk24YK3BlDy7S+cWWunH3R4EIVDeA
	 RSXVBuzYWUvTU5P5WFCmVPqXEztwEEKsxJ8xgOl4NhN0HUzxC1B7W7vm6eOWoB904FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nawmy5R3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909F606A31E;
	Wed, 25 Nov 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nawmy5R3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795623378;
	b=HGWNJwKbsV7dLaY7pYib+NIJBTepEjLBWEBgY0ttxl3t8xU+YgAk+I3SikcUnclUgI5n
	 is4qcBzUwq2BMHyM3QPOjtvQCs05j4kTe6sLlClQKWifrbaoEGwKkMpccIi9VHEwxPSVT
	 MS+U/QhpFOzyk4UqqzXcRE0hOTceHTAZ7AO8RNnawmgrLprcYZ6O4xFTyi48W9Eo24iHc
	 0vg8Nc+4Lug2SjkkNmEZpd8WUlkO7byI8NVs70o4NGFYi4TfO8B9JJVxyesstsN4rNeGr
	 1TjigJimRFjE0CTYYLGEemNv1LJIINtSHzVJOKfWDn6bS+rqWr2Koi3YpuGqqD5Yt6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795623378;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IwYR7jxyy0oU38HwdJ0V2hMTdj58xBYLEDilB4VyrlY=;
	b=uuedYbhRy+alekMV9l+Gf7IfIaADthkGdthFV3WcCwlikbZwUWobQivHvdrqGsUQFCU/
	 evjAM7oygvcoZREUTl6npxPX6/TTFxrm9SA4V0kDmvvZ+71lS880qnpU01bT1MhncnMH8
	 n9vbJ1pQr9Y37Yv6oj/Om9LAtwUgzJXheENvwDF+EJpoyV2UFZEBqYhqc4A8kTLPjAhoT
	 A2Bq3M4Mlyk8ShgWnxZLvPSA1+BHp2aPBnG02pAed2EjhzCz3mYroEGY/IEQsB1icvZ9R
	 702V8wqxSTVzJj5hWAFitGa4MAzAKy3iuWqA67HPfzyxseM/T6PAH6ppBsgg9NK+BzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1B51D1F000C4;
	Wed, 25 Nov 2026 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623378;
	bh=IwYR7jxyy0oU38HwdJ0V2hMTdj58xBYLEDilB4VyrlY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=nawmy5R3E9sNrpBwSBLZ+SSd1Pj+dCjEnG9Sk4mzO/diiZiMEJhAKYqrmPigCEbbw
	 F5ncib03aObHeK9/3OQAvMfpKSFHC+MXxw+YshSbAxgB7TPbYi9yZ25+a+A/Iu6xdG
	 RbLte12ZKCoz/t35g4YXjoB5zAWIGGENd+NZDy4VFos3hfp3+PKu+QCAQ3gLYX6zjU
	 WvrGT9Xbqv/TGv8zX0Cz9zhfN+EORkwa9SJuyz6UBZDz6YfwllDKJVMPbR3ACTGzSF
	 ZMlBS96pj79whmW8cEDvCgHmABC3fl3beI0AL56mKEf13jGgFSZe3cTSZjyLrknFDM
	 NGKOclEcT+n9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 73DCB4CF5B;
	Wed, 25 Nov 2026 16:16:14 +0000 (UTC)
From: Sylvain Chouleur via B4 Relay <devnull+schouleur.snap.com@kernel.org>
Date: Wed, 25 Nov 2026 17:15:53 +0100
Subject: [PATCH] perf/arm-cmn: Use at least 2 bits per XP coordinate in
 node IDs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-arm-cmn-xyidbits-v1-1-6f7bee891859@snap.com>
X-B4-Tracking: v=1; b=H4sIALgJB2sC/yXMQQqDMBBA0avIrB0wA0bxKqWLmIx1BGPJaLGId
 zety7f4/wDlJKzQFQck/ojKEjNMWYAfXXwxSsgGqsgaQzW6NKOfI+5fCb2sisZWjeUwUOsIcvZ
 OPMj+Xz6et3XrJ/br7wPneQGnp47/dAAAAA==
X-Change-ID: 20261125-arm-cmn-xyidbits-16076edf28a2
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 stable@vger.kernel.org, Sylvain Chouleur <schouleur@snap.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795623374; l=2076;
 i=schouleur@snap.com; s=20261125; h=from:subject:message-id;
 bh=sa9PZCg2nW0vzlkWYPAJtFCSQhJMIg5Z6aFqeJbc3f0=;
 b=v8agyqySqDUxULbbTkNaysEzgYXGF2W7BwMxU/Z+NgcPXhzJMgZl8a//oBEcG1GqcKYbqI8kz
 7drwmw6dVbvAOmVnsA5sFaXDQwNFBEmM+zMoEN6tmjRLvhpuZbWVJFD
X-Developer-Key: i=schouleur@snap.com; a=ed25519;
 pk=T9TO/S3sm76Hkq5JdP/4AATQ2J2jGtskIHx0NY9lD4I=
X-Endpoint-Received: by B4 Relay for schouleur@snap.com/20261125 with
 auth_id=1639
X-Original-From: Sylvain Chouleur <schouleur@snap.com>
Reply-To: schouleur@snap.com
Content-Transfer-Encoding: 7bit

From: Sylvain Chouleur <schouleur@snap.com>

The X and Y coordinates in a CMN/CI-700 node ID are encoded in 2 bits
each for any mesh up to 4x4 (7-bit node IDs), and in 3 bits each for
larger meshes (9-bit node IDs). The width does not shrink for smaller
meshes: a 2x2 mesh still uses 2 bits per coordinate.

arm_cmn_xyidbits() derives the width from the actual mesh dimensions,
which yields 1 bit for a mesh with both dimensions <= 2. On such a
mesh arm_cmn_node_to_xp() then decodes every device on the X=1 column
into the wrong XP: X=1,Y=0 devices are attributed to XP (0,1), and
X=1,Y=1 devices to an index past the end of the XP array. Their PMU
events end up programmed into another XP's DTM, with the port/device
select of the intended XP, so the counters silently read zero while
the rest of the mesh works.

Observed on a CI-700 r3 with a 2x2 mesh (part 0x43a), where the SBSX
and HN-D nodes on the X=1 column never counted although the XP flit
counters showed the traffic. Forcing a minimum of 2 coordinate bits
matches the documented node ID format and makes all nodes count;
the minimum had been there until the node ID refactor dropped it.

Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
Cc: stable@vger.kernel.org
Signed-off-by: Sylvain Chouleur <schouleur@snap.com>
---
 drivers/perf/arm-cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 68a096c1fe6b..5f369c7a7a35 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -406,7 +406,8 @@ struct arm_cmn_nodeid {
 
 static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
 {
-	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
+	/* Node IDs never use fewer than 2 bits per XP coordinate */
+	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
 }
 
 static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-arm-cmn-xyidbits-16076edf28a2

Best regards,
--  
Sylvain Chouleur <schouleur@snap.com>


