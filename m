Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E832AAB3;
	Fri, 24 Jul 2026 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884480; cv=none; b=X6B6GxD1Vx4Jl94e2+BkRnUD5qsvLo1WiGfpeo/IbfvXBxfCeVGzpVWrmsUF4ZFm9zJnDfJZ7gR8+lzFLhrtOBxoryP1sZn7jiK9UcveZha4dLwRAzWRBynv3LgQ8bC88iy3m+u5QnzkAnFLL2JnSuEaosLAVB+xkol5vCxBzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884480; c=relaxed/simple;
	bh=+sSEvmrB7sIbUvIys9q7k2lXimwezPuz6BcqJq94yXs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=t+iuF4HjFZcY8OHL+dw6W18lm5FeAxtHrAniP4eRGnVEKuElxn572GdKt7l5VG9WCiSOOXJ4kUAxgAHp90lkWW3AGhMW5uY1Ly3x0eGj6hg3L+jcUXFjjTkN7Kvgka27eBZV28uHQVhcsqRdctg6tqC4DCmr1TjggtbiUEMCPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 27EDD2698C0;
	Fri, 24 Jul 2026 11:14:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id g_ZBn1QBkE1U; Fri, 24 Jul 2026 11:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 933E02698C1;
	Fri, 24 Jul 2026 11:14:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dwFqY_7lNOrD; Fri, 24 Jul 2026 11:14:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6D6092698C0;
	Fri, 24 Jul 2026 11:14:27 +0200 (CEST)
Date: Fri, 24 Jul 2026 11:14:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Message-ID: <699752101.3017.1784884467138.JavaMail.zimbra@nod.at>
In-Reply-To: <20260724074327.73582-1-security@auditcode.ai>
References: <20260724074327.73582-1-security@auditcode.ai>
Subject: Re: [PATCH] ubifs: fix out-of-bounds read in signature length check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF152 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: fix out-of-bounds read in signature length check
Thread-Index: nlmEpwFRuXKq6ooMPkH0R8BSJLkErw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Ibrahim Hashimov" <security@auditcode.ai>
> An: "richard" <richard@nod.at>
> CC: "chengzhihao1" <chengzhihao1@huawei.com>, "Sascha Hauer" <s.hauer@pen=
gutronix.de>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel=
.org>, "stable" <stable@vger.kernel.org>
> Gesendet: Freitag, 24. Juli 2026 09:43:27
> Betreff: [PATCH] ubifs: fix out-of-bounds read in signature length check

> ubifs_sb_verify_signature() bounds the on-disk ubifs_sig_node->len field
> before handing the signature payload to verify_pkcs7_signature(), but the
> check has the wrong sign:
>=20
>=09if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_nod=
e))
>=20
> The signature bytes start sizeof(struct ubifs_sig_node) (UBIFS_SIG_NODE_S=
Z,
> 64 bytes) into the node, so the payload is at most
>=20
>=09snod->len - sizeof(struct ubifs_sig_node)
>=20
> bytes long. Adding the header size instead of subtracting it accepts a
> declared length up to 2 * UBIFS_SIG_NODE_SZ larger than the node actually
> holds -- past the end of c->sbuf, which is vmalloc(c->leb_size).
> verify_pkcs7_signature() -> pkcs7_parse_message() -> asn1_ber_decoder()
> is then handed that inflated length and reads beyond the allocation while
> walking the DER headers. The node length comes straight from the mounted
> image, so a crafted signed UBIFS image reaches this via
> ubifs_read_superblock() before the signature is cryptographically checked=
.
>=20
> snod->len is guaranteed to be >=3D UBIFS_SIG_NODE_SZ by the node scanner
> (c->ranges[UBIFS_SIG_NODE].min_len =3D=3D UBIFS_SIG_NODE_SZ), so the corr=
ected
> subtraction cannot underflow. Legitimately signed images are unaffected: =
a
> correct superblock never declares a signature longer than the node it is
> embedded in.
>=20
> Fixes: 817aa094842d ("ubifs: support offline signed images")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
> fs/ubifs/auth.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
