Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274164;
	b=AHW3yJb3e28bZJUVwFWWEXLpoYqzLolUDnt4x/tu6koAFNkNhoTkwUcJ3Ui7k6IBiufz
	 26ydTBc7OfIEIl9JsjVR+oGqH/PUdJRComb5ed5c+W1QdBKJgp3IfJwY8tUl4VApX6LV6
	 WkqhXJbBD0b6B+NRBeqf7DhLkJYf7dOBEN+5oT4vs2FctPdz1UidrFt02x83y4zUxVn2h
	 Ml1yKo1gwoUhfrGzwa5yHn1kukmwm7K++uW4v74ppgYSBhl+m51Y4clRZAXBrxFc3SeUz
	 ufPUkQs8kCDb8oplsFotF7VkEp899cl3Yjq2HGUx3Z50FqZDeiF+2GdTgYFaHr0etqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dlfsidgNwJocoLDleEGDiZVDJ5E1YSokvbmj+g5R6w0=;
	b=byN8EjpAREEx4jxElDbBvMNgMyBMQ3zXzXVnHxH/uzxCd8XHy94ddwN2ywKU46Mg9LqE
	 djblF6vbA1xPsxg95XzbFvcJ+PuekeIUFEnYF5NexAV5QOFy+rCBhY+4rcYamrZ4Exufq
	 IV5BzF38/3lrFhUwXM2Wcx6wI9E1xte4PpaJZGxL9EpcD7/H7whqagk9xfGSXIyV4fUnZ
	 nlAtPoE7IuFXINwfg9R2dHg8fpT16O6EVP8v6B1tfo9ciVe0HbHeRaEQYfvKCV3D/zzEN
	 HaV0bZlUmM9qb15aJI6L1EA1QmWqzf0vSNFLrLesAKDNTpuec9cuElxIAPqaVQVrfFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIzEaA1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIzEaA1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D193B1F0089F;
	Tue, 10 Nov 2026 01:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274163;
	bh=dlfsidgNwJocoLDleEGDiZVDJ5E1YSokvbmj+g5R6w0=;
	h=From:To:Cc:Subject:Date;
	b=lIzEaA1TLeh4smA1fi7HzeZbPg0wH/tHnKlD6uEMP5eblNErL7AS3ZJjOt/+dItPA
	 t8liK5PPNAlTvCOeGGjnNXTkwb5/kLq6nOUsaQHk4JDmSoY/ks3K03tvjX6ERJ5xCd
	 Yi5Mm8ry7iqpfgan/WM7U7syGcPoCAhU7E0gzf5gU/u8dw1T2CkIp6m7Mt9F6EHMLS
	 ThjuhfFq6EAfd3uFzVSyFF31zRwJwIHcyQSCCJuk9MJaBfR5ZlQaSXt0gi0bJzngIE
	 YSQI6410YxBaxkM9LmIYS3zjcYgtSdLU+DIRiA/YeDF7ep/TnKbw7+jwICA0vNrOq1
	 RnlX7Yb7KBokA==
From: Sasha Levin <sashal@kernel.org>
To: ruanjinjie@huawei.com,
	will@kernel.org,
	thuth@redhat.com,
	leitao@debian.org,
	akpm@linux-foundation.org,
	yeoreum.yun@arm.com,
	bhe@redhat.com,
	catalin.marinas@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: kexec_file: Fix elf_headers memory leak in retry loop" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:21 -0500
Message-ID: <20261109202921-failed-5.10-ac302aea3d82@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ac302aea3d824ccc99f29b8e499c365cb9a684a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202921-failed-5.10-ac302aea3d82@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ac302aea3d824ccc99f29b8e499c365cb9a684a9 Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 5 Nov 2026 20:57:24 +0800
Subject: [PATCH] arm64: kexec_file: Fix elf_headers memory leak in retry loop

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
---
 arch/arm64/kernel/machine_kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 854d872dfd0f5..14f453dd09465 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -112,6 +112,8 @@ int load_other_segments(struct kimage *image,
 			vfree(headers);
 			goto out_err;
 		}
+
+		vfree(image->elf_headers);
 		image->elf_headers = headers;
 		image->elf_load_addr = kbuf.mem;
 		image->elf_headers_sz = headers_sz;
-- 
2.53.0




