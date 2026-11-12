Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481673;
	b=Ip8IFZYM6McMoRRa3iU+1mgFymDeBv70ZNKJqWnu+Vt4dgdYC5zxn+2HpBgDDaliI0Sh
	 btvNxS7ADnWDC7W3cODEufhbZTaGz3aNSxG0dUlSGSzNtYEGg3zOM0R5dfhwJLLiGXis/
	 sMmbcRI2D4YUdf6N5dVIKPUkxRzAHi4qWKOWt6U/mkALfkiXv3w8cQC0bU1VclXr0sIUa
	 wcC7hGXDuKcJM1IIEUmFw3ubgHyMfuHTAJMNjcWkPbtmXpHWjJPMPIimnJuwOKlCkft8T
	 qABU9pk0TujhYtcfMM1goPxqSqFGNB4ZXNZv6I9ZAHs1ytOgKL06z9NRq68ysfG48fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=U/iOpJ55d/ZZTEeI13++J8llf2RohCP7ym6AgO7t1xM=;
	b=vcDB8ulnO5oxsBWFJb5yvzWLhbI1zgj1tb2NENb2eGAlStv8I4ZqfjzHKg3PCrKFgDSR
	 ivLCeFp2gVy6xBD/5o4p8yxPqS631elCDA84zHdV5d/jhPO1vgJAD0tEa044BCE3OdiEF
	 I82bipwoGQcKMhLoOeDOP2Ui4jv4NRnyUOz1dcP0NFMTKqj13/o4ThYbQmJ8xTgfM13qH
	 34ttpVrcd0pYyE3CnmNQAAt6G2l7pkaD//CLfJs8X4Qne6PoCvkmf3ZbtbsXx7r1y0OYr
	 eh2GKV1xdXaBFXwH0O/4JaY61WyZUo3AqlBLzK1ELAdt7cEYYeCbDZaVhp66jECBuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AHZsH5t+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NHECWIDp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC4606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20FC4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AHZsH5t+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NHECWIDp
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5nlp4441999
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=U/iOpJ55d/ZZTEeI13++J8llf2RohCP7ym6
	AgO7t1xM=; b=AHZsH5t+C87h0eFYcKgEMidTQYJ1rggVGS6JuvHqJOK69xJ/8s7
	UIuyj65P0U/RJSQNxazde8FB27TLm+zjM65pP2C26qiZKOycvPqEiXbN/FILzMNo
	YfIo4Zh0MqZBi3RZ4XJmyVa552SF/FkhAw4IwJYTgSIoW/TwpriCH/6MXmobWKF8
	ZKfwDdb7ch7wzpQcqYlIAJDFs5v38E1KuL9EmgHrPc7PMGpEKd97DAF/SwnNDjzI
	XjF+1OM5vXq8Hgb79+75+DtCBBamezsRoOQasp5zUh1gLqf8vzKuaGMsVqRPB5Ud
	Qg25ERRuQjnxClx1mJK5+obUe+TLp1Dv7/A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc151c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:07:52 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1aa0fb7f157so6403547c88.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794481672; x=1795086472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U/iOpJ55d/ZZTEeI13++J8llf2RohCP7ym6AgO7t1xM=;
        b=NHECWIDpGJY4Efmr1NlgvRKkj1AbIHtcK8Jq0IIBobvTZpn9OpYoVH1b60jdQBHe/a
         Vikjbj/Y9gry1WsomM2w4q5nxJjtkH9aybd1sVdFqep90W8GSs+eZt/vT1gB7CJxHk2v
         +Rg/Xhe81A3Emu57OYAfta/jjZpHb4BnQKCq2g146BsvPjm6tLeZLRs1/FIvgD2g+yM4
         Da+PL4vbcCv9IUZPC7gGZKPEnhwPDK36jG/j7iw5U1D7RV+lNYWduwN2CjA+4zhX9Wju
         pL5R0rEIJPXRZ2xNP54oivDOOjnzBZosfLlbLtphBNQDSA78vSGRBCIpJcm/YPifHftJ
         JndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481672; x=1795086472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/iOpJ55d/ZZTEeI13++J8llf2RohCP7ym6AgO7t1xM=;
        b=GcCcrwbOgGyGyiSoz2J/g38+oYFlTM8twM9rROYgPGdXZSRhtBnSBhHHgebYx5H72h
         fotlWDEFm7yck3ccOC0nh5+MLws9rARvcy2vqPjSYFnhtWawox1InlZsF7E+6aL4FTkQ
         nvFLSpjvbhBhx/0Bs5dbWWMNP/nw3yDlOllZBX3LuzIaatxy/w3HgF5NwSbSf/JdQU+a
         8lRV4/n0SsThSqIPFiGOM84JHdt8aEDnwOZHGGGU5yXLzhv+OY/cmMsyS59+sdE++N5B
         4GVZQTTIOhaqFAWGzXzwVExnDAqVC3Gb+Uhvgb2BLGiGSGvpP5xvdwjH6saRR2bPpMwQ
         mKAg==
X-Forwarded-Encrypted: i=1; AL+hErGSfmwhKE5505JqU9KImEP+gaNWCjhfkpAD9/VGNqB8H4w/tGACYxnRUG/CkNoTsXv08cPL/bo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/plWI0OFS7vChc4blSZFPzOOy1FJLDgu/KAuvopb07/9uHAAxL
	mGnzg8m/f6+Z6p0AsajROtih5BmHYni5OXFmx9thjZ0VrYV4V0YJY1QG0WVMRwkEYlGlNUMt3/A
	TFrZ7P9uf+yY8/CbluEoUoBKHA1GT6AB0kX0TJ75ZSPGpm+tK/nxIbcwbu+dYo9okajg76A==
X-Gm-Gg: AYBFou1yfrUlbqsILymXk/lmu+7YTZOTiuc+EPnjQcB5/quiNJfYwnEDoVDhjMKbBoI
	OwC8Sc5zppiD5FGKkFE1+mzWwKwIoiuXnFLri7uHdlOttS0DiH5wL7swiy2E1MBtUV84XhNbKp6
	u5kucyqWqZ9EMKShnYNjABzNvcXeys9fpDLVn+UKex/LzcWlU6FI5P/uW3MxxZoHwpZDLK+a7pD
	c7CKtCvI8f5cbxf+WvnsFabQtG6OrF+JTvasmTTEkfEh8WyZ+n7yTPTkfu8AJ2EvvrofQa6JuEz
	g4OwbxIPVsMIQXVtiPmP9GJ7+2r4uDMkJLE1whNVHnLcLT7345dGvy+0BF3rfXZct4YkcXr+w/b
	BJas4XIC2h36Dhwxg57/t8iszFbeqoWN/nyzUa71NGF1mT2ViOxXDEqovjrNXjgN1UGNfJs7K2i
	EHfMku/nKR+Sxmj6zIJPXdew==
X-Received: by 2002:a05:7023:d0d:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b3c0310062mr5180295c88.17.1794481671459;
        Thu, 12 Nov 2026 03:07:51 -0800 (PST)
X-Received: by 2002:a05:7023:d0d:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b3c0310062mr5180271c88.17.1794481670799;
        Thu, 12 Nov 2026 03:07:50 -0800 (PST)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm24549909c88.9.2026.11.12.03.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:07:50 -0800 (PST)
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] iommu: Hold group references across bus_iommu_probe()
Date: Thu, 12 Nov 2026 03:07:47 -0800
Message-ID: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wEgYACT4XeFxjV1xs5aCWZWTxEH9fzcj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXzmwc9mrmgsmB
 XFzaUkWUcSX/0KBg7o84tI0LkA8ZcU2GUSCMV7edpEKzuHPGERgV3053KMnr8wYEPQ04QzoeuWD
 gwaP/WNaHRSzijqdNMJb9y81hnx8Zgo=
X-Proofpoint-GUID: wEgYACT4XeFxjV1xs5aCWZWTxEH9fzcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX6yxSW9kEW3N1
 Ar1BheyS4vIodYA7NyMVZMI6teufzYg09KIrfQGPnbN3JcNfTyBzzfnEn+EbBe5D7Z1AxNXOGpR
 Dd+zPkqoZ3OO7ayMM1knRSZjj8dlYQAF2bIQESS4Hddbol8UaTh4sorHkqKTlue8+GIlJZ88Yo/
 X5fwPCNIzsYqkEfIv7D7BcwCWpmv6bD/dL/aZkr7jSYgB8GnXLw4qdZEnSJHbA3Xes3BRh9y0pN
 IklMz1kqtEQ6REWgGt7SQVEZ0lJa1JuPI0y2upAfzNvra3LV5zJ640y1i73sytSucLKY8HIWy2Z
 4VccLUCB/AXDCmzy9o9CEbDse46G6E/V5EgTku047wO5fUK+T6vTYKtqaG/MeAbey/ejIXQLx5i
 LFSCZ4RrS5CUhvFaLoV3B611xy7PVngBaDFjsVY/khbbWbWQQiR6rIJKdO/dKbQJvurISeZiNzb
 mB8GfMBhuK4oYjZmKPw==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af59e08 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5nmvm-2Xiqt-MVby-jsA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

bus_iommu_probe() collects the groups that are linked through
group->entry, but the list does not hold a reference on them. Only the
member devices do. A device of such a group may be released while the
bus walk is still in progress, for example by a BUS_NOTIFY_REMOVED_DEVICE
for a platform device that is depopulated concurrently. If the last
iommu_group_put() then frees the group while it is still linked on the
list, the second loop of bus_iommu_probe() walks and unlinks freed
memory.

This is the "iommu_bus_notifier() being triggered during
bus_iommu_probe()" case that commit da33e87bd2bf ("iommu: Handle yet
another race around registration") left open. The sequence is:

  CPU0 (driver's of_platform_populate / of_platform_depopulate() path)
  CPU1 (arm_smmu_device_probe() -> iommu_device_register())

  CPU0                                CPU1
  of_platform_device_create(T)
                                      bus_iommu_probe()
                                        __iommu_probe_device(T)
                                          allocates group X,
                                          queues X on group_list
  platform_device_unregister(T)
    iommu_bus_notifier()
      __iommu_group_remove_device(T)
        iommu_group_put(X) -> kfree(X)
                                        list_del_init(&X->entry)
                                          <- use-after-free

The kernel dump is like below:
  list_del corruption. next->prev should be ffffff8064a984e8,
                       but was 0000000000000000. (next=ffffff8064a9a6e8)
  kernel BUG at lib/list_debug.c:67!
  Call trace:
   __list_del_entry_valid_or_report+0x148/0x14c (P)
   iommu_device_register+0x1d8/0x268
   arm_smmu_device_probe+0x588/0x624 [arm_smmu]
   platform_probe+0x74/0xb8
   ...
   deferred_probe_work_func+0xa4/0xf4

where next points at ->entry (offset 232) of a freed kmalloc-512 object,
the released iommu_group of the depopulated device. That was seen
on an Android 6.18-based kernel, but the code involved is unchanged in
mainline.

Take a group reference when a group is added to the list, and drop it
once bus_iommu_probe() is done with the group. With the group kept
alive, a group that has lost all of its devices in the meantime can
simply be skipped: there is nothing left to attach a default domain to.

Also drain the list on the error paths. Returning early used to leave
the remaining groups linked to the dead on-stack list head, so
list_empty(&group->entry) stays false for them and a later
bus_iommu_probe() would never queue them for default domain setup again.

Fixes: 41df6dcc0a3f ("iommu: Keep a list of allocated groups in __iommu_probe_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Chen <peter.chen@oss.qualcomm.com>
---
Changes in v2:
- Replace the step list with a race diagram in the commit message.
- Add Cc: stable.
- Rebase on v7.4-rc1, no code change.
- Delete the LLM Assisted-by tag.
- v1: https://lore.kernel.org/all/20260929070737.3798358-1-peter.chen@oss.qualcomm.com/

 drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..6965b89e76bb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -682,10 +682,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		/*
 		 * With a group_list argument we defer the default_domain setup
 		 * to the caller by providing a de-duplicated list of groups
-		 * that need further setup.
+		 * that need further setup. The list holds a reference on each
+		 * group, as its devices may be released before the caller
+		 * gets to it.
 		 */
-		if (list_empty(&group->entry))
+		if (list_empty(&group->entry)) {
+			iommu_group_ref_get(group);
 			list_add_tail(&group->entry, group_list);
+		}
 	}
 
 	if (group->default_domain)
@@ -1951,6 +1955,18 @@ static void iommu_group_do_probe_finalize(struct device *dev)
 		ops->probe_finalize(dev);
 }
 
+static void iommu_group_list_put(struct list_head *group_list)
+{
+	struct iommu_group *group, *next;
+
+	list_for_each_entry_safe(group, next, group_list, entry) {
+		mutex_lock(&group->mutex);
+		list_del_init(&group->entry);
+		mutex_unlock(&group->mutex);
+		iommu_group_put(group);
+	}
+}
+
 static int bus_iommu_probe(const struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
@@ -1959,7 +1975,7 @@ static int bus_iommu_probe(const struct bus_type *bus)
 
 	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
 	if (ret)
-		return ret;
+		goto err_put_groups;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
 		struct group_device *gdev;
@@ -1969,6 +1985,16 @@ static int bus_iommu_probe(const struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
+		/*
+		 * The bus notifier may have released every device of the group
+		 * since it was added to the list; there is nothing to set up.
+		 */
+		if (list_empty(&group->devices)) {
+			mutex_unlock(&group->mutex);
+			iommu_group_put(group);
+			continue;
+		}
+
 		/*
 		 * We go to the trouble of deferred default domain creation so
 		 * that the cross-group default domain type and the setup of the
@@ -1977,7 +2003,8 @@ static int bus_iommu_probe(const struct bus_type *bus)
 		ret = iommu_setup_default_domain(group, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
-			return ret;
+			iommu_group_put(group);
+			goto err_put_groups;
 		}
 		for_each_group_device(group, gdev)
 			iommu_setup_dma_ops(gdev->dev, group->default_domain);
@@ -1991,9 +2018,15 @@ static int bus_iommu_probe(const struct bus_type *bus)
 		 */
 		for_each_group_device(group, gdev)
 			iommu_group_do_probe_finalize(gdev->dev);
+
+		iommu_group_put(group);
 	}
 
 	return 0;
+
+err_put_groups:
+	iommu_group_list_put(&group_list);
+	return ret;
 }
 
 /**

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

