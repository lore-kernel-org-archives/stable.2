Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114A3D4125
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889729; cv=none; b=XLq375ZdRQaOkuwsyi06c2U3IcQd3DfZ8gPcUkRer3p/px8+eRX02QOzwQsvAznJK+TrOrQvVYY9hL3VEv8K+Y3axzm4eP08wk4ePZIYeTL3duM/GoUw3aFbZVdv4yK4HHnu7xcBq3NQPazBDM0OKbhazG2PiASFzQ5eL2gHcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889729; c=relaxed/simple;
	bh=DPiosEXUTgQ4JjvfnOhAGoZPwcUGQWKSSE59G1rv3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep/I5UM8Ta4CRzaUkviqty1Kz6T7icy0W51DdW/i5Wv80tp6bYAo53uH5VhsHFDQJr5Zk8DfEAZbcRNaUOu+t+a/JfDgz7wOtwns+DWkDpt/TF2+AB3poXh8E1MS/IQwK+OxUYE+PaNa3oDYXt2IIxb90N40t+ZTsCHYeHWtFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9Vt9o+l; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Vt9o+l"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso1229002a12.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889727; x=1790494527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30XeFg5Fl5QM8uZfDju7oAPFMP/eO4GBITZ0vmaOsbA=;
        b=n9Vt9o+lDWZxKsRBRt9ZYYT6+a3wHgPW2kWMxS61WBoTUIx3NtaVdvws762hZmWVIF
         fLy3E+5fwBX7yaQtgc+RxHa60Cwec/aDfreuqZipZ9t8L6LgXMNiEtwoEFbL4NQyR9Iy
         HtM7/4jzoQJQA1d5EnpD6HXAkOxj5Bdfn1745QyQitFZAgrcqRqLtEmVF64KkuqZcYAX
         t5nvMJfGdcRdTwYghiIqu9VCKovuKVIe0MrV6yVAaSN1yMYd3xyDJng4ziT1nawCv64O
         LeVRygSHoRKdmVPoODMJVkFi0dAK3pL7rF6kIQTS+M2it2FyeEW94NgUj+Mm3BJ4xnVa
         9MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889727; x=1790494527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=30XeFg5Fl5QM8uZfDju7oAPFMP/eO4GBITZ0vmaOsbA=;
        b=OFwzu8orn667ase5f4wv2V/2FSiWh6j+un3dRZbXBDtu9UuSKV0QXeaXNXGc77dAL2
         Fe1rnkmtweMi1i/cuZaJ59RkciTqcJQBEw0yKeKXmdW+zjVgiAD5XaauJqAYYq2JE82w
         TspLbWKf7e+vS0KWYPDPdwsTJm7XJknSnYI5D1++bcGaGnVo1FkjXdTrPQd3weWguoml
         RexU34/ptPPLJT/Uel2Y0wI9yBb4XMGl/er8XMZUv+j+dOEv7yFqx6Qm/K6RuTBkj4fj
         4BMTAiAE33oYbQHiEMGNMvGOLe2BLfS1an9mw4qDCcNIQ/zCYYeli1+yX/XiUL3S9psb
         y1Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwHHuT5GTcV+BcnHMw0eMbphE2t6VZsr78t0iYdxEZnLEY11r9nfFAiFG6mDgOVySLfzALSsUU=@vger.kernel.org
X-Gm-Message-State: AFuF++mks2zIgVXRusmqgXQbsyELb8B+0OgwZo8xIgF8t6oda/nb9Lim
	sIpyodSxR/zgI5ECT4KzavWn8c62Xq1uaFop7O2/qW7G2JQPdolJ/KQK
X-Gm-Gg: AYBFou1lIaN42ZkaQb/iF3FE32biAeF74v45RyehUgveGUX4XjgVylhrD962pAalyRf
	HzgiPv6zpFic0IFn776LYMGbqitmWXcEPAe6WqcjIzWvLIOi68eMQdZDYxlMjoJZ6WZKzpIaMOR
	VpXk+WgLbZoIvf4N1Imkbxz6xgpgKpo1ILQ1TDI2POQO2C2rQwB3H3h8MBQJuhfOSnAAuZ2c0AY
	TMmmahF9uBuWSEsd05wwSxh3zuWzOUqiMNmTBQKU1zkkz4anT53mGX+yl8PILwXxDHK2bu+Q6m3
	K2MSKY0yAjHwVWTXAeF7A4Xpehf2VRBnElP6ymQf2jY4qkQtVaOWpGw2Zf1paCT1anx1NX3vDga
	FTsLJUsZ4xrV7haY36JbEJ7WfPv4NokNa04QgTKsGvwfW3g7M0Zgi4oXw/fwD/5vfd7y45pUy/E
	VW9bAGTktP3ng8+mZEUV9ZUv+dk7uzTSuM8vke9eT53BFBoGTckg1x2UptOi0tCJ/qXBJ2zGrdE
	OVyrVIOqduVVehsG2G96ESsbU13I/q9SZSVlBzE03cpnaUxhyJPSfexdsMTf36IbnXvYyG7jPo/
X-Received: by 2002:a17:90b:4c02:b0:39e:2036:8243 with SMTP id 98e67ed59e1d1-39e54eb71f7mr11635098a91.25.1789889727412;
        Sun, 20 Sep 2026 00:35:27 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm8015194a91.11.2026.09.20.00.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:35:25 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH 1/1] KEYS: Account for asymmetric key payload data in the quota
Date: Sun, 20 Sep 2026 15:35:15 +0800
Message-ID: <20260920073515.64399-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6abaef5a35f2eb9d551a16817df12f786346b7c6.1789801335.git.xuyuqiabc@gmail.com>
References: <6abaef5a35f2eb9d551a16817df12f786346b7c6.1789801335.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Thanks for the review.

Sashiko reported the following findings on the patchset page; they have
not been posted to lore.  I looked at both against the tree; the
mechanism they describe is real, but it is not reachable by an
unprivileged user with the default quota, and the root case is not a
privilege boundary.  Details inline below.

The tree is crypto-2.6.git master at 10396a2d6d41; line numbers below are
for that revision plus this patch.

> 1) Does this code overflow key->quotalen if pub->keylen is large? While
>    prep->quotalen is a size_t, the internal key->quotalen field is an
>    unsigned short with a 16-bit limit of 65,535 bytes. If a user adds an
>    oversized asymmetric key and the quota capacity check passes (for
>    example, for the root user, or if kernel.keys.maxbytes is raised),
>    key->quotalen will silently overflow and truncate the length. When the
>    key is later destroyed in key_put(), user->qnbytes is decremented by the
>    truncated amount, permanently leaking the remainder.

The types are as stated: key->quotalen is unsigned short
(include/linux/key.h:216), prep->quotalen is size_t
(include/linux/key-type.h:37), and key_payload_reserve() computes
"int delta = (int)datalen - key->datalen" and then does
"key->quotalen += delta" (security/keys/key.c:376 and :396), so a charge
above USHRT_MAX would indeed truncate.  So the truncation is mechanically
correct.

It is not reachable by an unprivileged user, though.  key_payload_reserve()
checks the quota and returns -EDQUOT (key.c:392) *before* it touches
key->quotalen:

	security/keys/key.c:389
	if (delta > 0 &&
	    (key->user->qnbytes + delta > maxbytes || ...))
		ret = -EDQUOT;
	else {
		key->user->qnbytes += delta;
		key->quotalen += delta;
	}

For a non-root user maxbytes is key_quota_maxbytes = 20000
(security/keys/key.c:29).  The reserved amount for a single key cannot
exceed that: key_alloc() already charged desclen + 1 + def_datalen and set
key->quotalen to it (key.c:248, :272, :292), and the key_payload_reserve()
delta is bounded by the remaining quota (maxbytes - qnbytes).  After a
successful reserve the key's share of qnbytes is desclen + 1 +
prep->quotalen and it equals key->quotalen, so it is <= 20000 < USHRT_MAX.
The overflow value can never be committed; add_key() just fails with
-EDQUOT first.  In our testing, userspace sees errno 122 (EDQUOT) from
add_key() of a roughly 65000-byte PKCS#8 key, with no charge ever recorded
above 20000.

The root / raised-maxbytes case is also not a security boundary:

  - /proc/sys/kernel/keys/maxbytes is mode 0644 (security/keys/sysctl.c:26),
    i.e. only root can raise it, so "if maxbytes is raised" is itself a
    privileged action; root is not the boundary we are protecting.
  - Root does not need to raise that sysctl to pass the quota check.
    key_payload_reserve() selects maxbytes with
    uid_eq(key->user->uid, GLOBAL_ROOT_UID) (key.c:383), so the global
    root already uses key_quota_root_maxbytes = 25000000 (key.c:27).
    A user-namespace root is not GLOBAL_ROOT_UID and still uses
    key_quota_maxbytes = 20000.
  - asn1_ber_decoder() rejects a DER blob with datalen > 65535
    (lib/asn1_decoder.c:197, -EMSGSIZE), so a single key cannot grow
    without bound.  sizeof(*pub) + keylen can still exceed USHRT_MAX
    for a large but legal blob, so root (or a raised maxbytes) can hit
    the truncation.
  - The direction of the error is an over-charge, not a bypass.  qnbytes is
    credited with the full delta but debited with the truncated quotalen at
    key_put() (key.c:659), so the remainder simply stays charged against the
    same user, who hits EDQUOT sooner.  It cannot let anyone retain more than
    the accounted quota, and it does not weaken the check that protects
    unprivileged users.

> 2) Can this dynamically calculated payload size also overflow the 16-bit
>    limit of key->quotalen?

Same reasoning for the X.509 side.  The new expression is a sum over the
objects the payload actually retains (public key, parameters, signature,
authority key IDs and key IDs), and each is bounded by the same 65535-byte
DER limit.  For a non-root key the whole sum must satisfy the 20000-byte
quota check before key->quotalen is updated, so it cannot exceed USHRT_MAX
either.  As above, only root (or a root raising the sysctl) can get a single
key's charge past 65535, and the result is a self-inflicted quota
over-charge rather than any kind of bypass.

So we don't see a security issue here and would keep v1 as is.

That said, if you would prefer the byte accounting to stay self-consistent
even for root or a raised maxbytes, it could be handled by a small separate
hardening, e.g. having key_payload_reserve() reject a reservation larger
than USHRT_MAX (or widening key->quotalen to unsigned int).  I left that out
of this patch on purpose: it changes core quota semantics beyond the
reported bug and is not needed to close the unprivileged quota-accounting
bypass this series fixes.  Happy to send it as a follow-up if the
maintainers want it.

Thanks,
Yuqi Xu
