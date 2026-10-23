Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795454;
	b=BZYD6THKL+5JUXrOxxs7MF7vJ2vjlE443CVJVamtOgBO3a9UwoFldVhdXzQU6J3iwXlf
	 Jc+ylUFLeKziIe7TWqcgHz7wptVcXX4gY4cdO/enbLHA7dcFrnsAT7HEgNmaE42sY1zFc
	 vL6+ZfI9jCSoKcgWi4uNU3BWvxw2V1piJ4h19//6KVca9ZtWOikqYXea8I0dQvOgPxmOs
	 ivO5eAEagZC02bMS1+/bXGGV9FO56gqzwdZqdZ/jr3g1PjYr85wU6JLtElbGyesRAH7uR
	 EhJE18OABk3zY/rn0xBv/IDHpUuBM3rcYuzpWPJrEAVEAjUWEoOk/7BuyZoi0nrvfpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pJIrxg0Pdx42vikVs5ulMinCyovF6k2xYxAEXJBeRzg=;
	b=Rzk5cDp3slRi3K1jVzSTzuIC993fwrird1JotmuW5naH8V5OelKfINcZUmdkFj/6ln+J
	 iZxLhPjRiCWPgIUXMgmLqQkBByf4QOoVmiD3s1kAY68eYW/OAgF9heL2iLvw7Z96eAATU
	 R/WMHOm7mEucLYNcU78/rXs1zZ85j5EYepSWToUzluQ52PQ7yFrwvU8i0Rvvhp0Uqd0Qm
	 N1PPkHCz+K7JtyC4Eeo6i4gwsv9axZcB29xsDysSNgInjcAO+wZND8fcwFuTxj/td3hkG
	 /tZzMKK52cxyJ7htorV1nXaOtEfDGTm5O7jmVzkI8RwA33y9wd7NeKEPHKDAV1MXncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ALyPqJLb;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BD606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3BD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ALyPqJLb
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917a64f28d0so29125656d6.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795452; x=1793400252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJIrxg0Pdx42vikVs5ulMinCyovF6k2xYxAEXJBeRzg=;
        b=ALyPqJLbjW772lo5BYIRhoa1z6gcYO+YwrCrof+8WgmXC/6ZwZY/kNZBgP6lapLkeU
         oPG9i9JKWQ9Hn6oDfR7et+c59Hw9gEL2Ma6uLyyvbPqG/xzYHrsq4AUbGoQ4Sy6HN1ox
         Y8iJ8miCQL5MyPTjCwsh0qJMnivI+b9SflYePLJeInMh3IEks+JHLBCrmyP2XIgjKq4H
         En+a6OfgWCdQ5lh/WywiIh0bvNqKhDjh69hBF0nhXZQRlQiVT/PA2HF3T2rLbvFHz4nn
         j1OMl1YIjosoCnsGXH31CkiDAPCtWBj1N9E89a/G6Q0djzg8owskkaHftBo0swtmWaNs
         0NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795452; x=1793400252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJIrxg0Pdx42vikVs5ulMinCyovF6k2xYxAEXJBeRzg=;
        b=WVkMvJQSoZc32b9fy3gKj+gOXCghqSEkATdiF/W/WeGWGlFx7g355mzVElg7BSPBzh
         6yPaF3x6X3Ox/9Q1uj1M8cEtDji8vnYzIneoXOFJxSvF4nspt+VjmrtG2v8+oZf+fJcd
         +UKPwW2hnlmuYNX9P0ctH6V/lbhP5yry+A4y20DmaVel00I+21Y+oG8f1MNyicpCinj3
         Wr8mdKWDMtUzpl09Wz+jj2CYr8yocXG0xhlIMMW0b5TEFDT+eGivwnhCZbLIL+Txj1/e
         7XpHBjBHGoqRV8ZG/qXQuo6lVOkyO7KGfJpLmsheze1CZW+xQaLxGqy7sbMFhHarUJDw
         AJ4g==
X-Forwarded-Encrypted: i=1; AKwUvBwshKLN1Fzu3ej1eCGFpAAFRtcAYMYVqXpIVzf4IM10dqNTWlWFPBbTNPAf7r7WsU2HgLvZXKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYISXCCFp8iu9AFH0sNLdqntUR4J688ydq1BCayn0TEmKBq4VHv3
	0aJmBhj7BfQ4o2rIm1uhjIoFKTjjJlu2ABV+QjB1Jp7u+jNXAhcHD+VqLtr61Q==
X-Gm-Gg: AYBFou2EnmgmBNgNwZAQX8wntmwTnhzdceTBKBvs5KQfscbGSyh47EDkNEZ6QzthnwX
	N6L2N/e7c02z719imVrq2SkGO4jhHJyNGfkx/vD8ShfBJADwl2rAJk1jqIAW46y6QGwQOrO9nrG
	CtF8CKLZpHY97o7z1rzS0kF7ef4Eo+5YMcl8hYs5sz251+mb54ZevvGunMxFAFiluWptLYxRrLi
	GhACWNwnLyy/YvY0+sawb0IpqiRqf0STRT5roSzWzp5pK2eutIV9T3cm13Q5hIO2R4S+2kZj2q3
	RnP1D6fMbJCb028lhVH1LomtmqQgmvw4hJyQ8pxBKkdPspNnwskhh3GbxnoZbSukDXzqLxxhBKs
	Pl2b+rV8NyKiZSVc7BQKF7xWbC1tCx5tySAT0qALryaE0vLgIIX/eLRjfLvcaZthrnGpKtYGQqo
	ckBbqxrtw0yt7NuKYeeRyOTrJi2Vc0TRtcBP37yEb+C6gPunO++XGc5OGdeFzfoVl3LBnifci1N
	3I42vM+mwPyjQvgJRSDfeCDHVSwjcTPs4YQDuyTB5l+1APPgMvviDuAdZhdiPdfkm3KgKbSNNq4
	RpCSFNpbuIOw3EFVAl8iGLBLwprd
X-Received: by 2002:a05:6214:5193:b0:917:b8e0:6ca3 with SMTP id 6a1803df08f44-91c490092e0mr6953306d6.5.1792795452375;
        Fri, 23 Oct 2026 15:44:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm6300606d6.3.2026.10.23.15.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 15:44:11 -0700 (PDT)
Message-ID: <7540e723-054e-43a2-859d-616010fc7bea@gmail.com>
Date: Fri, 23 Oct 2026 15:44:07 -0700
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
Subject: Re: [PATCH 7.2 000/242] 7.2.13-rc1 review
To: Salvatore Bonaccorso <carnil@debian.org>,
 Pavel Machek <pavel@nabladev.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable # v4 . 9+" <stable@vger.kernel.org>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261023163713.816071858@linuxfoundation.org>
 <atvHKoRHHjKV4l8A@duo.ucw.cz> <atvS68GhCvmAphrQ@eldamar.lan>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <atvS68GhCvmAphrQ@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 14:34, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Fri, Oct 23, 2026 at 10:44:26PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> This is the start of the stable review cycle for the 7.2.13 release.
>>> There are 242 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>
>> Either something went very wrong with our testing, or this fails on
>> all our targets. 6.18.59-rc1 does not seem to have those widespread
>> failures.
>>
>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2982452623
>>
>> Example failure is:
>>
>> I'll look some more to try to figure out what is going on there.
>>
>> Best regards,
>>
>> 								Pavel
>>
>>
>> [    1.238864] Yama: becoming mindful.
>> L426[    1.238864] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> L427[    1.238864] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> L428[    1.238864] VFS: Finished mounting rootfs on nullfs
>> L431[    1.238864] BUG: kernel NULL pointer dereference, address: 000000000000002c
>> L436[    1.238864] #PF: supervisor write access in kernel mode
>> L437[    1.238864] #PF: error_code(0x0002) - not-present page
>> L438[    1.238864] PGD 0 P4D 0
>> L441[    1.238864] Oops: Oops: 0002 [#1] SMP PTI
>> L446[    1.238864] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S                  7.2.13-rc1+ #1 PREEMPT(lazy)
>> L447[    1.238864] Tainted: [S]=CPU_OUT_OF_SPEC
>> L448[    1.238864] Hardware name: SIEMENS AG SIMATIC IPC227E/A5E42630598, BIOS V20.01.11 03/15/2018
>> L449[    1.238864] RIP: 0010:rest_init+0x33/0xd0
>> L450[    1.238864] Code: 34 ff ba 00 02 00 00 31 f6 48 c7 c7 70 a2 e6 b2 e8 52 d3 28 ff 89 c3 e8 bb 2d 34 ff 89 df 48 c7 c6 80 db 85 b3 e8 9d d7 2b ff <81> 48 2c 00 00 00 04 65 8b 15 63 6e 45 01 48 89 c7 89 d0 c1 ea 06
>> L451[    1.238864] RSP: 0000:ffffffffb3803ee0 EFLAGS: 00010246
>> L452[    1.238864] RAX: 0000000000000000 RBX: 00000000ffffffea RCX: 0000000000000000
>> L453[    1.238864] RDX: 0000000000000000 RSI: ffffffffffffffea RDI: ffffffffffffffea
>> L454[    1.238864] RBP: ffff8cf23ffed080 R08: ffffffffb385db88 R09: ffffffffb385db80
>> L455[    1.238864] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8cf23ffed0ab
>> L456[    1.238864] R13: 0000000000000000 R14: ffffffffb380c040 R15: 00000000b43e8000
>> L457[    1.238864] FS:  0000000000000000(0000) GS:ffff8cf287953000(0000) knlGS:0000000000000000
>> L458[    1.238864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> L459[    1.238864] CR2: 000000000000002c CR3: 000000000d630000 CR4: 00000000001006f0
>> L460[    1.238864] Call Trace:
>> L461[    1.238864]  <TASK>
>> L462[    1.238864]  start_kernel+0x7a2/0x7b0
>> L463[    1.238864]  x86_64_start_reservations+0x24/0x30
>> L464[    1.238864]  x86_64_start_kernel+0xcd/0xd0
>> L465[    1.238864]  common_startup_64+0x13e/0x158
>> L466[    1.238864]  </TASK>
>> L467[    1.238864] Modules linked in:
>> L468[    1.238864] CR2: 000000000000002c
>> L469[    1.238864] ---[ end trace 0000000000000000 ]---
>> L470[    1.238864] RIP: 0010:rest_init+0x33/0xd0
> 
> Same here indepently, but not yet bisected.

Same here as well, bisected down to: a0c935bd1f76 ("fs: add umh argument 
to struct kernel_clone_args"), it looks like we need to cherry-pick 
14adbd5341aa ("fs: stop sharing fs_struct between init_task and pid 1"), 
with that I can boot a kernel.

[    0.050862] VFS: Finished mounting rootfs on nullfs
[    0.056357] Unable to handle kernel NULL pointer dereference at 
virtual address 000000000000002c
[    0.065711] Mem abort info:
[    0.068679]   ESR = 0x0000000096000004
[    0.072657]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.078323]   SET = 0, FnV = 0
[    0.081587]   EA = 0, S1PTW = 0
[    0.084930]   FSC = 0x04: level 0 translation fault
[    0.090117] Data abort info:
[    0.093189]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.099019]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.104380]   GCS = 0, Overlay = 0, DirtyBit = 0
[    0.109297] [000000000000002c] user address but active_mm is swapper
[    0.116061] Internal error: Oops: 0000000096000004 [#1]  SMP
[    0.122056] Modules linked in:
[    0.125308] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
7.2.13-rc1-gd1c66ab3e3bd #2 PREEMPTLAZY
[    0.135124] Hardware name: BCM97268SV (DT)
[    0.139473] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.146859] pc : rest_init+0x4c/0xf0
[    0.150659] lr : rest_init+0x4c/0xf0
[    0.154461] sp : ffff800083133e30
[    0.157982] x29: ffff800083133e30 x28: 0000000000000000 x27: 
0000000000000000
[    0.165565] x26: ffff00001a5e2e40 x25: 0000000000000000 x24: 
ffff800080fc0000
[    0.173157] x23: ffff800083137a00 x22: ffff800083140e40 x21: 
ffff00001a5d1700
[    0.180774] x20: 00000000ffffffea x19: ffff80008314f300 x18: 
0000000000000006
[    0.188374] x17: 0000000000001000 x16: 0000000000000000 x15: 
000000000000cfff
[    0.195966] x14: ffffffffffff8000 x13: 0000000000000000 x12: 
ffff8000832fed50
[    0.203548] x11: 0000000000000040 x10: ffff80008314f308 x9 : 
ffff80008314f300
[    0.211165] x8 : 0000000000000000 x7 : 000000004308a007 x6 : 
0000000000000000
[    0.218757] x5 : ffff800083276900 x4 : ffff800083133cb8 x3 : 
0000000000000000
[    0.226356] x2 : 0000000000000000 x1 : ffffffffffffffea x0 : 
0000000000000000
[    0.233914] Call trace:
[    0.236505]  rest_init+0x4c/0xf0 (P)
[    0.240302]  start_kernel+0x6dc/0x810
[    0.244204]  __primary_switched+0x88/0x98
[    0.248449] Code: 910c0273 aa1303e1 2a1403e0 97c30fa2 (b9402c04)
[    0.254926] ---[ end trace 0000000000000000 ]---
[    0.259849] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.266980] ---[ end Kernel panic - not syncing: Attempted to kill 
the idle task! ]---
-- 
Florian
