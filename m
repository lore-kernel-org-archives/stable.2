Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381837;
	b=oTn0Ze5GRLj/kSgCAmaepIi9JxUCffNRky8efWFZ1qt0vDjGjKvVHudOADs1eYDZ6Uuh
	 S7qjBBayoQm69B8EXdysuIKiSC6gfR/ge+dinTrp5IFo2BDVTHGsqhGzm3VxcGpgpjdv7
	 yF/l1LiTV9lK8LeqxLTjDK+xxBURlU+u9GT8nh9tcol/k4nGwutFLY/xkzSBJinYWVNzm
	 7iITY0G/EoCdEM/sdG2RtxO5B53UnXR587/AyerZcK8IzWKREizlOWuLQYyUbo693HASh
	 tXZU+oq6YqrV8Zl1Sa4I5I0xQwNMP/uT5Lo5+1dyVDUK+7guCKSTHSU2TtbEypHwSJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381837;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Jm8OIYeZ2+Dv3alD0eS13x7wHLdUZwxioOv0dGV9tVo=;
	b=pAt8oU4zr9jx5PqDmPvknh5P3vVR4e5Zk0u9eoPOI39ODhHCvqeV8PLF0vI2uK14D5jC
	 0uEfIPTkbSzmWIyYUPnDpO4CcluxMpGJoaqTY1kKyrzM06Mpz7oVHi3ddQvJ+nS4o3SgF
	 6apVObgWO2uQCNNyDkT6FA2PeI7hvW32SO+3rvPeNdQEVZIQHdcDAT/6UlOkv6cv+jqz1
	 XSw4z7a91N4kwcCZxD/0ns9rtZ2dmjrSZ0HsRqZ6qTMVix4LZ8R6yGS1Oy/gNF+y3ooYE
	 aTjpbVg+LUrTJKddOU68l6axgk0EOX0U1mnrqBANXyyVUBIrEn4Wp83i0VW/TUC86oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA8606A31C;
	Fri, 30 Oct 2026 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=Jm8OIYeZ2+Dv3alD0eS13x7wHLdUZwxioO
	v0dGV9tVo=; b=60JtqSJpF6Fxtp+hlYl8Rz4Vo+/J+p8dh6WjRSTKkolBOEeDNz
	YsHYmhkAA6tQU/NLa0ZFKVu8Mdqm4ssEg65cqMmP7S/CHgD2VgDhlWWnlJBX/omL
	QrkGJdiyTgL04yFAe2pbPZnWBPo/JhuaQ6/Ol5rsw6xGU2mpsDxixJ4dU=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkAWWwDH1eRqRXEMAQ--.14469S2;
	Sat, 31 Oct 2026 01:37:11 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
Date: Sat, 31 Oct 2026 01:36:58 +0800
Message-ID: <20261030.pref-20.adbceb9e18d0402e@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261028042525.8737-1-25031212351@stu.xidian.edu.cn>
References: <20261028042525.8737-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkAWWwDH1eRqRXEMAQ--.14469S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ijjDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQViQAAs9

Hi Takashi,

Could you please review this patch?

  [PATCH] ALSA: us122l: Add missing NULL check in
  usb_stream_hwdep_mmap()

It checks for a missing stream object in usb_stream_hwdep_mmap() and
returns ENODEV instead of dereferencing NULL.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261028042525.8737-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

