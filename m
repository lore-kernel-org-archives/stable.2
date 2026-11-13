Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549932;
	b=n4cjBYQc8LKDxynYwSgWyO6xdZygTaQRiepqBNA1TCkjHdGhVDoPEdz7o/vql/gu4sDF
	 nxtKComtSEIxWFuT1EwuY/9L75GKSsjIqgLrYVnNwZarFiu1qTkZD2GgfXkro9jCnKiHd
	 hHSMEMCe/TA05a7UpKWw7VUEGmIwUOj3DE5gAQkzcvjjGmxrC67NqVCF5+f4nD8bhZ9Gh
	 IMmd8JtBKogtRugKiT6ojWiQjH+BgTgG9foyJu0A8CmzXkt9FDXTJ0pEDaAtIwL/F/CzH
	 vYp/55As4cnD1GYo4KY7FvaQMJPBpj5VXEjz9sww0LLy3RQY/0nO5+UBrQJXMF383PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549932;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Cw0aNhtrZXS8kFyEmLL4uH/j57aq3MotWd+22cVvZWs=;
	b=vmu9apUBQA3AyvJ8hC7lBxWUauwbWsyvOFRl+tuCmLtmm0G9yRrOpStiPDs94CtX0up6
	 SLLnjKxd9C283qUZcdq7n7TTriBaisboH2W867H/jVRUODz4xB8Zn+VFugep25iAsPOkv
	 a05TTVsFYuui+HxlNTYh3EnB29HAoKd499RecsipEM19BmqlMJGBuGjN6twQIGxhY7Ans
	 pSxQbe2z41Z7eDYHLk6Qq04cC/c1kOaRPFPSJxnHFMvte3+aIyWvTsbxHYQn8ehAKOZTd
	 LuCEPAEbPsIbgwdej37eo7Gs+qgj5Aolf37cXohjJdi0Q6GpOVKDr4dGJwraEo9Gdhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5+Ud+1vm;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22E606A31C;
	Fri, 13 Nov 2026 06:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E22E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5+Ud+1vm
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQmvZ1hYYz4yjT0;
	Fri, 13 Nov 2026 14:05:30 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794549930;
	bh=kEK/CdjUuLDdYkzvW76iRkve1W1+RjViKn+Zz6zXGgw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=5+Ud+1vmD13rXc430CPlOpc5b1o4JP+wdtbUUC+UMpnJEGP7yK6Ehi+5m9Ga0Ba8s
	 rUit8P3zcO201yaDBH9c14hTsrq1kQ3XGvTd92l/K97tcNZ7AspW5BONM05J/QYghA
	 MqY3GkVro3z66P8IgeIkiLLRa4/gVKL9rx6TyIxFFNLDoKniqwcnwvZOELtb94A9YJ
	 mSpyA2F7rGsJa+Wy4mcpXMN8lgE6AG7CgCQlq8myk/3k6TGS7lSndFcGtz6ubO8W6b
	 GAb/dwsJ9QAh/nZh2lSlPF1qqt1+IK8nSqh1vhG9PTnXI+gw8/AWFUglwrA6O4OjhJ
	 Wb3rR2LuAEgDA==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AD65HZX055158;
	Fri, 13 Nov 2026 14:05:18 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Nov 2026 14:05:19 +0800 (CST)
X-Zmail-TransId: 2afa6af6a89f931-79c0f
X-Mailer: Zmail v1.0
Message-ID: <20261113140519708mqg78DW--hT8RANbqMrZB@zte.com.cn>
In-Reply-To: <20261112211246.GB11126@lst.de>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn,20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn,20261112211246.GB11126@lst.de
Date: Fri, 13 Nov 2026 14:05:19 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <justin.tee@broadcom.com>,
        <nareshgottumukkala83@gmail.com>, <paul.ely@broadcom.com>,
        <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzZdIG52bWV0LXRjcDogb25seSB3YWl0IGZvciBpbi1jYXBzdWxlIGRhdGEgZm9yIGlubGluZSBTR0xz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AD65HZX055158
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Nov 2026 14:05:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6A8AA.000/4jQmvZ1hYYz4yjT0

On Thu, Nov 12, 2026 at 10:12:46PM +0100, Christoph Hellwig wrote:
> Nit: this would become much more readable if split into multiple
> conditions instead of this giant compound expression.

Agreed.  I'll split nvmet_tcp_sgl_is_inline() into separate checks and send
a v2 of the series; the other five patches are unchanged and keep your
Reviewed-by.

Thanks,
Shao
