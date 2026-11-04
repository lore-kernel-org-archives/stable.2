Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767211;
	b=LTBn4wH9cqJOKW9nbLhPJhHpYc6+QJFAPCzFiAJUEG2YnZX9FinN7V2E8jK/cxgrDqSB
	 fePdE7uSnLjpBciwrHycgnzhgcDLoh1MSUOOluMWt9UzL1JE4PGUWbrgGUha0JwqqfOzf
	 yvv6GkiDelQyB6sTu1OaJ846DyJn2TE2lSp6G91lg7lQE1+ARYsY89UJK9vSxmt6OtN3b
	 sffIuhM9nfc9MhYI3FGntF3hhZUzQ9PEIqNKJsp7zkhcssAcelX7mKuUV8EGhGpuq3E5c
	 +h4uncZwIdcN05qkDNhqxv0cN8vaaAfoPUXRqqjenXfFE+WZzVgYpao5bosvYFgjFYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yDNMtsvfB4pI9zwgFjMxckJnvbkqEPEwSr6fXlmbHxo=;
	b=Ev7Q80g03tGt7dc9wksEJZ5kdUHYqh/o9HTXJ65vpk/DlkZ1hPWOV3cu3XRo3j9dEOK3
	 DBvza3tz9uq4YyV90y2A/REsexPr86qYtQ2mVjT+M1eeU6711YZKXx8KphwYdSz0Y29yv
	 WNzTDojV++3SW+QNAaAj+82ykKfoQfXcGaR+rJnu/WWQD3LIq3rkvxz9PYKT4KcUutBuL
	 224Cxo4X9xzbpxDgx6aiM+s8K6wm4+aLHO01TRKVpxYGGNCU+Oh3vgXCFVION+1guIBFW
	 oXbmX6qxcpU+upBAqXx36XDD72APkIAqMhc9YkhusaNLHU7axQf05ho/pRagNHp2N1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtVmiQwC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F51606A32C;
	Wed,  4 Nov 2026 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtVmiQwC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8818F1F000C1;
	Wed,  4 Nov 2026 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767210;
	bh=yDNMtsvfB4pI9zwgFjMxckJnvbkqEPEwSr6fXlmbHxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NtVmiQwCOPgWwzgE5tddys6yEWRocATzwlqipdrPf7vl1EyTkz9O7JEAkZQLEuOvA
	 15ox5q3Uzup3Ie84LIhrDTuMjdGJ+owPeapboTH+/Df81ALsmGW0kP8FASPvyoXm/F
	 u8X6cXc2spEYpQRE9Hdab1J99SnpO6rNDTXh613xk6lZ7GtOJQ0lZCaCbiSfzYBKeQ
	 MgXGyOe9bVEV2jKwI05gjl9VW6ofPt4yQC/hDpZj1FdxxltyDVc7Z+Wqok8jThQnRk
	 cHepISR7tLGL+h2NM2EiUDBkb7z9/PaXdOuoKEJE2htl+Mnrd1xApDClmUvwqUIbem
	 WtsQnbZl3B3Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D28639D0C34;
	Wed,  4 Nov 2026 04:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH bpf-next 0/5] bpf: Fix three bugs around constant blinding
 and nop removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179376720904.2078713.14897677456982144973.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 04:40:09 +0000
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, luis.gerhorst@fau.de,
 henriette.herzog@rub.de, a.s.protopopov@gmail.com, xukuohai@huawei.com,
 hengqi.chen@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 02 Nov 2026 07:37:00 -0500 you wrote:
> Alexei listed three bugs that were in the tree before the patch list
> series [1]. Each patch fixes one, the last two add tests:
> 
>   bug                                                  fix   test
>   line info stays blinded when the JIT falls back      1     -
>   removing a nospec jump as a nop drops its barrier    2     4
>   log_true_size misses an error from blinding          3     5
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] bpf: Put the line info back when the JIT falls back after blinding
    https://git.kernel.org/bpf/bpf-next/c/82e89a32c974
  - [bpf-next,2/5] bpf: Keep the barrier of a nospec insn when removing nops
    https://git.kernel.org/bpf/bpf-next/c/ea2ae2cdadee
  - [bpf-next,3/5] bpf: Finalize the verifier log after the runtime is selected
    https://git.kernel.org/bpf/bpf-next/c/4dc6335da407
  - [bpf-next,4/5] selftests/bpf: Cover a nospec jump that becomes a nop
    https://git.kernel.org/bpf/bpf-next/c/08843010ceae
  - [bpf-next,5/5] selftests/bpf: Test log_true_size with an error from blinding
    https://git.kernel.org/bpf/bpf-next/c/970c0d366166

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


