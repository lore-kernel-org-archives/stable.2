Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AA3B9D93;
	Tue,  8 Sep 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900590; cv=none; b=u8rRmJnTSASPEuKu4dIT0wFCcp8neOWz6Zz5jJcg1HyTtLk/sXSZRyGykV8gO//A0u635nsorn4sEwmF+RVke8vnHtKWRLCsB+mMqbhjlaF2pHZtXqJbasFqUwsq8gt4ZZW/Fo2hdsQt9oMoymPXnBsxKvRhyZVRITH0myoDVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900590; c=relaxed/simple;
	bh=OvFr4E1Y9r7q5+KUEUgII1NFhkUWJP7l92/BoYkLsas=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuNjPHybaLP8HhaeJrlAtNpSBjMsrwZvHUDPM3t8cgR+BH9dyplejlJAszAn8LCSeyzkaNV4ykd5CEe4o712d7vtDTY5Vl6DbTSICVX5UWBTMIlE9KtCCqXpVj8z3U8Gz1HAOOolLaAcSxPinc3HaM/31puhjN2tKp/P+QiBeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHVzwr0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHVzwr0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5356F1F00A3A;
	Tue,  8 Sep 2026 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900589;
	bh=6NMclM/shf5i5k4E0D1d9WEi12zMVmQmyHEmBEmdwDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fHVzwr0Oej2P9VkRH8C6ztPNHK2+Aw0c5tYAl1x6ihdj6VgPGizukKai+/n0/FEsD
	 OFKifqw6heUoS78Qlpxgle+tlNwWTWxkxvYZEf8FGb3M7mRCnta9zB2Qr7sml1201q
	 TVy0dP/QFMCMM5qamiCnG1fD7TvR5yx3t1zQm8jVMKn/j2fTSxvuCWmtHmIuoJmuw1
	 MPrV6wlNnG/+uoUHZ0PUboe24VHEdKP+RbJrpbxkCEel0Vevn+5xp6iMRPin1he++a
	 8lxIp4N0h8tieHOpUURMCIquD/fY+sEZOSH5VRHFjswcEUiKojYPbPTr+D9NAfy+4M
	 1kGW451mFpLpQ==
Subject: Re: [PATCH net v9 11/14] afs: Fix creation of RxGK CM channel token
 to have right size
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:47 +0000
Message-ID: <178890058789.219967.10564231796121366711@kernel.org>
In-Reply-To: <20260907113743.1453210-12-dhowells@redhat.com>
References: <20260907113743.1453210-12-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] Changelog of the stable-tagged fix does not state the user-
  visible symptom of the off-by-4 `toksize` in afs_create_yfs_cm_token()…

Pre-existing issues:
- [Low] afs_create_yfs_cm_token() keeps a hand-maintained field-by-field
  size expression (`toksize`, fs/afs/cm_security.c:238) whose only guard…

--

afs: Fix creation of RxGK CM channel token to have right size

This corrects the token size arithmetic in afs_create_yfs_cm_token() by
adding the missing 4 bytes for the RXGK_Level field.  The size feeds the
encrypted token container and the appdata buffer published as
server->cm_rxgk_appdata.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index 103168c70dd4d..5eeeef761cf31 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c
> @@ -235,7 +235,7 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
>  	 *	struct RXGK_AuthName	identities<>;
>  	 * };
>  	 */
> -	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
> +	toksize = keysize + 4 + 8 + 4 + 4 + 8 + xdr_len_object(authsize);

[Severity: Low]
Could the changelog say what the observable symptom of the old arithmetic
was?  The field count matches what I see written after the K0 blob in
afs_create_yfs_cm_token():

	level(4) + starttime(8) + lifetime(4) + bytelife(4) +
	expirationtime(8) + identities.count(4) + kind(4) +
	data.len(4) + uuid(16) + display.len(4) = 60

and the pre-patch expression accounted for 56, so the arithmetic fix looks
right.

What is not stated is where the missing 4 bytes went.  toksize is passed as
data_len to crypto_krb5_encrypt(), and the rfc3961 encrypt profile places
the checksum at conf_len + data_len:

crypto/krb5/rfc3961_simplified.c:krb5_aead_encrypt() {
	...
	base_len	= krb5->conf_len + data_len;
	...
	cksum_offset	= secure_len;
	if (WARN_ON(cksum_offset + krb5->cksum_len > sg_len))
		return -EFAULT;
	...
}

So with the short toksize, the trailing word written here:

	*xdr++ = htonl(0);			/* token.identities[0].display.len */

sat outside the encrypted region and was then overwritten by the first
4 bytes of the HMAC, producing a truncated/malformed RXGK_Token in the
callback-channel appdata.  Since the token key enctype is fixed to
AES128-CTS-HMAC-SHA1-96 (cksum_len 12), the extra bytes stayed inside the
kzalloc'd buffer, so there was no out-of-bounds access.

Would it help stable backporters to state that this was a silent
protocol-encoding defect with no memory-safety impact and no kernel log
message?

[Severity: Low]
This isn't a bug introduced by this patch, but while the toksize term is
being corrected, is the existing size self-check in
afs_create_yfs_cm_token() able to detect this class of error at all?

Just before the check, the write cursor is thrown away and recomputed from
encsize:

	xdr = encbase + xdr_round_up(encsize);

	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
		pr_err("Appdata size incorrect %lx != %zx\n",
		       (unsigned long)xdr - (unsigned long)appdata, adatasize);

encsize comes from crypto_krb5_how_much_buffer(..., toksize, &offset) and
adatasize is derived from contsize, which is derived from encsize, so both
operands move together with any error in toksize.  That is presumably why
the check stayed balanced with the pre-patch 4-byte-short token and nothing
was logged.

The check is also non-fatal: execution falls through to

	sg_init_one(&sg, encbase, encsize);
	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);

and then to publication into server->cm_rxgk_appdata.

Would comparing the post-write cursor against encbase + offset + toksize
and failing be preferable, in the style of the decoder counterpart?

net/rxrpc/rxgk_app.c:rxgk_yfs_decode_ticket() {
	...
	if (WARN_ON((unsigned long)q != (unsigned long)ticket)) {
		ret = -EIO;
		goto error;
	}
	...
}

As it stands, a future field addition or reordering in the token can
silently regenerate the same malformed-token result.  I could not find a
way to overflow the buffer today: keysize (4 + xdr_len_object(key_len))
exactly matches the three K0 writes, and every other emitted field is a
compile-time constant, so this is a hardening observation rather than a
live defect.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
