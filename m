Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795653845;
	b=Wg2O3dHVGeOCBXTN4+9s/c/NnLVTkR/2RIqkI4ZfgRgLfXVnqn5uELzbsPd304sRDhpp
	 aXYxoqCYYtsCvY719cehvFF2Ediyi06xHYkp0zjvn7gGi5cdjbnPa4nEzDjIsIOMvQwMQ
	 J/IIV2Wn2H+4AdT4Q5zxIkQQDqe9feoHaJ2b1xBMmsNqlTTJtmihlUG1L4WpE+/mgMIlr
	 ufLY8pf8xs6kYp4fPUxZBR3EUqdBLNxEXWoX/oRdbgkhq1Uozh2q8+CEzbjQ5f/vdb4SK
	 UTRg7rN36KzQ4F+zXJHUZTY7znA1IuKf3N1wL6++edup4yolM+pb4Mz8QWUIFXeZfJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kntvEAl8c9UlNNjGZIvxtVFbdMIQt57S01N2AkNPnUM=;
	b=zA0RgEYOdxejEz7ng2A0mCZWf46c4h5i6fHUWYtw660TmXY7Kmjvg/dx2JN/aEObvtzB
	 +G2pe2AqmHgn2P8+45u0yAKavVpXxs6EJgYAMdfZogGiqP3mwcHYfAHqMSIJjTlMOBSSX
	 DXy9/0kTL0HR3n8rFxziUR8c4QhHm8D9PlieqiSVluswfhMjhQRcxqbDjgFgenInkYsRd
	 qWOJPpA9lEEArG/t4MYP0JSRbnv9+ChZrj776a31saf/8e1Li0KqcL9U+/Rnaa2LOSFnZ
	 njbnaDpzfpt4gZC9i7yZR88ea+aut/Iywws3D1i8KdPOLxxB5izG8lD/Iq/vZs+MM+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BoNrw4dc;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177D606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4177D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BoNrw4dc
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-384c78aa0dbso8483841eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653843; x=1796258643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kntvEAl8c9UlNNjGZIvxtVFbdMIQt57S01N2AkNPnUM=;
        b=BoNrw4dc0wesVjDd+co6oCGosrNKKDLwVcayt+Uq4JDCQ4k8wM2BaT2HXHXtW0y9yY
         4yB/olIQXKxP1SsOqKpKrjbsIb/X/tl52QhyzAgZeTIDME93CS0Ueyn2l4A57Hln3+fN
         xhG5/T3R4cR3Sk7Tr2VpUgisHB7nWyTnsc0DNzUomU4P55P2qw3ldNwZ1c/miXqHOZli
         g3MFFfT8Wz4gV3zJ9VHmLqnuViABWwA5Kf0bN+FiOMQQLN5PsFHIfFRTyiseo7gaXn1H
         LgUQQ3aeqG5JTHfVQPQoCIbGX2ZK/8906aAadolKVC8Jpps6NkYFE+DIgrPhygb5dkYU
         42ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653843; x=1796258643;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kntvEAl8c9UlNNjGZIvxtVFbdMIQt57S01N2AkNPnUM=;
        b=e4wRpmkqnYtl9kfdqnvVc6v7AeZnxO23g+LFWTSEmUwEVdU1AO33SXzS7CO4CFToRy
         oSAZ0WNyMwnEBj7BRRVSD8QRNkhmmV+KjY6tLrtbOaPAx82iBuu8kTqQsvxDgdLhCi3A
         TkE230yO9eIrmMBXrvzoS0T0azxtG60hIo3K+cBmPBSnWClWaGQhKQS5UDQNwgEAB3ip
         0ypOh26OqBSI/2xjyt/voy/JruVfc7GT3ZBmRtD6HAP3ndRsdyaiDtj79zpmjy2sAGYj
         iA0FnZUaHl2uFJcf1J036emdUCbpO59fZazM5UobqxDpkCPyN46GGVJSyuvxqAU4vaJm
         5BAg==
X-Forwarded-Encrypted: i=1; AL+hErG5gGVBQEmAEDRwhID5114XyRjppH15kxbZd0ySzGHHtU5U3Q859HcJrVrMXTrY+iybp5fVxJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WrcM6/oH3vN0OCBB5Lyt552y52ysP9dU76AF1fy5zMXGCvZYw
	bUIo3ZRBN8tDfZS/x13Oz8+w9ebDwCRk4myE1RSdgUzfWg6+0P2dcUOkJyzNjLWA3IbLjp5Jpdm
	jDw==
X-Received: from dybgk2.prod.google.com ([2002:a05:7301:182:b0:385:e49a:dd09])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8084:b0:36f:4981:da16
 with SMTP id 5a478bee46e88-3857073f5ebmr18632806eec.25.1795653842992; Wed, 25
 Nov 2026 16:44:02 -0800 (PST)
Date: Thu, 26 Nov 2026 00:43:32 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126004332.1712403-1-elkin@google.com>
Subject: [PATCH v2] btrfs: tree-checker: verify tree_block_info bounds in check_extent_item()
From: Elkin Cruz <elkin@google.com>
To: David Sterba <dsterba@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

check_extent_item() only verifies item_size >= sizeof(*ei) before
reading struct btrfs_tree_block_info on non-skinny tree block extent
items (BTRFS_EXTENT_ITEM_KEY with BTRFS_EXTENT_FLAG_TREE_BLOCK). A
crafted filesystem image with 24 <= item_size < 42 causes
btrfs_tree_block_level() to read past the item and potentially past the
extent buffer's populated folios.

Verify ptr + sizeof(*info) <= end before accessing
btrfs_tree_block_info, matching the inline ref bounds checks below.

Fixes: f82d1c7ca8ae ("btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

Changes in v2:
- Use (ptr + sizeof(*info) > end) with matching extent_err() format to
  follow the existing pattern in check_extent_item(), thanks to Qu
  Wenruo for the review.

v1: https://lore.kernel.org/r/20261125221849.1424464-1-elkin@google.com

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 fs/btrfs/tree-checker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index d2bf21c7b848..40f2355cbb1d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1665,6 +1665,12 @@ static int check_extent_item(struct extent_buffer *leaf,
 	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
 		struct btrfs_tree_block_info *info;
 
+		if (unlikely(ptr + sizeof(*info) > end)) {
+			extent_err(leaf, slot,
+				   "tree block info overflows extent item, ptr %lu info size %zu end %lu",
+				   ptr, sizeof(*info), end);
+			return -EUCLEAN;
+		}
 		info = (struct btrfs_tree_block_info *)ptr;
 		if (unlikely(btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL)) {
 			extent_err(leaf, slot,
-- 
2.56.1.839.g22a8290db9-goog

