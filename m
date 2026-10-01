Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BE3FFABF;
	Thu,  1 Oct 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855185; cv=none; b=EgOQaN1bIwge7NTo6JtyffxVIDgPb1Dkwrb4j7Kk0Bx1KXixVM1baKg/L5X+o5h1+TxOqht1dEwYUMoxGLR04j1XcAhyZvRKCZ53e7Xukte02fL68lqAxs/wx0lMXIh9SX/rDfE7r8ptuO3f4+pI+bj5g8+m7hqFA3ItbN4Cz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855185; c=relaxed/simple;
	bh=KyolMzK8ydCDoHJPkXUr6Ao+vwzZukFtG7QYLft9ifU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT3+kwPFlouPw8EAgIN30SmgkuelQRqvUmgz1PM2ubV/ixBh5TLTS1UUHYsRvAisrxNBEba/hCYu+TFqiFjAMP8pM5wmZg8lqyUckadUb4f2xJ/R2qvTRdoKe5YV/8grMhOyqdwKwMqQFz6i5PqQzx0GvKnmcivmWb/tjrmpZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qQDNRYIz; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qQDNRYIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790855171; x=1822391171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0U+2BvrThBbxwX301DVl0/86ISK7yw4/jJo9vgpwYsE=;
  b=qQDNRYIzIAKuVseG/6MHKKs8vHZPD8k4f1cN1YemR13PsGZYLlXyDg3k
   awuIOeVGWmkk9Ncy2vY2tL94J1JJreddPzuEas4H7uCWz9MuuK4S98V3T
   34lmRaKa0vWNG+278RBIX3l04CoMf1HeYdCMWzlEU5fnLepzLD59bl/06
   OZAFPcEjPlVgr5JHVkEyUj8Ucb3fFdQxTcqXOONHavtQL6PxcHyzHJWRF
   rTdJHgutkpFN++N/G2aBoKE9bw6bVO1CPbgVG18BDqvQgbIpQgYoU3ddd
   SGICs7Cxo2jFu5bFNcvTc3XUhGzxzew+K+g7KJBs3ArSVXE0smd2U84nV
   w==;
X-CSE-ConnectionGUID: loI0uMNXRlG48wAW3TeDLA==
X-CSE-MsgGUID: B+DocRXZT3yo1WUsj6+Jbg==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="30159234"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:46:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:8819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.113:2525] with esmtp (Farcaster)
 id 77cb46fc-a86b-4e6b-9ed3-833f18851ca9; Thu, 1 Oct 2026 11:46:05 +0000 (UTC)
X-Farcaster-Flow-ID: 77cb46fc-a86b-4e6b-9ed3-833f18851ca9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 11:46:05 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Thu, 1 Oct 2026
 11:46:04 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: lei lu <llfamsec@gmail.com>
Subject: [PATCH 6.1.y 1/4] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Thu, 1 Oct 2026 11:45:46 +0000
Message-ID: <20261001114549.162469-2-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001114549.162469-1-nagornyi@amazon.de>
References: <20261001114549.162469-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Add offset check before access to attr->non_res field as mentioned in [1].

[1] https://lore.kernel.org/ntfs3/20241010110005.42792-1-llfamsec@gmail.com/

Suggested-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
(cherry picked from commit a8f659ce14f8f734894227ba2c5ca78c8451501e)
---
 fs/ntfs3/record.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index bfb1f4c2f271..d8d43f6a96fd 100644
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

base-commit: 1a8763b93150b2c8f3992c27a5ce7857fee4ab0f
--
2.50.1

