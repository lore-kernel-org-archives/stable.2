Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740804C77D7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447993; cv=none; b=spGDSHvTvS6uyVprx5J/6bw+1sHCmCqSwBxTR1UPxOAcwPsYtfWhsP5gtnipjgd9bhstiMjnbOQ4RjkscHye7s3wsH8VuM8WIWZuW63fvnUtnj+SxU2peYkVtUuH3/8uwFTnWIQcl0kSJpkDk7A5xgWubD0ke1ivn79UVJHhpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447993; c=relaxed/simple;
	bh=Br+3XEEzsxSBVe1K+Eu19znPSdGTkUmybANhC14H/gI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=saFLwYE/R4QY7lU7czgZNusvI7QeB5vgKOEq4RmLEnQYunDdxs25l1sK2d35qwmq/B343a2XDjEScxFmST31+idpesB65JkJ8x4cXWKEjsZHgju/kkzpywKMctD2wiLFNZBClQoLkrx/Qez/71kTH+sbMsli+P+DXdvDJM3FUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x3BuD75J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x3BuD75J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09BA1F000E9;
	Thu,  3 Sep 2026 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447992;
	bh=voq8qtjzTc8SUygeQE+dO4VjShdjuPD9OxGAwkOSmm0=;
	h=Subject:To:Cc:From:Date;
	b=x3BuD75JQZjJmR41xp+rutVktBeDpaf7wGyVbCd/4G+Xl/7AWTrTrtaRifEJbah84
	 Xe4xWQYOQn47qfae6/HlQj/L875Pri1OoRmrOTRS/Q+CfYaNLWCPUew1MwzfNHq3d2
	 mrgcZo+o0jBYl+RXpTpQRE+NyPyM2e5sOL1sw0Ug=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix current password length check" failed to apply to 6.6-stable tree
To: thorsten.blum@linux.dev,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:49:42 +0200
Message-ID: <2026090342-prepay-dwelling-6bbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 54745d563114b74f6fecebce68cd020d06c1772b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-prepay-dwelling-6bbb@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54745d563114b74f6fecebce68cd020d06c1772b Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Tue, 18 Aug 2026 17:16:35 +0200
Subject: [PATCH] platform/x86: think-lmi: Fix current password length check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

current_password_store() checks the password length before removing the
trailing newline, which can reject valid passwords that are exactly
->maxlen bytes long.

It also passes ->maxlen to strscpy(), which truncates passwords without
a newline.

Use strchrnul() to measure the password length up to the newline, then
copy that many bytes and add a trailing NUL terminator using strscpy().

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260818151635.37094-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index ca266657e16c..a0e3fa766e37 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -438,14 +438,13 @@ static ssize_t current_password_store(struct kobject *kobj,
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 	size_t pwdlen;
 
-	pwdlen = strlen(buf);
+	/* Strip newline; setting password won't work if one is present. */
+	pwdlen = strchrnul(buf, '\n') - buf;
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
 		return -EINVAL;
 
-	strscpy(setting->password, buf, setting->maxlen);
-	/* Strip out CR if one is present, setting password won't work if it is present */
-	strreplace(setting->password, '\n', '\0');
+	strscpy(setting->password, buf, pwdlen + 1);
 	return count;
 }
 

