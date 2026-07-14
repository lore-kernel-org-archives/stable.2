Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901ED3890E0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045007; cv=none; b=HrEa+qG9w69ZDHkeGWSgWfhm72ISV4kIjINTt+4Chy1t2AQaxR0yLM5SEYIyustourxFi7g7sXpb9In2gqrgxUew+JqUz5rvAzRdiAl3xjg4u5HDD3ihDCgwRFZ5JosC6FksxmBfOGtYVcJoVCFPbOYa+dkZWZ7TX7F6bFi3bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045007; c=relaxed/simple;
	bh=tdCTinZhd8OZzikBSbGYEyuW2+fhsRbwsajxmlSyf1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XZq2AOgXIATX7gt7selgNTnFM1spE9ztj0+/Cm1V6LIqfYRZgGGryz9VeTaFLMUcCSyC8fiZH6An93fwz/8wLZeCkegVOdDHbE1GSAOMNbg06+7NXrEsveSdHivjr9nZtzZqoBcXi3B6q0K/lVBlBQ+cR+Bdd5AA2EvPR6B7C+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGNKbM6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGNKbM6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029221F000E9;
	Tue, 14 Jul 2026 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784045006;
	bh=Y+YrQtFk4G/sEimj4P5FRB55qwpw2m4gFZZOOgqi8LQ=;
	h=Subject:To:Cc:From:Date;
	b=MGNKbM6LX8xdcmb4iLitC/fEnBCIZoFPqut7lH3ULxEV08mgiT3t1BIvpbL7lHPkw
	 /tnIyVLigDuaTtHtGq1ivYZwkKOPDmGL+Lc4YRKcCPFpatBepnI/hYr4YomqECxDdM
	 QiQWEFzYm567gFXsZhZQPY65CJADi5xP7JCufwGA=
Subject: FAILED: patch "[PATCH] usb: gadget: f_printer: take kref only for successful open" failed to apply to 5.15-stable tree
To: raoxu@uniontech.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:03:12 +0200
Message-ID: <2026071412-palpable-underuse-1c58@gregkh>
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
git cherry-pick -x 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071412-palpable-underuse-1c58@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Fri, 26 Jun 2026 14:46:17 +0800
Subject: [PATCH] usb: gadget: f_printer: take kref only for successful open

printer_open() returns -EBUSY when the character device is already
open, but it increments dev->kref regardless of the return value. VFS
does not call ->release() for a failed open, so every rejected second
open permanently leaks one reference.

Move kref_get() into the successful-open branch.

Fixes: e8d5f92b8d30 ("usb: gadget: function: printer: fix use-after-free in __lock_acquire")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/80295742B820DA9B+20260626064617.4090626-1-raoxu@uniontech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..837f753d0cae 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,12 +363,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	kref_get(&dev->kref);
-
 	return ret;
 }
 

