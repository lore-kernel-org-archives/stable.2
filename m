Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7642DA3F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225861; cv=none; b=VE87rYCV/i0BnidkUNrVQAxr98exzVuE26ioBzmX4iFcvxAPImDO0yPtnDs0Hkxmlw9FMqcJLK+A/dTLR8CGDfvaWDdIpjHv/QSWNeWxQ4kZbGyvcf3v98apOVDchGV6M1RojfSMd7eCapsLdOb2EYy8rwnH8VTpQOyK7/a0AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225861; c=relaxed/simple;
	bh=EagDfLbasNS5puDXWRfdlciqbQZBlrJZgh7RjjsXH0g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eTC/6CoaV/th/1d5TlS/dhmjjvJwO+h8ExN1dU9cUyvq+891f06U0XhXJvbo+IeiVTOzAI+PqkGPAsxYmqgWQMVjP589w2slo7+/7uEWQHLsR2VPbZWh2TkdHuBDS6PxPE31EX6ynox/2//KQZOXitQBBRD3ygLUlWpPTosFzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6rk5e8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6rk5e8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9A1F000E9;
	Thu, 20 Aug 2026 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225860;
	bh=OtogEtZhhEMXS1cm6lX9IT7S4MKv92y9cvMPYnlIfts=;
	h=Subject:To:Cc:From:Date;
	b=e6rk5e8Wu27I8LWnAzjTqdu2aisUOEtMYm5NQWArSPInVL5JfeoqErGDLJqWleF/E
	 05NIsWGt6EFeIDz6hf79o60fSGKwdfeDoF0qrUtMUQokJr42FxXLp7GZwV1kWQxPSe
	 B0K3NuZ6IlsKkrG23K2ohh+RmNQGfKb5IBx9JtPU=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Ensure first IDAW remains constant" failed to apply to 5.10-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:23:10 +0200
Message-ID: <2026082010-headboard-hamper-69a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 565bef268d75bf7df665bce6923a88cd0eb74592
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082010-headboard-hamper-69a9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 565bef268d75bf7df665bce6923a88cd0eb74592 Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:16 +0200
Subject: [PATCH] s390/vfio_ccw: Ensure first IDAW remains constant

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL.

Verify that the address found in the first IDAW is unchanged between
reads, to ensure a consistent set of IDAWs being worked with.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index af632f9d5453..6275794751cb 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
+	u64 first_idaw;
 	int idal_len = idaw_nr * sizeof(*idaws);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
@@ -539,6 +540,18 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		idaws_f1 = (dma32_t *)idaws;
+		if (cp->orb.cmd.c64)
+			first_idaw = dma64_to_u64(idaws[0]);
+		else
+			first_idaw = dma32_to_u32(idaws_f1[0]);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw != cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -604,6 +617,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 		iova = dma32_to_u32(ccw->cda);
 	}
 
+	/* Save the read address for later */
+	cp->guest_iova = iova;
+
 	/* Format-1 IDAWs operate on 2K each */
 	if (!cp->orb.cmd.c64)
 		return idal_2k_nr_words((void *)iova, bytes);
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index a9b1d8dbc6f6..9af98ff12d67 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -35,6 +35,7 @@
  * @initialized: whether this instance is actually initialized
  * @guest_cp: copy of guest channel program
  * @ccwchain_count: number of channel program segments (linked by TIC)
+ * @guest_iova: first data address of a guest channel program
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -46,6 +47,7 @@ struct channel_program {
 	bool initialized;
 	struct ccw1 *guest_cp;
 	unsigned int ccwchain_count;
+	u64 guest_iova;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);

