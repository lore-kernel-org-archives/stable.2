Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5E265620;
	Tue, 18 Aug 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059393; cv=none; b=XshgKlZKaPrKoex69ilShRb/1+Tu5s48zSEd6gbXw2rG86QMgnIcLTLeVG+IeUBXfuFMGIFepm0VxhIe9RfQqiPPaV/8eSgZNLuN85JSWIYV4w/nx7SFNORMirpU8JTe1lMzMGQ2OwgcMkHBCYe8KqTNVdPePj6jX5LWfY6eW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059393; c=relaxed/simple;
	bh=rKLsA3aGNbgt2pa2mIymRT1P8WdpYnV8vAbLjWJUaPs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GAOkAY4JgNvm+7MsPkeAUylzbVUfprUlqXUNXr4TRrx0tsWftSIoRanY0MoG0lmaHEoUCEGEn3xh3+4VwWLtxWZAlYKxrk+WxQCJC5W1fVo+2Rc36KCkFz5EQ5PdtvXohyhFkwN0ORWPIpFzjXOM3Hk/wti4IDuUj53To+ZSCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.97.62.103])
	by mtasvr (Coremail) with SMTP id _____wAnAX62XIRq+jWkAA--.11144S3;
	Tue, 18 Aug 2026 21:23:03 +0800 (CST)
Received: from smtpclient.apple (unknown [10.97.62.103])
	by mail-app1 (Coremail) with SMTP id yy_KCgAnd5+2XIRqdaz4Aw--.17569S2;
	Tue, 18 Aug 2026 21:23:02 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <20260818-ambrosial-courageous-carp-1162c8-mkl@pengutronix.de>
Date: Tue, 18 Aug 2026 21:22:51 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D2ED044B-6B32-4FB4-B9FF-E65497B84A25@zju.edu.cn>
References: <20260818063832.383829-1-fanwu01@zju.edu.cn>
 <20260818-ambrosial-courageous-carp-1162c8-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:yy_KCgAnd5+2XIRqdaz4Aw--.17569S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?YUXfcQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGHAYlwMLSMXGSVoKbAzcD4niq98Nj4ItGd8L8jX8/TLZXz
	oEyL/WX6XoCu+ioMtz8Qig7m8RJtowMQOTNUOYX5
X-Coremail-Antispam: 1Uk129KBj93XoW7urW3AFWfKw4rurWfGw48AFc_yoW8Xr18pr
	Z8Wa17Jr1vqr4FkFn7ZF4vqryUZwnay3yrA3s2vry3Cw43Xr15WFWYkrW8Way2k3sYq3W7
	Kw18Z3s8JFn8JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

Hi Marc,

Yes. The driver has three timer_delete() call sites, all for
bec_poll_timer.

The calls in kvaser_pciefd_bus_on() and kvaser_pciefd_stop() are runtime
cancellations: the CAN device stays alive after both, and the timer must
stay rearmable for the next open/bus-on cycle, since the interrupt
handler arms it from handle_error_packet(), handle_status_resp() and
handle_status_packet().  Converting either one to timer_shutdown_sync()
would make those later mod_timer() calls no-ops.  The stop() flush-timeout
path, which skips its timer_delete() entirely, is also covered: the device
is still alive there, and remove() still shuts the timer down
unconditionally.

kvaser_pciefd_remove() is different: its timer_delete() is followed by
free_irq() and then by the final free_candev(), while the interrupt
handler can still rearm the timer.  That is the call converted by this
patch, which also adds timer_shutdown_sync() to
kvaser_pciefd_teardown_can_ctrls(), the probe-error path that frees the
CAN devices after free_irq().

Thanks,
Fan

> On Aug 18, 2026, at 20:00, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
> On 18.08.2026 06:38:32, Fan Wu wrote:
>> The bec poll timer is rearmed from the interrupt handler, so the
>> timer_delete() call in kvaser_pciefd_remove() neither waits for a
> 
> There are more timer_delete() in the code, have you had a look at them,
> too?
> 
> regards,
> Marc

