Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7B2857EA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052328; cv=pass; b=aoPFVeOzEwNF/6iFVcAUBxGaBHzXV4PERmJ08Urw6l7TOrJ1WwJVfXEGp1go3ANPcCPQf/gskSeDaQqa3Uq0gr8kDgKxO9e2OsEdyQWfJji/ZOubX565U+zQHW8OoOatoQUoL75wMS+7b8HhpJngIq7nllKWjnKoeslKmzK1wKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052328; c=relaxed/simple;
	bh=bMqv6qMH/Xe06iopa2RDT3Ru0gHSO0znvKQJMuoe1f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH+dLeLhvFfPuV+S2JH2HXa+Fh+qjHsTePF3Y+rSMuTY9nlnl11VxEQQRw6d9lQwywDAepSaE4Poffad2XdIciSEa2l9y/Ifw9Fp4on0snGstLltpPDl0hthq4OJ1uGvjgpX8Zh2lvyTdNPBc4DV1S//KZfsSK/2PaaG6VBAyfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUbu452M; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUbu452M"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacef7d299so171535ad.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784052326; cv=none;
        d=google.com; s=arc-20260327;
        b=FX23Dp21/yyEkBAPqiygKYsFZCX+Rdox2++NxFSLwqk/2y8XAiqBFXbVFZI73ayLAt
         uLvqCVzJ87sRpYTjK1YbxF967ur9+A6Gj+tiLchYp2CXY923O+cbRLlNg5gOxPs/Ic43
         InfKalFQkcw3nBqrNNbb5z8OsybDRl1JIn2wH77WzYMb/l0Px+sodRPpb1ckRp/2Re27
         eWiaYL7UiJLfxoSOj6SkG1N0BXi1+7Qs+GkuQ7mFFonMBJeoNy7/zTboys85N7gB3aEu
         yjXMR63krrIGKo3ED2og85dEk2UgwBnuGWcVjI7VZSELlyaryFDM5CJ4yD2gsR4P6geS
         AWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        fh=eDgeoMvwz1noHi/uhsdRqni6YhVxp/n0QyJk41lVv6k=;
        b=Kqycn/9X+PVnJ6t1YzDJ5iBP+tAmyiprn9qcsPrHT9DT0mFnBihjW4S0VcqYu9yG43
         BzRkoSND2BVGSWg1anoZH3TB1SJfNsmi6TCGw1Zi4OOYupJWOGO3ZXYBaSaLZASdlk6M
         rFKnaJNHCEdmW8libr2s0kxC+aizg+ybyYZwWnI17vk2UOvFcFmdrdqgyVuRpuigqudY
         v0L13A/Je6xUV7DmE4xogd79bdq7bd8frmcyi9Zqd/UOD7+BgeNsWFed65M37Lp7LIy1
         1yDCRmivOuAYRlq80QeG4mLleBKxIjSPNTO0HXDsq4Rh9QXUmIfIgHiSl0bzIh2PiYzt
         3BhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784052326; x=1784657126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        b=QUbu452M0M4OjHnxQMqx+uY4VtufMrwPags+EVJdkv1Zpd24hLInXvjqBnJ5lMGB0F
         OLEx8KxsNgQ8A+2ZDwuDODv3wdoQHT6OmnrcqmuXzEN12q4iT8ofjZ/w96UDA+rXEHC6
         8xK48AdU1iTs4zIoqWYIvd1UuZpm7y2+B25/srPxB9+lZdSp+x6iDq8d77+8ofdL973x
         oBgWO1FrZ4F7mAoR4Y+lvZtVuiE2o/mbtuSx9Q1TeKkAD0aaDWZrBIoVchZB0+YXrnMS
         FbdqIvLiT7Ie2mrYvDESTXqfMFBMPWGQZhdoh/C9PVuLxRSfbIMLu2BPZjhjNIsunVyz
         ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052326; x=1784657126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        b=PqXYIuoxiXKoU6Wfdi92ejkCPNOV7zzvbMECXPiKdYu5N1XeTUXUqMbUq4SrMG2h0S
         avijWZ1YiX8jo866GbdC9EE6naRnfjRyRKYFiOmxgucYPIsi4Rah9eXKcHVse8Z7zXF9
         D8Mt5tUdCyMZxhk+5YMCTs5X9gRA/QX+F3060G0jSZ5BUSSwTYAFqLU6UvyDi2hTO6F/
         neICUrpqtjeH8DDjroHveEP8ztNROsRPUISnjjIf6AeE2GGKL630JoL0Mnbimu45CPse
         1yya16JsV5YFmxGJsmvoG49ZDSe7dA48kYrJwF8Sug+pMovV4wugZLDQ1HEbDWu6CnIm
         D5eA==
X-Forwarded-Encrypted: i=1; AHgh+RoboFuv1qZxizb9JtZ5QJrvyWIHXD2Sd3UHHSx9sJxlHFE8HEObcCM5W9PZa/exdGwtLcicGR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6Qof70jow0YpnOUtnj1zhnM663zsPL6dGWPqfpXNs1j6lERx
	Zkbslto59p0mrghzdPu8mTCw2H+B2V6MqZNLmlz5xhuRSHe2e1YZetnFsauQ3g2yiLHrUdB3w7b
	zD1A4pKFcgDT8cdLmnEdN9rGWyt86zsGc4QnTD6Go
X-Gm-Gg: AfdE7cnrlNoGLZxKuLU4x0wy91EmS1DWAe1+fmtKIq7u6ldPzqmbQocse5/jovJZg1e
	6QobMxyNA/zTgD0diMVl7WpJU28Ihuah5UOY3Vu4El7Lnjnpvrht271gHqmi5ZveTtdTWhzttKN
	ElVKRk2FvsnCMVZqYVNeQ0IGlMagZdmwyOYoRDdhWLCUi6kbDcTkVBbgCRYo53MUhcWq0u1p5HG
	zu+BhYot7SJlZsd5se0t5soa3Bhkj31XxA9vw8DHoiURad/P8z//c5upidyfMxE95LtlU2F2TOQ
	K0KMMmDtPKUXE+TtBirJMTuNVw==
X-Received: by 2002:a17:902:c40a:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2cee166107dmr5050295ad.6.1784052325956; Tue, 14 Jul 2026
 11:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260714092146-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Tue, 14 Jul 2026 11:05:13 -0700
X-Gm-Features: AUfX_mx5k9DBPXvby8jHd85RScNqoUx2Mk5ySUSPxdCd7MSrVwbUj5pXe7nTaQQ
Message-ID: <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 13, 2026 at 6:17 AM David Hildenbrand wrote:
> I assume that workqueue is not frozen yet because ... it's not freezable :)
> So could we queue to system_freezable_wq instead, or define our own freezable
> workqueue there? Then a driver doesn't have to worry about that.

Exactly. As noted in the RFC, the root cause is indeed that system_wq
lacks the WQ_FREEZABLE flag, leaving it active during suspend.

Switching the worker over to system_freezable_wq is a brilliant idea.
It's a much cleaner abstraction that solves the problem at the core,
saving individual drivers from having to micromanage this lifecycle
and handle failure unwinding during freeze/restore.

On Mon, Jul 13, 2026 at 6:26 AM Michael S. Tsirkin wrote:
> +1.  Just system_freezable_wq will do the trick.

Thanks, David and Michael. I will drop the virtio-balloon specific
unregister logic and adopt this approach.

Per the earlier feedback to keep these fixes independent, I'll format
v2 as a 3-part patch series:
  [PATCH v2 1/3] mm/page_reporting: use system_freezable_wq
  [PATCH v2 2/3] virtio_balloon: fix shrinker UAF during PM freeze
  [PATCH v2 3/3] virtio_balloon: fix OOM notifier UAF during PM freeze

I'll send that out shortly.

Thanks,
Link
