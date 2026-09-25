Received: from mail-pz2-f17.google.com (mail-pz2-f17.google.com [74.125.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7C370AE6
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347212; cv=pass; b=WqkFuNIuZ47hteyS6ibjK0E71Hm35DWpNo/Pbja7GRVZYZmemjFw1ovI0BJy8NVY59pZTA/X98OPVw/L23zvDXFnl1whgOPzf9SW2RcZ0cS3z1dR+3yCC57OI5YEJge7QPqa6ClZJZ2YnrAGZYkQph1zsMC1+iFaog+9CkHc198=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347212; c=relaxed/simple;
	bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrhvaH0XZLmoe99UJDP+X6N8MBUrqNTobZ0T5OKVGGw2EwnFytrXG/5J2sAn55EoCCrFMl9rTyp9RMhnPlG2yMZxfzPZ03t5TlUT44R1AKxZnQns+QKn3MSCWP8rt17PEJibgaog99K3uTOiwyarNhbfyrV5e3GQQGApYS6Olbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/7YXNyI; arc=pass smtp.client-ip=74.125.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/7YXNyI"
Received: by mail-pz2-f17.google.com with SMTP id 41be03b00d2f7-cc4c3304784so392501a12.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790347205; cv=none;
        d=google.com; s=arc-20260327;
        b=hm8v2Sp+jbw2F6op79iK2XdkD6WFarAyvIlL2QFHVguN0rJgsqkOjjtHn2Ycf6+IUf
         599Osm4NYpIlPoErXkaj0rDMMt+g78Ipbe1ELkD4fPpXfBcfPFkLT9MhSIuRKXDajmtK
         lw0P503NdWNVDVEwaYpsefsXFlOSfij60mpa+U6VBpn0GthZlBTuiMHOrhU6h+89GHcC
         CWdC8AshN2KqbA2jWA8VyViqCSwjkT4SSC5imJNYGjtwH5b0urHVL8rMlksRFu6c78vK
         ed+sDLdhotetysYc/QF76JpcgxWSpPLhc4Jhu65kEqRJtc+q/qFpWoxpoGJpNvzGOGae
         +oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        fh=aIs6dWup/xQ3Nvy1QkIMVNEDE0agGKdZuKhlWQ85R4k=;
        b=qRX7v1GEW+s9ePaoh85mdneT5ZXvho7ZKH0lliP+1MTyuLrpsQlFaUfw4okKjlWEQo
         Bf/q/vOP2mcT/dh166ZvKp1Hk4BgFq35HdJxtFgkFLbZkd47C6U59vie/yT7995Cz+uI
         rS7jab2un25+PMQEeCbQ5jF3j+byAGiVHFYY0oSRB1rSqTyUlMtzXvQ1DzA4flTxgs87
         EqOOJchIWRIJqbx4rGGgwg5SpCIJKFtesfVjLicxbfrEoj9qQQ9fLIxj2CjnLmxb4d2H
         umeO1u15UaJWSkTzLD70PnCljp7V0fBVpBc1Pu0PgnPgZU7R+l2aK2rXKwCS4V3WbPT2
         ZvAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790347205; x=1790952005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        b=e/7YXNyItBmjCQpXcQxE4wgZGpzoLFg6T4q4XuO/cgfNNXMos8gYZyGrf0Q2Y8yhMs
         4tcN2nY4p5WsZbI2vR1/kSAiktxoT4wmplK4RIH9hAOR3QejI0a5vt4h5cODxQTJr4Zo
         eLMv7xYQ6F15XWI0RRSae0M/CkrR7i2jFN+wqCGQv1I2iAdzieYLgPxW+iEDneCB7n2G
         Bg/fqesT61VC3jPres5oCymCS7wChjK3YvZyxgBualFZeGtBPr0QNSfQ5brhH8ct4ESS
         PVCcnHeE/ALX+96qaELNDTWOX7/KKYckZNQyT3qGD5FuGBW8QwhbTN5wGMII90ZZV1Z9
         z5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790347205; x=1790952005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        b=Xh9urd/AzoTaMwz26GMPVwT/9ANwHgmJ0AEklpJpaUaC+iqE+ZA/vcawCgtSnOTfSm
         oha3zFlhW2Nz7zsYo1BzMphg+hiBUozlhtHvrfeV3CKtBqkx8p0ApRWNwaW/b/sdaK/k
         YN8j6PNwO6oJp3qeD8E1n75jY4X0C9AyEKlqI1xxZ4dM3k86mUAT9jr3xf8it++J8tUg
         JIl7SYtC6JNf8/pqpAtcHG2PUR2g625TtBz2ugJ1m8lrgOPadcbEx76pHKiJlrvRx76Y
         b1xmOTh/lP9cQq5oZDSanj80oFhV8vksQLJ+rY9Mv13p19tLGsg+zPERKaEszojLGS0G
         U5gQ==
X-Forwarded-Encrypted: i=1; AKwUvBwh1iqZqwYT1THHumGgDXPYg/lQWTtvwSRG5QRA5SDs/PsOF0dmWeMQtreNCgAOsUYcJUCaK5g=@vger.kernel.org
X-Gm-Message-State: AFuF++nnoOKowBETADuuygdT0nSVALdUO8hnqg5Bl3e3918Y8u2xHth6
	go+RJLj+PFr1hwM6X9CAK2WVP+zg4eNl1x7sEKLgR5CbHt32EGaXXpEySPw+zTavjCZTxwFXo4d
	zoux+5x9qlxtwa9PBibbDFLC8t5RVj1f8UJ+/IKs=
X-Gm-Gg: AYBFou0CQ240YtfDlDQIfYTViXYNL6g6j9jhfmrYB4SxQTXnDkxG/K098zF2HHhKW26
	I5FHq/QdfHmcU9tMQloif0/3hoNuZHVtZJhCz9eGZSmBpzspCvcwbeKyst6BEo03W4MlogLY6Wh
	jUkNchJEgrjElLd7rNhhMh7duW9P7K6EY5LJn2QUI7p48pJLWdMTRz03p6Ncf514LGJZ+6oWhom
	vUIBcz/Kl7m6UGDsU87YHjB4b0QtTu7IazTIxjJJwBJQ4FODIuF9Lo7lcJ31IQSH+liuxU6Ozag
	dw1uDv9I0EmB5e2tXuY94HiV8Y8lq0PG71f9dQj04MFHLWajH2Nm4VaWPs1YogEKZ7WMeoeJZOZ
	qIgQcHm02br0zoSXhjXzhCqRSUqLEV6NJOP+vSh2SOM7HGym00u4izw==
X-Received: by 2002:a05:6a20:6a08:b0:3dd:a197:cf20 with SMTP id
 adf61e73a8af0-3de0e8e72a2mr5267114637.68.1790347204371; Fri, 25 Sep 2026
 07:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
In-Reply-To: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 25 Sep 2026 10:39:51 -0400
X-Gm-Features: AclHuK8gVZp62vkthgFM_M7aNDmllGSluoXwPOdoWj0sX3mgmB8hyAR2Qnd4sf0
Message-ID: <CADvbK_dV9M3RhnXvoBzd5rfNPcYGy4F=DHUo_dBZzrBw0MGrbw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key when
 no mask supplied
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, sashiko-bot@kernel.org, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:18=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> removed the unconditional memset of the erspan_metadata mask in
> fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
> encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
> (v2), then matches every ERSPAN packet's values instead of exact-matching=
.
>
> Default the match fields on the no-mask path the same way the with-mask
> branches default them: v1 index to 0xff, v2 dir and hwid to their
> exact-match masks. The union cannot just be memset to 0xff -- that would
> re-mask the overlapping timestamp/sgt bytes of the v2 header that the
> commit deliberately left to 0.
>
> A mask and a key that declare different ERSPAN versions describe differen=
t
> union layouts, so the mask would silently wildcard the key's matched
> fields. Reject that combination. Have fl_set_erspan_opt() report the
> parsed key's version back through a u8 pointer so the mask pass uses it
> without re-reading the union.
>
> This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> validate mask pointer after nla_next()").
>
> Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> match mask is zero (wildcard) instead of exact for the supplied fields.
> For the mismatch case, pair a v1 key with a v2 mask (or vice versa) and
> observe the request is accepted with a mask of the other version.
>
> Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026082602512=
3.62758-1-ljp1205831794@gmail.com
> Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794=
@gmail.com/
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/netdev/179003833955.2160803.107768171639185=
8800@kernel.org/
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
