Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F381311C27
	for <stable@vger.kernel.org>; Sun, 31 May 2026 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235633; cv=none; b=WEiagWvciHDq7Mvm1+/eXmto0mQy4w3fav70mTaicYgxqiyYnb45ZO+huu1e3YFEoZ6/Bh2fhHhFum4uqvwjWWQH9DXXXrieMjwQRMPFTr+R5SEXUrCjEHgDrYpMBme9bwJPEBQsCYWd1dCaCQZAYnmZkYRYquuKkvm5jyOVC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235633; c=relaxed/simple;
	bh=xVnaM/+1aBYmJ4YaorBuWTpKG8CYCZzXpaGVH9DiuqA=;
	h=From:Mime-Version:Subject:Date:Content-Type:To:Cc:Message-Id; b=X3ZSMmwecgKjflG5WtUNVmL7CbPajIL2PMfaX7wZmA1dvaRUik77ibJSYUJDULXHmaQOqM3r3HVh5bZgxAcLTMmYYl1igLie8CXbdjRMA0ePnWMsk9LgUiVBoqaaIjfcvOSqwoFQkn8vBo3tnWulABQMcKKnWAA/roGFU+wNIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ALj5KvTN; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ALj5KvTN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235626; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=iQj5TnujvPDGBG8oYjt78Ys5Do8XcI+QaD2jG2aisX0=;
 b=ALj5KvTNr1sjr2+hfosteAP5Oq/rMhhEPrnDAohSVRG9zbkL4BTKP2x4MWQpBTQ4gP1PKT
 aou0cy/p2Ep7P6KTDtQ4pjpo1Al2cR7eUsABi3kK4IDBO1wnuvQ6do/UVexRBUQbEiAJfp
 +YWSbofaJ95tKYweVt3LbFvfvb4JuMgvZ/t2LqSMNIi6RSNTDkZ88yleClpd+r9ZT2JDmr
 4PK2KMy9ieeDEey3R2ilmE2JZVWJLuIVxYT/vSNqNPjXXRblSSgDHeZcrMgDAMz3j+iZw2
 f6dyAGahyQmaiT/Bsa0trW33f0FapTTVKMbPIIvyj58FxG7yoKF6mN5G8Q2USA==
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [v2 0/2] KVM: Validate irqchip index in routing entries
Date: Sun, 31 May 2026 21:53:24 +0800
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a1c3d68+ed588b+vger.kernel.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>
Message-Id: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>

Validate irqchip indexes for LoongArch and PowerPC irq routing entries
to reject out-of-range values before indexing the irqchip array.

v1->v2:
- Split the patch into two by architecture (Sean)
- Pick up Reviewed-by

Yanfei Xu (2):
  KVM: LoongArch: Validate irqchip index in irqfd routing
  KVM: PPC: Validate irqchip index in MPIC routing

 arch/loongarch/kvm/irqfd.c | 3 ++-
 arch/powerpc/kvm/mpic.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1
