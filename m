Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038893;
	b=DvYe0o4fmx52fnzc0kN7EcoxpDhMXWF1TNQtPO7W+tQz+8SxaeynVcecs9HIYux92TY+
	 8POzzF+cZfEDblE87ejbn5AXAmGE+jOErwQJTl6Id/J0ccz3qDYLKgLIgjunv4D7t94rl
	 vWEp4wQH0E0SYqCA0bYGhiUrC5hM8hvQWT37LECMm8kuV+gSRrIXF2QLPm4y9hWeWs+6H
	 LrT7MBxp3qPkChrqVD5ctUgKkRRi27RD1nl0swbk0/YN3rpn4KOjlKIFeU169gTaVw9si
	 8CZNtRV22mTPxxhbBVl1dDUXG4aLcm7tdyeYGNh22JW87888Os24p9J8RlDxmRU8gEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
	b=r/TvX5Gc3Ckswa4a8t895NFH67aKcjdvd9NECxDS9oNOzg7TftFDkyAl8qhQB7PTld3a
	 AGXwrRf3Nm0Z3EpZPxk9I8LNvdGXT5n20ga2CpA/7Xlr9J/XfxSxMxzlSPtqmIQTCEz3M
	 Rpn00TSvsDlkD+gDvhYYtcKdPebyq7NfA2nMh8rGAyldhVmyTYaJxGT9U9Bngzk1LgcfO
	 42asmb5PVQ17juBRcsMQC46BT9tqR1+NZlAKHjGFrrYkzfi8/myubUzpASq07CBn1uRj4
	 SyPBbylOM1KHAKOfzx+ON3UIGf1wrRMkb+DZWHba5+J6HfGzZesdGqhgFvrhw6nOmkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjR3O+Ln;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F616606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F616606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjR3O+Ln
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea7987517aso8167055ad.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794038892; x=1794643692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
        b=gjR3O+LnbqWxSywMeqbqw+2tekOwfmC3a5BDhu60zh3iUcZ0Y3Mzu7GPeI9zhL+aHG
         eZWl1skwP1Q/ll1e+lKt8scG8ma7mqFE2WWCEWpcHSYAqqqLl3NSj92XPwBjFcUwPDIS
         l2MVQZyp8nPW6H4lH7sAHbUnWKOctaRelZL2/8faw9SdV7hAOI1FIueSB6ylCXggbLe7
         JfxANvcupt3AxNkyuaiwncgHCpq1yxBDSLkCP49P6ePE8BAobSbK4noUzkekAp73VY9e
         SDcZvO8bll/JwGA4InjCk6mETFBPB52IlyvUXmM1kkKc2+Y7KooJs5ZauCtp6HNd8+p3
         IxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794038892; x=1794643692;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
        b=M9BZF9LopGKiBWIDDP5l6AppbnUllTwityoG/1svT2Sv0/O0T8zDtshEAdAx2/SrUs
         omH9vHg57HTYcyH8bH7Mw6hBas9X9jbeY0BEQLufXB0KjIXSY7k9/OkYA7egm3EKaDQ6
         71FyhUTJAhOoZJN4lq87pldYrU144v5y0NCa8GoggNlp5MOaYclXwplB58r+6omcSYr/
         wUMqR/tsrKTo6voQ96tPk3CLZUY/uGzfOlp/x6TKbeJEkFIU3hIAKXgUMjKM1nG/tXWo
         I2q4mIWsahKJXsRRMTw14gLSZehop3qR3jn7HzQBgbLOISaavmxWRpM9hJKZ6DGfQSas
         s4dQ==
X-Forwarded-Encrypted: i=1; AL+hErGV2KaxBGkg74jzoHH3zYkAkwP6+0lsbo2c7H5Wts/GLmwo/Dt1UscGgG74H6JvTdBrxjzEyAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9je4lRDGgWrbHX/m9JJEXNKQoqgFFJdue1+zlJVXfpeaZFfnmH
	mJIyMZYP/nbx4hjnMZTvyQzRiEKc/3FaGvcH53HsIhoohJHoikl7qzeB
X-Gm-Gg: AYBFou3C3H1N+9GKRco6sOaj+ak79NoI/T0m3TRahR4mbUzGahoqJOSh4sxfv2IT/gU
	7u+WvpT5+GLgir5ufL3rD5BD8t3VwcQ5hDj2QQ4gC70XKLAQs5mx+4Z3UtOPsg7KWXFV4jfRIkI
	cGu1LpccnWx7f5AoOtxuZ3rhi+PIjB31rb5iVA+9dwj27hO8gq89tDVtQjxQTC95/hxECAftgDy
	oZl3GArLv07kxezkB3R69Oe9CYFHkJv3AwSA+lCCXkC2ksURI0H+BFKCPStw7LOLyJlAHzMAli8
	Lgn3vmKF6WDA03KKBsRCBquE0WoB640vHE13KCeNxzc5V3lkxp6wy6oPRPVBS0aTDJ8oIUjqxE+
	GWGmwQWO2PG50O5AECw0rLPGjamlWcxL6fBtMGlQef2j2yqDkEPTe0Bw6ADYNbEB/ILy3DG0J+y
	Ro3ZfHtfzpKtcJDBNAlPeFGvTQobe7TIc8xUfJIRCHWOmah7cdHB1BD+ICcmtAJAcMGKQ39FKyP
	nlCEqn0vFt59vxcO7f72EwvJyBF1dd4VrfT6c9+6D2dEvDieDB5HRlTZQo+C6EKwxQbJ16CXpnf
	ylZuEzyAPYbLWu12o+sR0GIl2oiqNhQwDKt7rXhAGY7xg8gjtEkkxTTk
X-Received: by 2002:a17:90b:568e:b0:3ad:870b:b6d4 with SMTP id 98e67ed59e1d1-3b0db609836mr4788668a91.1.1794038891748;
        Sat, 07 Nov 2026 00:08:11 -0800 (PST)
Received: from [192.168.255.10] ([223.104.68.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm1764509a91.0.2026.11.07.00.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 00:08:10 -0800 (PST)
Message-ID: <05e77224-7d3a-42d5-9e08-82c7257cba34@gmail.com>
Date: Sat, 7 Nov 2026 16:08:03 +0800
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
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket
 insertion
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Lin Jiapeng <jiapenglin@tencent.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
 <6cb5fe89-c6f0-4e84-b753-4425b1aebe1e@linux.dev>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <6cb5fe89-c6f0-4e84-b753-4425b1aebe1e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-07 1:02 p.m., Jiayuan Chen wrote:
> 
> On 11/6/26 9:58 PM, Lin Jiapeng wrote:
>> Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
>> sk_reuseport_cb attached to its reuseport group. 
>> ...
>> Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
>> socket until num_closed_socks exceeds max_socks. The next insertion
>> writes before socks[], overlapping prog on x86-64 and leading to type
>> confusion when a reuseport program is attached or detached.
> 
> 
> Is the issue same as Eric's patch ?
> 
> https://lore.kernel.org/netdev/20261106084300.2029567-1-edumazet@kernel.org/

These reports may be related, but analysis suggests that they seem
to have different root causes.

Eric's patch seems to prevent attaching a program to the same unhashed,
shutdown listener from resurrecting it into the listening section. My
patch addresses duplicate closed-section insertion after SO_REUSEPORT
is cleared, which may eventually make socks[-1] overwrite reuse->prog.

Eric's patch does not change reuseport_stop_listen_sock(). Also, my PoC
attaches the program on a separate, still-hashed anchor socket, so his
new check may not apply to this path.

I tested Eric's v2 patch with my unmodified PoC. His positive control
returned EINVAL, so the patch seems to be active. However, my PoC still
triggered the same UBSAN/KASAN failure. Since his patch did not stop my
reproducer, and the root causes appear to be different, I think these
may not be the same issue. The two fixes may therefore be complementary.

The following is the UBSAN/KASAN output with Eric's v2 patch applied:

[trigger] cycle 129/129 (vulnerable: socks[-1] overwrites prog)
[trigger] attaching CBPF after closed-region pump
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in 
/Users/m00nb1rd/WorkSpace/vul-findings/reuseport-closed-region-negative-index-bpfprog-as-sock/repro-upstream/linux-eric-v2/net/core/sock_reuseport.c:153:9
index -1 is out of range for type 'struct sock *[] 
__counted_by(max_socks)' (aka 'struct sock *[]')
CPU: 0 UID: 65534 PID: 22 Comm: poc Not tainted 7.4.0-rc1+ #1 PREEMPTLAZY
Call Trace:
  <TASK>
  dump_stack_lvl+0x23/0x30
  ubsan_epilogue+0x5/0x30
  __ubsan_handle_out_of_bounds+0x91/0xa0
  reuseport_stop_listen_sock+0x290/0x310
  ? reuseport_stop_listen_sock+0x43/0x310
  inet_unhash+0xd5/0x400
  tcp_set_state+0x125/0x260
  tcp_disconnect+0x47/0x1950
  __inet_stream_connect+0x2d0/0xab0
  ? do_iter_readv_writev+0x25b/0x350
  ? vfs_writev+0x2e0/0x3c0
  inet_stream_connect+0x57/0x90
  __sys_connect+0x14b/0x1a0
  __x64_sys_connect+0x71/0x80
  do_syscall_64+0x6c/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x205560
...
...
  </TASK>
---[ end trace ]---
Oops: general protection fault, probably for non-canonical address 
0xdffffc000000008e: 0000 [#1] KASAN
KASAN: null-ptr-deref in range [0x0000000000000470-0x0000000000000477]
CPU: 0 UID: 65534 PID: 22 Comm: poc Not tainted 7.4.0-rc1+ #1 PREEMPTLAZY
RIP: 0010:call_rcu+0x10d/0x260
...
Call Trace:
  <TASK>
  ? reuseport_attach_prog+0x6c/0x250
  reuseport_attach_prog+0xdd/0x250
  sk_reuseport_attach_filter+0x97/0xf0
  sk_setsockopt+0x973/0x1cc0
  do_sock_setsockopt+0xa9/0x120
  __sys_setsockopt+0xaa/0xe0
  __x64_sys_setsockopt+0xac/0xc0
  do_syscall_64+0x6c/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x202f22
...
  </TASK>
---[ end trace 0000000000000000 ]---

