Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00419481FC2
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322596; cv=none; b=o6VX1Z027OIkR2IQHqfBhQ+Jvr50Xau4EtLgmzIB7FnMbbVDjPupP6nIM6Wu9f/jmt/zM+5Sbm11EQqRDucKFgpCSeaQ3YgVo9et/e5+q5r0i3gH4GFg7KSb9jpnNSKF2Wjjsx8O87WtoYcxS+wsuzDALygYOowp+W9Hvit4RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322596; c=relaxed/simple;
	bh=MqTsNi+pWWcsqzilCVqeOt9X0DrwjNhs3WYgNXeE96E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jALr1kzW5MlzO91pDIusZInMTwXY/sRRq/n3J3iDxR+JFwCkj69Ne5z+XzDn7pGafOcgIQCouY/I7MNPCzlFyxCXZM1gSBNOGQHWEvT+z/fBpv0Iisy+ZkzA2DR89qKIQJf2eus7VtbW/fSyT64YX8oiah/20HpxDyOiviU4gGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqz5fIYf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp3mrcbj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqz5fIYf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp3mrcbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LoPUMEzF5v/31a3ileSqz/j7rdB/qcT6gvg1SqPd594=;
	b=dqz5fIYf/NW8sJAHfTDOFb4GA+0iPuiFzouBLLHpVegcLvA73/eWaBov9VTaaqfWoU8RTv
	v1AgISQ1wQ30Lrfahhm+EHfxwnIGpK1WFu29evGPY0UAEor8Gr1khrEBUog/u9cbillh3Q
	g4GhFYEaLRVLjMdecnqZEtF4do9OwOk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-FhorifpFO_akUjMgdbyAww-1; Fri, 21 Aug 2026 10:29:51 -0400
X-MC-Unique: FhorifpFO_akUjMgdbyAww-1
X-Mimecast-MFC-AGG-ID: FhorifpFO_akUjMgdbyAww_1787322591
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1a97644aso13327811cf.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787322591; x=1787927391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LoPUMEzF5v/31a3ileSqz/j7rdB/qcT6gvg1SqPd594=;
        b=Kp3mrcbjdGVUSqjOfYR8hcz9un8uZ0Z8eJ7Un1rkInhXYl59R8djk9y0x9djG9iFD4
         IfB/YNhGk8qe3XgIXVDQZZHcsqjAa68RzI+YLb1171lI+vUyst6UDllEblpcUq+3G8ze
         KE1D8V82nT2TajrgJwUU//vBar+1e3wjWKztRdFSeqdA02fp0iqNZtn54T9WuDe2trIh
         /kS7fuRfXyJr5MY+NsrPa0nnsGp3pmuiJj8n658Dyy2Sqy+a3ut1QwbIokIQF5E8Xgfw
         s7q4JW/95A5Ngot03bETk7IvvURhBVkV7P1AFiY5Yr4Mo9X8HFfoXWESLid5MNO7rIjK
         kvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322591; x=1787927391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoPUMEzF5v/31a3ileSqz/j7rdB/qcT6gvg1SqPd594=;
        b=OPFwfVr5zgjG5UPH6RLeVJQBIddxU+xl8mRiMT9YcpEVFhsVAQSpNZIIBPxkeGJgiz
         CisnansXsYbU3kxmhsMQ6uo6J6pz+8APqwGXFUAchKxlesZrQ3Le8i0+BYNPoAbNk2HX
         Za5iZcdjP7+zUXz8amHlGB0Mgzud/RcNBM+UntEtbHMdC06b5KEi6ItC1LL8ctwh6kmy
         PQRk5i1KspOUBktzGIfwmomO6t3uTjvPJGeNLPpvST85b9un4UEApjSbyOTa/B4mZC+t
         lLSwW/yPrhZoS1u8zjlFfWRh8++TWOP5oHEx+eq8bdgs86b5HeQb2iN4QsS5eFraTiws
         xuUQ==
X-Forwarded-Encrypted: i=1; AHgh+Roc8QcNrlIQvtBYxs7oANhC5JarozXigyo8bkmUPZlYPHpO+GaxFcrZdUOw2sw8FKnxDzCAdzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/4s3g0ZYYw40kK5KobJBcHhxJwccKO959L6Ke4aFzDPiR+aD
	aW7gDAqEVmFbPkH6Jh/Yuj1nGsH++tf/HrksHn6U3Z8QjBqe733IOGilnGuTyc5i8nWtXdSkFFP
	fVIFzFuI6yodztvrwTx3+A7tSnNJzY7t/NzviSnoVhhslE0NDa19jGbKyOw==
X-Gm-Gg: AR+sD10pagXjFOE2CLV4Pr2Yr53FpWmv5iHsO6+AQkcZI6BDTvSw/+kyA0UYU7AVPHm
	rEXCUJSBP+zU7FS/ah/jnyO0Geo4ch4NE0PhgTBG0o0g/LebIeyv8la3v1YRgY+lNn+tG/sUPiL
	99WPaRWhpEr2+bd9OnZzDAgI2AILmV9vtQhbCa92moTE/ok3hs5ovFQE2BgEtCIVuZz8BK4D5++
	1Njrx1DmAt2LFMkNH8nIf3yH1qJOqc9sViMtQlJINmcAj/xVEDhLL+5AvUGFl7Qx85rVm8a5OZG
	vvUx50iIMSfOsf9CGdRJ7BGG4nIvs/EYXuzohNrbL2JiPzEdNkpl55TT8ZSfzCUNtb8lxI7/aXC
	Ad4+fzxdbM5dIKv10IHF+TaOQ3bFvic6Ql2vr8iGVXcVJ6JRcChcGoMt4dMRhhHaaiw==
X-Received: by 2002:a05:622a:1f8e:b0:51c:2135:b00a with SMTP id d75a77b69052e-52df5bf8884mr63070681cf.40.1787322590613;
        Fri, 21 Aug 2026 07:29:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8e:b0:51c:2135:b00a with SMTP id d75a77b69052e-52df5bf8884mr63069951cf.40.1787322590049;
        Fri, 21 Aug 2026 07:29:50 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2911a5sm63285396d6.30.2026.08.21.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:29:49 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix OOB array access in __smb2_calc_size() on unknown Command
Date: Fri, 21 Aug 2026 09:29:46 -0500
Message-ID: <20260821142946.1728452-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

has_smb2_data_area[] is indexed by the server-supplied shdr->Command
with no bounds check:

    if (has_smb2_data_area[le16_to_cpu(shdr->Command)] == false)

The array has NUMBER_OF_SMB2_COMMANDS (0x13) entries; any Command value
>= 0x13 reads past the end into adjacent read-only data.

Add an upper-bound check before the lookup; commands outside the valid
range have no data area, so treat them as false.

Fixes: 093b2bdad322 ("CIFS: Make demultiplex_thread work with SMB2 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 9068175e57cd..26b41ea3b72b 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -451,7 +451,8 @@ __smb2_calc_size(void *buf, bool *have_data, bool *data_area_overlap)
 	 */
 	len += le16_to_cpu(pdu->StructureSize2);
 
-	if (has_smb2_data_area[le16_to_cpu(shdr->Command)] == false)
+	if (le16_to_cpu(shdr->Command) >= ARRAY_SIZE(has_smb2_data_area) ||
+	    !has_smb2_data_area[le16_to_cpu(shdr->Command)])
 		goto calc_size_exit;
 
 	smb2_get_data_area_len(&offset, &data_length, shdr);
-- 
2.55.0

