Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FC4D7955
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579797; cv=none; b=dMu/sL4pdgBIZqzAZBOKzqRKmzr9YtguvpbIUiiTnJRUwW+z3gX0HLNdp851g0AJDbtj7sAmbINIEbjZfUWGOn9I2UtW9fvAqVa4/SYZ+5jnJSDw6V1IJBrLOcEZTUxBkuejQA7kSJLJ/eh6Hc99rz6HFL2dsVjsAT7ekoqWYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579797; c=relaxed/simple;
	bh=/RAhFldvWak+rY7rUIVQRDP3Vu/CnEcWiYiJWMCjWyc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sEkrMjZIXk/nLWW0EhTR/zeF8OELF4fWTcjrOPT4DeDh/DZIs+nlJNjGWotzXPo/SZDNU8YDYesOZv48wWbcDAohOdOEHmBt5Hxoowca1s/C2PxNwC51MRHWx4eaycqYBh9a/85t8LCStT4GhqGoEcCnVGLk3eESkBMeyevvFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK5fL2+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK5fL2+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE771F00893;
	Wed, 16 Sep 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579795;
	bh=n5Z/oDKUDEjiIAa61l6XKJsY76PexAHDytzKqebkEro=;
	h=Subject:To:Cc:From:Date;
	b=AK5fL2+vF3RjEzTkskj3Rq8dHtsS0AztEW5XPWSqsy2D5NvC0QBY4iPdECR0bvDfe
	 omNTRu7W9FeX4n7N4Y+AD2Re6AWEfY17mjmNdPq3W81GQCVoMWXIh1NM5zz4bSBObg
	 q6iuhOaw1GJuc6lvIBp7cikVfxl0z8c6J33wiIrg=
Subject: FAILED: patch "[PATCH] xfs: fix short ifork reaping computation in" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:24:58 +0100
Message-ID: <2026091658-cornball-gerbil-7e76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eacb8479507756c3305994e87fb2fb1183827e98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091658-cornball-gerbil-7e76@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eacb8479507756c3305994e87fb2fb1183827e98 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 1 Sep 2026 22:42:15 -0700
Subject: [PATCH] xfs: fix short ifork reaping computation in
 xreap_bmapi_binval

LOLLM got really confused about the update to imap->br_blockcount in
xreap_bmapi_binval if xreap_inc_binval returns false.  The intent of
this code is that we shorten the imap to whatever length of space we
invalidated so that the next iteration through the loop will start
wherever we left off.  Unfortunately, the calculation sets br_blockcount
to the amount of *unfinished* work, which means that we pointlessly
re-scan blocks that we already reaped.  This is benign, but we should
fix the computation anyway.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5befb047b9f4de ("xfs: add the ability to reap entire inode forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 496c6eab555e..f698b9be3dd1 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -1399,7 +1399,7 @@ xreap_bmapi_binval(
 			 * far we've gotten.
 			 */
 			if (!xreap_inc_binval(rs)) {
-				imap->br_blockcount = agbno_next - bno;
+				imap->br_blockcount = bno - agbno;
 				goto out;
 			}
 		}

