Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866906;
	b=plc49wVtJ7INnnwQ0YQhPznxfKp6sC8n4XCeeUDbJ/ONyBFTmPS3kydbjWwOpFHpg5f6
	 Mjqjl9oWCah/9XFWiGx+HyvMr+CKO+/qvXraOGEB6w9uOc0My/lBFgqd8NOVSsnR6UH7Q
	 YgIsc0PHLDNbW7hJVWJXblkpGljtNPw5DXyJ3/ben1sh2iR/pRGw5quLb+S+FeHQ7SQoc
	 cBUxACrd1kVzwewD6bbBkkZw/K7nrPxy+8mBQC7glP2V5YZ1B1lunltBTiEIElHwW4q8x
	 Cytc8BdMc5VMQfTQYodk3LHs1e7YymZguCkXz34K1Hijho3vy5Gylb3MorszpypkKxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
	b=aLDQGCN+f251zX37T2HdthJc2YyKgMN+AzMJ0i2ocd6r+ml4IOZqEydS2wCTjaJbsZ35
	 ZcVM1ZfWlVMKpBNc7d4yAcmKlz2LTluHAkGziRRIB0XFHvWuNhn5jN2MEeoyJsmbj9oRl
	 IuuI/7opED++/f75jAhJgsiNV0Uv4JDVAT6b1jjs29ziIeWiag5hnZLB93GvZ5FwqEndw
	 g1muOeXWmJ4vfd+v9wqTD51lyxchPbkVYbULABNI6fzCTR0oCkVVyiaSR3swOBXH0SVXJ
	 2LhYc/nzbZeTI3GvegMfyO7ptNkVVN5TltQguh+JjnDvvCQ9rJQd9/iFKiEho25I5Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mI9AzHue;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iu1T06jW;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BF606A8A1
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946BF606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mI9AzHue;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iu1T06jW
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYsnw1009602
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=60pH
	mj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=; b=mI9AzHue1mrP9Pn96d3u
	9DqalThhYt33uJqu180jr534PpsMio/QdWisTR/60eTWrX8VcZxqBJyd/U7fIJlP
	EsUVOJnd9knkaadrQUS68WK+Iriuu6FzTonvT9c+pmUWfq5Wm593XlobQlG6Uj5H
	6QFtY7Vh2a1Xb8dSD7YJgkevsInDTBvQUtC/EGOIlFu7JJIe7+xAtYOT4dWZOzxm
	1l3BTw9IBAsVozKXPDE881xZm1LbxtYCk/H+8j7udAZGwfzpYeRisdY7N7gpaNQQ
	6iz5Lx8HlLhrgG0D6F9GDJkvsCStNmk7Ged2uOuu80U3ugm+0HVLo+2NSbmkOhHK
	GQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qu889-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:24 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91f12cc95a0so82517336d6.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866904; x=1795471704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=iu1T06jW8kEq0JVxfgo+z0sbMPNQkA+N4lLcjJi4K8Z8KaPGQrh0CEVIs4vhXc12ye
         Aja9L1Q8D8fJBVRV4gCvooIwGAMtgsUgMsA1dRahEn2QBQVOX24g5KymN0A2mlgwEXCp
         /5tbsU8pBawkuoF27KgTPjTXZKMttTYYBfQzg1hzuAKaS03+/c8EmDvriSwDSH8tOvCf
         0xoMs7QA5Xo9hNGU2sbLSshCQKAUMIGsPQDrezYsUWsEGe+6DiuUwWYYg/zfR0WUZgAN
         5tsMu50uz6Z6sXtaAi8QP2awXEXcVvFQnlY2TvxMWg4kDD44ToyVyiQvujnrmEC8HplA
         Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866904; x=1795471704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=vbHWjD+3MFg3RheVFxKXOJs53kB2a9t3HF5FSK7EAWDqiBf2Ao4VsaQikF9GN/8tD3
         HnTcMMM0IKQnDQTHJHhxSdBzI9lCGwdHr/CKHLAChmmDdUugLK0oMTSgcNNu6EsBk9E+
         iRD3oH+9EKCO+N5ixPW5BTpAhZK+LS+ATrd/HI7wWvcbwVNcNCqL9+QA+NnnHfthb+Hc
         F76yXOMuXd8z7IEVlnmfljp6Qj7vcaSvJRF0GpgMAKI7cxf1cHPffcCbsxs6dR0qiM68
         CWcKmYmOLlPOjAc56CYL4xhM5g2e2roBZr3+6WuGjK/Fui6Zgl6HEB/r72dg6YKaioiy
         QHjg==
X-Forwarded-Encrypted: i=1; AL+hErEvM+iQMUsv2B/mVzWvTYgbnxWCdmBZxVr75CRnPALBcm/kRtgwPLyS5At11kbNip8c37vkqzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/01i6+A7GDO/HHJjVmswS2SC5UdfOlSaoZeGwalmKvVNx5ceGN
	qm4i/uMStQcItvzOsqMf/bwTJLig6qnkW1Lh9FGsC54iNC4C8OR3kLwCEIq8m2Hct9eCN3tEAjl
	b+IHaW80Cgma1/5X7/KYQil2PX2MjObtcQtpy0SbB7j5L8QghVWtWZQ==
X-Gm-Gg: AYBFou353yaSwYv/I87PE1/x5ktLsZJXBovDpqiPOqYq+9+UySMG5cx+SrnYaQUu+O4
	5pE/uewhgxCunQKymJNex0Yzr+OTjy/yNZP8NYXrMbLBsFQCeMBPnVjKYaWDjUDmzwwsWtS8069
	JfO3VZJUPmEjHudg28i6p40/czen+qfq8RTuOm1HRPW4JDbraqlYzOSLuI1XQUXw9YxyB2BCWqd
	PamZ1hpuAcjYwkPGF3/nbRFWtofwszu9YM8/Cbhv+4XSLBdjGHud1mi3sZpiYNrCLKmhgPCu8b2
	n87o4+JMJmKtw22clVqnUX/64PLFySZs4Q/mc3UdqDgtObPVfSdTrbu2PfUCI4lLRo9cJjnFkV2
	/yDX5a4Y7sxlAcnsWvluti/xjV15AJvcnLrexjo2gPQNSaWPGiPkr+7JT8i4Txz+YYqugKyevhg
	/nFcbdlY7x2paSQsaUcPMD
X-Received: by 2002:a05:620a:838d:b0:949:6ec7:68e1 with SMTP id af79cd13be357-9496ec77643mr1165873185a.18.1794866903962;
        Mon, 16 Nov 2026 14:08:23 -0800 (PST)
X-Received: by 2002:a05:620a:838d:b0:949:6ec7:68e1 with SMTP id af79cd13be357-9496ec77643mr1165869485a.18.1794866903580;
        Mon, 16 Nov 2026 14:08:23 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:08 -0500
Subject: [PATCH v3 02/10] ecryptfs: reject zero-length encrypted session
 keys
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ecryptfs-folio-v3-2-1aba8e620eda@columbia.edu>
References: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
In-Reply-To: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>, Erez Zadok <ezk@cs.sunysb.edu>,
        Phillip Hellewell <phillip@hellewell.homeip.net>,
        Badari Pulavarty <pbadari@us.ibm.com>, Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephan Mueller <smueller@chronox.de>, Adrian Bunk <bunk@stusta.de>,
        Michael Halcrow <mhalcrow@us.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1720;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=a+HBd1agQSrDWNNuzP/HbD49+xH+YgjHAS6T3xiz06c=;
 b=vTinei3NYNuv3Cv3rUkazssBbXmnH82BNwNm1+s3HPYI3+HUQp6/M/dmQBEJw0ok2epNOyPoC
 8UCEY0R5wgcAByL+q0yMda/FpXxWHZFvrR1bpWhrh7Qfsuzqq77OS2R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb7ed8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=aH2rPlVYf5PhSe4MZfIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: d1D1cE9Cwoyj-w0b_S11AqOBPt7gfuuK
X-Proofpoint-ORIG-GUID: d1D1cE9Cwoyj-w0b_S11AqOBPt7gfuuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfXy7cUqo6dH35T
 65ikNMA/jbujg6XdIO3XMCJDYmWnHySzcDLrLkk32OuJr5qovzRWLfIVuuHZolBDRbO0NpoWK+S
 VI2b77+0ZfLBIMWH7gnPPvHZPedWxmiuQRWQ1ViSC13MLGcScl9wjfH2N884XicqMY81WPl0e0v
 5VNlsFwKPd0xe+VFK7Xij5JHn2MmbxAhsG/VI71zXKfHF8bU9Wa3aVJPzeA2Gp7ofivI+Z1IKal
 D2ze9vFwH+oPkDBB1o7RjOiHhitglw6H+7xpd7IJ4mMbsHpXuGlL2Lk0y3DZ1yTkv8UxpaMMHNO
 OaBsp5E62rP9dKVeGOUzYnObx4avEIxYw5fTlfof5dbKeSiqh27JB5ajjy9cTnszpSRc8qIjpMf
 /C8JQAbLnAx/PLgPub8BDll3L8b6XX2C1xNTdbeA+Zx09QmiN2SN7XrhxFWqFc3fiPlExMHtX84
 ArfMtPHS7QBAo1igzkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX+AuBxMvzDEIA
 X5+BjJJuh96ClaaBUwDMRdjYUvHu3iLzmbCGkyI3Eotbq7R/duIJaeJnD5isHcYmx/I9EdLW63A
 5XvWNjq+oLP9ToChEvEFbejInArh5kqumaFM2jc5bIxiS8gzAvsx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

parse_tag_1_packet() and parse_tag_3_packet() accept a packet that
contains no key, leaving encrypted_key_size at 0. The decrypt path then
fails its scatterlist check but returns 0 anyway, so the file ends up
with an all-zero session key. Since file headers are attacker
controlled, someone without the passphrase can plant a file that reads
as plaintext of their choosing and encrypts anything written to it
under a known key. Reject these packets.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261014-ecryptfs-folio-v1-0-f4412187b1d3%40columbia.edu?part=4
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/keystore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index c2ba230c71fd..a0989e3c8aef 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1250,7 +1250,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       "rc = [%d]\n", rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SIG_SIZE + 2))) {
+	if (unlikely(body_size <= (ECRYPTFS_SIG_SIZE + 2))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;
@@ -1384,7 +1384,7 @@ parse_tag_3_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SALT_SIZE + 5))) {
+	if (unlikely(body_size <= (ECRYPTFS_SALT_SIZE + 5))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;

-- 
2.39.5

