Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3043B6EE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226543; cv=none; b=tDC4lxs1/LfNYAsEWDZiWVtlMKVZ5p1LNGQPiFvNh+erukqy0kkntrrx6e4u3GSGkj7GN5Fd4aH5r19vcukcuNHlfKBze69vy7l16d25/dTky41O2J+dxu+MczwWsqOGGPSMbcfv3VvcoCQkSwkEqmZqgOE2mg6yPlupTyyO9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226543; c=relaxed/simple;
	bh=5l9xRVM/9/sFjjxnHYoiJHqA5VQfBX/lQ5Uczuq4uDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gCw4kmnLYacFpl5MkEzZgMm8W99LX5EZdgp9jJo8nYG7OR3rTh4+NiURa7eMDgIWmJdDnpt5Eoyz7tkHq/CEArdL+o5SmzFuYt3oTz9/IcIXkwpH5pmDkXXBUEB00jzNw5Scc9PUTmyg7omYgH8E1U2zuI9G0OwtS3JKh8fenSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v30bZaDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v30bZaDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22CC1F000E9;
	Thu, 20 Aug 2026 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787226540;
	bh=T+LYWMJW3WI5FroHUE1n3y1dkT8ga/0lK8rudkfIEio=;
	h=Subject:To:Cc:From:Date;
	b=v30bZaDyQXIzReVPn6ZK6iGBXyRfHTaS1M9yMGwcpr0ZHzvGDwFOjUkpYOtyj1i6o
	 KhstAv+4eJBQGZ7vArYffY5cdHLybMoh2iA5ShxH/hFJQV+JsQ2Oivjte7YG3ytTah
	 k2dUz9ImzX1brKEMhc2e12tasOD6IIJ1mWmDBpHA=
Subject: FAILED: patch "[PATCH] xfs: rtsummary scrub should treat rtbitmap corruption errors" failed to apply to 7.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:37:37 +0200
Message-ID: <2026082037-faceted-nearby-f8fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ed78104722b57df69478b0b1608a408c1036085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082037-faceted-nearby-f8fe@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ed78104722b57df69478b0b1608a408c1036085 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 20 Jul 2026 20:24:17 -0700
Subject: [PATCH] xfs: rtsummary scrub should treat rtbitmap corruption errors
 as an xref error

LOLLM notes the discrepancy between the comment saying that this is an
xref error and the code, which marks a (non-xref) corruption error.
This appears to be a regression.

Cc: stable@vger.kernel.org # v6.13
Fixes: e3088ae2dcae3c ("xfs: move RT bitmap and summary information to the rtgroup")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index 78f72a046887..546b335ade13 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -358,7 +358,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ip_set_corrupt(sc, rbmip);
+		xchk_ip_xref_set_corrupt(sc, rbmip);
 		return 0;
 	}
 	if (error)

