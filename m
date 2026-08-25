Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892D3DA7F3
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650190; cv=none; b=pqF02ci6uJa7nP0c71SnbGsvNCWyyqEP+4gL5j4x3wdjsMfY+f8IyxW+9u2y6oHVTFuT0OCkidpZb+3QMJe2BI/ZjY4o4dlcHLqNj9Zq9jv+8J/B1yCv4g5GvX6ZA5uU5dwq0qAVFbaR1tzwJ/a5Nv3IV/2r2NyABc5fw2MAX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650190; c=relaxed/simple;
	bh=hb9INDHGhUPT/WoB0U9k2zL8xFQlPxW/TAPBgVzi9a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NskvobiRXCyWTZZlUFbcPDy1LxamcMfY5SxE/PbrH5+FRLlITbx8JeGn88t4l1oq5XSZMl6tooicga1rDxvf+uUQJffuO7SnyDOAP8iIyKhVXwi30JZnZ4uYoiifqyb7LN9VLeYhCBOK0mjG6qpcLd8ou64LTrjtBQuOnZrRBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsnWsHE+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A551CWFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsnWsHE+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A551CWFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787650186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
	b=JsnWsHE+c2NnuQyAKBfC1zRX4mrTn07FusJ/3obOfpAYxksnsdHDPYjpiUGBFzi2fzwQJq
	vj8IOdKyoRawrefIpjfesOkwMBV9nVOwZjoYJia9kjTZUMNU8r0fZk2PCxnw/Us+jMjovw
	iHFZ8kcYedZjyGWYeIazvroGdHd39CI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-Wy4xDebePNG3uQAi81fmxQ-1; Tue, 25 Aug 2026 05:29:45 -0400
X-MC-Unique: Wy4xDebePNG3uQAi81fmxQ-1
X-Mimecast-MFC-AGG-ID: Wy4xDebePNG3uQAi81fmxQ_1787650184
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso4988368a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787650184; x=1788254984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
        b=A551CWFeLOnB+y2gRoeXffMYyKxULvicfEb/fsZC0uw85mdDTX1drOcKFblX/wUCS+
         QINFQWztJU8HXr77ee7tIl1uXkSyVL7HUwM/IoyyAp+bNTzSEXBN7dfHN4RseRxWg4SW
         RN3x2jfcK0CQjd407yshsNCcbXyBT87Jpekic1SiPUs0/Cq93ToNduLWpEiVYL0tG9Ck
         0d51wBlx4NZgCYhKPUSAH1Y1bBkxAuOQ9u2R6JIRIMucGQdRK0AQ/z7zhGsaIiYVrz3f
         qagr5gWyHM13l0osMhmOSGy+J+wDwPRXOyQmIOgL0kU4q8nIkY4pb5Pk6RQbi9Oljk5a
         /Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650184; x=1788254984;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
        b=o0u8rPsW3U6xPrr3FEhkUXJ2vONntbHGlafZW5cksI/8Qp+Nfea2fzLJn4BP0NZFbD
         2z0c0Jd+MTyFfNnK0P6PrvV7AQG+gvQJun3lpDmYVQINf03xjb1SF8JaeKFQWA16uTVQ
         Ffs5FN+OLNBDmxDyIuhJYZ6++f1F/ITkho7Uft+ujO39aL7YxMiNwgtlxtjP5b+/DDDC
         ymueNGHyEnwueQzzJIAtMXGV5OCjF0oqFT6kwxX7UJ36ApLkuJkznxxXlzlt+RPvbR5c
         R1KTcCGHAjrGmqEx6JIgsocRNszNl+TktuAlsNnNKG68QVwqyBA7xDpHopvlipaKTNuB
         63sg==
X-Forwarded-Encrypted: i=1; AHgh+RoXH1mBmlvr+pxdqUL50mBz5j0pmJG4+syhT/tnl+yqNC41xgYW8eoBB1RT3HkCe9Bg80Ka9o4=@vger.kernel.org
X-Gm-Message-State: AFuF++kE9YFtcOJ9yE1Z1oyqklN613wxhQS2zAvL2BLo3igLrz5ZB8WL
	Otjk5hWlWKvBvJ+X2wnaNwKjPzTzBolPuUX5O5P+VHYU6ybRnnTecdMl7+HCbDPzVocAxkUIrsn
	8SMuKghMB3YQratwsQlbYD6ZkybXq9Bucwil6UfzZhUm6urj8ZFzc9IOWZg==
X-Gm-Gg: AR+sD11vqIZzJbv29Cis3hqHe0VVVYFkdhMpOldhxEjS8SbsJdtaTLZpkfNnct43Ynd
	fviBz28D2E7St7O3WcNOaP9KCEo7XuI/TulTDImqVqdryti1RrZzpe4LeWIle9R8/udQSIDrNAw
	RLhcoLBityf/tdRulTdPnKlWOpq+4HCyVlY2o/yU4gYRqWtitLmqoNxVLx2pRfe5N0QweHrYTlv
	AcryGtS/sWEo5y4kRshPOf6A8GesgpjkRu9KSEV5UwDdCLvdGfZgkof4vt+sodfFOPR04P1FU6K
	43f0FmghLI4ERgjr39xNnaETPxvux/NBGjUCiLdZS+kUfPtMSbW+44BVIyTRhBjus77FOQ==
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr10987941a91.11.1787650183776;
        Tue, 25 Aug 2026 02:29:43 -0700 (PDT)
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr10987851a91.11.1787650183236;
        Tue, 25 Aug 2026 02:29:43 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm36270057eec.17.2026.08.25.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:29:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Tal Zussman <tz2294@columbia.edu>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix page vector leak on encrypted netfs read EIO path
Date: Tue, 25 Aug 2026 09:29:34 +0000
Message-Id: <20260825092934.2605898-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ceph_netfs_issue_read() pins pages with iov_iter_get_pages_alloc2() for
encrypted inodes and attaches them with own_pages=false. If
ceph_inc_osd_stopping_blocker() then fails, the request is dropped
without calling finish_netfs_read(), so the page array and the
references taken on those pages leak: ceph_osd_data_release() only
frees pages when own_pages is true, and __free_pages() would be the
wrong destructor for GUP-pinned pages.

Release the vector with put_page() and kvfree() on that error path,
matching finish_netfs_read(). Unencrypted ITER reads are unaffected.

Fixes: 1464de9f813e ("ceph: wait for OSD requests' callbacks to finish when unmounting")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c05bdf5d7273..8b009e354d30 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -442,6 +442,17 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
+		struct ceph_osd_data *osd_data =
+			osd_req_op_extent_osd_data(req, 0);
+
+		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+			int num_pages = calc_pages_for(osd_data->alignment,
+						       osd_data->length);
+
+			for (int i = 0; i < num_pages; i++)
+				put_page(osd_data->pages[i]);
+			kvfree(osd_data->pages);
+		}
 		err = -EIO;
 		goto out;
 	}
-- 
2.34.1

