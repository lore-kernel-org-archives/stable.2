Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792649933;
	b=fhV7pbb++ziXXmuv+LQla8umFL009hyG8HWvLXgaQMuYntroP1XWVHiN0Gz31I6z/Ch3
	 o5+nqrqpSznLM/dm7ZdZRPTKLneFFSPsVsSHrnwS6dze3BYVViv3FlOf2x5r14qNuJ4m0
	 IOMQUIREc6P70z+nl1BIWb+turGAtStuugz6AFNj8ALi/By9pvgrGMsvg0F1cGeGDlcoH
	 8PPCL4tSM7KzVxQjWzqoVu1qYytWfjBAjINXeLU8nc83I4SqpTCVHuuLUMYbVK5H4GLeb
	 uq8NHMx8h7RaA9Y1kiDm6zF8Q20iPGG1nlEz0NniSXsDHOHR7ppNOmnZCMjoxUUZ8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792649933;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=sdkf6x2nSvsbqLuxdgn1+SU3gZJnlP6tWDG2RxdcBLY=;
	b=bmsTzLv5gXPtUXuFNo8cTemjsTU5HNCbaSrNXGOGOr+HbBTG7DCkodO3bj4mRls2b/ou
	 CTCdf38Z+r+XsOhoPAWftcstB3ggd6Tr4gczs+yL8Kyf/xDvj+3UJETxqoqR1zkqzG3Wz
	 bXSu7fDq+Q/MzuaqZoT3e2cu0syuxsePQa6JyKE5Ie3fdubZ+o7ODLKTUyw6KQ6iepXWG
	 ICEeNHyNIIXoZOPKP3vuOIjh3F5pAObUONfydcND4Dt/lb+BAvpKfP88VUjLOeu+SumOn
	 RCmErI9416dWUvy60OlhKCkROi/tEQi7FKed8xmrThTkgh4Gfj2wRkbAGFKCEz2nQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF0606A319;
	Thu, 22 Oct 2026 06:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAF0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ar (unknown [42.86.112.99])
	by APP-03 (Coremail) with SMTP id rQCowAAHDTvFqtlqS_5rCw--.2003S2;
	Thu, 22 Oct 2026 14:18:45 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: reconnect on peer reset even if the mdsmap says the MDS is active
Date: Wed, 21 Oct 2026 23:18:45 -0700
Message-ID: <20261022061845.2719518-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAOJNxR+bfs_g7t4qkZyfcWJAd2W51LH0skzzOpSztSZqCjuqeg@mail.gmail.com>
References: <20261021170613.1144381-1-sunyuechi@iscas.ac.cn> <CAOJNxR+bfs_g7t4qkZyfcWJAd2W51LH0skzzOpSztSZqCjuqeg@mail.gmail.com>
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
X-CM-TRANSID:rQCowAAHDTvFqtlqS_5rCw--.2003S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8rcTPUUUUU==
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwEIAmrZhhp5jQABsW

On Thu, Oct 22, 2026 at 05:02, Xiubo Li wrote:
> A few nits, none of them blocking:
>
> 1. It would help to say in the changelog that this is a partial revert:
[...]
> 2. The reproducer needs the client to send no MDS request between the
[...]
> 3. check_new_map() still warns on every non-zero return of
[...]
> 4. Nit: "replies with CLOSE (or REJECT if it has no session for us)".
[...]
> Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
> Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks for reviewing and testing. I'll address 1, 2 and 4 in v2 and do
3 as a follow-up.

Yuechi

