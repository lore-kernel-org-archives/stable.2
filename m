Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86094348C4C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760699; cv=pass; b=EFMYI/m9g0T0fAJdAZvDoyAbCg3PVbMbQrl/U+YROpAkGsNTka9HXQycHNg8YZWjYxqzZxuTKM71ZEtWIx2TUdQyZI/s3LaaNM63/Z2ch77R5bi8vWpdJzLcdewbBskE/aa6UbcOAdmJt9NIgkvkJxNMQgbgvJvxmZ49s6zpRxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760699; c=relaxed/simple;
	bh=sSCgviBed8zHf2g3xfsl2lv3eFzl+hoXf/vZ34TkSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzJU0A+FsceY5HLMnBohsk2P/YluizZ1D4h2uSowl+Ozokk/w2IC0PJhPhGhSdXa7XEs8Qu6x8KVscUEZhejhZI3pwR1hCV8M2geh4G69ZYfn+tGBwS2toSxv5lsuRfTTeRGpISoIj2iNXmFx5nMQYm9DBhr9iHTBdLXLj5m52A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=b2d8MHbI; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="b2d8MHbI"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so2425515b3a.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760697; cv=none;
        d=google.com; s=arc-20260327;
        b=AiwfvtN0A4axQJTXy3kJqz6mCA/DJ1pYTs5eEMa/PxG/FGc5FbFg1b8eJ4ui4IgrsP
         rrGnDSnc1cwYAFQZSQWpmroKnJ44g/EoWc1fGb1lOq2QouOjWqQYFkhggF7BCpPD6Znb
         XaFhPoD1+pqr5wPyfQC43wQb/jdB3g2K9MSkvvjCccKHbfaylLQtopJV8Qr22XWfGi9b
         ZiMMYC3kI6lz65hjmyceT9pZbF6JsB32niVZZgTUtiSfrzJZ5ToR6gMMq8uiyZ7wqVoP
         eF1CQ+2m2s4eD9UYxS5QIOsfgM+rqo0na3X8MzlsSKZspexptAgQ76qg1GufK+RlVITL
         gufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        fh=uvzaOsrQDHrlHgI3duDKsrRKdXDoPWiTYkit7rCyNhg=;
        b=eKqvv1vs249ohhzz+x2ninRbqgIgLI3Q7EUHRdiWa/mzK3xW2jR5YVJIjuGrj1TW2D
         MhyXNMehLasfxsdpdBG4iZzB6qXJ2nCZ1bI1GIc09Sd/z3eV0uvFg3sHAJGPik7r1o9L
         kFzWdqFFjGSd3EIYjOOBolZjTKQhUUKQ/Kv4mvTMMsxCuUweugpcDLTYw6SaZGUc+G8L
         MBsXBHRwGFIC4iejxeAZGUOJC2ts0Px2oioOHI4gdGLU2FBeTPAJo6bEC0/kZuYB6SOo
         +HwlwXI2jxiYvDc4scPn5qL8hXu609gEjGB7la0i7UXQ/GYppqFP/ogV9F7+EqZ6WIDa
         iXHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1790760697; x=1791365497; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        b=b2d8MHbI/K2msxANIAUSGWXRSD3g+5IUfmA27J8SV/04s9iV0+KsuZX5Li5UiXboef
         Wdff3WdMdsHQUQDCTaVv5ggfVJK8iCIjpiXJ+OYjGYWv11Psi2r9KQeBS7qIhvGCu6nx
         jb64DZXN9rdOnehgUbQngI5VT46cKm1HcrgCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760697; x=1791365497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gmqdU3mh7HkwuHdawcYTNlsooyWkbGnJjJwr+HnDbhM=;
        b=B2glrfSJp+uO+L4Ebx9boMHfbO/lyYZE4Gy8WRmfyJw1IkW0EuNdK7VgPQ4LJiiRzr
         kmHZEUt3ZAOetzRxsXALsjrpLRs1aeYCQj/oSW5/cPUvNm0J6TFnrg0tzZpq8hD+rGRo
         zPPrcASYgWAkQ+A6pebsqa5+k6+M9eZco2GmJu7EiPGBY8EN5ob/EFgCfTN+7GVJEaOp
         lBlKzdpIKGCPJ9ZmhMg6uDvgXAknj9isJ6hbMpCy3noyh5X0FkS+fqjSLzTi3t+aA+fK
         ByS9ZttqKEckPO/6p/eQpUb/MoV2AGXS4BA1Cy7VUr1PRLq9geEIKhSxwwMl5HNbSVd9
         BDlg==
X-Forwarded-Encrypted: i=1; AKwUvBwh5iv8CnjGvZmRIqG7q0DDWx/r3GQ3NlNMFvwSx/nV+HaNkP9AFlhu0LReWl7yavAZpelA4is=@vger.kernel.org
X-Gm-Message-State: AFuF++lIYfkqMgePKjC/7X5x/mQQ1zk3kiLmA+l2xYbp3mE0YD/YuFnp
	dirBHBEMSkqtS+cmPRmZBQoCHlbGRGbjJjP+Y40prkuNoA5zsJYJvwTvUfqreCHHU8wR+YaABiK
	YimGF3QplIa5Fjgu7oJCnwm8GBJgIjBG9vDGE5DP7EQ==
X-Gm-Gg: AYBFou3aME47F3Lqwq8Z17ZPTPb4bKOFDA3jXVbJ0cLhH9WPsmIJXs/tOwbadfpOSPo
	03VgVLgO6qPK/eGuSoMkGnpczuhb45piUX8l6HE4qs5B1Ut6RF0XPVx1jnboEvffs/sZ7qjM/mY
	xPLUmTx3+CWiJtL9Zthut9AOuuXuNyZUHuACiLr8LnMBVyzvIjz7bdHB9QDrKCFpnGe0ObdBGD6
	AFAd8pYEXAXbDhU7eDgddbo4lSEvSpxyEboxivEzyzsfTh2jrPQLHmOvY3/fqu4RehnHi0Ka3vg
	m+t90MFid38K7EEEhSGFbTAyP4gR6xprHd9Rn1B6i+rPbn+VuRRwfzrO2VR1S09yINQaXqQ2mvI
	51T+4kgXbh6JGZrtnwTtHBNIkc8zhgD3DLTlWFl9BQllDzBFLanIhFjrDZskMJ4DJfaYOu7mKCc
	S5nXu5d47+Dw498VSwcvKOVy8dZkXMy3Sq/nSp+BX6eZyH3qMgy3+kwLjRe8KvtDHGjgDibEYdk
	jx6sRvrHH0k2unk6sNaTRdIXwKHG7vdwsc=
X-Received: by 2002:a05:6a00:1d93:b0:86a:c062:8af2 with SMTP id
 d2e1a72fcca58-887475beb20mr572280b3a.3.1790760696692; Wed, 30 Sep 2026
 02:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929041444.9837-1-daniel@quora.org> <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
In-Reply-To: <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 30 Sep 2026 17:31:25 +0800
X-Gm-Features: AclHuK8EAJhwPODS-uwXrHzCTd7v9hqYYiYnc0-_fOmkD3ZLxi8pO4B443j8vUk
Message-ID: <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 15:19, Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
> Thanks Daniel !
>
> On 9/29/2026 9:44 AM, Daniel J Blueman wrote:
> > Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
> > SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
> > timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
> > on all boots, and touchpad unusable on some boots, resulting in:
> >
> >    i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
> >    i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> >
> > With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
> > versus the previous default of 521ns, however the I2C spec has a
> > minimum tSCL of 600ns.
> >
> > Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
> > verified on Lenovo Yoga Slim 7x X1E-80100.
> >
>
> There might be a final count which i should get and update back.
> Since this fix is working though not suggested per hardware guidance,
> should we consider as temporary fix and move ahead to prevent failing
> usecase ?

If you can get the final values into a patch for the next -rc instead
of my fix here, that would be the minimal path for everyone. You or
the hardware team can cross-check against the I2C standard as I did
[1, p44].

I would revert the original patch if there is hardware that uses the
I2C 1MHz fast-mode, since the current timings aren't to spec, but also
weren't before.

Thanks,
  Dan

-- [1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf
-- 
Daniel J Blueman
