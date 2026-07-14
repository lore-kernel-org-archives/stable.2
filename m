Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E047F2DD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040757; cv=none; b=VEpUf08MYbvglEv3kcr0NOtv074VvCBL5+6IS1s7/CLIQDl55RbuQIsuPJ4ZesHQm6omaPW72/08DA81CEnr9bPN5+YqhxtiV9H3FdVeUCFSepEzUD/qN3c/CLwsefVktYnOq8nb5whVyJLjJNWVNP4HVLFgUPxMoMc1DT12IZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040757; c=relaxed/simple;
	bh=Ls82oteqpL9pG2+9TAFTSLQ7qe4UrGlyVplHuJCnVr8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PID8SMhQzQn1HVgsfrS7XnIa/Hdli9aknjlNk5ewue43UInFnPJA/fXRwoLDUiaMDwBE4Sje/7dxIMTkNsPqxaZu/Vnv+hkjuOUlQakbmF608UBNFBXht9bDr64Eke5O+KyyuePH6lb3uD74Kt0RNIMH+kFfBAGQvlF820flGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a6cbs7mS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a6cbs7mS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077271F000E9;
	Tue, 14 Jul 2026 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040756;
	bh=OKRkM982AsLXn69fhaJRL1FzU2w+c+RzFbL/2xm0vA4=;
	h=Subject:To:Cc:From:Date;
	b=a6cbs7mSOXffvFccxsox1hK05eS2dgMQANNbT+bb1faf0wQS/cTtVV6IEGUZARtm4
	 RYalXt5QeCKv6U387ECX8LJWqPnZzluw2j/YJ9XWoaeWh5yCnde1tiIsDMVj/41cC4
	 H21Mm2pmwrdUhixtNhvkvko++uogfe4gGqTgear0=
Subject: FAILED: patch "[PATCH] tools/mm/slabinfo: fix total_objects attribute name" failed to apply to 6.1-stable tree
To: chenyichong@uniontech.com,sj@kernel.org,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:52:25 +0200
Message-ID: <2026071425-unhearing-deviator-ae0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 892a7864730775c3dbee2a39e9ead4fa8d4256e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071425-unhearing-deviator-ae0d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 892a7864730775c3dbee2a39e9ead4fa8d4256e7 Mon Sep 17 00:00:00 2001
From: Yichong Chen <chenyichong@uniontech.com>
Date: Fri, 12 Jun 2026 15:13:59 +0800
Subject: [PATCH] tools/mm/slabinfo: fix total_objects attribute name

SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
objects_total. As a result, the lookup fails and the field remains zero.

Use the correct attribute name and rename the corresponding structure
member to match.

Fixes: 205ab99dd103 ("slub: Update statistics handling for variable order slabs")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Link: https://patch.msgid.link/96556748872BB47E+20260612071359.649946-1-chenyichong@uniontech.com
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index 87570c22b151..48d1ee8b0e81 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -33,7 +33,7 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
-	unsigned long partial, objects, slabs, objects_partial, objects_total;
+	unsigned long partial, objects, slabs, objects_partial, total_objects;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
 	unsigned long free_frozen, free_add_partial, free_remove_partial;
@@ -1262,7 +1262,7 @@ static void read_slab_dir(void)
 			slab->object_size = get_obj("object_size");
 			slab->objects = get_obj("objects");
 			slab->objects_partial = get_obj("objects_partial");
-			slab->objects_total = get_obj("objects_total");
+			slab->total_objects = get_obj("total_objects");
 			slab->objs_per_slab = get_obj("objs_per_slab");
 			slab->order = get_obj("order");
 			slab->partial = get_obj_and_str("partial", &t);

