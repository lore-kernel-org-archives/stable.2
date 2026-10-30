Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340113;
	b=jh8Tz3eTL/JEzlquSN9yMW6jOGVtsiIK9eEX76Qh0aIOK2t8wvtYY2coK9qZB4zQj1Mp
	 FJFVv6JM7gEv2SMcoIfP0XCTDChqXz9/cKRS2O8kV+uEjiHdk/0sPQZhCn4uC8mzSfAnn
	 bfFarizZA+lKtKl+GTOFEGwgT/4vxobL8KNTzEn7aXS0Z1Bmsop/YaDrKEbTNa19W9Cnu
	 Rr1M8FpnjHvzx0hEZ7J7cuGIaA2B5TEDy5jmhNHCFIiqbxmYugEhFodTzrNBPxC3Q2b50
	 iBmuON4O0HFsdR8c5phEbf7aBpFuDUHtdZ25sb/9H+wRuf2Xtj7cZlQ5AfMbaQy1aOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340113;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=3+yMgOHJoCI4m0B8wh7JCOWSOxNAOkqliA1eIXX27jY=;
	b=p/pCrPp99ovU1sLANXXXsMBBz6mR+mUpZUsndyQZ3TQaE9z3A4EvH5RzCQTW6WqMlHIw
	 s3SPVr/xZhXcPmqS4Wp7dW05KR6g3uXGP2rBZaER5pMv0qvPqWH4rD+JahBPpDiOalb7I
	 hoTJ22Df9u7UscmDz3FQ254YGE/I1upHKRx2o/dwL83a4hqILqFk9NYeAxQaek9E1k82u
	 HIro+VsK/LbgLcg3gnuIc0lIm6hVC/grMHkO8K74OG6aCqlfdbPWzE0TKTZE12AFCU+HA
	 q+A4CRNdipFZMfzCKEjjByaR2FtQxIjqhrQQ4Am12gFkGX3h2rY4n2XHY8JilLmqnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F4606A31F;
	Fri, 30 Oct 2026 06:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0F4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=3+yMgOHJoCI4m0B8wh7JCOWSOxNAOkqliA
	1eIXX27jY=; b=KEmvw/au0zs8lv0SOcZbxiVqKw6oMFpFHanlX4zjR86qqs0iVB
	TSsJS7ANR2CW5bHE/HEgitaKiE8TvobEh1DnQ2F2oMmLLM4xHTI/WcQErAb7zI0x
	gR0YS7Kxd8SbiExYVqjpl3urAJ6E+q4dtboArlZRQCsdGrXFUb5VyB7Po=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2ev3NMuRqZQYHAQ--.6649S2;
	Fri, 30 Oct 2026 14:01:50 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: az6007: stop CA thread on probe failure
Date: Fri, 30 Oct 2026 14:01:35 +0800
Message-ID: <20261030.pref-06.a2ac6da0394b4f0c@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261013144717.1621-1-25031212351@stu.xidian.edu.cn>
References: <20261013144717.1621-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2ev3NMuRqZQYHAQ--.6649S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYJ7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vI
	FxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7
	CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4jXdUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rjY8F8yQADsX

Hi Mauro,

Could you please review this patch?

  [PATCH] media: az6007: stop CA thread on probe failure

It stops the az6007 CA polling thread on probe failure before the device
state is freed.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261013144717.1621-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

