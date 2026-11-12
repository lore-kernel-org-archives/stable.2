Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501479;
	b=rsXlMQCafPErZIkM1Z+o905kiM1pABWaEfoWxSZvv9Uc2MttwhZiZf851ufOhFoR1Iyf
	 YZaS7Odn+/JcHg6GG3vJUru7KOHBFRJiYFjqSROhaZvlZn9IKND/mhUUk0Z00AHgcGZ9B
	 +BPvHJbHXBKzZbnOQ7rLkaZHoUGXN6sUSIf/IBYz1nF1vEztkvZ0Zlw+hBlFtOnCc1SXx
	 sX1mAN2y7UeY77LeM9naFeISOuDC8Q09zuB2a/xYkWp2ThTJkVqEj/DTFXPuQLjwdMw4b
	 g/YWYld1EiapjqaMXD1JyYMCUvKpilhqRu8uNE2jJ9RYQpkyQxoc4sHN3Sx0w82In4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501479;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=;
	b=OBCBjgVjQScqoWMJYUejHRX2Rx07ic5xLOen07V5jQ//+Rq7s3InEIV4qCt9AY9FRhpB
	 4/mh+X6m//oEO/GdvlfgFnEhc8Yi5YIWGlWGRv3JbSAh775ReqU272aR+dTzAt9pLLKwR
	 ShShjSC1whZcxHQAdh1MhQtE4nrJLVl1z41RPOzcl5wg+vM0RBZcP0SpxfruIJZYtHt4n
	 tag7KPfUxfUCg7siMgdCrJOx1t+M3U8KIv+dW7jfiILuTZrCwQ5aa9UG1JIRaGXJM1Vu5
	 yhIshipYB09fLdUToJIWfUnVnwEBNfM3pSBJ/dPveb9Uznl+pjK0CwHmAM6xy/yHpQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GXVr4/I2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69E606A884;
	Thu, 12 Nov 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVr4/I2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEF1F000CC;
	Thu, 12 Nov 2026 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501478;
	bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GXVr4/I21EXRfq59LPVJh+GmLyWYGYkNNqjQsKf3zPXFlW0NWJtf5rPpcYS7KOSdX
	 cuvsiMR6wRMGlfXHs45dfh/aiyCJKPpwkJ7InATFRZtni627BvP/NEfYa5Ri9Wl7Zm
	 MbwX+2ixCbawrFxG2m/qE3K5amQhVt9WGB8GswGm5IwnOCODWz265MPKp37n2GQi2l
	 M1bo6PXczS1it8gll8U/oh+d1dTFskrjXYWMy/I7fMgUryBIBX8Q1mPirE6GGU5+RQ
	 WyRFjq2bSV9lTVbdhV9MZsFaflA7hPleW9EzEyCV0hrkShXp4EzDcRquIE/QuL/MiG
	 4H11/+PoqQmwA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:07 +0100
Subject: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ok0CVH0NZbW9pFZQURYCmgK7NHT0tqdpELAezILCuX8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR1hPytaT0Fg3571WX5Pc49l9Ljm5hpfSjOaFKiXc
 /+Nd/DXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksrWFk2DblYlb2+wtcAm9f
 9Urw2pVlH9jjtld/qn2aTOpzlZI/+owM3+QcSm04dq2PmNo4h83lzbOWLSZyi39PsZWtrdseFlz
 CAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

copy_oldmem_page() maps a page of the old kernel that isn't in the
linear mapping with ioremap_cache() and copies from it without checking
whether the mapping worked. If it didn't, the copy reads from an offset
into the NULL page. That oopses unless the copy happens to be a user
copy, whose exception table entries turn the fault into a short copy.

Return -ENOMEM like the other architectures do. read_from_oldmem()
turns that into -EFAULT like any other short copy.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Cc: stable@vger.kernel.org
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 103b6605dd68f..1543917bd3e1d 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
+		if (!vaddr)
+			return -ENOMEM;
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}

-- 
2.53.0

