Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794029738;
	b=aomNyY8sJZxRcAn5gH1MyUBLHVhjIMXQztOxuDAxU4cwC2EhjHdfs2MXn37S5vo20PnX
	 IWxG0xMhHf/4ecJ2UHbYGuJVrtQT7moOONahZivJkXhRgcQR92fc7OpKtQYTnUNJIqYS8
	 V7wbfwfl/8LaJrrqecyPha7xCHyjg/Ubh8Q4hAgmUOHjAECd2+jwHHPuoqFCQdy3ronLk
	 n5e+czG7bDITJbNPxmnEyLalV3NedaSSZFYj1f0G5pNA3xqicpo58+qF/qt/gnOLe4dyZ
	 ugzYt5zRhNIzNcQYRGzajAEas1yaCYslj73rUMRi9GIG5CB/7g2volBev/EjcDyK4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794029738;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=4BU3jWG6HgtUEzCXO9L6HXY2c3GFaOpgCDBfsihICbY=;
	b=cc5M/e4ZfZRri2/Xk9y/dsKtWhO9NZzhlFZ2GydC8l9rBdqM1/C0tEaSwjeunKszGztI
	 QkJ7tzfDSlzgY3dD4MyonVL+e8B/I6E00cOAXAjlQ5O8UMHsUowEWjUZYSDelplh6HCIk
	 3ypiPuIB7okIFTdqPO61/lDr46bPiMnuCutXC5zB8nysyCY7ccQ9K/H3/eHDjSKSRn3nG
	 YnnbHZRsbbeULVvW57lqtCQx5YhDYFuzREF7V0Y7HdQWhrjUW8Gnl6IABzCWjwjyx1x/r
	 6FQE4uGqhg5wP5rmoThX1I4fy2OWjxLCGmUfJsYL8aVgZpTPryJ702Q02abK/kjhX0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0D606A326;
	Sat,  7 Nov 2026 05:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD0D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QZKauO5qndt5AA--.17203S2;
	Sat, 07 Nov 2026 13:35:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: enachman@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: prestera: release the ruleset in prestera_flower_prio_get
In-Reply-To: <20261106121731.GI865646@horms.kernel.org>
References: <20261103100532.1309990-1-vulab@iscas.ac.cn>
 <20261106121731.GI865646@horms.kernel.org>
Date: Sat, 07 Nov 2026 05:35:17 -0000
Message-ID: <179402971765.2318769.17775485131459248250@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:rQCowAA3QZKauO5qndt5AA--.17203S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF15tFW8Jw4DKrW8Jw45Awb_yoWfXFbE9w
	4vy347Za1UAF17Ja1YyrWYvrZ3Wr48CrW5Z34rXr13try5ZFZaqw1vkrZ0yw1SqFWUAFZx
	Jr1Yy3yYk34qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bnXd8UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUEA2rucA5nSwACsP

Hi Simon,

Thank you for reviewing this patch and providing your Reviewed-by.

I apologize for the delayed reply and for the excessive volume of
patches I sent to netdev. I also failed to follow up on earlier
feedback promptly, creating additional work for you and other
reviewers. I take responsibility for that.

Your concern about the submission volume is well founded. I will
personally go through the outstanding feedback, review each comment
carefully, and respond in the relevant threads. I will respect the
posting pause requested in the earlier discussions while I address
that feedback.

Going forward, I will not send large batches of patches. I will keep
submissions within my personal capacity to understand and validate
each change, and to respond to review in a timely manner.

Thank you again for your time and careful review.

Best regards,
Wentao Liang

