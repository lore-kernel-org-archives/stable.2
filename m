Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340028;
	b=YnOkauKFed1WDD1a39UIBQV0wzpektLqo6Ku62bqNKZBly6wp218PQzbuhTRh25QCox5
	 juw/qEQWEg2+PF2qcgcNybjVi08ng+oayY9ortckyXz1pDEsWpprbr4vpf9HC+J9HpQcl
	 QC9Ukwt1NVaYEb0Ze6ffxGf8vVNy/6fG8LO4c/NVIP908aRog3i2R2OCJDpxt1s5cEyq9
	 0IYjyn/m9FyKdzUa53K71TuKZn5qzUrt7dqtEpm0kyTxQRAmsLfJJVK9W/NpbkhgcDwO9
	 RJwEFvIFqIP0rtKu8o5CjyG217M3vHXM2O0dx+9QrwV89ok32sZky2+gpIj06o8EYuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340028;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=X0371SJevF519y+FyAxegceguZyUW/5BWi3LbfDEn5s=;
	b=qQjqVZKoCosIS08RP3LICmcCn3zdS8XiSL/iOL7Sw6CCe7PES9Q8CIaS4VU/reIybeED
	 L/VI8SXK2fKL6grTr9QvWUeFQgUQawp9PMvPKXE0UnoeGhdy3USzX7/zm3Y3o4LUjP3c/
	 FSbxBb4C+dDpW2jaMe9N+9TcOza70wSQq0E2KmLtlx+sm4y0/njYA2sMjNjH7JRRtS1np
	 y1IUNf8Y7tCGgQgA4TisBSwV8aSZxF1LClMJoty3jBlGtU3Ec2MzdkGOXpCak9KGJb2k4
	 q+JM1Ax1jqilpXiDG1jTJQU5HgtPTUhD3CqZHD24D6CKyraUNXNPbV89Dz/blhCYJeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC29606A325;
	Fri, 30 Oct 2026 06:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC29606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=X0371SJevF519y+FyAxegceguZyUW/5BWi
	3LbfDEn5s=; b=W8CqS+rKD4+vKLb+VNpXGC+V8EpTCEZFWHWD6e7vO5oPAuvuWv
	OAkmfQJkdU2arKTwBrYQzxsDqN3wyt3nufIOCYBB510E2eFzbZvsWZzkPtUtQonc
	zpjgNOmuFK6uvLmrF/CY7I3yNL/nA9iUIe+McLMfWtR8eSRf2C7g4ypgs=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDW_gRoMuRqdYcHAQ--.5955S2;
	Fri, 30 Oct 2026 14:00:10 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v3] media: dvb-core: prevent frontend thread resurrection
 after unregister
Date: Fri, 30 Oct 2026 13:59:55 +0800
Message-ID: <20261030.pref-01.1bb885fdc3d94a60@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261027012542.5029-1-25031212351@stu.xidian.edu.cn>
References: <20261027012542.5029-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkDW_gRoMuRqdYcHAQ--.5955S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x
	0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr_-PUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rjY8F8lgAAsL

Hi Mauro,

Could you please review this patch?

  [PATCH v3] media: dvb-core: prevent frontend thread resurrection after
  unregister

It prevents the DVB frontend thread from being restarted after the
frontend has been unregistered.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261027012542.5029-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

