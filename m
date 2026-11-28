Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795871498;
	b=KqEwqRCmGASYb7MVjFqjyViBhavU6hmrb160VqcOcqL95KUahWNARJUONENmSA6FXp3I
	 447EOhAo0xlfGc7HA+8RMOo3vkKehcMZ0ng8Wk+nm0WWDYVZ4GBmh1PEylu221l4HJpIp
	 elzEvFIfN7npG3UsA/Ojm2GmdFlc1BEMEVmDA5WnCHx7XGMqq9AsVJXRyyDe85OyQkymV
	 Ff1IieLS/XtJvNFDE+Lkxg+0q/CjEPcmkASrsQHz2wBOcxaKciIsW1PAmQffszlR/liSi
	 i9MjIyvNcOP0hUoE02k71B9gYYiLwUG09J1zG9DyTRksZNmt/l2OS/FF/b7kAtfuSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795871498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
	b=BTsIJOkRYdAwIUp16sfNS3Y8sbgkMBqTnwXptqlJP3fS/ClFSyakDME1PFP+xg5TbUGs
	 7RrPHZyevWxpTECzEdX82ivOt5YFAxStgQxnI77/78YdtLiksHI/uooTHoEbIpFhHFt6T
	 ju1rJdhZKaWuuIYSxA0ROW6PdalhJp55FaEQyRTjHfOJ0G3AJAE32dJvOBr7lnuQkJorc
	 tSiIjrKh1H0wm/GF9ZkX/0IcG3EKY5pGKp75dm2IhoCyir06qeHPHqdw/zR51WeQTCp8x
	 hp6pXfg+lM8BuNpM6GykiEsLWXNcYl3y1qWlHd2MMF/WfgP4M09LVCcw+CMqlu5YuhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdxDblNc;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475D606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 13:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4475D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdxDblNc
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso72286eec.0
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795871497; x=1796476297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
        b=UdxDblNczEsg6WXfIEEEl2cK+cbtUyZn/pGAKpHrkx7yY+hVH4Y99cmI4F0eUn+2L9
         daLAcCZjGFUTHAkPM1ltahKiaXxp6e9Oh2l11p4+vaMguHjdpeI/Q65+zMoA9lh+cd8z
         wQiKxiXPX8hTem/bWZIPXFqghFw3R3dRq/nW3iIt9+ITtOrZQNNE2ClQLL0OrVeB+YNQ
         29w4LCadpjtPKqT4hmrsoNjeV4qfuRSsSslgVzoZo7IWzqPtHE/JTzmmhDGHnWfOP9BB
         c6rwHKjj5G2Du+y02lmS8eAb+EiX8NfnDHOcrF7g5rWChENqzK4a55DsHsNN6AKY7yqf
         rX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795871497; x=1796476297;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Znno/6cdjeGyh4QHR1BzUSwOFxc0tW9FZcWjMXNlod8=;
        b=NcpD8HSU9bJViSxfSfiHGadx++peS/ZeUfV3vOgbz1fRkuyVSpMB66qqv0f6Z0iDhh
         Ncf4PaRxfC/62BRejQqojjfFasgA9mBeqp6Go/5wyF4aPHsufyb5+hrYKfI95s0/MTHJ
         549tMZTCyZRy9kYePOSU5PM6RflfPe80SuZd7fJEusNj+sTTq+zz8c+tqqHVrPpkLdWX
         96msV3r5BqIK+mAIskSeGu7YvVCaRsQxe+4kWuftf0pixs/jSvPyX+HrHn2Td+ftdQJB
         kl2862sQ+VkZmPVqPxKN1UXSL8hM1XR3HgSRWLSuPuezxfWPq2aBPG1M7bB69JoCfG/Y
         9BEA==
X-Forwarded-Encrypted: i=1; AL+hErG29EB1pR+KJtdj5CO88bXqrHMSSZhKpzz+gYujG/jFmV5GbOggEtLc4ccKUBYuzpk378dzLOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jzOq8FUB6o3BsB6jtkkb2XWdhvNasc+UiGDUnTzaUFXzvG34J
	Q9p+I7Xw2J7cnR06wgAMYceO3IXGE7sSUMUgAavFiwJNHWoM2VND3S5sPs/7gg==
X-Gm-Gg: AZFdTZePFyvSKYnJ0G6JKMI52K0Imjk4sMhrZb0SxD3ZP+Rs43Pz91fK33qx3xysAcF
	QuN/IgaAnpTp6q0/lQSgeCfbkIdK7RgV5NbELMNpieGd14jrkhAeO+CIAn0aaUhXH9Yp4iIZcc8
	AvE3G6r5ivcJ4gLGUHWl67ioVwix39qcmL+ILYvUAcevX9FRcPCjyI0wdZWRHwEMHA59bzcC9RI
	CDtaF8MNffPE7BtoSBO/smqRfumn0GL/0EEcW1P6hD3Pg3wLwx/BjtKIjcRRu9OzeLD1cIA7/t2
	RReNNH8qv5B4LtTImVRfiDx+4CZEk3uQT8CMvev/IBM0O2U5IQkkETzAy6hUxk9w/wAbaQLU3p2
	3jsOSGsyWHtp+s/VBxv9B+LscbOaq5uXAcUCJ/8f4oMZkg99gRtqDB0caAVy33s2vXKfZvcWaeW
	ucc/n3y7BtK3oyejpspkqwBWr9YKKnZfZxeK0HTYDccuqq7XpqKbaQQwXDqbA7UXHSbfrvTaOZ+
	7vMH2d6/oVudlx8KLoXucLzvNPnDTFNCfzVS35MKqJtgoeNPEuXG1s0DQoERWRp/xa5zypJgz6W
	NZN6HD1ZkQDQ6AIXkX845c5qXf0=
X-Received: by 2002:a05:7301:b02:b0:382:48a5:cd53 with SMTP id 5a478bee46e88-3857111f187mr29171697eec.31.1795871497156;
        Sat, 28 Nov 2026 05:11:37 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm49634928eec.9.2026.11.28.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:11:36 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <jylzkbvr.ritesh.list@gmail.com>
Date: Sat, 28 Nov 2026 18:37:29 +0530
Message-ID: <33slw1da.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <o6bdjkq1.ritesh.list@gmail.com> <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org> <jylzkbvr.ritesh.list@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Christophe,

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>
>> Le 25/11/2026 à 10:58, Ritesh Harjani a écrit :
>>> Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:
>>> 
>>>> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>>>>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>>>>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>>>>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>>>>>
>>>>>    root@buildroot:/# echo w > /proc/sysrq-trigger
>>>>>    sysrq: Show Blocked State
>>>>>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>>>>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>>>>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>>>>    Call Trace:
>>>>>     dump_stack_lvl+0x138/0x150 (unreliable)
>>>>>     check_preemption_disabled+0x120/0x158
>>>>>     arch_touch_nmi_watchdog+0x3c/0xd4
>>>>>     show_state_filter+0xf0/0x338
>>>>>     sysrq_handle_showstate_blocked+0x24/0x38
>>>>>     __handle_sysrq+0x134/0x3a8
>>>>>     write_sysrq_trigger+0x178/0x22c
>>>>>     proc_reg_write+0xf4/0x150
>>>>>     vfs_write+0xfc/0x71c
>>>>>     ksys_write+0x8c/0x150
>>>>>     system_call_exception+0x310/0x590
>>>>>     system_call_vectored_common+0x15c/0x2ec
>>>>>    ---- interrupt: 3000 at 0x7ffd01755b98
>>>>>
>>>>> Unlike the generic version, which only sets a flag, we update the CPU's
>>>>> timebase stamp and its SMP watchdog pending bit, so a migration in
>>>>> between touches the state of a CPU we are no longer on.
>>>>>
>>>>> Disable preemption across the update. While at it, let's also mark the
>>>>> function as notrace (since we might be within a tracer when this
>>>>> function gets called).
>>>> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>>>>
>>> 
>>> aah yes, I didn't see that there is another function which is not
>>> inlined. Thanks for spotting that. The reason I added "notrace" was
>>> mainly to have consistency with kernel/watchdog.c which is due to this
>>> commit:
>>> 
>>> cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")
>>> 
>>> 
>>> However, after looking more closely now, I don't think we need notrace
>>> here at all. To simply put, on powerpc, we don't use stop_machine() from
>>> within arch_ftrace_update_code() like how arch/arm does and besides, I
>>> think it is even safe for one cpu to be executing the instruction on
>>> powerpc, while another cpu modifying that atomically.
>>
>> But haven't we identified in another discussion that it might be needed 
>> to use stop_machine() ? See 
>> https://lore.kernel.org/all/qzh06fxn.ritesh.list@gmail.com/
>>
>
> Yes, that is why I also quoted second reason too on why we don't need it
> on powerpc. But here is the detailed explaination of what I understood -
> while looking at the history of changes on why "notrace" was added to
> some arch (like arm or to the generic definition) in the first place.
>
> On ARM, ftrace call sites were patched under stop_machine() and the code
> used to rely on other CPUs not executing any call site meanwhile. (Note
> that this itself is not needed on PowerPC see commit ee456bb346e7).
> However, with a THUMB-2 instruction set on ARM, a 4byte instruction is
> only 2 byte aligned, so while patching the instruction it can result
> into a 2 x 16bit stores. Now after commit ce4f06dcbb5d ("stop_machine:
> Touch_nmi_watchdog() after MULTI_STOP_PREPARE"), stopped cpus started
> calling the watchdog touch functions (which were not marked notrace yet)
> from multi_cpu_stop(), so a stopped cpu could therefore execute the
> ftrace call site of those functions between the two stores. This
> resulted into kernel crashes as seen on ARM while enabling/disabling
> ftrace on ARM kernels built with THUMB-2 instruction set.
> Therefore commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> as notrace") was needed on ARM to fix these crashes.
>
> So I still think we don't need a "notrace" on arch_touch_nmi_watchdog()
> on powerpc, even if tomorrow, we extend the use of stop_machine() for
> patching usecase, as we discussed on that other thread.
>

Just wondering if this answer your concerns? I see that others have
provided their Tested-by on v4 of this patch series. If that looks ok to
you - I was hoping if we could get that series queued up in powerpc's
next. Thoughts?

-ritesh

