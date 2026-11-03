Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711859;
	b=5Xp9Dc5QQ5Tv7TsKEaz1AtAqgTkiCsH3fqgnypPX5+PurwexdtM9l2AGYRWVjoAqxSJD
	 vlqLAW4ZEceIqgfW2MfsyLpTqvJBe6kiskNlyFdb/dJ1dflFTY+y+npuq6mstIb7jTO+x
	 yU2fYV+9b555JmbjnzWEhf5PIAjZdd7WojLhwOH67+Zfi4TD0LNlmvcLVgT+PJcLBvxbd
	 cW3YBv/vZWHtCQTrDPIB5uXx6hdzfHVPgxoiZg2aGdm9qgsmtPsHVbvVDns9uOjAFGw02
	 Swqc16eFWaVIBE68nRNj/DowqSpDGd+o935kOniF0RZWJtTF9QX9TcLqhQv1J0+ZJeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qYSxn1XfiaP/st3a00FEfiZHOq3MU227Jvp9fdcquiI=;
	b=bpkO6gr3fYEP29YQ3T86f5Mancz5TfMi3FK/UQghCPePjTIGGMxqPuDN3fIZBUmckOtg
	 r1pyocB7yUyTUN/IfROyXBBfzoUDHcv8ZfMi+maAS1YQ3Mcbb432e93l2rYDBwSsSLr6o
	 KTFdq/cI/gdr6aQcZ52eEx+wXV5fLmIiK32+3/YejWBE7i0943+m+pAjL1RvkBdSXgx4p
	 V7vqzfW/8lKeD8f5A0APNwsA//cu4BrSSAij7iyMyAUMz9SIk+wkhXtZapNda6WDuW8cv
	 O9A0R59EcEg+98NLi8BKRWq0doKn3H/90L9TRRaUdSS/xyu7baYwvJT0IEUFu0bd9Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=DdnpZctt;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VdraNgxe;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F488606A338
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F488606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=DdnpZctt;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VdraNgxe
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A390CgO523888
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 08:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=qYSx
	n1XfiaP/st3a00FEfiZHOq3MU227Jvp9fdcquiI=; b=DdnpZcttVgUflw2w7IOG
	hUSthiZyMpb4gAm6xk6W4B6SM7aufEWTOAKbLeJZoQ40uHMnFxsuiFbjZsxufFVq
	wehTR7XjN+SQVczywDhmyx1kDfY2gA00sZE3gkMjhl4l8IYfUt0yxS4kXJek8VA7
	jRx40QzIJCKYqyNv6j8Q45WXC+kXYSRBvVCe0/M2Dmv+tNEXKtkaXnCaeTXajSCR
	YO+BtZ5K/8LkESX2JA3XzmKaUyiFcTqwR+32R+8QdRO+qRoYSnLY1YryXvp+NgPY
	4mDpXB+YpZ1VP+xdyyKuTGEEO4aIUr2+cI1b+87ebZfEePMM4NdyjVNKPy2hVlGG
	xw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hqck8s5n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:17:37 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-944138ed63fso661070885a.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793711856; x=1794316656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYSxn1XfiaP/st3a00FEfiZHOq3MU227Jvp9fdcquiI=;
        b=VdraNgxeJQng5LaQGz+LcVlVu+Y/clSZYEjkdRVhk599/W4pHqQFt29Oh4ZDsUStPb
         lZg0oKVCrgkh8pjYsXJxdSQzIJs9vdmZq/U4bvuw7RobIOyPShrg2Z1EzHWgXT8qL4bZ
         w/dr2PBldJFgXb7dQJ5QDanvLWP7vcSrRC93xjJsg2qSKun93N+A5b7NRXfnwP4MzMNN
         lAi1/keWSCPe2Cr/igtEb/cObpjf5UlzofI/KnRLIX1/gV40iIKnmS5eSnG+tXs0HSzT
         vgqYdn+hPJzv4B4PpUgaih6MCp9ZrM9PS3GSKFmlGMiZfKZXsH4MTca0OXwXsvMuD5iS
         Zuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711856; x=1794316656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYSxn1XfiaP/st3a00FEfiZHOq3MU227Jvp9fdcquiI=;
        b=yuY4gZZFTpfKPkwH0oj2F4FITD4uNPD4LdxvhCQUJOHK8/cfu9YZM2lTDvFlUmQBWC
         UFxZSKlJakqhMgOPWZtU8rmAA87hyvEDvzfb/q1Ns8oehwNwCoUHzWj9LK965HQzmgS3
         vMk2x4R5EY9kJZM/YDWOcTLMcDZKq7hs0a8HrxwTmwGruqbHZr/BWOXihZzhY6orY1vW
         tamBukSaAwqOTRPfdMcUpWEJb6Qb0GfsuSWzDfWBo3wbXDT1CsyBbdjxXMYE6dbPCXn/
         Haun0vFZjgW/k/LJbx3RbtDqlhDN9vjP/onitbyDYgDyeLBObav/1d3Rfh+gZ2BhRAyF
         EB0A==
X-Forwarded-Encrypted: i=1; AKwUvBz2fy9zfeUV35d1LWj6BfL3w2yMw9UqbF4C9Q8QrtYuu9Gygwp+Zr36vmNYLth834LJP+yG/p4=@vger.kernel.org
X-Gm-Message-State: APuU4Z//20/Gg7bPgAd1QGy/o5KYg43cDNx0bnaZMiN2wijNa2Gf5xoy
	kBFSxWSkwdyY5JvpuXnzBz+xIG1LrO+GYsLwbpUhV6H22S/aqkzotiHhACfyIo5S1tpGyj9mtC+
	aLKeP9R7HM7ftnQhlj87lQA7LKGTNWgyaXIF3vwmUdQFZtGgRGsvrLA==
X-Gm-Gg: AYBFou3SnMCbB9lsH1OMfkjiw1J9/NNy4zc8RjkBhtFWpTTfw3y5YNCtKWslZFErmwV
	lTcymd3ygCUBKgyXktj2l5MyTFiyRy6cpzSsXnzEdSGQLETYfRXzxn0DuKeGrvkCHvXG2FgeQ59
	US5l6JaRnKgzznMqHvdZhf58KvwP7vmwFzWUok9rOxGmGzwRBqJ976ARj5cmItH3KG8lrAmjI6t
	V7pocMq+mi2b1Wqd4JQqpsiM2EhxYRUwwyqkcSP5pcs+EjbSol1dhi2xFOIKMSY/p65/yglXtHV
	KtD9omY6r7IbFPEm0Ck7o/uEunkLRQsrHwBCCf4WxYZij54p2QXjP8Cp2Xg10pl7UCmPqATLHWN
	7bqbMgl12D/Wdiv0HdYnnOB77jj2WCIzWoadtFql2+y37F82m+O+60Io2hIw=
X-Received: by 2002:a05:620a:318a:b0:93a:11a4:223c with SMTP id af79cd13be357-94421585ccamr2029616685a.9.1793711856496;
        Tue, 03 Nov 2026 05:17:36 -0800 (PST)
X-Received: by 2002:a05:620a:318a:b0:93a:11a4:223c with SMTP id af79cd13be357-94421585ccamr2029613585a.9.1793711856031;
        Tue, 03 Nov 2026 05:17:36 -0800 (PST)
Received: from [127.0.1.1] ([37.142.147.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa5781c9sm62076885e9.8.2026.11.03.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:17:34 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Nov 2026 08:16:59 -0500
Subject: [PATCH 01/16] squashfs: don't truncate page cache indices in
 squashfs_copy_cache()
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
Message-Id: <20261103-squashfs-folio-v1-1-7b0fd4d20882@columbia.edu>
References: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
In-Reply-To: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793711849; l=1892;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hhR/0qFXTHIEAAk3wh6pERZ7ESuQx+zeS3j5JBZjUqs=;
 b=bQLgA9Sj6NYRfiZu1hAhI/T/7HnYWMH7y2gf8Kc4NWiullWkt9QZ5B/Ebd1nqWfqI4Yv/IZ6q
 ucYYDIDV9cSAx3zKTMkx1jCU7iTAs+BIL+Ci0asoHImWlnVQ+gMBggP
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX6eGtDaNjj9wT
 wC+l7dFIdAkoIbX0sQ0uXMNAjOCRdyyQP2ZpcOZ1sNg/dlwCBOo+QzaOJebcM5XJyVoDRUqDYy9
 DK+TyowV5R7KBRptjhYqEGWfKILWPENsgVeLi472ccZP6CVYOErw5qxtnMYkm9z103pC9LogL6u
 AaBvSr0/XUcmnH1NuKFv0srpQC1V06HTUnvftfJoj7kriGxgyVKZS5Ch7gwRWjlEX4TL5GL8Ias
 xmk8FNpMCZcI8UNB2KCYDjozO69RAjPr2pcnng4quWwe6eNHui519it7IKNGG7Wetm1Hn0MmC3j
 pa5DHQlnH3yBhE0sTTzJuetSlQCX8i/3DCbPak8383VEEUPr4EInKPwmtt0Vl3xTNU8NFHUdCoM
 QvMDuBEXNFBIibcGlcAPWZgYmurp7GygE/jnPJZTTGn2tw12Qi6YBvB4kgz6fVwx1FC/kBFe5oK
 5U0icxU3M1sOsReEyzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX1N6ftI8PcRzM
 UXXAWBa4PFOQ/W2TKr0bHIC18CGhXzppth9WRLpUxAsrbiZjvX722f1VEETHauoyt9uOI5SOZFV
 rZxIXkvOor/v5JcDOCa86l2MxmTKy0ORFor8YSeBVQQM275x8Pe4
X-Proofpoint-GUID: LD69th7UH-2p3oZAj0aNv0zeNLnuMn5_
X-Proofpoint-ORIG-GUID: LD69th7UH-2p3oZAj0aNv0zeNLnuMn5_
X-Authority-Analysis: v=2.4 cv=LLrz05W9 c=1 sm=1 tr=0 ts=6ae9def1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6RgaMXXTExC6Yw++yBnrug==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=0xRz-ObG50yOKxxSkZ4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 impostorscore=10 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=10 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030052

squashfs_copy_cache() keeps the page cache indices of the block it fills
in ints. On 64-bit, once a file is past 8 TiB the index truncates and the
loop never reaches the folio it was called for. That folio is never
unlocked and the read hangs, and the other folios in the block are looked
up and filled at the wrong indices.

Fragments and sparse blocks always go through squashfs_copy_cache(), as
does every block with CONFIG_SQUASHFS_FILE_CACHE, so a large sparse file
is enough to hit this.

Use pgoff_t for the indices.

Fixes: 1701aecb6849 ("Squashfs: regular file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/squashfs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index d83594ce91d2..9c9a437ab118 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -396,8 +396,9 @@ void squashfs_copy_cache(struct folio *folio,
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = folio->index & ~mask, end_index = start_index | mask;
+	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	pgoff_t i, start_index = folio->index & ~mask;
+	pgoff_t end_index = start_index | mask;
 
 	/*
 	 * Loop copying datablock into pages.  As the datablock likely covers
@@ -411,7 +412,7 @@ void squashfs_copy_cache(struct folio *folio,
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
 		bool updated = false;
 
-		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
+		TRACE("bytes %zu, i %lu, available_bytes %zu\n", bytes, i, avail);
 
 		push_folio = (i == folio->index) ? folio :
 			__filemap_get_folio(mapping, i,

-- 
2.39.5

