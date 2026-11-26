Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723267;
	b=xOkOHaTHDI3JQnIMGF4r2r11fKhzmDE/sLvvzdrHDE1ISZFLaHESWTQHJymkvGGQMV+g
	 NYbpvrPPylLZglKNWkfPeSovCtUj0Cp5mnvdS6tZF1XnVFe5HwHIOv5UCCDOcLJILRSfc
	 odLiRUzotN86dA89rykNsf7h65MFoBISknonEECx+zW7iWSAJuf4gPsLq9gYklzwB3oTd
	 ab3smOeXxch4Osdko7CLiool9Y9o91yYXq5vUUZwVdbXFIMBPM4W1JwkyIqVe1DJhoxww
	 MBAR5KBFCsiswTQT1isB9XRtRTqFDz9iddYQx3sVZs5hHIzCxl2yhCY7MOAqiFOqMvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
	b=ZjpYS8FQWyofVkqF3B7OmN3ejI/f0WptG0rFGuzd6LZvqb/UpBu1CXRbydgr0p5EFHMJ
	 LYj0VxR3mpbgqtPgKd2JU2Wupu6xavV+RVdI7YNbisS8FlnN8HHSgbxIb+myA/Xsrqw10
	 qlSCHf0vF4VXIYf31Jz5Ohxc/kZSjpXJDrwmrDtHUiKzZahVXq9C10kZ3Cmz1Xul86mdp
	 eMc1CfupNcITBaz4JSy/i6YcBIfbjzc0Q69UVi5hIOEFihaJ0j22zds1IdAeVf6X+e0R5
	 Tx30MaCr+YIeL4I/DlM4/SSBpUPCm0KvBCdYZAKL/iyRpn6iUyqaCK1YzmKMsXlfS+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QxbdqK/L";
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D876606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D876606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QxbdqK/L
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5641cd2cc13so7380869b6e.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723265; x=1796328065; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
        b=QxbdqK/LnysLZNk3giLpFCC6miNSsgKre4H+NTcH1r+SzCQAHgLQjJPSGK2ObW/qzN
         GWtcny/72I4JywhjriFo845hSsRIgBL8Qn61amypgK7xmosCZbyAMNGh9+wNqkeQAS/3
         e3yB9Em15DwqFj7E6sJ+kanQZEH6Zj+3w87sJUaABY/62hZYCS7LPZOZN8GzYybXkyiK
         ITCRd3uCHyNC3U9n3jrN5z41tP5KIGzy11YUBY3dzvJBqqLf+aeVTvHV5wYx6p4LEatc
         Mu/1V27sS6i1N/fPPvoWuyTpe+jPZ1ldCSUHCe8jYC8zZuoJvuDctYZAsRcZNrw8xa+R
         f7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723265; x=1796328065;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
        b=jtW+Tc8gsg+xeYqlgkekNe4R+fqk7NYGdpgHlSpX35QBlWuuPVDXKNv869iV7ZbOtY
         e9NAkL7BClCqPkYXhJaSVBexhjBIk93S2+h1g3I/xKEiqwKfN2I2JxkwJ43zt7RMTLLf
         lpmHZ57WdwtQM9MLrDjx7htCHp+f5vuTYuY7B+xNhPDOBudpa7W0OB//bq/bG+mqHq5J
         1sVHOVQeN6EFBuXQVUNGiLZ8LU3AZDBr1M35wKtfBQXj0WYAxDKnYt53m3lK6iEA2TTm
         jYNO6hn+6+FXx/duV2IZweOv08A5eSFIxpYvR//0jg18Iobbc9Uq8UsSb5g5EFDrOonR
         RMSQ==
X-Forwarded-Encrypted: i=1; AL+hErEslQEmoH7xUuIXTnWGT7SrGtO7q+D0bo7HyqIW3o/oFf3ql/y4D+4APv+QbCmri0fOFIelj6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qyeCqWwesIbnyo5G8OiNh6pgGhetmesJ3DxXOQq6NLVGbdbnW
	jBIvbOm+IzJbqNgU3tTBPoAZuEQN4B/90b10IxGgpshqZSSc1xBCrj8GekvDkBgNfS8NVWboxmg
	xZ9Vzzjo9L/kO9ukCDM/V2FN028aLJg==
X-Received: from ilei11-n2.prod.google.com ([2002:a05:6e02:61cb:20b0:54e:86af:fe5d])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f2c:b0:4d6:90f4:48b4 with SMTP id 5614622812f47-57a0cae5223mr24227154b6e.54.1795723264869;
 Thu, 26 Nov 2026 12:01:04 -0800 (PST)
Date: Thu, 26 Nov 2026 20:01:02 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200103.2806716-1-zhenwenliang@google.com>
Subject: [PATCH 1/2] KEYS: encrypted: Wait for RCU callbacks before module unload
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

encrypted_update() frees the old payload with call_rcu(), and the
callback, encrypted_rcu_free(), is part of encrypted-keys.ko.
cleanup_encrypted() only calls unregister_key_type(), which does not
wait for callbacks that are already queued. If the module is removed
shortly after a KEYCTL_UPDATE, the RCU core later calls
encrypted_rcu_free() in freed module memory.

No new callback can be queued once unregister_key_type() has returned:
key_create_or_update() holds key_types_sem across __key_update(),
key_update() checks key->type->update with key->sem held, and the
garbage collector switches every remaining key of the type to
key_type_dead under key->sem before unregister_key_type() returns. An
rcu_barrier() at that point therefore waits for all pending
encrypted_rcu_free() callbacks, as Documentation/RCU/rcubarrier.rst
describes for modules that use call_rcu().

Tested in QEMU (x86_64, TCG) on mainline (7.4-rc4+) with KASAN,
ENCRYPTED_KEYS=m and CONFIG_RCU_LAZY=y, so that callbacks are deferred:
add an encrypted key, update it 20 times, then call delete_module()
right away. Without this patch, the rcuop kthread hit int3 at
encrypted_rcu_free+0x1 in the freed module text in 5 of 5 runs. With
it, 5 of 5 runs were clean, and the unload took about 30 ms longer.

The problem was found, and this patch prepared, with the help of a
formal analysis tool we are developing that uses AI assistance; I have
reviewed the analysis and the patch.

Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 security/keys/encrypted-keys/encrypted.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 63f0245e6f74..fca809819f8e 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -1000,6 +1000,7 @@ static int __init init_encrypted(void)
 static void __exit cleanup_encrypted(void)
 {
 	unregister_key_type(&key_type_encrypted);
+	rcu_barrier();
 }
 
 late_initcall(init_encrypted);
