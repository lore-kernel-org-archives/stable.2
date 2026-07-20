Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E232773E4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560778; cv=none; b=D7x/V7Dn6u4QKS0zv0tps+Ji+7VAfEeo6omAHmWFgYagrLyy1ShUmpBMtUgIvbHMP4Y3T5yxMCpYr4YeFO8boScBO+cY80UJrUXmrZ650W8FK9uThwXrOTj2ap3IukF2iZowtIjJAMTAeoHvJwoQXUkECufOUpBy4DmMXPlSDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560778; c=relaxed/simple;
	bh=w+5XvrBStjxWoFqS5eBc0AwqWvVN4fVDsrd+jxU1+/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HSaA8iG9wlOKnxJD2XUkMwOMDKdfVfL9VVXAlZq/cSjSo45h2iqoc2NIYYqQ6f+KIMEfMi6bP1zCXZXJ4yoDWKlBs+OihLT7rXgyHtUwWfRvKABJYmiB47ZpF84ggOLlLfXBWvcdFQd3LrHqZvCvtOJaaZ6Ek75NQ/r5JkGFpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPqructV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPqructV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634521F00A3A;
	Mon, 20 Jul 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560776;
	bh=ZVQBZ3/SnJ+jQZ+gKsjzqVusZwqBay2IaNs4POm9TaQ=;
	h=Subject:To:Cc:From:Date;
	b=oPqructVLjjxONg2vHk/LSVv4s6sZXFq6LQzci/NLTew00yhzgd6KWFgmj5lz7ALH
	 J5FUfz6i5W0Qf/BYkZDAn3z1JGusfU6jeDCMW5HrdGqGVp2q3Zsv5zi7Tg/lroCP+S
	 2QRVHWobfOScUPABPrV3XPkpwn1reEGqclyuykfc=
Subject: FAILED: patch "[PATCH] dm-verity: avoid double increment of &use_bh_wq_enabled" failed to apply to 6.6-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:19:19 +0200
Message-ID: <2026072019-washhouse-dweeb-5963@gregkh>
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
git cherry-pick -x 72e9ec2fe32b00994f41719cf77423fca67d48b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072019-washhouse-dweeb-5963@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72e9ec2fe32b00994f41719cf77423fca67d48b2 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 9 Jul 2026 21:33:16 +0200
Subject: [PATCH] dm-verity: avoid double increment of &use_bh_wq_enabled

verity_parse_opt_args is called twice, first with the only_modifier_opts,
first with only_modifier_opts == true and then with only_modifier_opts ==
false. Thus, the static branch &use_bh_wq_enabled was incremented twice
and the destructor verity_dtr would only decrement it once.

Fix tihs bug by only incrementing it on the first call, on the second
call, when v->use_bh_wq is true, do nothing.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Cc: stable@vger.kernel.org
Fixes: df326e7a0699 ("dm verity: allow optional args to alter primary args handling")

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 9a9847f94c46..adfda1fdab6a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1262,6 +1262,8 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 			continue;
 
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
+			if (v->use_bh_wq)
+				continue;
 			v->use_bh_wq = true;
 			static_branch_inc(&use_bh_wq_enabled);
 			continue;

