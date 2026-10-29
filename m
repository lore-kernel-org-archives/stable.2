Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263709;
	b=nH8ohc1UleTOsQD7fNDrKHymEzhEIuNsiFJGclr5e/cbMnNotNNZts/KDfOcBxhQzLiL
	 EEaCTJyjiU/6IxuDXLJEqu8BdAN2u41p6MeEQyRFD0aluU03R+ZwknrsFC30NVq85GYOq
	 iLRDld3ORjW0Hou7VjLwpRBbsoJSCjsH1sSS/MlO7Rpx5356qxSBEyu4YyCj3VqDM+R55
	 WKY1ceZqfMg+7/NT68HttG0CymapvHKhSViXN57UMj4eAqUzQkkB+1+JBl1+zgj9hMDLS
	 NCk79xTbifhOaGdMZyUMhAizbTocppmy6VKwM9oJIXPLi/znami2UKSq9/m1QAEtb0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=O/fiqeUUaTfu9pOKZpK8oTWhDaZ+OmjDQ5pEjLnqGDs=;
	b=U9w2wbXUr5CxxKooEs/hLDJl1oxLAt/qFfx0W3fKYBGbnrfW87oZNIt1PeYA5EOvmKds
	 K7b4MApeC8hLcZnPYJkxb50b86Z2Xa7EaPvLBy4ppG1X1dH7+cc0EjJEhXyZz7twONf7D
	 NIEQcFCEigYva2R2r8vVd4RYsW2ISzwzhvumaT148qHB1It7/3r/bFoI3dzCXv/8J1kUX
	 lFYf6z30YpahA2mh5EgWlBcRU3M36r96FXil57bnvRnk8pWG8wkw6xi/2xGcH0E/LC9VM
	 lF2zcqRh8gDlZFpkwRl9ZsWQjnrPdzfXMauj66UuZ7KMcqGQ8BdjwhqiSzsP8ljt0dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0D606A31A;
	Thu, 29 Oct 2026 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB0D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=O/fiqeUUaT
	fu9pOKZpK8oTWhDaZ+OmjDQ5pEjLnqGDs=; b=Gm8+718iBIJFzpc8AdC06E5fDa
	X2bEnzW3f23uyyPFMlz4jSlN5EPmBeRuQyWPIXkZHOY4646/PE547ym/kFC0WbgM
	DsntfoCgNuw//JJl6mZYVX51bXz7AGZEg6I6/Deh9BebZg3zMP+hZZOJ3N8NP/eR
	ydbdcX7jf8YmM0yKg=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAmKv1KCONq6jz8AA--.61740S2;
	Thu, 29 Oct 2026 16:48:11 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] ALSA: fix a user-triggerable WARN on repeated DSP load
Date: Thu, 29 Oct 2026 16:48:08 +0800
Message-Id: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BbQMCkAmKv1KCONq6jz8AA--.61740S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4rAr17ZF4UZryDKw1kAFb_yoWDZFb_GF
	ZY9r17J34UW3y3t3Z0kan5Zr9xCay3uFyUG39IyrW2qryfJFs0qwn5Z3Z5Grs7uFW7Zrn3
	Zw47Aa4xZFySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxU4E_MUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUBD2riD9OTkAAAsd

snd_hwdep_dsp_load() checks hw->dsp_loaded and then calls the driver's
dsp_load callback without any serialization.  A hwdep file descriptor can
be shared among threads, so two SNDRV_HWDEP_IOCTL_DSP_LOAD requests for
the same index can both pass the check and run the callback concurrently.

The snd-usb-usx2y driver then enters usx2y_async_seq04_init() twice, which
hits WARN_ON(usx2y->as04.buffer) and may also allocate the US-428
sequence URBs twice.

Patch 1 adds a per-device mutex around the check, the callback and the
bookkeeping.  Patch 2 removes the WARN_ON() assertions from the usx2y
initialization helpers: a repeated request after a partially failed load
is a valid sequence from user space, so the driver should return -EBUSY
instead of warning.

YuanZhe Liu (2):
  ALSA: hwdep: Serialize DSP load requests
  ALSA: usx2y: Avoid WARN on a repeated DSP load

 include/sound/hwdep.h      | 1 +
 sound/core/hwdep.c         | 2 ++
 sound/usb/usx2y/usbusx2y.c | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1

