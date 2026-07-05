Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775419E7F7;
	Sun,  5 Jul 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246020; cv=none; b=mvXI3JeOCNWOXTm4SndfrFUQhV0mYMO35WgaKCFSToGZfqAlowkUQS9/W42URZ6G5Maaw51Mw4b2rYJP0jSIMo2YXjk+1Bx91ENTtRE7y7R2LSJGhx3CQZjnRkI8a9M+5GsVa6pH77QrulyGRdRBw8x3nXZ1ZJTBaKn7mN1x++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246020; c=relaxed/simple;
	bh=D/BslCccLispeoVpuIZDyoYMBtPgiDfj5O6/0eKk15o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvvHoD7/Y3RuWeQbM9BI5wZCEVqvYt78lVF4hj7eml75WEozbRmvFG49SyIAaXAmB/pyymovp3RCZ/rCWhn+2bdpwJQjqiNIKwKatn8+N6wTt5Bj/gARFihf6ffqmI6ZTW1QryDAc5nmzBAunFFePvgJMeeSJeHRU6bgHUD45GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=pit0Hm+6; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="pit0Hm+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783245981;
	bh=Bu2RbYJiLRXJooGrlsiHZm0pAPVf7UmQEIwLmVCISpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pit0Hm+6KsJ4dayrQL+VvG2+3KD8ZxRi3pWQGN0OtsYGaXr6eROce5d08yxZxtIIQ
	 tkyz4mCBwgvDdLxaHG8SEVUooyVZARrFOBiCIfmyzcAO008+TSd613WyGLWrEfscHo
	 hI8jjjzFqO+Pj7sLCzDD09txz0IpEivPrYY9ixVU=
X-QQ-mid: esmtpgz13t1783245976tb64a4809
X-QQ-Originating-IP: N2J/2ZOqWZo1Bb/znBgORj0PvU2aBr17tCYIibhWubM=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 05 Jul 2026 18:06:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14034554521175312704
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix hole runlist memory leak in insert range error path
Date: Sun,  5 Jul 2026 18:05:54 +0800
Message-ID: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NUTz4BkILuKLqvjEQlq56M9xIQjGP2kd/uKqIf5roOMUDuBaMg+zIZkd
	vdyuNJ2qHsR8yhw1tHi4Rep2leNVrHUgufBRf8D72QSKRPEXvZeA4/jGJe+d8eNsWyKEbY0
	NCkuWQ0gjZesQnBwtC+WR+vjX3X6pl0bp7chuJJa4nETfwbXhC62swxbAUooJjyIQSrq8QT
	7F/jMxbFGxkru9RE79s1cjNeSVAPS1X6ltFd8eDeSwM77MG7zH7RXRs/94wD6v5HPVGylgQ
	Mn9rY5tixIdAFWYAUHiUWKj9Q6sTomWoqiJo/hqGV8VioWCkFrXo2tY1aIP5wiw67b5FXPP
	SR0FZoMa8+7PJ9uTkaqkIQySAt6EXTc7EWgUWApd0pfUKwEXlFb3nffAI63IDtPpHRhToy/
	6Rt87HqcGxljDqzZ54KKymhbWMEFUcKIsoBh9ME5NI8aZ4Lt7AnGoPiX7MYpIGF8a8VNBP8
	dZo69XYMLYNxXIp2S7q0agwvud0dLVCoYTxDPVlcoWjVlF6FDoQF3mV6wfSZc5CnPjRb8yc
	M5yfuttav+WY7kvpOrL7mRCq8gN9BCyPMqmltrkZyz1wH2AAF+qBilgVpa37zgrGEyR5WdW
	zsoRK7/lPCMA1tFzGy8iRamOFAvKohd/5BV0HQOu1xOnMArCH7XDO9PadMitXpH+WPakBHN
	uaIGGaSnL6kfevGPG0RTzJjxFCT2Vznpdv9eG5kn41HdsCWxtHHLpVrABu6fc6E3q7/M3JJ
	Ffs9lb0UcAy+bSl1lX7G+75wHGEJ2TsfaPq/9MW2Nd+9Y+kR3DFgskTe8H8YBtuDx6fFkUq
	HEBxlTDh1bbsktrOD120Ce/JtXRBfQzTFevfAbo0B/LmDshR1HmwtrPh9o8hkwCThlhRPuw
	4CgsNJ06lPWjevRB+Yt+2i1dtcziqiKR1/zBVmLy4DB98Z4SYqKUntWm2DsyLw4XUJU99UJ
	llq/LfdU8reEDW7OWXNEdzYDrSc2WD1kU2XD8mZQe2NRAkmXQMTFjKIKMTTHN2RPOIQ/yCF
	N6MvrLBkz3P+l/Z4wJ
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping the
whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path drops
ni->runlist.lock and returns without freeing hole_rl. This causes memory leak
of sizeof(*hole_rl) * 2 bytes.

Fix this memory leak by freeing hole_rl before returning from that error path,
matching the later error paths in the same function.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 fs/ntfs/attrib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd8828098511..55603df0a2ed 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5325,6 +5325,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	ret = ntfs_attr_map_whole_runlist(ni);
 	if (ret) {
 		up_write(&ni->runlist.lock);
+		kfree(hole_rl);
 		return ret;
 	}
 

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0

