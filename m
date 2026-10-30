Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381800;
	b=V1befBphANGs6DpsWoFIOMqujJ5rqqFLVpjS7lqLJ8CkCeNOjkCmx9zJbmIW1Jkw7ZOE
	 +n6Hcp8CQtvxskwxwh4/8WWk9tbioZTsVFx7z5FeHYZP9N8PmHBcTrnBHjJHiNVSvJI6w
	 0hM8F7BmzpiKaI2RZ8Xp9KcMzDQlHTdx9MKDopbBRGreBJ6Je0bEmvUW3hzTBnTXN37lm
	 vUseL98nxzZmtQ3Np7MZOI3ZSYumRYIZpNiAhsfLCchDdIdBsSpGqTG+uSnSVoiX+QKO5
	 wEY7j7A+qjfqSOUeU+ZdgT2+m5XQANkEm5MnB34LYZ/zYnneuXdg3BMKADjRWPjLZoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381800;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Vzf/oKvIfm6ePZf5BybDfMAWaHgo0MfybYT96AeuK8I=;
	b=lv3TZvKHmv66V3mJ5mP1ESWLosa0h6tnukwmGUFq6j18DFcg5GqqhK+o/hvFtZXSnNm/
	 55Z65qbGVfWXXRcffkseTKgK6/LQQBOWJQen6p646kP1dkRC/KKsrj3quX7pH7SBBmOcz
	 okJ6q0JapcWGeWkeIZJVglGYGi0Z887RBP4WBn6Yj3H5JiV0DOGLMvKybcYLAY5oC7ZCg
	 +mloaYj1lR39NWBOw/pEwvv1+wTO0lrlhQPATlKzNK28QEGIclloJzHQ8dX3gdqNBi2iA
	 Cds6zNkyEDiPZKFu6qrsBBl4GwdhOmHS4h69KGVtxL3J07woDtlB9SRBHbCd4sc0igw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0B606A31A;
	Fri, 30 Oct 2026 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=Vzf/oKvIfm6ePZf5BybDfMAWaHgo0MfybY
	T96AeuK8I=; b=CgouatjqUkTcOr/CqdnToels2U0zH0cqb1wWvftMC2QNo/2fuu
	NSa1RsyN4ADtWj9KA3+XcaVpj4D7SNBawsPfAQaABGc62JyDvVzAAHQu2HuwlDww
	Pqq8fihZQtGKjolrMtPq0K63kq1a4UXo4qZjD+zYcOkE9v09LlQaZE8y4=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAWGv2Y1eRq1CAMAQ--.11970S2;
	Sat, 31 Oct 2026 01:36:25 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: fix a user-triggerable WARN on repeated DSP load
Date: Sat, 31 Oct 2026 01:36:11 +0800
Message-ID: <20261030.pref-15.1b79819b46c54b16@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
References: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset="utf-8"
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
X-CM-TRANSID:BbQMCkAWGv2Y1eRq1CAMAQ--.11970S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYQ7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Jr
	0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUxwvKUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQJkAACs6

Hi Takashi,

Could you please review this patch series?

  [PATCH 0/2] ALSA: fix a user-triggerable WARN on repeated DSP load

It serializes concurrent hwdep DSP load requests and returns EBUSY
instead of triggering a WARN on repeated usx2y initialization.

The series is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261029084810.21910-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

