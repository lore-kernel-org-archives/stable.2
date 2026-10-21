Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594276;
	b=s2Jn/NuP60VFMqgtpotNl4hP2RZIRmmJI4ZiIxVSd9boyrzXiOAhP+u7jEbalzYb9nh5
	 MT/OiVjNQwugTvX9fPNnWAR6oHD76Qf33U9pubxnGJ+Yy0Psr/q/wP2GZ9aaDgANSuwT0
	 MmBkHvjFzaDAe/yDSH0Rs+WA1BY3O5cfC0zeBJ+8j6Quy5Ehbtcsdl1BKhpmfPGc1iaG9
	 Drozi5dwsoDNJIRV05t5ZFrH12Ki2jm9eGv8GyLdmA1TRGcWlpFIsCbdI7j5xfZII/tUJ
	 1kC7Tag3K0Vbvf+r8ju+RuSNQHtr+cBFsOO1s7OpGS8T+WcEptLS4vVA2Q9ZYkVWVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594276;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lA2CBY7dG2G5aG9T32e+fDe4SqNLbkEqs5TwBxUX5sY=;
	b=40gCE1pyUhzore3uxF287TPfrMZAuSUNYUZZUcEAWSHPZ24uVroPyx7n0LxxdkxSHOo5
	 sFQ7FC2eC8w1tEgZZeB9ABVS4sDaMdDehVimcESdMFGrO9SuiHcP7CJ3kRjP36yWXcOlw
	 +MREg/+pbbzZqF3YunS9t5qkNwiOcwfVAsvhGWhKc8hKEnBz81HZMC6soz4HDlQSH/8Nj
	 56Xs4ezD/1hZbt3OSMXeG+3yvLqiWzgx9U9ShJjj0vtMesG2T2lP80IyU7OqTBLSH4GQw
	 KmCOiMonUKI/QcP4YWwgiz7qOGpxgxWa0ZOnSy4cAjJiVyVEoEK+UhvE3O20ygb1xVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="JYf7ms/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE236606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JYf7ms/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4581F000C4;
	Wed, 21 Oct 2026 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594275;
	bh=lA2CBY7dG2G5aG9T32e+fDe4SqNLbkEqs5TwBxUX5sY=;
	h=Subject:To:Cc:From:Date;
	b=JYf7ms/vCs/nGiv/rCWQJSNTJxuJi53j2gRg2cY9t08AHO5LBTeOcEVKkjY0HfJZm
	 CEJLc9Kn0CHXBM6taXVG+lWlbGbyJDnnrxP+pOusRp102LbQnW+n5o6WdUmvrxn1FM
	 iEyt5Bu0dX3WvH3nFS+wfj15gTvM/OchOmsTziu4=
Subject: FAILED: patch "[PATCH] scsi: st: Fix use-after-free race between st_remove() and" failed to apply to 6.12-stable tree
To: loberman@redhat.com,dingiso.kernel@gmail.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:44:29 +0200
Message-ID: <2026102129-zesty-hardhead-44d3@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 71caf7f84bd62a4bf91cc95abd2de690afb8d15f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102129-zesty-hardhead-44d3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

