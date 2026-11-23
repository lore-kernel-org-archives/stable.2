Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406825;
	b=jUTiehj9ueTk2oLwrbkgbCskNo4R952YYJ6JQN/LlOouHS4PWWLTE0D6QryDVrlFZEsZ
	 HK5pABR09WBcO/DSg8TDWKZLnIB758XQkNgJfQlB8/mT64qbosSPCYU+beGZAKT25fB+1
	 Ub27mQu1/xaReqYMuxas/6zC0LLWLlCmYX20j+fBSujWPbQrEU9fSIAZYbA+V62Nhk8ag
	 Q+ZRAG8geZf8blfHNkNgu/tH+k2HUPnbN2Q1vUiY6DkFKAxE+oZrb9JYA+5U2rHqwPlm/
	 n7IBTgyxITlnsORlI4lb+JaNyJqWw//dyq/NiKi+VAA56GyBCBt7GfKpwAmnGjdEP7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
	b=1PGxxqXvzFcp0gFK+APCxfbwiihhcewWqMrIDX+O1QE8eFVyKkl8O/AGakRSAcLXDX7P
	 x8v+TpqhQkfFXamC7c5hq2f3DNLl7o3caJKiWuYpEjLliQFJ4gszi96ICWTDvJqH60w+m
	 1aqJQp7YsgyXIz5cmn+Ibj6NygXfd+Jnm1czNL1zMR346gD4c3C+2lox6sp2aJexX9ns+
	 eOE+f/TcU4uJrIoTeZTSuzS2oKzOxZaRXnPMgzkmgBtI64zl33jSUDNONJpFPYKtR5+F7
	 uW1kDScgfKJAYH3E8tqQ462UR9daBvV6AHZk7R0Pmt0kHKXWdgbfDdobKjb8Dfy5DBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrkVMVM8;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1312606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1312606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrkVMVM8
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cde84cb8803so308321a12.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795406824; x=1796011624; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
        b=zrkVMVM8fiHIA2UIO1Um5i49tmxW5eAK/JbbSxShAL8W/6EY0z524g/bRIpvKqlMDo
         6aKIXn27f6nZ/hN1j3RBtpx3nDs//cfaPPVaWZR6AvCdt+HOKLsKNZvWbsjXNtuO+SN9
         /aI/c9/i1dEUrMglw2IFAf3wpR5tBymGIoQFag5KJ+JqP29kvrOa8hCq6xBemxljADkW
         tzXv0bBUBqcFmUpbcirQeDeWwn9tD2B/2MUi9/4BtsfklBJX/0KFxHRZZrRkHs/zfdEe
         Zma8doDyTSAzPcxB2PShBO+k9yTHKjjM7rRECrAgOvOz2+Za8g3vZm0zubw0SFWmzqwk
         YNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795406824; x=1796011624;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
        b=Z5M1GaLEqhD7mhEEQ4OjP3OU8nrH0myjEkmQ9oD+nFY7KTe3k4DJgpwyWEanUwwSbb
         DbykCeSnxQmPzgpMyPmH367mlfneMigOk9TrjqtQQls3ryWau/ON8KvNDjgXtTP1vgzM
         6cADjlVoR/dMTgap7pEc41pIVyM0jiEgbJq55rGnUY4hx7COaVX+BjZ7EFcFMU84DVMT
         PgzPzua3UCnNFHKSBgGi/2m1lY1+7ZVZz+404po19wxB7tWGtMSTV8KYB393EAEDCPfO
         n7dyA25kisg1sWtJ3iCoFtiB0L64p/Yhr2OkGxLePQxml0AIYu41xKspURp0lsS1P8sj
         QZpQ==
X-Forwarded-Encrypted: i=1; AL+hErEdJ55lt/Ds8we+2WOq2YqtOL+xEi8xdSAbA/1hBNhf/72lXkXukCM31U/Kj2VQ2bzC2aAoAIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XkffPI6S50i+cHa+lIudZfk/95d5O2s71FsE5OggZZafTGQRS
	dD0yBX4iduzaXgYQqgI3puNQ3cF4SJ9tXfoUITq/r3dkreslTW6YmVLvpgi7uA==
X-Gm-Gg: AZFdTZe5k9iWGy/LpjhThq2woaoLJof5IH+R2IkBqwqwFAoYtMhCN3jxF+Bb0Citz++
	xcnJ2HhbPFnjonIheEUpO4LQikWbiwQrOPzkDg6jzwjdcKCXka9rhItPy8kkkgYd3CMsYaUTtZl
	lgy4wEiOcV/6u6cVP8qXfK9cAxGm+lg1Gtg2Xz0P431emC6SvxmQLDwKOAerg4Oz3THOrTvSQ6r
	dhdTCXMnSrnT/gS949FDqTTSR0Gv4FvDLswq6TYm4D4uk1zcwJHys6eM5j6Y/JkKAUm/uO5eRXf
	SJLSrhQuFVKgfFyTpjJbBkKs9sYT0aVEcEdoe2iBeyZdl8x4ewq/Kc4F86N+dg+76BkK8akAzEZ
	o0d7bEjlTyPBFdWBTz9XGm4+48ttbCc0g1FkqIHaHceIkTp2NOfCJ7z4dCgwwHetR/Dm1yOuB6S
	MLrFUKEQScKyUcqoZ1q16jS0UTDyK31aHQpqnf9Za3wuwAEHDpD96J0eyIYTHmPfDDypliGNxRS
	Pp8nRFD3EFC3AIxLke2kb0eHSJu5e3LpB6jk30kruHzq28MN9iYJYqvjS0WBsikNjsn/72igNTi
	jrDhue+0zxPZTivdKN5zMuPqJrqNGgqObEWkWUEFLDZy2Hpl2wVyqbmWZ9+PP1lJDo4ueXxnQ5+
	fL1aY+ON3Cw5d8TwtIyqjxEvQl0tXMQYADw==
X-Received: by 2002:a17:90a:e70c:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b41c955b0emr9277361a91.51.1795406823840;
        Sun, 22 Nov 2026 20:07:03 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm15511490a91.4.2026.11.22.20.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 20:07:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 04:07:03 +0000
Message-Id: <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>
Cc: "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com> <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com> <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com> <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 12:58 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
> BPF code - I've only removed an out of date comment in BPF code, which assumed
> the code path was for Spectre v4 only. But that's not true since Commit
> dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").

Fair enough, but the arm64 part of that comment is stale.
The verifier relies on nospec for v1 since
commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1").

> arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
> the same situation as x86. I think this is orthogonal to whether or not the BPF
> interpreter permits speculation attacks in other places?

Not quite. In the interpreter the barrier sits behind an indirect branch:

  goto *jumptable[insn->code];

arm64 has no retpoline, and the prog can train this branch.
With a wrong target the CPU skips ST_NOSPEC and runs the next insn.
So the interpreter is still not safe.
Yet you're arguing that you're making bpf interpreter a viable option
on arm64. That's just not fair to users.
Say it in the commit log that you're fixing one tiny issue and leaving
giant security hole in place.
With that I'm no longer nacking it.

> Looking at bpf-next, it is still possible to deselect BPF_JIT when building. If
> this is such a security issue, shouldn't we disallow that on arm64, or at the
> every least make it an EXPERT option?

Yeah. Good point. Let's disallow it on arm64 and x86-64.

I'm thinking to push something like this

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d705d7b..8b8688d 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -26,8 +26,8 @@ config HAVE_EBPF_JIT_KASAN
 config ARCH_WANT_DEFAULT_BPF_JIT
 	bool
 
-# Used by archs to tell that kernels that were compiled with BPF JIT support
-# have no BPF interpreter.
+# Used by archs to tell that kernels with the bpf() system call have the
+# BPF JIT compiler and no BPF interpreter.
 config ARCH_WANT_BPF_JIT_ALWAYS_ON
 	bool
 
@@ -36,6 +36,7 @@ menu "BPF subsystem"
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
+	select BPF_JIT if ARCH_WANT_BPF_JIT_ALWAYS_ON
 	select IRQ_WORK
 	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
