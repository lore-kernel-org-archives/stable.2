Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508192;
	b=ZvKAKLLpLdWyvX3RNbyHcUBSw93gwPFt9JqPNMJQ3S77+wdIBFnZwDUKzf04Tgk9JYPh
	 ANgGooxHLqfRDhOc4msAW5J09zK+fm3uY1TsBKTzNsHIlTvMNtxXCxj2AnFlSkLr8elNm
	 5bWERf4NI98Qy9quU/OWrAjLxL4cS0QNCxgrURRSYozolgc1X6sipgk6CuOc+iLJ/M4/b
	 Lg8PLmYTotO5+dC7jeKcS7mRpWrXbJmJB+n0NL9EpcW/TE0e/zU9A4L/I7Xbcmtl7FqGz
	 TTqab33tL8jiY8HRUPQYSLxuH/Qb2RuVe/upkEwDpqo8ACJG9/eIYa80vjpH6wVqikw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508192;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=gtfdC/ZGiUD1rSEakWBvxpLMWFjLacariuNQPtc6NHo=;
	b=uY7A+9tLPtG2EfKQD717XwduHND4VndV9oQw8qDqOUHxy/A/OSTyeFYzfjll2L7oP2Sk
	 ImoS5Ye96Qf3hxF6ORD56ilcRljtIudUjddEQH6B6XCffKMT6H8GXUSy//X9bWYZnhUs8
	 mcXdU2mjK9ecAcA8QGu3ynPpJuPQBTXTTIKkqp02d9KErpWdXX6syfNiU0FwlDsoDLmxL
	 3HhY6vR1xi+30ULva48rjMrSnPQ3kgu3a1zJK6q2VB33pEzeMXJL6rYqQjAUhYeedkQ0x
	 PKgoiIeD9ta+FuguBvEiGeq/AxLC4bvMFKugq95hDdebNNEGvQFxEDXMXn0kcEJ9DFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F4606A321;
	Tue, 24 Nov 2026 08:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 720F4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gtfdC/ZGiUD1rSEakWBvxpLMWFjLacariu
	NQPtc6NHo=; b=U60AGqju8XH/SNHj7POOxLFRH9tyoUT6c8KGsuLezccyJrJ/Jw
	B6kUoLYydOel2C3P/JO5XBBysO88J07KjJbsCBN1XTHnG129Q9oPpVOm2nW0zBQx
	NYaFZF8HNy71Kd0syxcQydwDSWgxDAIbEIesxd+ETCM+Pz+hf3k6NXINA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2u_7RRwVr66wkAg--.46263S2;
	Tue, 24 Nov 2026 16:16:18 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arien Judge <arien.judge@morsemicro.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH 2/2] wifi: mm81x: clear a stalled bulk endpoint before the next transfer
Date: Tue, 24 Nov 2026 16:16:15 +0800
Message-Id: <20261124081615.3496-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <vshptwv5idooqjvdirp5ssf2ofiff6tjhgjnzqgptte556uzem@f7kec5a632s7>
References: <vshptwv5idooqjvdirp5ssf2ofiff6tjhgjnzqgptte556uzem@f7kec5a632s7>
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
X-CM-TRANSID:BbQMCkC2u_7RRwVr66wkAg--.46263S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18tw45uF4Utr15KFWktFb_yoW8KF4kpF
	WagrZ8tr4DtrW2y3WfZr1UtF1rAw4rJa47GF15K39xZ3W5GrySyr1FgFWYvFyUCrnag34Y
	vanIq34Y9a4DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUyQB_DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2sEVtikXAAAsV

> I applied patch #1, but this one seems .. interesting. Have you run
> into this problem? Do you have a reproducer?

Hi Lachlan,

Thanks for taking patch 1.

No - not on a real MM81x, and I do not have a reproducer. I should have
been explicit about that in the cover letter. Let me describe what we
actually saw, so you can judge whether the patch makes sense.

The path involved is the register/memory access path:

  mm81x_hw_otp_read() -> mm81x_reg32_read() -> mm81x_usb_mem_read()
    mm81x_usb_cmd()          cmd urb on the bulk OUT endpoint, wait
    usb_submit_urb()         data urb on the bulk IN endpoint
    wait_event_interruptible_timeout()
    completion callback      musb->errors = urb->status

We drove this against a USB device model that can answer an individual
transfer with STALL or IOERROR instead of data. On the guest side those
complete as -EPIPE and -EPROTO on the data urb; the driver stores the
status in musb->errors and reports it up the stack, and that is the
"nonzero write bulk status received: -32" line in our logs.

The important part is what the model does next: it answers every
transfer independently. The next transfer either gets a freshly injected
status or completes normally, so the endpoint is never left in a halted
state. The model therefore cannot exhibit the failure this patch is
about - after -EPIPE its endpoint simply works again.

So the statement that the endpoint stays halted is from the USB spec, not
from observation: a bulk endpoint that returned STALL remains halted
until the host sends CLEAR_FEATURE(ENDPOINT_HALT), and on xHCI a stall
only resets the host-side ring. Whether MM8108 can leave these endpoints
in that state, or whether a STALL on this interface always means the link
is gone, is something you would know much better than we can tell from
here - so we would rather leave the decision to you.

Any of these is fine with us:

 - drop 2/2; patch 1 stands on its own and we can resend this one if a
   stall ever shows up in the field;

 - keep it if you consider a bulk STALL reachable and want the driver to
   recover instead of failing every later transfer on that endpoint;

 - or go the other way and treat -EPIPE on the bulk pipes the same way
   mm81x_usb_urb_status_is_disconnect() already treats the status
   interrupt: mark the chip unresponsive and stop retrying.

Just tell us which direction you prefer and we will follow it.

Thanks,
YuanZhe

