Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381875;
	b=JLNS030Pjmc6Ee1CEMmucouBAxTh6NcUMPYFxhpUNrSm7OwFmFm1SkcEKSzAw71pdN7j
	 IvFRlgjxWJl0VQvmmSD+6IPzKTn3pW0FTJAvriyA4/q2JER5Kt+v61mTMjpfwIIfoeb6N
	 qB/X6CqSs7i05R/ruBdNb039nF8OZEWNIHPMI3Qk98c2xdqo8c74BoY2zmwgujbjcgidJ
	 ONZNGhocNP9rF8Ei/3I0QaE7cwQ+42nmIyux++1Yt9X2VJnRtrJSTTTBw20LJsw2Ng2kM
	 0m61gQvsoQY6BOXSGMhewca8GV9xQd1GP2TW1Kb8FWWdBxSpqQEB9Q8h9lcUzQNlMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381875;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ejTqMbm2YF8hq1t2Q7Q+G5E5tccW21ZfrvOT83EL3B4=;
	b=EQoSCtq6PbnhjwiX/2kkjj5w4p7TR33o1P/pzZ68ykqMDmsTNnjc8gl6mKm2MhcIz62i
	 unJ4Q2ltWWFihbwyHDBk/DfzAQdyrv0batakC9OSdyywzs/JbXPYNJWNzLpKnfj8C1mzi
	 sHosdTSh0Yufq15sPpR04F5C0R5u9c/L++3gFeNaHOJrAGwZj+4jw5qQ5ZAIyTccR1pxu
	 DJ1TRY15s0vLBbhtpSXIuDTlw6q9OGPfbum5KCox+oAKikkbkxtrQFhTlISZcRWx1jNjX
	 YiOa8Z300rkN2ICXViAseR0xoTKXqZQSz3skwH9NJZY/wxBBOk3wurBlxrK5BaxQV8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA7606A31A;
	Fri, 30 Oct 2026 17:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADDA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=ejTqMbm2YF8hq1t2Q7Q+G5E5tccW21Zfrv
	OT83EL3B4=; b=zUcd13LynVjs1KFuhjKL495ZBghCeqtXXal0wpin9hqY5OR4jF
	0U1MeulCKOtZaXSUyU0GhxkqshLMQOr+7hQUT5iEW6a4RNWxkFf6y7BOvno6eU+a
	TNN3taR0+cMZif66jL5TSDwdnz9y+icLCfF0sQRppuOJ7/K5XJZUC95oU=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDG5Prl1eRqbKcMAQ--.10589S2;
	Sat, 31 Oct 2026 01:37:42 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Anssi Hannula <anssi.hannula@iki.fi>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 0/2] media: rc: ati_remote: fix NULL input device handling
Date: Sat, 31 Oct 2026 01:37:28 +0800
Message-ID: <20261030.pref-08.0e2173b9093240d0@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
References: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkDG5Prl1eRqbKcMAQ--.10589S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0UxhJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQVmgAAsu

Hi Mauro,

Could you please review this patch series?

  [PATCH v2 0/2] media: rc: ati_remote: fix NULL input device handling

It fixes NULL input device handling in ati_remote during early RC open
and when mouse support is disabled.

The series is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261026125731.1952-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

