Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928B4A5ED2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440081; cv=none; b=N3rYgmLPEaNjAz9p3xp0ms1mWeH0PY4qz4FYy+WKMYp48bbmSysKzL/r9cfYnxlYk/YHimzDIN931suMvIOffubxKUYdnb43ftKUAeUe/tP+6lwGfMS2rGmeZX9yUgBg+r375ZySCY7Xxw/UhliVpZ8OHt/5cQdG2p8DkRjWdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440081; c=relaxed/simple;
	bh=oEtiHkrUMPNRGkFAvvTFYTsUyzlV2yOTW/CO4yhBeL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DyeaAz4YAIGy/eWW5L3J2fHFlzH/lQABSDdLqkhC0bWK6zbekSX/T8EPiU8Nghv2YWxtJzgIxOwa+p8atOFUjFr1SFKlnW+Sd5mFvJcgOPw4Bfcdaa32dakmYC9NhsAFd4yP7lWIFJklCw/pqxiIvmKV3C+p8SOeAhESuhzb6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGWCt2j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGWCt2j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8862C1F000E9;
	Thu,  3 Sep 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440080;
	bh=S843kAD8DLMo5Zbb3mDOviU38spQaKK7XlpQxhM7UvI=;
	h=Subject:To:Cc:From:Date;
	b=hGWCt2j7DjjDPGAWBQwR+A3SgYJaYWD9TM1cfhUkvLTIZTJ5Y3a7PQZ7YU8CCW65x
	 zCqU4wQiStOl0xDhJCjZeJHkovKnoC/gk2Wkolm4OLk2+dTdNe09oBhh8AIo19+5e8
	 A3DiOjq1geQq9EksadksiRJVemOyKYy7dX/ixpR8=
Subject: FAILED: patch "[PATCH] tracing: Fix logged instance name on creation failure" failed to apply to 6.6-stable tree
To: vdonnefort@google.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:36:05 +0200
Message-ID: <2026090305-creole-floral-cc49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a9a01be2834a529cbd490ccbab02643f0c1735f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-creole-floral-cc49@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9a01be2834a529cbd490ccbab02643f0c1735f2 Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Fri, 7 Aug 2026 09:54:23 +0100
Subject: [PATCH] tracing: Fix logged instance name on creation failure

When boot instance creation fails, the kernel incorrectly logs "(null)"
as the instance name because strsep() consumes curr_str entirely during
parsing.

Print the properly parsed name variable instead. And while at it log
the error code.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260807085423.4175161-1-vdonnefort@google.com
Fixes: cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 89dc1c0ebb90..740c5f358b75 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9726,7 +9726,8 @@ __init static void enable_instances(void)
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
 		if (IS_ERR(tr)) {
-			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
+				PTR_ERR(tr));
 			continue;
 		}
 

