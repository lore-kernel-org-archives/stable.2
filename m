Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFE302753;
	Wed, 19 Aug 2026 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121638; cv=none; b=Mo+82G/FyFaKKpTRO/vJjU8r5DqpSQULNcwfbyZ0CQqkNeg7RjuAJ6aA1UzsjLHhkU7kTQTcq0vw+xJ6WGPWCV4PKVmsuyJ/GR322KB52e2fodEo7q5PdhptGqxoy0bv1uLRRYAjMCGJR9zfjDxS0kMwEMrinxWVQBZiB6VnkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121638; c=relaxed/simple;
	bh=lxWU45Bto7KMCpNbz5PO8YKIa/YktYWn+MjkaIXISCU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V1n5rNRSoNoAWEPoUCkH3QDOnXQtqj7Et4R2Gs+/O/X7myHXPTh0+Qaet+wBircOp75n7lTfsAWqLtzKaHyzy8j6wd4VWj+WYjTzBDX5CI1eau2QGZOauFu4UI8p29Qvl8bGFy1vz8zqpMWmOlsy+Fzeb9YWmgeeAgHNAxvdX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.97.62.103])
	by mtasvr (Coremail) with SMTP id _____wCnvny_T4VqtJ6nAA--.36202S3;
	Wed, 19 Aug 2026 14:40:00 +0800 (CST)
Received: from smtpclient.apple (unknown [10.97.62.103])
	by mail-app2 (Coremail) with SMTP id zC_KCgB35cq8T4Vqfrz9Aw--.39095S2;
	Wed, 19 Aug 2026 14:39:56 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown
 and remove
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <46936686-3bdd-4d36-9124-e8d3376ad5ea@kernel.org>
Date: Wed, 19 Aug 2026 14:39:45 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C6A3233A-A352-45AC-A498-0DED1EC57147@zju.edu.cn>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn>
 <46936686-3bdd-4d36-9124-e8d3376ad5ea@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zC_KCgB35cq8T4Vqfrz9Aw--.39095S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?su+KKgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI3EaNafmokmxSGacB/SiOKcuO416gdgVifUJNAsz9S/YwSp
	Wt05rizKujXnc7uVicOp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFy3XF47AF13Xr1rCw15Awc_yoWftFc_u3
	4UAw1kuw1q9F4xA3W5Gw1kZrW7tF429FyktryFyry3t3yrWF9xJFn2k34Iqry8X393ZF9r
	Cr9FkFyI93W29osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU


> On Aug 19, 2026, at 12:26, Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> serial core does not call the
>> driver shutdown on every path that reaches remove().
> 
> Could you be more specific on what path it does not?
> 
> thanks,
> -- 
> js
> suse labs

Hi Jiri

Yes. The relevant path is a console port whose last TTY user closes it
before the device is unbound.

tty_port_shutdown() skips port->ops->shutdown() for console ports. The
last close then clears the active state and dissociates the TTY, so the
later tty_port_tty_vhangup() in the remove path has no TTY to hang up
and cannot invoke the driver shutdown.  That is the path the cancel in
imx_uart_remove() covers.

trigger_stop_tx can already be pending at that point: after TXDC,
imx_uart_stop_tx() starts it for delay_rts_after_send, whereas the close
path only waits for TXDC.

I can add this to the changelog if you would prefer the rationale to be
spelled out there.

Thanks,
Fan

