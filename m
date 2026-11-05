Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897178;
	b=w2FQ++34Jvln/8UjcIVFoMxe5RZSfdOFU7xqJujggh8Qau7U8xPz30zksiPK0u4Vxjq9
	 1+ZMhzaYB1zr8ZGG/G0+mZ9yEEKPRcJ/T7wb5v4StNCWrg2yOveoU5gmO8eqHIndDo6zT
	 6GDCHwiCpWdGJuC2OQwa5S2Vj280+jR9pd1DwgZ9Gbyw2e6S4mRUwBOO0k8v4zEIwPtwM
	 cQT5o6x7MU3UWcVbysl0Y+O+/P9QdOza1aPn1Wj9eOCnrpzRH7OMcUvPmdA3YBvA31COL
	 Px53NtRZvOLsJeSImC3ZTnicf4UVwaOmJlCWysv4ynJSEAWlzw/BLcxbfcnoHO341NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897178;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=qOBd/AF0trxY0YAt5Jt3B+F2pkdd0RcR8oCX6VitlYo=;
	b=Xv7sN/4kzxJXcnzZm9j4y71T9A1nVS2YznllV0l6BwWNULtJWiwWiLeNd9hkSQba2ga+
	 ZKCwbO6R6C/Knd0syFBlJDqUWp4a84VkqipJqRvl2baAvyUIg3NGzxE8p+GK9jLMNHp7V
	 IvtSL/wvFqpyIGST66ZU5cscI3ZUINvCvW28iLbWh2saiJfc8Du6gFXAVnzMV88n3Ee2o
	 jZ20AZZUe6q8u+B7dj5PMJ/F7+U3Jm4OhKKuoRUvLQlSlwIIBZ/umn4cSrgPN+Qrb2Ml1
	 /GQ79J9EJlux9sFNQZurpHjr1AzBREWZ8QnbnPLycZIz59XyeKZn9u+iCsCYAfMz60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma6tXKnD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D5606D804
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773D5606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma6tXKnD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOBd/AF0trxY0YAt5Jt3B+F2pkdd0RcR8oCX6VitlYo=;
	b=Ma6tXKnD64fPgPj8+0W0AgBhSkAex9aHpWqQXnhy306okg+2g3LKNeCQiJmPYHAUY3AmL5
	JNnLzlag8k12Q3/9k1QNHZj7O+FDJmo5ajpHurp8ykEvIcbVR/njUlPUA/0jG1NttQqMUB
	R3ZKqcSGsZ1AJ1g5t1YhT9nZhme2hYc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-P__bO09AMJu_dDHqsFadHA-1; Thu,
 05 Nov 2026 11:45:57 -0500
X-MC-Unique: P__bO09AMJu_dDHqsFadHA-1
X-Mimecast-MFC-AGG-ID: P__bO09AMJu_dDHqsFadHA_1793897138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D792D1955E7A;
	Thu,  5 Nov 2026 16:45:37 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D51C01956088;
	Thu,  5 Nov 2026 16:45:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] x86: KVM: take b->lock around wait
Date: Thu,  5 Nov 2026 17:45:27 +0100
Message-ID: <20261105164531.313849-2-pbonzini@redhat.com>
In-Reply-To: <20261105164531.313849-1-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a vCPU thread is migrated between an async page fault vmexit and the
call to kvm_async_pf_wait_schedule(), the wait will occur on a different
CPU than the page ready notification.  When this happens,
kvm_async_pf_wait_schedule() can exit and free the on-stack node
before swake_up_one() finishes.  Avoid this by protecting the
accesses to &n.link with the bucket spinlock.

Note that in principle this could use a single critical section that
also covers kvm_async_pf_queue_task(), but that call is going to be
moved out of kvm_async_pf_wait_schedule().

Cc: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9f0efbe94793..6c0a794ed89a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -152,6 +152,8 @@ static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
  */
 void kvm_async_pf_task_wait_schedule(u32 token)
 {
+	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
+	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
 	struct kvm_task_sleep_node n;
 	DECLARE_SWAITQUEUE(wait);
 
@@ -160,16 +162,20 @@ void kvm_async_pf_task_wait_schedule(u32 token)
 	if (!kvm_async_pf_queue_task(token, &n))
 		return;
 
+	raw_spin_lock(&b->lock);
 	for (;;) {
 		prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
+		raw_spin_unlock(&b->lock);
 		local_irq_enable();
 		schedule();
 		local_irq_disable();
+		raw_spin_lock(&b->lock);
 	}
 	finish_swait(&n.wq, &wait);
+	raw_spin_unlock(&b->lock);
 }
 EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_task_wait_schedule);
 
-- 
2.56.0


