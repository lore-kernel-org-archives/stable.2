Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174947CA87
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852232; cv=none; b=bzXZQ/SRQoeWk8JVzroXLVL5luVLgHtzdcIIWPRTwVHNlz8bgZEsfimRrMP1lYm3DMuZFymx56cJacZl1MJhb5uL6I2evdM07Vc9sv/C4T/VzhzQq0AQhgHuEM71SmxnRpQGB/MSh5g0eQjM3az+3nLNiS0ZOvtcOoG0lnYfMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852232; c=relaxed/simple;
	bh=qPsUp4IBU702AYv5m5TMwKUH3RCsApcpmsXTAVAyBAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NvliDki0PULK5R5uiE/Vkw9ZWnS2Ryqk6VwQkaRcpmAFmc5Xd6QadtL3mjSoBz3MrvYLeP5zW+/Fxady/7heUncGyBRtUMZPVfa58yE1wDVcVrPHjTswowX8d9m0HObX8I5k8O6VCOJYSVK+OP0EhFXleUgw4lcNCE8knKltwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4mLZd1h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBswFAB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4mLZd1h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBswFAB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787852229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kjNPRgM2Y7JIhIV41NJgBnIZmEAkNtWdFSBVc2llNG8=;
	b=W4mLZd1h66BvXosEdWaMafoyeRILtiqIdyGejgLt3iizqJ6ttHn0M8cWXUsigd8OZChsPt
	EIj5My3ezIABvi35d46eYCgOQgbpWYS0gb9NJ46dS0xMuA4ol4v+jv2bXafnNEQYa88DAV
	9Le5qlDnQPTPvpVSAA+m4MIfxe0ybqo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-9VBnU6fIPxi_7XULz3XjlQ-1; Thu, 27 Aug 2026 13:37:07 -0400
X-MC-Unique: 9VBnU6fIPxi_7XULz3XjlQ-1
X-Mimecast-MFC-AGG-ID: 9VBnU6fIPxi_7XULz3XjlQ_1787852226
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c213d5fb55aso9395566b.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787852226; x=1788457026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjNPRgM2Y7JIhIV41NJgBnIZmEAkNtWdFSBVc2llNG8=;
        b=PBswFAB49bQzhdoRiI5Pb4sad49xfOIRRXr0/kD+YkAQFrhTvlAdwZrtg1TbJyt8aD
         4hGD3YPRp9ojsJpG8dwFtICQJ+vGSX1AB0Ib5UcPB23feMWhF8s6ndiQYCNpop9/le5+
         h/DIkC1DxDuGv+fR7aBKnSPmHrjzbzm5ZohBrUCvGR2GLBN8YqOyynCShkScZvBVuZPG
         a3KhrGYRCEYSfu4JZrq2aTbUnFLaMnGW98PmHKiWQ6HNM832H2wOaFc83Drkj9jydP+c
         +XEXmQqQfnROUJ2bDpenLSJX4Wbnjy8bMC+rfi77GqI1mmFZZmx6mqKXT5Ue+szyrlik
         xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852226; x=1788457026;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjNPRgM2Y7JIhIV41NJgBnIZmEAkNtWdFSBVc2llNG8=;
        b=ah3jFhHu7kxHamJxDQUhcwtdG9qtkrIWnpVAbSvUde27jdl7zEcAbc81uHYW53l3XH
         YccQaDaGW7aWlytYe4qL64oIx9gVSKg2cGYLgbVU4iHgWp3C2yXsxbYQNEeeyusYHCop
         JgQSLcvgGvblFJfSKU/6By/h8eQ6MXll2hsElBDD9d2IQUZBiullancIM9zjqMOXBl+o
         yKP1BdS9PxoTuxSnPdrYIFrnSI3C6eVIRFh7JMLu61FAzPkEMfVb0GoNfGxMn5LrEjc9
         7AVY/bJF2KdVVs8SINPo/I8nXiluV+3O7SnUNMMQUGzdnYZwd5qeb0kpia2TJBuRFsyW
         VzmA==
X-Forwarded-Encrypted: i=1; AHgh+RrsiBmQJHvf8nx5U9bRftMoJTRCoY6NkHKxzh28v54wVRxhd2SbyEnNzoXui3mgRCT/jRbJoic=@vger.kernel.org
X-Gm-Message-State: AFuF++nHgOZlhqwb+LHMMogbTWM2pOIjaKD4a2DbCcABCv8cjQ2NS6fI
	JK5SzRy7G9x8ok2UUM0B6Ypr1FnMsTaNVYfgeUTSJ0XzXXo62CV8dKka2n7sPrcP4+T7v77DK4S
	yLRyTyQUzERabKh3UkUAtnQcF0mCAGztOS26cshaKWMOTa/p6ZDRmnrHccQ==
X-Gm-Gg: AR+sD10+IorMYg/j+rBtfkev1buNUOPpjgmKeNn2v4ieHhdNogEOXZdf8tDbB6RhxX6
	siWY/CnFoH5bkTzpFonz0h/uqCtSCa6yVhZaZN5fCXdKqf7v8VElUIPbR07R2q0WyZ4yBz5loJS
	UMILAo9JDa4MrCJz3tXqxl5uG3jQfp2CB9Dcncg+LPxUWVcE6beiz8NTGP7gzLU2SwlmUslwONb
	Mae5wllnPxyuPDqT9GONJ2d26Aai/49m/WgCXJEAY1UFG4/9EiJ/WbhtJnPeBaKAQDmsEomlqPR
	VD/vyIp+SbC3GSHeBKpISFUlKH0TUPOX9F2D5DNdk1TnB418Sc1w581y29wMhidM/9MGlggXXz1
	UIZzOCeujClOjHkUAhouW2g9vSHpjLGgXIA==
X-Received: by 2002:a17:907:60cc:b0:c24:dd7f:3254 with SMTP id a640c23a62f3a-c2556c195e2mr24617366b.3.1787852226165;
        Thu, 27 Aug 2026 10:37:06 -0700 (PDT)
X-Received: by 2002:a17:907:60cc:b0:c24:dd7f:3254 with SMTP id a640c23a62f3a-c2556c195e2mr24613466b.3.1787852225685;
        Thu, 27 Aug 2026 10:37:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ab82sm799262066b.31.2026.08.27.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:37:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] libceph: avoid infinite loop in ceph_pg_is_split()
Date: Thu, 27 Aug 2026 17:37:03 +0000
Message-Id: <20260827173703.2762844-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

old_pg_num and new_pg_num come from the OSD map. When old_pg_num is at
least 2^31, calc_bits_of() returns 32 and both (1 << 32) and
n << (old_bits - 1) are undefined in 32-bit signed arithmetic. On
machines that mask the shift count, next_bit toggles between 0 and
2^31 so s never reaches new_pg_num and the loop never exits. old_pg_num
== 0 hits n << -1, which is also undefined.

Do the shift in u64, build the 2^n-1 mask without a 32-bit overflow,
treat old_pg_num == 0 as not-a-split, and compute stable_mod in
unsigned so seeds in the high half of the u32 range stay well-defined.
A hostile map can no longer pin the client in this helper.

Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Link: https://lore.kernel.org/ceph-devel/d1dc7faa-2373-4c96-ba0e-0e6d3e3b8457@tu-ilmenau.de/
Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 net/ceph/osdmap.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index e3448915bdec..558c7c3a4a84 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2307,25 +2307,39 @@ void ceph_osds_copy(struct ceph_osds *dest, const struct ceph_osds *src)
 bool ceph_pg_is_split(const struct ceph_pg *pgid, u32 old_pg_num,
 		      u32 new_pg_num)
 {
-	int old_bits = calc_bits_of(old_pg_num);
-	int old_mask = (1 << old_bits) - 1;
-	int n;
+	unsigned int old_bits;
+	u32 old_mask, n;
 
-	WARN_ON(pgid->seed >= old_pg_num);
-	if (new_pg_num <= old_pg_num)
+	if (!old_pg_num || new_pg_num <= old_pg_num)
 		return false;
 
-	for (n = 1; ; n++) {
-		int next_bit = n << (old_bits - 1);
-		u32 s = next_bit | pgid->seed;
+	WARN_ON(pgid->seed >= old_pg_num);
+
+	old_bits = calc_bits_of(old_pg_num);
+	if (old_bits >= 32)
+		old_mask = ~0U;
+	else
+		old_mask = (1U << old_bits) - 1;
+
+	for (n = 1; n; n++) {
+		u64 next_bit, s;
+		u32 parent;
+
+		next_bit = (u64)n << (old_bits - 1);
+		if (next_bit >= new_pg_num)
+			break;
 
+		s = next_bit | pgid->seed;
 		if (s < old_pg_num || s == pgid->seed)
 			continue;
 		if (s >= new_pg_num)
 			break;
 
-		s = ceph_stable_mod(s, old_pg_num, old_mask);
-		if (s == pgid->seed)
+		if ((s & old_mask) < old_pg_num)
+			parent = s & old_mask;
+		else
+			parent = s & (old_mask >> 1);
+		if (parent == pgid->seed)
 			return true;
 	}
 
-- 
2.34.1

