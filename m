Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32E3A3E98
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511523; cv=none; b=SkRONboYkuCsvKVuu0EwwVu9zLQ88GEWvB3upGJlO2jRvHwnXc5rTVGOVuecAW0F8vlMZp0SX4LBYOqLCNMWAV9cSE97275/jLNuCsRfhF44CFgmLq4R/LYbUVbQfH/dp4l/wPRIw1d4oMeA+X1+JQlP4ukHIpzr5MVFJQl4BYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511523; c=relaxed/simple;
	bh=ymkOB8UMUk5U/Tsy8K8fpcj6cIsBZ2uNEJoBCL7v9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg3NoeNlUI6geSq7tVek66KuueqyeuEfjeyFxW091tIm0O4PNYK9p4xkgou81Ch5Uygdj7G+YAbgJiy02OvX8ut9FXEUZMKEhubSdAcI3wNCZJJOf7kkL+t17TZW8sZNbWGdVW9icT2leE6ZwPnJLMkpmxIsdWDlwWrssXYk7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UldmXxuh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwAQuhIp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UldmXxuh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwAQuhIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787511520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
	b=UldmXxuhSNOBoNOlsFysd2CCqZQMgMqY36DGJNlM3mSCQQZYZzvYD5U5Ma+dF+jIii80I2
	Wps7J/w9T6obykAUrxZVTqwD1FuV3oGkF4OAHC5xKPkh0AdWQs+NVtcGgJZzKywARAMh0G
	dE9JIsg7wpom1+DNUh7oOfo8m2PwE+8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-nyfR7MBwMi2wmbB9psimDw-1; Sun, 23 Aug 2026 14:58:39 -0400
X-MC-Unique: nyfR7MBwMi2wmbB9psimDw-1
X-Mimecast-MFC-AGG-ID: nyfR7MBwMi2wmbB9psimDw_1787511519
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e99ff505c2so5555342a34.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787511519; x=1788116319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
        b=PwAQuhIpI9cK+r1OTqNBQmbUKM2BOoOThtTdTxphTYsIZGpWW7zPdYFLq8YwotVUYS
         zQDXtR/vBpUTERQy8xR06nLa/eUtQ8JZv1GhJ7QT9Lxt6PCd6oByd1948BbqS4ynMDqu
         qb51/CYt9+z3pqnW5wktMM6P/QiyW6K34F0AH6ZrFNbAaW3Vva1h4rmNuKU/2IZoySGe
         KPrPt9RYJYreHaIPrNh9xTbUKuvDhl+Z/yPBxEH2J1LyM1oxrljEVZeujF3GwYf/Fn28
         QKFIam7SROmHUBfGN1XFum9T9f1wkXPPBqgkAD6S+STB82YZJ8ufawpIVkwcimbAb1Lq
         y/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511519; x=1788116319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
        b=Sv47Yg8+ivKThfA9JxN8t30YH5N6er0jHburQvv0M2DOPAMJQVdZ/0CUg52vrHpRKz
         /N72bQ2SmLvW5+4BQMHTovpUvhxUr5f0/txtrxVoziiO/Lgcq7Yvrcrl7BmpDE2UacfK
         udAsSuGcN+3IoL01iNKt4oBh9Z6IbQfGXmBajIScDDflTjmez88N1oFGTXqUcwYjjBGM
         X92ysHeJRqCDq+ghaOoJgAYsApyHVUNbpmQwJb2I5Q3Dv1XV02wuJBRrUvGIgztjNkMC
         s4SwvsBhVr6Nqz0BOYE0XiW1DYCjLt5BQ15xa6OjNIgWPag2Ee+To3sfsMVIgOJClZ/r
         08pQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhkBYTcNPCDavWiv+6wQ3fDFWPp7cDpyTbQI6Hc2k/2uGDJ01BATSDIj/PYsn7rVQDtV4RCzw=@vger.kernel.org
X-Gm-Message-State: AFuF++lwZnjn/uR+q1hETjcLfcJVKbDVTeiqcU7lICgsdfl7hYs90PX3
	PIi7d6t6sZsIsvILRhrCM/fu3xVLB3mAeP34noB2wfa7NFVfJXcopTyTolUDIpM0KgdaYvRf35x
	VdY9Ortu0KCa7nVg5jehQkgTP3OsZSVc4SNDIfpafXfaNIyYKIaUV/hOKpq2ZRuh+ow==
X-Gm-Gg: AR+sD13XGaLQOjnmYM7M4vJLE5RUkBrRV3AVQfx+19aFXKVtix9zwDLUNAK9dzemXrM
	m0U4hthANQKgRF2qJ9Rm7gluIo86HIcGMhWdykf+/lNasGXgIk1GgL2Z/7DMSEuXKfOCSZhdiYs
	Bzm74APe2E8zxoWbhEDFPyyquCvX5oDjGZ/rYBm4unXU6KiivGHCPoPV51+hfwGn5mghNb+adqK
	P4gCPH/LcDOfqDdv/oJ+oYHPgFbaOps7jAUTNHUXScrWMjf9Oomli7x9kfDlctUC+7Wt4mncsJV
	0uuLPnlusfGobY1Y0E/oQIzmqfbAfyIQy5kTDkkuYmmgz6VYqil3OeFsyLC6BR9PnGFbYRMiecU
	DJZA2y7FhoS1d458cgW+aiDtdzhHqIssSEhIHluj7kkb+tGN95jasdSHhumCQSBzJeg==
X-Received: by 2002:a05:6830:3590:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7f4615ccd5fmr25283740a34.15.1787511518679;
        Sun, 23 Aug 2026 11:58:38 -0700 (PDT)
X-Received: by 2002:a05:6830:3590:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7f4615ccd5fmr25283718a34.15.1787511518292;
        Sun, 23 Aug 2026 11:58:38 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1db63sm2518710a34.12.2026.08.23.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:58:37 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/11] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Sun, 23 Aug 2026 13:58:00 -0500
Message-ID: <20260823185807.3115901-5-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823185807.3115901-1-sorenson@redhat.com>
References: <20260823185807.3115901-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_dfs_referrals() checks DfsPathOffset and NetworkAddressOffset
against the buffer end but not against sizeof(*ref).  An offset smaller
than sizeof(struct dfs_referral_level_3) places the derived pointer
inside the referral header, causing cifs_strndup_from_utf16() to read
struct fields as string data.

Require each offset to be at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 46e1382e8e04..bc7cccebf387 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -787,7 +787,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
-		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->DfsPathOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: DfsPathOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->DfsPathOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
@@ -801,7 +805,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
-		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->NetworkAddressOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: NetworkAddressOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->NetworkAddressOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
-- 
2.55.0

