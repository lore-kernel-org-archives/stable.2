Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072C3AAF42
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416211; cv=pass; b=NZIiy4ACBiueFlBRIQvEcEILBdbJ6303MoBJPh8JlhKklYtQI19i66VY11iFycujSNHwcshsaAMbvRaglVtwvJdYizz9gh+ewvnet9bjF3ZODXpmSc5/wFvKbBc/ZrJg7nz11/SGNwIqDG6BT20Y3NSpL2enkcivwCzTTaaOqEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416211; c=relaxed/simple;
	bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBH5PwtfHnm26QxxzLbD55tLAxZpnCeQ4LtUvvIuopJU0YOlTfTtOjLwcnhgmzMLTk5m1HfMHCpkhBDwD6Zh3tQ+qF27niSrbqw3FlNGhkUq5ktV/UWrtEqEriWHgFcDuv6M7yQC+ajIH9lbR+a0z7wILjpkCpsWo58omxcGjnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=p9X9b3aN; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="p9X9b3aN"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so1764157c88.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 02:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790416209; cv=none;
        d=google.com; s=arc-20260327;
        b=BzIyT9IkXKhPVFeSJWQXJTI+ANyVauOfw8U+KafP+cJBwHTtdxIhl1010eP53DbQZM
         vlqlsp4fFqBeF7fsY/KDIQWHzz0AB6t4KGaNzfPpd6zq87U70Ga1CZxuBoOhd+wfhRGH
         gVABV+bO9Vj/DmQH/Bc/ccXz4L+vm5Q5geghEBRoN+OKPKYy+4w1uteCbDKq7xafGub7
         RzXud3yXPN3nOWyCzGngm9Jr6VTh32wzeIzs61vsJbjqN9/nwmc2fCWYPX0yRwz3KrQw
         Jzeil6C0dHsXuNn7cKDE4fO9v8u+fFdu8RhHF1aJkGNVWOXBXSeC3aCO4HKd60Dco5XN
         CRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        fh=e6UZVbMMCm7ClDBTyDSJqHV1OAo6SWrJroC/2TpNU0I=;
        b=T26NpHGtSDEtYkYNXXHPsjv6aurJN9Z9YG52QJ6qK6h672g9t0Eu848PMqihGYuHa9
         F4PXamE9IysTnqxLtJULSbyAFGpsb2KL//5ClKvus5v+syi/4cUwWTSfG9u8tlnSuLJ7
         h27bCMo3KPpp5S00svP28E7QTRXnGbs9EQcFVTZhL46odxXiwMhbD+zSOFqr0aBWHyt/
         FYWla9TXQz3n4BJZZBrLTX/Q/VovcuMH8ePVZyJQ15zv2/KQpsYmN9Ost3XDz5012t4C
         k/Ks0FI0q9GBrpbrFTPLsanfK5//rIp6NuX/g+0/PkOW7hhr9LdLgd4yuFVR+6rpUHbX
         LBhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790416209; x=1791021009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        b=p9X9b3aNNEFn5qcFJpr8zmwBjhE9Oaud+fByNZC1d5zF8OLR2IMpXGum+OJjOyKSUV
         /fRPte+dZ+xqTSc/jpVeLVW5/B5DHxQWqAvWN/eHx8FbeNt7/kdW4cYVzaon0ys+2xzn
         fLuRrciK3MW9AQsMypQGlGhJzAWBJkyuyIolA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416209; x=1791021009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        b=HC+IVZ4Jbda1ceukXXdhrZtud5SyYJS+/vgzQORU6CmdQ/he3HsYC8uEFfg5+3r4vp
         VB1TLcZmGkyY4O7DEFDaAaHdUo2s49Y5J6RsQ3vDBTxbjT5RfdAMVml2kv4BylEf1cjk
         KzJziIGufghXNlWpqP9tObPV0Sv3kE3I/uHGG9vp7s0xIeF3E2gsS2i6I3s7WW+sOpKV
         rW6pF0uRjmcGz1FGQqI0uARxe6WjWM15E0lYGrox7Zx3Nxdh74A2lCNEgaAGWOiZo00t
         PxivZTy9owgckjaUsHX3hbiL3gU+tVa2jo+hv176hsx2S0q8AqKYURBi2gFtCmpxMD10
         xZbg==
X-Forwarded-Encrypted: i=1; AKwUvBwcePdtSLsDYCi4oya9rhIlDye8fUHvuApw4aFz7lc9fVnZUxnEESS4IZnnoH1Tn7YRxdrTECc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPdTwEsBY588XiMH1jPgQdArpnCSsIILNwZ84cX0BBTLbPbLwW
	/uwdFgmr7FA4URyQ4TCvTgvkGawFPcvJAbXvDDzFZZIQS9Mk5r772JC5z+YntRxrzvvnC7ncIwY
	4gOb0s3k+3tJjSQa3n1UmJmo9G/lFRDgr/uS4Zs8F
X-Gm-Gg: AYBFou1a9E87SKNQ5vhgDRoc6cGpYhaEmoTlNPkpNuABOz22/4P9PlsSThs8JCIWgnx
	n3CjrZcpHZyn6GacyE5WJ35OLdL46kQqeT5QO+BZfPYPAuwFflo1PA/4KUiW10/R2X+jPxMdG/k
	Ko/0YcIpfEewg6Mj9aZG3pqptgqd1ZoI9JgGMAfbWcq5o7JYii9bEc4Fc/qUlxEW58nGJYSTpyN
	s55DAehaLt8jcP5WdXEUvMCnPUUWlzs8YEgfj8xfZuU2D6T19lJ9aLv4VB6wK1RVIKgjgdN9b6p
	Qiz3tozaSGc1LZMhrqoac75HrUaMttJDmR0dEk3JWBiQjDjq3YN1oo1csiJNdM8UQpNIw62ZB7B
	vBZnsOCFeXfeMJPiTEl8lwl4ohKL5Cc3LgBumrTWEsMN0LmA4NRqagzg7JSWqdzbbZBEnyKUgaM
	j7637qOOkXr+u0aQpcWjo=
X-Received: by 2002:a05:7022:29b:b0:13c:ec65:7bca with SMTP id
 a92af1059eb24-146ce680830mr3047598c88.13.1790416209014; Sat, 26 Sep 2026
 02:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com> <20260925171834.73b5b367@kernel.org>
In-Reply-To: <20260925171834.73b5b367@kernel.org>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Sat, 26 Sep 2026 05:49:57 -0400
X-Gm-Features: AclHuK8ozjCUr8GkFMwDP03J3HTQRT-rnIrz6ZgUgaH8T_J6FhqTiPvsXV2w8II
Message-ID: <CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:18=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yielding
Back-end Review & Insight System <hybris@mojatatu.com> wrote:
>
> On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote:
> > Tested-by: hybris <hybris@mojatatu.ai>
>
> Please stop adding these tags, they tell us absolutely nothing.

This says that our _automated_ bot tested and it adds the tag before
we send the patch.
It does more than tdc for a specific patch set (e.g., PoCs for code
paths not reachable via tdc) and it does find issues sometimes before
we send out.
If a human had done the same, wouldn't the protocol be for us to add this t=
ag?

cheers,
jamal
