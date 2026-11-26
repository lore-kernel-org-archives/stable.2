Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681621;
	b=0xrqEoS3S+XvDYWJrLWda+CIjhEAjlj+ymEodYPQGnsIsv3JRyaKVJNOff8gv91EIxgw
	 dlC0rJVpUNV8FkOsBRXYVxM/PcMWaXK5j1E9HfPY7iBeAGuAcwlBuE1HJEfIYtxOKzQtT
	 rH4AcKSMklX2VwQmSNjwdoEG4BLJwYy0xNYgeFNh84QKAtjpSKfxdocm2WPYbXadoDK2z
	 rxTqc3G+bNABL9zb1QkwyldkbPvM1y6W1vnxAY75evPsa38R878LhysaHdcUfzuDRXThB
	 1ImZVY61phHX63Rw8UIwVctg4xA/qOttkbzfAkHpvPemkI0WmA1CYjcONmksYYMI9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681621;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nMb0vrZtB0rCGRBMD5Szuw+BH4dPouiVXcf115w+KNw=;
	b=v3jl60/nlDFXHhI2orjthBJiLgR5FzCcsBXVqcXzBxbwfpApoMGrqGi2MxZ7P46PyZur
	 E/q5tGaFq62lJ4SStgSpxmMInNc3RqvO06ma+5HPHLFN7FaBnZkp3OYjJQXmpewrMXIDE
	 RAitgjbLRkiItKRwGsTWSmc3KcUxqdFZLTADxt9vrU1nTn2gTHQ/H5cfDGI7IRCj84mym
	 mpsCwZ1wvFsl0iC/R2yWDJp20ByHI2Fsgfz00f1/AP44KJNpQv3EcwoXVb7TlhbyfMjBO
	 CndhKcKmwBGh1x2ADqMMVNKW4uD0w8F/k3pEB+dn0eRJhGwGPtUgnorS+SEfLPx8X+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c1UESQdY;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87791606A31E;
	Thu, 26 Nov 2026 08:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87791606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c1UESQdY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nM
	b0vrZtB0rCGRBMD5Szuw+BH4dPouiVXcf115w+KNw=; b=c1UESQdYYdl8ML0ayl
	TR1i+ed15Q22nTaEcsNSQPkwVb2Wi6fHLrtoBHsLjxR+nDOcveoYsIuNi22n+1JW
	+uMgvfbLt6dC5+rFpIUdgMRbRG/KFQGF+x5yVOeaCfewDpS091+deDSqVUP+Ua6H
	qssZZBQGJ5+Ipfczff8r+NI4o=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn7+Yt7Qdr9WuKHQ--.46746S2;
	Thu, 26 Nov 2026 16:26:22 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: dayou5941@163.com
Cc: agk@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	liyouhong@kylinos.cn,
	magiclinan@didiglobal.com,
	mpatocka@redhat.com,
	snitzer@kernel.org,
	song@kernel.org,
	stable@vger.kernel.org,
	syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com,
	xiao@kernel.org,
	yukuai@fygo.io
Subject: Re: [PATCH v6 2/2] md: fix sync_work vs array teardown races
Date: Thu, 26 Nov 2026 16:26:21 +0800
Message-Id: <20261126082621.194246-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261126081030.150032-1-dayou5941@163.com>
References: <20261126081030.150032-1-dayou5941@163.com>
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
X-CM-TRANSID:PCgvCgBn7+Yt7Qdr9WuKHQ--.46746S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMUDXUUUUU
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+g4j0WsH7S4yjwAA3U

Hi,

Sorry, this series was not sent correctly (the patches were not
posted as one continuous, dependent series). Please ignore it.

I will resend a corrected v6 shortly.

Thanks,
Li Youhong

