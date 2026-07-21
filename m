Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFB445AF2
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627109; cv=none; b=fsu8JtnOZspJuywno+4y28SjMRXBZS0qPvLWCgIR146bgAxB5wYm6yj1iqMR4BV7PxLIKXIZpNKGKbu+4d08dn6jEQQL5KLtUA0PND8U24IUMzSXP3wCc/x7zNTcwedFc2wX0J4LrIy5auh/gBwM2bLIcdZsgp7yI5NdgWE+npM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627109; c=relaxed/simple;
	bh=isCipL/AvxBTj4YQMMqySx5Kh83uqGFmLros5PPxd88=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I1vXaJZCgs3f/l44hnRrpE8OctsbmSqmeDO7RNkNogIa3CpaKNSLNURk/UUPiBgoPwFjZ0aI28ex1S/Ho/AJDJneA1ALINqISRJC782qJEUpBloW1C3N5F4+WF3rxzEFRNepBAIKwcszW7bDWhCKD1EZF+SgMJSqSRAD0WHF/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XrvdUJJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XrvdUJJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36A91F000E9;
	Tue, 21 Jul 2026 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784627105;
	bh=8WjXdoSoQMwi8PN2Mp5A3LemhDRfAUPd3xSxS52kwS0=;
	h=Subject:To:Cc:From:Date;
	b=XrvdUJJcWZ0L/Sh9NTKzoYiYgS8k8uMOpgNO+J/gv8zRDSrW25K8G4eHrRKgaomjL
	 67TXnsl5xSSkIoqsj+c+BUDziNN/whChT5c3dLQk+iZdp221LNgZCG1smnToTGv3S2
	 sYUAIkZjAGVXKoL3RDmjmvx2ndrGp+KmAsNJb35Q=
Subject: FAILED: patch "[PATCH] wifi: ieee80211: validate MLE common info length" failed to apply to 6.1-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:44:48 +0200
Message-ID: <2026072148-cattle-uniformed-bf56@gregkh>
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
git cherry-pick -x 293baeae9b2434a3e432629d7720b5603db2d77e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072148-cattle-uniformed-bf56@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 293baeae9b2434a3e432629d7720b5603db2d77e Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Fri, 12 Jun 2026 01:35:07 +0800
Subject: [PATCH] wifi: ieee80211: validate MLE common info length

ieee80211_mle_common_size() uses the first common-info octet as the
common information length for all known MLE types. However,
ieee80211_mle_size_ok() only validates that octet for Basic, Probe
Request, and TDLS MLEs.

Reconfiguration MLEs also skipped the length octet when calculating the
minimum common size, and Priority Access MLEs skipped validation of the
advertised common information length.

Account for the Reconfiguration common-info length octet and validate
the advertised common information length for all known MLE types. Keep
unknown-type handling unchanged.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20260611173506.36838-2-enderaoelyther@gmail.com
[remove now misleading comment]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 18f9c662cf4c..c109722b1969 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -857,7 +857,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u8 fixed = sizeof(*mle);
 	u8 common = 0;
-	bool check_common_len = false;
+	u8 common_len;
 	u16 control;
 
 	if (!data || len < fixed)
@@ -868,7 +868,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 		common += sizeof(struct ieee80211_mle_basic_common_info);
-		check_common_len = true;
 		if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
 			common += 1;
 		if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
@@ -888,9 +887,9 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		common += sizeof(struct ieee80211_mle_preq_common_info);
 		if (control & IEEE80211_MLC_PREQ_PRES_MLD_ID)
 			common += 1;
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+		common += 1;
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
@@ -902,7 +901,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 		common += sizeof(struct ieee80211_mle_tdls_common_info);
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		common = ETH_ALEN + 1;
@@ -915,11 +913,9 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	if (len < fixed + common)
 		return false;
 
-	if (!check_common_len)
-		return true;
+	common_len = mle->variable[0];
 
-	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	return common_len >= common && common_len <= len - fixed;
 }
 
 /**

