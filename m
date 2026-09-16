Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56848A8C2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594471; cv=none; b=VSqKpegfT+kcWARePSWXR5UfIQKEyjeirc59A9NFgBld2VceZvQk7+vxqCpv1LAC1LnAQyKLXjtjt/3YG9yX7pYuBZ/ZSdD4Y6SyesSCtlXZr2T2y65vdrTZ2kIukH+q6gclS8GMNbXpiLthLpz1S7GyMyVwALprDcGKF2qEdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594471; c=relaxed/simple;
	bh=Qmnf+v4LrIMRZqg6edS/dfA+zof2rqtKyGrQNG8y/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdgsZQgL5q830Iw5DSBZ9ikuvhKbJqQ1J0z1pwQrCusciu1hK6o7XOerqdeJxVTtKU19ihy5AxX4BLltXweUgkWaJODup5Y03eanB3veR1+dLTDSj81o7aTtZBV67iPr/LkTba2/NWhIbpgS40krKbVoAIZroZUsEtHr3d6Gptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=To177ZFz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYkUb2G5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To177ZFz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYkUb2G5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TMTDgfe97KIkncHZCw2WXJmRfTT4UsDz8mHppwqPsQ=;
	b=To177ZFzb9mGIDmr9r13B0xlv9tvVu/1JPDqWwqtBhbUNMSLH3xMM577UZXgNsFi3DLZHY
	azz9mV9lXUrNI9DTi9F3csXFni8eDq5HqAL57G8mjsMhn29qNPX8s9KHZyx7XaSiHgF5Z4
	snPQluPz+m8yrYjM0/KLTYXxOI2iY7U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-S5Uq1sPfPz2YM8pRao1VCQ-1; Wed, 16 Sep 2026 17:34:16 -0400
X-MC-Unique: S5Uq1sPfPz2YM8pRao1VCQ-1
X-Mimecast-MFC-AGG-ID: S5Uq1sPfPz2YM8pRao1VCQ_1789594456
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530d912b923so1518151cf.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594456; x=1790199256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7TMTDgfe97KIkncHZCw2WXJmRfTT4UsDz8mHppwqPsQ=;
        b=DYkUb2G5Fq7vCgnTp916zbRfUP9eOsl0c4feSQdnbTwNPzR/RQM2SlEg+OaADnxXZ6
         KoaFH+Vlfkx7SmWdKs6Vcxk19wf/ebaS6gZusFN530tlz7PEEj4Gl9dkq+l0WIC5ev80
         ez57ShJ+8b6E02bFnoLuUudQrnWBRr2awv//CqLo3KEHPsi7MUM6jUYspE1qcPmqCQj0
         wPSnHtJBupwEnv/FMIqk24m+mYqjyu2PE8YMin4HIzRX5I4WSPDffuT6Nf/eTkhDQPUV
         vr1IjnF3kNfd+JcSjsdoOLyQOEFvyMBv9DZuUXVlx3VTpcrCFYjzuPe16P7xqFwDLVFn
         58hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594456; x=1790199256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7TMTDgfe97KIkncHZCw2WXJmRfTT4UsDz8mHppwqPsQ=;
        b=TQwOMlu52Y+oKjlSl0ubiZev89D7aQQA8wDJZSHUuTbrEcEgN0hV0vTMaisEjT024q
         nIR8jlxt0ldCCfYkyzT31JKYdAgCXrD91H+Dv2aQJuFzHDGiYDNyhpZQ7/W2j0eC65rK
         wLxtxTQDKG/W2HaQBYMByHnrRPmlnN3riAXam1mD5y2n2XJdtMLfgzrF/1NWm3h88Ckl
         H/zLwIIWIzuOKEcnyOgIpqstdsedg9w8vONlmb8Q5iJx+LxZPFhkxEhGT6bFeIW/EJxy
         pgZYe3vK4xP0IiHQWU62PYDgKOu7Ye0xh/fFvo5qDpjny3Bl//k8rAdK8PuFpwN4oTQS
         Iahw==
X-Forwarded-Encrypted: i=1; AKwUvBzoH0KFF5jNRWNC5LSm8X3KPiu+JlhLHTMW+7pvmBJAN38yytalODL3Y4MD/mqUbOdm1/i4VqA=@vger.kernel.org
X-Gm-Message-State: AFuF++l0ktu/im//1mZ0xuD9QjXB3dDNfXLMJLNRRz0+8KXeS+7YBG5D
	RIfBRtkI99gyzVOgN6Ses4IW4Ss9PZKMDB5v3BYYK0pIDrqtJdaE8RT1eqxFUnszbZ17pXTqB3w
	n3D4rIpNT1hS+bPZV8jO4J62/CUCCcRQk6YABTZmkOexh+i+RQZLTyf6eDQ==
X-Gm-Gg: AYBFou2RXIHfsMCcfDGBLf+wlMXHiO1dC4/RqNHH74tT8LOg9RInlnAWxbMAtpmU4eq
	i/uq1+FaKI0fJq2eC/VdG7+oTnHnrQ8XJwXICKOOh4QY++0aZ1rz/HNwfCFJS2kwsMd50O3oOGB
	QdDGgG1OR5hVM9e7Qr3FwsChhRzaVqT2d8CEcYvrgIqW0Lf7d0HZuu24CxGYOOTwQ+iRrd4wG3R
	FAdX6QIkZ3FELcHDIZWIPYLfKSyAlIzt/PnlOnaYamB4F3vAHNnVuaoq/9Z9ixHRHhVUz/N0I/q
	bK0nQLYqziVwt4UfrTEdpSKuHOKJ5gZN5WIt3r6mngt4WQoEEPF99ADBlGPdLjsu/2qL5fIKKeX
	nKGNxd/Zi4Q+USXiP4e6eQ2pqVnjoBNrNRmZD7nGMAWvsV4X3aHelkL62JwdJfhXMEw==
X-Received: by 2002:ac8:594b:0:b0:531:d21:5021 with SMTP id d75a77b69052e-5327ed7c18dmr74679641cf.13.1789594455833;
        Wed, 16 Sep 2026 14:34:15 -0700 (PDT)
X-Received: by 2002:ac8:594b:0:b0:531:d21:5021 with SMTP id d75a77b69052e-5327ed7c18dmr74679181cf.13.1789594455315;
        Wed, 16 Sep 2026 14:34:15 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:14 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 4/9] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Wed, 16 Sep 2026 16:33:55 -0500
Message-ID: <20260916213406.1496960-5-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213406.1496960-1-sorenson@redhat.com>
References: <20260916213406.1496960-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_dfs_referrals() checks that DfsPathOffset and NetworkAddressOffset
do not exceed the buffer end, but fails to check that they don't point
inside the referral header itself.

If a server provides an offset smaller than
sizeof(struct dfs_referral_level_3), the derived string pointer overlaps
with the struct fields, causing cifs_strndup_from_utf16() to interpret
header data as UTF-16 strings.

Fix this by enforcing that string offsets are at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 945194fe7a97..05168284f205 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -788,7 +788,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
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
@@ -802,7 +806,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
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

