Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340129;
	b=3/VRQwGOuWGO418SIqCMVdCrnBg97e4kPo4KrOsn0XQNTUsVQt6BtEANW/aLjgr0oXCr
	 iIl8gmhFIzhWTjBc7GhpmCpG3VTHLP9My6zEqtJUrE0ivE9yWvVzdpex8u4ABAk3Q07z/
	 lNsQkiR4s2Tcpeo3ZB3+8GhVAlcJ+5RWojiIZMw1dci1n8GgW/qmwZ2rwgK+oCMOVNAlk
	 sJldWNKlnY8BwCAEdDG5gzvvoxb32w6ZFYrFpp0vmBwdkk8yBU1CaabPq92COcjnEquh2
	 /olgKX5UGUjOU+gxTVMKiFWXUfYRGpXY6WljQRwwpQXeCaYCWS+i6jtb/T8quTw7VVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340129;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=GXYrVMD8tIwM2KrzF3PYSm7iqQWOWiytKfsGCC1S/Hw=;
	b=UT1R4JbzWjdX84/6nIDiILe8tcc4rAlR99HtKX3pRZs0CBFdnkrYIHsl4rwt8IsI7Dgm
	 MOeaNVK9LJITglAIGCUyEWsGRtkUnjppXlwsT11me9ykXfzzLgvX0ZMsG8PXSGxovHjb9
	 tW/behBYfKPFotO38mDPPLlI+M3UToVpGjNjuthX30SME/ievTwX1DpULmLEiTBq5JDsy
	 HK8qp1VZmMYLDPD10xie2RtP0zLCPkv0pSek6U0YT3a/2aSus5VB7533Vcxvhmb31yUxi
	 Ak1qnt0hwtsutixAPoq8tAmK+xmYv6MiFUlSa0MDHKPBe9QJVKRiYl7SNcD8WC+NGGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB4606A339;
	Fri, 30 Oct 2026 06:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BBB4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=GXYrVMD8tIwM2KrzF3PYSm7iqQWOWiytKf
	sGCC1S/Hw=; b=V2LSHhfoqknpUN0v/DskYYdxnYkkviKVlOahhHR9v+dtU8Kv9W
	J42W8n/oymb37XpvleNTmHy2limJdaFOxP+bdlSmz3xvE6F2QWpjPPYjx46OnOyc
	OsiPyW2u8J/g/kUeMbCh21Y+H5bPnSu+/fztdoO/hEuVVr98gbeGPi8d4=
Received: from localhost.localdomain (unknown [223.160.172.89])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCWmfzZMuRqvAYHAQ--.7328S2;
	Fri, 30 Oct 2026 14:02:02 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Fri, 30 Oct 2026 14:01:51 +0800
Message-ID: <20261030.pref-07.7db2853141714bbe@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261026123628.7493-1-25031212351@stu.xidian.edu.cn>
References: <20261026123628.7493-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCWmfzZMuRqvAYHAQ--.7328S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYG7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vI
	FxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7
	CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8JfHUUUUUU=
	=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rjYVR+NQAAs+

Hi Mathias,

Could you please review this patch?

  [PATCH v2] usb: xhci: Fix use-after-free race in xhci_stop_device()

It synchronizes access to the virtual device and its USB device pointer
with xhci->lock to avoid a disconnect race in xhci_stop_device().

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261026123628.7493-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe

