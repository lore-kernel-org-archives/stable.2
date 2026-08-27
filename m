Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AAC43FD05
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843790; cv=none; b=Ixe7tVVGmPazyoHhXhaQxRm5l92Z1nV5B8DiqGlfPuTyHKdq1WvpDd9iCPUGX3ytOMd2afUHrTXl20US0bL+5lS5e3vMN9jQbKl9cplG5V83BR2mhkg8EdTGIXz02zHcrzkphoQMSnOYYjmXVxslXjlAWinrcTBP5nOgXpG4D7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843790; c=relaxed/simple;
	bh=BRVLrK4oRNq3SMWiTqcZYNPP3f0yzzTdczJcufYytXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pwj/fu+Vg62nzydLH3LyfuhHjt4We8MnOQJEhCbQw5SpdzRuF12YQUCE1ANUzrhMdtj8iHb4ZZ2sJH5vR44ZxMMjQcPc7OrUjBSDc2X7VBoK/zvRoFPQNSOKP+Z2jaOV75hOUF97TRMsZ+/AUyVoJNR9lKWfKjKgnu+yk2qXwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLwgqifS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HN/PoFBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLwgqifS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN/PoFBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787843788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
	b=CLwgqifSDCbDH2q/+Wio0wM8h5oGS/GHiqhNAP9q+HZcG6rDyu62rom/VvDTTVB+9MoCkB
	RMIsEStB2i+y9YA/oVK4WVk6nmw5Eq+WFKFottAWeqtm6ndqQeNN8ZJLH5j/cY7ON4YzPT
	M7EOgmqoDRw3Jobht5TMk70oiM6nyug=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-XjkWjmNwMmKTvaz_6xD_cg-1; Thu, 27 Aug 2026 11:16:26 -0400
X-MC-Unique: XjkWjmNwMmKTvaz_6xD_cg-1
X-Mimecast-MFC-AGG-ID: XjkWjmNwMmKTvaz_6xD_cg_1787843785
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2531b5afe6so110286166b.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787843785; x=1788448585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
        b=HN/PoFBIs9xeUrQ2bFHQwfNhc+IVaOeVeMOnQ96s/AOIpPERGitvqTgIO3BEpH+5bl
         EzPADuEPr/Il57V2JHeArk/Lou8Fr2DHAJZT1pgNVB7Sp8eAG7i5dKBzF2MKc2bWkvgx
         wi/2KxSNkM1qQZcGQQe1O4bv2jT5oW38chNXfHtXSNZsk5a2CHcbOrMRLHpqmqspEEr1
         MiciMHq4mLeGzIYmH//tTF1r/7U/MB9C0qEgQbxfteU+EvUWUz7BSCqLH1kugbOrdKx8
         TFpEqqgatPUq5XLYBxuKgClxIiX3jztNt2CAL7+acfX9usY7eRcy5c01HNwbo42Vwy+W
         bFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843785; x=1788448585;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
        b=tTZHGF1pguBAALLy3gxB4katHpuOecKqEUk6fFcnRhNrqqHvUWiUFISV7yF2c+6ULa
         P/fvY9k6F6N2Jy/WpU8+bJfOImgcLj9OzBEIbK6b5UKdkXk6LVGDK3YXfAG8lrQooMrW
         tnTdxQNInx4LD6F5SN+uGViVTK8FMDQnEOEsRZWMOugxwFux4x04GzdHSSlGdpw871Ku
         Ax5VhIc0vbnGses4t72RbE9lPoRsdUFhdksY7BUJqB0sYnmAMT3tOBh7sjNURa8GAxf8
         aWPXj1IEtkuB//HiXCnUYS3oUXPDnRXSyDHjxXiQOjzpJYojsBzfVa5ofc5Uw1Xoh0+S
         D8WA==
X-Forwarded-Encrypted: i=1; AHgh+RqscdXiLQF4c+iW4dbyS7LG/cFpkL+79wwwow7YZJ/4tcR7OeNqqpERwkfhLsxn6N7teH8VY0w=@vger.kernel.org
X-Gm-Message-State: AFuF++mA5Ogpq7f//P9Q9eGJR9nyAEAsSxNdwlAO7qDwqqHFHNDc9X+u
	3KmQ0EUHXF77Gy+qSEnULWelh2/Gr3fd/Ar9NUbOGntrMiA9rLan1JUpiHrXuhfAFK82/LTGBCr
	ZNXTDQ63QvVC12PBgjRD2QsOalHPy8YtvAyhrWoQj1l0bz8QucJLK8AAa145Ef6W8FREF
X-Gm-Gg: AR+sD109NlOJ0SLjdDlt+4pVwn611TD68B6Ose8CkmA+ESlkE9qvi2K3nQfEFKcc8gf
	goB5PC/7vgrakTuv/iYOPh5o2QUbMydODsx8yVZXaUKRBnW8BxOg8uoHFVUoHTF7XHLGeWwzysJ
	ag2hTZsl+EoNqqF7sEBxa6/IVcL6psE+HXGcnXIDMfPIdHwwzBG17J5V3t0INyN+JenU32Wz9O9
	mFBCmCNPn70YTvga/S2bo6iNPJhrCWyDLzTF6bilz24jEFF96q8l+k+68hRZ1Xlwn2RiPmL0jEO
	hg/FXi2HTBbeZc7R3d7UpiO375EBtRgPTMRZSu23bAOGD4QCvquAOwOCU+4auui4oMyS6E8NyGy
	TB72A/7WYHpseiaIyoOe6ayfEYwcaNU3AAA==
X-Received: by 2002:a17:906:f5a2:b0:c25:4a19:45c3 with SMTP id a640c23a62f3a-c254a194808mr230595466b.8.1787843784829;
        Thu, 27 Aug 2026 08:16:24 -0700 (PDT)
X-Received: by 2002:a17:906:f5a2:b0:c25:4a19:45c3 with SMTP id a640c23a62f3a-c254a194808mr230592166b.8.1787843784422;
        Thu, 27 Aug 2026 08:16:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c253b0684a1sm139666666b.25.2026.08.27.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:16:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: apply nearfull_sync on remount
Date: Thu, 27 Aug 2026 15:16:21 +0000
Message-Id: <20260827151621.2758276-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ceph_parse_mount_param() stores nearfull_sync / nonearfull_sync on the
temporary fs_context options, but ceph_reconfigure_fc() never copied
CEPH_MOUNT_OPT_NEARFULL_SYNC onto the live mount. Remount therefore
succeeded while writes and /proc/mounts kept the original-mount flag.

Apply the flag the same way as ASYNC_DIROPS and SPARSEREAD so remount
can enable or disable NEARFULL IOCB_DSYNC promotion.

Fixes: c7a12c20bfba ("ceph: make nearfull sync writes opt-in")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6c6e9a1100db..d8ae49495c39 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1423,6 +1423,11 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 	else
 		ceph_clear_mount_opt(fsc, SPARSEREAD);
 
+	if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
+		ceph_set_mount_opt(fsc, NEARFULL_SYNC);
+	else
+		ceph_clear_mount_opt(fsc, NEARFULL_SYNC);
+
 	if (strcmp_null(fsc->mount_options->mon_addr, fsopt->mon_addr)) {
 		kfree(fsc->mount_options->mon_addr);
 		fsc->mount_options->mon_addr = fsopt->mon_addr;
-- 
2.34.1

