Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D836492C
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582566; cv=none; b=N/v8qh2IrVbNDvTIHUnvqml/xcseuiHBOD21LieLF1MXk9X2a8YTDZKQEvDQdDJfPgsdf0Fz2zn+Wvc8+uMrz4Mn6Q5poRx/PjMx2HD0xb1ft6FMlkNyfbfCTDSazNYnlRjGVTPe33c1eYfCc9TkBRW0lBwjMzTFa65k931xyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582566; c=relaxed/simple;
	bh=lBYA02p+/O+qzH7dLpNk/39s6qEiCY5YCs0GlVPIZP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4QLczFod7ya8VLNSElLbNSu8t4bXD7dhEST5Ka9MQ0QcMbVrsSU12xbLKKC8QGvz/wejTpcR+yEKYm3ZOGyc/H0AEUZ2XkvAYM5jd9P9ob7t+fkOEze0uD65GkcSUBNYj5akV3yYuJs+h+aznvUio4u7eB47ow2PdPk2PVF/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tAb/xid0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tAb/xid0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1856168a91.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785582562; x=1786187362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ut+TYnUp65Th9//uFyyT2zkSxvallqu1/pfyahDUJyM=;
        b=tAb/xid0aLlB4Y/8TI1M9b1DuQDBsu2sb5WAVNhruwlthwtRA1nxDQC29pyiTP5kzC
         9rnzRN1y/Pxp7nVsqV9yUbuS1Czbo3kJuIi0C2bMkCJWYBGdezp3h8xonRF594uWu7i2
         qOTJahWmyFZfHUkrVS1UH4ceHcqcSX4U4kd8sj+pGWf0z44YwuMK0oDOV0MjrveUXBlq
         zjxnIYLUp0qkvPI5aBMKAqcPtFQ8O3HBCA97mB16H/p6udCKQBecvx/CjruYCCIvA9pq
         3H/DTt0HknFB75LEVMjJWbynesnzFJt3UO62gDhA0KJtbRiWQvF8bbLJCCBIu87L5mZL
         aYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785582562; x=1786187362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ut+TYnUp65Th9//uFyyT2zkSxvallqu1/pfyahDUJyM=;
        b=UFQ+GXa+GW56nDnxbpwi5GkwecDqIZzAXXlcW399m7CGiNsyTbJF6YwiVQarubuhLU
         WZ6acdGuH+XwpZ2ICzLE302skD2/dXtoaSbFhN/fklDc1SYjUderv8qomsMLLibf2HvM
         CsWqb+V31y8mkU1yxlV0dWSdnFQ7ZhD9aOoz7vognGljZ1xtEDN8Z9PfrmN7U0Rkfcvs
         Gfw0fii/eAox9x4pN/ZjzQXqmYLFuu4+apk0n+gFT9AcDfrA9PihASKp7Kj6HcSUo1zu
         cECPZBGNxlgVtZH7e8RS6rtpJ8Fo7Dv1/pZ2WpKpiSaALlEr8GZHwL7tZR+qAq9pWRRy
         rKhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9AOaSTqQuDAyLdZ3++2acLfochGEJslN0pQVAImKQrAoYZCsaBnZKW0Yk9mLopuy8F3w9hrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kIVsOTiCkNUxqkTpvxE8Y9DnPvLoEhoXentgliCOU6lofQkW
	XaP+tt07aBXH90cLB/5OuQtYgefzlWzRRT91a32Kqf5hT3OiIZgrQlbpy9jm20lYZQY=
X-Gm-Gg: AR+sD13n7bV+hdV/WekLHIUwz6RTRSwiddS7R+secsCXcJpHcLZ0/L5GjDAltzEHsKN
	y3vpbQK7JCtgdRK6rQloxfXwbTT0MPKKkE0q1U84FVvMPb/syqPzbTxYZvkQUd8RyWlRpXbGgGz
	nCq8V8e/58MxxkMPdxdUZua5QDZShDZSdWbolL4DOsqE2oSbPvOH0PWbOGeYexek//8LlXF3ri0
	4jrNHKTv4SeLgb8zp7mon3k4SEuohk/QUMFRso3druK/JnB94MXf71FWpsTtRUOILV/kPGChDWc
	WfydxvHrwGo4lNjrpkYEz50SmjNrPGdPDSxjB8CMKy1f8sWFEIdllHTzKeBATpv94eu9EnENebD
	WO4KIjbeRA5PURsu29BPnGh+JGAPGaG57PldNpCouOEIeylsvi3wXR3NaTpIgNoqn6G1AOrzNoV
	auqhAOIi5uIajBer0QIb8e7EjffnxDch3qrkD+JZym9mcIAOj2g3D8UCh8etWxJ6J5YnbPMyfUe
	UuYlqV30cEQFNKxILU/djg05UKLx0hapyKp7L6jhekbhQVw/19n3XPamGOkj0JCtz1PjQI0Ag4F
	0CrcuiVDrzqvE7bJintUPBjwLA==
X-Received: by 2002:a17:90b:53c5:b0:38e:85fb:71b9 with SMTP id 98e67ed59e1d1-38fbc3f9aa9mr3098165a91.4.1785582562113;
        Sat, 01 Aug 2026 04:09:22 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm20596758c88.10.2026.08.01.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:09:21 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: o-takashi@sakamocchi.jp
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] firewire: core: fix possible memory leak in build_tree()
Date: Sat,  1 Aug 2026 16:39:13 +0530
Message-ID: <20260801110915.82561-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for node in fw_node_create() is not freed when a
parent port inconsistency error occurs. Fix that by invalidating
references to the node, and then calling fw_node_put() on it.

Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis

v1->v2:
- Invalidate references to the node in the child nodes,
  as suggested by Takashi Sakamoto.
- Use fw_node_put() instead of kfree() for consistency

v1 link: https://lore.kernel.org/all/20260727095955.104972-1-nihaal@cse.iitm.ac.in/

 drivers/firewire/core-topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index df2ac0dab106..3d0109c3ed90 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -227,6 +227,15 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		    (enumerator.quadlet_count > 0 && parent_count != 1)) {
 			fw_err(card, "parent port inconsistency for node %d: "
 			       "parent_count=%d\n", phy_id, parent_count);
+			while (h != &stack) {
+				child = fw_node(h);
+				for (i = 0; i < child->port_count; i++) {
+					if (child->ports[i] == node)
+						child->ports[i] = NULL;
+				}
+				h = h->next;
+			}
+			fw_node_put(node);
 			return NULL;
 		}
 
-- 
2.43.0

