Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F823E334;
	Fri,  9 Oct 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554093; cv=none; b=Rhl145mjNE6k535lYggaPrqxwYI9qRnPHFio19p7/by92iywsjTF/7QoV2+laYeOsGBuV4MeoctYHeORTiZ3aMo7NS+69KehzSfNmw/i/dVS0vDTFa1By2NWXqVybqP1gmA4pFZDA9CX+Ch/xG5L4tuLPzxtsfI0Y7RuMO+GYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554093; c=relaxed/simple;
	bh=h2TG/datiDtZD+aY8qm92gWYyH/kHIEvLXPka6LuiRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9xGlKbnV98qrN04CgmLMnvhBjfmYWJe0W7NcjdyHwADNjUa6mpJHFgQOAmWsEsWJEvTfaAKxyPzwp17CmM5ERtpIXjaieleCEP4wrorOeCPHZvcpszcdkfQAJDCCSIF+g6WcQW/WezuMDRcpHx48jdVJVztQvWew4i+2FidFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=fEWPH8FS; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="fEWPH8FS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791554091; x=1823090091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3pBSUI4IT6lCTtq4GcKaLHdG1S2Qw5b0Iqj4BF09bg=;
  b=fEWPH8FSB36IyhBKkAR5W53Dq11o4geMqejjOUP1SgJmCoBY4STqyU5X
   M3UApbJVosv5MmPGeYMQAO0pw9nxLlqc/wIee0MRmbu65gRyjwvxxT2tH
   2+QGM6I9cBaOx4L6zNZ8KGN4RmuLaLN/IfU79uhQyRD7y9z+awQLTykvi
   R8RT3zXWETiWojtrvsUaTYrE48NlAe0g6uHfX1iMFgLuc7NusK4/U7fyk
   b6bUc1gXHuQkpPJayneB8Geq6gyFZOhGRe6/MA6r+32UHHREqsnAWgv5g
   8EWxarICgHeC1O09P6XcuzL2O7gJigFYL719HBgmLqQF9mRIubylcOf59
   w==;
X-CSE-ConnectionGUID: Qkr2VIfNQ1i6cWkPB8RUFA==
X-CSE-MsgGUID: xFF3ydQCT1WO42O0466dTw==
X-IronPort-AV: E=Sophos;i="6.27,148,1787011200"; 
   d="scan'208";a="30615507"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:54:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29640]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.82:2525] with esmtp (Farcaster)
 id 5d7aa8f5-9a4b-453e-8e06-76113e6cd374; Fri, 9 Oct 2026 13:54:49 +0000 (UTC)
X-Farcaster-Flow-ID: 5d7aa8f5-9a4b-453e-8e06-76113e6cd374
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 9 Oct 2026 13:54:48 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 9 Oct 2026
 13:54:48 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sasha Levin <sashal@kernel.org>, lei lu <llfamsec@gmail.com>
Subject: [PATCH 6.1.y v2 1/4] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Fri, 9 Oct 2026 13:54:12 +0000
Message-ID: <20261009135415.850568-2-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261009135415.850568-1-nagornyi@amazon.de>
References: <20261009135415.850568-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit a8f659ce14f8f734894227ba2c5ca78c8451501e ]

Add offset check before access to attr->non_res field as mentioned in [1].

[1] https://lore.kernel.org/ntfs3/20241010110005.42792-1-llfamsec@gmail.com/

Suggested-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
---
 fs/ntfs3/record.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index bfb1f4c2f271b..d8d43f6a96fd0 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -206,7 +206,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
-		    !IS_ALIGNED(off, 4)) {
+		    !IS_ALIGNED(off, 8)) {
 			return NULL;
 		}
 
@@ -230,8 +230,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off += asize;
 	}
 
-	/* Can we use the first field (attr->type). */
-	/* NOTE: this code also checks attr->size availability. */
+	/*
+	 * Can we use the first fields:
+	 * attr->type,
+	 * attr->size
+	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -253,10 +256,17 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	asize = le32_to_cpu(attr->size);
 
+	if (!IS_ALIGNED(asize, 8))
+		return NULL;
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
 
+	/* Can we use the field attr->non_res. */
+	if (off + 9 > used)
+		return NULL;
+
 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
-- 
2.50.1

