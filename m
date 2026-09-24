Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EB426D3F
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237211; cv=pass; b=NgVEQpzMjz8iaas0GBk8uy9rkF7cWk8y40vZ+aF656aCNdbGvjx4EL4BxpxEYYP0yqZKz6uSPO/wWsl8C/5zQeYUCP72sFS6EDjdykO8J/9X9opRsg9yn9Mjef0qGiThnkDYjpXb9QMqNSm6jYpdhputsa7gLc/BpncPjGGB3S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237211; c=relaxed/simple;
	bh=UGYQZrnkRgeJr42+jBEAfW2EjfUaS7m1JQC4CpN5LwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk2Y2L7tSjeFiwXYBqjy6hjhvTeNOcS24wvZxo8zgjHSiQYDMJhgV2lZb1g9fBFhRO8p/vX8FoFqMuGkfhK548ikq+tfzpzECKBHdYmiO3KoyecF4j7IPOJG292SPLd7X1Enl/8bck7E0dbPc+9752Y+KKEHOHqILjmhDto5tl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UFHOPdhc; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UFHOPdhc"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so880182a12.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790237209; cv=none;
        d=google.com; s=arc-20260327;
        b=hdG4txlSYiLO7uPdMcevRRpbM5cnZzApnTXuOr4C1U9SM9cKdYjaos8YLPK+gDvWlM
         5YRdFxOEzKp00GeT2KK6ccMYBE8VwM9B4G+2b6M1qB33LGNNcma5XfucqX20T7qE2sfI
         MCcxqvQkaWAd3WISb+B/tpE1Vu606nshONwcZZAqbQNay2oJOk29Uq05dtAi0e13ap+N
         rVyMIBgnlVXmN/SvhOsrIbjtLOFIaxPK/YlqKs+zPsOVf4MyQNKutrO4I3ECuaz0hTGB
         QDoetV3JRj+md2v6LcDupPbcNk3AiadSsi9ytImWIU/y+QrT8SstkRLixdUao562SS9O
         pECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        fh=of0AE1g6IR2UJZ3ldWYcu6a6829XVRPwxrOL4/D7drk=;
        b=BcCClvx4kmx6PYQ3fc+L6TD+/xJR/1UjPB6QZztssbcC16Wg8GWwjGPILU18ikvS8q
         1TuSeoRDS2fTWf9+es1lJSCaow9FtRzJBZo4TtEA2l3sJ8sZKNa6cmCgrFCRBGRcYbQr
         5Gn42vwYGWxo1dEcIHu49kGGkEKbnK2jjm92RMVY7WnhE9yld78p57RUBTtkFSmFph4G
         u6z1+cdEKAXcxQNuYkI8FqYDNhuEuEhqnqDAnJ5s8B1btGGig3eYkEJ6EJj/+VWkkgWX
         9qbWGcizDJvJ/5YEs6yXX7u9hmeD/cH8Bn+Y81yuxKK4dV7B5UQbkif1rmIAGqc9rBeS
         I1nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790237209; x=1790842009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        b=UFHOPdhcSZ960kqKpp5V0uuB0YGBTdaM9Nhh8wzRkmUyArajxb546vOQ5klXC7b8+N
         ULvkq7JuVqsgnpE6c+Y3C+uQrGHEOLXgA40U+FROvH/9XmiWDlTcVp124x+E0UnoNjG9
         ti7xglVZ3cozrj6ZgDTh2b2/OzklpCbh8fvc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790237209; x=1790842009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        b=tVwaAHagVFzf1ZmM1AOlsSWuaGBHP+SqiruPPPCpJIeBkZ5zbAHXDCGYoPO85LQtj2
         iiR1ttwBY5BeghCzODIaqm4S53FFfw/Fl+tnJIP2eRVzgDLc6C+LNnIU+gxSg0UlUFFu
         xxDyvu/8z/7aszce6jaZZSnLMXvubb4Z1IIQ5jOvFPkW5uhPKPar+Y+QOErNVuUVF/qD
         /CnGZYZLUV1aK/ATEZ6C6LMmHvv882niVtZtWav0TNtfN+GtC5ug8QYSnxc1xJN3wklQ
         Wn/2akwP3X46fjSgcVSCcxrObVvZBH49AZZGLy4w/yWv9vcqOqtLsCmBPLhUn3ydpziD
         d3GQ==
X-Forwarded-Encrypted: i=1; AKwUvBzChZhv6p75ErbQeT3tIyJv7LOpRBMsIB/rPeLPV/mPxgf4npod7c2kbL9HVLbf+RpD0h2AiR0=@vger.kernel.org
X-Gm-Message-State: AFuF++kdH4OgyEyfTIMugaiTxOQanqLxUoNnfXF/GNf/FIiLTJBavvAx
	1KOOQMeOUGK7jRMr7QndXAJMJVg/LNCTC4sjik/YXnLsVEgj82d1wvPQwnhmPo9gBou0mvSAR4j
	prQn49ZBN9U3A/OZOc0esHQSC/0cX3SBiVwbljkzF
X-Gm-Gg: AYBFou0Tim+G7L5WlBthSaP3+XspAfSVSav24S0Vs3GlmcztZFLDw0HzO6RST+pJr2P
	zHATIhtdNHo7pK3TIhOxqhDqxPd9xR9PjS+3oO9TWoFtgLdMIDFoz0IMu3SXoWimS/fADu0QhG5
	k1duOXOvTVm4Iv08GEmuZPrjFA5iEf53RYQFDXBevlq7JYQGs5kCXwEUjKAGvqbXamdzuRZbuu/
	o9SP0s7/+XjEQoIDJzqb6mBinpy0m1uWyjCObAah6nIj0XE+7kPClBr1iK6pO0zM5hl9Cogj/Wd
	THCJ08OogeONbM2FOkKEou6ny3wLvo1UHKkbWBe23lZ/CASnBsrF4PB6G3A8393cyonsQRRqNUN
	jggunALIGNNf8JNynAr2iFWOfLK3rRW4kzw==
X-Received: by 2002:a05:6300:4044:b0:3dd:e691:df3f with SMTP id
 adf61e73a8af0-3de0e8e77a0mr1867560637.57.1790237208727; Thu, 24 Sep 2026
 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com> <179008581937.2160803.7117814290574262942@kernel.org>
 <CAM0EoMkooCG2s+RS53i=qo718GNDGiDz+xaUzAidZArNWO7EuQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkooCG2s+RS53i=qo718GNDGiDz+xaUzAidZArNWO7EuQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Sep 2026 04:06:36 -0400
X-Gm-Features: AclHuK9Obeyam49OTB6ufG-HbCqQCVyHAiNVJYIhe1cVEQ-Oy24kBbB86GTolJo
Message-ID: <CAM0EoMnEvGZQr6KxHR-+RZdCmWQ+PduK4286+W=WB1kcy0fSXA@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	vinicius.gomes@intel.com, horms@kernel.org, victor@mojatatu.com, 
	xiangxia.m.yue@gmail.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Sep 22, 2026 at 10:03=E2=80=AFAM <netdev-bot+sashiko@kernel.org> =
wrote:
> >

> >
> > Also, this isn't a bug, but the changelog says:
> >
> >     Another approach was to cap it in skbedit;  cannot work: the
> >     redirect target, whose queue count bounds the mapping, is not known
> >     when the action runs, and act_mirred sets skb->dev afterwards.
> >
> > there is a double space after the semicolon.
>
> Sheesh - bikeshed much?
>

pw-bot: cr

cheers,
jamal
