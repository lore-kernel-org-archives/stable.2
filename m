Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794642293;
	b=LuSn9zpdsnR8XRiF7SxcCzZd1nQdVT3MPOubHzU9D1hCODdTkBNdStWfV9blaw7Lx/3/
	 N7nDe0XMK+YkXEM7dYAlov4X3CpHTc+Bl5Fn7wDvV9jpZ9Jh+lLFLETxTwWTdGFJuIXd7
	 sjqUU5UWlYeTNc3zG59A8f9Vd3u32jLCOlpUQoI5Yz7YBGyjChLK9OS1ik4QuJNLrw3R5
	 XsDkYWPUJ+Er/uyc1Oaodb7oM3MJHdJ3qOp4a1NtcsP78YcjbTW59ooUCLFk0oqB4MWKp
	 hCz5/Csz+heXEBmRamkrR54my1FDrTMNK5Z1lHiQCRt4ugqN18bIhP3av266EYuz8wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794642293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e3A7gGjqJdGZgTWJM2XoL79jlQpwRLz/9JBwDnVXF7A=;
	b=4BxvjE2o/Rkj68cpyqHE6MgSh8P8eNB+h75EReE6crsQfEE5B8JRpFhjU6BfZJb3QZkM
	 meITtcOx2g8bqwi7BNk4OknUbD6twlksznrzhIkVJhhR1NBZdEm7fWGqp4H+xSwvfLQc5
	 bDqN+hZnoFQhW2YMTfFB6F2LhlDTihNhanhph2zFAJ/buvlET6eos6jGyFWogUKXOv4HQ
	 cxN+pL+zNZ5MX0g4ols8cIJjKcKjZ5nVp8FELWLBC5d2NxVrdRlrtWCnDeInWwkfuZ0PU
	 XXskAg9YkbY/wa/FiBzMV/wdUAcqF7QlWkWRmXvFxFWz9V0GkSM5By5zvXoNmRGztPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEmKY0Ln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC111606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEmKY0Ln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2900B1F000C4;
	Sat, 14 Nov 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794642293;
	bh=e3A7gGjqJdGZgTWJM2XoL79jlQpwRLz/9JBwDnVXF7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEmKY0LnOFOuY+H2JdoNzEh00N/8GFtK5GotRrPUzkKSBiSwQhyOSWsnnYC8kxgjb
	 fD044v5t2+cXoRa18ikeu5BHKZIxe3HaHh30i1uglB849UhX6rzzI+/ZyROT8e8NF2
	 bJjzzNsLlChVIsDmoK+YIa7DGOuk35slxk69jjzHQV+KYrCu9nqocnH3URz/uiwma1
	 PzMXo3ZMqLoCVM1tGh6W/hao2rAGHKWPtM2K/ioDwmHP0LkVidYMzvzYEZ4Fv3huMu
	 7MjowSERvXAR1SWvsKgXK3oTnDAyZ9Hkw1sAd+jLaEK8JtkZhQOhSXg3IyH2dzSn0y
	 VabA4aA5t0nPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Will Deacon <will@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] arm64: kexec_file: Fix elf_headers memory leak in retry loop
Date: Sat, 14 Nov 2026 02:44:50 -0500
Message-ID: <20261114074433.3235650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202921-failed-5.10-ac302aea3d82@kernel.org>
References: <20261109202921-failed-5.10-ac302aea3d82@kernel.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit ac302aea3d824ccc99f29b8e499c365cb9a684a9 ]

A retry allocates new elf headers and overwrites image->elf_headers,
leaking the previous buffer.

Free it before assigning.

Cc: Will Deacon <will@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
[catalin.marinas@arm.com: drop the redundant NULL check before vfree()]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ sashal: Changed the vfree() argument from image->elf_headers to image->arch.elf_headers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 0cde47a63bebf..1226d665a5872 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -284,6 +284,8 @@ int load_other_segments(struct kimage *image,
 			vfree(headers);
 			goto out_err;
 		}
+
+		vfree(image->arch.elf_headers);
 		image->arch.elf_headers = headers;
 		image->arch.elf_headers_mem = kbuf.mem;
 		image->arch.elf_headers_sz = headers_sz;
-- 
2.53.0

