Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF254DAC0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880851; cv=none; b=od80eLJnX8lgnq6o0MDQvHrKXixGdYwbyk1oJoMkJM8zC+XyYPJ3xY43FJ0fR2TMG0Y74O+yWVLzq6ZyJgnfZp4aziDomn6gy2w64Y1llwCp+7EMvaUEJMaR1+09/a0HeotMIakudiYSyzawvo2Wn9gcsyVC2m2yEwRTRt6YII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880851; c=relaxed/simple;
	bh=EcAnVVTY0TJDo2Bi6+H6n+pfEVg8/5bxAwTCYAgGkg4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=civN2u6xVa3sM58auLQjLD2HmKCDOIPOnMOaMtftFlxnFNJLm98pJ6l5kCdl3aDhximOAuPYAw2JFIEWbdP5/5Op4N1zqJKVrKzaop9eoR8iy1sc9Jdqulo00+Ypp42bBfDxXHtSxVgE27X2aERrDVac8g+k3FvOdzr5NO3eMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=nt8ejIgh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="nt8ejIgh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso70793285e9.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1788880834; x=1789485634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LuokIwMefYOOpiFr53gx2wC8mSSX4YXcghnNFTGNZ/Y=;
        b=nt8ejIghpB8/ZUDgxm4W3fHyCj3CxMbHOkmGLLPMPZ1Y/szJSa6GDyL2DDbQE0YYQm
         k+m1LWIrOY+856NDtvm9K53p7o/3PO1MkxBPrtRzdXLShrYg8CzxKLI5KxYToe3h9BAK
         rkNjAKSz7eLQRPl8ya4FdApjGChmuthN8zzF3cPCu5VPZesy85SgHnqBw1krGZ6Sg+RI
         pR8ByQbPki9awRozYXLyDEr4HVuJgbe218tA1CoeUdrH2cN4nYE5qTLiWEE9FaiXYH8n
         1E5td478R2HzwsnmwsCFGV8au6fDhjSX1MR4tsCBCHDnuCxnx15u4vdpUfkrhkCWUpFn
         a+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880834; x=1789485634;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LuokIwMefYOOpiFr53gx2wC8mSSX4YXcghnNFTGNZ/Y=;
        b=GKMFUmSZzgXPke+5+Oiie/4vhG0dyByPH47rWicMuuVCduzqy9d71lUGjHhDK+LDdS
         LfON1bCRPa1vOj5bgSiN2BmkfdnZAaQHQLKjFgBUa14v18gkFguFoz77P3CMPkLrLyNO
         SlyN1ZnNEtF74bQ4815teKoxaDt5OOB7eTYrme+mbX7ysguI78UOMz0JLTNN4VG1vCML
         S70eOatYiPpQZijlqFjtMMXGRwt/iLoNR6GO83hjLAVmr/ZzLdTwtbmxzcC2L5tsKhvC
         lV+YEfNI3Mdv0SZbyAXrhJGanvp+IWE+q/jCqG5zCWsl9gf6Q7tPE0325x2Ag3oAmnIe
         tAzg==
X-Forwarded-Encrypted: i=1; AKwUvBw+Me9tA4gac+Mb+RNzKBOBASBr/lrLkMqXmUgWqkuYdoknC37PPsxI381cgWV12seD1DHHp6E=@vger.kernel.org
X-Gm-Message-State: AFuF++m6IAj7i7DVeZlWL2lSExrPMUNryoi9abE4vdPF3jSmwgIs7M/C
	CupIyswBcHjuCB3YokmaoLf4R4k8KCnspT81GrGSDynSEZ7N1RNAqhrakSsI9wCc7es=
X-Gm-Gg: AYBFou0y71kcz0olQdwMdMoYUG5Wg1Vt4hLhu65AYHuaVlpNYpdeQ1set95irPkC+nf
	CEA0uZVLRF0czCBvPrTeHjEadIupA41l9hOSVt87nVZ+XYhmJwPSLVPjsvxciaFp83u0z+c3TAU
	NbfowIzoEIOTJyAwSzm2WZz2dviWvD1Rp30HejWyeYqYgd16ONxxZT5De+Sw9u7EDBA6+pQWkKH
	lJ3T9kdENeP3mWxf8P8QVfGHyQEU8rPANi1bk2kHBEJQieRLFlpGNaEOAVjkGXidBYF7KelKv0b
	N2tJ+tHGLWbTaMDLetO+WnoHsGOp1GYAOSdyw4Pwd0yG2ZXSFRokFYcIZFi7Tgiq+rpx9+Nxf8e
	3/9Lfp7uj830+g7/SFGuMRdWLBLb4HPuN5byd1+/d2eRk27cyDL4HcCBTQeP3+uxDvnCIGIeBKL
	YQcW3edP3oyCbITasWaeJPgFVMMNEjTj3YXCazKENX1v22SaPRyUt/gl77kDEoEE5J4YWL9T5/B
	sFh
X-Received: by 2002:a05:600c:4e89:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-49cfa211d6bmr261885185e9.22.1788880834245;
        Tue, 08 Sep 2026 08:20:34 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm306292535e9.9.2026.09.08.08.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 08:20:31 -0700 (PDT)
Message-ID: <68ff837b-4b40-4ce3-a90c-0630e4711e63@ursulin.net>
Date: Tue, 8 Sep 2026 16:20:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
 <96eb6288-5c85-47c0-8f72-57d6f138851e@ursulin.net>
Content-Language: en-GB
In-Reply-To: <96eb6288-5c85-47c0-8f72-57d6f138851e@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/09/2026 13:28, Tvrtko Ursulin wrote:
> 
> On 07/09/2026 12:06, Tvrtko Ursulin wrote:
>>
>> On 07/09/2026 11:47, Philipp Stanner wrote:
>>> On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
>>>>>
>>>
>>> […]
>>>
>>>>> How did the others fix that?
>>>>
>>>> Combination of kfree_rcu, synchronize_rcu and storing the name in an
>>>> object protected by those:
>>>
>>> […]
>>>
>>>> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>>>>
>>>> That makes scheduler timeline name vfunc safe:
>>>>
>>>> static const char *drm_sched_fence_get_timeline_name(struct 
>>>> dma_fence *f)
>>>> {
>>>>     struct drm_sched_fence *fence = to_drm_sched_fence(f);
>>>>     return (const char *)fence->sched->name;
>>>>
>>>> sched is then RCU protected. sched->name is already static so not a 
>>>> concern.
>>>>
>>>> As you say nouveau_sched_fini() only tears down the scheduler after
>>>> fences have been signaled it seems adding two new kfree_rcu make is 
>>>> safe.
>>>
>>>
>>> I don't see how any RCU mechanism would make anything here safe.
>>>
>>> As long as ops->release is implemented, ops will never be set to NULL,
>>> (with or without RCU) – so everyone who holds a reference to finished-
>>> fence can still run into drm_sched_fence_get_timeline_name() and cause
>>> UAF on the sched pointer *and* the name pointer.
>>>
>>> Moreover, all of this falls apart should the driver unload.
>>>
>>> So I maintain the position that we only get it right by having the
>>> signaled-bit be the decoupling point.
>>>
>>> Or am I missing something?
>>
>> The driver fixes you asked about and I listed work(ed) in the context 
>> of 506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
>> rules"). In that "world" it would have been safe. Did 035219a760ed 
>> ("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
>> those fixes a bit?
>>
>> I can try my IGT and see..
> 
> With RCU frees in xe it is harder to hit it reliably for KASAN to 
> notice. Guess I would need to have a way to flush the RCU callbacks from 
> IGT but I did not bother with that, it seemed easier to check the 
> returned name. Since it is not returning "detached-driver" / "detached- 
> timeline" post signalling that proves things are indeed broken:
> 
> $ sudo tests/xe_sync_file
> IGT-Version: 2.5-ge37a85b91 (x86_64) (Linux: 7.3.0-rc1+ x86_64)
> Using IGT_SRANDOM=1788784104 for randomisation
> Opened device: /dev/dri/card0
> Starting subtest: sync_file_race
> [2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
> function test_race, file ../tests/intel/xe_sync_file.c:130:
> [2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: ! 
> strcmp(driver_name, "detached-driver")
> Stack trace:
>    #0 ../lib/igt_core.c:2089 __igt_fail_assert()
>    #1 ../tests/intel/xe_sync_file.c:155 __igt_unique____real_main136()
>    #2 ../tests/intel/xe_sync_file.c:136 main()
>    #3 ../sysdeps/nptl/libc_start_call_main.h:83 __libc_start_call_main()
>    #4 ../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
>    #5 [_start+0x25]
> Subtest sync_file_race failed.
> **** DEBUG ****
> [2177.516393] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
> [2178.517745] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
> [2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
> function test_race, file ../tests/intel/xe_sync_file.c:130:
> [2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: ! 
> strcmp(driver_name, "detached-driver")
> [2178.518762] (xe_sync_file:10970) igt_core-INFO: Stack trace:
> [2178.523313] (xe_sync_file:10970) igt_core-INFO:   #0 ../lib/ 
> igt_core.c:2089 __igt_fail_assert()
> [2178.523428] (xe_sync_file:10970) igt_core-INFO:   #1 ../tests/intel/ 
> xe_sync_file.c:155 __igt_unique____real_main136()
> [2178.523436] (xe_sync_file:10970) igt_core-INFO:   #2 ../tests/intel/ 
> xe_sync_file.c:136 main()
> [2178.564635] (xe_sync_file:10970) igt_core-INFO:   #3 ../sysdeps/nptl/ 
> libc_start_call_main.h:83 __libc_start_call_main()
> [2178.564690] (xe_sync_file:10970) igt_core-INFO:   #4 ../csu/libc- 
> start.c:128 __libc_start_main@@GLIBC_2.34()
> [2178.564892] (xe_sync_file:10970) igt_core-INFO:   #5 [_start+0x25]
> ****  END  ****
> Subtest sync_file_race: FAIL (1.054s)
> 
> I'll copy you on the updated IGT for reference.

For reference Intel's CI managed to catch the UAF using the test I 
re-posted yesterday:

https://intel-gfx-ci.01.org/tree/intel-xe/IGTPW_15796/shard-bmg-9/igt@xe_sync_file@sync_file_race.html

<6> [107.688696] [IGT] xe_sync_file: executing
<6> [107.711053] [IGT] xe_sync_file: starting subtest sync_file_race
<4> [108.719407] Oops: general protection fault, probably for 
non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP NOPTI
<4> [108.730119] CPU: 11 UID: 0 PID: 4227 Comm: xe_sync_file Tainted: G 
S   U              7.3.0-rc2-lgci-xe-xe-5698-547f981c369d4b8ad-debug+ #1 
PREEMPT(lazy)
<4> [108.743915] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
<4> [108.748699] Hardware name: ASUS System Product Name/PRIME Z790-P 
WIFI, BIOS 1645 03/15/2024
<4> [108.757038] RIP: 0010:strnlen+0x17/0x50
<4> [108.760873] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 48 8d 14 37 48 89 f8 48 85 f6 75 0b eb 2d 48 83 c0 01 48 39 c2 
74 13 <80> 38 00 75 f2 48 29 f8 31 d2 31 f6 31 ff c3 cc cc cc cc 48 89 d0
<4> [108.779603] RSP: 0018:ffffc9000414fcc8 EFLAGS: 00010202
<4> [108.784827] RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000000050 RCX: 
0000000000000000
<4> [108.791954] RDX: 6b6b6b6b6b6b6b8b RSI: 0000000000000020 RDI: 
6b6b6b6b6b6b6b6b
<4> [108.799079] RBP: ffffc9000414fd90 R08: 0000000000000000 R09: 
0000000000000000
<4> [108.806201] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8881098231a0
<4> [108.813329] R13: 0000000000000020 R14: ffff88816a833ab8 R15: 
6b6b6b6b6b6b6b6b
<4> [108.820454] FS:  00007de5028bebc0(0000) GS:ffff8888d5fdb000(0000) 
knlGS:0000000000000000
<4> [108.828530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [108.834268] CR2: 00007de5028bc000 CR3: 000000012c9b7001 CR4: 
0000000000f72ef0
<4> [108.841396] PKRU: 55555554
<4> [108.844104] Call Trace:
<4> [108.846554]  <TASK>
<4> [108.848656]  ? sync_file_ioctl+0x1ed/0x750
<4> [108.852754]  ? sync_file_ioctl+0x153/0x750
<4> [108.856850]  __x64_sys_ioctl+0xa5/0x100
<4> [108.860691]  x64_sys_call+0x2b5/0x27e0
<4> [108.864439]  do_syscall_64+0xea/0x670
<4> [108.868101]  ? do_syscall_64+0x224/0x670
<4> [108.872024]  ? trace_hardirqs_on_prepare+0xcb/0xf0
<4> [108.876812]  ? do_syscall_64+0x224/0x670
<4> [108.880736]  ? trace_hardirqs_on_prepare+0xcb/0xf0
<4> [108.885522]  ? trace_hardirqs_off_finish+0xc7/0xe0
<4> [108.890307]  ? do_syscall_64+0x58/0x670
<4> [108.894143]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
<4> [108.899190] RIP: 0033:0x7de504724f1d
<4> [108.902764] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
<4> [108.921497] RSP: 002b:00007ffdc9fd5e50 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
<4> [108.929059] RAX: ffffffffffffffda RBX: 00007ffdc9fd5fd8 RCX: 
00007de504724f1d
<4> [108.936182] RDX: 00007ffdc9fd5ee0 RSI: 00000000c0383e04 RDI: 
0000000000000006
<4> [108.943310] RBP: 00007ffdc9fd5ea0 R08: 0000000000000000 R09: 
0000000000000000
<4> [108.950435] R10: 00007ffdc9fd5f60 R11: 0000000000000246 R12: 
00007ffdc9fd5ee0
<4> [108.957558] R13: 00000000c0383e04 R14: 0000000000000006 R15: 
0000000000000005
<4> [108.964686]  </TASK>


Regards,

Tvrtko

