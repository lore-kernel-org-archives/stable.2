Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438388;
	b=2pGnvYDHyB2U+D+q/2BNfuWtZaIG7yS18+VvxXUEdxaAgW2b5KMu9iTEN8YotFdmdXGJ
	 vPax880AcTmiPAwPAix+PQEe7LPCu04Ni6FolFJpc3Mmv4FGvlJN5hOXMZJWhXBsz9BF+
	 1XDUjBVi6yLzSdWxwX1pXGyQXKmTuYrn2SOxQT2mdmwrMchr5oqPesUi4kHEAzMjk+Viw
	 N5rXzUFjxZOfpBSUcrAyQNhs88VY46iHlDup61Fe+0Qh3ujtPJWwYK1VMBzAI0fQ2zk/L
	 hJ4dfRlSYzDBaEup3PtvWbbFYpOiaMYy/0HXv4X1e7OXpGp+7Z6/+mEGboJ5yrjTTbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438388;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vOd3Fxn6yvB2VyZrBg3cap4BKOQOr3E+6p4jJYft2n0=;
	b=Bzhba3jqmtVjfOq9gMWq5FB8AEZVrhetbuF06Jvh9EnGB9/8hpa76Gn05QHc1QnKTbt2
	 3XCtMnlY05yA7lcYnzqHzXM0OLsmw2rkeHnzjtadp+r4JBJKVc1JnsOittcotfUsMz/vN
	 rYF7CPRugo0JBPS08AP8O988YyUAKJJz+HAZE9T4Vy2DnkYzOt5HV0IKrFhYMvdH1eGZe
	 RsPuoYlRh2Gb3UVNmATJJW9YC6YFmuWK/CRhpV6/OzhYMBghCE8O1ghN+l1hmaSeddm/V
	 dxTZXYF+L0OvN83dAgIT/hl1ZivnB+4/YBmwRKsTlLlyHeBYrAaWOx2ZMwZskjFSH0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/wVuqj2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B21DC606A31A;
	Sat, 31 Oct 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/wVuqj2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B8D791F000C1;
	Sat, 31 Oct 2026 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793438387;
	bh=vOd3Fxn6yvB2VyZrBg3cap4BKOQOr3E+6p4jJYft2n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/wVuqj2u/y4XTuMZ6ypvyS0TFhy84J7BOxIso9WwSyz+fpUDzr3fDwZCN6+KqIEH
	 QOpt/UtaGkbD8aNMrhndQyykTdnEqwTqN49iYueoeFsYQj6meAugSYa2921HpvmRln
	 SA7wWgtWdqJXf9PX7FR9zcPt/arlKlBA4zYovvIw+SfZCyg1f5ti0dcBW3ndTL/o5w
	 tg2m68vSlOu+xLzwK4+XA8tbg1ZNfKM78Ev7ouAO8w/vPRnalP7Nf5g1/9PmmftgLR
	 qDd1Wl9hECHsJv1ZSA8sMdDoJi3q8gO38x+ZO8QTyvYhobByXt/W9d7e9ciVntjIpN
	 6QB89j5cJlffw==
Date: Sat, 31 Oct 2026 11:19:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auWyr4u0icssaOHy@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
 <auWk2PAYDgQGXLqr@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fP9ujw+JDj5S0FS3"
Content-Disposition: inline
In-Reply-To: <auWk2PAYDgQGXLqr@kernel.org>


--fP9ujw+JDj5S0FS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 31, 2026 at 10:20:44AM +0200, Jarkko Sakkinen wrote:
> I tried to go through the code change now as it is huge and there was no
> explanation why you need to do all of this.
> 
> It is full out-of-scope changes. Please redo this just as a scoped bug
> fix, and don't add any new flags.

Unfortunately it immediately hit me after sending this how to fix the bug,
and it does not make much sense to ask to write the same fix I would do
myself anyway.

I'll rather go this time with the attached patch and consider this as a
bug report (as marked by reported-by).

Thank you for your contribution.

Br, Jarkko

--fP9ujw+JDj5S0FS3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-KEYS-Reject-restricted-dest_keyring-in-construct_all.patch"

From 2e37dd3a4fe1c10ebaeec3243e48baa25a6efa1b Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Sat, 31 Oct 2026 11:06:59 +0200
Subject: [PATCH] KEYS: Reject restricted dest_keyring in construct_alloc_key()

construct_alloc_key() links keys into dest_keyring without checking
restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
remain in a restricted keyring when instantiated without relinking into
dest_keyring. Reject restricted destination keyrings with -EPERM after
__key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.

Cc: stable@vger.kernel.org
Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissiontogallop@gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/request_key.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da5..715ef3cc51b3 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -404,6 +404,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
+
+		/* The payload is not yet available to check the restriction. */
+		if (dest_keyring->restrict_link &&
+		    !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+			ret = -EPERM;
+			goto link_alloc_failed_unlocked;
+		}
 	}
 
 	/*
-- 
2.47.3


--fP9ujw+JDj5S0FS3--
