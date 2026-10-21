Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598146;
	b=Q9eLvnhQFtm38MmRxVv6tFJIYPKw/CRWNUkYuSdcrNUhQeIJI2mnii8EFz5XBycFVuPy
	 i7kCXpFqWAtfMweEr3Kva0GfBbXuVBFTKIJYd66YFQ5WxBeGOp8obWAkms7WGhn11Hg7Y
	 JPc4z6++0BgauWwgMnsJe+WuRYrkBw+q6ak21wGw4kfUX8B3uWLE/7c6iwxEQvSKp5oKA
	 8boDUdSecmrWV0WOmXkYkSp0BumtnrufDRxfY8Oy/K7cx8u28y04Ofi5nZPEEfoaRzLS9
	 qK+OWtC+koYLpDiQx4xRucKalw5x8xZjITtV1NRa9FGlYPsDnP+7WlA9+keY32ZHn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598146;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=i50wEGYXCLBVOGgmt9v4+hZIwNI4ZPAHYIYyfh4PdOY=;
	b=SN2kO6oK7P2iQyWZU2JKg1zjm2SdWf0flp48vScmN9fMZXMWSCrJ9SjTEyTtx/CTd/3d
	 BNdSADX9+9p+OlTJcKOkQl9XYa8VB9ACwLlI04+6dNeVy3b7GyUf6zCk+DGaExdmU6GML
	 sJILkE55Bpj4guQV9XrReaJRpULxDzht3X/82XIMuVCqVN3GSUi3qEusRXfoU9ZHG8lFF
	 4Do/0BWlg/Kjx5eAARKbbj1YeS3Dxjo11DoGwoNcoo/5BCyuVQ/jXG6zA1WzhaZL8yDPd
	 O7YSDdQBj2VkBdI1WwyCpnJSRlYkxDnwndMVh9nyxydGaNBGhoULb2Zwl5mgRm052zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bJPclUME;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD7606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CD7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bJPclUME
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i50wEGYXCLBVOGgmt9v4+hZIwNI4ZPAHYIYyfh4PdOY=;
	b=bJPclUMETi3ZH93lvxur36ar6dmWwk+ZIiN2ZcQchHlk6HtDeteYslvb9Ggyvb+xqVSNIW
	EyW+nYZwgdrJSh1i8K/4R2CIX1NxESyB0S3oq6VtiH81rmrgN8ChMrF1omUe5DYho4OThv
	TvR/57s/8p1saBgQuuv4SC4pYeHwjeI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-UIVlsxmSOT-zXiKMWi4UlQ-1; Wed,
 21 Oct 2026 15:55:41 +0000
X-MC-Unique: UIVlsxmSOT-zXiKMWi4UlQ-1
X-Mimecast-MFC-AGG-ID: UIVlsxmSOT-zXiKMWi4UlQ_1792598140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688A819560AF;
	Wed, 21 Oct 2026 15:55:40 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6C8730002CB;
	Wed, 21 Oct 2026 15:55:39 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>
Subject: [PATCH 6.1.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Wed, 21 Oct 2026 11:55:37 -0400
Message-ID: <20261021155537.2740297-1-loberman@redhat.com>
In-Reply-To: <2026102130-reputably-unlikable-edca@gregkh>
References: <2026102130-reputably-unlikable-edca@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

commit 71caf7f84bd62a4bf91cc95abd2de690afb8d15f upstream.

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
[ loberman: st_remove() still returns int in 6.1; context adjusted ]
Signed-off-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9ba5ad106b65..603ac7de030e 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4434,11 +4434,11 @@ static int st_remove(struct device *dev)
 	remove_cdevs(tpnt);
 
 	mutex_lock(&st_ref_mutex);
-	kref_put(&tpnt->kref, scsi_tape_release);
-	mutex_unlock(&st_ref_mutex);
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, index);
 	spin_unlock(&st_index_lock);
+	kref_put(&tpnt->kref, scsi_tape_release);
+	mutex_unlock(&st_ref_mutex);
 	return 0;
 }
 
-- 
2.56.0

