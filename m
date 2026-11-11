Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412493;
	b=vPWixUEP1xpHmQJ7VMJU5KV0kZ8XQJ7Iljsz5D/ym8k8LJJyfKzG51PmK7nZZkQSD9Pn
	 WdcikTLNI2BqQVHAr7t5/K0WvkftBaZ86+kg2Dex8Sv/+Z5zMFxhY2rEXsg/hABniyc8G
	 ZXGs+tDzuizelhJZaqM1AS6ILxnsRhEoQsChKJ4v28z97ngZ5RbkiuUk2FUVQgM2E0WjP
	 gSuJFotKywuLq6bdxblS0Sx0GxE+B13W4yG0k8qrF+9Q1llMwBkWZGdUNoemj0qs01mku
	 A3B4CgLtWACNYI2aXOohjd/ugEHHDiToJ6CI5xj863k5pHX+Oz8XT5atEQFlISPG3Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=PyTjjEcLLW8FFyjOmYevivG+BkNgjhrEu3VKQJTACv0=;
	b=e2LvPSDd0cll4xuy0+NphMQI9n70og2mp32q3Z0bQC3a2bdCZ9dNoXH8Y4JI6UVZDM11
	 cM0ZQmmoDGOU6khq2JaZF31XHjmSw7W0IfhtQAMA+WQH/atKG2L7t8aBcxXY0848yTtFI
	 UZyk0v6H3n6rgqEgnh3qwqyUN3iicu5va13U1XWzP32hAkS8RQThZ6AO9SX2EXQ9Vajju
	 1SLTsTeLkyn5W2gDr2z50XXfE8ZVNKvOkrTltsS2OyMpQqHbevHwZ7qYIsVO1ihjB9jXB
	 V7tTMSTlAe/fdtT2ZQb/OVXXWf0eozkSk/pifTgk/4NueYthZkcbkrbwzAyZsnhlNxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P4QsZQAz;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAE606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36EAE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P4QsZQAz
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e954d87b48so50516545ad.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794412492; x=1795017292; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PyTjjEcLLW8FFyjOmYevivG+BkNgjhrEu3VKQJTACv0=;
        b=P4QsZQAzHlWuseOmgesBRE1qPshHHv8DoFojuRduEBLbuftkJNNeVVi8BOE9TzTAWz
         /NpHzb3F6wSAvxseBhy+K4cbxVs0zLm362CRSSQ4fRvj8nX4gFl39nAJouk7o2n6Ebf1
         M7wQ8yKVs1HwEJe7GY3MkxhvIFhkl72NJpCKFLu1ddiisN8Ai2aunsdiv6R1JHTogAaE
         +nvQlP9XzYB0k4//cydShvvdhGD/RFv6mBuK2bwlC/kWvXJh5u1lkcy6iYAQBoNQIkKd
         AlGFP7Ua7RPbD1752U5bUB5ZjDxrwokUbqOWVl2shH8rwJJsGSKiQaIJAqiuTixlcGxk
         Ohbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412492; x=1795017292;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyTjjEcLLW8FFyjOmYevivG+BkNgjhrEu3VKQJTACv0=;
        b=mYBCW8MpecNWYPzF+Bu+NPzFA5ZmhzM7HAbUB478UsapQlcAE5WyTc9gW8r9f++C92
         Y3lXluFrFdYCRnwnzIpgqq3DcyrK38PyCN9EtiSCuHvyqd1qcPeGib+zhC43z3qtar2F
         7GxTZzG2tlsNAH5KShBJ+2YaHlWyFo6qAGc+3cukxQDpStpQhISyWw+SmI+WZ7XnDJYY
         7paI7pVqTqjaWc4F6QQwyeyrQJ8bdqTK6NG+wKH7PWSGFGoD/QmQBoE7lXxtNdQD56pb
         cOD7LOEgZhDbW8Hod1ojYM9owS2emaR4NZ3Cc56o+1ZxguhOMhQWP9mgfujnYwcOBOZq
         T7Tg==
X-Forwarded-Encrypted: i=1; AL+hErEAqrJ7zrYwxw3m7plC33ls+3cMeXmEwCCysdPrbVhYJUofXrsNjbPU4tVC+xZE3Tl704V/xjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KZVwz187Bc/5ZAUkV9pMJQ0KqQrhYCi0Z864iu9S+qCpX328w
	ok6WE6rUU+WeefJXbSDXykbVreQyyoB1ft6X6B+No27/aYYWZFtwzHSvDEPZJ5I8WMCkoEeC6u9
	h2QOwKg==
X-Received: from plgp10.prod.google.com ([2002:a17:902:ebca:b0:2eb:3478:6e2f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e948:b0:2ed:acb:aa96
 with SMTP id d9443c01a7336-2edd7740135mr31261685ad.24.1794412492286; Wed, 11
 Nov 2026 07:54:52 -0800 (PST)
Date: Wed, 11 Nov 2026 07:54:51 -0800
In-Reply-To: <0c53480c-770f-4568-b44f-cf13961d6f5f@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107051725-failed-6.12-326fa2c9b4d3@kernel.org>
 <20261110151928.2074971-1-sashal@kernel.org> <0c53480c-770f-4568-b44f-cf13961d6f5f@intel.com>
Message-ID: <avSPyySNu0tMia6H@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Xiaoyao Li wrote:
> On 11/10/2026 11:19 PM, Sasha Levin wrote:
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > [ Upstream commit 326fa2c9b4d3e6cab58c139eb55aaabd7179192e ]
> > 
> > Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
> > helper so that TDX can use it for Bus Lock VM exit handling as well.
> > Rename it to add vt_ prefix to reflect that it is a helper for both VMX
> > and TDX.
> 
> TDX support was merged since 6.16. I think we don't need to backport this patch
> before 6.16 since there are no TDX code to share anything and no vt_*()
> functions at all.

Agreed.
