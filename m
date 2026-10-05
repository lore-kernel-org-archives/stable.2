Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD741E6A7
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195570; cv=none; b=uDIkS+OZyu1J04LKVSzeJj70n22DpEIgPfHYqLUIxTWw4YrtRodc0H/ToByQqLxRqWRHwa3QW0ftbYKomsKU4QaAhB3tPJ0XyN8DniyV2wjQ9P8j45Ov2dwJ4szHxFVoL4rO+m2F8KeVNHb5QN52Nx51JOHS3cG7HCRsupqWQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195570; c=relaxed/simple;
	bh=GAji249sH5WipMyjCpI71mtLB1IYwZ02tAjtRiUGHiE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pcw3G698Jr7p6r7tB8G4ovvf1ncI7wGklIuJc3dwvROxvvNWABbMNOaFzK6V+3rU+umb7Sc12PJTvm6eaMBkC18pLM+Acxfj4orCwvaN9d1LtAst9tHLu3yjPn12Xn92rdpWkKV2//DptYb6sCINhivRqk0tF/R2dcjLHqAo8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAA1/Agx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAA1/Agx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08211F000FF;
	Mon,  5 Oct 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195569;
	bh=0OaDt5XMCw2dIIZedoJHp4OrXlCumc/lO2cTpy9dx3U=;
	h=Subject:To:Cc:From:Date;
	b=gAA1/AgxF3GKPk5GObLfslDxlsH/l63HvZX/XHWyd29MJNyvTmM0vvCjj3/h6A88J
	 37OYgJArKchKpOPvyje4yg4nXduP3C5eO2BrFquc1SZwd45fK0N/PEaf+M47FU/+xa
	 P1u07UJfVoa/ODm0MQvx0Rfa/+vtMRM3pWY2MGFI=
Subject: FAILED: patch "[PATCH] serial: ma35d1: Fix clock reference leak in" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:19:17 +0200
Message-ID: <2026100517-epic-chomp-5963@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 98401cf912fe8a081ef8e500c421b6d957b55a99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100517-epic-chomp-5963@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98401cf912fe8a081ef8e500c421b6d957b55a99 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 15:56:50 +0000
Subject: [PATCH] serial: ma35d1: Fix clock reference leak in
 ma35d1serial_probe()

of_clk_get() returns a clock with a reference that has to be released
with clk_put(). ma35d1serial_probe() never does that, so the reference
is leaked on the probe error paths and also when the port is removed.

Release it on the error paths and in ma35d1serial_remove().

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Cc: stable@kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917155650.2161274-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 920fe7ff5083..0809655f4395 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -728,7 +728,7 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(up->clk);
 	if (ret)
-		goto err_iounmap;
+		goto err_put_clk;
 
 	if (up->port.line != 0)
 		up->port.uartclk = clk_get_rate(up->clk);
@@ -755,6 +755,9 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 err_clk_disable:
 	clk_disable_unprepare(up->clk);
 
+err_put_clk:
+	clk_put(up->clk);
+
 err_iounmap:
 	iounmap(up->port.membase);
 	return ret;
@@ -770,6 +773,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
+	clk_put(up->clk);
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)

