Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F141A919
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065559; cv=none; b=LwqkR4f8C3JQZnr9OQncE+5/xyD2po74spHtDvNT4+FPAzUASVwnNkpKTkvT6bQq9DoxbeOFXoQpY7VYFb5lxwgI7gW+qyJiiX9hBEENh2DdayuGPpOR6p05q5IV8bvls2QYaIdpXQK0EfehixUi7ImEMSTmbcp5KkhYNIyVPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065559; c=relaxed/simple;
	bh=IOykPecjry2xxirmcg0amhwQgdSKPChtO0tapXw/dB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=okvBjdVoPVpbuCbLrqH+4C/G1diBn8sbFIfbOPUp9kNK9h1EIcyUNQZiOIk3ltrcaBy+9bV2cjjdwWmapzxheWJK03vgWzG5R7j0y8ACWXj520060/3+lxaBnDTa90Xj+C23eBYU4TEQPg73x8IdjrHgWsNk5tUseeFzBwCbEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4NmsfgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4NmsfgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96571F00898;
	Tue, 22 Sep 2026 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065558;
	bh=Bsm9k3DgqgsRD8LJOjuENqSJOzwJE4ccZ2Y6LfX+tks=;
	h=Subject:To:Cc:From:Date;
	b=B4NmsfgAu5a7FN4+UglsHDZPC81cZl/ozoNyqs6AfKHO8j/sqwI0CQnSwHbhxm+lV
	 PA4IRGs6DCLPuSvjpH8sah4Zik0nIMztyZXEjKhZ5by6aY6bmYmOzouLhYTgei9C0u
	 i0cI/setBLQqAMoIWH9ZHW08WU9j4BDvvQORMEDA=
Subject: FAILED: patch "[PATCH] ata: libahci_platform: Fix device reference leak in" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,cassel@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:25:55 +0200
Message-ID: <2026092255-unstamped-imprison-dfc7@gregkh>
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
git cherry-pick -x 0d1cb83337f13af082afb68b28d3fdfe29cde7fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092255-unstamped-imprison-dfc7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d1cb83337f13af082afb68b28d3fdfe29cde7fb Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Tue, 15 Sep 2026 06:59:33 +0000
Subject: [PATCH] ata: libahci_platform: Fix device reference leak in
 ahci_platform_get_resources()

of_find_device_by_node() takes a reference on the port platform device,
which is only used to look up its port regulator and is never released,
neither on success nor on the error paths. Drop the reference with
put_device() once the regulator has been obtained, which covers both the
success and error paths.

Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/r/20260915065933.1733061-1-vulab@iscas.ac.cn
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..f6524135ea11 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -620,10 +620,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			of_platform_device_create(child, NULL, NULL);
 
 			port_dev = of_find_device_by_node(child);
-
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
+				put_device(&port_dev->dev);
 				if (rc == -EPROBE_DEFER)
 					goto err_out;
 			}

