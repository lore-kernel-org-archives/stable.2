Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED233F8883
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224348; cv=none; b=I9eDVKyG6yA9AsRXL9ijj5cmLfYns6zxHs3l8agwHWd1/gIX9dpQ1VMX1w8yiHnicnT1T4FkjpSREapbnV8AEMalt82eZe/7ZeqEEnHjKqAyFb6KUZSwMyK3JJ2tTvvJi0AC74XUwZE466oDwql8GkOiMT69uSMLPs3Of/SCRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224348; c=relaxed/simple;
	bh=myVXp0tm8Am90cOphkVFCe075RFIKG12mAWph1JFh14=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hfxb3PprmJF6PWO1YVZt4KHJ3Itc6qvJOBN+PtQwjiQ6psj/9+FnOcpHhRh1ab5TEkA4pGM7eSRzJLwSx75wBk+6W/kFlQA9Cyl0w9fJsdUENznyW8gxbeZMSIkWnNk9g2xAuOt4IsT/1LvJadOLVwVtXWHNxTBwDrK5NJNS/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V7UuxATV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V7UuxATV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF9F1F000E9;
	Thu, 20 Aug 2026 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224346;
	bh=LBz2SEXmQBbpRlAG8D50rAZoTDDrQoB6FHJRbEFxXMk=;
	h=Subject:To:Cc:From:Date;
	b=V7UuxATVIGfvzzJfyD8ecg1EfGKHLBylUwdbVuwy7lK+3NM7enmNy15KywU8cfrOl
	 wf6xYowuIceFY4k1b4vrBJ8DS1bwl2h6J8VgBmFSvnly4+3b68WNaQ+KVx4TkGDLzy
	 Gm2risXtODry+LSSXDnhVgRWrwZ9TGdYsu78BSyo=
Subject: FAILED: patch "[PATCH] libceph: fix OOB read in decode_watchers() via missing bounds" failed to apply to 5.10-stable tree
To: jhapavitra98@gmail.com,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:11:58 +0200
Message-ID: <2026082058-swiftly-hardwood-656a@gregkh>
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
git cherry-pick -x 00ead17c7de137a692edee59f2772e6af687e8eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082058-swiftly-hardwood-656a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00ead17c7de137a692edee59f2772e6af687e8eb Mon Sep 17 00:00:00 2001
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Wed, 8 Jul 2026 01:39:41 -0400
Subject: [PATCH] libceph: fix OOB read in decode_watchers() via missing bounds
 check

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() as the watcher count.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, bad), consistent with the established pattern.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

[ idryomov: trim changelog ]

Cc: stable@vger.kernel.org
Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..28d76c2f6b3e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5044,6 +5044,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*

