Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340097;
	b=0N5+b5A1hFYZ9N3ql6IQ/z0fbIFQKPnDAGmn0R28XG3l9sq2BSGd2z8Gwcfcca1v5tcs
	 cSgbK08kqv2vmANQ82YTIPp9q/OIv/tZ70cNFo5cRN+cxX55qWgXg9ZMv7nVHfhd96ZiK
	 +cuUoPZTnTYfrV5J7FCf2Q8qUfkZYVH+Hsv0pxF2nyIL68dVQyDJnNkIp+h/0WAsCgIWx
	 a/2W6ZxP9EVhksk64MVuKqvWaowSgRsqHdTYdihHSho6YouuoIOn5awI4sP6I0jOut8Gr
	 1O5kzrU4AxhjbkaG2RF0wgbyashDuG9onekf7c80YjM7CJmsVfX2+G2Oq5FWz5h/0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340097;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Pk2tWgO+6B7jrggC2Q2WGSvf8Eevq+494hzw3Wao7dI=;
	b=DI/o31ZZ/nI4hyBxOseIzt4M0ajHFKdTApAN12CQjli9Y62BbXo4PlTZfXtQcfsC/t2u
	 v657pTjwdTKLhotSSoULceBHNC5k65eKp0872jx8nOo6W0KlqGBAgO5oVTRjnSBTEBPUp
	 a8Cww5CCH9fDLI2QyVfdQz1f8beqv8e1hA6LBC9KKsm1xnGFpoSHCNL8R5HFN9XLszgLa
	 SSJ2bY39azIqMVWdTB8tW38ABornAUjKRwodpNfWE0ZAZOiX/L0Re23kE3zLfAQXxo/SC
	 pL98Zh2PZqAIBTb0RXgM9HJhClCwqvmPZorQp5bDPN4uoftdhYq91qm5n0eXPhFBe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666B606A32C;
	Fri, 30 Oct 2026 06:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E666B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=Pk2tWgO+6B7jrggC2Q2WGSvf8Eevq+494h
	zw3Wao7dI=; b=yZjtCGEfVn3LXiXY6UMZnyYkJrNQZKNQ/4YICkeYgfE9FcXpSP
	BRPRR731zJKSNce71vd8pI5G13ld6Hus27HdzAuBcOvMkctAqb7QlB+nKo5lKmJ7
	a/0o0NZo8jMvf4W5r4x/v3vsv2lPXI/EVWY8A4bXs/8S1nPwVVNfBj7eg=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2fwK4MuRq1AUHAQ--.7256S2;
	Fri, 30 Oct 2026 14:01:29 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jose Alberto Reguero <jareguero@telefonica.net>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] media: dvb-usb-v2: az6007: Release CA interface on
 frontend detach
Date: Fri, 30 Oct 2026 14:01:14 +0800
Message-ID: <20261030.pref-05.3fa33011d6394c8a@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261014030222.9265-1-25031212351@stu.xidian.edu.cn>
References: <20261014030222.9265-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2fwK4MuRq1AUHAQ--.7256S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x
	0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jreOJUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rjY8F8yQACsW

Hi Mauro,

Could you please review this patch?

  [PATCH] media: dvb-usb-v2: az6007: Release CA interface on frontend
  detach

It releases the az6007 conditional-access interface on frontend detach
so that the CA thread stops before the private state is freed.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261014030222.9265-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

