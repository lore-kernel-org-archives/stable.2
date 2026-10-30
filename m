Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381812;
	b=lyUh9kuF0pwrhthe2vKEbxqToAZrKsEPbBcbcXnuBgK0y7ahnSWOQzd/tKScbfO0U64I
	 lzrL2bIx5ju6D5pLZPoukxwvWLF4UVnyzz5Zp2BSy8I1PjsadaCwqosZlxc6DbzGr6Kcl
	 HT/2xTseHnUKwPquDWJKPzBChqGi+9JUILQeb0NWPqIrTYgNfCt8LwHAMaKsC9q7DzRwn
	 RvVVKXseReK+dtvl+jrO/+NkqbyNEtzyAUOdtaw2nWgl2sM/AWn5a9Ztqti5J9qe3h821
	 RdK+yZ0uxIOGucdJIR7PPD7shIuWWnNXO1G/GqP5ABCvKQ7dC31y989uDvW6VEXo+aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381812;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+iBznHwZuI5Lijz3HLM92IzOh/NILCQlRn3QTknWkp4=;
	b=KxG/aRdfdt0C/QxqupgnxmFHTH5aQVV+En49uye24lUlR7Bxp3wp4odE38E8WoByT9hP
	 5yC4og9TFIepYFeb6GuS/flVk0biqALTDBa1xbxAJJUTlbbyGnfiGU1c8ZchkJHQhLvDE
	 xcLRA3w/Ma6UTkey9sBXqjKiA1b8kx5gKG8VmSv7MA5FhUn/zA56Ixmh27mp1mcIThyhP
	 OWIyjE3YvE2vH8bLMLJ/IyqK7UHH2XeJC6uZw+eiEjse9BOEKXWjYrppz2y/M8kfgLaQr
	 jJm3er09Rh2Ba1wdGWU2mzy76ClwnG+9aAg76i0gLr2t7VDQQnLeLEZXChizfPl2J0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E08606A320;
	Fri, 30 Oct 2026 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E08606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=+iBznHwZuI5Lijz3HLM92IzOh/NILCQlRn
	3QTknWkp4=; b=t8DzcSvYvPluO/uDD8CupbcRv13L7smQkhQRNEHV0+NzoYRdIQ
	ogz/WztwkD8PNDqhrLEYk9wRdAER/2e0XM+rbg3LCsT6E5GsSKCUV8ALruvt5XOt
	/O2Euy64umRfAD/NlzO++UyVlIfKwVRaWcksv/Wim9A2EfxXNAI5mgrzY=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkAGRfqs1eRquHAMAQ--.15027S2;
	Sat, 31 Oct 2026 01:36:45 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] ALSA: usx2y: Initialize idle URBs before submitting streams
Date: Sat, 31 Oct 2026 01:36:31 +0800
Message-ID: <20261030.pref-18.befc3244dc8b4572@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261028103158.22996-1-25031212351@stu.xidian.edu.cn>
References: <20261028103158.22996-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkAGRfqs1eRquHAMAQ--.15027S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr
	0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Jrc3UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQJkAADs7

Hi Takashi,

Could you please review this patch?

  [PATCH] ALSA: usx2y: Initialize idle URBs before submitting streams

It initializes the idle URB pointers before submitting USB stream URBs,
preventing a NULL dereference in the completion path.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261028103158.22996-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

