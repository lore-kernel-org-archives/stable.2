Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2D4756B8;
	Mon, 31 Aug 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191929; cv=none; b=WIC+RgxxOmSmid2Pl/9hG4nTC8uPXZnnfAPu9CZ3eQu59X3zvyBWrdxvFjc5FQq9xFn2fp33pQJbhk3BsUPyMx9ySklGqX7HuhtpwuVp5/oP3ZX5rG7sXyL2ZrkGi+oGPlyqlCQZYB0FopNdn9WfEgtgJ5NjZcMT9aG3t6HW/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191929; c=relaxed/simple;
	bh=T55Y4uuAJxv3WFPq9booCQyLTm0GRA0jZMZzHT3QGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f29LWLDe71zczd6hiAWbQnWRAbR0CZBLKdChrsuFQ1IgkZCGPDmMmoPxq+gfTyA5xoOxndqTuF1x9QioNhQy1YQScqAoKCdG8gEDSDIJRlAxtVMSgGnMP+PJy7xIy5mcUPsS7qEJ0kvd639UqV/q9CsSRExcE2IjhfK8hfLr5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=yCpJ8rTp; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="yCpJ8rTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=8QKolhDVGV745+l9s8oWeKbAfzNFG57ejA
	T33PjDnKc=; b=yCpJ8rTpJ78z1GQP1brzfNXlqaDw8fkjSnlAsYiDOd+p4CoANe
	KYKKAjOAQNeoYNznWP4xv1uJpG8paKaXIWleMpfyHCqkYMf6q+WY6kvyxTSUTXNp
	3YPjrHQq4s+LMd3WFHxNTC8fmimETGD1osQgWao7RbVl9fwGNoZ2Y35as=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnLTSnpJVqV_vCAA--.5094S2;
	Mon, 31 Aug 2026 23:58:32 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	joannelkoong@gmail.com,
	sashal@kernel.org
Subject: Re: [PATCH 6.12.y v4 0/3] bpf: fix dynptr release handling
Date: Mon, 31 Aug 2026 23:58:14 +0800
Message-ID: <20260831155815.70167-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026083135-hammock-bagel-3147@gregkh>
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn> <2026083135-hammock-bagel-3147@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnLTSnpJVqV_vCAA--.5094S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw1kGw18tFy5Wr4DXr1UWrg_yoW8JF45pr
	WfGrWjqrsYkr48tas7ur42yFy8Wanagay7uFyFkFW7X3WkX348WF4aqryavFyxArs3uw1Y
	qr4Yvry8GF4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryrMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYU-PUUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Hi Greg,

Thanks. I understand that I should drop the three stable-specific
implementations, preserve Amery's original authorship, changelog, and
trailer chain, and cover 6.6.y, 6.12.y, 6.18.y, and 7.1.y.

Before rerolling, could I confirm how the prerequisite chain should be
handled?

Commit 308c7a0ae885 ("bpf: Refactor object relationship tracking and
fix dynptr UAF bug") is patch 5 of its upstream series and relies on
these preceding commits:

  bab08d1f70438 ("bpf: Simplify mark_stack_slot_obj_read() and callers")
  b5c0a07eb2c23 ("bpf: Unify dynptr handling in the verifier")
  94ac7553361f3 ("bpf: Assign reg->id when getting referenced kptr from ctx")
  06d518a5583fa ("bpf: Preserve reg->id of pointer objects after null-check")

I do not find these commits in any of the four target stable branches.
In particular, the latter commits establish the reg->id semantics used
by 308c7a0ae885, so applying that commit alone would not be semantically
complete.

My plan is to prepare a five-patch backport series for each stable
branch, preserving the original authorship, changelog, and trailer chain
of every commit, and adding only branch-specific conflict notes and my
final Signed-off-by.

Is that what you had in mind?

Thanks,
Xu

