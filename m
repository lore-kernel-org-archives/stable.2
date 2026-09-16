Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAE2E6CA6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541468; cv=pass; b=j6BBHLrsT3ZNSO6ht4BE7Z0P0/p5szReLPQIyHKs6IbuPS6DphYATG5OJk8QzsgqAaB3adUGEkUsdsrzFM8OKRABoY1HeHRr/KB9ZMkwSTDKXyvttItchQiW9NN+cnCoxroL4xMEmzYlBzWovFmqbFZHnKlnCKZw/La5IvC2Vq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541468; c=relaxed/simple;
	bh=7fmSOz7iXB5a8XLL2bezW2+ceV14IeadbCUEVSxZg+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTHZ/4nQ0R/SNtx3bOkyz8tlx0y1Re6B733e9JE5AsyA5xVorPrxPtQj8duH8CfaxxgTtv6UH9OLhD8Wa5LrsCV/rqSSZ/uNC8rfp7HT1MognR4Bt8KLl4pI7lgkKamoKPK4tt9BN5exe9NVEiiKZFt7bgYiXaqdoEiDu3I+gL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9cHJTSN; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9cHJTSN"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so3690085e9.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789541464; cv=none;
        d=google.com; s=arc-20260327;
        b=rxwtxjSWOPYryBwSvcSlgIZP2nPnXVi7d+oDAapk4Me0CUsqMrgATXe9T5twOgDJ9K
         f8yXewm/giKqMpMMzgEaLZ15IeYoETjKJzsABo7lcVl1oA2AEp/N/Hz9RPs06akJiudU
         pIH1wmYffM5lN3XaycWNR2F/cbrqF3kXACbHQgjXaK4lmOmVin7BP8l4D4j2Juu9qRsK
         Im62DA5ogvuejgztUxCmLFU3n6WY9wipEi+yqx6FIR1EBsaz4RnFSfcMWe6YmkN75rJS
         A9t9aYavQdR9h6GuaqbQ6JiW3IeXyXI3/WHaJG2vIl0LHbaWfEZIjc1jbkAOE2nN32fM
         zTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        fh=EkwjjH4eCmCBDDR7DC3JS2vrjMr97u1RCh5pXox+xcE=;
        b=nnLeHHerY5/CwGYlivTNa406bbmjXKz2gsmmRQ7DEGAVWjXtz8hs+qk+UpjbNO34Kw
         03G1bbD+mC6C8/+m0mftIl76qApBGJbg3OGrBvVUKrqXGuGPgP+qBo+Df+OW0IF20M40
         sJ3BG78nqNbMp+00pHxsRUrmRb2SIX5L9eo4iYKApjVarDlD2tISwxEL659Hd0f1ltCI
         eJ+k5rYMUEkrAcAy1E2pvAssMabGABKOGfiXiRoRDjOc+a5eMYihLqZZIg0Sw6+xAN3z
         V7mtVXOc96FgACFDmFsQcGOwlhVVsMbpepnD0Lork0YN184moqdjrtTmR0W0WZWeTdl1
         mqJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541464; x=1790146264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        b=l9cHJTSNnz4yD3VVv9yB/tSPXPnvxKtcTJkdZl8eITTDh615Fu53MHlCz3J9j2+AAp
         bc8ZKVSJ9ABh4PKjPsYLvTBttfnVQX1xuIqlWbKUCbnricvPVj2LHabVWNF6gtkL3cdx
         GgfLhOwNkQczqVMZmrrckqKnd4gcuN7EBe3Qpq0vXbWHnRuqxSEN+WE9QVFwBt2+oAJ8
         aL+TFeERcAVvvcu0GKewCyQp49d4hc+D7I9qalh05NP1S2DZ2+0CLUCZATDNTLF6ofJy
         Pu1t3wS8AeYrjeke7OxwCohhdwYWwR+CRDA/Fqu3OjzqSB93+P8RWMwTKsRBNbdXWWUt
         Hpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541464; x=1790146264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        b=YWFz42VugqcMEVN/I1SXdYKkc/mhHwBPEpA8OTOThbt0q43kJIaPvOhI9MMJ7RwIWU
         5vk75MBrQoEfUdHs5joIGW04Ed5yKWz2VfHZwNbiTNVFrxqlpc5VTUuHAnuTTJeGBCz1
         hfR4VoqTQHN7v2JegvNgfPw95ryuFF7Yfo8qHhtHKs3OCqb6LxvVVyQSU2gesVop61Yf
         Jk9bx3Jc7PIgmismufvz8zsNSkQvufWOGL0vOXMJKbwJb6fMVdjnD90s369y9aZ94ngK
         mZmOKoBxRPW1gZe4djxdO2dayYxhvtaT5t6TsekOYJ6kUkdU7VDlWIpMu8WiDYlLkfpt
         Lw2g==
X-Gm-Message-State: AFuF++nUw3d5Yu2tmxguy0AmtMJEMQSC+AiB9MyrnYIiRzftFYv3o8k8
	GBnOh+ohFKjto8WTL2ufdbv6m4my7oLEEU1Cwcq0njVq0rJacrnUecf6vhYIvNEzhRcegJyKr98
	p2GEqkDs6VikYnWvCrvKskQstP9TP1KS7O8bpE9g=
X-Gm-Gg: AYBFou23KHpFf6wvJYU1qEVU++A+jgZD1wQnsngx33SOto6bNxVEZt7n7ACibuWDJbn
	klbLsDsBVlDq/dav51JQHJUY4YYPlomMlc5EmgXDo1SaooyYQUUBpESsV5qhlswphXwepa0rVjY
	z0AThVvON5qs2+EAorvNTvq6zH3eoJcQG2RswSbDjHpTtz0uZ3DFM9vEHHm4jRthesoIbhZlY9H
	0Ho1bCzACE5t6WFEZbLZ8HNJuKhRGVXPVXkytOvjIS1sQ/LEXbKXeaZXh+a1FBK28SnwzlRFt2c
	9boy8AAz86cAM/paBMYjJ75oF8lTiKj+9FbGKdjW8OChslQGEIpn+ofiRDehxfkR8nJ1SMp+Dga
	adLAb4NIMan+FKQ==
X-Received: by 2002:a05:600c:4505:b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49eb7346118mr12408175e9.32.1789541463728; Tue, 15 Sep 2026
 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041409.106926-1-sj@kernel.org>
In-Reply-To: <20260916041409.106926-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 16 Sep 2026 14:50:52 +0800
X-Gm-Features: AcwNN1VhHl9-ceP5c4iG_sWBNprIthUHetKIW-a6tK-i7YoEH8Zpfkg8hmrI5R0
Message-ID: <CAN_Opa-Cb2TG0C1bZix7LqFk_LH-0qgNgkj8GU4kUE2FwtA7mQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:14=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> DAMOS could unexpectedly stop working when a user disables quota using
> the online parameters commit feature.  Fix it by correcting a wrong
> quota unset check in damos_adjust_quota().
>
> DAMON users could disable all quotas by unsetting time and size quotas,
> and removing all quota goals.  The intention of disabling quotas would
> be making DAMOS run at full speed.  When such quota disabled setup is
> detected, damos_adjust_quota() skips all its work.  The skipped works
> include effective size quota (damos_quota->esz) updates and charged
> quota amount (damos_quota->charged_sz) resets.  The intention is to
> avoid doing unnecessary work when quotas are disabled.
>
> However, users could do the setup while effective size quota is
> non-zero, by doing the disabling with the online DAMON parameters commit
> feature.  In this case, because the effective size quota exists, DAMOS
> will keep working with the quota until it is fully charged.  After the
> effective quota is fully charged, the charged quota amount
> (damos_quota->charged_sz) cannot be reset because damos_adjust_quota()
> skips it.  Then, DAMOS stops working until the quota is newly set or
> DAMON is entirely restarted.
>
> The problem happens because damos_adjust_quota() assumes the user setup
> for disabling quota immediately disabled it.  In reality, the quota is
> still working until the effective size quota is also updated to zero.
> Other logic for catching that uses damos_quota_is_set(), which
> understands the fact and therefore checks the effective size quota in
> addition to the user setup.  Fix the issue by using damos_quota_is_set()
> in damos_adjust_quota() to determine if its works should be skipped.
>
> The user impact is a non-deterministic and unexpected DAMOS stop
> behavior.  That is, users would disable quotas using the online
> parameters commit feature, expecting DAMOS will run at full speed.
> However, depending on the timing, the setup can be updated while the
> effective size quota is non-zero.  Due to the above mentioned internal
> mechanism, DAMOS stops working instead of running at full speed.  It is
> unexpected behavior.  It is also non-deterministic because sometimes the
> setup is done when the effective size quota is zero, depending on the
> timing.  It doesn't cause critical issues like crashes or leaks.  Users
> can simply set a reasonable quota again, or restart DAMON.  But
> definitely it is an unexpected and non-deterministic behavior that makes
> it difficult to reliably use.  Also investigating the root cause of the
> behavior would be quite difficult.
>
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Thanks, SJ. The commit message captures the full lifecycle precisely.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

> ---
> Changes from RFC
> - RFC: https://lore.kernel.org/20260912200814.145612-5-sj@kernel.org
> - Split out from the cleanup series for taking hotfix path.
> - Describe the real issue.
>
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e0414d2adcb41..89390897a0d8e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3330,7 +3330,7 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>         unsigned long cumulated_sz, cached_esz;
>         unsigned int score, max_score =3D 0;
>
> -       if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> +       if (!damos_quota_is_set(quota))
>                 return;
>
>         /* First charge window */
>
> base-commit: 191c4a84eef1db85cc7e1a853761e8ce8683afd4
> --
> 2.47.3
