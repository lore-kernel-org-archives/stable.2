Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812A43B6EE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226546; cv=none; b=LQ8ng6YQMBWrEK7YAzZGqWHAWGXvdxjIlGV72adOJ7J+omS4ZwqC1lHTNeDxDONsoigiORjv/f9ir/EzsiwYnvvYvEj+nAy/g0BQiNX9ZT23Tevh7UwoRqp04hjmKM2juhzuv3lS2n43WZOXjWk5B4Jdu3ZXK68s4nL5BwB2Gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226546; c=relaxed/simple;
	bh=1T2MUL1/N9WjWIfS2WIx6ShW8S0+Segb8Genkkmqvpw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LqsSyCXLfT3pt1EH1daYaB7S3DQSyYIQ3oWGG68vnqfxsKFHXVIPDbkb0hdsK7RJiSjhtJQMZIgjXtYMKUHHlZ80gJa1EP4+zaelQsNF+mxFn7aVBJillhL1ADqYf5ldnRFsvFWvzteUURsDguRX5JdkxrAG7QJGUEUhNaPyVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2nEwD6pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2nEwD6pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CF31F000E9;
	Thu, 20 Aug 2026 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787226545;
	bh=GNyB74qEbLsakxvTzEowyaiqE/How1yVmLAU59VtY5s=;
	h=Subject:To:Cc:From:Date;
	b=2nEwD6ptyON8Bxk48ESJoQMVquzrrPat0s6GSU2Z/sD08110dTLsIS4GSR5MRn3hV
	 Vy034sa3GbRmHZXmLAG9YGA9blvqs7/qUeYfbAfaUGAKbe1MZm+0C6VMNPvKskryow
	 2+LWBlQJLZ0rmdtTN6zXhTCKHgmah4bD5TMaaTZw=
Subject: FAILED: patch "[PATCH] xfs: rtsummary scrub should treat rtbitmap corruption errors" failed to apply to 6.18-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:37:38 +0200
Message-ID: <2026082038-basis-zookeeper-14ec@gregkh>
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
git cherry-pick -x 8ed78104722b57df69478b0b1608a408c1036085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082038-basis-zookeeper-14ec@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

