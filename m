Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598156;
	b=GIU80bfIkG/lcY+tgj1lTUFdT2pJCNTyRv679F3lwRkXHUxdKfUTg/zEhDHUl487VXKd
	 +wChk10lbK1BjimDCsPzOCO+ODXMDU6QpuOw4MYpDjkEg9gbNBBtnA7FTh4WPDRfLKB80
	 EeZ5uMc5Lbr//bPG7T8LvChlW69f6S4ntCHV7ww57q+PixPOEP2iY9GNTmpPdTqhrthY7
	 qc9y4tSet6B/lbXLo1RSeGNmNMfMvg1ngBvWKZtYVTV8pY2HNLzOgJm4ajeO+e2OHibqj
	 h3T3FFi11tnhidcAzGn4+8JnQdifRtaBEIV2lZNVWpRfTw2OMwnMkMeUMfUs7RGTNPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598156;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=6u+VnV/PRcIV9Jk00Ya7mwpUQYwoPMoHOwJqjDAOkiw=;
	b=VxXu4vTMdcdynAsbdIt+RC0sENNnouP1Hlbl4UrqNYYjAL6cDjmEQkMCXDJXFSFYbeGi
	 ALl8wNfcdMylmp6eFXwB2nHlbi//MFiCValViXPCEayjSU/BVfpd7906YCkTcIWAPFJfk
	 dgeCjF/CMVEcQTMKYlUwJa7dWWA4SgLQvt1ZMbF0jz6E4NvJsi0JxobNLmmHEgMxm+n2b
	 JfxTowPPcsF+t0ylqosRWgUuPN4cMLw68H7ZFKXZPQZ6t1Dofwr9cSm+vhqIGZbq7ANAQ
	 lL08v/aj0SoEQ1iShlEfIorCYyYBPUZgJQefAp7rC5O0rjR50Sq+1WWFPDNDKixSY7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhKd1bP2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9252606A328
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9252606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhKd1bP2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6u+VnV/PRcIV9Jk00Ya7mwpUQYwoPMoHOwJqjDAOkiw=;
	b=NhKd1bP2++cSu3NIaAvMVafJphb+wbIFcIIbfnRdHAGmUMBZ4BKR3hQotZbv8AvhgyD2XH
	ZGRHEAmEczCFZCMeA4biNVGDT23rA2w5ihq4zEb2wf9QLaz48NcuHstFDDmwTIQLcjVfBL
	qsAbj9j99EEvQTxIVDam+OzunyIkwwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-axPgfgQpPhiYYpi114s_tw-1; Wed,
 21 Oct 2026 15:55:52 +0000
X-MC-Unique: axPgfgQpPhiYYpi114s_tw-1
X-Mimecast-MFC-AGG-ID: axPgfgQpPhiYYpi114s_tw_1792598151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C9F1956078;
	Wed, 21 Oct 2026 15:55:51 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 197F81800677;
	Wed, 21 Oct 2026 15:55:50 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>
Subject: [PATCH 6.12.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Wed, 21 Oct 2026 11:55:47 -0400
Message-ID: <20261021155547.2740356-1-loberman@redhat.com>
In-Reply-To: <2026102129-zesty-hardhead-44d3@gregkh>
References: <2026102129-zesty-hardhead-44d3@gregkh>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
[ loberman: st_remove() still returns int in 6.12; context adjusted ]
Signed-off-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 3e982c166baf..bad04cf3c287 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4442,11 +4442,11 @@ static int st_remove(struct device *dev)
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

