Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD04E1C81
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954426; cv=none; b=Kv8zg2/tz6i9Chx9Toe+9+k74XGI6aq/veZ9cXLB88ANdXPoqg69btM9TVZ8+WvyIce0Pm+Yp6OTITyReeIKogDYY8Y801cmdmhZSwHv4KOZXHnGlMWtyBd67+sOVUS8mkRgt9DneNhf4j9Z6JACsPorMWn+dlyLAG+oP3nDGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954426; c=relaxed/simple;
	bh=jiRlnQPL/4jn0XA+0EpA4cRvVnRyf76p+dgNnwem+7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbYVaV5+0BwuDUgDd+o3La+MpqPy4vLT9wmAHUKsb0MqZi3g+9b17xox2yGBZ6+m9VfMb29dOzShcyGF4dLgWFBM6F/SNFU/x16WKQhyGOCDymWNt9HATFhbxlWD1aGBYieQ9fiPgFnbJ78fLpzEOEgB/2I1FJwMMNEVzmfJgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=J++kYhkW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="J++kYhkW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso103015e9.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790954420; x=1791559220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DX8YXk9lb+w/GLA7rHIr8s7xKmdQI537LSAHJBywLx0=;
        b=J++kYhkWj9+SLNiKsoL+D8NzoWCWJcK8iCe5h799Zsazgagvd1VJh30KOQZjZMfH32
         Xhk15Xt8gNOgkfy3rGrDU4SmjikuAZ+qNtzNxCEO1KEIxZ2DzQdrqBAi1lKCca8DkU6R
         +bWyFAyajVR96Qe7LGpDi/QvLXXxSLHJh/J9896HEWT1IM8DjZI1Oo+5k7T7kg0lkryJ
         NtHUCoI91i51ZzH8Q9rD4QgEQ+QUzK0kBVJ49Tavqz8W+Zoh41HPEFPYEohz+pAa6xO/
         rYbf8Lso19sW1JmbubLRIkotwCRAO6gGfzIEy/BmkK5oy/XZD3n1wPNky2stBSVXluw/
         CG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954420; x=1791559220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DX8YXk9lb+w/GLA7rHIr8s7xKmdQI537LSAHJBywLx0=;
        b=xF13CSVeXnmXDsiStWKCQ45+1z22ATbTwTqI6KwzQYOmG6c+2qjLg03SOkxhB7qUhN
         fYblGLkao/g5zLoRD8m6wSu/w4ArVNBwfW6iGT14dVFUaBsuCT3yLWjQkZA/Pss1149i
         pEJWzXPOxy/mnVlc05vDNL9UdEps23PtHDDdWOaouzgWAGNLv0pDPMiHl/CH091P0IRJ
         JczjFHi4s57ftfYAM5PJyKhC0J28L316FBWilXvieBbScIutDb2U9nNs+1Ap0MJXJcpq
         NvrM0CpKT1kZdN9dt/cLyIfss7EKSzgexvH093HPuR2E1+uLsmp78bGW3mlcUANASBz9
         pPRA==
X-Forwarded-Encrypted: i=1; AKwUvBzR+dgUqePZuA/nrpDdGZ4eZJrNrxsKFC4AeObAG81H/V7sTqr4l3zseZEeZKMtKAL6XrQBU7c=@vger.kernel.org
X-Gm-Message-State: AFuF++ny/axCwTrmo5YInAIdkBbNdR/cBPZFpmg7YN4Qg1czQPMH/1Zj
	nUxqAjGIuz1Ki+62Kj3X9AomIcSGO6yDRaxJn7k0J15NWaOvDOxy2dDs8YrBwxrrp/k=
X-Gm-Gg: AYBFou3MBXI0xp4dtY8Q73VVw4QN7g9Mu544BssTz4tBVmwRoN9qACb5KEZJ3+QI+gx
	B+0hqjiG0KBCArY5vnd7mlBn/16WKKAiTCtsZ7gVu62iIMkOy8eTnLWe+2zrp72+HYwuz4h1BoK
	0Sy4jQ1HMqozq0WpWMP8zedxEkLFAkHMR34hAeF+mvNnWd8J7ftjNnpEYJD6YXhOwxtGYkHlbEN
	lzXRaWAL/i45o+O+2/NDuMJEKOgJmEAdKSc3jfk/b908IT9P0KYyopofib+ARlIC3w1q3dMaDNY
	xrgvcsqunxhu3oLjc6uxSDSyjehR79ymRPbnlKnglUhR750Iw6tcFMxvCY4q0tUWt1Ms2PXIfFM
	BijevU9K2uro4sNzEdhm0MGmykh6/xF9C/tVryZIizbQzmMhPo8wVoBRIIa8M5GwFSwaKdLKZH9
	3tBZn/DMRc9s5LbSIh04a2yWQ0nuoYKQWS7FQzoRB7rrMbdaQn8Di4ZjDnKl5S5illPS8UwCaTX
	4S5/Wmi
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr55471925e9.16.1790954420036;
        Fri, 02 Oct 2026 08:20:20 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:9c5b:8aff:fed1:19b4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03048abc9sm32039625e9.0.2026.10.02.08.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 08:20:19 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: kvm@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] KVM: x86: Cancel PIT timer on failed creation
Date: Fri,  2 Oct 2026 17:19:42 +0200
Message-ID: <20261002151942.491680-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

Cancel the PIT hrtimer if PIT creation fails after registering the PIO
device. This matches normal teardown and ensures the timer no longer
uses the PIT before its memory is freed.

KVM registers the PIT's PIO device before registering the optional dummy
speaker device.  If speaker registration fails, a vCPU can have already
programmed channel 0 and armed pit_state.timer through the published PIT
device. When I/O bus registration became fallible, its cleanup did not
cancel the timer before freeing the PIT.

Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 arch/x86/kvm/i8254.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077..b7875345f 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);
+	hrtimer_cancel(&pit->pit_state.timer);
 	kthread_destroy_worker(pit->worker);
 fail_kthread:
 	kfree(pit);
-- 
2.53.0
