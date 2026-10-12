Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033649B465
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818500; cv=none; b=Uv5mA521YmIiEbEiEdZGPKBbDflvHRoTMfrNAwdrxHZEz2MngHaGjnOW47Xlh5hOQoMiASRdVdUq5eX4JMlS6lFM2coHl5MgxI6qIr7kxQher5oovCPwo2J4NnIr0n/V4yewTm6TCN7x7boM6sK2WBk01003czSVGAggP9A3Npw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818500; c=relaxed/simple;
	bh=ymSjVHBU6Za5g9JZ9eoqtPhKMRIHJ1nmj+wHcQOtpIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nOfvKF51KZ9AN9EtrtkwTSq7zaJajoTvj4sxVLLOchu7YGQCuxgNtFVYqz8aytvuJ//oB2Ce+7WSVFsWRaFwE+lePqmjttUIdcI7f3iUuWvTmWljBlrfF0AcIoZWtXvwsa4uaeZSX8TSXF1TA3+Y5BUKmdRqkWSV2QM7wvM1dZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t9hA+tzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t9hA+tzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24891F0089B;
	Mon, 12 Oct 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818499;
	bh=p36vwDvpGk83imKCo+6utJx4oJE6VZsyhNWek7LTE/c=;
	h=Subject:To:Cc:From:Date;
	b=t9hA+tzSO1L9qoJI4R3fzU6/nD65QIhdoCTQLq9gQCRfbtCfuNkbwYVFt98dOvovy
	 syGORsnuZ+4bYclZRJFvOnX0zrFJSxuWMeT4thUQjePmBYfk/rhpJhLAmgyiRYzNF4
	 VSSaa3dPIOpTb6/tMR6Yd5DTHTb75VnB+xpV8dwU=
Subject: FAILED: patch "[PATCH] scsi: ch: Do not keep references to data transfer element" failed to apply to 6.1-stable tree
To: ahmedhal@gmail.com,loberman@redhat.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:21:40 +0200
Message-ID: <2026101240-identity-dormitory-be3b@gregkh>
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
git cherry-pick -x 27c0f718d3b3c99e6d315308e95d987d0382a8a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101240-identity-dormitory-be3b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27c0f718d3b3c99e6d315308e95d987d0382a8a8 Mon Sep 17 00:00:00 2001
From: Ahmed Abdelhaleem Ahmed <ahmedhal@gmail.com>
Date: Tue, 22 Sep 2026 15:46:46 +0000
Subject: [PATCH] scsi: ch: Do not keep references to data transfer element
 devices

ch_readconfig() looks up the scsi_device of every data transfer element
whose SCSI id the changer reports in READ ELEMENT STATUS, and stores it in
ch->dt[]. scsi_device_lookup() takes a reference, and nothing ever drops
it: ch_destroy() frees the array with kfree(). ch->dt[] is read nowhere
else - it only supplies the vendor, model and revision printed in the same
loop.

Once such a drive is removed, its scsi_device can never be released. It
stays on the host's device list at its address, so a new device there is
refused by anything that walks the list - target_core_pscsi reports
"scsi_device_get() failed for H:C:T:L" - and the low-level driver's module
can no longer be unloaded. Only a reboot recovers.

It shows with any changer that reports its drives' ids; with the mhvtl
virtual library (IBM 3573-TL personality), each create and remove of a
library with four drives leaves four references behind, counted by the
module's use count in lsmod. With ch not bound the count is unchanged, and
with this patch applied it is unchanged too.

Drop the reference as soon as the name has been printed, and remove the now
unused dt[] array. That also removes the array leaked when ch_probe() fails
after ch_readconfig().

The same leak was reported with an RFC patch in 2022, which was not merged.

Fixes: daa6eda65a53 ("[SCSI] add scsi changer driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-scsi/20220719075442.6215-1-yanghao_ht@163.com/
Signed-off-by: Ahmed Abdelhaleem Ahmed <ahmedhal@gmail.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Fixes: daa6eda65a53 ("[SCSI] add scsi changer driver")
Link: https://patch.msgid.link/20260929-ch-dt-leak-v2-1-ddda8d635dca@gmail.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 4010fdbf813c..c36539c83ed1 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -112,7 +112,6 @@ typedef struct {
 	int                 minor;
 	char                name[8];
 	struct scsi_device  *device;
-	struct scsi_device  **dt;        /* ptrs to data transfer elements */
 	u_int               firsts[CH_TYPES];
 	u_int               counts[CH_TYPES];
 	u_int		    voltags;
@@ -363,15 +362,10 @@ ch_readconfig(scsi_changer *ch)
 			vendor_labels[i]);
 	}
 
-	/* look up the devices of the data transfer elements */
-	ch->dt = kzalloc_objs(*ch->dt, ch->counts[CHET_DT]);
-
-	if (!ch->dt) {
-		kfree(buffer);
-		return -ENOMEM;
-	}
-
+	/* report the devices of the data transfer elements */
 	for (elem = 0; elem < ch->counts[CHET_DT]; elem++) {
+		struct scsi_device *sdev;
+
 		id  = -1;
 		lun = 0;
 		if (elem < CH_DT_MAX  &&  -1 != dt_id[elem]) {
@@ -387,10 +381,8 @@ ch_readconfig(scsi_changer *ch)
 			VPRINTK(KERN_INFO, "dt 0x%x: ",elem+ch->firsts[CHET_DT]);
 			if (data[6] & 0x80) {
 				VPRINTK(KERN_CONT, "not this SCSI bus\n");
-				ch->dt[elem] = NULL;
 			} else if (0 == (data[6] & 0x30)) {
 				VPRINTK(KERN_CONT, "ID/LUN unknown\n");
-				ch->dt[elem] = NULL;
 			} else {
 				id  = ch->device->id;
 				lun = 0;
@@ -400,18 +392,16 @@ ch_readconfig(scsi_changer *ch)
 		}
 		if (-1 != id) {
 			VPRINTK(KERN_CONT, "ID %i, LUN %i, ",id,lun);
-			ch->dt[elem] =
-				scsi_device_lookup(ch->device->host,
-						   ch->device->channel,
-						   id,lun);
-			if (!ch->dt[elem]) {
+			sdev = scsi_device_lookup(ch->device->host,
+						  ch->device->channel,
+						  id, lun);
+			if (!sdev) {
 				/* should not happen */
 				VPRINTK(KERN_CONT, "Huh? device not found!\n");
 			} else {
 				VPRINTK(KERN_CONT, "name: %8.8s %16.16s %4.4s\n",
-					ch->dt[elem]->vendor,
-					ch->dt[elem]->model,
-					ch->dt[elem]->rev);
+					sdev->vendor, sdev->model, sdev->rev);
+				scsi_device_put(sdev);
 			}
 		}
 	}
@@ -575,7 +565,6 @@ static void ch_destroy(struct kref *ref)
 	scsi_changer *ch = container_of(ref, scsi_changer, ref);
 
 	ch->device = NULL;
-	kfree(ch->dt);
 	kfree(ch);
 }
 

