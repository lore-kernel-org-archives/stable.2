Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340063;
	b=gndYC+t92aqWwPsKqmLeHb7su2MzxFyrC0ESO22W/ElbXg/HKTq+D+W67DmEAB4GlQen
	 bT0Z714oOERyxUJc3uSAikBDt85mZpHxTnRX3FIHgJ8Avt33rISZTNYAcZ7SVv2DVjf2E
	 gmMHTSjWLOc3jPxNJlizcZNTo1BtJLhB8TB3F9THcFx3fskR6rj72RJUO6bTDd6hMpvHY
	 jgR6iJUos1iD4HATbX3oOHCWGXbVqIlrPpIZcKuGGBr3LFw9uJMxrgD4Ly1k96On0vddp
	 aZYRwWB/tEe3HQCeWoETlZMU899sA55xgIfkEeTqDscM3mGQ4Ang0v3Mm0B/5A4QSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340063;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=PAgzzzplxkNYEoxRbE6tWlZWu7lYZiWDw4wNXNfy1jM=;
	b=B5Vb5aA9qSJaauuciq4JAyEvFSoYgAPDT1wr61iKNwJ8g7CI+e1oI6W9Snz+A3IG4MGi
	 fWhPqxv5jp3A9NoNE++mpTNV22WjojPVe6W7Wyx2YHLiNCjBblx4uUgjuojdl1avoqklb
	 /Jc4Kc0xiOlkJmCKApTheIqlcfahPqfyi4e/pvdm/Yh6yrb6tvR5qVZf/E3UwIieFQ8/M
	 VKCItICDRNiAlQga9oWWNh764qtKR6pPOpWhdWz0LLm0jALYM7N2LN+EmkCIg89/9lR+J
	 tzFRKoufkifawGvZDyw3sxO24sguOzgpBCdizZ9QqrWi7t0o5Ac1zvsnhzcYkFXrD3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C6606A31A;
	Fri, 30 Oct 2026 06:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=PAgzzzplxkNYEoxRbE6tWlZWu7lYZiWDw4
	wNXNfy1jM=; b=vEqx8C246XMqy/GWeP1zhHK42irirbNbtlK6Q49ZRx9OzYL9OS
	NG5yNold2Xu0XBMV7BcsRALABBXNh64g3YfY07ZxLmI7WFQgA2nYD2OZaULugFJ/
	oW8K3S5aSoaWSRsoIwIpFwmGPf0hq9zgkWxFPMo82ruxJH6ax1Hqqfalc=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkB2lfuWMuRq9IgHAQ--.7295S2;
	Fri, 30 Oct 2026 14:00:55 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] media: gspca: check return value of usb_ifnum_to_if() in
 gspca_init_transfer()
Date: Fri, 30 Oct 2026 14:00:45 +0800
Message-ID: <20261030.pref-03.522b5738fdaf4d7d@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261016040404.1337-1-25031212351@stu.xidian.edu.cn>
References: <20261016040404.1337-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkB2lfuWMuRq9IgHAQ--.7295S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7k0a2IF6F1UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x
	0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zi92-bUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rjY8F8yQAAsU

Hi Hans and Mauro,

Could you please review this patch?

  [PATCH] media: gspca: check return value of usb_ifnum_to_if() in
  gspca_init_transfer()

It checks the result of usb_ifnum_to_if() before using the interface in
gspca transfer setup, preventing a NULL dereference.

The patch is unchanged. I am copying these addresses for visibility.

Original submission:
https://lore.kernel.org/r/20261016040404.1337-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

