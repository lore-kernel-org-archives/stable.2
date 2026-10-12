Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4231B80D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823586; cv=pass; b=jiWH/Y04NwpNFI549cU8+OGfHHgVwCgTbqqwDjyLziKoeCsDCdJBZNEtsEIvwk+hXAFPJnk+gfEPzKK9wlanQBgdK+FoX2c5/SCoYscWuEG6flTacKa7H+7BFetBdMnNKvVAvASNPrlXyUciiBGloMbiiDkYVK3fsalrt5WUyPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823586; c=relaxed/simple;
	bh=oAXS6V6MF2Ql5LJpFSKH366GGwqI3OJmzAt9fON9zVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmn0ePqDE/xXBJprktujLQYTxS881zHEnnAkT2j9IoiZUmDUKZvdt4VqzEbB55wjk/IGKvKxVB70J1g2F86NTEK9rVlSMJJnFD6bK2OSoYvzSp9XnfsASD/JAI5ZyOQW2FWpkaGARjgfryP26WsurSvbMcmxWMHsJoCqTKREjmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOzbwcka; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/PqYrSG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOzbwcka";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/PqYrSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791823583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
	b=MOzbwckaxjZIf6hsWkHxqW/FVuIGqvo+0fDZ+d74oRVFnEruq6EAOv1dRy1PM3DUaaHDg5
	Kv62uW1dfT7Ffv4d6S74r8RreneUUJ8U0+8S7LsG1HrXot3pdq5DEId+vDT/fIZw/DXQHa
	BsGRNxt1u4aXNlEggy/hfYexYCpCJS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-JHWS_zWCPaS6z1V_aRgNIg-1; Mon, 12 Oct 2026 16:46:10 +0000
X-MC-Unique: JHWS_zWCPaS6z1V_aRgNIg-1
X-Mimecast-MFC-AGG-ID: JHWS_zWCPaS6z1V_aRgNIg_1791823569
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c437ae7dbso1048184f8f.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791823569; cv=none;
        d=google.com; s=arc-20260327;
        b=jVTWUgd2Hca+khNnhigCqudL0a6CIFgGriGuUz6mqKZVO/OBqo3ovtAs1W6u/0J8pw
         Wz+GeKOqcn6NKlguLbHcm5f2p7vxT6Nopxa0SD9dRIbbS1FvDPwEyMUFZ7FihPfJTo4k
         Mhazn3bqc7KJMJr56bejczAzoyJK5Z+jZywLeICO0Dw/QPDtloOxmQ6GEM9Udwdi0Lf0
         l81Yixooy/zEq/ikheQyN4R4KQXpM9+O2bonqA8UQ18QZXwcxWp2Qb2OThgLFzPui8SH
         +p8oo9oyEFAvCviOketEsC8gvR7OHNwW3FlXWAD4fYlaA8HjbmPCtwRwROqwyI2KVgi5
         yRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        fh=j/5VGJ8bN/gGm3IHyKIfQIGmBPdeBLfkytytGZafP0s=;
        b=hlgyZ8WaUkcmz3p1Pr60gkuwqy0bLpFBfGkWy/z53/QUBa1OclXSHjM1+oeBJfYlx1
         wFqYuCmAGhzCQ79KW4kchGZUzO4nFOeGPK65XYnusXNcsTCGJUAHlN6BEJyrG1EGq0jY
         wPtCFU7SfFFHeyP7tNUyMP6J2fdFh4khlWFzoiEBwOYZH/um3+AhofXP4UDOLiFXr+qb
         WTr3UKiJdE3HHq0eEyaCyDzU8XsjzDb1sGPI6SZ7iIPDZjJzZQS5sfcDi/LFya6cAdg+
         TJs4CCF3lseESdH8usMND3RFWhGF6hUbANd8MIsfxnrc1nQKyBu3Rghr2NPBUemKuyBc
         X7XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791823569; x=1792428369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        b=K/PqYrSGbMLD4cr1p0bUSPaSdk7BqoFT5E3pl3Ei0hTq6/+4nfXSipnYzci6Ljf3lJ
         wux3gvg3esVbl9moYAXYFreLHE2PYZym/zbfdQw2t5YsNklXajbvaDXXvi5ZutJjl3/Z
         qH+LXmlwHzZT4rEcpAH9Vj3y5UuhbaZt2JmnqLhuZxF84mR03GLCl7DNIqhvLHBzLL7B
         ejuVVm3VU/NAQyqotGDNOHivD1eceOa9cpD6AVNJTAEGjK2e/VV5285GPNvTnf/gBbCC
         3fFoUbpHR4af6YZqC5t9NQtOvvh/aLeEgOEQ8kRm+kiSb8WbvXvakkepecMzSCgZOtHt
         vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823569; x=1792428369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        b=ZMB9JveLmolLRTydS6yM7ZYWhqZVXRSSRFccghz6lnmeV6qigIxPKpMNO3t5sYH8XL
         w57AVr8ftpbtFOdiuvi+EyaVSgVe2ghBpm/P9RBmuj/HWy6AOL4V8EsXIDqU8ljQzT14
         GfzoJ4EFDG38EW33mJRvW2l+3KcwZdi1jD8pP/5OasP14LBNh6ctDERXk3+NkRbHEjyc
         nouMghQAJQma2Emo95qCUDJTX51x9n84eqAwFL9vL4m855fh3+wtWS/tjEZ6NKy2JI4J
         bFJBPCXwMShyU+m8l0ULzs633IapmWuwo1EdYkYmI63Swj49nRewZinqQfB1rMUeaRFz
         FTNg==
X-Forwarded-Encrypted: i=1; AKwUvBxRYKQLJieNyk4CaMmjaFUjz0ZqWgaQM7FkYLA+2DlUQ9qZYb3je7CEtkkCT/Yq+C0NUhB9TKo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0h2IK+B7xVfwb9LchfTjqPaPERyvSn49tXJaICYqIXtn8cy5Z
	zbFiyqOQ5hjy+LaoNVnYeqnB95aq+OAac0DIC8tpwHzB1YQ0NUXgC6qcAX0uJrt/Yeu0Kq1nm6i
	IvGClMgzGBvc6LOF9xn7/Y30+vKeC23o/4FSnBMqcRpIBot3FpeP58IZ+ljfvjfFvDIobwaIbxW
	YSWiwCRj8nJOu1JhpOO0z1rNJwe5ePFQRF
X-Gm-Gg: AYBFou3zoC/Uv8yoTt+QG5q1b/J+8Kcp3+4tjzW6Ery3fOXUYgQaOUbVF6cl2eoFtVI
	x8+gd8flNsL4cYQKNFpAtmBO1jNLD8iqoMOFbfsWhKOjM6dqHtquNSJL2vCWLEw6T+Km7scNvj3
	0lBWe1AbMvdabs/714W1uUqnP8GZo+vmeUeHHOHxqIgc2zJq0r7u0X9//laKrQQkAzZVDuG+I+Z
	MIE2mkGcdXJdjjktxKHz97byv3X+AnusAZlfrpyN19YuUkwwcAUFQBxdQmSzw==
X-Received: by 2002:a05:6000:61c:b0:48c:58b9:f17c with SMTP id ffacd0b85a97d-48db947461fmr19542071f8f.12.1791823569151;
        Mon, 12 Oct 2026 09:46:09 -0700 (PDT)
X-Received: by 2002:a05:6000:61c:b0:48c:58b9:f17c with SMTP id
 ffacd0b85a97d-48db947461fmr19542035f8f.12.1791823568768; Mon, 12 Oct 2026
 09:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com> <as0NBfuEY-60pgtz@google.com>
In-Reply-To: <as0NBfuEY-60pgtz@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Oct 2026 18:45:55 +0200
X-Gm-Features: AclHuK9pVodaU0y8aFoEzn0G64V6E6NcOQh1xijrAviXyHmZnBb8SlkbTzGCjn8
Message-ID: <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:38=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> > When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> > in nested page fault error codes produced for shadowed NPT.  The AMD
> > manual is unclear about when SS is set, including whether it can be set
> > when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> > of the VMCB; in fact, bisection shows that while SHSTK was available
> > to guests since Linux 6.18, this started happening with commit
> > 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrelat=
ed.
>
> It's not unrelated.  As you note below, this is purely because Hyper-V on=
ly uses
> CET when GMET is available.

Indeed, my intended meaning is that bit 1 of MISC_CTL does *not* have
the side effect of reporting SS failures...

> This is wrong, I reproduced this with the KUT CET test with gmet=3D1.

... howver, this makes me wonder if you meant gmet=3D0? Because if you
need gmet=3D1, the Fixes would be fe080f58dec24049 (i.e. when the gmet
module parameter was added).

Paolo

