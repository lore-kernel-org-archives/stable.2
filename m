Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381897;
	b=uVOlMUbs5Zin/YjuEDxkcN6tPUuWhHckXE91NrjDgQt7PLVpiJ1lRc5tu13OSvI+/Hpz
	 hOh8k/Xf1s69otsw5Qt30klaR6KjSYos1qRkQOk40mFYwK3hdSdmKK5EzQoi8qVqZoUPg
	 hIXoZeOt1UoNDypToM3+qCvwxOi0qXFBeGbxWFpsk/GZf/uTUiikfe7EmXa6n/ImRyeiv
	 R/12cn4A6XJmUGM7B1Wgd8VY4VWPqBBLFFrjN+CSkh0gorG7OZHp3fd0IWT0eq2kOS8pE
	 IbR008GmezW9qkC40xQjIZfinQO2WD3P30mCdyYpszqttW8I2csNe+pYyk+ui44QGUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381897;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nANXWkw+rY+n4MaV1ZUeGP/X+9zMUwXHwAiUm1jMgXw=;
	b=LzKegPkCYfgxd8sl9CFetkOO/dXzZsMIqYu/OrJQ6M8hrs4lwilU9B1mG1yOLzfc4NsL
	 jIeYUD+iKgMH/p8PtBLUJkckrO/FyLvffDmlV1Ux6zgKCvEr+TSmmDxTxmSMOCwtA4arc
	 KRZZVcH1f/bhzff/7iCr8WhIiaAlK8MrCJSgsswMAn+tYXgQ50Z3LQxnIpu7nAYzH4FyG
	 LXNg+mPJQpZNdOid3S9xEORuldQ3W2TE+KORVA2wxgHR4Mp0VJpd9Nk6JIcpBnsPjfWvx
	 8o+tpDnJ8EJPFkv9srm4RYrxbJDXRbOh6GZrkVNXwv5FGqpdcRzgpIRW9wrIXigkASg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D646606A31D;
	Fri, 30 Oct 2026 17:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D646606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=nANXWkw+rY+n4MaV1ZUeGP/X+9zMUwXHwA
	iUm1jMgXw=; b=xSl7uLLMHNkuIQmu0aq/yOo/Bq5jIGBFU1UltFKPRMxIAivffm
	VfCXqGqUxVnqNvHjXhMSWu5eOdlBrEQfYqbS7ik0i8Uwp/2MYctQss00M9ATkyfC
	WDElLjVBVNRTb6D5fgRnMulmgbN257zEw/CN6p3PfhhPExu5hP7DaLAlc=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDm6_4E1uRqsSIMAQ--.35312S2;
	Sat, 31 Oct 2026 01:38:13 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] media: gspca: don't complete buffers before streaming has started
Date: Sat, 31 Oct 2026 01:38:04 +0800
Message-ID: <20261030.pref-10.8158e7fe75794546@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261016140132.23712-1-25031212351@stu.xidian.edu.cn>
References: <20261016140132.23712-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDm6_4E1uRqsSIMAQ--.35312S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOb7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GwCF04k20x
	vY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUxj2MUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rktUIS3wABs-

Hi Hans and Mauro,

Could you please review this patch?

  [PATCH] media: gspca: don't complete buffers before streaming has
  started

It defers completing gspca buffers until streaming startup has
succeeded.

The patch is unchanged. I am copying these addresses for visibility.

Original submission:
https://lore.kernel.org/r/20261016140132.23712-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

