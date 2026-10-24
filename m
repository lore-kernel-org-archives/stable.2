Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820902;
	b=s0gjacqodv6HIMDu5hvMqtnSKdAkc4gFvRayO1Bi8zz7wDzfwGlDXgoF5ym5neLyJjhx
	 R/rIQs+N6wgFCZXqKeExOb/rzZzh6Fn9piGSG/EWx1sxwvfR4wq0hdV5tcPjQv8gcY4j8
	 Wu9Jcj47J1a6yuL64NSolTYCRv8d/KkFYg7KTKa2D6F7aZFbRLBnwoIqZJih1oa1hxd5g
	 8hW4zLqNJYoFMCEBB4r/qMWILBUR0WGzsoCsB+65dpP45aanriboBhL9a/sWvSr6xSH/W
	 n4xMVsYkEEDEwlQYSmEJbVMF8+qpWu737ujOutoT59FPylRWIOdBC29rcJ+MXVeMviQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
	b=LJTM/m7hA9Q7C7vYxJoRyO5K1bENCLo1W/Kwf/rIngubuOfugjqS6oHqbzNq0jE69p0g
	 WpCbR1JqZycSqVva/oAOQPt8Hri6RLbLM6iUGx6oDFE8Y5h9rDfaProaOxevMoywSAjMJ
	 uXSfafza5M++qu6DE/z/z1iR35sKEU6wD6/u0L65vRGAkGD3i1RXii3gPeRJA1ZH38Q53
	 NVKaHfq3Mt6i8wu/MUSbe6VQtGqI1A7WvBBpsPOkFAggUrZbtKExo6s45EJ7NF/tSYewA
	 FNkJMJtjcMc3AUlOOE2r8x0cR7rXWesTrp3gnulol9rwyWEZbcMw3ycMV/TcYxHWmpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1E606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dc202a60eso741420f8f.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820900; x=1793425700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=eHXQ75jbOsfxPG3i87e1VO0X3uwPAbBy91TM+fOWXtit2BQpXi9n3dTFCKtKvViCf2
         9Uj1tpZjyGw6WXmVGREnAdblX53nevh2tQe3n/LmE2SBvMO5inlY3/Tp3TjtYzCBzhy0
         R6xnpOvuRt56mZrPbYtPR1DZFp5BJOzucSElqaYBf8MnLWnS4A/KSfPEbAdjuyTX/0xM
         z+ke58s5zokAoOJAFlvEtUb4KXCiEnvZFizByPnR4fKsZ4iJRgcuP6RlCv1I74H0f5oL
         BSOUj3ays7QEJTYf6EmD7rPAS983u/xtjFClZtqAGMvJtXFilpeTwfyrf80K7mFcnfPP
         nzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820900; x=1793425700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=1aL2J19oo7tJuFiez8mhPVwKuC18Xrui5cjZNBD96PEQSaGgVP3wkzzc0UYSulJVs/
         gmg9qhwA7Ps0gJVZ3wFRqmcy5tN99zJud+dKPpC+pD5GFMpB67gMbWOI/kv+s2ydvjRi
         1Fxf8Rq5HSmr7DN2O9LGu59uijBny2UgxcX52wRFH0LPAzJ2nyc0u4ZpBm/baU5lJp2I
         NcIEKdCUfHH6TwisHtHZEZARHj0+4m5HjYmxeW+pEKTR6PDc7oNRNYuA+Zmnoz8hbbM8
         L+6s3Aube2nzb5osvx64yZZgT7RgNDpxUxcLjeSSb6Gvp/h+ZDQ4MYoqKegFcFfEr8u8
         DzIA==
X-Forwarded-Encrypted: i=1; AKwUvBxEHY7j9Cspv70XwrgRiSSqO8nWwlmguZ45CZlYuuP3NNoYSWe+n9BEJnvQi/9t8K9hLajkc/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7iWdwkbPIndhf6tCvlqs+qUQdPKd+rRwj4CT6UD5Iu458w6rL
	zcezEQbwARPGcBbfAwN0rlhyt2NSr2v/W4ulGk1tLzzh5a/KiwmtIrwM
X-Gm-Gg: AYBFou1+WIbClJhTmxBB6HFGDaGgfEDvjpE/UUfPRLBsfQz2u3Sobh7Q4d7H0LdQz/V
	2XjYirFphy/Ulaf8/heQdfRd2kICF1hM09Hxq4+VT2eHA22TGFZAcvJr3IF6POjznYb8YC0qdCZ
	IxVL3wdA3RKMZJL5nYvTQ8AuQopAY/COFqT0fbNcdIe6Ms7ns3R9gSkN40PKrFhIlHWc+nOALKQ
	8lOn6q7974/2RakmivyrNE56idagiZe6ABx6AmQ109dlKaGTbZ0iA1DYlIkyblCYPSZbw3Ekr8V
	F2Rme16JsqcljWq+h0/6YtOp4d9WRHcE8L+vT01Cu1vNQ+A2Pv21aQrVhxOKlDqE1Cmt1XOonug
	KNMr9heE3WKhgQk98bpXkDXwi9a+e1CBKAz5tFOA+aHXOjUo+Jb2wbG+IA661sLjKZxk3LoYkOJ
	ccr/pN1580Sb9mz8HAhS8+YoA7zjgHut2xgiH7jnSELjQNv0sP0G2+qTSmWjAhVSt1ezSGz8dfe
	N0h5rPghk/2qKut2Gep7WWV4cDoz2SHw9f5MQRSdCtmvKH/JBQl3R+TPKf78WKG4nVEGaw5m8bF
	HxA=
X-Received: by 2002:a05:600c:1987:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4a35ac3a7b1mr13113545e9.2.1792820899903;
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm30737725e9.12.2026.10.23.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: Re: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:48:18 +0200
Message-ID: <20261024054818.21654-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atsWqqpFptswGQKy@wunner.de>
References: <atsWqqpFptswGQKy@wunner.de>
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

On Fri, Oct 23, 2026 at 10:11:22AM +0200, Lukas Wunner wrote:
> This is x86-specific but drivers/pci/quirks.c is used by all arches.
> It should rather live e.g. in drivers/acpi/x86/utils.c.

Thanks for the review, Lukas. I have moved the quirk to
drivers/acpi/x86/utils.c in v2 (and dropped clearing
adev->wakeup.flags.valid so pci_acpi_setup()/pci_acpi_cleanup() power
dependent tracking remains balanced).

Best regards,
Victor
