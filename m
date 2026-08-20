Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B2414A04
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224321; cv=none; b=MFwXjZ0pGlpUaXPEJAIPlms6GkvyiRuzJ933ictHpIsdrdycBOXHNH8tD+tvGXHu4Lx3jpqhmcGqIB33bmciyNdC9MAFViMSYSLUwnkp4wmfI2eiWQwFb2G0tugmNZrxHd0HWddNFiOO4ZAY80GS7F+PAMbdRFYn35wZgxYV+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224321; c=relaxed/simple;
	bh=ijE3ll95WX+DSBJ5IIUj0f8pGh1tYIR3/goX5H4ui9M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o0hyV7lMYpmmamCeCJHB48EEyFN4Jrh8bjrEcQ5S6QpIavNC0mbpj4OXM3Uk8cq+Qdee90dXN/wXmONH5ScXTW81LYRG6+l0F9dA3j772RD8Bg5+gukbecm8Ef4Op24qSAT59yaAH1BCaTrZ3RdkXaQI1NFP3XXY+lkFWjJrhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iIK21MYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iIK21MYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F31F000E9;
	Thu, 20 Aug 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224319;
	bh=U6Cq7tzmjm3JAjRdxZMp56wgSY5GHR9Vwc7Wy0rfr38=;
	h=Subject:To:Cc:From:Date;
	b=iIK21MYxuozKXEhfKa7hf+7EscjgeDpmrxYn3GMa/bj5hjB9y1wTb8JCsE4/q+XAW
	 DwdKp5K5wJjnEIwq9gzbOUDD1Aoq6sKp3FbXvU43H4MrVQAJa7x4CXVpeQYEg/UwE5
	 nLHwDz5+w/D6gNKbvgcMEmW3QdzIZ6H523FYkov8=
Subject: FAILED: patch "[PATCH] libceph: fix OOB read in decode_watchers() via missing bounds" failed to apply to 6.18-stable tree
To: jhapavitra98@gmail.com,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:11:55 +0200
Message-ID: <2026082055-chug-kinetic-d689@gregkh>
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
git cherry-pick -x 00ead17c7de137a692edee59f2772e6af687e8eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082055-chug-kinetic-d689@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

