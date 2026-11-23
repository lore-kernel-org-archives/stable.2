Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427733;
	b=NZSbVi9oQV3K86/WPOacVXoAi+zaY6kTCq886cJKWcsE3WWW+6V1qIoWMdmrF7ez4hdI
	 lNg+ebYvsp3gr2k4QqVe7Gf75D9VmZpUFlL3NSHHgBmMjW1hEL+0W4E/2SND/eAWMWNOw
	 2svuPhTdAWIZl4TI7e32WgInYHuSMBo99av5EIqtE230RQx6kjgjz05RV3YsmMZtBSzPk
	 keJ/6ZyXqj/RlIBUZUls0AKnwJrGTs5ugqYu20c0v0xjU+w7vE/Qh69qVYnE5RWokA7VN
	 AnVhVLLhV3/xoakI+AZKdFxY0JMvNzOEPeDAT4t3z5/suN0IJ3Zt8Pw9YKTw8a2K5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427733;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ExBrdivvPGnMfALa1gyv4ambGV9X8LsRbMUTFusz2lM=;
	b=rIjl+sbI2lbEQKpWFpSrzPS5yomQJlqVB787jx+4g4qxxG2jIKTi7fCPk6PAjatUUXho
	 vyT0mRBh2zF59Hm6vltDzTJ4JBpAendwwLJ2KkhcKNjxVMfeM3vGvk40y1X5erdmUZzrL
	 9zumVeg48m98VLk1rKh+mvYVMCal8CqM8y93+aqcQkTiNzlL1OfAdMHQGEJlngLcyEVFl
	 zTEinGB7SnV1UHZqTs6bIox8WiQqYampSntbxc/TiTv603yHrYAuTtLCJkv4P+ZzY/3Oa
	 RVAXkrR4EqP0L8+IgKNgG6SU4AS4sXuqSO21OpDJWpI1zbKcv3fFXWHjpcvgAPmsDfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F5606A31A;
	Mon, 23 Nov 2026 09:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ff3964bee72311f19a56ed5b684f684d-20261123
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d9d3e7ed-4998-436a-99a2-9ca028c2f262,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:d9d3e7ed-4998-436a-99a2-9ca028c2f262,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:a8d4509ebbf7a42d767ec0deb1659f01,BulkI
	D:261123175525VOW09MFG,BulkQuantity:0,SF:17|19|38|66|78|102|127|153|865|89
	8,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff3964bee72311f19a56ed5b684f684d-20261123
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 137605619; Mon, 23 Nov 2026 17:55:21 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	virtio-fs@lists.linux.dev,
	Li Wang <liwang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] virtiofs: fix potential unmount or device removal hang due to stuck FORGETs
Date: Mon, 23 Nov 2026 17:54:55 +0800
Message-Id: <20261123095455.88622-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

virtqueue_add_outbuf() returns -ENOSPC when the virtqueue is full.  On
this path it can also return -ENOMEM, when a split-ring DMA mapping
fails, or -EIO, when the virtqueue is broken or a packed-ring mapping
fails.  send_forget_request() turns only -ENOSPC into 1, so
virtio_fs_hiprio_dispatch_work() stops and waits for a completion.  Any
other error frees that FORGET and drops its in_flight count, then
returns the negative errno.  The worker treats every non-zero return as
a reason to stop, so the rest of queued_reqs is left unexamined.

hiprio dispatch_work is scheduled only from
virtio_fs_hiprio_done_work(), which runs from that virtqueue interrupt.
Once no descriptor is outstanding, the device raises no interrupt and
nothing walks the list.  virtio_fs_send_forget() submits a new FORGET
directly and does not schedule the worker.  The queued entries are
reached again only if that new FORGET is placed on the virtqueue and
the device completes it.  A new FORGET that itself gets -ENOSPC,
-ENOMEM or -EIO does not schedule dispatch_work.

-EIO stays -EIO for every later add.  New FORGETs never enter the ring,
so they never produce the completion that would run the worker.
Entries already queued still hold in_flight.  virtio_fs_drain_queue()
waits for in_flight to reach zero before it flushes dispatch_work, and
unmount or device removal hangs.  -ENOMEM can succeed on a later
attempt, but with an empty ring the same entries wait until some later
FORGET both enters the ring and completes.  Each such completion
retries only the head of the list and stops again when that head fails.

After the FORGET is dropped, return 0 so this same worker invocation
continues with the rest of queued_reqs.  A full queue still returns 1.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/virtio_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d247a02cdca9..d2d1e8fe3a91 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -655,6 +655,8 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			kfree(forget);
 			if (in_flight)
 				dec_in_flight_req(fsvq);
+			/* Dropped.  Let the worker keep going. */
+			ret = 0;
 		}
 		goto out;
 	}
-- 
2.34.1

