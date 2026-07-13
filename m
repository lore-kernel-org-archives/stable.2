Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1B36D9E0;
	Mon, 13 Jul 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925355; cv=none; b=Lv0rn6Guc9OFd1BjxXBuyn0Q8N8cPUUZyu264haPvy7KK9Ad9rN/Yb0Bz4nfLdRJw1PXJJ+ncibg5dWXpLtuN7E63V8TLCYLTnhB/dtFDQFOpTPb10QmLPb8dDTz0Qx4SGJb/cjx4uLRbOkf7QEDdXY4GawSgB5RTwYz6RY+gyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925355; c=relaxed/simple;
	bh=lyXqyOWVpjUYzeo6dapPbpq32QuBspJ7hsTTwK9skfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9EH8WICk11phLGj86MV0VbV9gqsKl3USPdKHhviFmwtYXh1PtqcDRcsqfBQJT2kRj6XMBLNI0SQNZs/9crLbo5U4MDu4SWdbYdVYaBtA8cWo/J5emBYp8mMXNlDV1VX6GQ1epn0GP0xdVzsORvuG72QeRzXvOKQESZ34UHFhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=SXyihkrh; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="SXyihkrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=RT5+wPpAl4iGgnsOvf4B4+nW8I0T9Bewcc
	bYyASGIJM=; b=SXyihkrhkelFqNAZwMW26Duz44LPCmx9msIr19v2BN4T/HcpE/
	ujQ5uiJ1rY8/i/WwdvqPy0Oko+eBq3a7uttYuEBehDk0ioT+WyavuEIepLeOKz4c
	Z7U3MwdEfXK+KStM/aKSRhDD4ITNxgqBkVImByIfAuiTxGDdxsPFQTC+s=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUJOilRqfnsQAA--.16812S2;
	Mon, 13 Jul 2026 14:49:01 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
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
	stable@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix lost virtual interrupts during IRQ sync
Date: Mon, 13 Jul 2026 14:48:14 +0800
Message-ID: <20260713064815.1276212-1-xb@ultrarisc.com>
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
X-CM-TRANSID:AQAAfwA3cUJOilRqfnsQAA--.16812S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYG7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAqzxv26x
	kF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU=
	=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2pUYNAAEwABsd

Hi Anup,

I have addressed all three suggestions in v3:

- use non-atomic bitmap operations while holding irqs_pending_lock;
- hold irqs_pending_lock across the AIA sync, flush, and pending checks,
  with lockdep assertions in the AIA helpers; and
- protect kvm_riscv_vcpu_has_interrupts() with the same lock.

I also rebased the patch onto Linux 7.2-rc3. Both RV64 and RV32 KVM
builds pass, and checkpatch reports no issues.

The v3 patch follows this reply.

Regards,
Xie Bo

