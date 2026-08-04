Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176044998F;
	Tue,  4 Aug 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840129; cv=none; b=KcLGaRSeVg1ByrsYgEmxqs48RIideC5qSlzEs66S/0wEvOhXAMgnySMcK4AnNsquG2UtONopjs49IIG6JkpAMYZXq5KwcBB1c4dnI4G/yt+nJ1GHDG1WGo+KPp+B0MpfkfRsvPhjZL1KXz3KvNQUt/MbSVgiFTOkqHEpu46lC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840129; c=relaxed/simple;
	bh=WTo0rdPyb4dnV0ZLhVfdxGqsoXq5+8Z48HZSCO9kRnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKHySIm+3uMC8Z8WnFlAmWBvrCS4FjFWeSXBy4CaO1hQPgwBNs4O1DVNzADr8NDb67DtE69QuN4o7YFL4ugr5X824zQzhQrRaEzX9nwKKbWK6I/z6Y1zRID2USkY6mfoGQKny08+tuGnBWVRkCgArnNu9uod7EBLpgFMqa7D018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=60WPnwuw reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="60WPnwuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=WTo0rdPyb
	4dnV0ZLhVfdxGqsoXq5+8Z48HZSCO9kRnY=; b=60WPnwuw93fsWbFJcwPMlrfKw
	/BNjoEHwEs4K8prouW/wx4/t2LmfiY8thVkBuEAACt6H4OZ9WT9y4elfuHgO5xhx
	65klLU/loJMJL6vEV4k2XWo/jlU8ubCIN+Ges/77EAhwdspwNrMnaW2aLjGxzUiW
	9P9N5j5/GE7gsz+khA=
Received: from [192.168.1.110] (unknown [115.53.140.128])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkBmiA7jwXFq92ndAQ--.1748S3;
	Tue, 04 Aug 2026 18:41:40 +0800 (CST)
Message-ID: <f79bc014-a606-4ab5-adfd-1b56dbdc30ba@stu.xidian.edu.cn>
Date: Tue, 4 Aug 2026 18:41:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Johan Hovold <johan@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
 <8d507b50-b5a2-48a8-a4bb-f196ac28b5e4@suse.com>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <8d507b50-b5a2-48a8-a4bb-f196ac28b5e4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkBmiA7jwXFq92ndAQ--.1748S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1DGrW3XFykWF18Zw1xuFg_yoW8ur4kpF
	W8Wryakr4kZa1kKayxXw4UCFyFg392yryYgr95Xw4Ivwn8KFy2yFnIg3WUXrWxCr4rG3Wj
	qF40y3W8CayUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5qPftUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUPEWpwsH1ogQACsl

Hi Petr,

> I'm confused by this description and I'm not sure what problem the patch
> is trying to solve. A task is not normally terminated in the middle of
> a syscall. This could happen only if it hits an oops. However, that
> means there is an earlier bug and the module loader isn't expected to be
> resilient to a post-oops state.
>
> Could you clarify the scenario that you ran into?

Thank you for the review. You are entirely correct; the task did not
terminate during a normal syscall, but was indeed killed by a prior
oops.

Here is the exact scenario discovered during driver fuzzing by our
automated virtual device modeling tool, DevGen:

1. A `modprobe` task (PID 433) concurrently loaded a faulty driver
    (the `atlantic` net driver in our trace).
2. It passed the idempotent() check and added its stack-allocated
    `struct idempotent` node to the global `idem_hash` list.
3. During init_module_from_file(), the `atlantic` driver hit a fatal
    oops in its hardware init path (aq_hw_write_reg+0x39/0x50).
4. The kernel initiated oops recovery, terminating the `modprobe` task
    (exited with preempt_count 1) and freeing its kernel stack.
5. The oops recovery path does not clean up the `idem_hash` list,
    leaving a dangling pointer to the freed stack in the global list.
6. A subsequent module loading attempt traversed `idem_hash`,
    dereferenced the stale stack pointer, and triggered a secondary
    KASAN use-after-free and GPF.

While the root cause of the initial crash lies within the specific
buggy driver, the current stack allocation allows an isolated driver
oops to corrupt a global synchronization primitive, preventing any
further module loading across the entire system.

By migrating this allocation to the heap via kmalloc_obj(), the patch
prevents the global memory corruption. We acknowledge this leaves a
leaked node in the hash list. Consequently, subsequent attempts to load
that *specific* oopsed module will hang, but the rest of the module
subsystem survives and functions normally.

Thanks,
Mingyu

