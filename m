Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792708620;
	b=LwqslCNnO9on9PtcCxmb7ipRjcS02a1duLhVaMxwdF/FdEp6nbbWhvOq1WyIfRi1AC2G
	 btvrzSesC+iN1BYaTNb8sVv3gUbx2tyIzfl0vkUPERxYtpO3xAdPIbDJ5dnupd230HUWT
	 BVhoW6R4u5GJERANXTAc3/zdz+oQUqQKHJogd6UGjOLtwpArUULxxGiRRpgQ6Mb3R3Cal
	 aZH07983+Eud0j4etSo1rVoiYqoE2aq4k+k00+EhEaeoPVVuzvYnTaD0LgRgFn7tXSTCr
	 7rmChkon0Ih04NnYarJJ13Bz4ot5LV1tPyw/PSnWfo2HZ+j9I8ltwCs3YIs1x4Ayasg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MH1HzOWc8xmkfAC3/eYTHqPYJe71FCQa1AkNGEWJ6tQ=;
	b=vmmwPT7TTVnd1ezaOtNZU3z4tQrmN0sF3Vz72GIcHZIqwBQVwHVqQ0n+mA/dDHkCsC2D
	 nXCvNGjGDzjsXv98W84N1sXDc7WbFLH1v4yWiFOKIdok4PIhJoNIp1DNyY585kgFSRdcn
	 0iPf4yAZZK6hnTc86GS/sr+qU3MRPfbM+DVo2RcZ16pAzGKqTI9yxtVI0g1pqJ5/t5qtj
	 gntT29eg+N7dHYbfDMY4H/HMtDN2c08XLnd8D3Kdgr/fAJaf9JFAr6mRPdk3fKno/hPGB
	 tDvvUk51C/LZND4jNVSrXQAbiPe7ErBodjsq/EX6DIHdAfS3TJdWFdzVOPjTV617dVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=NsruxeEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E448606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E448606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=NsruxeEz
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso100618137.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792708618; cv=none;
        d=google.com; s=arc-20260327;
        b=kGYxTggwKGqvPTk0xBHq0TfhHK4F3wwS2wW0+Y0EOZmAiyqI32JoG64DQDCfjQ31P1
         I7/AB5Xe8VdVj9FqZgoEMaZguW0W2KXj6JZE9oS7KFoDlA05VKxLQbIGaAN6nfAMJqLN
         wYSYrfl/+msKz4OUAFYT3b1xwZsnZELE8PetelJrjf2Ft+iqqwWnktPg09mFcp/tj18b
         f7wI/+scGMEPGL/32jS9TNxg/Z/+5V9n0SFtLydBg03h0ZVk98xsRF7wFl0u4QQ3H3As
         qU/KmkmxzPTD8hDw8Cbpj+Kx3UgxiKOeC59QdcmsMs5E972VpEmxqzRp+GXf1cVgZpvx
         cwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MH1HzOWc8xmkfAC3/eYTHqPYJe71FCQa1AkNGEWJ6tQ=;
        fh=vXjlLMe7CGAQAdA37LQjuUpiqw7PhV3NKTni3jgb/Bw=;
        b=o+FFqrAW+O4qsgm6+HZ3djEyv5xh2bEcqUJQoAJAuDkGUCclp2kZuGsix9QFqU93jQ
         RQy7mQESwYM+MhVAHCBUnWClESpX/W1Qug6lARwnBJNmNT3i1D7syw60l3sGE4TOb9sV
         vYgwbuOSHHnxsrGLEdzWEHV+HG4QG2xjKQdvY5EonwAl73xHjEKZHtQGPyZgnNoQ9RZ7
         354fQpS/Ke+m/zwHg8exBQG8oOupIumZkjVe1lwqRTIb7Va6jyC+JdMAcUORcygxP+3s
         e14PK6c7rNYVlIuVx/nJ+H7Yfo4bykgi24b7YAszMbjEOCm0C/kx/ksWyeOv0QTKkkDN
         9gRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792708618; x=1793313418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MH1HzOWc8xmkfAC3/eYTHqPYJe71FCQa1AkNGEWJ6tQ=;
        b=NsruxeEzRlxDlc/Cq/XLpFOHKF6e9b4Ol81RnVTuC4azwcoYJff8QakFO/E+YQISsA
         mpaJsZBNOglprF3P7nX+5PbcMtvRujR6EkPsey+IbejBmtE2ZWEaVBE5icOAa0gCHMq1
         VSZ2K7YSmyfhCla3gOh5b2iw2W/UTKck2VLpq8TRoQPert6/4jOjdL5Zua3+w53Zp8yM
         evI2FiIeOwNK1OdfoHqgwsVMFDaOX9cia6cMYTq19D7tu9g1luMbh6GMP4bsh0Aimj6/
         3mmeIU17zxGuBgUtxqFCbWBkyQBUb0ahmwouw6pGjXutQAG/ienfwm3wykChWz1KcIkx
         91YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708618; x=1793313418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH1HzOWc8xmkfAC3/eYTHqPYJe71FCQa1AkNGEWJ6tQ=;
        b=Mk2g9zORngqslmznY7sGNbjtHoA+u8vKuMQUCW/CkYno16oXh9Gzu61oDLXG5oc3aT
         BK9dChXlzRIU27kJz/Coc5DRaTBjUzGcc7IpcfZDooVBtnS9ugu9gq0IEzNtpsBTscXo
         Ncy18WIALOup6tdNR/YpmG14O/YF/DDuCBM948YLCIpa+fGBriA3x2qVfJ9FsZ1MTwvy
         FjWNnZqjCww7KopbMeDNLoVgDdwxgvCSV/D7521ukiu/EX2+gPLyCffYPS75VocveAmJ
         tRoLNHNSV8WuSpxwm7hyzApg2loBejJL8ZfzImWMiaFK6TwlSlWwfAyCsZSUNWXDnIes
         n4Uw==
X-Forwarded-Encrypted: i=1; AKwUvBykT6nX5wYZSinX5GVKkZmwEn6Rd65yXH1aKB6/PC+07dF91GXQkdOLmc6pA9tUxqgAh5+9uPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFN1WtOasQ4ooQdaaMYQ0oJhCucB5QW/cleEq5DMZNQ+Fk/dEe
	rlwGEsLPV0jQijFgZU8nmW9YaknN+740VcxM3qEh5qgWg9vopjUbGTkdnRINGz0+TtDX/a4ZhMT
	NQ8W0VUtdO6T+hEvkr9dBbLjvBRlmvgEWaEecQKEX8g==
X-Gm-Gg: AYBFou05h1MF2TmSlHt5o/htRspDGri2afmKKgwn7k24NT+edRQVfYhjCcFd308RVjO
	KRpIo4GkuRKFk0w3AstbVrptvRDIb4cytv4U1fa9HSe+dv8uhdZ1IvlYbzQOiVJ6sQeA8Zda9Dy
	KHndaQQO1BpSW/g4nToLDF0ZLt++fK9wynfKyw28qHMcyenzDSQmw5AE0Vd39CEoGCb9zerVuUM
	dh5crB+ZzQXC0nyU8wepbBZC3OKwbIP3YYfzJakC1ljii8e7aCziHlOsr5YQE7g7vZlOcFw+PAZ
	nawbL3CWu1bwyIpdoMokB+FT1RrNUlj85WdYE0nRoNszQuKYWTVxWOyp3K1oiZnwloIqbRSUe2b
	XVqHN5Tw0AWtVKMTeJ8va8tt2eFtiNnrI4RM9PLALBSJ2TW/ARM7V1nyPlorw3XERkX/Ty3WMA+
	X/S4ZJPRzCOGaLqwj+SN0nw2i1V1k1WBIgI9aMnDE8wtItT9VuABlnbyTw/YNc29sYYVHxsxQ7s
	VqT20hvLP0hXmju8aCghskr+w==
X-Received: by 2002:a05:6102:6447:b0:7c3:9464:efaa with SMTP id
 ada2fe7eead31-7ccc300c580mr368655137.2.1792708617978; Thu, 22 Oct 2026
 15:36:57 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019212651.733565-1-rjethwani@purestorage.com> <atiAExld_bpR7sQm@krikkit>
In-Reply-To: <atiAExld_bpR7sQm@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 22 Oct 2026 15:36:47 -0700
X-Gm-Features: AclHuK-hRjTDoTYC3L_MNULYjp_mlORTyN-OWMcxmoOWe4G0to44llKlZ5zfS80
Message-ID: <CAKaoeS39Xtrx3NV+YShnx=tOo5qV6tYkgZiUzQDaDi_Cw3x7-A@mail.gmail.com>
Subject: Re: [PATCH net] tls: device: keep tls_sw_fallback() from encrypting
 its own output
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:04=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-10-19, 15:26:51 -0600, Rishikesh Jethwani wrote:
> > A socket offloaded through a bond has every skb validated twice, once
> > at the master and again at the slave. tls_validate_xmit_skb() passes
> > the master-level call through for that reason (netif_is_bond_master()),
> > but tls_validate_xmit_skb_sw(), the validator tls_device_down()
> > installs, calls tls_sw_fallback() unconditionally, so it encrypts the
> > master-level ciphertext a second time with the same rcd_sn and IV. This
> > cancels the CTR keystream and exposes plaintext on the wire. For a
> > complete record encrypted twice in one skb, the second pass also
> > generates a valid GCM tag, so the peer accepts corrupted data without
> > an authentication failure.
> >
> > Guard on the content rather than the device. Offload plaintext always
> > carries the decrypted bit (tls_push_data() and
> > tls_device_write_space() send with MSG_SENDPAGE_DECRYPTED), so
> > tls_sw_fallback() can pass through any skb without it: such a skb needs
> > no offload encryption. complete_skb() now clears the bit that
> > skb_copy_header() copied from the plaintext original, so the fallback's
> > own output passes through any later validation pass untouched. This
> > also does not rely on every path validating a skb at both the master
> > and the slave.
> >
> > Tested on two hosts back to back over a mlx5 port, the only slave of
> > a bond0 (balance-xor, layer3+4), so each transmit is validated at the
>
> As in another patch, a couple of selftests for "offload over
> bond->NIC" would be good.

Will do. The hw offload test these would go into is still under
review:

https://lore.kernel.org/netdev/20261020181147.939575-2-rjethwani@purestorag=
e.com/

Would you prefer I fold this fix and the bond tests into the next
revision of that series, or wait until it's applied and send v2 of
this patch with the tests on top?

> > master and again at the slave. Run from each host as sender, a TLS 1.2
> > AES-GCM-128 TX socket kept open across an administrative bounce of the
> > slave leaked every later record as plaintext before the fix; after it
> > each record is encrypted exactly once and the kTLS peer reads the
> > stream intact.
>
> The wording and verbosity of this section ("administrative bounce", 3
> lines to say "before it didn't work and now it does" which IMO
> shouldn't even have to be said) needs to be cleaned up. The rest of
> the commit message as well.
>
> > Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device =
goes down and up")
> > Cc: stable@vger.kernel.org # needs commit fc6d80eb5044 ("tcp: prevent c=
ollapsing skbs across boundary in rtx queue")
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> >  net/tls/tls_device_fallback.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index 3b7d0ab2bcf1..24fba12febd1 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -192,6 +192,14 @@ static void complete_skb(struct sk_buff *nskb, str=
uct sk_buff *skb, int headln)
> >       skb->destructor =3D NULL;
> >       skb->sk =3D NULL;
> >
> > +     /* nskb carries ciphertext now, but skb_copy_header() inherited t=
he
> > +      * plaintext original's decrypted bit. Clear it so the bit keeps =
meaning
> > +      * "still-plaintext, needs an encryptor": a requeued nskb would o=
therwise
> > +      * be re-validated and encrypted a second time on any re-entry in=
to
> > +      * tls_sw_fallback().
> > +      */
>
> "nskb is encrypted now" is enough. the rest of this comment (why it
> was set and what the bug would be) really doesn't belong here.
>
> > +     nskb->decrypted =3D 0;
> > +
> >       update_chksum(nskb, headln);
> >
> >       /* sock_efree means skb must gone through skb_orphan_partial() */
> > @@ -371,6 +379,17 @@ static struct sk_buff *tls_sw_fallback(struct sock=
 *sk, struct sk_buff *skb)
> >       s32 sync_size =3D 0;
> >       u64 rcd_sn;
> >
> > +     /* Only skbs carrying the decrypted bit hold plaintext that await=
s
> > +      * offload encryption; anything else needs no work here. That
> > +      * includes this function's own output (complete_skb() clears the
> > +      * bit skb_copy_header() inherited), which is seen again when a s=
kb
> > +      * is validated a second time, e.g. a bond master handing it to a
> > +      * slave via bond_dev_queue_xmit(). fill_sg_in() would map it bac=
k
> > +      * onto its own record by tcp_seq, reusing rcd_sn and IV.
> > +      */
>
> Sorry, I'm not reading all this. 0 or 1 line of comment here, nothing mor=
e.
>
> > +     if (!skb_is_decrypted(skb))
> > +             return skb;
> > +
> >       /* worst case is:
> >        * MAX_SKB_FRAGS in tls_record_info
> >        * MAX_SKB_FRAGS + 1 in SKB head and frags.
> > --
> > 2.50.1
> >
>
> --
> Sabrina
