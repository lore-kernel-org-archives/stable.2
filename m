Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E0329C60
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497493; cv=none; b=FqqarrPR+PQCcaJBPCpBgfRTRMKxqpnfAApLFAXfP2o8zrY1r6sk5UWU5zXO2ZIlUn8NhVbfLXOKVzjwte9jUQo+DwZrZzNXADdTBIblR2nDAM5G60H4CWrbgOs3QNcs5K+kAqw5RgqgueKgW0utd2GiM1j5g+5KTMFOEN7wAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497493; c=relaxed/simple;
	bh=1fCx9aHzRdepGeVPCXuh7NGO4JDNj5y0Rvv6PINg2N8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NwNByAq93X4PtST5yvRFjiRjGDgCnfj2G0mEkn8IhUDDIwJF2PSZiuHHUjJPXCNNWsGJ9j6St6UJWhNAC55Wx7fXVRY7ytgNWt3UO7bOW345+8US3mPLfpiNoqMF7Dpua5WiyMA6UrDXe6zu03YnruiiK0r0S8BxVt8Svt7N44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/48FQHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/48FQHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365121F00A3D;
	Fri,  4 Sep 2026 04:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497491;
	bh=oWoNjPnT6R7V9xKZJxRLZca1F2rIMVHkiw+2GlIJY6o=;
	h=Subject:To:Cc:From:Date;
	b=o/48FQHJyMOtH7gPG3iS034bkUwglSKA8C//IIFxXl39+EZk5a+k73JZeDrGzpaoT
	 3/DPkEVcI1PdHbzmx81lrnJGilAZMz5C3SYys2CTXwky/odcKi1hTY8ZHKJQ/2p8PN
	 MNVjXJ26J0YkGZUJeEFypb4DTE/o7zm39qfHRVKU=
Subject: FAILED: patch "[PATCH] taskstats: fix cpumask parsing cutting off the last character" failed to apply to 5.10-stable tree
To: include@grrlz.net,akpm@linux-foundation.org,bsingharora@gmail.com,oleg.deomi@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:51:26 +0200
Message-ID: <2026090426-survival-bush-ee14@gregkh>
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
git cherry-pick -x 1f58a5335cdd14b3fb5f2a5d3763dee1f5cba1d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090426-survival-bush-ee14@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f58a5335cdd14b3fb5f2a5d3763dee1f5cba1d3 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Thu, 23 Jul 2026 21:09:22 +0000
Subject: [PATCH] taskstats: fix cpumask parsing cutting off the last character

parse() hands nla_strscpy() len as dstsize, and nla_strscpy() copies at
most dstsize - 1 bytes.  When the attr payload comes in without a trailing
NUL, srclen == len >= dstsize and the last character of the cpumask string
gets cut off.  Register "0-15" and you are silently listening on "0-1",
exit data for the rest never shows up.

The bug only bites when the sender doesn't NUL terminate the payload;
senders that include the NUL were always fine (srclen gets decremented for
the trailing NUL, so srclen < dstsize).  Thats probably why this survived
20 years.  And the policy is NLA_STRING, not NLA_NUL_STRING, so a payload
without the trailing NUL is legit input here.

Skip the kmalloc/nla_strscpy dance entirely and use nla_strdup(), which
already allocates srclen + 1 and terminates.  The nla_len() bounds checks
stay as they were.

Link: https://lore.kernel.org/EC49FE41-7F5F-41E0-A07A-ABEB8ECA514D@grrlz.net
Fixes: f9fd8914c1ac ("[PATCH] per-task delay accounting taskstats interface: control exit data through cpumasks")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Reported-by: Oleg Deomi <oleg.deomi@gmail.com>
Closes: https://lore.kernel.org/CAByWkfZ6b1=3H9pwkz-dDQOs9cZaF-HYQ6b9Yb0=Hq2r1Vv_Pw@mail.gmail.com
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 8d115670a3ca..74f89b632c0a 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -368,10 +368,9 @@ static int parse(struct nlattr *na, struct cpumask *mask)
 		return -E2BIG;
 	if (len < 1)
 		return -EINVAL;
-	data = kmalloc(len, GFP_KERNEL);
+	data = nla_strdup(na, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	nla_strscpy(data, na, len);
 	ret = cpulist_parse(data, mask);
 	kfree(data);
 	return ret;

