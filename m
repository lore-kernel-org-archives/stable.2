Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F33BBFCA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715147; cv=none; b=rGsRwZq8wUAh0pVSdDLUWW9yUMCug6puxhPGyu0EvlVcvXqsLa6Q0ZhaZ6Iu6Lk3ebHRD3qMsY1mwhkSePiAdADeBe6/nEGFUkcl9vw/18hUOV1FzZj1TREQeK9WOG57+qgunr/cqmc1YRQ8kNNOkEGeLlwlNtJ+TBOvqAcOGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715147; c=relaxed/simple;
	bh=GGGxfO0Qo0dxpzVrm9yXcA4os1ySTtqqs7LY4j9g1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOAyQTmnQJaibiyqtlbu78tGYXwoEzv/Z1o2I9nKYngxE+HNBcPvzOv1dbNeoI8CvHyFTQg17+vRrrQnSlRhc7uFXFUi58wcBQ7c7ebOPsZ106PfnzvndFMlI4hqfz1zgTSYWEyCRKZjVbmk9/FZXlfL0TrP2Vm/kNPTWWdK3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo5PNRXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo5PNRXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF891F00A3D;
	Sun,  6 Sep 2026 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715145;
	bh=oUIbDkUxV00Uws60O91MqzG5jA/3swIXZGRdMumzm1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yo5PNRXPsUpL6dSF6D1lvhYll6+7wCC07PASLnQ2iTo6GfupXLQGmlW1v6XOYNhuj
	 /jH/jctoUDvIrGzYXgtPtnHq4jC766VTVYOeBvBAyETAU5sWkgmJV7zqStUEzvT1mu
	 kybZb2V9syMVAEwf6+24jkcgiisCqlgl7SX7rGjac1XS6dY5OiNok+DDvQsEcfXj7w
	 bl1BruhXF8JoDQN3VwcMVTov2ML1N1lELBsfduEkDed5HXfGhgl2M1agJKPJZpe2QE
	 8pya/2DZW2yFxyqobl78V8Tr31FWz+5Vw4tdLQpVFjqSKh7mkoC4fIXobnL9h+ye/B
	 lQC0vMlA8vOyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] btrfs: do not panic in __add_reloc_root
Date: Sun,  6 Sep 2026 13:19:00 -0400
Message-ID: <20260906171902.1684623-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171902.1684623-1-sashal@kernel.org>
References: <2026090300-visible-upwind-24ae@gregkh>
 <20260906171902.1684623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 57a304cfd43b2b4a5b44b8f5dc026abb34183068 ]

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  Since this shouldn't
happen unless there is corruption, add an ASSERT(ret != -EEXIST) to all
of the callers of __add_reloc_root() to catch any logic mistakes for
developers, otherwise normal error handling will happen for normal
users.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8ac37034c6561..0442cfe70b323 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -638,9 +638,10 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
@@ -882,6 +883,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
+	ASSERT(ret != -EEXIST);
 	if (ret) {
 		/* Pairs with create_reloc_root */
 		btrfs_put_root(reloc_root);
@@ -3862,6 +3864,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
+		ASSERT(err != -EEXIST);
 		if (err) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
@@ -4092,6 +4095,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
+	ASSERT(ret != -EEXIST);
 	if (ret) {
 		/* Pairs with create_reloc_root */
 		btrfs_put_root(reloc_root);
-- 
2.53.0

