Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027214963B2
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642354; cv=none; b=n7Bt7laCmWWgJZMTdlCtncRaFm0I+z6z2rW9l3IX6UQOcO7cG3ITy3VDXeilouHbSvVn4GkZ7Uk/FBOFBFYl1BAR7Vvy4FxPtvbT5eUeZ+DwA3rWxuGSMpw/5OFGHPig+UnEQKpCoZsOsdsZS4MvuflNRnbB2kmUqKpJqXhhcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642354; c=relaxed/simple;
	bh=BqrIIerMCSzPlCiKASkxxbCEjoy29np5YGXs3jbWfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4dyWUmQkBerRnMLmZ/X+GDpogceaBd//b3TN68EjQon23JauFCf5DBaSRAAy23ijjWnzh1QhKBrarou/hglaHhyee2jdM+2PAgkUiA88fiiVNv8JwlCENhYN1ygHkUQ2k0pZouVxMWQuM6Qv7PT9y5rGLGwrYYFih7cdEwD4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW4V3Bhx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW4V3Bhx"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so960654a12.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642351; x=1792247151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7sU+GyiWKytsNfxYTotZ4BHP/F79d3LoL+yzE1mHYA=;
        b=SW4V3Bhxne+rf842isLI2jTeasmivGMwL4cGYxuuy3J5OsaQcR0LTefQeGpIZo+7LO
         DvNjxcjy509FqMYY2ja6lQB3u3SplmSpMR+gT7tPTCyEcrOYoxnD9HV87TuxYEkcwH7g
         OH1RXdy++DzlU/YS2DLsMulPzNflsi5ni2dtxedlhFXS0+9JUaBLzobbDmFCbnQ8UPwf
         Z6LgZ7+BAQX6Er4Ga/GS1zGtibWghgDriAiaxwvZvk1znJbFF/ZWuv3JgJlGT6lWZAvg
         IxORt3JJoYNVIlko+hCmwKM/SRpBhzpHpNXM9r6zPhLGdl1Ffupfs0iHkF8mOR6a50/h
         Tn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642351; x=1792247151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7sU+GyiWKytsNfxYTotZ4BHP/F79d3LoL+yzE1mHYA=;
        b=xcX02zCN1Q1wySzfMUheolpaC+mXUnB7kvbpLfGQCCj4VmSmT+YDSYkTZAna+j+FZg
         5gkhtYPrn79RfxuldW/kFnxXagjmGKGMB9CaEYU6qmpb+O0hMBXPbve3IhOQEA4cYaAO
         lQ+nQ7wBlrs942F7h17pfdmjF9XgRrJ4ngZUFTbfHxPOrEB8f1Ha0QpUC11hDWMrGNve
         l1yIhC3QmhR8/tsmUAf49G5VFs0WbU4r2fkrqK7u9NWWbovHHqpd1ba6BVJoO/rSraZW
         sU/MCv+HSyqKh6OktFkFuuorDrwzNkLjyzHsuAXjA12nQg0ESb8fwr9s2nRHN7XReeO1
         Yzig==
X-Forwarded-Encrypted: i=1; AKwUvBz4mBCOpzacu+AMihi2kWC+SLrYLC+1JcYm3BUj3M+UYc/h5JzCSSjYNbo3ZjUMYotwU4IXdC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4XnTEh1Oa+3c41Qrkgp3/x4+qFX4CV1EydW+SZDRdnp91ExK7
	j6gDNEKXNGP0FtLv5k/f+IMaKyGJXd8HkA+wJJRbOkb5rh8cMEff9u2nSsfBRNCE
X-Gm-Gg: AYBFou2DaTskp2m5XaW6E9zzm6LmRfWkd0+/RpMH0FuGaaoaKIZe7Iex5klyMv8aK71
	qbuSGjA398EexYtztXS9t2VoNaPhqZ/uiXNd2wnru8Zjep48x6ZvPys6Y5DwksVm7RURtnjptVJ
	cZ9O68nPqA1La0rd3ju6N2tPrfXg1QoKLWqbe90RlAGqTs2Ue9BGCcENxoLgUvVICnsxh5uSFW8
	LkS7QmHKSX+rzxgtJ0wl8oa21tDu1POY0kvUy8/G3EFahE0g3wrnHwy6JxvxzCZ43nvXBvEO7Q7
	WMC3u/p8eOdHy9gekLgQNBy+Ti4UxrR5n91tnEHKsPJd508ScnfaiVuIAwwep+YsZ7LM7yZDkdd
	Dia+GK2OMryT1+xL5IJnM6PK426LDGAJ5bdkUMrVRef7U/cXJZgrX5wF7Y8Bjsl2FumXHSh3Wxu
	qOb9S28LU6gJxUNZ26EYf7Y6OT8ty8/HoaSUzAWUlynZCGHaRVlsjVBJ8A259jPx1BBiyJLinJr
	dZr21PpAn4xYzwsga7npHdpfmnI9DsocuhR4KaUaznKIveg8QOD
X-Received: by 2002:a05:6402:a25a:20b0:6b1:a544:da83 with SMTP id 4fb4d7f45d1cf-6b1a544df95mr225535a12.22.1791642351187;
        Sat, 10 Oct 2026 07:25:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:49 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 4/8] alpha: invalidate the local context in flush_tlb_page()
Date: Sat, 10 Oct 2026 16:24:30 +0200
Message-ID: <20261010142533.974797-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the target mm is not the calling CPU's active_mm, flush_tlb_page()
does nothing locally, and smp_call_function() reaches only the other CPUs.
This CPU may still hold translations for the mm and can later reuse the
old ASN together with them.

Add the missing else branch. flush_tlb_other() clears mm->context[cpu] so
a fresh ASN is taken at the next switch. Add this before changing the
current->active_mm test to current->mm: that change will also send lazy
callers here, so their local invalidate must already be in place.

The uniprocessor implementations of flush_tlb_mm() and
flush_icache_user_page() in asm/tlbflush.h and asm/cacheflush.h already
contain exactly this branch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 1ad448105201..e4ba0aab8a66 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -697,6 +697,9 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	data.vma = vma;
-- 
2.43.0

