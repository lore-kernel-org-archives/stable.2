Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651B3FA5D4
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970551; cv=none; b=SUfin24ropsjfgQ5x+Ioxs9/EH209kNnOY0j4XpTZU7jU2cL/FNWfO1qIMFGqSWegzzVPMYTFUsYa42Qlkrcsl2yW7HS0ktTPLZ+3T7dP5UUeJ4v89NA6lyHPgC526JRLZQer5qRf0I4/4Ow1RZ7p5Uw9oakGC2B3Xh5FVPqlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970551; c=relaxed/simple;
	bh=fwaPM9IgD3fmIUhvNM00us/gOlPMdl6unP4vvuyeNIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NY4yb8LjfOapeUAMv4zF4g9OGt03fim7X3Z+c9iwYslE3LsX1kNcy6LOYmJ0U19M8Ry4FDAin/XiA9vYuGywO9SpUkdQKGrYKbUnAJk0ttKAGL8lRn+hz1LIyLpApocc7UjEwMii5UKdi8KgYy+DBD99O7E+FCZAFdQiP2+4Afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2edOGj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2edOGj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EFD1F000E9;
	Mon, 17 Aug 2026 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970549;
	bh=Q2dAUaK8DobeM+gj8GLGsD/gpNfT6MhO86rP4PVUMEg=;
	h=Subject:To:Cc:From:Date;
	b=S2edOGj+zNK3OobIgDLkvXzl9RqxbsZ0Ws6LF33nq0K9j0JC3JQ3ujxHnGFTcZ/Eq
	 VkYSrxKn4pr3AdQksUcSdgAr3VQlpjhzo6UTlZjDgOw4YOCkvYqgyHxmVbj6/jmKEg
	 +3JS9b2fKnfMz+WsUyHr9ARhcjEEj27ESsTrOF+Q=
Subject: FAILED: patch "[PATCH] mm/huge_memory: initialise workingset state before folio" failed to apply to 6.18-stable tree
To: mfleming@cloudflare.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@fromorbit.com,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,muchun.song@linux.dev,npache@redhat.com,roman.gushchin@linux.dev,ryan.roberts@arm.com,ryncsn@gmail.com,shakeel.butt@linux.dev,stable@vger.kernel.org,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:39:33 +0200
Message-ID: <2026081733-plastic-tidings-c30e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x aca1f2d5de17e138bc6c4859126b77e516b82541
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081733-plastic-tidings-c30e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aca1f2d5de17e138bc6c4859126b77e516b82541 Mon Sep 17 00:00:00 2001
From: Matt Fleming <mfleming@cloudflare.com>
Date: Sat, 25 Jul 2026 11:14:19 +0100
Subject: [PATCH] mm/huge_memory: initialise workingset state before folio
 split

xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
__folio_split() leaves the xa_state's xa_lru unset.  That lets a live,
memcg-charged xa_node exist without being linked into the mapping's
shadow_nodes list_lru; when reclaim later walks the list_lru it trips
VM_WARN_ON(!css_is_dying()).

Use mapping_set_update() to install both the workingset update callback
and the shadow_nodes list_lru on the xa_state.

Link: https://lore.kernel.org/20260725101419.3938406-1-matt@readmodwrite.com
Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c5b060ce82921a2fd500
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nico Pache <npache@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f84fe7913d88..5d94fa4c74fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4076,7 +4076,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-		min_order = mapping_min_folio_order(folio->mapping);
+		min_order = mapping_min_folio_order(mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
 			goto out;
@@ -4090,6 +4090,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
+		mapping_set_update(&xas, mapping);
+
 		if (split_type == SPLIT_TYPE_UNIFORM) {
 			xas_set_order(&xas, folio->index, new_order);
 			xas_split_alloc(&xas, folio, old_order, gfp);

