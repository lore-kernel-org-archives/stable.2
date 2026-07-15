Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF138F64C;
	Wed, 15 Jul 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081069; cv=none; b=PybACNXj8PSUZ2geuKozToFcmX7KLV6wR49rXa7aiVwf4VIHLz1Y+kFGYrQmSDZ1g/tOJ/tZcUwO2afkbU8cyfbjXYu3/Vhp14W1de7z3OYlah3kI74vezbWe4ZCWGM48+SWTcJSweIvVIAh+4loZzPSN5mIEL3A4+MLmVqYqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081069; c=relaxed/simple;
	bh=PX5km05g/W6UeP4bHhbxX3nQahWLu0TE7I9fhNhU8ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUsPqRNGH0IY7pfexbId0t6d8NrDntYXLTx/efWCmlzFiaEVL74yLzQUX21OA+1tBieaf2S6nZC8oKdUwX1p9ZJ+98dA42tmLa5Nt7QHgXQK+95L0e7FLw6Dso73DYQpqmxornn57nSg8JLZZzAuRaOb/rIPaM7rXBUhF6RG+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ECfOVz8J; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="ECfOVz8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Ux+YlDFnPNWIMjq0BvNP9tiG0/QVCKDhsi
	CSzr+cmBM=; b=ECfOVz8JkJ/xiz+0tGE5UVlsczMbKo580e3uvhIWyTrGXXtKP9
	iBrfeVxO70nCGlb0tOmssK6DlPMV9RCAxvtLSd6GaV1+Hhh+rDXXP9v05mZv0GZ1
	QlXb3JQQdf8dy0O1CCDQzzTxCyYmwVD8yCTn/VV0uJcB8jvbXeNG9P89Y=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKu6lZqDtkRAA--.16825S2;
	Wed, 15 Jul 2026 10:04:31 +0800 (CST)
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
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Wed, 15 Jul 2026 10:03:58 +0800
Message-ID: <20260715020359.1521354-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com> <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com> <20260713073346.1293408-1-xb@ultrarisc.com> <20260713073346.1293408-2-xb@ultrarisc.com> <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUKu6lZqDtkRAA--.16825S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW8KF1xur43XFWDJw1UJrb_yoWxArg_W3
	4aka17G34kJF43ta95Ar48CrsYgw1DCa4xGw4Sgr9rtrn5CF43WFZ7ArnxWwn7J3yYva43
	twn09an2gayayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2pUYNAARQAEsO

Hi Anup,

I addressed your comments in v5:

- kept kvm_riscv_vcpu_aia_has_interrupts() as a single helper and made
  it acquire irqs_pending_lock internally while checking the high
  pending bitmap;
- released irqs_pending_lock before the IMSIC VS-file check, since that
  path takes vsfile_lock;
- kept the guest CSR updates outside the critical section and protected
  only the dirty bitmap updates; and
- added the requested whitespace and clarified the race example.

The patch remains based on Linux 7.2-rc3. RV64, RV32, and RV64 with
PREEMPT_RT KVM builds pass, and checkpatch reports no issues.

The v5 patch follows this reply.

Regards,
Xie Bo

