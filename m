Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594282;
	b=HdEu7Yhy10mx4ghE+65hnCpRoOMLqdqjFO3kUcUq5Pd8ByDsPquW/aMLWJryyXTyri4g
	 AwucC0Zq//VHOiKLMM64HGkwaPjglTKCopSjylLVIkJJptLswiF3EFQIoDWCiBw7AQbf6
	 27ylL19FnkMaxiO0+3b7ajBeBru7jYObj7tUbRRO8GrnrGuqPf8PC9DpG/w49XsBa2ZQH
	 q/IZCdXiTG33eUNrS/wPfp15hDnOtTbnnYgKm5PU6C/sLVbC9wdyXFiiENXQcTgdsxWvl
	 8q9qSDJJSZpY39sK2cGdAmQG90C2YQor9l6cjCZibei54f+3aWxmp0aA5pf+s1ETKPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594282;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ux/zDWC+cHe/DvHqeT/y40dEHx4zhJkugLyJP4TNREA=;
	b=U6/G+VPONhJ9ivYLCG+BbuKB2lJngoZOt3Bdn+w770RAxim7xXeQc9D590uc9UwhWTG3
	 XmfqyYEOLX7juQW7WNwO/ZadnLaYGlINSkbFvpJPYny0qz7eyOb46MeJyjxypzigj4VbP
	 xxpUCEcgyO+9fKbHqi3Wnkwejl9EYrtYYWWCUhdhVboDY72RGubJZwmARFBL4WQ84BJP+
	 Ume+0uNzmfMYcNQk2kDpGLy/WglhJ+yZDnhjIXb9iClLll0a/426aZkXCfzDN1FBYE2eS
	 2MsjHXmnFWkTWboyj3HGmWvdr/VuW8sTgEkh65odVWU2MedI1CGHzBK/S2O9mjEV/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g1IvhDXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2FA606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g1IvhDXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDBA1F000C1;
	Wed, 21 Oct 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594281;
	bh=Ux/zDWC+cHe/DvHqeT/y40dEHx4zhJkugLyJP4TNREA=;
	h=Subject:To:Cc:From:Date;
	b=g1IvhDXoBzMYVB4yHeQbtJ27OdWsVJ0esmwAs2ZBgvrQV8YHe9JJq4Gk3OtnsC/5o
	 +hiFRoFK3hAhMBkG7SGwTdJU0kmhfHyrUAedBDEL28E0wXkXHri4VuFBR2fwAXRQUF
	 p1NLXDh2jNDE7Cl764gLtltzcU1xClEw2BzMMzyY=
Subject: FAILED: patch "[PATCH] scsi: st: Fix use-after-free race between st_remove() and" failed to apply to 6.6-stable tree
To: loberman@redhat.com,dingiso.kernel@gmail.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:44:30 +0200
Message-ID: <2026102129-antidote-wad-c176@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 71caf7f84bd62a4bf91cc95abd2de690afb8d15f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102129-antidote-wad-c176@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

