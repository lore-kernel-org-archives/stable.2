Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D83655E7
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213092; cv=none; b=q8G0sE3MBa5/+eXAFaqWFDpQEPUatp+jlj1ZcSQU2HxZW+eGC1v9fB7EWnCIpkWrRxI2l8XeFZB9nDgT0Ct6ybPAJY58lDIOwqvRkA3PhLtEvsM09nfVs60fndvtxqd+fPLInFFQOTIz8/gEdFnBAlW7ypUpKS+drvnrKBhpJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213092; c=relaxed/simple;
	bh=jMN/1aQdUacQw37CoA5G1RDGKU9+Br07yXHh8f3cvGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saZOF82e2j+SWL1XnFo2YKWJaRH2LEBPTY20ONo1iDk5HGLn226XZSQ8RYxpUaWv2GUEitOnKISN8r8IZ2acVkusXQyejjTJURsfmAmP6xCn1wptMyvArVXvAEBCua5j4b/7iOImxbX7L3jyShE6aqGtfKM6R+Pdk+uWfTiLygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QiQ7l4z4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QiQ7l4z4"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9158fbaa4bbso37620085a.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213090; x=1781817890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZb0xO5n0S2OTyc+rJ6TCTi3OZkKPUT9vDDGD9gSnOk=;
        b=QiQ7l4z4mHeOFhBSUrf9uZFSFGwaPnKViDMg51YBtaxhNGMHQVPrUoDFkPaop5D9pu
         Cfp95b2NPVcmrHtHjvvkAKUYNzE2LlJKaUmFm52ZBzbkMRb8/wv6XBDqGSNviOjqeytt
         F59YrlN/7gJT7n5IIVE8VUtKZRtdd9H9rZjOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213090; x=1781817890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZb0xO5n0S2OTyc+rJ6TCTi3OZkKPUT9vDDGD9gSnOk=;
        b=otHNYQyud5LFv8ubtSxGqT9ZRgoHZu+6YMRNua8kSiGU9YnNuJhznWVOknBojxkYHq
         QdTdkRkvzyvoeyapFYI1dpPnHnrLljhB9pg9c2+uPdiZY9VvaPr4UH0z2Gf8hplOrOzF
         /axldQ5Ac+pdyQ8c8ihewSn1oAW7gHpaOvwBv8l++dg2A2VqWHZsQiIoDfQ7hmQiedFy
         MO/h2IgXS8LMG7yBdB/m0t4HUa9y1lo/eJQVj3K9nVCAHKgw7d1RrFNu9VGfknJW2Gvp
         WypLi/rTSt2TXs5OCvdke67EVFkO8BTo/Z9nkb+yvt1TqZ9SIr2qT5HzwWNz0Y0z1o/o
         3e4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+UVh8Jq0kckFJ0LeT3uzvtIhmgbifyDgEG9gpaIeS7iPxVQm1vMcCyI3iL/bkr0hD5k6AmMPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ztETtRoJ8Tg7X1Wak2UOuRN/YtwEYYLBTvZQ5KyCtS5AIbYK
	/B6LRxQ4xevRHWd8g9cHSDrjswOlISPGfLnDMPnkoyYOM/xCRVdEKI7r8hoD09PWsws=
X-Gm-Gg: Acq92OE3MbWWkuhrmdH4D/Th2/VYyu/YuYcyEh3SAbKnB5EkqzBMpkIjnij5xaFV2qh
	4IyctSRGv6aAImaMmkRbrYeBoVq445ZnuyLcBIQBybIt03EGEphsO/9uacbNfhn87+FmekFRdJ5
	EA9gaRtSSAn1FXCEz3R9zH1xx5Pkq8ZZAtrmAoytUShIOMKgYIO1vPkGITGqmlKoDhoUJbnb1JX
	q5enAoTi+Lig50o5trp10W+/YU6P6FE0YIM6UlyOLBMCVUbazo7pFdaME/L+15dzvRcpy8Dug0P
	6MJuQVQeBSwPa0QXrc8IW641kDZs7N0gUy6h0eGxjXL5cuLtbzR1nJzomf2+VjDVCAzpbkrDgc7
	5e0NdcdFYbHhX2jvXGgK9lbRTY6N1l7hoWZI2tG829mDf/4j9J2va84QgDY4XBgJb4hW2UtcCwy
	jxy3VqtMTlYmJH//0B2DvLh4KoO0RdIkxgt5769LTDdgdqI4i4fvKjXm0strTY0BMM0cf7GPN6d
	h94N2alQoZigoSf5GZS5nJOCJDnueoJN18=
X-Received: by 2002:a05:620a:19a6:b0:914:b65f:6b00 with SMTP id af79cd13be357-9160ac7d1eamr718436685a.6.1781213089949;
        Thu, 11 Jun 2026 14:24:49 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a0541d3sm24925085a.39.2026.06.11.14.24.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:24:49 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: validate root ref item size and name length
Date: Thu, 11 Jun 2026 14:24:45 -0700
Message-ID: <20260611212445.4848-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROOT_REF and ROOT_BACKREF items contain a struct btrfs_root_ref followed
by one variable-length name.  The tree checker validates only generic leaf
geometry for these item types, so corrupted metadata can expose a root-ref
item whose item size does not match the embedded name_len field.

Several readers later trust the item size or the name_len field when
copying the name into fixed-size buffers.  For example,
BTRFS_IOC_GET_SUBVOL_INFO subtracts sizeof(struct btrfs_root_ref) from
the item size and copies that many bytes into the 256-byte subvolume name
field.  A crafted ROOT_BACKREF item can therefore trigger a kernel heap
out-of-bounds write.

Validate root refs in the tree checker before other Btrfs code consumes
them.  Reject items that are too small for the fixed header, names larger
than BTRFS_NAME_LEN, and item sizes that do not exactly match
sizeof(struct btrfs_root_ref) plus the embedded name length.

Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
Fixes: b64ec075bded ("btrfs: Add unprivileged ioctl which returns subvolume information")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1f15d0793a9c..fb072045ca18 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1915,6 +1915,40 @@ static int check_inode_extref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_root_ref(struct extent_buffer *leaf, int slot)
+{
+	struct btrfs_root_ref *rref;
+	const u32 item_size = btrfs_item_size(leaf, slot);
+	u32 expect_size;
+	u16 name_len;
+
+	if (unlikely(item_size < sizeof(*rref))) {
+		generic_err(leaf, slot,
+			    "invalid root ref item size, have %u expect >= %zu",
+			    item_size, sizeof(*rref));
+		return -EUCLEAN;
+	}
+
+	rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
+	name_len = btrfs_root_ref_name_len(leaf, rref);
+	if (unlikely(name_len > BTRFS_NAME_LEN)) {
+		generic_err(leaf, slot,
+			    "root ref name too long, have %u max %u",
+			    name_len, BTRFS_NAME_LEN);
+		return -EUCLEAN;
+	}
+
+	expect_size = sizeof(*rref) + name_len;
+	if (unlikely(item_size != expect_size)) {
+		generic_err(leaf, slot,
+			    "invalid root ref item size, have %u expect %u",
+			    item_size, expect_size);
+		return -EUCLEAN;
+	}
+
+	return 0;
+}
+
 static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 				    const struct btrfs_key *key, int slot)
 {
@@ -2226,6 +2260,10 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_ROOT_ITEM_KEY:
 		ret = check_root_item(leaf, key, slot);
 		break;
+	case BTRFS_ROOT_REF_KEY:
+	case BTRFS_ROOT_BACKREF_KEY:
+		ret = check_root_ref(leaf, slot);
+		break;
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
 		ret = check_extent_item(leaf, key, slot, prev_key);
-- 
2.54.0
