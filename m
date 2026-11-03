Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711862;
	b=3mA8WOsyd2tUQL7RWHkDUc6MdY6dtCL6ZmYSihGq6mr3UYj5pHkjyBGr3WSdgUb5LSVn
	 /VbxoCGZSMDo04XmzOnJfiLyFAjw7iXwy316YXr/rI4fCsVJxR0YixgGJOa252eYm/E3W
	 XeGSBRIBd8VipQIDSGfWnQUzZtOpuG4qtSVpBKrulLLyYU9hmsTJuG1ZSioQ589v9is5K
	 3yv+hxWZYtNaPRjchkft4OMnxRolYlYY+EI++mto1f0BJ+5q2XgrhqSmbo01t9NzqyJXL
	 7EN6AM9I5U7c4MH9v9jp+wEGky/N19xBFAJT6fsJaneBXpyNZ59e4anDKyZwhvC2MiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711862;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HqFcnPyfzSuZm59WBilsmjvYcFmuJCpEQX4tF4/vjSw=;
	b=S8tiquFnsyFULUk9u7laZaA/Gn6dodeqo3rVaJqlf9MhdUXKtbDnYfEdVk9lV7hUdPKV
	 nMtnENotHqBjmGjPtp0vuyLjKMuFEvrrb5baVMm0oYOBi52uIT8AGm8Lcqqu870puihMs
	 CxU/m4QTPWWtUXvzWZUPxsj3/f2acKgLdElIDuuGy4RkVAq266U2v+2gu5bO0/KK2IwFz
	 T9/5l/v/cCpv5QExSQGIORM2wUTK0fFVW279UBTNGAiJ5dmrWGRwq5TnX4I3RI2P9To/O
	 vVAQW8vc/xsjLPe5lf90oIo3toVOhmYq4hVFOZNpBJEJb0yF3RPW8hmiTsWrTR47U/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=vNxJXHN4;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=4QFHTuLR;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D606A33A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE8D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=vNxJXHN4;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=4QFHTuLR
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A39AmNP601249
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 08:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=HqFc
	nPyfzSuZm59WBilsmjvYcFmuJCpEQX4tF4/vjSw=; b=vNxJXHN482xPl/cjLJOY
	Lio3IkcX8tcrmsiG2Ev5ugRoa6KcgTIgfxQDp91cA2nnfp+HoaoMJtmxSXoxBEIM
	2dLBRyQrKr8v3hQzuRur14cuiufQZObRudXqGqTAu8DQUW6vwslTKhBs2UgcNr1G
	S2jRz5HLeg8xX6TaM5Z9Q6zv5MpmLB8v5V6aovGzAxX//5vMTePCGzo3rwlxIhae
	kYXAtbs0WfLOhE6Wy0hl7+abDFfOnCnwHxNjxIOM/Cl0MAyq7qT1ypaN9D+pSBBH
	T4zDR2S2i++Lo6YqnyB3VoJI8m8rIOGGFkdEwnVJQqvINF1WQLKoh31ixQw5xp/y
	Ag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hqcr912ma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:17:41 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1e62510cso912550285a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793711861; x=1794316661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqFcnPyfzSuZm59WBilsmjvYcFmuJCpEQX4tF4/vjSw=;
        b=4QFHTuLRDO3LmCZX/JN0SRplwjARIYh9He4gmkExQF9rRa/WNzc73A+LcqyaEQoc6C
         BGI0vITi94sZtdco5qBwOTb6PuS0pOoqfD8exW2OxU0i0EUG7mxqf9i9PX5gihHNhOSZ
         k9fAmD5rAHnlGOlqX/j7MzEuG7UdQG1wwSepwWVhA3qL96w+YifirnqrxjEMrpQtMEt7
         reTaRg9oOkStWISNtIPBHkIQGcNwhfL/4ZLQwFnoNRuLjo38cerme+/YFe5ZP9Wmbvk5
         xcnZP5FW/cOOecWEINt1dDjHw9M8s6tGGhhVrvs1thKROpWAkFPpUOvZmq4uS9/GuwDL
         i80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711861; x=1794316661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqFcnPyfzSuZm59WBilsmjvYcFmuJCpEQX4tF4/vjSw=;
        b=ANQEQXD8v+LC50lniKXJHAzfUC03BP7GNGmhN9nW8ClJmMH/59J5NYqO8mzOlxuF+7
         kmG1PU99eF10nKqL6NyiyUD2e6uKEvZFmcD52MzKb+2rYyo91lD+FZ9acbGc433J43Oz
         dXONj4x+doNyn2BRwA6uFKFOTbd5E6D6FbBT8zTySGwTW6gNi4ZN1QzZg2py0okRzH10
         SQjG+51uFBHj5t/uk8pPaBUHnSKtpb9/yeRUEqhGq2OzYXqMsy+vZ7e7Ljqtskocq0+X
         mxtbmqsKkKZHfu9ow8LD4XBozoQ5XcHZBLcvqBrgluOApXze6fF+kzMImwmzHCmKxSyg
         fNJg==
X-Forwarded-Encrypted: i=1; AKwUvBw4udJzaXqSBLIR45WOwQv6Qv5Lpi8mzfuRLjD0dRCzmHLqJeKeY2tKX0tTww49dqVnxK6iUfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/NMf/0Vdoimylk4lTcIm4fqF75UAFgfasRBszVUmq/e0pBP8n
	hnvLaXEe3SXHO/2VbJgwfyX9zZrS698/HV2T787uXpracIIxghX4sIdvCLfWR7WwiDTF8STimrf
	J9iKPjncTBLYtjv6jTMrhgOGemSm2Z00L1SJAr+9KgRGzL30ryfLgFA==
X-Gm-Gg: AYBFou3cXn7blBgpk6z91mV5ideRICi2HppF+lE2Zg2Kdr3BJWYXSiJh0XJrwSPCwEF
	nrw2Zg9xn4eZgesPd+shd7N+TAUayHpXIm6brZ3SrsEdLytrGXl4y292hzWyp4nGOCxmXvqaydg
	rlIJSH8xLHEmq6d+MoU9R3rZtGP3Jsfr9o+Q+HNFhLInJqbzM5fng2SyE5Ni1Wtwp/qzEJZA9Qo
	bgCf6KZUD/polD/wjRS3AJhme8tp5koTDxkAkziX8c5OQ2zboUrFDHE1blupS4s1MrZOr2dUcUg
	tdTjL6dnBYACA3n81KOy7q4z/gQYpASF6vUYye+xb0o+RI/EDV0CWvMIfg3GNCyn0LMldKqfbcC
	F3GP32y7mWqSLIDC/z32qHZBq+cR/Q5Gd1aMHBEkthnNOwnyHmnAplhhJESI=
X-Received: by 2002:a05:620a:3188:b0:93f:3646:7a53 with SMTP id af79cd13be357-944218411eamr2071253985a.83.1793711860752;
        Tue, 03 Nov 2026 05:17:40 -0800 (PST)
X-Received: by 2002:a05:620a:3188:b0:93f:3646:7a53 with SMTP id af79cd13be357-944218411eamr2071250485a.83.1793711860327;
        Tue, 03 Nov 2026 05:17:40 -0800 (PST)
Received: from [127.0.1.1] ([37.142.147.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa5781c9sm62076885e9.8.2026.11.03.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:17:39 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Nov 2026 08:17:01 -0500
Subject: [PATCH 03/16] squashfs: release the grabbed pages if allocating
 the page actor fails
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
Message-Id: <20261103-squashfs-folio-v1-3-7b0fd4d20882@columbia.edu>
References: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
In-Reply-To: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793711849; l=1334;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=efypQrpn/b73zsQU3Coq95Rqi0HpSFUY7KMlLGRCohI=;
 b=NRvIh1TO5PCnhNbCmzYalH3vkmpetuN+RN9XHYgN4rNl2WOHXYiw781pYLY6j2LZqtIbma9/8
 8POCiINEc/RDpp18fKizbLEYX50yD7IQUhnDq2f3Hjw8zY5KCbYq/uc
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX5aLgtszs75er
 zPDXXV4EvuU/4JPVYuTTD3K7rF3ItnettrNVpldildru7V3HZjAD1GnSmYo3wclGi2HOX8Mwhn2
 tbB2tHtDHlUHZAPDvEO2qSkkp73d7V5fUbhPqA+4E53TFh85/znC
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ae9def5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6RgaMXXTExC6Yw++yBnrug==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=U5fOvYNq48yE9kKlttIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX9kJvvOR0rvP8
 XD5KjAJN73HBfKsgru6fIUhdx8irYanQImhlzdh4/DiSCyoPUAeoVcyT4G0eWjzV0bKA3Fs1WoL
 7lbJoetPi77iJAcg0BIiSiF8LX8ZowLN3Hl8/RgAGBm0RYp0afz+pqvzwptqHuM5pV7YFswz+qd
 yOFRce2L1KNHLTjeFR1/xYkSb+OjGKX1TdIbNZlh9HJfX0gkjW0ELCLf3mzZaHbh4uDX90uoiJr
 nkEziRsTSYzUumA5hKGd6LLhAjjeHQb+Vd4JfqmHCcrJy+hQYTMBiLNMYzQ+SmFw0+fxD3SsgKB
 ZoR6F/fvkPcDMCmyF8M+qJZUfK8vOv8Nw3xn3OMkA4bhNudHWXf6zdQwxRKo8lzbQcUIYZaoNsH
 H42mZlP4VhCP6G60v/0mgC/t34zew0zxB+Y7qas8Strl9Z3oYT6a4rINikpX7QOywWyHU5YYNBr
 f9MVHtIyAq1M1oRSwQA==
X-Proofpoint-ORIG-GUID: CAt8-jWcS0txzd31ORhMFunvTdPi8L6k
X-Proofpoint-GUID: CAt8-jWcS0txzd31ORhMFunvTdPi8L6k
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030052

squashfs_readpage_block() grabs and locks every page in the block before
it allocates the page actor. If that allocation fails it jumps straight
to out, which leaves all of those pages locked with an extra reference,
and anything that later reads them waits forever.

Go through mark_errored instead, which unlocks and releases them.

Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/squashfs/file_direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 2c3e809d6891..3b6aa4727c79 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -70,7 +70,7 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
 	actor = squashfs_page_actor_init_special(msblk, page, pages, expected,
 						start_index << PAGE_SHIFT);
 	if (actor == NULL)
-		goto out;
+		goto mark_errored;
 
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
@@ -118,7 +118,6 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
 		put_page(page[i]);
 	}
 
-out:
 	kfree(page);
 	return res;
 }

-- 
2.39.5

