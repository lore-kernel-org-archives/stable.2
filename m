Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DD3603C2;
	Tue,  4 Aug 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824340; cv=none; b=i4XlB51Qb3jry7wbzLQkbbxoRNnO4niKWcMbqGEyz6Py4ImeGnbO3aGNzrD9ZbF0RuoNam4Fj5DarRMkigftOvGMgpXvoH54Z6jZKHps8OItBRwPUxF0lRdEt7F67rHD4Y0y2laNCsZFFV/o3Yuf9mTWKdeQ8+E8BE5AC/tbDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824340; c=relaxed/simple;
	bh=5fE3X1Wjtrr36x9FoDny7H2bXEFplz1eLA2gXJUQmy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZs//rMimDx/bxU2RZWgOocWzZ0Zxev2uDaN53m65xHaojvUvGK3kOrOQ3lBXeMIrz2QWF6qiKI6i5ktCyW8H6jPRKgZieuPf0Squ3bqjodLJgqDbisSLNGF9t9l2sYL3YgXD4cvRhrLOfj2XIlqWV9hXyudpwxadL1y42zaF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=EY6frFRZ reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="EY6frFRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=iwPMobUGJ
	b9Mp6jsLSzeM4wpVTSjA/s5fET8NykvjHY=; b=EY6frFRZEUZ7gu3TEv4cBWOdJ
	QJOXaEVBqRQQ4R6zTSIYGWoJf0r00N/0KnOyxnfvjONBOtZVrWXUvbnkIOUbKhIQ
	gqFdCJHyEcRKeStgkKGLkZ3TAhToQW7AhLsxjznEEo7T87zHOqEODe1Po79cpEn5
	tuBf4q0KhcgTTieqwE=
Received: from [192.168.1.110] (unknown [115.53.183.158])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkCW+9RAhHFqjD7bAQ--.20798S3;
	Tue, 04 Aug 2026 14:18:41 +0800 (CST)
Message-ID: <2459be1a-7507-4bc4-a235-09c18ca6b8a6@stu.xidian.edu.cn>
Date: Tue, 4 Aug 2026 14:18:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Johan Hovold <johan@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkCW+9RAhHFqjD7bAQ--.20798S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6F1UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRMnYFDUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUPEWpwsO5ougAAsM

Hi Luis, Petr, and others,

Gentle ping on this patch.
Please let me know if there are any updates or if further modifications 
are needed from my side.

Thanks,
Mingyu

