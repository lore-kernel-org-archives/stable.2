Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52648A8B4
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726954; cv=pass; b=pj19+1hn0pGQu3uqAau3x7+f/QSKH+se5skIHWG+QpxBljH+moMjJCynrNMVZC1pFkLvzdLS5oubjJOJQ841Z/br9l/DKu6ps0YhaQoTqfDxVNjWLJNP2Exuk8wslSZvQ8X559MHRuTGcR/z4X6piwCfulrfOxOevro+33Uy6bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726954; c=relaxed/simple;
	bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J32TKLshEdS8ePol3jtseNCE+UcSPwuY7/OEhEPUI1cjqd8HxZc+wKTi3KYceAFaWvm5uORvq9SfidBe9NbnxRcXCL+4NvFVubUlEvnze3DOVBTpGVnguLqjhAPdbOvLAELEpapy99asP67GZy+ido7zQi541wRcizTCSdd1OyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Hi5YwYB7; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Hi5YwYB7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca12086c06eso925701a12.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786726952; cv=none;
        d=google.com; s=arc-20260327;
        b=VxmwNDfutb2yvWxQmjUR56d1RH8fahaNd+QVyHvfdVGBBMYrqO8kj7BHNcnx+VCvjT
         DfPEN2Xpb/bpDA/AiTa4w/vQ5oYLAEhIIJ4hqtvwV+utWz4oQXOBqibbjAcItWzdFRU2
         bzUlc9omePcRLXtMvyc0EX66dEMyEkMaMLKVmMA2mq/Ij5b3YHTJYSG/POf63GqHh2qi
         LEjmPz32ZxdCEnk+SHPOiUbJVwHobSgWJEkH1OuH/VOsSNY4bIMTG1Z9gTO4dOyCco8C
         WLAnEPobW7POCnQs+b4FAczZC+Wq15tMxTozjbeVhwHVWHRpTiyA/9aberLoBZB9fJqE
         3PtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        fh=/HX4AOb48XmQwu4i4CWQe2HYPsd5Lxzziza9HHmCywU=;
        b=miNhV4w8+ywk2EIGF3kurFFXG6NHAhbE2smhKRHFoqOHERCDhWP1ePGfRy4/lw6DZh
         2TAeaGVKsKyKRJfSB5cbWeqUaigz0gSx5pedtpcsezJknTQNvPCdHhrR/j4Va6Azfcty
         Ic0Tvt/ACHU6jYGAeYQps+B8rgULOToBJMlz9dqgBSPltmUkTRfzyrkV7ymF+B6cgMBB
         NEXb7rUzt4WwvhsD8iqKUaRIPDPaSBFMzdRnZ5MFImjUw3ZJXBK25zGSSYgxY4ZOREa3
         muK7ffCSOUj2GNOisrO1iVaQIk+UXe4xMipx+6GLXbt75FOcs2ZV601yRISFa91Lxn7+
         x1PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786726952; x=1787331752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        b=Hi5YwYB7xeueQ81NLg48IsZTjqgbslSM+Z2e0vOLdckwawmKSfSHXGKjFEMwXCxlxz
         J364SAAG3mccSrvGmqESRz8e+gMtw5CgB14q1cRWPQiZ+psVnelvqX/djLHS9ulupvXC
         w5nq6mqyE0sghA49l4iM2CdqNjOC6wyrzbKiX1MhoZ+w6M7QoKJRqAUajCeKS3+vcQPy
         E5wlvQWXcKqRZxlB/q4DgB4iouGeh3BUJG5NW7g8v3yvbazV2fJS0Snsm45U29uZAszZ
         PcaSGI81I9/M4+chuR1Htz4qAvuUE9YRWanY1lNRZXCORCEu5x0SZtN3GHOjAh8QK5+p
         8BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726952; x=1787331752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l+8sEY4fVIcObetwhlkFIug59o+dvPR7HAFl9MXUwc=;
        b=fNsttAExYruBT+0Glm96SyxxSbEUm4JbqXQC7EVOUrk1uyUEyhMdgjV+bHM8zt2pp/
         vRGQ2HuM+QPTlxSuHlvrhnAAqXmUNQwK/4cG+UK6HZmmU4FnodWitGDGajRCg8UnH5Sw
         pdO7zYZQ142dqzXhDB3UgbugkO5SifdOmP+br53UEdRTdVcfZzK2/SpBuCuhV8525gmM
         7FlXd98VQ1jSwGWqWFnO14By31Kii6xkenVVJMEpio1gsj7vLRL4mnaRsncyAL04joH1
         KEc5NOyshMdNRTztmHJpg1GKazp5zkgQY+yESW538Z1KUmc07AdRXZuXnx4f4eOM2aad
         bsCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEY1yWT8zxiJQ00XYMrnmmviUiCJFA8BALf23rF73gGYyw5g2RLIGvNOO1rPMQhlHBZXW7MSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuNPe2widSzmkm+dGmoYljjh6JzkuQq5YGJKOIqJaMGLvQzQd
	+U61cLLQA0nbqASOdEUu+UhSfmhOVIaz23iVFd1z3m6hlHo/+k+Hvc+aJLI/gxu7kCxi79Slx23
	6ScA7ghVF2to5EdmCwfhjCRE2VJWJPLPihdvLHg6H
X-Gm-Gg: AR+sD122EvXKA6dRUPmktFe6qrTEOXbahvHhtMUf4MW+ZINcUB3VS2VR4ckxYavgyfm
	7bhbYfua6gEBo5QaXMzswyNeH7hIq0ctHimmbquYqtSwEZbOlfRve9d8MeUTlRdx4DTLsm79NMq
	Y4x+wh8bRA/ptsCu8SZoYepQqZEJq7sQgTuyj7JfJAKWSOqwKM0nWn+BMrCGiUx325HQFqPRzPn
	+hYb5TL3R39RBDW4JJNau2ogrrGmXOO/BqoH4uXxwy223bYmsjdFUAcqfVeQXYLb62F9g1whcqg
	lCohKW+CE7rqXFf8vsheskIyemuJtkOFRsYNAg/AsW+ypQ==
X-Received: by 2002:a05:6a20:c6c1:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cc71e1b525mr8653190637.29.1786726951998; Fri, 14 Aug 2026
 10:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
 <20260814052541.1198373-1-xmei5@asu.edu> <CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
 <20260814151453.4d45d5af5fd7bcecf0e0dbdf@uniroma2.it>
In-Reply-To: <20260814151453.4d45d5af5fd7bcecf0e0dbdf@uniroma2.it>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 14 Aug 2026 10:02:21 -0700
X-Gm-Features: AUfX_mxtrL3Wam_weCjrMzDuL-wUbcw55UCi0JBIG1z06zuBFY6JgqeKDdO-beA
Message-ID: <CAPpSM+TRJc6ALASmezNPV49osyc3gvw3Ea8-1aGYPdfXgYhe1g@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: dsahern@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	bestswngs@gmail.com, justin.iurman@gmail.com, alex.aring@gmail.com, 
	davem@davemloft.net, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	pabeni@redhat.com, stefano.salsano@uniroma2.it, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:15=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> On Thu, 13 Aug 2026 22:31:18 -0700
> Xiang Mei <xmei5@asu.edu> wrote:
>
> >> [snip]
> >
> > Sorry for my English. I mean, if you agree with this patch, you can
> > take it (it's based on the proposed version you mentioned).
> > You don't need to follow our version of imp.
> >
> > Thanks,
> > Xiang
>
> Hi Xiang,
>
> thank you for testing this and for the kind offer.
>
> I will go with option (a) from my earlier reply [1].
>
> I will send v3. It is identical to the diff you posted, so what you teste=
d
> is what I am sending. If you want a Tested-by on it, please tell me and I
> will add it before I post. Otherwise you can reply with it once v3 is on
> the list.
>
Feel free to add my Tested-by to the identical diff.

Thanks,
Xiang

> [1] https://lore.kernel.org/netdev/20260521200859.816b8923b5f27bba6124461=
e@uniroma2.it/
>
> Ciao,
> Andrea
