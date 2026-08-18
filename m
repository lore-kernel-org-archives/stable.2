Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2E23D7F0;
	Tue, 18 Aug 2026 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028440; cv=none; b=HWiucZzIn9Dfxn6L+HgSr9dTL9znpa26Q9Q14niAzT9m4CyYqMSXGY9lX1T0494qr1XtsY3hYqnteeNWL2mo2HJlg3/ii9iL6HVS/2FLRAwephFFg32fxcnec+61RRKogRFcpgO6OTKeSPZUwwEEvlB4ERqAGNgZxq18s6jm1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028440; c=relaxed/simple;
	bh=gRV8QeQ74Po1bVon06AJq4OjeL79GNP8cm9tv8PnsrA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gxGFax7aJUjIDRRx1/axwXbPn01YC81TV3nwzeTAwVrKqCGyHAqK2Ftpw0owMrdaZrBDMzYhFfH4UBr0Kn9YbaVJT0watY34b36uk8mCezism+LSmWbeJzOqJ2+ajcRVW5K0pUazsRvnzF6lcmys3MKoPEy4EzznODZ+3PBRFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JlMsbSRl; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JlMsbSRl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=McZMtrUa3hzu0hmypcB7NhE1Zyyi8suts0Khhwn9SGU=;
	b=JlMsbSRlu4gGhwvCetSIAp9Ez0mXGF5lMdEZG9PDhnRs/GdbJEcQGtGF4dbV1N2N/Mlrjb/Jc
	OLCMJfOh7NZTl/YOqzq0DO/mXKzWfpmffMuiHjTmrh4t+XGbQ+at+yoeTCLZAwpT5fsw/kBs4x4
	ruWAdsRthoJzEm7TcbdryEA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hPH2s4fBjzRhR0;
	Tue, 18 Aug 2026 12:36:21 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 61B4340561;
	Tue, 18 Aug 2026 12:47:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 12:46:59 +0800
Subject: Re: [PATCH v6.12.y 1/2] mtd: ubi: skip programming unused bits in ubi
 headers
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	<stable@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
 <20260818-ubi-backports-v1-1-324d6816d2ae@atmark-techno.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3fec694c-386d-2227-fe72-25e2c909a5a4@huawei.com>
Date: Tue, 18 Aug 2026 12:46:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260818-ubi-backports-v1-1-324d6816d2ae@atmark-techno.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/8/18 10:09, Dominique Martinet 写道:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> This patch prevents unnecessary programming of bits in ec_hdr and
> vid_hdr that are not used or read during normal UBI operation. These
> unused bits are typcially already set to 1 in erased flash and do not
> need to be explicitly programmed to 0 if they are not used.
> 
> Programming such unused areas offers no functional benefit and may
> result in unnecessary flash wear, reducing the overall lifetime of the
> device. By skipping these writes, we preserve the flash state as much as
> possible and minimize wear caused by redundant operations.
> 
> This change ensures that only necessary fields are written when preparing
> UBI headers, improving flash efficiency without affecting functionality.
> 
> Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
> that continuous program/erase cycling with a high percentage of '0' bits
> in the data pattern can accelerate block endurance degradation.
> This further supports avoiding large 0x00 patterns.
> 
> Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datasheet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> (cherry picked from commit 77530d1a78ca5c274e37d6494a965223672630b2)
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>   drivers/mtd/ubi/io.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 


Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index a4999bce435f..915eb64cb001 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -868,6 +868,8 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
>   		return -EROFS;
>   	}
>   
> +	memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize - UBI_EC_HDR_SIZE);
> +
>   	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
>   	return err;
>   }
> @@ -1150,6 +1152,14 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
>   		return -EROFS;
>   	}
>   
> +	if (ubi->vid_hdr_shift) {
> +		memset((char *)p, 0xFF, ubi->vid_hdr_shift);
> +		memset((char *)p + ubi->vid_hdr_shift + UBI_VID_HDR_SIZE, 0xFF,
> +		       ubi->vid_hdr_alsize - (ubi->vid_hdr_shift + UBI_VID_HDR_SIZE));
> +	} else {
> +		memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
> +	}
> +
>   	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
>   			   ubi->vid_hdr_alsize);
>   	return err;
> 

