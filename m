Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381823;
	b=uZGKHve6t8Vo3NAvlRoPIefMWKsHF7qoOSqGzxdKww17mbUNdMWeIdhQH4PIfIM84+Am
	 qci3C52xHlIW8vZuvcHRznBLW3MCCPB4bVoxH57dzzHO1Pxljy6QJs2N7uPM+4X//YRRk
	 dIItKXuB4xO4xS4mxs5Xppk5OFN2qhUz01BW/gLDvgh3Fhy6K1rzgrgHuxBXBQTyZ4XE2
	 xCp3amzTadx46ZD68RuVYRYbwW7WIwzVPTrrguFCSsssGaA/T9ehKgkP9TdSUaVOvIhI6
	 u4qdTkMS614YR4LfsMOao8cS3Xu76mBz6hTeQQ5HREvBi/aAMIL4cLHOJN05ktNfSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381823;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YpSzr7L8JK/9IEOdv93nPa+KjiCnCHqna9UA3ZoEnr4=;
	b=TIQZ3zPpVqAWv18pEvJTG0q1Vkg2Iytj5QEBnpLZdkh7sl0tPxtiZL0z2V3OrwhNErXx
	 2y06nn2TFkq50J/6yDNwasO+mPidF4YrRsJKRsvrID1Za4vbGR4CEWgNOIgZ0CDx+H32U
	 1TSXDxUy7HnLV9ewsRwZ6uApEQPbrX0m7O5j/sKSyebmU8fhFgEOzNWbhbvMAkAgeEaop
	 lACYDe56Q3LN9uu7XstVSBJ0XfhWWlW7Wy2aT/rs1o/IZB/zHmBjL74lgOEAs8JHPhaxG
	 q2AMR17uyiDWslR9MAzraYP0bTp6ZZJJitKlUKILsIOE2n81Ml5FwrrpKMYMjxWSoXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C8606A31C;
	Fri, 30 Oct 2026 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=YpSzr7L8JK/9IEOdv93nPa+KjiCnCHqna9
	UA3ZoEnr4=; b=AuqpEmoiE0GmBY0/bOk8R/b+d0REH6Tsmx6uRWASttgyGlae46
	765LlWpsz4JULKd8tnCBsCgsTEsF3dNiqaxaEc7TcJ/KqlEMzq6wI3Wd0qtkrY09
	FWpMfDw2oMOxooaBBShsLgZIeDjufnIwxGiM6fwCmbc3VuugVQ7vcQk8Y=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWHAK31eRqAnEMAQ--.35160S2;
	Sat, 31 Oct 2026 01:36:56 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ALSA: us122l: Fix NULL dereference at hwdep open and release
Date: Sat, 31 Oct 2026 01:36:47 +0800
Message-ID: <20261030.pref-19.113b1366288a41f2@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261028074143.14440-1-25031212351@stu.xidian.edu.cn>
References: <20261028074143.14440-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDWHAK31eRqAnEMAQ--.35160S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr
	0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ijjDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rktUISrAAAsN

Hi Takashi,

Could you please review this patch?

  [PATCH] ALSA: us122l: Fix NULL dereference at hwdep open and release

It checks for a missing USB interface in us122l hwdep open and release,
avoiding a NULL dereference in the runtime-PM calls.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261028074143.14440-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

