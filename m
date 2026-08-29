Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159AD2EFD9B;
	Sat, 29 Aug 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974656; cv=none; b=GYXqzkJk+lEcZ8oOgKawLP9X1HtjLDfaPdbkxwRPdiuDLNeLDIEATM19GwkpqHX68M4zr+v5lrLY4w+XzTi+SIXHfOxoNytnmm6WE3tLUgRASWv+ml+dABj3zRLPLPYUHqztnn+7i9bHBuxeLpyPGfNCwckBKxyTyNGztIYRCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974656; c=relaxed/simple;
	bh=rldH9Z9VRCvCw9cruDSLBQiY4SjlTM8sOMvOIrAqm7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfpPcDrHpDO23liu6yyYjwGH1cCpmMGXDi/AqfTD8X9CO4JLAMKE3oRl3nW77Pau7A8ijYaz69ZLX0FkK8VrZHjK1Q6X9R33igtelY8SE3Mylabk6nIZG181Iiue31wwsmF0rJrKNdrgO3Ip2z3QVtu8gkZTQDRcI7WOBGVmYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=ZCuY75bi; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ZCuY75bi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=bZFt8Injtr
	owYAcmBqFA9s7elAZJQwgTv8v7EL+u4Ao=; b=ZCuY75biOS8eHVUk4iasCn7RFn
	kBqXJ5NSM4bjiyucEyqqPk4j49E3WDWXcZL1txkhRFQLT90p5DLuzpC7KklLpOZ1
	CIW/x1RxUzY8uoNrTG8+9Fee/4XsiP4LiENq2OojOhvDQkHxuGMrj6krsRAeYYuT
	fP9MYvlulw+5soM4Y=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnUxr2U5Jq0V+zAA--.4473S2;
	Sat, 29 Aug 2026 11:37:27 +0800 (CST)
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
Subject: [PATCH 6.12.y v2 0/2] bpf: fix dynptr lifetime invalidation on release
Date: Sat, 29 Aug 2026 11:37:23 +0800
Message-ID: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBnUxr2U5Jq0V+zAA--.4473S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UKr18uF18WFyfCrW3ZFb_yoW8uw1UpF
	WFkayYqrykJw47CF93Ar409F1rCFs5X3y3GFn3K34fA3Z8JryvvF43Kw17XFW7tr93Zay2
	9w45twnxCFWUZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5HUDtUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor.  That refactor cannot be applied to
6.12.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies two stable-sized equivalents using the existing
6.12.y representation.  Patch 1 invalidates slice registers with the
released dynptr_id.  Patch 2 scans every call frame when invalidating
cloned dynptr stack slots.  They are split because the two bugs have
different introducing commits and independently testable effects.

Both patches preserve Amery's upstream authorship and complete trailer
chain.  Each commit message explicitly documents the deviations from
308c7a0ae885 and the reason for the stable-only implementation.

Changes in v2:

- restore Amery as the author and retain the complete upstream trailer
  chain;
- add bracketed notes documenting the stable-only implementation;
- remove the exact PTR_TO_MEM type filter so slices carrying
  DYNPTR_TYPE_* flags are invalidated by dynptr_id;
- add the applicable dynptr slice/clone Fixes tags and identify the
  reporter;
- add a cross-frame clone regression test and tighten the slice test.

Tested on top of Linux 6.12.107 (f717995cb7dc):

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


base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.43.0

