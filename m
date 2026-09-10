Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412530D3E8;
	Thu, 10 Sep 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019467; cv=none; b=i8SY/ldp1rt9NNVOBry9sxsuAoJmfHt0SDurL1KZzAhvySRvgYookB6uXZK0XD5+0nRS8+AVksxDYHIhTkM1VzgjonFSuIC7SYfqBfw2aYSAq2LIqmOho0p3vK6IUNbTk90DciCwFUawxFl+AEnyD0px2bxTkUEBR8M7f+s53Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019467; c=relaxed/simple;
	bh=DrXfTS8ZxyUDNE5U6sJBSOlmwS0hqMzaEq5mQxDQUFA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fM2fT3col2MhTMeNgIDJjnsvC663lEqYb6nAi+8IghBVvTWGYP0+/JeAkX3G7Xn04G8Ls0lR1Sec6H4ZLEhRKssqJHHuusGu38A3r2rvZl+Gj98n98gstfm6KQwuw5679wv1xe2pHrYhaU/Dd7Xfa0RuIy3sVI5GooDWqOQTs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.40.33])
	by mtasvr (Coremail) with SMTP id _____wC3Yz1ARaJqE6kFAQ--.2549S3;
	Thu, 10 Sep 2026 13:50:57 +0800 (CST)
Received: from smtpclient.apple (unknown [10.192.40.33])
	by mail-app3 (Coremail) with SMTP id zS_KCgBHX3FARaJquhMPBQ--.5303S2;
	Thu, 10 Sep 2026 13:50:56 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <aqIVzxZyRyx67GPX@hu-petche-lv.qualcomm.com>
Date: Thu, 10 Sep 2026 13:50:46 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 linux-usb@vger.kernel.org,
 Pawel Laszczak <pawell@cadence.com>,
 Roger Quadros <rogerq@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Song Li <songl@zju.edu.cn>,
 Sicong Huang <congei42@163.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4BDFACF5-50C7-43B5-861C-9467B6E3D819@zju.edu.cn>
References: <20260909095655.694527-1-fanwu01@zju.edu.cn>
 <aqIVzxZyRyx67GPX@hu-petche-lv.qualcomm.com>
To: Peter Chen <peter.chen@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgBHX3FARaJquhMPBQ--.5303S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?WHDvpwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNB66d1lXcKtjZp12WNyL+NGUIw2xCv9nnYIkgX6xtv+Pvs
	3eJmM/Z+qZRsjNnOb0wB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1ruw1kCF45CFykWr18CrX_yoWkAwc_Wa
	yvkr97Ga1UW39rAwnxCr15Ar93GFyxWa48Ww4qyFWfC3yUtrs8Jr18Gr95Cr43Xw4fKFn3
	A3s5t3yfur9rZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb-AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

> On Sep 10, 2026, at 10:28, Peter Chen <peter.chen@kernel.org> wrote:
> 
> We may cancel work before going to de-init. How about move them before
> 
> pm_runtime_put_autosuspend(cdns->dev);
> 
> 

Hi Peter,

Thanks for the review.

I think the work items need to be cancelled only after the gadget has
been quiesced. Moving the cancellations before
pm_runtime_put_autosuspend() would run them while the gadget driver is
still bound and requests may still be queued.

In particular, an EP0 status request can queue pending_status_wq from
cdns3_gadget_ep0_queue(), and an endpoint request can queue
aligned_buf_wq from cdns3_prepare_aligned_request_buf(). Thus either
work can be re-queued after an early cancellation and before
usb_del_gadget() unbinds the gadget driver.

usb_del_gadget() performs the gadget unbind and synchronizes the gadget
IRQ; devm_free_irq() then removes the driver's IRQ handler. Keeping the
cancellations after these teardown steps ensures that both works are
drained before cdns3_free_all_eps() and the aligned buffers are freed.

Could we keep the current placement?

Thanks,
Fan

