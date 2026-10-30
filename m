Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381960;
	b=x6Uk8IHgDN7iYrna3XFP1PpeXoJdj8mGvphgVHZ1lC6/iHaxOpU9r+QSEGzLItSINtyw
	 QrveMmQCtPJ5ZIsmLchWG7bk0yZGWbAfLpDt7Ev6YERT46To+CviZAbHa3NNHMzgNqJxC
	 rg8UAv06HgNHmwZDRh1qmlXlaobWwAlezkbqZNYRctNyMlEu5n9xogVsBS8AkAQQ5CdKQ
	 l16TOvMtxA+482f48hGBNgazfB6MEXaZsVakOhw+1U7TWC7Hn6fXaS7Z+yjivQa4L0N0x
	 b1lNCy5XvjtAHvL58Mt0yjl43zQtPDbGf/9rPA8iDmBmRw2aPqTAz60bqOqExxNaX5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381960;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=y2lepkzk7vkt3kr4ZkaYhyRBEGVnVhus9V1jSE6WHgc=;
	b=Ja9fZYtIXMb20PwB2qAdmm3kYrs8zOO5La+YKOMFPJIu/qJKMUF3l+pUyeeL7/60wvul
	 +rC6W1/v7akLb/1hpgog3/+f+V9p4SKHdkyl88ZfR1hYzv+A7EacV7cUE8hxntgYtrkkV
	 zN6X8Z1EQRZ/JDpEjqLWXQ3YssT1BxUO1n1VmeYniVVVXvvT/yIUd17vwBxuNvBdQPn2O
	 Cb4wIbWtH9QxFS8+Tg8GcTMMLSq1gnvZoalS6Igui3Q575I/Dcu3dCeGdWZ8D0fesjqWx
	 UfFm9K2tKTk2UEh0keumtOjnrLScwGhq14kbTNMeDgqYZ0vLD+2U3qCtlTp2tvvcrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA38606A31D;
	Fri, 30 Oct 2026 17:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA38606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=y2lepkzk7vkt3kr4ZkaYhyRBEGVnVhus9V
	1jSE6WHgc=; b=ana79iSxT6QU9IuBRJniTb/2EPswH4ObsAZBrzosPjKqS3+Nbs
	OlJwT8UavdasN16tEUcFDV0GSN1cOIzG8q5hOpuCZS+p3f/47lPJssQvTLUiPzDI
	aaEWnZQV4kfbn59Igyz5igVeqG/Ga4CN3IHd/AIZPU3AVjP6uk7rg59j0=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBGZPou1uRqeagMAQ--.10457S2;
	Sat, 31 Oct 2026 01:38:55 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the interface
 is running
Date: Sat, 31 Oct 2026 01:38:41 +0800
Message-ID: <20261030.pref-13.995287b5f6e44468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBGZPou1uRqeagMAQ--.10457S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO17k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4Ir
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4l42xK82
	IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0fOz3UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rktUIS9gAAsX

Hi Andrew,

Could you please review this patch?

  [PATCH net] net: usb: lan78xx: only stop phylink if the interface is
  running

It calls phylink_stop() during lan78xx disconnect only when the network
interface is running.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261029160204.2567-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

