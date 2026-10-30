Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340048;
	b=yAjQTbXCiFrxzZSgPMJivMtF6WWk6BWnVRAr4zcXVA01//7gHiRmnviNz6LwQc9UP/tn
	 S8F2IHaudsQLtQcN1wIV6Wq2glvVvyA20gObQfRt1C5Fq2qaLaLhVI92CcK36PHMLSdKD
	 II0aRmmzHGTeuYWEg6BSU2EpSkJ9uC2J4pI3akhR6BSn/2PC9MP9+5E2qu6cynw4nj0GX
	 S7zslRgEn/jWCjnn5gfrM+ZzEEMxY+xQ4l3ifkmEUhRTaz7W2Mab87+mq64/HAfHGkGk4
	 LGNfYUAIeIAQgXcRvpTLXyBnFuJEv7tvNOYvpj1rth6W43wPYozf3maWkXvgjHmrIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340048;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xYiuNKU4W34QRuXNDo0mI/xVZR7pBc6NKd1CQf110KY=;
	b=x43AqvXX8+0mGtmkqAmtOY7d+mKfX2NRrzoFNcgmwAvJjQVZdRwgTGA/x1yazq0Cv26K
	 Smw0jxB/S6BxGsiVHgXOmNvoIZYlkM6wfJP8R0MYDYYtS5yr5dEBkquUuz35QQx1rvNt+
	 BnkHOJAWtnQU0g9XPvQiLreXTNBhpnmNlv2SqYYBndqLdEnclGQSAhZQ9tnrCfZfZ5Ded
	 qctZHCXbyQEHXhd59EF7SBV2P3PF6egxkJV9YM6ua4FFJgboASbWQY6qvNhIPl3zIXUB/
	 I8iNAagCYyEPbckH6C8PecrZr+aiIJlrNo4Dh4DUzdpCQta9ivXUVRFkkcg/w3lCAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707C606A31A;
	Fri, 30 Oct 2026 06:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1707C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=xYiuNKU4W34QRuXNDo0mI/xVZR7pBc6NKd
	1CQf110KY=; b=eeWVEbVsnqJ+WOr3ispCBIL+pNnUiXcEL5vwI0cVxhGC3xEm2/
	8WxpQY2FPa6Mmew0tx9Ty8ZyLd/RSY3x0bV3tnv+svttHITMrr5Y0iogqvpkZpS6
	7p0sneKlQ/MK3Wks/1EVfZpvU/sJ5U+kGWKced+GBjP7kg/coHEVMGZ3s=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGjwSKMuRqnlIHAQ--.9683S2;
	Fri, 30 Oct 2026 14:00:43 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v4 0/3] media: dvb: fix use-after-free family in dvb-core
 and dvb-usb disconnect paths
Date: Fri, 30 Oct 2026 14:00:28 +0800
Message-ID: <20261030.pref-02.e247338465874370@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261027024856.22764-1-25031212351@stu.xidian.edu.cn>
References: <20261027024856.22764-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBGjwSKMuRqnlIHAQ--.9683S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x
	0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j50edUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rjYVR94QAAsp

Hi Mauro,

Could you please review this patch series?

  [PATCH v4 0/3] media: dvb: fix use-after-free family in dvb-core and
  dvb-usb disconnect paths

It addresses DVB device, frontend and USB-device lifetime issues during
disconnect while file descriptors remain open.

The series is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261027024856.22764-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

