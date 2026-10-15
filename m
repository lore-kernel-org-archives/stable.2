Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A2502790
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071445; cv=none; b=MUX+LAiCU4eLlvOJEinynKuGe/Fp8YRswlGGrHfOgBzgjav8xuu5JgzswvCmjCuCa12IIUy54ow9Ld3VsdoyYFNw442ROCg8CRlfVVloaZDBVK8LEx8Mf+dEHX98KpuMiGozUn3Nyausn3avaaiuS3c8cZb/obHq/jdMzT33wBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071445; c=relaxed/simple;
	bh=CSQSUkw67U8IfZbECBvgh790aNvSkZ+ZWc7fw2g+TiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t37mgbG8h3PlWvifOEyuuO2CSTd9jBcZzFtxASeSugS69pyvZKBUp64G+dvMkkr/uFykSYlLT+IEG/cdLjPR1ziZrVePfJnUGRbVii9vbBzkao0ChlOW09q0EdtKZ5Ie2u7K3ZLzuF8L32la4TiYA61FZRv2Z+yXrNBm81X02Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLeqmRsb; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLeqmRsb"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so14865250eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792071443; x=1792676243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMRUyKDIlmUyDqr3MGg93OZa2p3kWIknOepDwEvmiZY=;
        b=LLeqmRsb8HF2mo8+ywz3UHuv7XGv8d4uskE+M1KGZQAv0p3PGHx/hfTtow2Py9NRTU
         IpnZXaFyDsBg45gK0zw/Mzz7SnlhLyJj6wP0EDe3v2I8Iwg/m4lUSbS7D+P+Ml3kC4TM
         R+EcIoTrE7cMgxkDhd825OFV8cje42VnV2m6ZNamRTZH9B96IYPwyg5JzP4Hh7w7X1h6
         jkZ/o+pv0sjhUatSsnDkFz2TFQYWx7eKcmi3bRn0hKcsLb7UtKPxmiB2DlUgIoKe4zbx
         piF2XLohHN2T1WMK4Veg/va0Kzx2svCmrMiTtZht8pYhvRLRWcjfLTH/bYv0SwuyBqTk
         Gzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071443; x=1792676243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMRUyKDIlmUyDqr3MGg93OZa2p3kWIknOepDwEvmiZY=;
        b=i6I2TjiZ+kB0HXXLPRGWASk2u27/LCPztJJq9deMbkOXYYlkzJzsPrtCte8nDqoS9j
         1nOnmAoZrLznopeFmFyyTz3nBU9PUtAXdO34XP7e5w5hfdEXAYuly8qspb2hyYfEv4uR
         XxzeK5mthabhaLfcRgyRGRYyj9Ix9dsRJPG8kLbHl4g5j+6SLHwv2fM0JkSgWpubsZyN
         SsWclPBN6ksW/0v6yxtChZ5d1ON3WUHx21N8BhTxNCbCQi4GCAGPB89XZVaphfnQUIbZ
         lJaqZTNHjwAIDFNScB3REyAbJEWSNNXYOMOEkepylWQ7affCuJeRBL1JUrAX6XCkBXTp
         Ivsg==
X-Forwarded-Encrypted: i=1; AKwUvBzlMqXDDZXEZGsTKUPg90814h/qu5ELl+ATBUz8+1UnUFZ4mtfQZJCjXxlrgiG5oheTujkx50k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIumDK6AB4+xUwDpLNOtIKA/PSHFCg3TJU0WCJ0eFhEim0J9hea
	ShkWN6rFgn0xR0k+ihY5oAFbG86EiuQK24jUvdIdATM04VMtluFq//pBfvutlbgifGL54w==
X-Received: from dleb18-n1.prod.google.com ([2002:a05:701b:4252:10b0:161:fc1c:61e2])
 (user=rnv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:260e:b0:159:aa67:28c1
 with SMTP id a92af1059eb24-16a5eb53f9emr28763528c88.20.1792071442858; Thu, 15
 Oct 2026 06:37:22 -0700 (PDT)
Date: Thu, 15 Oct 2026 06:37:22 -0700
In-Reply-To: <atCKXeWnVAWvhSn0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <atCKXeWnVAWvhSn0@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015133722.2351642-1-rnv@google.com>
Subject: Re: [PATCH] mm/execmem: only free ROX cache vm_struct when fully unused
From: Arnav Kansal <rnv@google.com>
To: rppt@kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, rnv@google.com, rohakum@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 15, 2026 at 11:10:05AM +0300, Mike Rapoport wrote:
> On Wed, Oct 14, 2026 at 04:30:58PM -0700, Arnav Kansal wrote:
> > execmem_cache_clean() currently uses:
> > 
> >     IS_ALIGNED(size, PMD_SIZE) && IS_ALIGNED(mas.index, PMD_SIZE)
> 
> This is not the case anymore:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/mm/execmem.c?id=569db54d8b7a4ec463a62c444de0d6f5f10e9dc1

Thanks for the pointer, Mike! We had checked Linus's tree (v7.3-rc6) and
missed that your series ("mm/execmem: fixes and cleanups for the ROX
cache") was already queued in akpm/mm.git.

Commit 52d95a55a011 ("mm/execmem: free ROX cache chunks only when they
span an entire vm area") and 569db54d8b7a completely cover this, so
please drop our patch.

As a data point, we hit the exact multi-PMD premature vfree() from
52d95a55a011 in production (on 6.18.y) when a large module (> 6 MiB of
.text) failed initialization and unloaded after a smaller module
(kvm.ko) had been allocated out of the tail of the same 8 MiB vm_struct,
so having 52d95a55a011 tagged for stable is much appreciated.

Thanks,
Arnav
