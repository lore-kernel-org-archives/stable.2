Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BA36BCD7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040750; cv=none; b=bunoIIcib77PFQPUZ9pO/fZdKef5GSco6qpfaDPE5BT8IwOgTtWSH/jPEV6Mvu9qDHn59Gw8DR96QqqxnwZOa3FWYXL5RoK+sT5R67+vF96TmeUIOZXqfYfvgR9Kx7OOfZM0yNvjY8eJoT24SyqRhcUDQ3xineTAGI4Ia+SF8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040750; c=relaxed/simple;
	bh=IFPU0NZbhGniOssbu0f9Zq+28pF0ianD/CE/+qwUyxE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AyFZ2ce6zDaTsGIWEd5zWwm1W550SuaJPrOOsXJ2etPoW2I2CGMVz91jrKDDOxV5wDgFnaiEQglkIoGcvH8VrBAXLNQnYVLlBYFN7wZ0JNVBtVwIw+1XBnq8H6OVvNeIqssiayEs8AE/vNLlyDD7ES92SYSG5gHg/eJOkmj5Wew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vnDeDphm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vnDeDphm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C471F000E9;
	Tue, 14 Jul 2026 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040748;
	bh=PWWLxPR9ThU5IfGot1kdr1SToXw2gi23J6Cd7l7CXbo=;
	h=Subject:To:Cc:From:Date;
	b=vnDeDphmo9GCmM0CMiU4QPuml2gOTZcDy9hIi6OVqj65evaYmqHmIKDHZfE0U4BiT
	 rFdq8B2dE7pZORc7RowJPtQ4zLd7eBwlG+7JnsHug9GfhBO+z0PEuX4udJgOiJaYw1
	 cBqQimeWg00mtCBuzF5dDpoCIyD+DGz655SPswUI=
Subject: FAILED: patch "[PATCH] tools/mm/slabinfo: Fix trace disable logic inversion" failed to apply to 5.10-stable tree
To: wangxuewen@kylinos.cn,18810879172@163.com,sj@kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:52:14 +0200
Message-ID: <2026071414-creme-vagrantly-a73c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 235ab68d67eadbef1fdbfb771f21f5bacc77a2ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071414-creme-vagrantly-a73c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 235ab68d67eadbef1fdbfb771f21f5bacc77a2ae Mon Sep 17 00:00:00 2001
From: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Mon, 18 May 2026 14:21:57 +0800
Subject: [PATCH] tools/mm/slabinfo: Fix trace disable logic inversion

The disable trace path in slab_debug() had a logic error where it would
set trace=1 instead of trace=0. This made trace functionality permanently
enabled once turned on for any slab cache.

Fixes: a87615b8f9e2 ("SLUB: slabinfo upgrade")
Cc: stable@vger.kernel.org
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
WARNING: From:/Signed-off-by: email address mismatch: 'From: wangxuewen <18810879172@163.com>' != 'Signed-off-by: wangxuewen <wangxuewen@kylinos.cn>'
Link: https://patch.msgid.link/20260518062159.80664-2-wangxuewen@kylinos.cn
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index 54c7265ab52d..39f7eae7eecd 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -798,7 +798,7 @@ static void slab_debug(struct slabinfo *s)
 			fprintf(stderr, "%s can only enable trace for one slab at a time\n", s->name);
 	}
 	if (!tracing && s->trace)
-		set_obj(s, "trace", 1);
+		set_obj(s, "trace", 0);
 }
 
 static void totals(void)

