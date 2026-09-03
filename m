Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA64C77A1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448002; cv=none; b=HO0RXuqY2my8azXEOHYprhXAPMgdmtB5GmQgydQcUAYNFZEY2XGoCXD7FpNkdPdBORafZkWtqoO7MErj0whE572omLRGPgwESdsOlCyqG5X4p8MfVAsRq0JbZRrY2KyB09pUDxjbc/XTwOKZ3a+sZq7vfNX3P2Z+jvaMuz67My4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448002; c=relaxed/simple;
	bh=Jfa+MQ9LjawLDkITauvSbYFqiuYxZ8j4+CVSUQWqpLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j0ohI8Tg1n0Dkbr/0uN4/FeAVv9wwzaoIIxdP+npi4zrlSIgA20H29Oi3E0UWiElOI5KJZGuTNYVk+YSE7vh7j2iXquRBY5ZcGGyVMLE1fIs+VII3bhIzUHZ6axnyRoQ3dcyudL/0CO5AmxRkWoUnK3bXBtyYC0MOZ2C9VvCyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDo/hUVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDo/hUVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347FA1F000E9;
	Thu,  3 Sep 2026 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448000;
	bh=9fNwZw8X02X/fDt3cCFNyNElksukSezTknt+pcMj5ug=;
	h=Subject:To:Cc:From:Date;
	b=qDo/hUVHvUQtdktTsdBmOfGmBmbnKDIdBfH0qgPQPics7RerYZbwV6/G/DwJSE4sn
	 VUvr5cZrxrKB3a7WRxTiUI7NdJGerZyp9TmIgHbL6U0CPHIG+ipC24kJqr6lKzewH9
	 ugP4J+nMlbwMz2vrBNKiibBE2o3wJtdzenSESRM0=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix current password length check" failed to apply to 5.15-stable tree
To: thorsten.blum@linux.dev,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:49:43 +0200
Message-ID: <2026090343-sarcastic-pound-fa39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 54745d563114b74f6fecebce68cd020d06c1772b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-sarcastic-pound-fa39@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

