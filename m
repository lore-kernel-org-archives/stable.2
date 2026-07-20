Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ECA27874F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560841; cv=none; b=NLLaFNWgD2w183Q6PUzrrBkUA431mryTDHuubGePAjle44bsrAd5hWlY2Iq3udO6Lunz+TfJb5V+FsKHNyET8VV2a4R/GBo14GPoGw99++jk0TwdqG7AG86+G2h3zh8ATlW5trSsTZrEd6QEOSQ4GLHZIcnE2YcBELHQLfwbhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560841; c=relaxed/simple;
	bh=zpl1s8Qw6pC/PdVwIiCKLd0DDmXLJydq+jJy345BjDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hR7xNZq5xPOqokVj12bqP7aQw0+IaVBi/O6Hv7WCpXgKZDkxZ/+CDhghNF0YzNh2Eq4J3tA7V5Zr04wVDDyZMm4kbrmDnZZkUQYasqWkZPWE4LQ6bRO4rlx4SHniL+v1vFMSQJRWsPTx/5vf5uJBbm1j7BOBpWGDqxRQk2j7J/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ALXs0YEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ALXs0YEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287661F000E9;
	Mon, 20 Jul 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560839;
	bh=ViAuoJkXGeXTr5WrNVw4se7XvoTaPOJNQ7Ttko2Z5Pk=;
	h=Subject:To:Cc:From:Date;
	b=ALXs0YEbWR1t1V4XaUl3ef1geVh7L9GO3bo+Xaz/asWbWYpOa6ErVSRzizA7zspJD
	 TnzFs7hJoPRb7KUT37/Mc4C/P9G7PYOkTYIZxiiJ4Hr5qjn93QlZIcH7MQbq91y6Fu
	 RGgVF0Zkswxz2ClpdozV6AW+fNTXBLSsIIIMFqg0=
Subject: FAILED: patch "[PATCH] accel/amdxdna: reject command submission on devices without a" failed to apply to 6.18-stable tree
To: doruk@0sec.ai,lizhi.hou@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:20:30 +0200
Message-ID: <2026072030-chastity-composed-e7c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 38953513d7313992676d4136cd425cdb70c6278e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072030-chastity-composed-e7c9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38953513d7313992676d4136cd425cdb70c6278e Mon Sep 17 00:00:00 2001
From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 19:30:29 +0200
Subject: [PATCH] accel/amdxdna: reject command submission on devices without a
 submit op

amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
unconditionally, but only aie2_dev_ops defines that callback.
aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
call and oopses the kernel. AIE4 submits work through a mapped user queue
and doorbell, not this ioctl path.

Reject the submission early with -EOPNOTSUPP when the device provides no
cmd_submit op, so the shared EXEC ioctl is a clean no-op on such devices.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260713173030.87541-3-doruk@0sec.ai

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index a5c8c2c4de6d..bdbd3db12a6c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -590,6 +590,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 	int ret, idx;
 
 	XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", cmd_bo_hdl, arg_bo_cnt);
+
+	if (!xdna->dev_info->ops->cmd_submit)
+		return -EOPNOTSUPP;
+
 	job = kzalloc_flex(*job, bos, arg_bo_cnt);
 	if (!job)
 		return -ENOMEM;

