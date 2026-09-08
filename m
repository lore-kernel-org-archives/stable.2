Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1253D0A0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871321; cv=none; b=LLMLInNh53SPwXw0ucwHcCHCA3IKHvvsm1f/cjTV6WhTCsjvLjzZMhbfqrW7AWeq7GdYVPlqZtCfz7BLxZMH9WoL1KpvR5gRRzXlfJfLoCkgA3+EJXYM3JSiZc7mPebT4LWuiVP9yhbFLdyuvINlyaRN/1vx4ujS3mLlha8wF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871321; c=relaxed/simple;
	bh=dztQqmjyimkHchzzqcByDchkvj8O4qs7FFidBuQFDzE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ruEB3MhVgccS4H/TCmtuIadwYrYAFnFIpibMDb4ZA5q86S/QCE8W88k2qfDBzXU57Mf9aH4KNYVMaY3rlvmupKwXiVoS6MvnkiKu96HYRhLOATghYlLm49nDcRhTvTxSZShn2n7R/2mzlMRELQWi1JgT0Tp1qT8AO7UZol+F9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGwXsNKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGwXsNKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A053C1F00A3A;
	Tue,  8 Sep 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788871320;
	bh=hGim9nm76XSZG1VcKIs2LMCu6B6s/EOgIQ/Lwh9DIyA=;
	h=Subject:To:Cc:From:Date;
	b=TGwXsNKCivExWN5Yfad2oetseoLIXm96MeB5obDhQNGUzVmpM8PWrHPuV/VH3cAS/
	 xy3IatjTxbFVBg1CKC1M3wqT/q5LE6gpiqlKpeQ77wfOHYIDIMB0RbdLAQz4q3ft++
	 EGY1sMY8HYUniMVaZuIDPpyFiRFaj+x1yJg8eqUI=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read / stack overflow in" failed to apply to 5.10-stable tree
To: meatuni001@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:41:53 +0200
Message-ID: <2026090853-convent-spill-68e6@gregkh>
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
git cherry-pick -x 99aa998dec83ba180822f70e6d48a514fc81c20d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090853-convent-spill-68e6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99aa998dec83ba180822f70e6d48a514fc81c20d Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 28 Jul 2026 17:54:54 +0500
Subject: [PATCH] staging: rtl8723bs: fix OOB read / stack overflow in
 rtw_get_wps_attr()

rtw_get_wps_attr() walks WPS attributes inside a WPS IE taken from
a wireless management frame. For each candidate attribute it only
checks that the fixed 4-byte attribute header (2-byte ID + 2-byte
length) fits inside the IE:

	if (attr_ptr + 4 > wps_ie + wps_ielen)
		break;
	u16 attr_id = get_unaligned_be16(attr_ptr);
	u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
	u16 attr_len = attr_data_len + 4;

attr_data_len (and therefore attr_len) is read directly from the
wire and is never checked against the remaining bytes in the IE
before being used as the size of:

	memcpy(buf_attr, attr_ptr, attr_len);

Since attr_len is fully attacker controlled (0 to 65535+4), this is
both a heap OOB read of wps_ie, and, more seriously, a stack buffer
overflow at several call sites where buf_attr is a single-byte
stack variable, e.g. rtw_get_wps_attr_content()'s callers passing
WPS_ATTR_SELECTED_REGISTRAR into a stack "u8 sr"/"u8
selected_registrar" (drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c,
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c). A crafted WPS IE in a
beacon or probe response processed during scanning can therefore
smash the stack of the parsing thread.

rtw_get_wps_attr_content() itself has no independent length check
and simply trusts the attr_len it gets back from rtw_get_wps_attr(),
so fixing the bound here also fixes that caller.

The "attr_ptr + 4 > wps_ie + wps_ielen" header check above was added
by commit 1463ca3ec6601 ("staging: rtl8723bs: fix OOB reads in
rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()"), which
bounded the fixed header but never extended the check to cover the
variable-length attribute data that follows it. Add that missing
check before attr_len is used as a memcpy() length or accepted as a
match.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-2-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 66f476a46aad..2a58a5cdd9f5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -741,6 +741,10 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
+		/* Reject attributes whose claimed length runs past the IE */
+		if (attr_ptr + attr_len > wps_ie + wps_ielen)
+			break;
+
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 

