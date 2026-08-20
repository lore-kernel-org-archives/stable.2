Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB224B28
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192512; cv=none; b=hZvKndQUbus5czank+YnP9K7EEzD7ibp6JdCqv4ja8GQ11T0VIvyDS04+rc+ExDjwjlBEhzmZSMsQrC8QV37YE0YNdjg0sMWzpQcCA3j5BP/XCdLLqOk+rhfk0zsqCS0Ic43a6SmpRXbabz8dWGFMOPLfHOWAw1fkuwrlojI83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192512; c=relaxed/simple;
	bh=+1Mtc0DAwThmhOk+bT3NubaMhQKKDxz84BXajDMgmYQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q1mDoz48Y3SzMjdCBCXTHbjFMKaei3oe4zfMrP2jJm3TvS+tz6DbV3gPjH//c3cw8xZhPR9I1cyLKhd1EcZbklgCYmsuta9WyWMzre8UYx8tTdozWEQdICrMkStEdl5qv3zmiXe5lrac/1uUhfP0Irabro/eHsa7cWeSrP4Wgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=HPsiDrUU reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="HPsiDrUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:To:Cc:From:Subject:Content-Type:
	Content-Transfer-Encoding; bh=+1Mtc0DAwThmhOk+bT3NubaMhQKKDxz84B
	XajDMgmYQ=; b=HPsiDrUU6oEsU93ZBJymsC1KKPriZ4LV+qWcOa/G/aLFBv9xEQ
	QsdQQEEXmJi69JT2JFyRcXM0EZGjfbtXCtc7LM+5toBJG76FT4ZezCJhoxQ3xNCH
	/8s6akqufmvIZnfeEUp+wAoVyK0BDSct9erLbHkDCpR/FhIZSk+WLS8E0=
Received: from [192.168.1.109] (unknown [115.53.140.193])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAmT4i1ZIZqTt98AA--.23275S3;
	Thu, 20 Aug 2026 10:21:41 +0800 (CST)
Message-ID: <6a7c009c-8e26-455d-bbe1-1afc3381ed76@stu.xidian.edu.cn>
Date: Thu, 20 Aug 2026 10:21:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, deller@gmx.de
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Please cherry-pick commit 81cc73be40c6 to stable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkAmT4i1ZIZqTt98AA--.23275S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27k0a2IF6F4UM7kC6x804xWl14x267AK
	xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvEwIxGrwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x07jY5l8UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWqF8pNBywAAsZ

Hi,

Could you please cherry-pick the following upstream commit into the
active stable trees?

Commit: 81cc73be40c6f028f1ee3f438ace46afe666dbae
Title: fbdev: core: Fix pointer desynchronization in fb_io_read()

It fixes a deterministic out-of-bounds (OOB) hardware read caused by
a pointer desynchronization when copy_to_user() performs a partial
copy. The commit has been merged upstream and contains the Cc: stable
tag, but it seems to have missed the recent stable queues.

Thanks,
Mingyu Wang

