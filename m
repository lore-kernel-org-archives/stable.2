Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4A3C37B6
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074181; cv=none; b=K+IPQ+Xxl+ifbZskdjokmPP7n5hZzPHT1GnK38kyKATPqPtWxhNehz5PX1n5QcmGA3jRg//YrCQKVy9jXyD5UcNWx2nLkl2D5NiJc1dYZ9g9QJ9uG/aq23JgauygTlCxVkacpfSaK8ZETuTnwn09UJViEtPB1e25olq6eE6tZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074181; c=relaxed/simple;
	bh=qNLJ1DzGl8129HBO0EhHn4JkWSr5Kr9g5Ar9omOOWrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHumeI+g91VKJPYVQFaC1nOMAsis63+4z+WgZKDUXX/S23r9Xr2q6v4BIZMYQLq6U7Gcyg/rDFCCQYIT9Kp8tG68woLWnM2QPWyUeVuUG2fCpdiURYF6ZDIu+HrbiwKPYT2LGOVWIYY+p+4o5JBq2GrwbV5c7Qnru/AO2nzyeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyBNYwuW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l5kMvg2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyBNYwuW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l5kMvg2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783074179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SqSTAKAygGy6fDoH7HM38FHPVW7tCSNwGAcZ298VToc=;
	b=fyBNYwuWgH6gFOBT8eE5Dn6N00sy5OqfwRXkWnRoyCvROw7SuN5KJRnmv8vIsuoLOVCdHx
	UsSGCAOYGtcWcgm6M6wUbUEvhxKu8eDp6ZOZCqA3Oby+7oI3AdqWEv2CN8f2J5sAmBPAGH
	nG+cd2OReZ9ongfoMOsLBIS1v47pW6Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-SLTboiGaMbmciPN8T6lqsw-1; Fri, 03 Jul 2026 06:22:57 -0400
X-MC-Unique: SLTboiGaMbmciPN8T6lqsw-1
X-Mimecast-MFC-AGG-ID: SLTboiGaMbmciPN8T6lqsw_1783074177
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475eba52438so375433f8f.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783074176; x=1783678976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqSTAKAygGy6fDoH7HM38FHPVW7tCSNwGAcZ298VToc=;
        b=l5kMvg2RLcyO+htGoIoWq+Ojc20gMfRBhr97wZRTlr23A1L4GaOPmAgmt/ee2Ze3E1
         rYN0CmBwF0dBU43p628i+9L6Wg2PF1xyqk3mBj8bDoQwN8RAPsTMiGMauH9r/9S1Xfqu
         3Lf4a7/Xw3yUrmtYfG8iqEU4Vj2k2qn1kl694YhcziHk7vtTtysPM6YdJkJUDRL+HQig
         tGhvL7Uz0R7SVNoUPGQAlJt8WlJmAc3NQVR8/lTsBPZshbXEab3RjqXjfFqAA24CXlOU
         b5nFtyi5TpEKbhkMwDfZbDSzw814PLT6CvdwowjeOemaFvyJg2++81uGvEfIMZiPfb/s
         nOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074176; x=1783678976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqSTAKAygGy6fDoH7HM38FHPVW7tCSNwGAcZ298VToc=;
        b=hnLwOQNE63C8XmLjqLo4VS8Q+N+xK0KIFk5ttSBiwGgmYzklfGJiZmN68Q6PcF+9Tw
         gGt/T8YlnnFcxpktD9h29NFcLEvR8U+hty8SonUGCtI8H0rsTU0rbbuT+rq1CCWLyw2+
         bShZbV8B1pwXjVpEnPJFR7+sL5zWDCRZKwK6vt+ctxOxTr9fsAgArjSluMlhWl5Z9lOv
         pIAlaQ7a6ajqmjvvFaNePoxQoH5x7GX/eRnW/08YgjV6ceqqhFtv4Z3SyG7I14LqehOC
         jLoRRu0QOUR9A4ykesGmzAKflKK68x+QMRB0js0cnBQxccW5WCVYCRnlskuGJgVo3fjU
         xdxw==
X-Forwarded-Encrypted: i=1; AHgh+RozmjpN9DI7nbYIEmml07AghovflivJAQts3lg2wyDTLS/WNCgEkoUtEKWBwVYkYhhSddT5bg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSe8OnbxBXXky+zCM/8DyX+DIRivLj3DsVXndBLbJjWAJihct
	EE3NSEOAra2h9lYkQVzWXum5Aib5nnKx1T+s2I0sNGKZQG4tyaJ7DmU1x4+THEgFFXmQaDbM4De
	F/8BfaqTJBUN5w0JlT9ZVxxyeS/cuWF8VydrOKTqZJ8zz3YMBW4t4BS/Iog==
X-Gm-Gg: AfdE7cmjDgE9LerP9ALtlvyD2HVssz782cFl0wKjH2VSi8uc7K+AJ1TxG7a/qVhGykF
	X57Ws17esrZV2Ss8lCeO6QWzbzgvRJHueRM61v2P2nOjD1l5Q1qCGJdYtwlwqbC/sMe7cYh1peB
	3Ky+9L/XJR0sZ1apRu73wcoRLckbHk6N7DqkycoDxfNervhBGL+/nEQldZYPpBZSO28QDn75xNf
	xbeUQ548TA5Z+UDw8hYKFUib4V2/GPVTPTLEj4Fw/ZotXpVWBRfpDP5mKqEq+cGTuyadVCxcrnJ
	r6SPAwHD3w2zfRfhLCaXW/y7/KZXYplBfeh8XgA1jEndJusaQpBZDD4PCdyRexG7byxgYuc3Ayq
	M7Oqe8qnrn3q2BOuZrMfKxiKV9/yJcGHbFmV8rFWcBaUNvKXBk2mIW8LlyFq3wqI=
X-Received: by 2002:a05:6000:604:b0:46f:558:a43f with SMTP id ffacd0b85a97d-477b34b039fmr12378722f8f.4.1783074176486;
        Fri, 03 Jul 2026 03:22:56 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:46f:558:a43f with SMTP id ffacd0b85a97d-477b34b039fmr12378677f8f.4.1783074175996;
        Fri, 03 Jul 2026 03:22:55 -0700 (PDT)
Received: from stex1.redhat.corp (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dc77bsm17460704f8f.33.2026.07.03.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:22:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: v9fs@lists.linux.dev
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] 9p: fix privport option setting wrong RDMA field
Date: Fri,  3 Jul 2026 12:22:54 +0200
Message-ID: <20260703102254.114446-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

While reviewing a patch adding vsock transport to 9p, I noticed that
since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
Opt_privport case incorrectly sets rdma_opts->port instead of
rdma_opts->privport, so mounting with the privport option overwrites
the RDMA port number instead of enabling privileged port usage.

Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
Cc: stable@vger.kernel.org
Cc: sandeen@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 274c5157135d..f426cee37414 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -406,7 +406,7 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_privport:
 		fd_opts->privport = true;
-		rdma_opts->port = true;
+		rdma_opts->privport = true;
 		break;
 	}
 
-- 
2.55.0

