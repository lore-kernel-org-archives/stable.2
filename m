Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381913;
	b=2VZMgsfnSqi6pSfwkyGNUUW4W+xsj3JFposeA83w3Nal2Ub9Ozcrhjo7xIqzb9DV7c32
	 RysEs1xRAE69X6NeaZpCVKZpfEgSoq8vkMPRdQojXIvrjex0B5InqwGhhqQlsx9NzInwI
	 LgO1/+Wt+drMJStN2GWt5KPoa/IYeP2ZcazVnLSXH/oWcqMOhAJpPmFNSZ5nGrEbvWv7M
	 HdCqQOKriULnt/BDJdD6BaSFdnoazJNgx2fb30fzMeEpHVpAoR19f1CgxURz4nqz3Klgt
	 VPNRsUO071QyUtjvWsBUaWSiEgKtifhqQrO1rMf/yaxqWKMmdZg4UqPGYQDoZegFXNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381913;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Ke1RlSBs9vYYr3FpN+ZJDjwrZrlDqO2snIeNd9/XS/k=;
	b=egNbvFUXHeHPPKOuETSLJQN+nyqTjTGh2XkVULm1wYUBau4P91Vs/c9+vk3skaAZ8KN6
	 BDaqLjCpZtSen7BBbXTo8MTxhMzXhqcsw1d5Iqo59Mupm7mfowL9duoGkQ0F137DslouI
	 AmwB+7zNi7x1siSc08Pn9RLs19thwAorX7ooqvpONtn5zmq330OI1kzVYEljMT0ILjP4X
	 piHE/JpN4rb3lk9KQlbTKS4RwDGHLVbdjTLu13hnhDi99bxmakedVsXc2//cxHiWO6hRh
	 GQfKqHzaun+m3eDYoI7SaAcJj0h/nWWBLuZ/1aoH3+fPGNubWH0uskizsSYPNxJsffg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3946606A339;
	Fri, 30 Oct 2026 17:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3946606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=Ke1RlSBs9vYYr3FpN+ZJDjwrZrlDqO2snI
	eNd9/XS/k=; b=ZSzMAhhvsMDY4u+LKkRp4vkbyiA9/o+ZV1eI12rT86hsNQWx75
	v9FgVV7s3NbeyZo/d2b1d0IpfYoZQWC5A8Mf53qjM6na2wCU6ForSd0PivHzx3Kp
	GXEmGg+50/7+KIplYy+k749GG82jkmZZDM2iirzXgLZ0kES8zUwY9Ztuo=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDGDwUU1uRqbnIMAQ--.13433S2;
	Sat, 31 Oct 2026 01:38:28 +0800 (CST)
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
Subject: Re: [PATCH] media: go7007: return queued buffers on start_streaming() failure
Date: Sat, 31 Oct 2026 01:38:15 +0800
Message-ID: <20261030.pref-11.fad568eef2b543bd@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261016102213.42771-1-25031212351@stu.xidian.edu.cn>
References: <20261016102213.42771-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDGDwUU1uRqbnIMAQ--.13433S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxs2-UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQVtQAAsB

Hi Hans and Mauro,

Could you please review this patch?

  [PATCH] media: go7007: return queued buffers on start_streaming()
  failure

It returns queued go7007 buffers in the QUEUED state when
start_streaming() fails.

The patch is unchanged. I am copying these addresses for visibility.

Original submission:
https://lore.kernel.org/r/20261016102213.42771-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

