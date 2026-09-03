Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB554BB5D9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447531; cv=none; b=QJspwjvhalJuHEjAjPbAhFg/nd71ObDmNLljxwhu3jthEs9HciYnK1atwD3iGwBXIcVYcrexPjlY8IXFF3Wi/Lwlk1gMat7ZNqcCBZBkjxZzpfoAMOClrX5sEpErqyy2eKbcMkupDzL/qTPh8+tTG9vr0Zxba/ELYDpZdJ6ac7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447531; c=relaxed/simple;
	bh=X0R5QJj2YS3iWu4/E5e5aIhYgM0QWYaQS3q/QITEj9E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KU5RKiRIUr6slRqEk6/uU/MrjQF0TXkSYBEFu22jX/Uh38AWyvqpoetqmpV3l05nnZzGIGaykWlsTF4AvpwEY58OymW8iEyPbOEyNcZv3vR6ZKCJC3prpJO8V+T5YltCwZI/N78upnGjWE6BnbSW9v/n+Nf7TgTnOp6lmHFu/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5eWukVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5eWukVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B0C1F000E9;
	Thu,  3 Sep 2026 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447530;
	bh=kDUk23vrPDDE9zJQ6qV781jrbxCH5tJU6yMwBILINTY=;
	h=Subject:To:Cc:From:Date;
	b=c5eWukVoEFAW0VxpIE6kbsJGR9NOGQ/TdcPg/3nWuSv2ED8xE5pYC4K6VH0xqVGLy
	 GwaN6AvFcda5bJBnfVTNa5h4muEv1h8l5Oqax5Gf7mHoUfC96t2HZ0m+dpX4Rtb9qd
	 X4jgHZRKokG0kSGVTAeNK/nWjtKOvnuVRwIBi9Ic=
Subject: FAILED: patch "[PATCH] i2c: mxs: fix DMA channel leak on probe error" failed to apply to 6.12-stable tree
To: ruoyuw560@gmail.com,Frank.Li@nxp.com,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:34:01 +0200
Message-ID: <2026090301-stream-storage-7d41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 777979e627115734052b323d2721cdb500e81dcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090301-stream-storage-7d41@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 777979e627115734052b323d2721cdb500e81dcf Mon Sep 17 00:00:00 2001
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Sat, 15 Aug 2026 23:17:20 +0800
Subject: [PATCH] i2c: mxs: fix DMA channel leak on probe error

mxs_i2c_probe() requests an exclusive DMA channel before resetting the
controller and registering the I2C adapter. If either later operation
fails, probe returns without releasing the channel because the remove
callback is not invoked after a failed probe.

Use devm_dma_request_chan() so the device core releases the channel on
probe failure and driver detach. Remove the manual release from the
remove callback because the channel is now device-managed.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
Assisted-by: unnamed:claude-opus-4.8 typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: <stable@vger.kernel.org> # v3.7+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260815151720.3757460-1-ruoyuw560@gmail.com

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 4e07babea9c3..eee4fdcd9df3 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -839,7 +839,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -877,9 +877,6 @@ static void mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 }
 

