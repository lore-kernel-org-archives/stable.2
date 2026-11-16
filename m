Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866935;
	b=OVGoOZtaujfwPU5JieunGSD55gsboGx73aEBbPlzC10xzSHKsrf/zXN34z5DXYOzj2+f
	 vE3PCZueN4eqJyS3T+dlxdIWFmqTlesQJP3q4O0PRxv08AW8M/BM70np+pH/S0VEpQul8
	 17TNfsgDTN5C/lhFC7S7b79i4UOGpoBM1D6CPxQ/wKsVT2/hL1pSINsRt9IXo1T5CUOxd
	 JngAXJOetodp8EKYN0R5pxdBv4v1X05ZiDzRWnzU4HKYzhC9SZE0LICQC93kquLgVAlQs
	 sTbTeGAqubCdeMV+YzrvhFD36WyKxo/wL7P/BLNvQ3iY8PEdC5ynWEpcVtU4maWn/zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866935;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FkxAzsjJNf+C3xwo+IqzVffQESsTNH6DaVyjsMO+ATA=;
	b=NMR05/Hl4ELbZoEmbJZz4Yoz83fPfKbtTKx1SPZWsx0RCZqGiFpaLJOx0rviNybT9wOI
	 2SqiYtrGPNVmaBF24KcscCVeBpAqArNQ0Sd5Bt2IhAT7SQZw+eMG8dAySXcKxs9TfuDt3
	 rsbrYDtyilUrTLlKORYx4A9KU3UYv7qSyEticPjdUoOZDxaOIKwD4jc1+5dcAcEHM4shY
	 ndZjYtsuNwiey+BhQdQPCLYGZYlQXhCs0VYezJ72Lt8enIcf8g6q33TWgl5vcxGPhM2SN
	 lnXQhAKvkEM8qTPD8o5uYITzjRHtZJjm8Ycf0fRy3AqdlEDXMQN/dq/7mtvxTBZ6ywQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TaP5B3QL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9960A2630
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C9960A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TaP5B3QL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794866934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkxAzsjJNf+C3xwo+IqzVffQESsTNH6DaVyjsMO+ATA=;
	b=TaP5B3QLKAIVMvZW+A2+riUHTugaJ0ecJ7ehBytY2VXvLg9uhyjPhkhkGBb5zvty4hR74H
	Q+L66pPas4U3DV1FvaaD+hmWs1/fFQbDLoWRMA79fWNPtJTNVsIo4X1S1MiB+fEI2j4ID4
	jkUdqND0u/jIHC2IJBAmsHPg/d86QfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-T1Jv61UwNK2_6-JrnCTAuw-1; Mon,
 16 Nov 2026 17:08:48 -0500
X-MC-Unique: T1Jv61UwNK2_6-JrnCTAuw-1
X-Mimecast-MFC-AGG-ID: T1Jv61UwNK2_6-JrnCTAuw_1794866927
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A1B0195D01E;
	Mon, 16 Nov 2026 22:08:47 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 215C31956047;
	Mon, 16 Nov 2026 22:08:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: William Chuang <founder@logarcheon.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
Date: Mon, 16 Nov 2026 23:08:43 +0100
Message-ID: <20261116220843.378480-1-agruenba@redhat.com>
In-Reply-To: <20261116180002.44336-1-founder@logarcheon.com>
References: <20261116180002.44336-1-founder@logarcheon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 16, 2026 at 7:01 PM William Chuang <founder@logarcheon.com> wrote:
> When the filesystem has been withdrawn, gfs2_glock_nq() returns -EIO
> without queuing the holder, and gfs2_glock_nq_init() then calls
> gfs2_holder_uninit(), which sets gh.gh_gl to NULL.
>
> gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_dq_uninit()
> unconditionally, so in that case gfs2_glock_dq() dereferences a NULL
> glock when it takes gl->gl_lockref.lock, causing a general protection
> fault.
>
> Only release the holder when it was successfully acquired, matching the
> pattern already used elsewhere in this file (such as gfs2_fiemap() and
> gfs2_getattr()).
>
> Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
> Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
> Cc: stable@vger.kernel.org
> Signed-off-by: William Chuang <founder@logarcheon.com>

Thanks.

Could you please replace this with the following fix and resend?

Andreas

--

gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_nq_init(), and
independent of the outcome, they call gfs2_glock_dq_uninit().  When the
gfs2_glock_nq() call in gfs2_glock_nq_init() fails, gfs2_glock_nq_init()
returns with an error code and gh.gh_gl is set NULL.  This causes a NULL
pointer dereference in gfs2_glock_dq().

Fix that by only calling gfs2_glock_dq_uninit() when
gfs2_glock_nq_init() succeeds.

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
Cc: stable@vger.kernel.org
Signed-off-by: William Chuang <founder@logarcheon.com>

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 2c2dc459c037..d4678e4832b3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2253,9 +2253,11 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
-		ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
+	if (ret)
+		goto out;
+	ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
+out:
 	inode_unlock_shared(inode);
 
 	if (ret < 0)
@@ -2272,9 +2274,11 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
-		ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
+	if (ret)
+		goto out;
+	ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
+out:
 	inode_unlock_shared(inode);
 
 	if (ret < 0)

