Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEA1F938
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566714; cv=none; b=Zru0N4XY17SXt9zs6YRybL+gjiruaLhK998DONWJBxixeQ8OAClyijH0MCb2aJrOjzIZl2+0kKxQfJ/FUxiTYcE9GFcRCEEEtKplSx1JJgz8AeHxAmBvx4YtcgpZQatsb/Czoy4g3XfGwDkDSXThOfzld6nVmYSq9U7S322RzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566714; c=relaxed/simple;
	bh=eJ6Q8zK4nOlvNmOOhipx0OnUcg1VFdcdPcmXWx52KOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWlR2xhNCpnGtSvCLoa9iejp73LpRIjcoFNmp9l2f5KrgL8hmFLbYg6mO/IDwPip6f2ZVjLLIYSNrCPAxoJSOBLBAfpsYuzNQZqZb2iJdf5TfjFg9XZzjFRFU1cbKjwtC3R6BKDSuVL+ONJctKtyeQoH/TNHlq4dl4GicHdAly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvL/DXNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvL/DXNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4211F00A3F;
	Sat,  5 Sep 2026 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566713;
	bh=XJ25dkLEKHXrD4zDJsRwyi0bwMpRC6xN6GX2w6Fi+Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvL/DXNoZ+PiVCMgh33XBGocc/FJZmmis3OMvHoU2JQBAeNhLQpolnORuzxiSbJ0p
	 HvVKUPTmBTLf5avUefjWuan4QuwFxshiNswTyGh3q9cQ9Pg4w2sDO6ywVIiFeVHrka
	 N3yHOvfViFq+HnS24YtKozZzpfeQSKkHFVfWiepFvGdbZcOvuDakNiSzKp4+P3wE1z
	 62n2f2XZ+SBwdQU3DxnM5yS7dp63upglh+X6lB6rmsCS5r3PGaA8NVTOsPULYKZ9lz
	 NoH/CIrV3SdPy38E41Z1EDlhN+Fs9MYQCJm3VqFq11VtiWYScTYgoyXM+xQ5BW3J65
	 LME8RNOlwcXCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] device property: fix infinite loop in fwnode_for_each_child_node()
Date: Fri,  4 Sep 2026 20:05:09 -0400
Message-ID: <20260905000510.1659297-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905000510.1659297-1-sashal@kernel.org>
References: <2026090348-triceps-paramount-f040@gregkh>
 <20260905000510.1659297-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 1900692555826753adab8799a1a8d50bb1ee200c ]

When iterate over children of a fwnode that has a secondary fwnode,
fwnode_get_next_child_node() can enter an infinite loop if the secondary
fwnode has more than one child.

                       Parent        Child
      (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
    (Secondary fwnode)   FWb:   {FWb1, FWb2}

In this case:

 ┌─> fwnode_get_next_child_node(FWa, FWa1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
 │
 │   ...
 │
 │   fwnode_get_next_child_node(FWa, FWa3)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
 │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
 │
 │   fwnode_get_next_child_node(FWa, FWb1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
 └────┘

This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.

The root cause is that when the current child (FWb1) belongs to the
secondary fwnode, calling get_next_child_node() on the parimary fwnode
incorrectly returns the first child (FWa1) again instead of NULL.

Fix this by dynamically checking the parent fwnode of the current child
before calling get_next_child_node(). This approach follows the pattern
established in commit b5b41ab6b0c1 ("device property: Check
fwnode->secondary in fwnode_graph_get_next_endpoint()").

Fixes: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260611203537.1786399-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e490166261d9a..262e43a9e8bad 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -748,18 +748,31 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *child_parent __free(fwnode_handle) = NULL;
 	struct fwnode_handle *next;
 
-	if (IS_ERR_OR_NULL(fwnode))
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an child from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (child) {
+		child_parent = fwnode_get_parent(child);
+		parent = child_parent;
+	} else {
+		parent = fwnode;
+	}
+	if (IS_ERR_OR_NULL(parent))
 		return NULL;
 
 	/* Try to find a child in primary fwnode */
-	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
+	return fwnode_get_next_child_node(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
-- 
2.53.0

