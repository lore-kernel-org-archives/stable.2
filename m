Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBB4B26F0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447990; cv=none; b=GruMtB4Z1IMhXYSoVJiAjZnTkDWoXihHp3JeksZS0IyrzDGzUeae5CV7y4b+I1iZLIxkPDh2SOUKaRFsHqZwRmAO1YMqnh4YkDGbMRSYDekfvmkPUUGuQnFre84rEZjxAfPo1KiP7IpU4Kpf5pZLCQtV+ju2rePVpQrL4Y3jZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447990; c=relaxed/simple;
	bh=8HMyp8Dhxnms72qXLS7GcAVrdACc8Mt+s5HQ4MRRUoI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WDcJpBBbeHx5VMLWoU14+7b2TFkW37Tlk6x+GsN7fybSXb6wH/9fdeHz70alM6dVHvv5sNmXaHfF2OYM16vDDoek0OBD36ftmDxKJziiZAP3jdJw/N91th/mkAKnm3c1TA3JxXaWg5H8M6nWIHi3DQbC3I2zBByamwTp2aKkUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trWQFZeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trWQFZeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7931F000E9;
	Thu,  3 Sep 2026 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447989;
	bh=I+ae8pF6JiIRyyF4/zffdvo1IVn3OibFcw0y8AusSsA=;
	h=Subject:To:Cc:From:Date;
	b=trWQFZeSB4axMyvynscgBwbb8UXWWIRkQ14MSdT80MnExOPtyNpvn+b9L0N3ab3u3
	 mUewr7IQJVWAzP4IFPyxT7c5zDc5r2lgJ34N1ZQvWAPSEQPGEpRQAbZTlowud46Mlz
	 pfBsLD5PEAWkT0qAnXIkatbP17OENBt0R4p994wE=
Subject: FAILED: patch "[PATCH] platform/x86: think-lmi: Fix certificate thumbprint sysfs" failed to apply to 6.1-stable tree
To: thorsten.blum@linux.dev,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:49:27 +0200
Message-ID: <2026090327-banknote-slogan-6f7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f3183f5ae9b8ddfe338d79a96146a05342bbe50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-banknote-slogan-6f7e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

