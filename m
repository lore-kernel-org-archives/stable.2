Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968214;
	b=CBhx1b19xllFcwVBpBjPNRwrnG3UaLhCggQ6QnmEKTUIQeH+ViHtpbiHCitstlocBC07
	 VdnmWRJQHUuBkjX9tbYCKpzoMYSdwyx/U2cMpXuc6CFKNDBcMr2lS0AHsdKciFNsQpumD
	 BDRgLmEGSzuE1Jww4TBWhERZkzW7IGjvDoOL3YWW4JntmmBz3htPnKoiuEqA1Ycpncbzw
	 UKHNiJF6CJiY0vTXzDN+Gm1zGgqfVV6niXIiYUJFm0KPa3Xhsk0te86w+6fGAVL03oyXe
	 uqEnJouKSzRj0umMB3ctzCYfFSQtWX43kW1EnC2o6Ei6FHB3RaS0Awkd/rFzmjeCINw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968214;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=iE/wSMEyH+VJ7N44evRSI6GiZHRtas+tUg6V/FJukv8=;
	b=GRGZqiqs4AN4ZlmKGIk80jZecuHOQRQV54Vy372aNi0XFZDGqxrH9pTK+O9cTvJbK9s2
	 +9BdXGHqyLTFjCBs0+FNyaSKj5pOlwM874VUV5DjyHrIPZVxYHM0Y4yZGO/eF2x75K5bZ
	 awk+IK7Ii7Hz6C6SjdnISFjks6zxfiZp8axb5sH3UQco6LZ5zsnCww11eat9mme9yVgNH
	 KA5vgpmo6SCqqR8t6jwf9XU0hBGI+5Ljl3p9homPGPzkXW9eu++k5h15GWATjXJ57vtqF
	 r4I2hUOKuXEhieR3zd/8p1YAvjFGnUMnZP0tJBSKvirphjmf8+uV0Wf9R1kNuKD5ywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=YrQeH6rD;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034B606A326;
	Fri,  6 Nov 2026 12:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6034B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=YrQeH6rD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793968154;
	bh=iE/wSMEyH+VJ7N44evRSI6GiZHRtas+tUg6V/FJukv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YrQeH6rDtICoC49R+Ny98LjrT3tTdxdw204wGECqB+TifQ16mTCkWqy6DvnjYltHG
	 MwDaBiUCcWhhlMzzSJjVVL/do5fRSrqdbo4xXi8h3DP6sLQ8a698jVxxBBC4awC1eo
	 DZqX9z52PVWxqOG0lGy+FAGmQhE7EZbJEbQKDKlc=
X-QQ-mid: esmtpsz16t1793968149tfd83a869
X-QQ-Originating-IP: rn61B8C1YNl8SyjETSttrJvGd3PBtU2QMgdZTeBhfdI=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 20:29:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11494895802683602056
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	praan@google.com,
	stable@vger.kernel.org,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommufd/selftest: Fix wrong slot cleared on mock HW queue destroy
Date: Fri,  6 Nov 2026 20:28:32 +0800
Message-ID: <09A8E000F2353E67+20261106122832.88995-1-peiyang_he@smail.nju.edu.cn>
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MEB/GPYjqGH/DEXGQiY0HgoHjqcB92IdenzqECRmDRpqSHbbIr4fC/WK
	TYsDZtT8HDjfPT21suB0OH3husV4lhpV6daxRuLCWbl7vpjenhjUpEAdfltpttmghflTsKa
	ZQTDLhYQlO4jFOljzf/aRjZwhpzfDUP/auciCSKERCVEYYJ7IHoQQJkU/PAAmwfwxPk4x+F
	ASblXgtatHI0UR6LN7ocj96yGxZ1QQavygZjUEtd04pHMCD8iJcEfNb7yKzQ/5W8WCMYxcL
	IMxfCnJ/qRZw1CrdBTe+YWBfixl5krfDOm3BS7Hiuy45xWPouyX9Vf/Y1z0iYqCga7FOvqN
	jimCsv+fbZSp+eGfyrIsTHJGQctOed8Fd97GjEI5MtQ1SHG65rFpEufj9XRdczdc5kBCFnz
	VwMlXpfWCjHhkchC2xfvIGQ0B6/0PLBbmsGoTkD9X0e4kJOTaZzKx5KVrBK4CDWbBA6C855
	Wzc6eHEewSBsfUw9e8oWYfL7SWJrHbo2uszXwE0mA2rP49rrrUEVSt/TuKNNflWkbgMKCEf
	OhEuCMh1TAgAbTHKIstaHOl3r0UDSxaUJe1WqAhl7i+A7Kd3c+tbf2IcdRG+7DKSri2ukaJ
	t9epoU+GC87u25AIiQm4WMooqSn7DkX7ylkiuWCwv47RijtePJFlZJmL0m4XRSYUTB5l0WX
	kkLcGMqlZ2wJB+d+EOJAwsCfEtbZbz5DjFb/UYL0aiQ4ABeIYcRr3/3LmriJ9G4R/517QZP
	G8nui/j7Dsd65V0Xjk9h5Ubm+DXdJ3iscd0F0xHURujdxReyjOqNfTVsg6hMfCysZbGwpQr
	TwzPgIy818n3+IW4o9TYvpM5Gg8Q4rROEdRYHVTvbcCQrcjE7Oc7Ep+wcefZRxVzHzfiT4/
	hfNDZV1xV0DTrKJYXmmwdSmMhLm6Eox+iDp/DzxT699zpSvOgQMkrKWTWqnlP+VN0ETzWT0
	qq1tbM+xHhx9/5/3bybqIYL8fxTitFxEEEmoIS76rdtIx3Y/wvkELJRexmMp5M2ggBauDNV
	w83FLHzjrVOb9fgAqRUiUrda2vsq/tRzPzMvux2Ovb76fe+YX7
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

mock_hw_queue_init_phys() publishes a new queue in
mock_viommu->hw_queue[index] but never stores the index in
mock_hw_queue->index, while mock_hw_queue_destroy() uses that field to
clear the slot. Since the object is zero-allocated, destroying any queue
always clears hw_queue[0] instead of the queue's own slot.

Record the index before publishing the queue so that destroy clears the
correct slot.

Fixes: 20896914da8a ("iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: stable@vger.kernel.org
---
This bug cannot be detected by any sanitizers or kernel warnings.
We observed this kind of weird situation and thus found this bug:
after allocating queues 0 and 1 and destroying queue 1,
later IOMMU_HW_QUEUE_ALLOC for index 1 still fails with -EEXIST.

 drivers/iommu/iommufd/selftest.c | 1 +
 1 file changed, 1 insertion(+)
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 25387969a..54d86bce7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -759,6 +759,7 @@ static int mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
 
 	mock_hw_queue->prev = prev;
 	mock_hw_queue->mock_viommu = mock_viommu;
+	mock_hw_queue->index = index;
 	mock_viommu->hw_queue[index] = mock_hw_queue;
 
 	hw_queue->destroy = &mock_hw_queue_destroy;
