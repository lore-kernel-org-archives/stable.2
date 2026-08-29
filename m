Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5C28C5B1;
	Sat, 29 Aug 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974097; cv=none; b=Vs2vIcOfwtsKNBBj3r8a/XMnu9fNDJQbXVnnZ+rXLwqL5Q1cERVyvu5FanDTsYfc+qdgWAbuMcFYVTg33QgU45jAQuUSgH+Hnau7DyUjMDGjnjNMdh7Sgw5w2XSVD5CqO9+R5ZZhIfdSKaLSxKLa0v5X4e+PqCmA8BkZ0t7DbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974097; c=relaxed/simple;
	bh=v5Jqibtppcvma0ydNYcrBhGhBWs8XTElGsdUdpIK82w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3oamqMxy12CbJxWGdeJE1Boe+GHEZVaC1ljGOZwPi+jBc8t82W7XhLTpLgckUV8MHbfpWyoNWzaxODvo8DqU6JDPN99+yGQXGmdGwbOg6RdVAKGzgdq3e4q0fKqTFZ+n8G6IgT3psepnbl5jzNROHgRGrAUr7oKobHkXKxXUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=utIBuZYD; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="utIBuZYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ABcagkXZ5g
	Eg8oI8jLjTimEHAOga+6HwMrVGv7h2iFA=; b=utIBuZYDMqHPx+8+nPqQhdNLM0
	6dYcbd+jnbx9iiSNeTHqyL6fhj1awVXUIm8G9rOgUNkFFfEjyxHW9mUlq1F9cQjI
	n10pLQAb8jt+ogYybGd0HJ0P1R9simo5AmEHzE0wLvs7aunae4bYc5ZozEV9//vJ
	3Re4+EU64EpDXbuAM=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHyTC7UZJq71azAA--.191S2;
	Sat, 29 Aug 2026 11:27:56 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	joannelkoong@gmail.com
Subject: [PATCH 6.6.y 0/2] bpf: fix dynptr lifetime invalidation on release
Date: Sat, 29 Aug 2026 11:27:52 +0800
Message-ID: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDHyTC7UZJq71azAA--.191S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UKr18uF18WFyfCrW3ZFb_yoW8AryrpF
	yF9ayYqw1kJrsrC3s7Aa10vFyrGFs5X3y3GF93trWfAFn8JrykZr42gw17XFW3tr93Z3yU
	Zw1YqwnIkFWUZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_Jr
	ylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5pndUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor.  That refactor cannot be applied to
6.6.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies two stable-sized equivalents using the existing
6.6.y representation.  Patch 1 invalidates slice registers with the
released dynptr_id.  Patch 2 scans every call frame when invalidating
cloned dynptr stack slots.  They are split because the two bugs have
different introducing commits and independently testable effects.

Both patches preserve Amery's upstream authorship and complete trailer
chain.  Each commit message explicitly documents the deviations from
308c7a0ae885 and the reason for the stable-only implementation.

Tested on top of Linux 6.6.155 (a4a971135a2f):

- built kernel/bpf/verifier.o and bzImage;
- built the updated dynptr_fail.bpf.o selftest object;
- booted the patched kernel under QEMU and reran fresh reproducers;
- the slice-after-submit case is rejected with
  "R7 invalid mem access 'scalar'";
- the cross-frame control case loads and executes successfully, while
  the double-submit and submit/discard cases are rejected with
  "arg 1 is an unacquired reference".

Amery Hung (2):
  bpf: Invalidate dynptr slices by dynptr_id on release
  bpf: Invalidate dynptr clones in every call frame on release

 kernel/bpf/verifier.c                         | 60 ++++++++++++++-----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++
 2 files changed, 88 insertions(+), 14 deletions(-)


base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.43.0

