Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D131A7264;
	Sat, 20 Jun 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944702; cv=none; b=YmbgK57uccf0uIrc9zKgUOD1z+9s7e5VN67vinnPvJ7Nf2Dkx3mBAqcP/M2RwX6esj4H5H+TZThbk8Ox8B27hvYzgV/tytdZLXJHf/+fY3+Doo6eh1Msjv+m2mTbDnF5QMPbjJ/WbN3S9XRCjduUXs9zKUfeaA0+ZvNbtdaYqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944702; c=relaxed/simple;
	bh=zEMukMBeMwrPcONyhw38vn1lpBqPIHdDff/YFQd2mLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GekQP8n+kwwGKWNthfp3RFq6DqxC7TV3KuwTSiUdqP7K1HSJfWs3La5MKB7LSFDKWQS2FysPf3JwCTh1xf3JYSfNdG0MEi+LQurTEmezOxePs/W4HwYs3XIp32SjJWwABrxfIHE6MMlIy+f1V7Y4XKEAnZu3eZ13Rqlz3MT15/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jvkFxt9/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jvkFxt9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d2
	yvxLlucterId8c/ram7jvV+2CDThmj8Ip83xZTfFI=; b=jvkFxt9/s1RFI18adK
	W49+3WBuBq8AnmUkspU54x52Cku+J5YJlumUCdVS5lFo+T4eWh7kGQ47MtyFDV+G
	e+RGHX6co5V7ythfXC3AU186GGk0p+loRyH+EAZijqck8bDynOCSRf+2Cw804Yos
	6v/ex5BrEdSJu2Bv0JspfRV14=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnra9IUTZqBIGuEg--.2619S2;
	Sat, 20 Jun 2026 16:37:30 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	felix.manlunas@cavium.com,
	ricardo.farrington@cavium.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: liquidio: fix BAR resource leak on PF number failure
Date: Sat, 20 Jun 2026 16:37:28 +0800
Message-Id: <20260620083728.2722895-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnra9IUTZqBIGuEg--.2619S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1ftF43uF1ktFyfWF1rWFg_yoWkWrX_Wr
	129wn7Xa12k34qkw4DAr4jq340kanFqrykAayUtFZ3J3y3Xws8Zr4kArs5G3Wjg34xCF9r
	uFnrKr4fXw17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUjQ6PUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QqO-Go2UUqX1wAA3S

If cn23xx_get_pf_num() fails, the function returns without
unmapping either BAR. Unmap both BARs before returning from
the error path.

Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 75f22f74774c..a1548ca81ecd 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1167,8 +1167,11 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 		return 1;
 	}
 
-	if (cn23xx_get_pf_num(oct) != 0)
+	if (cn23xx_get_pf_num(oct) != 0) {
+		octeon_unmap_pci_barx(oct, 0);
+		octeon_unmap_pci_barx(oct, 1);
 		return 1;
+	}
 
 	if (cn23xx_sriov_config(oct)) {
 		octeon_unmap_pci_barx(oct, 0);
-- 
2.25.1

