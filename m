Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DE4418CB;
	Thu,  4 Jun 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577257; cv=none; b=GYtQEOIpVnjNkUz5Lxdx+VbnTVh5Qd84fn1SuSs6xQGin5aSFMDCt36FdaBVgvMQI2ipEHVwaPSXD6mdc2qqS7ov45PY5XQKdt1ErH1HrogfPQdPlwT5ffg0JZKhvpyo2JqbMM7VTiA/lmac+dKqFOV2y8JZ3+adWCJflIC2DjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577257; c=relaxed/simple;
	bh=mGLL4gYZsxyjh0SOhyKACvq5R/hIckK43rjCgIeuSE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axCps5ZL+hhQse7v6dZaQSaN/6MQU+32K4Ktph8WSXLu4/5saoqXjG3jOYyxE2T+7nb1aH44MVQaD+wFNPGYOZvA+quvoVUKue8dbiySnCPfE08Is5eWpkYbj5EP7XpsIEParjs9gG2wydejqRdk3O0FtofWBJkSqkKk0AxmKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JQKqYv8Q; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JQKqYv8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780577224;
	bh=jHi0ltUOL5zvC2Rty/sIW4nOr19+20xTrMETwUpRcxQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JQKqYv8QeJVxZOTpyJZzr2JVAxM6Z7q+KQKYGez4BxvlIG4yACbTqmtgNFOEE4McP
	 P+kwZ0nD16skzLjYimKfxFMWR34PRo9UMq56OObG9eTDmRDSLwNTe6nZc0K4CEhcGC
	 zKLLTqey0XWAyHzbnJgat5htbyuzDFPphT/qOvLs=
X-QQ-mid: zesmtpsz4t1780577204tbaec641b
X-QQ-Originating-IP: HG91FUHEZ3GUlzVBNP359O1cQnfIv89a2YRKjs/3uUw=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 20:46:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1488707378607944439
EX-QQ-RecipientCnt: 9
From: Qiang Ma <maqianga@uniontech.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: return full old CSR value from kvm_emu_xchg_csr()
Date: Thu,  4 Jun 2026 20:34:33 +0800
Message-Id: <20260604123433.3182173-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJG2NVWVA7qwl8m2S2QOxwfG8OG4MmwljwqrQycMk0Ur0LfhVY/CRUYM
	OhFoQJzkW+fIirJCeYCg8s8m9I8b7wveBcc1CQYnAWniCQKufZokbGg1dyPcxGrjFku9IY6
	0VhPMdDWq3Ww7XnX1s4W9YbVBeQ6sbU3jn5/um2GXmL6LDNjTYDHXt1LnkaAGdxUNHbfogI
	8PcPsdkI5ONXgcLuaOSFaP2ZMiQMGJxIX1A+0iPgFsD5p3QNUHndFLWDs7L1AxARgRXGrx0
	KlXhWxVd2oXb2Sxnn5DtGwvBoHU7p85ZhjyAyUTF5PRFpN3miHGH43C1kkdDa6ynXA4KxGm
	beyJE3QWx9NkCog3iym0ToiHV1ZWz+cu6RXunvm/n+yCvvmkC0PQYE/Vr8rL3CpzgvWaOTI
	Pd6hHEFbAGPGXh1piPP7kqEggjjOiOiTxVkyaJl/Zg4Tcgu5kyUR+oRFuRVlOK+71bYoHQY
	6+THeCnEV6/XY3qzyKz+iAsuV2eAlNGmmmxJrx72TCky+cgmTnng7GbyB6ZVI4NLepIGlT/
	ytjSGjjmneDS3jNcYv7ZWrtM8q+3NDrbpSA7/UlljUZz+GVZceOHqr09arBlX5p6DxWt1A3
	6i4KPunIdPk8q1hOBP801iXJIcA4KgS0OTO4E54eB+lI7cAeRKTrqzvwkh51ErrZ3iTNgCQ
	2MJpW9zY1l78nF7I8OHI950x5DV0CmS9bQZqU5SzJGn47Ec278iFKiT8LBarj6EHe9XcPox
	rVwDrs2myFHylPMNCQsxHY2IkG7Fy1c8AzT8DvPxofxAq2VwN+Jhp6cguh3Gv56vBhtRFOH
	GyagdEE2UtZF+eL2WSnztGjir3n8YLQzZzk1iibpeuasT3o4zIdIOF57HSkT+yL6zzT+d/3
	tXE1nJwxugRhAVepiA9il+zC/nZQClXlHVKZA4KPXx3ef44FyGdHzFDBxDtcJvZ4K85benj
	4Q5LbVvv94j+Yx023REt8pbKQCPXq+ff6t7r9DVEAnt0mold329Ao2SbEh87tDZW6ZvtYOC
	D16TF9YlKGO+m1FxuZzcpCodbI8wsa8iRfg0fWIg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The LoongArch CSRXCHG instruction returns the full old CSR value in rd
after applying the masked update. kvm_emu_xchg_csr() currently masks
the saved value before returning it to the guest, so rd receives only
the bits selected by the write mask.

That breaks the architectural behavior and makes a zero mask return 0
instead of the previous CSR value. Keep the masked CSR update, but
return the unmodified old CSR value.

Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
Cc: stable@vger.kernel.org
Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/loongarch/kvm/exit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 3b95cd0f989b..264813d45cbe 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct kvm_vcpu *vcpu, int csrid,
 		old = kvm_read_sw_gcsr(csr, csrid);
 		val = (old & ~csr_mask) | (val & csr_mask);
 		kvm_write_sw_gcsr(csr, csrid, val);
-		old = old & csr_mask;
 	} else
 		pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", csrid, vcpu->arch.pc);
 
-- 
2.20.1

