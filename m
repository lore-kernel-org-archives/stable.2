Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260566;
	b=hkdGJrEJeSEA9d1JGtS26wiN8yRlOajdZNSoa3/c2kC6ZRpIwLbUfv7SS8CG+CLo4A75
	 LIfoqdCfBcoSVxx02ELVd2M21wONLbw6El0nJlB8GCdbbtdW1I8M7aXhl2hrCzoLeu+QW
	 GHC1ep4DztAFTrocVV4c9gdKKblSbUk27fdpSzq+0rFqrlDvOyna3/+s2ohf40gdr1XxP
	 mD1rSM/VUP1Iw/xdBfNdqq6cKjCv9ABESktDkb+ffRDtVLWsFIJue1hzLV1plgTTH1L1M
	 fJkbxB8Nq11fAO6ALQjva1EEvFBftUcvq8GD72zHHBwRfJCuX200/bhCbRBc4G4VMWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
	b=Eg6Ys/3owzDAPls1zRF1H0ndwLX7tGBTQSkcuB+8gxiREy4ALADr/14Rhi2p1Q2SJ35M
	 jVyzDI3Pwe7rd7/cemylSVcvYZa/orY/dZuIzTgruCV1K39+LG27m7dyVfLXRTPOcUTCW
	 eX8ZCapskN7+/PMVcQHJeTZGQUE0DolkDnPhRJXlThe7xNGGNkkn4JXmn9HzwkfCfOpQU
	 3Ye3CdHa385jHd7aLu1EJMxi+b53EAhj3Bid8wUix9q1EJd+mfV4s9dA4APPMZbYocJga
	 0Ew+6l9a/lrXStY2325dECh55uWIS6Pxq/VK+udd8v0kLPv3yAesHVD3C0u1ryWusAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0134606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 11:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0134606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dee593f18so1614211f8f.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260564; x=1795865364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=Wndv97v0xNPaFveqPJE73z2hBy2mVbS4EQLfhSu3Qr/NEtlcenEomJW44MLGRSN0NK
         4ebXbUWqFYFshtpdLkIu4G+V+8BBmM4hyxvT3t8kA+Oxvm2IVXPxSvGwwul3fcxE0VQq
         HIs2yWfKLdXI7nxF4IPMSF/TR+8a3cnWWtx2k85gPjqLFLunNFD8vv9NlusF/pG0iaq7
         +VRUjMsc2SpfichnmWjWT5E+IL35HOomym2W//nn2utskrI50B/79Ztt9kmhc4C+HvIe
         4sGG3nqOPrBEJuFMaS80zwwswZrzMx4Wr0D9XlEh+IYg6SwXxZju8DRH6xr/BPT7Vemr
         9ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260564; x=1795865364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=hFUYi2eCDEbYCe5x509eeD48mXAvMWw03Tx9IFXMQc7gBrsadwGarMlYfT0c1VyBPN
         DMbe7ylHTAoyIWtDYQwYYAdTOvCNHZJotyNv25KHf7/xoBcdGnFk+V0P3ScNmofqj9Gw
         W+2xpDm4RaEyKsY1oV6/Wq4HMOU2ufE9fcQWojTvJpoMgKZLtjfLisMSwJXFUx+RirEd
         75TggRPZw9JxGJF8HIe1ruaGyEOeXXPfgPJSIZu3+JXohmVJaYXc49z/5pjv5InTrFg4
         NDMTWkYKiVT6Ex6DSwzg4ZJLHyPlD67k6Yef9popkHHAxMHlZSeP7BKutXX9q21J0w0b
         kjiw==
X-Forwarded-Encrypted: i=1; AL+hErGz5oEGpvr3ELlreSXjJjVSUQBbtcOjHwbsigZrumz6h81YY8QR1H5cjilbjr6Rg5pPv+ybiIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qdZTQW3y5pSHfp6ztIy4wFV7yZm+vYF08F8BSfIrbR/M7O/wI
	7QEC7k6rV7Fkhowq9onMBOk6cT7V3tvpFlhY8xOcZhU9BUQBItkwboQ=
X-Gm-Gg: AZFdTZfrfgICBWUYn8PMPiO/b2AszQi276eMagU8fqFqrOocumClKfO3dhMj2bK7Z2c
	f23JauKpMX1ODIGHBtz9TVr6LKQvFr+YOCqnxkFx7kPbNg5vZ1AEdMsVJUj/TiEldiiYWGKCpr0
	n3sMBFw1wg/04FIjsKvNvVCzAkocA47V+0kKD8Nuf77IymArkx6qIG9zHipzvf5J7o4EJHQk4Co
	Ebkk5/vk0ULTHKnVlrh5OvzhCxrfukRZgIBdgznL+etdEJFGVA/oUs+dEJjgg0/Mz6ef7weyDRZ
	2F5p8DqaKKx1Pkm+egGj79xsjJGh1scMqPlykuJfwD5IuTFPj172wEXGnfhk94oJm5gvVTA7WZ1
	KCp2JZBGboIqUWIX6lmabNjA08qMyrI9ea6ogEwMY1oJcM8O2s21HkwDJJhW/hOcw87hNqduHIo
	inIZrfn367xPqGdQeW5zmCYqDVCeBmsR2sZgMjvfv3Jj0KzIVQQSU/uBwDYb4yswnWmw9AeDP+M
	PDKs1JjZl8nOfqOQ80pfcnaFmJvr0CHnsaZY00zuy6CTRnOyXrWA4ZSeSj03sapV4aHRwwOE8df
	j3b3o3ThmKwdmeYEqf9P6DJVOXE8hfp8Md1szQ==
X-Received: by 2002:a05:600c:3511:b0:4ba:73f:ef5 with SMTP id 5b1f17b1804b1-4bb88828304mr137787085e9.34.1795260564182;
        Sat, 21 Nov 2026 03:29:24 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm37210385e9.3.2026.11.21.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:29:23 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 11:28:53 +0000
Message-ID: <20261121112853.2175119-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem.
A key reference keeps the key alive but does not pin the module that
provides its type. If the module is unloaded concurrently, the key GC
retypes the key to key_type_dead under key->sem, and the module text is
freed. Without the lock, construct_key can read a stale type pointer
after the method has been unmapped.

This is the same class of issue fixed for other key type methods in
commits 925c84e3cc21 ("KEYS: Protect the read method check against type
removal"), 51bcd09b9ffca ("KEYS: Protect the update method check against
type removal"), and bab48a1044475 ("KEYS: Protect the pkey method checks
against type removal"). construct_key was missed because request_key is
less commonly used than read/update/asym operations.

Take key->sem for reading around the key->type->request_key access to
prevent the type from changing while the method pointer is read.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..eff67c5fb9015 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

