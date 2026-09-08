Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FED53ECED
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871369; cv=none; b=IuRKBQhm5fBYEbeUh4PxjyUCALYAhKMhfg9Vl1tDoW74rsQfOvVvMlM3NAShRxBeb0e9P8y4cQ62V+3+LLtZcJ5JouwEyFlvPzW9Ndh2R/cSWRCoyui0RndXNQThEbIYvh65+xRZ2oYyvcjcQ8OKFwYcqaqDEj05Rt6Q4qV0xGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871369; c=relaxed/simple;
	bh=c/jFeKAmS9QLZa00vvV5dyE54lCsjuY+bzn5LH7V7fY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YnYpWPqmZSt97zBlPxgsmhaZQUzaodxuprnbPeE3LfU3vsFkbQ52VjGvWksKPG89baGtyC6UQCe68QCFZQY9EQHi4DkBH2u9sQIK2F+XD3aKyyNKM/AJAA+TlNJ6DcjAzr07rXW683e/4H6GrtHyUOMnyhWFBSg1teffkqwkm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BoLhsJ2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BoLhsJ2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B471F00A3E;
	Tue,  8 Sep 2026 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788871367;
	bh=/BxkHQBkPn5XaD9af2UCTxJK9G74MXvLaTvHzh62olU=;
	h=Subject:To:Cc:From:Date;
	b=BoLhsJ2HoZ4RtAQik+b2HJN+DLMBs3zOjxF8Y+3qC3TprlbSn1MfBgoRgY87opfUA
	 cXFkSEKcmmAKmU+qIDzPxCNQRj7R7Mf/w1sw6fvEB8eWBe0KhSkpkVlWOHAPAcYVLF
	 qQEgHqVYfJ5ggm3/jDFLQxXbThVxy6YyIwZsyGVQ=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()" failed to apply to 5.10-stable tree
To: meatuni001@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:42:23 +0200
Message-ID: <2026090823-contour-casket-b871@gregkh>
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
git cherry-pick -x 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090823-contour-casket-b871@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

