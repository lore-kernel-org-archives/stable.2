Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D90EACD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912236; cv=none; b=I9idlg0QiV9eEiTY5+DX0oOk2Hs/qOKL0U/J/1nr4dfftb2TucCHM+2uoJIuh94Dxysj2AViH+E4ZYUDXZbQtr/nw4+TTGp8QW3rUXL8ewb3yLE1y1ELilbaF8vUEafGRjMsQW3RTAncX4P1D/20T45qgf4VspJamA0EVUaQdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912236; c=relaxed/simple;
	bh=CwPTlr76puzr5ZS0xZM6k38sY+FZTelUS8ByfQVPVC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmpgkjqvo+A/0LUJi3/0s4CTKc41z2Np9GfFSHCnKBHciPwcojcYOgp3mWMfKhMUOUC4og39J3eQwFpyVidsHv7bMRN8BW6mZL4R8N5A+t9yTbwmSbEJ4gqIAuNUkYvq4c6HYoUf0qtUsldP6BhsqmON1vohDB09dD7aBiSrmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7dASMif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7dASMif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788912233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cLrURbixXtlb2wRM1cT/S3Lx6AO9OF0zqWiE6UKxos=;
	b=C7dASMifL4kKE1iaSTzGO18mrtViLYZCJclaJrOOKqxu1kZlwj9JriFVBuKPXXNlcSSkxw
	fXWpgHUmycdOrWDEs3sKBqnfZFS+tTz5aVOIUczkTDp3qEWlgMYAyKil+qfbql5AoFXNsZ
	IYd9GNMfYGqWJwsnWuz6mQEbjf43U/s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-Yldw-_4gMreCKkUxrKSRrg-1; Tue,
 08 Sep 2026 20:03:49 -0400
X-MC-Unique: Yldw-_4gMreCKkUxrKSRrg-1
X-Mimecast-MFC-AGG-ID: Yldw-_4gMreCKkUxrKSRrg_1788912228
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9B1B1955F1D;
	Wed,  9 Sep 2026 00:03:47 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 03CAB1800347;
	Wed,  9 Sep 2026 00:03:43 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Sep 2026 02:03:47 +0200 (CEST)
Date: Wed, 9 Sep 2026 02:03:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqCiXo-h1F5jsp_N@redhat.com>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_gOSWtPNjwWS1e@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/08, Frederic Weisbecker wrote:
>
> Old leader                           Exec'ing New leader     CPU 2
> -----                                -----                   -----
>
> WRITE q->next = q
> WRITE q->prev = q

Damn ;) I am shy to suggest this again, but if we have _any_
concerns about the races with list_del_init()...

The lockless flush_sigqueue_list() doesn't need to it, right?
So perhaps something like below (on top of this series) to avoid
the (potential) race explicitly?

Most probably this change is wrong. And in any case we can do better.
Just to explain what I mean.

In short, I mean that exit_signals() -> flush path can do
__sigqueue_free(q) without list_del_init(&q->list).

Yes! I agree in advance that if this change can fix something,
then it fixes the symptom.

But at the same time, why does flush_sigqueue_list(head) need
list_del_init() before __sigqueue_free() ? AFAICS only to make
list_empty(head) == true. This looks confusing to me.

Oh, I am sure I missed something again ;)

Oleg.
---

diff --git a/kernel/signal.c b/kernel/signal.c
index f93d8f77ec1a..32c344ee4769 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -457,14 +457,19 @@ static void __sigqueue_free(struct sigqueue *q)
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
-static void flush_sigqueue_list(struct list_head *head)
+static void __flush_sigqueue_list(struct list_head *head)
 {
 	struct sigqueue *q, *tmp;
 
-	list_for_each_entry_safe(q, tmp, head, list) {
-		list_del_init(&q->list);
+	list_for_each_entry_safe(q, tmp, head, list)
 		__sigqueue_free(q);
-	}
+}
+
+static void flush_sigqueue_list(struct list_head *head)
+{
+	LIST_HEAD(flush);
+	list_splice_init(head, &flush);
+	__flush_sigqueue_list(&flush);
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -3196,7 +3201,7 @@ void exit_signals(struct task_struct *tsk)
 
 	cgroup_threadgroup_change_end(tsk);
 
-	flush_sigqueue_list(&sigq_list);
+	__flush_sigqueue_list(&sigq_list);
 
 	/*
 	 * If group stop has completed, deliver the notification.  This

