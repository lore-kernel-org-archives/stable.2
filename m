Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594287;
	b=0QA7yDh6bNxwaCXSjtv9do7EJaiHOx6cc2khPSProi0yZXAAdC/pBdYQ/SzsIwBG4IWT
	 o3tIk/9HPL2mo8Vwuel3Vi5ECt1TSXJ6NmD0YK4EdXGWy4Te+Ns+XGEtAB0rbgnTPX2+R
	 86ilLBtFLH1BGhwrRyJ2yy4xiNLnTN5cify3jNDXnbAmzr3KkbkwBw8OSs8ww8h9Qfv++
	 zVnSX8QxylbvM2rhZQj4AqDFV0+1gK/wiUXNkIM48x1vXdgKSHOUCPVNCWvN3J8eTV2Hj
	 lOK0bK7m4wEMjlJ2BYEqjfYWcYi27DyCycnbRUDSZikADQ5vEhpuCuEfFnSaQmR1+rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594287;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oguaxEgPEC3eKI/cdgZmXXHzO1/yNTxKPNxn/1tgtYU=;
	b=Bo7A5k6bwk0vCeUE3C4BaF9xkKk1hGRBhltBpEl0jAQsShMdiiOgyPYTutI19Unpwxfk
	 8//CSekKFadt/DT+WqLRn04kjVNhKZRsZvf9iUHeTURdiJQS4AobIKxJjMf2N1Yqxy/EF
	 4PQUZuNsumU66DDoqhOSBkh62Z0z4f4H6twy8b80dtS82lT3C3Mi+RCWHYFUWmDSa1tFm
	 /0HjZtCIrb+AhYBPPRrHkPrBWjvU0MoP9Hit3hs1yMQsuorYeDZ81VMkQOnmgeKHdkrxu
	 tPFaV3rt9gtJjV+np46DDPwDkPebrrp5AnTtrcdV2H2yPgnRhcl1OjIZN0fuda6g6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hJTsBqrE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66185606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hJTsBqrE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10651F000C1;
	Wed, 21 Oct 2026 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594287;
	bh=oguaxEgPEC3eKI/cdgZmXXHzO1/yNTxKPNxn/1tgtYU=;
	h=Subject:To:Cc:From:Date;
	b=hJTsBqrEMvjvTOL9iMFZNqGB4V8KkKR6FQZLN6qan7Xs+565HBGTo7yAsE5Rs0qmd
	 sTqJVvcFjJHkQLjvxOdEtEtTgH+J16wQe2pgdLTiTMOCI2s4nsXgspgfjjgwLQNG1Z
	 4ju4JievZUp3hLTOPOyyMRuo+jkHTFYpLa+wtUhA=
Subject: FAILED: patch "[PATCH] scsi: st: Fix use-after-free race between st_remove() and" failed to apply to 5.15-stable tree
To: loberman@redhat.com,dingiso.kernel@gmail.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:44:31 +0200
Message-ID: <2026102131-preview-unlovely-f4ad@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 71caf7f84bd62a4bf91cc95abd2de690afb8d15f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102131-preview-unlovely-f4ad@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71caf7f84bd62a4bf91cc95abd2de690afb8d15f Mon Sep 17 00:00:00 2001
From: Laurence Oberman <loberman@redhat.com>
Date: Tue, 13 Oct 2026 16:25:48 -0400
Subject: [PATCH] scsi: st: Fix use-after-free race between st_remove() and
 st_open()

st_remove() drops the probe reference on the scsi_tape with kref_put()
and only afterwards removes its index from st_index_idr. If that was the
last reference, scsi_tape_release() frees the structure while it is
still published in the idr.

scsi_tape_get(), called from st_open(), looks up the tape in
st_index_idr and takes a reference under st_ref_mutex and
st_index_lock. remove_cdevs() does not wait for opens that are already
past chrdev_open(), so an open that is blocked on st_ref_mutex while
st_remove() holds it can take the mutex as soon as st_remove() drops it,
find the freed tpnt in the idr and call kref_get() on it:

  BUG: KASAN: slab-use-after-free in st_open
  Write of size 4 ...
   st_open (drivers/scsi/st.c:254 drivers/scsi/st.c:1291)
   chrdev_open
  ...
  Freed by task ...:
   kfree
   st_remove (drivers/scsi/st.c:4512)

Remove the index from the idr before dropping the reference, all under
st_ref_mutex. A concurrent scsi_tape_get() now either runs first and
holds a valid reference that keeps the tape alive, or runs afterwards
and finds nothing, so st_open() fails with -ENXIO.

This restores the ordering st_remove() had before the conversion to
st_index_idr, where the tape was unpublished from scsi_tapes[] before
the final kref_put().

Fixes: 6c648d95a6af ("[SCSI] st: get rid of scsi_tapes array")
Cc: stable@vger.kernel.org
Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: https://lore.kernel.org/linux-scsi/20261007211520.1428497-1-dingiso.kernel@gmail.com/
Tested-by: Dingisoul <dingiso.kernel@gmail.com>
Signed-off-by: Laurence Oberman <loberman@redhat.com>
Link: https://patch.msgid.link/20261013202548.249628-1-loberman@redhat.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index cab8aa73969c..a757646c8dc6 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4515,11 +4515,11 @@ static void st_remove(struct scsi_device *SDp)
 	remove_cdevs(tpnt);
 
 	mutex_lock(&st_ref_mutex);
-	kref_put(&tpnt->kref, scsi_tape_release);
-	mutex_unlock(&st_ref_mutex);
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, index);
 	spin_unlock(&st_index_lock);
+	kref_put(&tpnt->kref, scsi_tape_release);
+	mutex_unlock(&st_ref_mutex);
 }
 
 /**

