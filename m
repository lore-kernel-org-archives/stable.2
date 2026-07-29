Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE948D89F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331904; cv=none; b=bbAEiW8LWFpKQSlfGA0bUohgr064xTHydyHXJXoURNKOcNlKQuQEVbJnXUA8X14SbpT05mHKUaS2FKgn390NXKGmuZtX7155WU6+OObWTt+Ci/jdJIXQc8RfEYbdveTdgscWTZGjydn7YnqL6OLIwAWcsc0hiInEoErVpmL6zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331904; c=relaxed/simple;
	bh=/hmQmjPV4j4zmuC9Tvbxvg4eNv9APQjA3wrYFn+0lqg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VptCP2hMwmFlkhlOSy4kpwxlIEJ/ApP7VzbfLZxwpwmvEq9jC2Bjm9zjZ1dvWCl4uvl6aymaGmppuVYVD6gEJcTnxD/WPzBf9Gb/xHpd70Wz5OOomFgx/X8IcVtSQ9ahfEw/eASwG8lOtP2hKo77rqgEjTgfbP3+VHqRSqdSaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fs+fz8PP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fs+fz8PP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1761F00A3E;
	Wed, 29 Jul 2026 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331899;
	bh=zwreOOUeNhDuD62bmyZU4o7dVuVW3Ih91QNezncptcE=;
	h=Subject:To:Cc:From:Date;
	b=fs+fz8PP+TsuYe2NGTFBn+irMX+s0Jih6rxA0SsPFV05d2Xeo+7O60Pg8OpboYXJS
	 x8aDw3YTjWyO6u6VzPVPYXoZguSsx4kNjjRRQf6GZId1wfYax9Y3OdGnL1WQJWROvm
	 fDUdRNmDr39MUyTt0bunwOpBbUUqRJQ6xCk9Yx3w=
Subject: FAILED: patch "[PATCH] serial: 8250_mid: Fix NULL function pointer dereference on" failed to apply to 5.15-stable tree
To: yijiangshan@kylinos.cn,andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:31:25 +0200
Message-ID: <2026072925-blitz-earflap-f9ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7fb13fd7e9a59a37cd911efff83abe19e3ee029d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072925-blitz-earflap-f9ba@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fb13fd7e9a59a37cd911efff83abe19e3ee029d Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Wed, 15 Jul 2026 15:35:46 +0800
Subject: [PATCH] serial: 8250_mid: Fix NULL function pointer dereference on
 DNV/ICX-D/SNR platforms

Commit b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected
platforms") replaced the dnv_board setup and exit callbacks with
PTR_IF(false, ...), which evaluates to NULL. However, the three call
sites in mid8250_probe() and mid8250_remove() unconditionally
dereference these function pointers without NULL checks, causing a NULL
pointer dereference (kernel oops) on any Denverton (DNV), Ice Lake Xeon
D (ICX-D/CDF), or Snowridge (SNR) platform.

Fix this by adding the missing NULL checks before calling the setup and
exit callbacks.

Fixes: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Link: https://patch.msgid.link/20260715073546.1875083-1-yijiangshan@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index f88809ff370b..82656645b8a6 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -318,9 +318,11 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	ret = mid->board->setup(mid, &uart.port);
-	if (ret)
-		return ret;
+	if (mid->board->setup) {
+		ret = mid->board->setup(mid, &uart.port);
+		if (ret)
+			return ret;
+	}
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
@@ -336,7 +338,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -346,7 +349,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {

