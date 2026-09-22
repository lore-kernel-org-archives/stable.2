Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95674E9C2F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109779; cv=pass; b=LtTM+I2GMQU0QSE2OXhRzLDqUuXz0K76wKKRu6SibuWbb2y70oPdqHdxT6mWP8srB+Z4Orox4DVyg2x+OKXlEvwXGLcIaZnHEb42efO44O7tdsFxjQAQ8taxflCYs7dPynrCQbbjhPmz5uKYcBN6ypAt4oFZpStHBI+h2UUV+Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109779; c=relaxed/simple;
	bh=clPJAFG+iMbMZ/1lfY4k/HPrMduY365VF1hYyyaPXaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiUwQlPnKHuB7t3Vllp5ANJfnUEW5UrLgVYsIkzVG3tSSmDW9/uABplE3bemN50jCO3GkrVO7h5Z2Q4zyDXo+TN9L/KWWqLCpzi8/aJrNlOMeGD0Xb/P5qGa3qV7sXhpHXNfsLRDphfHmL/qtX8NwICeH416EichFyYlI6brbHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inf/3MjU; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inf/3MjU"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so263024b3a.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109766; cv=none;
        d=google.com; s=arc-20260327;
        b=AtUsKga2NOyJmVMklxrVxt3m2wU2i4tAmF1sUsAd1u3mC6aRPEMo+ZKjbPF0Py5Yea
         9CYjz4xrFcGseVOlhpO3RnSLUKyE6ybugQAfObofvDokotYh4RKxYACIR1QzF3zLaFhK
         k5omuJiBOlQAmblRY2iNa/SoeGUfBg1Ccvp2m/Q3CMG2rwtkXRaB6HSxp82ZYMj9Luoe
         Yne5w8msgXKNystw30ETJcJbJKoyn/vxEh8vjbkMKuopBKglnCxcID7eQ6eRp3hXqRSF
         /p6QpYfBKSIoikBqw/kAofckStJ3eCmfzvjtPUVZVSJCl2fhwQ7QDL+6UVc+OocEwoqF
         IfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        fh=CdcozH8DRSaidPXFXYB18bYREvoUcIc1pTKuno4I1zs=;
        b=qjVkgdGUiTbjGlyggGS9TckuHY51pO5QY09STIn/nrESZ0zUZoogsbz4uyEpVEUzCb
         Bm9GjWfH8rZQ3oNrHcbE/CB1wZy4/PBPxbObUo4Ivzr2lzAYdqA2yp584eQEPf69mt12
         CDoPfkuXPKSvaGehgSUD4zChN05r0RjtRGsmfHjvj2Y5wvJGAvkYyS65/f5ZSmS6wr2f
         V3Q53Wh4OcZ74gbYkZhFjyBOVJGreT9taEz81zZDnyHBPbj2stB8AQopvWTEQuJNXm7M
         G/AzcpcJia0ARB8xlsc5xNij/VbPQfC28KwWEfX5pP1oa4uj0WOYLqWEQBx6IfV+4A9F
         fIPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109766; x=1790714566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        b=inf/3MjU3tYDi+cWapNhF1EoZf/mH0nOYitrbEjpBEGiLHx5FWQOsL1le8T6YHHUJG
         NF4lDKYrgZjYl0Vejgf3crLJqwrnFudfYtvfu2ISayISMrFFkdk6McmFT/ess3qZS64K
         hioG6XKtifIwiOh97uy/s7wXJKrK3/thMqhtEZ0emawrDkhdO2Poz0mSleYbuXYOmbU6
         T4IIhE2xjWDyGlIuzQZae2cW8ArS87lOk3olvK/g2a4zvoTpJLOhRfNKFxi4DWEmiyXn
         saHU6e3nJ1q57XLC299hEtsrrz4MYzqDN2t4JwTJdN9C2FVoSt1wpKjwhIzIt/AlrzrB
         3+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109766; x=1790714566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        b=uVaTq3+nocTYjC8Woa85pILv1i0kOqOnLH8wObhsS52qJcd/9uymZHoDyeMExfv8fl
         Obkzu8/U/VIPK611myMU/CPtksjkgNPUD/qTpFMuFoyxYWBZIp2Rhojadn0gZMJGEcU8
         Mkv7Nn0pUtMU83qskhcK/NcNTv83rZ9mYMBhTogVWg535maI/Lx84DmaE4Qx5Uu2NcUn
         N8ztCUdb4yKjYJcS1zvQI9uqSH/w1yFwWXxuAHtbqYroXoqmfwWF3XtRso7eR293NXHT
         /OdfrsSDIR7H3A1sGVi8LDGjl6qi0cMjsKDzBldi9cEOlfIXbHqkmMS05rdI9iaaFDFd
         m8fQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwtuvGeqGcLG/FgSrfU0aeFzs2cDYuzzj3GNzz0/mNI+L+q3LFFGHjtqnQv0bjZp5/DADqhug=@vger.kernel.org
X-Gm-Message-State: AFuF++kcAEVgs7BA/csc9XMEPyjlNsaIh9CZUKLdZCAYjMYCcKz016d4
	fm+/SUWgrHfes3TQrvl0+7clYRGVhakv+xRKy/3u4o6E9CqwNLaC1ZEYXuUxpuUHiAM3lIm8jIH
	Jm+hIfMFuHGTSZLouBTGWfGgXQo39WfE=
X-Gm-Gg: AYBFou1EOfEhCvufXFnaLispwLO6hcvk7NyckiRiQvm0OLwuH+WBBDhkXIyV3/yhhNQ
	X+Jeo53HEETTm0TcfLi38/aBoN6/V9nZ0DV2UFobrUe2u6pf7gktXGBUqx/rgENRZtG9b5SMZbF
	RO6CozhbqRaIqB1ggSEyIt+B2pwpLVy2/CLH+8UWIz0e49ta+y1hI+jH7tW5ucF0AfRiRo8pANW
	hHqF6NrWbtaWK5RDXCdSfWPqu04e2PIPqNvbJUaESZ5xJffcyf36Gjkh9mMkwiKRB1sxrL5/+hv
	xK1JrxOCT9O5mjEWBCFK9qgxJfQI+EfGPqwMeDXw9u3uLsoVD0vKhum0JN0uf1FPPYtrchQRrkZ
	Q2xIrLCrVPqyx5z2/oVKXJ7qIkh+sXSvdqqtQqhs3Bc8WonhACUayb1bII5b9dKU9jg==
X-Received: by 2002:a05:6a21:6b0f:b0:3d3:ae40:51e3 with SMTP id
 adf61e73a8af0-3ddf7eb5f73mr622092637.23.1790109766026; Tue, 22 Sep 2026
 13:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-5-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-5-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:42:34 -0400
X-Gm-Features: AcwNN1W-iOgtFaeoFgTSVoi0VfumM0YOE87MwjOUfMe1Y7AltETdUhTGgq3CSe4
Message-ID: <CADvbK_c7dS27Vip8OO6vonG89MWTP3PwN_y-YP1TrH0du6HS5g@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/sched: act_ct: avoid modifying shared
 unconfirmed ct entry
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> In a case where skb with an unconfirmed ct entry gets cloned, we may
> end up processing both again but with different sets of extensions.
>
> The series of events:
>
>  1. The first clone wants to commit and runs the helpers wiring up
>     the extension pointer into the expectation list.
>  2. Then it looses the confirmation keeping the entry unconfirmed.
>  3. Second clone now wants to commit labels or run NAT and adds the
>     new extension for that breaking the pointer in the expectation
>     list causing UAF on the destruction path later.
>
> While this is possible to trigger, there should be no practical
> network pipeline where we need to process both clones without
> modifications in the same zone.  So, let's just reset the entry in
> case for some reason we got an skb with a shared one.  This doesn't
> affect any known use cases, but avoids any potential problems with
> sharing and modification of the unconfirmed ct entry.
>
> Unlike openvswitch module, act_ct allows for NAT without commit.
> Changing that would be a uAPI break.  So, act_ct needs to reset on NAT
> regardless of the commit flag to avoid reallocation of the extension
> space.  This, however, doesn't really change the picture for sensible
> networking cases as there should be no need to run the same packet
> twice (before and after the clone) through conntrack without packet
> header or zone changes and without commit.
>
> The fixes tag points to the introduction of helpers, since that's the
> main UAF trigger for the sharing.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
