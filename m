Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148A3C1D5E
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893402; cv=none; b=VIrb6/h12gzJw/CaOFvNQ0YqM62d7tq5aAFCTBxMrwc/0VrNokcXdEI1n+nd/PaXuZU3WuWwzGwLTExNTx+CethHJ33ti+uTRSKLq97DA5F54JJ+gPMl1J+Pp85b8Uyef5hfo+hvQ7HJdEsKnWXVhCvpcSZbK4qbL2GG8H6EyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893402; c=relaxed/simple;
	bh=M+wPeWwztp48tQ9qKtDyy8FDQr3NRT/x27ohW2wCg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=FqlQotJl9VFLbUP+WB0SBLluhsB2wCuBjRL/npjxaXdwkLbSr8QLtEnBiTzety8mGGePRiWGDCpK3NSA/k0+SyCbx6VKOmEeId91WA4L1tDJO7MuBaMybHtu7TN9ukbt5QtI04wVOXS7DIX2ZLv0rWxm9JFm6FOU/8TZeo2IUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Scs2K5q3; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Scs2K5q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Message-ID:MIME-Version:Content-Type:Content-Disposition:
	In-Reply-To:References; bh=M+wPeWwztp48tQ9qKtDyy8FDQr3NRT/x27ohW
	2wCg0M=; b=Scs2K5q3kQgXw0FR9FfEIIFgXgRLwl0DvlpBuXPFsDTOGfoaAvjdo
	XFZYB1FK5mXnnBuO6URTs0Q8WNGoRBuGSM/1KwXQNLuIzNG46ku601r1x5soUzx1
	Pt2bLTBAmkujnoV95iQzuRDY4U37xG1MlbVILh2ePK7u2BPufKhghU=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHeiGJFpFqcNOsAA--.684S2;
	Fri, 28 Aug 2026 13:03:05 +0800 (CST)
Date: Fri, 28 Aug 2026 13:03:05 +0800
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: w@1wt.eu
Cc: ast@kernel.org, daniel@iogearbox.net, security@kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	tao.lyu@epfl.ch, gregkh@linuxfoundation.org, ameryhung@gmail.com,
	stable@vger.kernel.org
Subject: Please ignore the four patch follow-ups sent earlier today
Message-ID: <apEWiWm3Hq6TPams@DESKTOP-F439VFF.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apDx0_GdOE3g65qd@1wt.eu>
References: <apDx0_GdOE3g65qd@1wt.eu>
X-CM-TRANSID:3pYKCgCHeiGJFpFqcNOsAA--.684S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYG7k0a2IF6w1UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
	6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26x
	kF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l4iUUUUUU=
	=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Hello Willy,

Please ignore the four patch mails sent earlier today in reply to
your notes (fp+0; the 6.6.y backport of 12659d28615d; and the two
dynptr stable equivalents).

They were generated and sent by Grok (xAI) without my review. I
had not approved those mails.

I will follow Documentation/process/submitting-patches.rst and
resubmit only once I have checked the patches myself. Sorry for
the noise.

Thanks,
Xu Yunxiang

