Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2113EFD3D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649814; cv=none; b=bSS2pIstGZ15uu+o5LmZ/SP9T4w5gSletIoAdk4BlYxP44FU07pkqpuE/RV8o/ECqO6Gc6yabbYgt76rheCpnIidTqvY8zbXcpEhWlr4U/0O5Xllp+wHmWd6NAIKB0gnYVUR4EP2S0z2RmHaqc2mjZl9Q8Gs5+3x/nOLIgUJOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649814; c=relaxed/simple;
	bh=2vCa4OWaCxs+EPAwn3Fk12/TtCk2qFnRbN4NZBCJLqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZWAiB6dX5en/sLr5gqMVuHnuz90iuo1ynlEJOEtFQ4cosjE8DjF6GmebISDckiqQFA5IE2B5xvER5qZS48KLOjeuKlwQjrSOmblcDQUn38njzZFhrFTlIHy1lBdZweIWw6DAmM8fkHZ6rkNH5AtMT5AKXcViT67SM1J4q2oY4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSY/4XV+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAdtJP12; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSY/4XV+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAdtJP12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787649810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
	b=fSY/4XV+zzNCVtTusEnCy4niWSPhop2fEr777h6560cwe7I/3x0XpjT43xqXIW01zCxTwJ
	VYRGzL2/fU5snMgTmZIJfStTyvnxiEYtL1DGm5MuUWhHpQ3ujNSf+8WgQAJ/XzhnTtE7OZ
	0k1FQXySDw9q3op1kfWBx2QKUYs3x8U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ZfHenhiwPgi576zX0g4SFw-1; Tue, 25 Aug 2026 05:23:29 -0400
X-MC-Unique: ZfHenhiwPgi576zX0g4SFw-1
X-Mimecast-MFC-AGG-ID: ZfHenhiwPgi576zX0g4SFw_1787649808
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2192b12cd6so421434766b.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787649808; x=1788254608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
        b=JAdtJP12vrPDXseQOFHUlS8b2Fixty79cyYdWCRMjYTo8qT6LyRNUdGt8Cf3yvnkMt
         BbPswJHcQqkz2rj5R7tIFJdxjQun3whNRd0XkG/ofgXb7hBjGCqHMauHX7LIpAhptMAA
         4FaEk1jubo1Dxu++kfYNIGfw9MfylkgEVennnOaRVKuJTmHOnGJw2wzUWdhJSeGMfiwH
         jFZL9SwKjz5DKCSiCOfZdB/o+4LO3nQ6jTCGR1uMK6foXU7WJl53TWGAAhfQ2UB8fyXl
         V4qVsvLP9jGI4p1tkPeLcTkbbKIluAeirPtb4xQqwBwasKaVFIecQDberxbWZHMWqYl9
         6MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649808; x=1788254608;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
        b=MCbuEQ3crKuAP6hSsf5nRf74Qq8Mg3zMOwgj8PSe74UzI4z0b9y0e2cDxmBaisTGfB
         TcK7RRinvhSmJEhSXWPX8GouiAwUN0zPIGPhc2GQTtBoiJgK7cBjymL+GtDg/OgLddlO
         cmqLsfqkm0ziLQoFtLHLGCuJ13GfSYIlLctbIYUp1+0U6Ga93cnAMHgLkqBxXQZc7Fea
         6vlL9RJ0er7mtXiXg1qI/dClRsJ6L+chUS9fTZ/DY+pHuFP/K09k+iNf3bzuM8+k6DoO
         qGUBS8VOzSYreGzLSpcTA1WC7P0akN9dHCuOL8Mf21BW+S8FITC7cHX+/ARnPDNKlq/Q
         Hs8g==
X-Forwarded-Encrypted: i=1; AHgh+RqgPw+uRRxXcWmhJx27dxRxYgvb8vTszkkcpKp8CnDFeDJTp+7B47BBykmJX6GakPqOayvua9s=@vger.kernel.org
X-Gm-Message-State: AFuF++kdNWvEjEsJSpV9rrV/HEKpeab/g+7PwIJlOjopU0SqwxbGNBOH
	7Lw4+PGqTJuZvAzsU4NiYkFY248nFOUwkMzZzOl0EiUxcOH9VXyu+HDe+Clunfp9LzV5LBesD9s
	71m1OBFX4H40tebMyagqP3vOB0Y7z5U7IE7Kfmq91pE05BdSJ3G3eG7FXog==
X-Gm-Gg: AR+sD138QRLrl6kiBj0TlCGP5hysRRYFYEBFJcqsIQcDZ9aUNJexKY5+/+7wnSDH1Ev
	vheJD1wMcXXsQxHFt0yvlhmyCLnWR4dWip9C4klsvgdjNEf6X3xfqKEJBzgOqSjSeCUx81kCtGr
	xUpb8Gqv+1mK8tgT4Fg0zg2bJ928+KE1H4fFt2MmVvku699qh3Dof5QpOf8jKKjMSj1JbX5PeIu
	QlpvJOJy2LltjyaSZv3m39ZMxnwgOvNy/yfIBWSZPZEvUYmaNRSc0mAVdgWuX/Au3E87Djg9JOU
	uYOf8M4mgfPiidlBBmuVGAvRUkLoUQVtS/WE/M+LgQOowEnM9gbdb26kaVci6wY8cgwlHI9cIMG
	ZjISiE6uT6wOyQRPM6KTWULOXhep7eBWOig==
X-Received: by 2002:a17:907:3d4e:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c246a4ad6abmr3801348066b.3.1787649807880;
        Tue, 25 Aug 2026 02:23:27 -0700 (PDT)
X-Received: by 2002:a17:907:3d4e:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c246a4ad6abmr3801340566b.3.1787649807413;
        Tue, 25 Aug 2026 02:23:27 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e8bsm1619137166b.44.2026.08.25.02.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:23:26 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph: reject export_targets ranks >= CEPH_MAX_MDS in mdsmap decode
Date: Tue, 25 Aug 2026 09:23:25 +0000
Message-Id: <20260825092325.2605644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch was sent to me privately. Thanks Jeremy. Posting it to the list.

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

MDSMap export_targets entries are monitor controlled. check_new_map() uses
each entry as a bit number in a fixed stack bitmap, so a rank outside the
protocol namespace can make set_bit() write past the end of the array.

Reject ranks outside CEPH_MAX_MDS while decoding the map. Do not validate
against possible_max_rank here because maps may legitimately reference ranks
beyond a temporarily reduced max_mds.

Fixes: d517b3983dd3 ("ceph: reconnect to the export targets on new mdsmaps")
Cc: stable@vger.kernel.org
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mdsmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 4f0626753429..53079ef34c3a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -269,6 +269,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 				goto nomem;
 			for (j = 0; j < num_export_targets; j++) {
 				target = ceph_decode_32(&pexport_targets);
+				if (target >= CEPH_MAX_MDS) {
+					err = -EIO;
+					goto corrupt;
+				}
 				info->export_targets[j] = target;
 			}
 		} else {
-- 
2.34.1

