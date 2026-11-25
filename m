Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645152;
	b=wXcvO1ak4bx3m36ch1sXALz48HH8XU3S+l13ND5wcZgWdX1PbIyVAtkeA9+fA1FWqKcS
	 9r+71U+ofdyLJqLa8P2Lc1JiW+RnXzYWvWrLHGpMFfbIUtnopcwkjlT8ZYGnwxMR9/i2l
	 0mBaPboz7etv31s3HS5/B2RLBDFYku/H4ra91PCdYAjnR6SD8JUE2tQuU2KQ7sBWFzN6j
	 ZAnJrY84ggfbONiiJmW+GIcjwGJEq+m8nvi2VPfezF1RA9MJpeCpIV372ywa/a+GlcLzw
	 3ivXaPngUbgFcuRa9lwgWaQaRn2F4WyGr04L46oxFR7E3EHutMkx8JWbA7umCp9zlpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HRwAz9BoxRqxj0ai++/VXeXT7drQEfcQGrxsvupjxW0=;
	b=RKFdNdq/nipgyfgddZ4TPeYvbraTW2Ez/iVE0aIEB9HyLReJYSY9ERR3THoBjWcmX5gt
	 /fioc6g0n25GtqpcC5kNity8EjqgF37C+sKHv4L33+Gw39eU+2xRf+ucOYXNOig/5LTKz
	 JIFcey+NQP6AcbmskXxXrcVM6W1tNuE4z8avuhsALCJzea9OdKbrWM3/0Ikba+16o9wfh
	 KL7fWPPD2H6rLQ1wEXHyiMq0zrh01P6trtXfrskfG7qm2Eh8OOl5P4hHCjXBFGaJboBWz
	 WPuRDUyoSesDRGK/i6POvJzokj1EeGjFuRuAAhiELCRhi58kyQCko821skJ/D0faG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j5ePXZHq;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84172606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84172606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j5ePXZHq
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-382af5cfc58so1791258eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645152; x=1796249952; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HRwAz9BoxRqxj0ai++/VXeXT7drQEfcQGrxsvupjxW0=;
        b=j5ePXZHqAU3bIuVeZPFXuWus8/cUkOn1VKam5tbxomu5ZPUfkcoZrAmuaeiWyZ6Zbd
         6L+RARaUcPgY48SatHcAIMXbLahr7V3Nc2WBK6lD8eMGAh97pPfRRNuNyBgeadLlw0M1
         dAEipdXMyJ+AM+R6tWj4QA4fCM4h5g9W32jLFv4qLNaEzhWC2Qmq9XS9xbmRntnqdBeC
         AFUbkHvLCKw/5NfMcn7HvSYIwN8nNEavQvbOo2pei3V7LLZdx2wNqYsg0pzlbBmzNkcE
         Fn4euUtG7726sPsWVmpJyffUFQ0XJ2D/i/DzHD+ueEdNNwFGuqXBk4otTxBGbndgy2jT
         AnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645152; x=1796249952;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRwAz9BoxRqxj0ai++/VXeXT7drQEfcQGrxsvupjxW0=;
        b=brFizZEqgeUuxiWUiw5xYYmUYsZ5YWhiGsOU3HfacteS65Xxc/291an/fIijMobCJr
         eoqZ6lbkaiPoxFYJLnYu5GU6uGZL4ysC1lZVQHUEU6zklS2yvI6cVCzCInNWv0kw7l0D
         gt9SLnCzWsKU62Yrj9XuUeTWKVT7ggNmJFxLVZVg1wNCPBN2VhFRvuiPENtQA1kfNRfu
         LjD3kNhGygRd4q2jjBDIvomOMp2LBiKYqK7FbkhWsY3XWcumTb2wmWNQK5hG2Zi8sLKH
         lUKGG3jrqmL8NX2s4Dspg1Dfn+KZ25BhXsijlzeANfrDavzYwr8dNfTCUxwVnGzB89o6
         xzIQ==
X-Forwarded-Encrypted: i=1; AL+hErFY/JwQzZrBBNxAYviCHzvfEfJbg44w2ARElASbZq3EgPi2DCW1LPd/X0bd03vKRESyBuzaC0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jdiXYUC0uxBCpglAVEzKXIlSDp0l3hexl7abNBwJEnsj1Yg+V
	Y65hhR0p+5PZCRc5ifOFIIRaxEdxEAQyz94UZZUd2jkhtyHSeC8alGLDD6SW4cG2kqakwJ9xCuY
	QNg==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:385:2e0b:4776])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd94:b0:36c:9afe:fcd8
 with SMTP id 5a478bee46e88-3856f559cfemr18733738eec.30.1795645151282; Wed, 25
 Nov 2026 14:19:11 -0800 (PST)
Date: Wed, 25 Nov 2026 22:18:49 +0000
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
Message-ID: <20261125221849.1424464-1-elkin@google.com>
Subject: [PATCH] btrfs: tree-checker: verify tree_block_info bounds in check_extent_item()
From: Elkin Cruz <elkin@google.com>
To: David Sterba <dsterba@suse.com>
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

Verify item_size >= sizeof(*ei) + sizeof(*info) before accessing
btrfs_tree_block_info.

Fixes: f82d1c7ca8ae ("btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 fs/btrfs/tree-checker.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index d2bf21c7b848..a38eeef7b859 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1665,6 +1665,13 @@ static int check_extent_item(struct extent_buffer *leaf,
 	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
 		struct btrfs_tree_block_info *info;
 
+		if (unlikely(item_size < sizeof(*ei) + sizeof(*info))) {
+			extent_err(leaf, slot,
+				   "invalid item size, have %u expect [%zu, %u)",
+				   item_size, sizeof(*ei) + sizeof(*info),
+				   BTRFS_LEAF_DATA_SIZE(fs_info));
+			return -EUCLEAN;
+		}
 		info = (struct btrfs_tree_block_info *)ptr;
 		if (unlikely(btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL)) {
 			extent_err(leaf, slot,
-- 
2.56.1.839.g22a8290db9-goog

