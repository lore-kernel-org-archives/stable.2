Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D519286D60
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608823; cv=none; b=k/ZiXESd3mJI+pM9Vm/OV6o4qm9C9MFQHm5QO1MdyagbZIQ2hYzB+87OJI48Ja/idmD+l3K740yPiAPCDU+O6r/eN0zIBA2BG92hr1GzfeV5ocAub+f+kTHTnvoSgXvo/MaVTB/sn3TYSzooPzgBtpqF4RkeM4hnHd1zyXoUA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608823; c=relaxed/simple;
	bh=6SFPBejrAgjJ5FdX0by3KUhlXYLkJw+fGyi3lfF7BU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6KYXwuA1FfO0nrQfDzbfXdRpMWZrXioqPdxfL222yKQZJvAM7RaV1bSuk/Eosrr7tJjV8QSAMKuytrPQ5/B+XMNiNE8myyFZVGXxL4Iz2IWHXuwagxT4J1KSnHLw4zckwWCtCqASTfNbwdPciG14jC0I4KLhTlJUOR/cp3RoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVxWZbz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVxWZbz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490EA1F000FF;
	Thu, 17 Sep 2026 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608821;
	bh=kyjOV897vZrLnXnqVZ3Xt+XZq5yBY7MsfnvGPZQKI9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVxWZbz84T5LGB8HwpgnKhGN1VKCGhGp2SDMixE+9iKsX1ydF0/FziyJK6Zs5QALF
	 yhj23k5dz7MqX3QcLc3Y6MpEVbmKEhGL4FRhGJGm6r6Czk+XyDaenLO73u/BkCmHIn
	 uX42asHdhfR8xLvXPZu9zzy2T0m63ZRUKWGjTuj6VZG0KjOWY4Dw+5hB1vEw9MYe85
	 tKnApQWviuaFcF1y6joGs/qvnXBstAUTrq/RfY/QPb/FNS14HTwIG/pugr67RWizXh
	 Z8MJaSz5lv3bwMJwaLprPTbS2y1+jApUH35eqoCDIdjuiKCYAvdVRnldQB2ziC5rgh
	 /Z0ks2VEHArNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bootconfig: Fix integer overflow in initrd size check
Date: Wed, 16 Sep 2026 21:33:39 -0400
Message-ID: <20260917013339.3597547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091617-recite-disperser-28e0@gregkh>
References: <2026091617-recite-disperser-28e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 7812d6dab0698001e50e8c2f901e17da3eb6f429 ]

Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
arithmetic:

    data = ((void *)hdr) - size;

to wrap around on 32-bit systems (or when pointer subtraction overflows).
Because data wraps around, the subsequent bounds check:

    if ((unsigned long)data < initrd_start)

evaluates to false, bypassing the check. The kernel then calls
xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
hitting unmapped pages and triggering a fatal kernel page fault during
early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
unbounded 32-bit size can similarly bypass the initrd_start check.

Fix this by:
1. Ensuring the initrd is at least large enough to contain the bootconfig
   footer and verifying hdr is within the initrd bounds.
2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
   the available space between initrd_start and hdr before performing
   pointer subtraction.

Link: https://lore.kernel.org/all/178905333479.213925.1358412668943562406.stgit@devnote2/

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
[ adjusted context to preserve Linux 5.15’s existing bootconfig footer access and parser API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index c86df2005204a..47137aa53e46f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -274,7 +274,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 	u32 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -291,16 +292,26 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 found:
 	hdr = (u32 *)(data - 8);
+	if ((unsigned long)hdr < initrd_start)
+		return NULL;
+
 	size = le32_to_cpu(hdr[0]);
 	csum = le32_to_cpu(hdr[1]);
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start) {
-		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+	if (size > XBC_DATA_MAX) {
+		pr_err("bootconfig size %u is greater than max size %d\n",
+			size, XBC_DATA_MAX);
+		return NULL;
+	}
+
+	if (size > ((unsigned long)hdr - initrd_start)) {
+		pr_err("bootconfig size %u is greater than initrd size %lu\n",
 			size, initrd_end - initrd_start);
 		return NULL;
 	}
 
+	data = ((void *)hdr) - size;
+
 	/* Remove bootconfig from initramfs/initrd */
 	initrd_end = (unsigned long)data;
 	if (_size)
@@ -394,12 +405,6 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
-		return;
-	}
-
 	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return;
-- 
2.53.0

