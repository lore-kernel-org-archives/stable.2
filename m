Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083438F62A;
	Mon, 13 Jul 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928050; cv=none; b=DssQuhwPMzt+dHcbo+CLqIK/wcYwiGuYJj5zUPqDezjBCQSWVYKnqED47oAOXU39d2fH3IkvkJNY3u8gRWp2VAlM4HPShxMYvNz3qli6pjBVPEl5LNPDIiY83+Y504zkt55exC8jSx17CIlRe54gqcEV4RcDYouD0JTNCuGht6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928050; c=relaxed/simple;
	bh=5EsQAGcW3lKZK7yZPg3wu2Pv2XPmCi8qN8NuZceqpd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzeBzSR8NzGqHQODLX+zI12TCiJ5CX/AZlb6njC4nZ1PIyMrEhd7Dwa3OZZpjts+MygQSDm/AKxzMhTEL0oNnsw+K/l8nIevIvD+3vCF/BClXSByFOYVVqdj8UuE8B3mziFm4vtvMwNuOxPgm7EBe+RhwQxrH4M4qoZoDB4XZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=GXgBy5Pl; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="GXgBy5Pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5EsQAGcW3lKZK7yZPg3wu2Pv2XPmCi8qN8
	NuZceqpd0=; b=GXgBy5PlYQz1xx/8DoEMpeNDbnJZ/beB2bjgXsH9MPpUDIYRsL
	hiZcQqdtffz6tfUt6waWDecTjsE6pUWlZLM+6wZTekQkzKlNE16rByk1ohdrCoOC
	50qJ4SH1MFdbGVcQDGtzNlZBZMtG+BXL0DtdKDfMpyOoqy9WgrSF9sbq4=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUL5lFRqtIEQAA--.16562S2;
	Mon, 13 Jul 2026 15:34:20 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Xie Bo <xb@ultrarisc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix lost virtual interrupts during IRQ sync
Date: Mon, 13 Jul 2026 15:33:36 +0800
Message-ID: <20260713073346.1293408-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com> <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUL5lFRqtIEQAA--.16562S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4kGFy3uw4fJF4fGw1UGFg_yoWxKFg_Wr
	yrZ39rG34xJw4ay3Z5Xrna9rsagw1kAw4xGws7uFn7Jwn8AFs3WaykCrnxuwsxJayFya45
	tr18Wa1fAan3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2pUYNAAEwAIsU

Hi Anup,

After sending v3, I found that kvm_riscv_vcpu_has_interrupts() held
irqs_pending_lock while the AIA helper could acquire the IMSIC
vsfile_lock. Since vsfile_lock is sleepable on PREEMPT_RT, this creates
a sleep-in-atomic issue. IMSIC update paths can also acquire the locks
in the reverse order, creating an ABBA lock ordering cycle.

I fixed this in v4 by splitting the AIA high pending bitmap check from
the IMSIC VS-file check. The bitmap check remains protected by
irqs_pending_lock, while the IMSIC check runs after releasing it.

The v4 patch is still based on Linux 7.2-rc3. Both RV64 and RV32 KVM
builds pass, and checkpatch reports no issues.

The v4 patch follows this reply.

Regards,
Xie Bo

