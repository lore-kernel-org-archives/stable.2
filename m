Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0624339363;
	Mon, 14 Sep 2026 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355554; cv=none; b=Pt1TbgLX+YbbvQ37c1AP6Feo2VB5/L+dfVYXo2X7yUdM/5Q/5SOGhkgWHla9smHQJtLRHeSNv0gr3DZIDen3ut/iNNneLAdtLHeNho2KwgpXr3XkLLWzR/NzW+XsrO4TxrOfB1YMOU5uFulwwkPjWMLJUgJit/VPltfby72ZL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355554; c=relaxed/simple;
	bh=huKWwb8rlJf3+N6r/GnqyXXU00p1lhy5cN8M9ZjYp0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLHOzzUQyQDokwyTa0KqtO2cJkVRs4jtowKJNyZdA/w1eyD/uPOfQ13GAG7TSDyvt7SadSbY+WTXcs7zE4YIFMdFSaoZl29ckV3lsT5t3Niz+N8a6CjaOoxpd3YaNVukdOcox+X6Bqy5posQbPvZmS0zQqvC5qEsLOGU/t4zuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from k3-03 (unknown [159.226.43.8])
	by APP-05 (Coremail) with SMTP id zQCowABn0Tv4ZadqJ0crCA--.15303S2;
	Mon, 14 Sep 2026 11:11:59 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tan Chi <tanchi25@mails.ucas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix HSM hart status error propagation
Date: Mon, 14 Sep 2026 11:11:46 +0800
Message-ID: <20260914031146.446157-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0Tv4ZadqJ0crCA--.15303S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur47GF48ZrWrZrW8JFWxtFb_yoW8Xr4rpr
	ZrGa1DurWFkFy0gasFya1q9FW5uFsagrnakw1kKw4Fv3yjvFW5Xr4vg34aqry5Aa48Wr1I
	9FWYqF90v3Z8Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjfb15UU
	UUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/

kvm_sbi_hsm_vcpu_get_status() returns SBI_ERR_INVALID_PARAM when
the requested hart does not exist. However, the HART_STATUS case
returns from the SBI handler without storing this error in
retdata->err_val.

As a result, a guest querying the status of a non-existent hart
observes SBI_SUCCESS instead of SBI_ERR_INVALID_PARAM.

Use the common SBI error handling path for HART_STATUS after
saving a valid hart state in retdata->out_val. This preserves
the returned error when kvm_sbi_hsm_vcpu_get_status() fails.

Fixes: bae0dfd74e01 ("RISC-V: KVM: Modify SBI extension handler to return SBI error code")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 arch/riscv/kvm/vcpu_sbi_hsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index f26207f84bab..06a15629c26b 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -95,9 +95,9 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		ret = kvm_sbi_hsm_vcpu_get_status(vcpu);
 		if (ret >= 0) {
 			retdata->out_val = ret;
-			retdata->err_val = 0;
+			ret = 0;
 		}
-		return 0;
+		break;
 	case SBI_EXT_HSM_HART_SUSPEND:
 		switch (lower_32_bits(cp->a0)) {
 		case SBI_HSM_SUSPEND_RET_DEFAULT:

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

