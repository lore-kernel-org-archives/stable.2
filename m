Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257943;
	b=YIJwIAvM1bPcOu4qlMI8tBp5zXHaVExV4Ja7xWmA98wPZIAsFKori1NXnztjJ8E5btzl
	 Uslc8UvixAhvYXfpnBpA5k8l3aSpR0xpUd4P8LO/WikLgYtqmtwAoRnJg5w9osDpaniy2
	 KI4Yx1TuZI5h7afSwfgV/Oym3U51h2xA36yDxF8XEM3F9LxkuoFQbHgLo7wL0w3osigOB
	 XWr/naRtG2parbLeBfwaUBmJv3cjNnmiHInsDfbbBNtTDzD3eeDrqFrGnw3xzz0DliC+5
	 WJ0LOvyShmkZvYZFS2vnlqz217GL16Jv8OwWDm2betDsZWaN4SDcIJ8PRemUvw8XeMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
	b=Cfv8nrd2nRLnR1voN3O+9yUUHz1MrBnbX5mGYWQ/GwHuu9aqOzaI7nDPSsGdOMzrd2SB
	 Vi4a9n4tYhothDDQh+HRF3Aw6x/gZVkzPmrVfKoGQkkBr2cDxFNxafi363e3AyyfQhUWm
	 ytRAGqyXgfoqR0RL25MzSUyEEsrT9zYkxqKQsCjZoAkOiGDIM5H6jIUQhSrVwxqxRUTcI
	 AXWcwK4yKc3rLKsfmpr8UER4t3FSU9XTrHdMqTuzcsDyre0aNORA4sO39iZ+Dhjcfu//0
	 ySKEQ/T9VEruhOlZXiDevTs95r4hYBUOxp+ge8AZoqIVBAtWUlSpTvgjnLAFO8EI/yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w+dn/dwg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1B606A32D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A1B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+dn/dwg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so19042645e9.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793257941; cv=none;
        d=google.com; s=arc-20260327;
        b=G+dDbAMVXOpoF5J9clBhAiolHFNm5Aa7KN32fqwbja9rWbDvxQ2TY70+wXr+4TJdbj
         uJqYGpt8Qq/kSzSZwLY8TUlm++DR1jDUXpYJ2JQu3rInvpsbefPDXvqd4j71TkbkhA8/
         Kp5Eijj9a2t4gpbq1/66qAQoEd4j+8Ju/fvfbnZqnn5u3XCte1EuamUHcK6g3M51ugjP
         kztuF5lfBuL4HcOMHct0FAPSCILcuDalTgJSmkfppxBhmPcXhFHePk9581U//+WaliUx
         oy9woXguRL6jjPOiJT/gWpqLP0i4dMaXaws5QjcWuKTPYAhh2ZaM2NHoZPvhZo7nMZF1
         Nmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        fh=HUCiENu8BM7nNo0odZFS+DUhMMpxHDyZNZR0mlgpqGs=;
        b=Kzu1Nnu2h/9iZGgXtsr/s1y4vuTXRRv0WDX/FI6+7hFAXABNSL8C+Y0ZUKy8HbKji3
         3m3tyxJuB2tDp+rt3IX6VYlnfwg3ozPOC8HBqq8p7CziIiwxFefrn7fIzgOUX1PVLK7b
         t/6qjl3/z8mYwwFepGKCRh4PQE0ICZLS9C4sOr42ewFUjwehhWCno45psg9GbLA7ou/e
         8hp5GxAL1+E41z9x08w8ZuiPYvnmK5tr8TyC9k07MkidAsCdAGUsgup6gAbJXMkjO9RN
         BtS4E7zREMANZY/GEP4wC6llCudrus8/GgWuI3hWah5/5EG9zIN+v+Th0KA7exvT4YbA
         w0lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257941; x=1793862741; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        b=w+dn/dwgtbrysHaAXv9ETJPfMsaFELE4gakBZpylLTZ5oGcJrz5KSTONKHRlOdE2I4
         IWwoXJjpxNpfxrVO2kDMbcup7bpMDblzyW+qq7XJI/IJFjCe4wqkAHp8PB9Cy7oyNhOF
         unwwH+zFYGfXrW7pOQHwxSYLXWpKmpbcLrGKBqh8OKO+bLeAU3dxFPBtGnFChn/8keYi
         XVVkXjIP6SzJ3dv01NteeWbX91ClybUiHZT7/g/Ua9i9YO1VAI1S8Xd8/InCgNtdg0yv
         rdsozN/MTriCUneq8he1ytUB8+ohVVoULeuVXz8xwsAMHAHhQXQo1AsAI4pQCorBJX27
         KESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257941; x=1793862741;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        b=OSrod8j8DZCRDbbCEYh13zZkfv3VdQgwkBpMW248zxhdyLYOhs7akZV/D52iMfmIJ6
         nSdjA4wlZasO0wlMzpghLsML1DkCw0Axe9s6sCETZOt6ybhKwYAr0Rd7DyzvfWHxFmtI
         Y3DgiLCT5jRayMKmoq7WKhqzoevTDmVGf9wo1lComDGuAMBjkvOGW4UBrrbM1l5Nigqo
         Up+QkNw1dDoGOwXxTOy4g0W3mnsXG7kPvUOV0YBTwsjKFos2wHki9oe1wQz0LFao2TBM
         nfLj8oWMyR45xbZ5VaJHoZ0WRALPPjQfDJDo6xnx9chivXWROLBB2syDQl8Qil8rUtZH
         V6Kw==
X-Forwarded-Encrypted: i=1; AKwUvBww6vwMtDy64NKqZt6uPoqkUwdF0e+IiYfjCYOtSpqT8lkhLzl46nkEp85A/u9juhz9kPCS7qg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhxRTWIM2WZ31Tb7P3iCrPiSDDL3T9XmBcAMGIk+M8DZam50Dw
	vtfXyZSK+Q6/prw1F5gDza8pzJJ/s4RSQrH8lBZuePI6Uw3W3JKi6M1g1m5ksCh5VMyroN+0jpY
	ULMsokzy6Wgl0bUIt1R+D3xULl9NR+zM=
X-Gm-Gg: AYBFou3zmYby1h+d9hdOYOXdzvl/leXOK5TdSvcfltQPmOb+82N3cFcelITVAaJZkpb
	MbmZjKl+pD+379Moq57n2d/UKwy0TQPv0VXSLYiGk3mPaRBIZJDF0XnTVz0S741GpHPvQhDPNvA
	s0lxIrhlOLXDJ1yTCIHRQGirLFnmCrt5GI5I5KCHq509vrCaW1+PcPZwrqxhKcnQ7ztJiBLfnW9
	/G3mlkM2M/er5/7rynE42SZZxrEolmmOfr9s/darfN6Y6IciwtbllQFkMSs6hdZSrdaDeFjkaxU
	5aaM0JAyjwyKQbwR46BPT/aVMpMza06JPirNEBn2WGYvHO/YzmvI6ksnk4MahX9wJvOlG+JBrjc
	940HXmLiENsMcOQWH6QfKcsjbdctL6JSAoTbXFpMFoZHE+QVzyTaiOGiXlEqBlB6Sa/affLSj56
	qIsPc+hFT/NPgvuLGNFg==
X-Received: by 2002:a05:600c:1f94:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a9663995a8mr105499305e9.12.1793257941322; Thu, 29 Oct 2026
 00:12:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ahmad AG <ahmadag1001@gmail.com>
Date: Thu, 29 Oct 2026 10:12:08 +0300
X-Gm-Features: AclHuK8oIQAbFPj51xALKq0pQMpaX8tYjUogaYqwbvGOzn7JupmqQ2AXYVRoUe8
Message-ID: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
Subject: [PATCH net] net/packet: charge fanout groups to the memory cgroup
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fanout_add() allocates a new group with room for max_num_members
socket pointers. Since commit 9c661b0b8544 ("net/packet: make
packet_fanout.arr size configurable up to 64K") that is up to 64K
pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
The allocation uses GFP_KERNEL, so it is not charged to the caller's
memory cgroup.

Each packet socket can create its own group, so a process with
CAP_NET_RAW in its own user and network namespace holds about 512 KB
of kernel memory per open socket that its memory cgroup never sees.
In a cgroup with memory.max set to 16M, 256 sockets each creating a
group with max_num_members = 65536 took 264 MB of system memory while
memory.current grew by 380 KB.

Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a
user can make on demand in the networking stack already do. With the
change the same test in the 16M cgroup is stopped by the cgroup's OOM
killer, and with memory.max at 512M the 256 groups charge 262656 KB
for 264640 KB of system memory used.

The missing charge was found by code inspection of net/packet/ with
the help of an LLM and then triggered with a small test program that
creates the sockets and groups and reads memory.current; the numbers
above are from that run. Tested in a QEMU/KVM guest on this tree
(x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
running the test as uid 1000 in a cgroup v2 memory cgroup.
tools/testing/selftests/net/psock_fanout passes before and after.

Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
configurable up to 64K")
Cc: stable@vger.kernel.org
Assisted-by: Claude Code
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
 net/packet/af_packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c91..406397acc5c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
fanout_args *args)
  /* legacy PACKET_FANOUT_MAX */
  args->max_num_members = 256;
  err = -ENOMEM;
- match = kvzalloc_flex(*match, arr, args->max_num_members);
+ match = kvzalloc_flex(*match, arr, args->max_num_members,
+      GFP_KERNEL_ACCOUNT);
  if (!match)
  goto out;
  write_pnet(&match->net, sock_net(sk));

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0
