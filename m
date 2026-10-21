Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598141;
	b=0jwgZ4TmM9bAywTwDLTXMk/FRhPIB4L5qHovfLquQUqQDrMf6RUG3XcaGxoPl6Cg03UQ
	 wv+ldZ/Anjdiyi5JyRfmQlubQ9uPbrW5PoqMuLIC0NsM2IsxGjIXyO3+twitvk31xvwid
	 wY+Qsf+bQJrPdQ2j+237Cv5m8uFOpeGdPs0yTYXqcYnU7+stowo4GvobfCLh5ClvWi3uA
	 exLkh4utIKx4rQLFtUUNLi5D8LIQkdsSC0outPHDGr5UzfEd3vum0hYfR/rMUIcx8c+NV
	 uTtTnSUmiWZ/C7o0MGacG3Z2Hz2bJxF37ZEGViz6w0AjwJZl4R9wf+UkG5Qx57LhzCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598141;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=uYAmuL0fc7WcnN1KcI2+Qqndo13RcbstOobYG07WOcQ=;
	b=baSrDzIsN1CynAjt4Q1vDQjboDItxSZUv5wFY5lcvJGPSBCLyEpz7RXWOrAL+35ZLTa8
	 5Ck6fgTAGpU+rlFjBTwQQqsnu9t5Rinw1oUtKANQmrjdNeCTTw+pNc82GHU0VKolR5jFo
	 FvLk4kD+oyPp3Q9C7Lw9m+NdbJtZemnmxlkXgTCoAUfHw42exo8J/jsGxiVdeyaa/cPTj
	 /TWOE5OXaVlKk+aWXdhS8/y0N3Nujj/SQNTrKWwSCHJwg9eog47Z1xIBlInBA6FsnqlOZ
	 voM4AURZALQKnzIC17n1sGjDLXKeQU4vRQVdMI3OGa4UA5OQFyUw4/P6/X4846Lo/KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgGT4aE5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98B606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F98B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgGT4aE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYAmuL0fc7WcnN1KcI2+Qqndo13RcbstOobYG07WOcQ=;
	b=BgGT4aE5gNh5vkVf8OhzAeI+CX7VguiThM2Ltsxdtk/KjuBHHu+KLa6a6VytNHV5VuyGF/
	tVUDYVRlwwuX+wk/QuL+oWGt2yxCqXnlB/VXajSLGQD6VD4D1QMK09A40/rU0Tyxh+4jmC
	ekEfHy1tS9Ban4aklHEEjaSQdY1JH3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-eiXSlsF7POuCmFyjVFNDeQ-1; Wed,
 21 Oct 2026 15:55:32 +0000
X-MC-Unique: eiXSlsF7POuCmFyjVFNDeQ-1
X-Mimecast-MFC-AGG-ID: eiXSlsF7POuCmFyjVFNDeQ_1792598132
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E661918007E9;
	Wed, 21 Oct 2026 15:55:31 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52A7F30002CB;
	Wed, 21 Oct 2026 15:55:31 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>
Subject: [PATCH 5.15.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Wed, 21 Oct 2026 11:55:26 -0400
Message-ID: <20261021155526.2740230-1-loberman@redhat.com>
In-Reply-To: <2026102131-preview-unlovely-f4ad@gregkh>
References: <2026102131-preview-unlovely-f4ad@gregkh>
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
[ loberman: st_remove() still returns int in 5.15; context adjusted ]
Signed-off-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index dc0c6508d254..444eb99e4f5f 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4433,11 +4433,11 @@ static int st_remove(struct device *dev)
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

