Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E42495AC5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579574; cv=none; b=GiHfwUYOsVr5jZtMcqV7xYJeoi6ZiI/crDOIdsuLDUsd6MA2Zo61HMwGeGs6PlzLVINPKt/PmgfvqmfgV9We5MqHAMiLTR68TqoljtzVsbfBhzbSf6fNw6zXZZKDU/IxDzib24w7t7RNnDr/tyVSAfwG0fxf2z2zVf2Wdz155fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579574; c=relaxed/simple;
	bh=EIaPtg2Pgu7KwMFE6p+oIFzYuoR5ErtditiXk8wNoB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d9d8vFyug+7zMJVphRA5IJEBNJ68v2qbqJkH8xJYfAri+R2ZuCDqyd0VoZ71/otS7PCeB5OeKpPqlZWQX6x+MBPIXavUmlfRBb94qZtz5xDLq6E9IOFDxEzyEvtvOPQ4oa0ZL1QYOIBhVoF7/EVP/yvsHVA2XpA24WgTaAqMB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fr4JEzzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fr4JEzzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FB1F000FF;
	Wed, 16 Sep 2026 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579572;
	bh=obFpsy2KOb6F4zVo6CN7myFizBuAcDJMYtH7t1/5Px8=;
	h=Subject:To:Cc:From:Date;
	b=Fr4JEzzpIjg3goefxr3wQNlXXmG35Kuig1OqHUIfEe/oSkZGmrTnVv4Jh6JM91n+n
	 i4hpqldQdCVE2v/CWp66g7GBn9jKQTBeW/MhqVZFmSO6CnUEEouwooUUrZI5Vj3Qjf
	 3j2hgpEYMwbIzOL0OwtfT5RLtWtr/uYkqXwS/3GI=
Subject: FAILED: patch "[PATCH] xfs: report healthy filesystem events in scrub stats" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:22:00 +0100
Message-ID: <2026091600-festive-identical-c500@gregkh>
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
git cherry-pick -x 0ae61c331ec552ad0c278c5c48a1c4ccb90b4bab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091600-festive-identical-c500@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ae61c331ec552ad0c278c5c48a1c4ccb90b4bab Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 8 Sep 2026 23:03:17 -0700
Subject: [PATCH] xfs: report healthy filesystem events in scrub stats

LOLLM also notices that I forgot to expose the "clean bill of health"
scrub stats.  Fix that.

Cc: stable@vger.kernel.org # v6.9
Fixes: a1f3e0cca41036 ("xfs: update health status if we get a clean bill of health")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/stats.c b/fs/xfs/scrub/stats.c
index f3f1fbfb6d99..da0c05ffe5cd 100644
--- a/fs/xfs/scrub/stats.c
+++ b/fs/xfs/scrub/stats.c
@@ -84,6 +84,7 @@ static const char *name_map[XFS_SCRUB_TYPE_NR] = {
 	[XFS_SCRUB_TYPE_RGSUPER]	= "rgsuper",
 	[XFS_SCRUB_TYPE_RTRMAPBT]	= "rtrmapbt",
 	[XFS_SCRUB_TYPE_RTREFCBT]	= "rtrefcountbt",
+	[XFS_SCRUB_TYPE_HEALTHY]	= "healthy",
 };
 
 /* Format the scrub stats into a text buffer, similar to pcp style. */

