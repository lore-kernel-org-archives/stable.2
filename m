Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2ED4C77BA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447948; cv=none; b=mGTsjlOZjaFFGueY+I4vYFb0Q+uR8OvcAvFbKMn97aUTNplv9z7TF371kJBwfV4V4HnaFthYavC1xau2jbANXCGm96UBHT3nWsGwZmBC3igrddLZttv46RausaA/wSDDZRqoPEECUKtscd839xw0BTBEFy0qP9H5ftihikf6wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447948; c=relaxed/simple;
	bh=9mhDVahLz0Bj8RpegpPzO5zoG+jlbFYFsll7yhHVWgI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c0OUMDrOkSd6zLDMYis9zlef7ALmOxY8X5uNj6EmOQuxvi+lpuLyiA68sxdCpDSWQlz/HYNzrx9LpQ53kPpf5Xxjv4d9CIRukqoBZdwC0SlF5upHdMzQ7QrCkHulnnqKaB5LuXwlJ4q6DxMGdSVK1ctz65jvsnTpKyX+XnWrm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z92TO2tY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z92TO2tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A71F000E9;
	Thu,  3 Sep 2026 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447946;
	bh=W0laqGlCPg/uJxFONiC3Vc1tNJFiwruUc+OHuGAvkBo=;
	h=Subject:To:Cc:From:Date;
	b=Z92TO2tY5TX+YTrST01OV/9EzFSjGyK+SbRasuXPi19ttn98Q9nQ1rOjD8iwjMKhM
	 I0Z7cdgt5jkY3hTZiueqqTyxU0CnOHqnVZIS7wlnmbZRs87Oqb8yczfTdtOc5lp223
	 wc5q/03zJ4MC1MbRlGi+jewVScI9amDsTYzcrQ+s=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Add a NULL check for sst_inst[]" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:47:34 +0200
Message-ID: <2026090334-lumber-underfoot-3bf9@gregkh>
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
git cherry-pick -x 3de2776e9d7073765c10c2326c2bda5926811ea6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090334-lumber-underfoot-3bf9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3de2776e9d7073765c10c2326c2bda5926811ea6 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:21:34 -0700
Subject: [PATCH] platform/x86: ISST: Add a NULL check for sst_inst[]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To be consistent with other places, add a NULL check for failed socket
loading by checking isst_common.sst_inst[].

Fixes: d805456c712f ("platform/x86: ISST: Enumerate TPMI SST and create framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811222134.3912626-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a50e3aa8c4d2..66dd974720be 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1433,6 +1433,8 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 		return -EINVAL;
 
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+	if (!sst_inst)
+		return -EINVAL;
 
 	tpmi_inst.count = isst_instance_count(sst_inst);
 

