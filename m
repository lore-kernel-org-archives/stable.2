Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA53D88E0
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279262; cv=none; b=SbQdSjsPe8wl6MHgdZDd1Uva8hn+aZydzsL2aAjCePOywl0jYEqpCodc6D/ZBD5RqNjiAuyAQCGMFvGz9Hl+RkNJ78RYGUjZLcDvmF2gEh0fLa/WX7bevQUwJKzdK4nMGkP1pSzRkUPInw4DvZDXvFyVOFHFEkMZhc0pdG1QTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279262; c=relaxed/simple;
	bh=+V8uFO8KjUBEZ10FiDGjD6LAJ9EH5zGBb8kX+VfCtOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mg09Hyuw8Pm3izvVV8fplQ4s0uUWMSc+PqaFY4Q5hhC01s86ASMfvNyqxoQXck3rr4g2+WEkKkfeJDDFDgl82se3jcVgOg8aDEJzZkP3rBUT/Ei1InDukfTj34HdpeBqmyM94o4O2pZm++++WrFHgA0Vc7ZADCRGaKOx/ngT4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LDNmFn+v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="LDNmFn+v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so347874f8f.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791279257; x=1791884057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jq4MvvelPJmLJTP64CCeQVSZLu/IREWVL/wvvlYXR5M=;
        b=LDNmFn+vPCgLAHGVEJ5RFSZOerw0K5YsVdDhGYeEEMnDdVbUHEoWvjiDevsA9m+kXY
         2Smgk0XLv2lLOEgn//z8ypMN5f4k+uEPK+6+oABKIuQ7LaWN0k6zKb9id5PsupUxeBBF
         EVc5jri1vpOfSJFAXf0Zear4Y/8gKQFeFa6ZmCJoH6pS5waZGuFzE1jH13QLRHBxN/Gb
         UF9hMpSijvL/dxWTXTb/Zf98ztlelOVbOEozgZU7PxykEwHNxDduRrrxxNHxJd8sJqty
         THmnl5q1FzkLG71LxZJXFH+BodhXeDXynEo3sDJ1xyaqlnLBPPUyvxYHx3/9hH3+ofaD
         l53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279257; x=1791884057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jq4MvvelPJmLJTP64CCeQVSZLu/IREWVL/wvvlYXR5M=;
        b=24/RpmQ6oN4sxAxWwYlGxMWgW6aRyob9uEVemw8rewWBAIIz8Lw8ZK34hwoW7xQ/bW
         ZzDV/KxGPPtwgQD6GIj7piun5XBHiNuOQMNeqRtYPcH5NryRQ1g2jyNmePuHwbIK77kR
         405znP/+2oLzjtVE8oc/BG73bsUhLB43efLn6TGwpSziiKFIP07/aalOZLf1Ft5m86PE
         u3XyGDpFN7P0vTXiOpWeeaO+XOv/AIV58upyUwGuz9Azi+YschYdKB8JV697OUrOyux3
         Q8lX5x/hfma9nLL5aDBT61Yh93eU3SSmANKGx1L42MKaYLb4PCJLSOVLaftBSuA6on4O
         CQLw==
X-Forwarded-Encrypted: i=1; AKwUvBxy6x0NEnRWcNRp8ejIG0+06EVf/eDqZtiSyrZ9tUKSnGj4yFU3lKB8wOxrDfYi3ricPh577mY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLQ89F0c1I79aTFj+cpQ3bFnchoRfFkwCXjUCTy+X2csdZ3f77
	stIwNRSzNSNX/uEpsWgU0A5B9HkP2D3sFm4DU5T0154IanLG/4Zurcgh9jZlf0dTHRs=
X-Gm-Gg: AYBFou1uLB2ylsguBhjd7AhL/KQTvIVW4B0jYkCzZJe6HBm4TbBeDkLBRYNL9UgQdka
	1UD65c/e2RNDnL9mSwuCRi6rcUok4LEf4Ojo9X1zJoBL/EXYZw2LSoatWgvJon/bDiZvUwpp2bF
	80kL/EA9ns6FOHvl58rBRmFvfpX0WeSlAxZsymof3d115pX6Eg3B62i25wLDZDjgAoMFCJK4psv
	N+89JxSeetSkLJT9EF95c1EBEDoJJM4mQ+qQpJhtuPnxuKs4CiZO8++LD3QFhG9ApStLzk1kjEI
	JwHwmRsbse9Dm3fYn5/Z/y3UWb5wO15YDb4etalIOT+v1TNtyPAS0hHtnFGBiBr3Ixhey0S4QcZ
	lyfHtbCDe3jyZEy2HB3Dhnx+kFJV5kOoO2vWPqLfh6XCNSX9NOpnpKpCUETVWnt4btiAtIZXNlJ
	v7kQwvnWgeFb0FL4Jb4B15c4MYtXoA7O8JThzYVeq26Laqke5FVT4kD5DAtnVcIyX8xsJZEoLAR
	djQaTSkXA==
X-Received: by 2002:a05:6000:2210:b0:487:27f9:82c with SMTP id ffacd0b85a97d-48c6d19ba25mr1256715f8f.33.1791279256305;
        Tue, 06 Oct 2026 02:34:16 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:9c5b:8aff:fed1:19b4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622b4685sm8853347f8f.41.2026.10.06.02.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:34:15 -0700 (PDT)
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
	Bruno Produit <bruno.produit@trailofbits.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Cancel PIT timer on failed creation
Date: Tue,  6 Oct 2026 11:33:54 +0200
Message-ID: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel the PIT hrtimer if PIT creation fails after registering the PIO
device.  This matches normal teardown and ensures the timer no longer
uses the PIT before its memory is freed.

KVM registers the PIT's PIO device before registering the optional dummy
speaker device.  If speaker registration fails, a vCPU can have already
programmed channel 0 and armed pit_state.timer through the published PIT
device.  When I/O bus registration became fallible, its cleanup did not
cancel the timer before freeing the PIT.

Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
Sean's proposal, feel free to change the FROM upstream
see https://lore.kernel.org/all/ar_PNEIvsQMQPMLg@google.com/
 
 arch/x86/kvm/i8254.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..33d772c7160b 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 
 fail_register_speaker:
 	kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
+	hrtimer_cancel(&pit->pit_state.timer);
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);
-- 
2.53.0
