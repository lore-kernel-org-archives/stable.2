Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681563;
	b=RF/Dxl+2DWLA2ZtZWvAAeyVrHESKdFygvIqGE1tOKSm96OlhTTV3zW27FR0omkAcyUJv
	 cwL8NhaFYqfmnEfcIDOBJBvhAbSAnlGSAgGP0vKVIz/QBsQGPFnatKP256L+3LlpFlp+H
	 FJDh3XDlXsS5HmJHynXa3a67lJ/BE3m7uIsDJQegtdpbh4RY0C2HhEyA9d2dMe4kXpkEz
	 IUYn73eRq+NTR1jPEm3Pyx/fSz84JExHUQ7yEzlfR0j5TSFPVX2wsC/HujTBwFnAeOhRv
	 l62N30DnMPUEoVn8YPbICC2zpEJY4dIvnN6MS4VdEkPhOPqumBuzrYXxKfK/5xfQADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681563;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nMb0vrZtB0rCGRBMD5Szuw+BH4dPouiVXcf115w+KNw=;
	b=TsGPmVmE/VutoW3pda6aj78+B1b8hr5/5quH5KMOxj4w9eood8av/hYpyeq+COpmLyiZ
	 PbFktUo92q9TLi5KzXnffQCqt9OwwLxMjTKUPGfL1zQRd30ONdUqkYBQzV+TKuhCzxIg/
	 kI3baCRnMTAyO+CumMNctiFcuCWOXCc776P5NnpQLnwP9+pAtuvISK8Qy+xJSF1VpTw3u
	 a3qb+goVvE4AxH2e0PzbWAv3kAVg2TVEHvkfqSqPYpgl0slA06A3BGr3LcqTpN0LVauMu
	 8godKktxVZExXs+8jprMN8ODjMqSAF1h+9LBLdV/6XnQ1pDpKjya60upSZSVHdA2hNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gGjQAK0S;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167E606A31C;
	Thu, 26 Nov 2026 08:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6167E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gGjQAK0S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nM
	b0vrZtB0rCGRBMD5Szuw+BH4dPouiVXcf115w+KNw=; b=gGjQAK0SchH66Xv5cB
	IH/SNZ11X5xwvf4qc/a5r+NbwdiYfmdYEPP1Wg15lsz66K/fzfuAoD3kC8mUyJzk
	oVatuwLT2DJQA/X2mMnk8+mLh3NUdpMqLBy7/JQsUMnklfqbB9Yq1r0bo4C4qiCh
	0jTd2Xlx6Nf0C50x/LY8Syahw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v6L57Adr+2gWKg--.36520S2;
	Thu, 26 Nov 2026 16:25:30 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: dayou5941@163.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	liyouhong@kylinos.cn,
	magiclinan@didiglobal.com,
	song@kernel.org,
	stable@vger.kernel.org,
	xiao@kernel.org,
	yukuai@fygo.io
Subject: Re: [PATCH v6 1/2] md: use work_busy() to flush sync_work in stop_sync_thread()
Date: Thu, 26 Nov 2026 16:25:28 +0800
Message-Id: <20261126082528.191484-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261126080830.144525-1-dayou5941@163.com>
References: <20261126080830.144525-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wD3v6L57Adr+2gWKg--.36520S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUnVyIUUUUU
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+RoWxGsH7PqZhwAA3V

Hi,

Sorry, this series was not sent correctly (the patches were not
posted as one continuous, dependent series). Please ignore it.

I will resend a corrected v6 shortly.

Thanks,
Li Youhong

