Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723268;
	b=C/ReD5OADodYHtlfQ/40Ml8HmrIBEytbC57AapqfwrDwGyr0l63zrrQtz9ZRT30/FKVR
	 XNJZbmm3hFBTvJLkkYZR+TTJ6M3q4n2Vtb/35wQB2KH1mlb2VLVr5yYYqvcJqdErgUQQD
	 xYZ8h8x7SHDqyfAFYjbQiCi1LzotsCmrC908hhNPY4u2Dp4i8jCJZORdvS//g5Ks5yjHB
	 feHWXVHvxta2UUsakO++ZecnX/184IZs8NZufbx29oJ03LgdV8hsO5Ldsb2rrqlq7IPLb
	 ZQijE8IgKuMO77wH0yq6W7ak76Wj28TjO9dowLHy06ZZwMb+9NQ6hxvjcW7JuooyMlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
	b=25wmHHAHTMhwz7TD0zIEH2Y0pJdtxLV9OVY3bXjG3PawQglfvtzWKlxAV64E5WTNYb4l
	 juNDxjk7gobNNdSydT8+4zcx0dwDZm6D5FBqAxc3ANC4HyyYFiWYgq7KQSYIu6v3L3piw
	 KCQDrvh8x3wfUQRC2B7F1V3ZnT3EKdkD8Z0vpt4NP8A7T0OCwAXDgmcsrJ7j6fBZyazpZ
	 vQBy1vkQ5xx2C5SoI/X//jDyPEVt/Me+OPRlp+xluMm+EThy5Y5YPkhJctem9hAC+tWDc
	 EWjz2+s4xmndycNBlv+x1ML7GOZJC5DPoV0pHWtLQ290FKZYpa8dewcE4aXccHVpQew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=muQBTpP7;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584F606A332
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A584F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=muQBTpP7
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-86313f7f4faso7351471a34.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723266; x=1796328066; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
        b=muQBTpP7/q1RlO+sE7lY+7jkO7y0hqz4OGsjZPnNcQ/yjEBfeYM2sTVT2u10XnEFdS
         C3ozy7zFIaCMCnElGo3uRFQNyERgFWFoNvQCfQ3CgTZFgMqdumfK5JEkZFTdjTI/+if0
         NKvr+nc7h3vQ1l/LB7Y6yB/+kjHcybOxzVGci3wzIYophJ8eGcs+FCsgIJW2hA2zF80s
         PTjeGgJ79obZcHmlmBl5uyhCitx0dnQB8IQcVdxvg8rz4HrgRzkuULok3Ibhgjs0iF5e
         qj1bZR/R066fwW/Q3YGmFuyMfb6LbSa1JAMWdr2++uUgoISb4+nrUcDIHdu5Ray7lBTC
         sfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723266; x=1796328066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
        b=SzI+k6lzfBCWH+flmXFIFTWqG25LRAjOMAP7xQEVDs7wmxsz4G7tEF0ZRtrnEFtogd
         WiFW4D0mLvifQXvI9ZHYCacne/1EbyvqDDSHCSh+u937gL40RSqaAkD6+UCoeQklGLwO
         a0Gcsazmh9njkYJqTqfC/yX2Kbu1D7mBvEtUida8z+5Fie86zoTaz92bzNmFiqsB6B9J
         NJ0lyCJeLt2axlBxy/bek8nOOvGn8BKenFRi45CY5JaMkRBXSQgcdhKahCJpvCqHyUgV
         hmifp1ustXKxDyHFqHW86Gvp9EpgLgbFHDWT5uh4+OhQy56HxwKiYpSwfA4XsaNWhwV2
         f1Lw==
X-Forwarded-Encrypted: i=1; AL+hErFRGx8L1j+gkH9MZWVPLonPyswgy5vhyQrynlzLowKnGEHBjaGsxaizfhRKpiIsjqDlEPZhUYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Lm202AB4XZDVckbbQIQiNsYZ5G94j317WKIvY3yzg/jPtSuVL
	taWU1G4U94FE5zwZBieqVftr41Mox+257WjgWnzhAcs/aAtaTJeN17HmmMXuXesNWjwS6pe2rei
	DxmIEpB0u4cXofwiNhuG4EqUMx8nYfw==
X-Received: from iowb19.prod.google.com ([2002:a05:6602:14d3:b0:9c7:bd0f:3947])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2208:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-57a0dd479f9mr27505393b6e.67.1795723266322;
 Thu, 26 Nov 2026 12:01:06 -0800 (PST)
Date: Thu, 26 Nov 2026 20:01:03 +0000
In-Reply-To: <20261126200103.2806716-1-zhenwenliang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126200103.2806716-1-zhenwenliang@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200103.2806716-2-zhenwenliang@google.com>
Subject: [PATCH 2/2] KEYS: trusted: Wait for RCU callbacks before module unload
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

trusted_update() frees the old payload with call_rcu(), and the
callback, trusted_rcu_free(), is part of trusted.ko. cleanup_trusted()
calls the trust source's exit callback, which unregisters the key type,
but nothing waits for callbacks that are already queued, so the module
can be freed while a trusted_rcu_free() callback is still pending.

Add an rcu_barrier() after the exit callback. As for encrypted keys, no
new callback can be queued once unregister_key_type() has returned. If
no trust source was found, the key type was never registered and
trusted_key_exit is NULL; the barrier is then harmless.

Tested in QEMU (x86_64, TCG) without a trust source, so only the
trusted_key_exit == NULL case ran: trusted.ko loads and unloads cleanly
with this patch (5 runs). The trusted_update() path itself was not run,
because no TPM was available.

The problem was found, and this patch prepared, with the help of a
formal analysis tool we are developing that uses AI assistance; I have
reviewed the analysis and the patch.

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 security/keys/trusted-keys/trusted_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 0509d9955f2a..5efd1e6ef111 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -401,6 +401,7 @@ static void __exit cleanup_trusted(void)
 {
 	if (trusted_key_exit)
 		(*trusted_key_exit)();
+	rcu_barrier();
 }
 
 late_initcall(init_trusted);
