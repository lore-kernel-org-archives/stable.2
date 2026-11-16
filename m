Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866910;
	b=IV2wVP1RIlrsB/PXgh1qxT8Vowyn+C9hlGJh89IIWMzBkpIElUQYpT4BRR1KOfAa5Fwd
	 V7dl193WyvpqAp8Sy5AOw/BOVBeBA18czI6EUF1l1JbdQ5/ucOgK4LqL9/m1wYUigkdqT
	 0G9+XUgftDAFkPgZnn1rs7LjUqih6YkcYad+EZJQheyXoULID1iLBvxkS74EzfNQ6j7EW
	 fPMx5hgE36DuqY3jh9/kqMZWvetaLxSCd46ogUFvmnXe88Cxc02F1Q7GVKhCWYsim7Pkz
	 jmDjZStNFq9RtO8Kl7YYCuVoqnGXucHNZ68MyKQmufoc26H/Li3m/qA8GVqRwzNDRxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
	b=jY+wXr+t9NxYeZrmOBXqmTsrSIiTtLWfmeoeZOBrAlgrHxPFRwoyiOVJJx/xI/H1FNoA
	 7VnZS7DJX0IIKal+IrMQ1r0vYkN37d1776/4TS1EBQMMNzwNLYMsdqMjwaz6b47PNz4dP
	 AaC1FBlFa6HB5NIPUX1h43Nhr1QmvDFbH+vDP91VQsOCcr1coppvKIKeqB2ZfRGfUu0je
	 B387QtzRBNxXImPCpM0vww9pvmhicI0WG8NmfUidTyd4MonCDx5xzpDt3pupMBVDfnUCv
	 kuo1DjXI7/vMR+klGgsI8q9AX1DiHlMxgQDdorQ0vJeLEk8/IEnQBu/tBsK/lpx/5KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XCfCoTmS;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=RZHzNF76;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72374606A896
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72374606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XCfCoTmS;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=RZHzNF76
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYlGE4118924
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+BUU
	SRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=; b=XCfCoTmSY5EFYB4UlYO3
	80KSJrmAjvpCy13G/7eRM9eEXwpIlRuFzA4kHNFsO20yTgGsDX5QMA5i5OSPcnmG
	qhny2iVdJOhrv+AUOEannZXhta/zsceJI8wJmWaA+onHIlxCnIAN9Kw2j5hBPEdC
	2dznpzvcnDH7fk6rjBjQuawSp/HKgLSLMJduBGNbw8OnviEitOL/2ix5f9ItVZFD
	ZQbGQgl2EMCJkapkA+2vHjy5b+uoUP+EvFRIsM72S/2PM81B5MZRRmOkFKn57H1H
	41kPqEZmb9eV4lwpj5QErk73vRRmX+aLGn1Uldy4be1zMyfUJMfDYJMTrwStNDXw
	Pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uahs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:23 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so1111672285a.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866903; x=1795471703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
        b=RZHzNF76vicFbD9HdD3cNyFfDayJNjPNAPA+hdOgJn/PM0eKjHCwhQaMuUTp4B5S+U
         r3q3Azj8VK/Uebbl0Kp6VmEU2JQl/TRSnxHCGd57nqKAIi9MO128FfcEqVOhu2HBznN6
         37IhREefrt+Rdn8nXmuoIbxn0tT1RoEkHyhD0Q+yazKfNsAoikgLBJ85OWQUucU48imM
         Sti0AQgiYTfANigQd5PMOdihtUPg+NQ41dmdQ+UZ1/3buSafeUiNmI5I2m3/btjYBOhn
         HKssHx5XGp1QcaxY9/Ql+SbVln5V0D15Ofz+AoTckst9CQhaCWNXzOtIMi429affJDIJ
         67wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866903; x=1795471703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
        b=i2xJpld55n81f0kx4qArjXiPLYz8dys+V38MMeLNE9Zw8MjRJT/iIOFhX1fUPRL/nh
         RnJ7WiR4rxYPXIWMMG6oM2kEy/E33FtRdyxhB24o7HrTqsU8SPwdtG+ieCrVVR7LxOlF
         5h8ju6J8/HozxRNYC9ISGuSMIZjHFL9Oe8ecQeCxQa56n1RDaSw0V7yk6J1P0SpKEK24
         Yp9sdcpL1ajkZM048twPh1x2er/KPpqCaIXq0aHqJoQtekg3f6CaqZRZARYBL6C5Znp6
         XFuTNifSqL32r8ZuQ3kwP+HF1nvgn1BW3f6gxcNdZQ8x0pkHxLuTxpLLK+lKD+iLgAtU
         ZDMQ==
X-Forwarded-Encrypted: i=1; AL+hErGpnukcyIh+zWYBciEgqpk5R/6kqDqmjnmy+5Y0g1c8Jvep7I234H/2QddipHQSd1KU9aon2XU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZB22xDZQoiho5lVMxMa58lIYyYXi6fojLMugDWIT77IunVFjL
	Xf8IX3i3W5N08FKlK7MRTaV1q9/SKHHLHxO+eB76nbTvLcqfgMrEtYPP2Aym7GBOt61zg7iA8w8
	4cWfF6JC/NUdsg9IgA1ZuWtrBR7LVVwSUjB2ypKv/BFXRdAvkAd/Q7Q==
X-Gm-Gg: AYBFou3k5KuXWypFkmFe4CCePM2A21qS8IAYEhBH6Bz75qWMEwqf4fdacGMGUu5Bku/
	+nYfr7ryBfHgB8LVlLdY/ve+dhMH5o2elDfGCVQndJ0zk7mpEi6xFR2nk2/qMustqKR/pbxw0FV
	r87G4NKxEP0vhRTRxYjwyiz2WwKLXEXDYDO+McoX65yPWa/3nw8EJ6REbos4BG+vNZSINrBQxEE
	kW72+8n/+P0SWlC28IpBsKz4dz7+d6fKcS3+9uUXSEy8zEaRmzsmYS/pvsaHuiSvWEjoKKaLO9C
	dYiJ5BKelj5f9c92QDsjrMD+s9sro85eGB3hCvdt72tg+EUBHa5lyUBsvfxHCn5K9T3tJesDWYu
	wLb5d7JHVEsjPsyU2NWiFcAzHVqqnZQu0lqvI7H+/2qXg2brEsfGi/4NDmIR/NU6qKoM3tEkqWL
	wyQXMro8JQstnHSkqB93NZ
X-Received: by 2002:a05:620a:199e:b0:93f:26f6:6bab with SMTP id af79cd13be357-9494bb76ff3mr1959300485a.18.1794866902776;
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
X-Received: by 2002:a05:620a:199e:b0:93f:26f6:6bab with SMTP id af79cd13be357-9494bb76ff3mr1959297085a.18.1794866902376;
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:07 -0500
Subject: [PATCH v3 01/10] ecryptfs: write from the right offset in
 ecryptfs_write_lower_page_segment()
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
Message-Id: <20261116-ecryptfs-folio-v3-1-1aba8e620eda@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1534;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8Nz9Xv25MqfERbysf6jE5yhp7runCvsoFyhssOE8ZqE=;
 b=YSWHWjqVm/aXu2+0BIhr176Uk7LNmJVnPY7NZOSaiXT1hUctM7vw3CitrApYmY74EL/cvlqEl
 8SEBxp2ZeMtDY1Z8YUKXjcIoqKArtu9zOTlq+hKxZQCfnTt5OmFC1nW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX0XXUCzc6WRNK
 ukfu6mpIwcaD+c4XIakRbx4wuP8nouRwNtQBzUS3wN7YamPuxO3288OMl8F6zUReP321D3Nyf+q
 Hz46OVb/xh4HRY+XHENO0qN7X4bgRM5pRPH43Ak26Lt19M5OSVHL
X-Proofpoint-ORIG-GUID: UtjiEkd4CLYcZ94pCV59OEChfUdfsy_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX4QQQrtB1ug6y
 0NohyZsAm/DF8I7wh7p0m+dWF7DA5gE5M5cMLdqvT5Q3DqAiG5V9sufLPX/xNb8zjD8Tw4jCB6b
 pcxha4XdZ5iJ5V0pbR09ibmtw8toneLnx4P99hXpR2YbdRe9H2uZfdYLmk4qiAmc7+WKTB45qgA
 98JNdpuJ/Difn5UsLtrFIFdmTgW3r3ZEVA04/AQ55BaGpO2t1d4bS4ZikjZAfUO1szScMYCEtvm
 DNCToDn2K0WwCJan3/diU+MEugY6dnoEIteBv+eTgtaKCWS0o/erSzwvnWwf33U2CUBDiDmcZs1
 /q9TpZCmZ7zKLLX16SfXwaEdHGS5Bkc4V8n37s1malmatG5WQAmY9eIPc6r7P/7+MmG+/u8k/Un
 F5g+YeqCNSMCylQi9SFR8GbS/kEOPdW60npkxpSX+l6ejoiFjckJK2Yec8lUGG+nryidIPPPyAO
 BiZ/vYs5Anz52hHppag==
X-Proofpoint-GUID: UtjiEkd4CLYcZ94pCV59OEChfUdfsy_0
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7ed7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=w15lwMz24VFeALwmIwgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

ecryptfs_write_lower_page_segment() writes part of a folio to the lower
file at offset_in_page, but takes the bytes from the start of the folio
instead of from offset_in_page.

ecryptfs_write() calls it with a non-zero offset for a file that is not
encrypted, which is possible with the ecryptfs_passthrough mount option.
For such a file, ecryptfs_write() is only called when a truncate extends
the file, to write a zero byte at the new last position. The lower file
gets the first byte of that page instead. If the page already holds
data, the last byte of the file reads back as that data once the page
has left the page cache, although it should be zero.

To fix it, map the folio at offset_in_page.

Fixes: 13a791b4e63e ("eCryptfs: Fix data corruption when using ecryptfs_passthrough")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index b3b451c2b941..e7319216a2f1 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -63,7 +63,7 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 	int rc;
 
 	offset = (loff_t)folio_for_lower->index * PAGE_SIZE + offset_in_page;
-	virt = kmap_local_folio(folio_for_lower, 0);
+	virt = kmap_local_folio(folio_for_lower, offset_in_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc = 0;

-- 
2.39.5

