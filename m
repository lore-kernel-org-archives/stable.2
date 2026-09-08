Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AE53ECEC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871366; cv=none; b=KXhQgO9sLDhFdc+btWSlAH9Rm2Qj95Wsh9B5lWVtWSzaEYLCBRq/9RU4V8kvnPPbP7949pSqgKoxOFGT718gQAU5xy0a9omPtQNyx4n0AH0zN8wbF1wfCf4qwz4NK1y+U3o/Zduhe+RpEUmtLp4OzaLvSNGXmSCjOi2KvFE6weQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871366; c=relaxed/simple;
	bh=xdNZZjwu4pbds2XU1SGtHh+lksKvIKCJR8kv/Xc7Kyo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gEKMchtFZxoQf/+Za0LuMTfdc7RcPwRBHS0ypoa+Ls+TjvIhP1J6n2qAw85eEUw2avRDy+s2iffPa4aGBE2T25o8Tidxt94P6+zcZxGTu5eDE7h7UKHLhiH6M0Kjuefbzt668a9PkJbpuNXVEucgGTLiB4VCSCxn2uz6vWxl9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TrHeiT1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TrHeiT1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA121F00A3A;
	Tue,  8 Sep 2026 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788871364;
	bh=oMb8Sm3Qr3myKRDqORKpzE6NQmZt39O8mkx1N2BWMtc=;
	h=Subject:To:Cc:From:Date;
	b=TrHeiT1NGKEY96T9dpPbPdQKSXp730Pt8tVxmIjY20WDfsSSvZz/92UL/Exrcp2Lk
	 nV6YriOB0ByAF8CgJC/ixKMSDd3M0ceYCa7HIcLh99FdFmUs0Ic4C0A/KRPiUt5G65
	 DMLkX0hoje/eYC2A67UuTd5UeOXYebZORTvNepqo=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()" failed to apply to 6.1-stable tree
To: meatuni001@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:42:22 +0200
Message-ID: <2026090822-abacus-psychic-5063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090822-abacus-psychic-5063@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852 Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 28 Jul 2026 17:54:56 +0500
Subject: [PATCH] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-4-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fc46b33b836a..d18768a51b19 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1975,6 +1975,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 

