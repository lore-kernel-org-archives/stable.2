Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5556A25B092;
	Mon, 22 Jun 2026 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782094499; cv=none; b=Uth1HIVqlEYq03R9VG+KYp1LHF1zlOPLwcUSKUfoV0O12mQu0kgxV1tmT7ZrUduqG0OXnn3j2SPMBJ1KozzEgDAR4zRavH56AaqkxPTsu7GtI39YrWvbmgv5V+mXRs52b8RtAZDmzYOEJfq5ZgzGffKfG6qEMC4nuUh8OWjW70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782094499; c=relaxed/simple;
	bh=hLAgi6PJaf3BdseRiaHAyoH7aPqwW/GU/uRfcjXAiMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thYzD6pBecKVYAW8+ZhrhzaFaeuWPq/frJtPNQni6xJpF4w5/oUU1uUUtbrxSuluwSie7sfgj1ncjtku2JGZjvmmsYO+X6H19gs7mBaSGV4WopdJkAk68I+2QJcEfpDjyHw+huhRV/Y7fQEgxLBkC4D9f0FG894Q1kj1HJY0qyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=AjtakNDq; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="AjtakNDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=hLAgi6PJaf3BdseRiaHAyoH7aPqwW/GU/u
	RfcjXAiMk=; b=AjtakNDq+diORRRcJpiN5ZYs0/uMr800UITLGZvS0+mzn463IU
	OL3Va5Guzhzs2UCpSydvipoFeRhQxZvo3F40GpVlTze6FtMVaQlT8M3Qv9J8wyOT
	f7aTgohlIS+ypbSWyEg5DMAfMvzTaMajcEtEP/KEWDNuXB6Z+VjEzzaiU=
Received: from localhost.localdomain (unknown [101.5.13.242])
	by web5 (Coremail) with SMTP id zAQGZQC3cMCImjhqxbCZAg--.9818S2;
	Mon, 22 Jun 2026 10:14:33 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	fengxw06@126.com,
	kees@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qli01@tsinghua.edu.cn,
	stable@vger.kernel.org,
	veritas501@foxmail.com,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] appletalk: fix use-after-free in atalk_find_primary()
Date: Mon, 22 Jun 2026 10:14:26 +0800
Message-ID: <20260622021426.68213-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20260616163403.GA827683@horms.kernel.org>
References: <20260616163403.GA827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQC3cMCImjhqxbCZAg--.9818S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYJ7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcV
	AFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAF
	wVW8JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4c8EcI0Ec7
	CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUs73vUUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgYEAWo1wh2a2wACsC

Hi Simon,

Thanks for the review.

I noticed that AppleTalk has since been moved out of tree by commit
8a398a0c189e ("appletalk: move the protocol out of tree"), so this patch no
longer applies to the current tree. I will not respin a v2 for mainline.

If you think this should still be addressed for stable trees or the
out-of-tree AppleTalk code, I can respin the fix there following your
comments.

Best,
Yizhou

