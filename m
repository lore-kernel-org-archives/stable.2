Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F9311C27
	for <stable@vger.kernel.org>; Sun, 31 May 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235693; cv=none; b=dsOQXW3gfAF4tsD1jMqBJEakhTo8ZluhrJuo2WxqB+l5wS1UUoo3CmeMX+pj0qWqJlSBBQLZi7bR3cHTuT4hStSF78uWN5SSs5x9GLaw7eLuOgtNrlg+Fd4DX2dku4H7mRJvGdaNOp0yqzTqP3lKGznOo+ZO1+DCcy3O3GZ5ynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235693; c=relaxed/simple;
	bh=ccbnT88ISHYpaYfAE/Q3yndQLNoMXqSq1Xp0b6DuA7k=;
	h=From:Date:In-Reply-To:References:To:Cc:Subject:Message-Id:
	 Mime-Version:Content-Type; b=cKU4LJ7BdAcoD6RKXEPiPWhgiMWh3KR451PiL99p/qV1wTEmOoPXe/e/M2vNORe35WOKQ4qbW6VMRmpZU4Yjq1dP1qeW0awNl+HOtJS9kI4U0ZNqpIaYXZwlpqJ2wTgAm93PDp2WPdi0n+SeYFT50dJulj2E2D0K/auSu0/I71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SseuZs/8; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SseuZs/8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780235684; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bkGZPnmEBvhp+vL6ky855GObJBvNEfMqOsZeKPfrh+A=;
 b=SseuZs/8i9bgjoyS2ZTc3Okt7SaapqCGpeDK0B3zKSRzHckhnw4OMLb6/dpEabuX+lm2SO
 mbLzKQ6Eqlg18189wGNpl7B9R0jvEZpogz7TD+97g/AzjJHeNal4uPe2AR2herBADmqCRv
 QQ9Vb3he6KbCmCimo2QGj1KJM73p3D2tuOYGTlVXcinXpQjJYguhdunlXw91+joEE3Fad4
 NlhFHktjMKvsXTN+Gp046rGozolhsWSpmkRjfcjOZhExJjanjzYUSh7nbu7FEhnkGba1zG
 EC18JGB6Po8fQhiDWmeoUOjwsVh40e6za9pJtPbI1BlS1SzN9kr2IKrKPOn5Cg==
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Sun, 31 May 2026 21:53:25 +0800
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26a1c3da2+8117e5+vger.kernel.org+yanfei.xu@bytedance.com>
To: <harshpb@linux.ibm.com>, <zhaotianrui@loongson.cn>, 
	<maobibo@loongson.cn>, <chenhuacai@kernel.org>, <maddy@linux.ibm.com>, 
	<npiggin@gmail.com>, <sashiko-reviews@lists.linux.dev>, 
	<seanjc@google.com>, <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>, <stable@vger.kernel.org>, 
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>, 
	<caixiangfeng@bytedance.com>, <fangying.tommy@bytedance.com>, 
	<yanfei.xu@bytedance.com>, <isyanfei.xu@gmail.com>, 
	"Sashiko" <sashiko-bot@kernel.org>
Subject: [v2 1/2] KVM: LoongArch: Validate irqchip index in irqfd routing
Message-Id: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8

Sashiko reported that the irqchip index is not validated for LoongArch.
Add validation and reject out-of-range irqchip indexes to avoid indexing
past the routing table's chip array.

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/loongarch/kvm/irqfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index f4f953b22419..40ed1081c4b6 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->irqchip.irqchip = ue->u.irqchip.irqchip;
 		e->irqchip.pin = ue->u.irqchip.pin;
 
-		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
+		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
+		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
 			return -EINVAL;
 
 		return 0;
-- 
2.20.1
