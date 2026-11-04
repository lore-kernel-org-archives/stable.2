Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771534;
	b=5NB3SY9Aq6E+QfXWZVlP6QJXY29LCyXGV2Sw63gfKNNqY5TEnTKCYZe/6S9+IUhlXNsf
	 V3vrUVjXghWkY+CU0BKanwk4rP1vtAYn1lQRGZv2Y9qUo63Q9v3QqYK6SsAd5XUy9ft1w
	 VTNoLlhkzZ36Q0TWYDkEMuTiSRT5gT2QHlm4J6cCSfQgLyyur1gKr6R9teWoU3ywW4B4V
	 TNFrRBVvkYf6OxggCcrUdNmVW1p05Njj5DNIkuEYLkXtSUf3zJ+5CcFLjbYktL1H0/Nnv
	 +0A1saRa3vFftPadaRQVGyX4D6q1e4LVxcFIk0cS2AcergY75O2pOujg/0jxekr102A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771534;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Subject:From:
	 To:Cc:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=FEL3mXotpxi5HHOSmxgKhXNsm0CX9l/laMH07CuMMUo=;
	b=IwNyjB2WOzRsZL/xvvEDJiEZhQiIUNL87Fg1xci2AO1YMQeh22B4sAnGpjO9rQnZ05VE
	 QAIfna6R7dj4eHTvSDIWd/jAkUd83OGrVWw7MCAmrrT3Bdx8mb2xXC+Ba5FcbzHL2c7JZ
	 MgTGtWrGlvAWfugAuQPvmclxdZtOjyLw5zu2ImzHA2va/aGn2Dw6f8tzsz9n6epPtojwo
	 ftwpsSMDsRzwrPyp9YS7qFPzY6IRkTgEAPDcSwlgAyQdx6S8mOPRkxylOlz/d6lJ/+Puj
	 OO7nmesb6QKU8aawRFfK0+C+LTVexFI70+65LHEkRDdVhvyt1SzKTsyBXwJjfxao1Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bvGAf9IZ;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB88606A326;
	Wed,  4 Nov 2026 05:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bvGAf9IZ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793771523; h=Subject:From:To:MIME-Version:Content-Type:Date:Message-ID;
	bh=FEL3mXotpxi5HHOSmxgKhXNsm0CX9l/laMH07CuMMUo=;
	b=bvGAf9IZqobk9Gj2nomKD+15zIKLt6poHw1eohrizPk5Bbo8dyKf9n8dcVHG/ytGgstthm00zzbou6cqrowhiq2W1VzUKng+Hj0x4Wvg68Odv3qFfFDp5ObLCHVcTxX8xn6LDzxYuwDRNWYksjmdQbP47p4Z4pCtUzyQILNIqAc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2686238|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.151568-0.000737019-0.847695;FP=5172841553863036793|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jwNFjaz_1793771522;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jwNFjaz_1793771522 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 13:52:02 +0800
Subject: Re: [PATCH] spi: ljca: Don't require data in write replies
From: Weibin Liu <liuwb@xiaopeng.com>
To: Arpith Alexander <arpith99@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
    Lixu Zhang <lixu.zhang@intel.com>,
    Sakari Ailus <sakari.ailus@linux.intel.com>,
    linux-spi@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
In-Reply-To: <20261103131435.21838-1-arpith99@gmail.com>
References: <20261103131435.21838-1-arpith99@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 04 Nov 2026 13:52:02 +0800
Message-ID: <179377152201.4085956.16301164342682506589@xiaopeng.com>

Hi Arpith,

Thanks for catching and fixing this. I missed that write replies only
contain the header, with no payload following.

The fix looks good to me. For stable, it should be backported together
with 0fe4573c822c.

Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
