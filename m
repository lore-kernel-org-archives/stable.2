Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6337189C;
	Fri, 21 Aug 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282912; cv=none; b=OuEK5RpP81o/75xkgk7SJd+wfgE27Y9rK3vA1Rpe5FoG7xOPQp81O6xd1q+UzDmEf2QfRGV7C8Ub1Mb3o3sVClWHs8iG4z/QNYZpKV1AJ7cg3Wx/P0NWD/Bce7n/pnqlCDdGQCunmR4N4eeg/Yp4Go6zY4i9PJXAoms9em+TF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282912; c=relaxed/simple;
	bh=SgIDj/Qoiw9IbD1da5NE7BBzdU3bJqbcJYLHQ4+hgrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID; b=fXmX8tKfvIY6IYagQesFp69x3uV13pmeu6XnWhzb78mI5baRNfw8/fIHJ75dX32Fa8H4riaZpR6B0PdGrc1rYtN6J+uTftSgjZhJ+dsOfpq7sw1n2ubC/Tk0tjDhYMH+1b4s0yXNOJ/Sn++UKkZ3OBqXiSfo8FLON2BUUJoTjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=k4T1yIyy; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="k4T1yIyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:
	In-Reply-To:References:Date:Message-ID; bh=SgIDj/Qoiw9IbD1da5NE7
	BBzdU3bJqbcJYLHQ4+hgrQ=; b=k4T1yIyyM+Nje8nZ3tl6IMPNaaK79nwJZAHr9
	3OP7a2ZBrBJdeoQIA+/ERJajI4BXxuYSZj+bZnmsEdV0iBeDP8ib4t9SRBRv+kIR
	42aZ2lkeHv7U4PPbUOYK+h47Pkqpo+bFca7erta/oQz6yX2t7xJiLLSAGdpOMjCe
	Q572EQ=
Received: from [127.0.1.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCXxs3XxYdqA6EAAA--.189S2;
	Fri, 21 Aug 2026 11:28:23 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Xie Bo <xb@ultrarisc.com>
Subject:
 Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
In-Reply-To:
 <CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
References: <20260721073612.137259-1-xb@ultrarisc.com>
	<CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
Date: Fri, 21 Aug 2026 11:28:08 +0800
Message-ID: <178728288861.534500.12009100192281293732@ultrarisc.com>
X-CM-TRANSID:AQAAfwCXxs3XxYdqA6EAAA--.189S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYL7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I
	0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAGB2qGcfoAPQAFsf
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi Anup,

The issue reported by Sashiko has been addressed in v2 by using
mutex_lock_killable() and returning -EINTR when the lock acquisition is
interrupted.

v2:
https://lore.kernel.org/r/20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com

Regards,
Xie Bo

