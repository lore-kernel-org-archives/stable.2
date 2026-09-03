Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D604C77A2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447985; cv=none; b=ezsUtdYsxZtareoESLx39Vq8paE/cndA4FEPCI9fCxqeYqo6qSr5HQrfLce0tzhZ8hKm3YG14CduPMBB2a9LQmlhy3oRFO1auD2fUB9xmdVwMdoM4AQUl4+ad1Y7+9WFmTqUrN2pAupRH4NQA5VvMWh9zUGIQrzrlyMZ7qJ5Rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447985; c=relaxed/simple;
	bh=7j62tLEpeO0rL50FZXCsL9/YfFwBDBoC9XpJvYNuwAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=baA+O37fkeGwkreVdw5BmkWP70S64wPp01bCmU1wklEKBjK9ldoEIxUqOlmsVL4vVR25qmol1Jj/v9TXXbBmDoA4TDVtQ+Fbeb77x0vE3WSns+HFFbi/oDbXjGyguCEflk2LI8SvgvrjSEU03cCegukkhIMUDjhgKmxEwnWDP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPOplGCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPOplGCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C631F00A3A;
	Thu,  3 Sep 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447983;
	bh=yJVlp6eg7HpDZulazuvf82F26CkhnjBchsL5fAhXEZM=;
	h=Subject:To:Cc:From:Date;
	b=oPOplGCq4SjYFyEaGmrpm7zeWafIhFcfbDoq1BvEt9wrBPEm/2+KIxICSQxtmE45A
	 Nebi1vr6061rWJqey8f5vypRHaxjp41Kr8O9KBhfGcYFs0urnNiVMOTW7OJcpE1Ecf
	 ZBbZ7eP9i/y6+S6xOGwpwilJ2+tdL0BkJlYDvACQ=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix certificate thumbprint sysfs" failed to apply to 6.6-stable tree
To: thorsten.blum@linux.dev,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:49:26 +0200
Message-ID: <2026090326-unmixable-concur-5982@gregkh>
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
git cherry-pick -x 4f3183f5ae9b8ddfe338d79a96146a05342bbe50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090326-unmixable-concur-5982@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f3183f5ae9b8ddfe338d79a96146a05342bbe50 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Mon, 10 Aug 2026 14:05:57 +0200
Subject: [PATCH] platform/x86: think-lmi: Fix certificate thumbprint sysfs
 output
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cert_thumbprint() already returns the accumulated output length, but
certificate_thumbprint_show() adds that value to count again, making the
next line use the wrong offset. Errors returned by cert_thumbprint() are
also ignored and their negative values added to count.

Assign the total length to count instead and propagate errors correctly.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/20260810120556.149416-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e3e683bf3469..ca266657e16c 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -745,6 +745,8 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
+		ssize_t ret;
+
 		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
 			/* Format: 'SVC | SMC, Thumbtype' */
 			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
@@ -756,8 +758,12 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 		}
 		if (!wmistr)
 			return -ENOMEM;
-		count += cert_thumbprint(buf, wmistr, count);
+
+		ret = cert_thumbprint(buf, wmistr, count);
 		kfree(wmistr);
+		if (ret < 0)
+			return ret;
+		count = ret;
 	}
 
 	return count;

