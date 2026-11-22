Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357912;
	b=Yhy/EqGHMFkxOYv2cT0GB2b89Py8N5M/smhuIvuvZqiJ7JpHovb0LlF1JGWhqPj1KxL/
	 hG9FP1apZBhJb1eca2lRx8r5Q245e6MqWwplDVWEL5wJnmK9NhTV7aSEDCiR9YxUptyuT
	 OD46dYFRg+vKQO0Y9aYoyAcGV3D5tBWpSodWCJJ4ViPF2nibiYFZ7f2wHpk1BJ6No5jyd
	 6TbgdH+Z3X9Bh8LIoqseCXFj1oZp2CSEihT0Lt/z1cqzRTUoiDo16mYr7ZoJu+saio9ws
	 UWDSSpqf0Wz5w+fPAhPgQTp8q8HgAxtiRcFPEXNWQNH86HlT8pUcd5RY+34YKfi3fbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357912;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=v0jrcO95QNbjtMp9ii5JuvvBFQFujvmXY7TE0yaao8c=;
	b=if/hAvrBc/dO7OElAHPOaQUEX49GH3mvi2FrlwPUqUBvfN7rfq8R3MXdCmTB+pSjTqNd
	 GzALBAaMv5Ftu0iGfRRGs1aKqmzDZQr/g5qWsVGhKyBLAejd4pTaYNkRtYFfCT1halC7H
	 JQWELfSBq8uqqeCJDCgcLqajrPnGYXdW6HYvy14RxXL1GJZ+KwqDBhIqnnLnC0goula4L
	 7VC7YBfl1Ivupdme2cO/C/etzv36fh7ApVD8elEGtUxEHhsebFJ9etMt1G9jyzG+MrNx1
	 pjLefPFTl1i9mS8/WBWMfFlJOnOZ6GCjFtK8ckkrbMOLUekyrNfG4PCQhR655AUIo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=K+ByQQKu;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC4606A320;
	Sun, 22 Nov 2026 14:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FC4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=K+ByQQKu
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXWjd73c9z8XrrM;
	Sun, 22 Nov 2026 22:31:49 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795357910;
	bh=u6c4MZjb9s2wR6f+AUHlY3U/e89ELkEpH1d6TgPWLME=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=K+ByQQKukJ4XEQhMbWHN191LDxGNIDikQYPKMOumIanTCkpB6AlEdnAW58NBrfBAS
	 UOXsEcCQFU0Z9ikOf/I81UBTKo+Hl/kOWIhGKsaqwQNl8cgm0bT3O/k3Q141vICNva
	 37DwuEzKN9tM++lA3DjbOMxAdfsNQTetW7oKDRa3qUtxllQiwM+BgwSC/igRaQP1Yk
	 ut0ggeOA9KcsrPS/Wc0D9wMtNNTLjCwpeCyDBLciIpPRtipcAltIzjNzoJhYxYOuzM
	 TUqf97+odKgfenSTdxiZ6xdiJ8szG4udNAHSpF5C4lHmD0khADPZxqiwkRBH8iSvYp
	 SZdUPMEYUzZqA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AMEVhj9024113;
	Sun, 22 Nov 2026 22:31:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:31:45 +0800 (CST)
X-Zmail-TransId: 2afb6b02fcd1e43-44a03
X-Mailer: Zmail v1.0
Message-ID: <202611222231458938QkRVDJ6-CnPlY9C-NaNY@zte.com.cn>
In-Reply-To: <CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn,CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com
Date: Sun, 22 Nov 2026 22:31:45 +0800 (CST)
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
To: <csander@purestorage.com>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzVdIG52bWU6IG1hcCBwYXNzdGhyb3VnaCBkYXRhIHdoZW4gdGhlIGxlbmd0aCBpcyBub256ZXJv?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AMEVhj9024113
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 22:31:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B02FCD5.000/4jXWjd73c9z8XrrM

Hi Caleb,

Thanks for pointing out the no-data command case. I tested it on
next-20261120 with a file-backed namespace over nvme-loop. I issued a
Read with a valid 4096-byte buffer, then reused the same ioctl command
structure for Flush. I reset the command fields for Flush and cleared
addr, leaving data_len at 4096.

                               Baseline       Proposed change
Read, valid addr, data_len=4096   success        success
Flush, addr=0, data_len=4096       success        EFAULT
Flush, addr=0, data_len=0          success        success

The earlier Read and Write tests only exercised commands that expect a
payload. With Flush, the old mapping check leaves the request without a
payload, and the command completes normally. The proposed check tries
to map the stale length and fails before submitting Flush. I haven't
identified a deployed application that relies on this pattern.

The case covered by 99fde895ff56 involves an offset into a registered
kernel bvec buffer, and zero is its starting offset.

I'll drop this version from the series. If the missing buffer case needs
a fix, I'll evaluate NVME_IOCTL_SUBMIT_IO separately, where the allowed
operations all require data.

Thanks,
Shao
