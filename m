Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511031;
	b=4hqT/1z7PfPyrJywQ+LxCfpXDkzYp/zd3MrxWCstH6uGLPskMQ/Pm9V/gIrJN00KCDYA
	 Mi8REUoGGm20CJeB7AQYN71iiHQyD7Y2uPBaIeQwG+HiRtZ/Agr9ZXo8jGUcZS9bl1K6n
	 3eeikRCGCDJbJ5LAiBpgB0LfsR5sZqCG8vVFIlU26Y6r1Zxd8DufRhd50i7iUtc9mfGxD
	 oPzjAK92jHnJudRIyg7rj4cuAKQ5iym8QPht9Vd3OaFLocWygQGS2DRmNupFRcj2YTAAA
	 jCN61hu6F/pNAzOScCzBEwHpS2l075V94HJs8zaHjtHU6/sK+AL81gXosjbSKVbYDqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511031;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+8s5J/Ij8rDmsLY8v0GD789s4jqD/QoQaBCQD+5CJeI=;
	b=OUmZy/z+nAqjS+DwLb6+7uXkVE9vZWrtTLkeUFUrCsMdXAvnzr5R4MAJnpB+TdTf2U4N
	 FemtpdwsAC2SnIewdkGpcOIrU0eAX1VGR9n5PogxA1/W2NxuRK0qYUBZIlGka0GkxF/Y1
	 zPGJVM6tAqmTW1EiTmvdnPQ5ixOmgszkZ2rM+/fFOmM01Cz8clOKx3qOe7SwaP06zR3zW
	 04wvkeO4Hbm/ViJyRtEX+elCX54nhAmASuaJezxl9NdTaescb7bcDLqExFRqIp/49tBCd
	 D/7dmW6Qk2o19wuRGCinJUNum6AxjQ0LXkrGgaUlSua4qoBbIG1cSDw4r+/q5Q/WazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E2606A31E;
	Tue, 24 Nov 2026 09:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jYcL84nJtz1rqCW;
	Tue, 24 Nov 2026 17:03:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D8763406B3;
	Tue, 24 Nov 2026 17:03:45 +0800 (CST)
Received: from [10.67.109.234] (unknown [10.67.109.234])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC3vgHwUgVrihQZFg--.18582S2;
	Tue, 24 Nov 2026 17:03:45 +0800 (CST)
Message-ID: <78cb7510-9e14-4632-bab3-01fce0b819fd@huaweicloud.com>
Date: Tue, 24 Nov 2026 17:03:43 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable/linux-6.6.y] perf, bpf: Fix NULL
 event->orig_overflow_handler dereference
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 alexander.shishkin@linux.intel.com
References: <20261124084837.2327711-1-luogengkun@huaweicloud.com>
 <2026112402-dictation-juror-2e5d@gregkh>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <2026112402-dictation-juror-2e5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3vgHwUgVrihQZFg--.18582S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kGF45ur4xWw1rZw4UXFb_yoW5urWrpr
	ZxKFZ0kr4DWF12qwsYyF1vyF17ur4fWrs8Jw1vy3yruayFgr93XF9rK34Y9FWfGryDCa4x
	tw1Ut34Yva45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

On 2026/11/24 16:21, Greg Kroah-Hartman wrote:
> On Tue, Nov 24, 2026 at 08:48:37AM +0000, Luo Gengkun wrote:
>> We hit the following problem on x86:
>>
>> 	BUG: kernel NULL pointer dereference, address: 0000000000000000
>> 	#PF: supervisor instruction fetch in kernel mode
>> 	#PF: error_code(0x0010) - not-present page
>> 	RIP: 0010:0x0
>> 	Call Trace:
>> 	 <IRQ>
>> 	 bpf_overflow_handler+0xa4/0x120
>> 	 __perf_event_overflow+0x11d/0x2f0
>> 	 perf_swevent_hrtimer+0x127/0x140
>> 	 __hrtimer_run_queues+0x108/0x250
>> 	 hrtimer_interrupt+0xfb/0x230
>> 	 sysvec_apic_timer_interrupt+0x69/0x90
>> 	 </IRQ>
>> 	 <TASK>
>> 	 asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> 	 __perf_event_set_bpf_prog+0xb7/0x180
>> 	 _perf_ioctl+0x1f9/0xb40
>> 	 perf_ioctl+0x41/0x70
>> 	 __se_sys_ioctl+0x82/0xc0
>> 	 do_syscall_64+0x44/0xb0
>> 	 entry_SYSCALL_64_after_hwframe+0x78/0xe2
>> 	 </TASK>
>>
>> RIP is 0 with error_code(0x0010) (instruction fetch, not-present), i.e.
>> an indirect call through a NULL function pointer.
>>
>> perf_event_set_bpf_handler() records the handler currently installed on
>> the event and replaces it with bpf_overflow_handler():
>>
>> 	event->prog = prog;
>> 	event->bpf_cookie = bpf_cookie;
>> 	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
>> 	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>>
>> WRITE_ONCE() is a single-copy atomic access, not a compiler barrier, and
>> the store to orig_overflow_handler is a plain assignment, so the compiler
>> may reorder the two stores. GCC 11.4.0 does; disassembly of
>> __perf_event_set_bpf_prog():
>>
>> 	mov    0x3d0(%rbp),%rax                  ; prev = overflow_handler
>> 	mov    %rsi,0x3e8(%rbp)                  ; event->prog = prog
>> 	mov    %r13,0x3f0(%rbp)                  ; event->bpf_cookie = cookie
>> 	movq   $bpf_overflow_handler,0x3d0(%rbp) ; publish overflow_handler
>> 	mov    %rax,0x3e0(%rbp)                  ; orig_overflow_handler = prev
>>
>> Use smp_store_release()/smp_load_acquire() to guarantee both the compiler
>> and the memory ordering.
>>
>> Upstream status:
>> Not affected. commit f11f10bfa1ca ("perf/bpf: Call BPF handler directly,
>> not through overflow machinery") removed orig_overflow_handler and
>> calls bpf_overflow_handler() directly from __perf_event_overflow(), so
>> the reordering window no longer exists. That rework was not backported
>> to any stable tree.
> 
> Please backport that rework instead of doing a one-off patch.
Makes sense, thanks for the guidance.

To properly eliminate the reordering window on stable trees without introducing
a one-off fix, I am looking at backporting the upstream rework commits
(around 7 patches in total, covering the refactoring parts from Kyle's series up
to and right after f11f10bfa1ca while skipping the new feature, plus Ingo's
follow-up stub cleanup) along with the bpftrace regression fix:

• Rework series:
https://lore.kernel.org/all/20240412015019.7060-1-khuey@kylehuey.com/

• Regression fix ("perf/bpf: Don't call bpf_overflow_handler() for tracing events"):
https://lore.kernel.org/all/20240813151727.28797-1-jdamato@fastly.com/

Once I finish backporting and testing this series, I will send it out for review.

Thanks,
Gengkun
> 
> thanks,
> 
> greg k-h

