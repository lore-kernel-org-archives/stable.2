Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711865;
	b=aZXDxpsKtKimQVzujyPxRAjyw2BQNmzUFxh9A4kME9gQtQj1V+FFNYiVSiC4A/EVSsYa
	 suHKZfSEplzz6dhOr+HjHUVje2kHl2ercwhwCVkMjT7ErxJWGWlbSBofAvb6da/TP6RKy
	 ue40xZDkchwwf783kFeBhLf72M6ELqZIx6Jmm+2WmXoZjrmLyu8erL1/3vA1jEN/tEZNS
	 H6pBahM3IHv78YOCvnB9UyeT0U/fYoak1dEysaxtJYNmMO+r8kFm9Nrx3pQlI/8YEc6Sl
	 ByHQArmNESOML2KQ8sp3Me5gkKC3BxKMptEPnmbgkL29xlvKkwH4sn1Dd2bkA+S+RvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711865;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Evq2lpNudnk1p1TXZ3KYNxtYQxFdhcIBXD43g9ybkPQ=;
	b=EKs//VS4bq2vMP8YQhKt519oq4VxpRIUiMYLSrCr8ty69wct61NUMhMOdLN6vowlxOc1
	 mQtVs4VwD+u4qS3UIsuB7TW9VM/TlDg/+d3v+gSX3ccY46DgEQAVx/BEwfPy0B9QttYHm
	 bgdJUDVLtWB6hneCY70R7ERy8CLIhOZIZq+lsy7+ziF55MlnftfVOGWUtrF7YRVIPbesf
	 +ea4Nji5jEJKsklESfy5RU5WDIYX/aRcH+pwvvrwoFz20NrqjcT821tdrd77r07fFd4MN
	 7I7Cw323CkzhmRVlcOF4mM1xuLz4wL/KYVyZMSjY3Pww0dtiGymvEDG1a24C4GzqpOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nrxtbiu0;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=w9Tueeiz;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83972606A33D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83972606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nrxtbiu0;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=w9Tueeiz
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3BI9e53443642
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 08:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Evq2
	lpNudnk1p1TXZ3KYNxtYQxFdhcIBXD43g9ybkPQ=; b=nrxtbiu0L3sL36qsWerf
	TiI+S+hg+IX4wp+hOozVrm53VOCF1Z5etVAXYqkgF6/BuEnAddqWwRnZFkAtG9Rr
	7+41Ku+25TSE9mSbj+BEBywSnRWdo0A0Jn7zN7bgBFLdEE8a1i/4hpqECUsOxP12
	fNFSFFMzG6cKvMkTOFQlYWLzcmee1VFNJhiOlc2pJq0WKXN3QE0PnEpHgp0gBZMy
	A0SxcHk4ZklS1xsI9yXGsY6zYgTNbSO2zP6GVIvusLYISpCM0j3BLBipxmL+Ybcs
	6CjruEg2+CcTEWJCELTl+xXAwipcllYo0tvsAwmQLVS41xd2Www09zf+1hxpx2Ql
	aA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hqem8rrsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:17:43 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so539259185a.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793711863; x=1794316663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Evq2lpNudnk1p1TXZ3KYNxtYQxFdhcIBXD43g9ybkPQ=;
        b=w9TueeizAdhhqfm4n1YBFn1m6fqAWFVqENEQwc3xLbWC4UxEVrUPi0JiZRgB8RSX+A
         dqnlB60B9umIl5+fr8trOESHLK7BgC1Koi3qdg4Pqb0y9/FWdQgnxn7TKqTop447w/yd
         yCx9Kaxo32lXS3gn5qsYt6wAedaRIpdgLgZvAgCVkgIBLPBoNtKUUNuLoSHHulXhhtXk
         34wkfUsIyG/+0RJYCWt0NDScYmEI3gPV+lAb8m6wU3XAQKlbWnm80XSWA8f8tSLAE4k/
         mGnhZ62w2GWIAZ1NVYs76MuX0eBkFyADYxx2WeMO7S1B+AetI2Bd9czT9dY/sn04k+gn
         0RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711863; x=1794316663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Evq2lpNudnk1p1TXZ3KYNxtYQxFdhcIBXD43g9ybkPQ=;
        b=zGPQT37Ycnq3FAWYZOoWZJ+g7BBqzj3LWUjUzxnPpwzmiH+4g4M4Of7jCSGMB0nwZQ
         V1NwufTjNSQFUHKOfOaWKK3FwJBT1i1WVq+gNin6J0/heAeq+Wsmbd6nkRYrcbW3GitV
         JztZiik5KtJJKsKQ7PXuojHzG9DB2cYJyPFsDW149p8yHlUUUrIsOlMCI0xzUSQmzBcy
         jorDbSeHyzySs3N5xtDgwVuV+Jd11OEa9kzddvsCgHE+vnNyJtpZFJuh1guFNGayHtUy
         zp6yeAl3/3n3VJPMNb2JT2gkuzezDZxb9es6JgelFFattlwK5z7Hn2dpnpan39j4sLac
         IWKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuYUQaJn2Boj/lxXiYC8XqBGIZF+XYWlf0CUxqPRP52TUXmn5G2GRaZGiUnh1WtYWG05YxXsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0WuDNdKpY0YPPbzMD6FLN3lYw/rQHy/GU6/Aqt6w6aAFuSSz6
	peKt1basZacSueGZB60v4WBaeQMa9vtk9uWXQCE5lH+Fh7J/vK5zuMoxS960tnM9EP1G+OHXBGU
	MPsK1YXCREAr/vCDpno9qyz53uTwDlptt26ud9LYV7oZ4r1tyv1Wspw==
X-Gm-Gg: AYBFou3xiIM1GI+2Ot07aozJmGBW5BmbCbTS5O6adKwoFRGuqK0NL4O/r3EKZ40Xi0e
	OQz2ojQ+rzpmHRbFNdXcum5cIfqQn4THW8Km9a+WSJe4o+GTfKS8RAQ3wCdYVnXmJx7Ajbdo28Y
	rTAETSdIiK4huxxvMLNRdpAPxSB5+f2cdRiutjTSV8ZUqqn/zYed+mrbMkysdWfmvjOPAm4zaU4
	Wv0yWrYRrNd+lQpGTKh+a6Uwg1XMqs+TSLaUHIUHOOKnB3xCbvShP5Pp2aS2wyYMilknFd0ZiPp
	6rhzV0uqmlIhx6qqUhdkSpEUOsBBeGMbKUnkF8TRs2JapJFiDipN6+6wpbjCkwg9pLWhuJmH9mb
	d/Y7ffBjBUJl+9JcQhDYOiDvAeQqYiv8w3qr7qWFhKUfUeb8mLSl612MhkaA=
X-Received: by 2002:a05:620a:4554:b0:93e:c12c:fbbd with SMTP id af79cd13be357-9442173e18dmr2154158085a.74.1793711862795;
        Tue, 03 Nov 2026 05:17:42 -0800 (PST)
X-Received: by 2002:a05:620a:4554:b0:93e:c12c:fbbd with SMTP id af79cd13be357-9442173e18dmr2154152985a.74.1793711862287;
        Tue, 03 Nov 2026 05:17:42 -0800 (PST)
Received: from [127.0.1.1] ([37.142.147.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa5781c9sm62076885e9.8.2026.11.03.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:17:41 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Nov 2026 08:17:02 -0500
Subject: [PATCH 04/16] squashfs: unmap the current page when a readahead
 fragment copy fails
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
Message-Id: <20261103-squashfs-folio-v1-4-7b0fd4d20882@columbia.edu>
References: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
In-Reply-To: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793711849; l=901;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=JdHbbHapsRjUb5jusXJZZoQo9MvBbLc8LAh8m6v74RQ=;
 b=5iRCbp9B4ykxXTywrUiB38L2gtu2+iVHmfeoTyfkUFQClJmi2FDW15t0i37VVE9/xBFprrGpm
 Gv2Yq0BDJd/BYaRDrjOIeYW34fEzPcWO8x7021uSJ6KbOr+5bPy7orM
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX3yA3YyKBNTLz
 8yCEU5k32VtX3/2ZBBpDmYpq/A1q1lZA7zb9deC3mwPCcF7C63MH/KpvOUZA+L+PMEhsoNl7OSq
 xGF4XFLOPXjbNV4Wt3KBPcgI0eEKm8+h18ULsTSP/9yiTFMqeJ2A
X-Authority-Analysis: v=2.4 cv=VYdir1p9 c=1 sm=1 tr=0 ts=6ae9def7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6RgaMXXTExC6Yw++yBnrug==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=Os-_f5rAaVhnqpJF2OQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: tqLPHvbDrsLDUykWA5fhVwmdKUrnVyp8
X-Proofpoint-GUID: tqLPHvbDrsLDUykWA5fhVwmdKUrnVyp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX1nnACSgvYVYV
 pJg6LAsGZyMyD+zPilwLTmPSgvlAs/RWyD3d9k3TaIkFV8Ulrp0FNvTqrXTmjIsKpUSPfcKDa8W
 /FjJxFurGdVwhfcmaose4hCW3bImOfbHgkmkFpqYOuKu5XFh+lfYD+pvt5gU5QnC2yXJQRLxw38
 NHHV7YuoGiH42sU3470ZPaMwymYATJtHFp5BT9hkwXqIte9CRSubibOsbzeRTrgPx1lyNAQpm1l
 LFjJmUDnjCoAQOkntoBnudtJb6P4AVQ3qFUd/Z2PiZa96tsXa+7VsWj6Bo5pzKoHadBPD3PWoMd
 BOdo7KlStAM4eOmMA/On5/6oSjSNEUzAP1OnpS7twnx9ZPz9K/r4q1s2kgnJA97Sd96MLRUk1MU
 bAbda5OnQLhBvlh2ODdkfKolAEnjnlj8Klc4LD4WcqS1RFYXacs6foWHz3APaM3EQIh5niCAgpU
 GrkB8Ms5GvLsMBi+biQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 lowpriorityscore=10 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030052

If copying the fragment into the readahead pages fails,
squashfs_readahead_fragment() frees the page actor while the current
page is still mapped with kmap_local_page() and never unmaps it.

Call squashfs_finish_page() before freeing the actor, like the success
path does through squashfs_next_page().

Fixes: b09a7a036d20 ("squashfs: support reading fragments in readahead call")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/squashfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 12263ec8494b..39142c4e08c4 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -565,6 +565,7 @@ static int squashfs_readahead_fragment(struct inode *inode, struct page **page,
 	return 0;
 
 failed:
+	squashfs_finish_page(actor);
 	squashfs_page_actor_free(actor);
 
 out:

-- 
2.39.5

