Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1A4248CE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065569; cv=none; b=LBmp3TFfXSOc5U1QTd+Im0tlsgpEvvVRXcHPsVf1o952Sy2nL5GF6txb1+LwrI9TaYzVvZcse7PjgJCv12sArO+aUe8/OBGs7bX+603DAWyB5yNXikk6/qmnQ6NKXcsUlRhaTz10f0MGct/pLJJ606lQh4FMz+LEvCKPdZZVUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065569; c=relaxed/simple;
	bh=k8K1wFmXPu/+l7RLGlbGkUqL6YNrjOJ5KFpTcuAtEIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fzAuYbVV2WDy5uR683hbdapigjxBz53lukkHrFq0QH0ZdefwpBDCt6wpnEhiii+JNSsem3BtL5khq3PRWWuotJI6oqOf+fcmN8LHFXzwc6DO2ZZHb3kIFlAod4xtEJY4IE25beDz9Rwdl0GsvSPuoQksxCdyapPZFbJ+jse2MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcbZgSXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcbZgSXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787E11F000FF;
	Tue, 22 Sep 2026 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065567;
	bh=GLknIys2ieapQ+BUXbK++KCLB0VO6DhdHtsY9mh2uko=;
	h=Subject:To:Cc:From:Date;
	b=YcbZgSXOqPQS8V7LctV57lgwN5QqoaX40xDf+1j7ph8C8RKQMDv6JWjbSiGn1gdCr
	 /PW+I7PsWw5wleYRYSW7+imNXlCivjQeELNy0UBQpkGzFNtouWHTT5v+jaCweFj5qW
	 RQ0qJxmfNA3XLrTCaKPEF7Vh1L5VmH87our0MZhA=
Subject: FAILED: patch "[PATCH] ata: libahci_platform: Fix device reference leak in" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,cassel@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:25:55 +0200
Message-ID: <2026092255-disaster-skittle-8855@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0d1cb83337f13af082afb68b28d3fdfe29cde7fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092255-disaster-skittle-8855@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

