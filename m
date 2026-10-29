Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290250;
	b=5YOt1dP2GXQIOZ+8B+2wnXieRlQXY/GF2B/zk49fBiqaNWb0ZXyJuHCd6xUTAz0rPjP7
	 FS/Qf4ElA4GAcshSl79sOHQesMirHSzm6+xuyUhZRxz/9bF19LvZrnu64M6d+kvlFEReI
	 /krNaNWLccBNBv8db6LBI8Y15xcSYGAKRFgmRalPJ4hHyBM7MI6hfEmj4gY9Jehia4NQu
	 87yFjx1dJD+tWTQoVipzaHjJdD2ocSd8pjKxWYId33ZpiVMi7NUUYJ6c7tjt6SFI0hWCk
	 8YaLFn2AtBKxNEDzPiwwS9QuFsYD9W4KvSDBYRzMR7zYGz8ZCWoKNvQDmbNjJ/qYWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
	b=j0DZUlzoR6vYCoQH0ku45ka1mNBBAF3soVYescxr8zLo9hQufCbxM2H1fcnp0a9Vma2R
	 5yD9AnLG8a3yA1Yrsf/bMDKc+6HShOC+VQBa7yWQGLIwdQVTiiEO3Mp4f1Pk2rYK651qd
	 qblvBEqN8eSjLo1yESoKo1XFCPtdwCbC9WTqFAhge4xdRLH1MepvGcVj5Wm+ePtia1zTK
	 DRN6ZM69+ARwwubCiCQwohkuRxx9x2Nrr6Q6PxUkKUDTR0VyTzVWEOD3wqr5UFjJHwdeu
	 9zc5tcU4xenUfqikJS+tFA7wEYDNxo2YM92POBka6ZqHGV2vz0sd4qlZCMzQu7K6uSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQ1HgAJB;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E2606E013
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441E2606E013
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQ1HgAJB
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d06ecaf709so76281137.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290248; x=1793895048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
        b=BQ1HgAJBM52AsbQ7tfdFq3gPd99w/14A03ldC+9zCPotdgmBElhQocOdv+zPBbopv3
         /sSlGYpgzZKxyUuURLiPcADtZ+/2b/+asX33xRM9nkV7swnjQ1JGfho3PNwvXQaAwdJm
         OMUAq+L64oXGkKt9nBn83mEEBOjFSMoK8EVw+KnQS0okrCLOFV+xdBozRew+RlguxgDc
         PBvEba/FY/XCihapa3YmOuVXiCd+JkdghOGo6l5oGUnyWfiPXd8kKr3RimsBeLA5EWSj
         M1/wrs8KDYq46uodupnIcnbtKpg/EVX9S0WuBAizCBQnHosJN4Go+QXM7K21B12ID/yr
         o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290248; x=1793895048;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGitExb5ASqG1hEb2tSa+iqDI3pMKELGUtvIGcSLDEQ=;
        b=oGNO/phXxK/YZeC/dkzqRlxU+I+oYpNwNcdlE8c/vFVQ2G+loqWnzqeHZo1/xpxIrI
         dvDZOtPModVoXnAtxsuqfzrw4YGTgVYOjgIcZeIpr5cMHm3bSwe1CtGpRjEhWtLGA2Kd
         LXqeEF29IjX/xI67OB0AsfiMc/mTMmkV56fYJMBY3HLXdMi1QRUz5q1nVtWCMbC1q+Ec
         K7acZw0Yuzn0XBTljl8G2X2YaUhJuRrWqzO0Xni/JifgbX8puubtVK4xCNZYSHas/SLi
         KlVClq5c2D8sb/ywhh2OW9gXDdzWOGqMsIIRDw/0RuAIQH8tzzA+IFvLoYYLylOsw6t3
         GaOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDzmlxA4BNTeSC1TnZ1bBSFioh7koTCrMyUk+acJ6AR4Ybnsm2TGciJuKkTeW5htpg4fKGiyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIASkx0U74f1V5GyURO6Jg5NavG9FRPG2pmap7s20b+DU8PgzNX
	CXJ2JGvIBhwVPp3gz/v6OL4Tk0bmHVoTA7s9a5J1+KZ01wX34AbCkydT
X-Gm-Gg: AYBFou0CztFDqa/HTXPtyjv/2QM3y8hLFE+D0p1wLB6prBjrFCiMZjB3pt7ll1STEtB
	FiPltmYZ5cHw8DwOYg8cCWtWgAjokzTJsgSbRQuJ4aTuBigkCeRpJR8WopX34GtTwzT3MC66d8Q
	0PV49QsEJnjMjmw5SlsPEUUTxM347ciguMTg7ChRlikVlIUfza2QuSJyqT91dF3VBRZ58dDYT9y
	LeZ7GnVTPlTc2ulKnjVB/+gjsvcUtFIZgrW9xfcAQ0QCrCmpLE8JK/CPYkMMhf4pTQQAt3/TOWK
	YaKnePhJm5MvICRWRkTfytXIK9tJtTox5AXAyYXfZw2eLafY+7RjGA3YnmSmt9b76QILK/tQTk9
	o3E8k2POsQC5SgATea97hpBvZL8D7xxVKdJ0XMV2/uySVKq91M35fu3eOC0fCOukjMHYtsBbezO
	FtW7dAwH/qIg5lrroVod/m1uosu81WmCCOqSJtFtLKdHYhmPsXivvmCmAfTWiYl0rii40c3laa/
	NTDGPqVcXY0EK+lF97IjscnnLDBUlqvISSuWKbERxNj+l1r4CyCuvWwzFTtpHYHVGR3zEwJu96g
	IN1XNRlerj2hDlkDtopNuwJNHkmewH0bAmWFxYihvjVhMpyxlk5dJsS6wRVOV1OUwWGBjUDKuWe
	rRpcAqxJ64FSPp3poCa4UCoZynau5LiIs4ZD8ttgfd2KTudMyPE5PGwTAb2ChyXTO7K5o
X-Received: by 2002:a05:6102:6a92:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d03a504ad3mr3020376137.13.1793290248125;
        Thu, 29 Oct 2026 09:10:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f8dfbddsm5953842e0c.6.2026.10.29.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:10:41 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:10:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
In-Reply-To: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
References: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: charge fanout groups to the memory cgroup
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ahmad AG wrote:
> fanout_add() allocates a new group with room for max_num_members
> socket pointers. Since commit 9c661b0b8544 ("net/packet: make
> packet_fanout.arr size configurable up to 64K") that is up to 64K
> pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
> The allocation uses GFP_KERNEL, so it is not charged to the caller's
> memory cgroup.
>
> Each packet socket can create its own group, so a process with
> CAP_NET_RAW in its own user and network namespace holds about 512 KB
> of kernel memory per open socket that its memory cgroup never sees.
> In a cgroup with memory.max set to 16M, 256 sockets each creating a
> group with max_num_members = 65536 took 264 MB of system memory while
> memory.current grew by 380 KB.
> 
> Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a

This is not the only such allocation in packet sockets that does not
account. If addressing that, probably scan all such allocations and
update them in one go.

> user can make on demand in the networking stack already do. With the
> change the same test in the 16M cgroup is stopped by the cgroup's OOM
> killer, and with memory.max at 512M the 256 groups charge 262656 KB
> for 264640 KB of system memory used.
> 
> The missing charge was found by code inspection of net/packet/ with
> the help of an LLM and then triggered with a small test program that
> creates the sockets and groups and reads memory.current; the numbers
> above are from that run. Tested in a QEMU/KVM guest on this tree
> (x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
> running the test as uid 1000 in a cgroup v2 memory cgroup.
> tools/testing/selftests/net/psock_fanout passes before and after.
> 
> Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
> configurable up to 64K")

Your email client corrupted the patch.

> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> ---
>  net/packet/af_packet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c91..406397acc5c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
> fanout_args *args)
>   /* legacy PACKET_FANOUT_MAX */
>   args->max_num_members = 256;
>   err = -ENOMEM;
> - match = kvzalloc_flex(*match, arr, args->max_num_members);
> + match = kvzalloc_flex(*match, arr, args->max_num_members,
> +      GFP_KERNEL_ACCOUNT);
>   if (!match)
>   goto out;
>   write_pnet(&match->net, sock_net(sk));
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> -- 
> 2.43.0


