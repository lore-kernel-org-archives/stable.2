Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643F5208CC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906507; cv=none; b=O6E9/mIXTd3yVAJaHG9fqkk5LINjV6f8gJ+Rd4Haky+a/ZCgn+EoOeA9pYIYDsEA4Ed8y5Qx1aGvx8jR0P9mcrI6zE1qITa7Wa++gPaTVpFBaIRJT1k3E0RXYK2FSTQ9i+I7RIdiwAT/n6K0ibp42gC3NU8StECraplbgJQZlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906507; c=relaxed/simple;
	bh=6AAA6xi0pT7F4vTx4TKJI8q5Wh+fGjxyfO3qMzuZFzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEUWXu+Ea6vjZ0BOywcn0pzZ8b4ewRVwz50jzCLePMjUHuuKyxW9HmBjALDQBVayAyB9VqV38PaScsrDeLFgm4vzi+j9S1NLQ6J6iXpxOFMeRNj2IkTLzS02LwDVE3f8iKrsSNfhndD+7lzK66UCd5lDIevxgwmExT2hqdylPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NENaff16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NENaff16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581381F00898;
	Tue, 13 Oct 2026 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906505;
	bh=MgF7hhbhFJJjcd6DP8+zfuItkv8i0n7avgHqD/yqBPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NENaff16QKD0xUVStBam98+ctecjJpeA/n52pK5PJrMMD7jr+UENPDJL9D3wkbVJX
	 x9XF6Izdz6wrjCqiGDBa2Gcazg9jGoTQNXmjlyAkYrtN5qyX3oIf/3IFnpTWduMkJ+
	 7jry5k7U+fadjRU3u4aqKLULNX/ZjBgyMynPz8jwVnZBdoQqJBJmYNSBtoCA04IAms
	 DEAxpVB7/L5zevdhz1q1P131wsP+XI12deRxTPxAFfy+daFnEBe3t0WmfyXRxtFIfa
	 2YN+YethJAdE7HvvR6B0GMQSxZ/OGUuw1/D2A3dhfn523UX/tACNzh28XxwQwyMmud
	 1PoofDV5sgFIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahmed Abdelhaleem Ahmed <ahmedhal@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: ch: Do not keep references to data transfer element devices
Date: Tue, 13 Oct 2026 11:48:24 -0400
Message-ID: <20261013154802.292702-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101236-primarily-rewrap-7482@gregkh>
References: <2026101236-primarily-rewrap-7482@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Abdelhaleem Ahmed <ahmedhal@gmail.com>

[ Upstream commit 27c0f718d3b3c99e6d315308e95d987d0382a8a8 ]

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
[ sashal: adjusted allocation-removal context for kcalloc() instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ch.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index fa07a6f54003e..c2c018236517b 100644
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
@@ -363,16 +362,10 @@ ch_readconfig(scsi_changer *ch)
 			vendor_labels[i]);
 	}
 
-	/* look up the devices of the data transfer elements */
-	ch->dt = kcalloc(ch->counts[CHET_DT], sizeof(*ch->dt),
-			 GFP_KERNEL);
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
@@ -388,10 +381,8 @@ ch_readconfig(scsi_changer *ch)
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
@@ -401,18 +392,16 @@ ch_readconfig(scsi_changer *ch)
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
@@ -576,7 +565,6 @@ static void ch_destroy(struct kref *ref)
 	scsi_changer *ch = container_of(ref, scsi_changer, ref);
 
 	ch->device = NULL;
-	kfree(ch->dt);
 	kfree(ch);
 }
 
-- 
2.53.0

