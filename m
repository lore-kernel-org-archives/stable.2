Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794597216;
	b=fwmn5QlMPEDLQSjhFZ354X7rUKsQueglL1fu6bhdWvD9iCFKstYqmOCS1peAIPoHfdEj
	 e1ly2qqe39EIfluqITfzgQE03JZVirLygHGkbZVi256Oqb7HbvcOlP1Dru3M6YH/hLAFw
	 fadw9x5dq8p5stTBKHxXz/mpyT8vtq3cNdrhYKbYpgBc1NC0qs3l9+vxNoMUZYoTSw9ug
	 okx5yVcksz+3pkmNFeEVQ12jVGUD/tHG/uuXH3IUivtBAIZMU3WkZysAZzNhKckEZ2Rhp
	 zgM2VQU0EaW3vJgmZz8G4Eihk343HVkZ22lbfJxWrVWzpknmUxixtHDjKYOu0vkDKhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CkJal16JVZy7MsnLo3ZvBIu4QJ0lwiHNnQnVMRLg5ug=;
	b=IS10QQyQiHsWVkOi6y0FtFefyVnfvGqMqhh4tPwIThjTL9NnIrD7boczP+BfsSJRuVnA
	 tflekUHwHdvbX8WVfGAl1DE3CHR5aU6QXyHe3eXUZ62haSu3WER5N4JDaPLF4RIgK1Hqb
	 UArA14LOy6NnESVHtMBZjU15SrPEQUCR3YLeyMxGXcuyrPJGiloMu1KQqAgd3gYMTDqtB
	 uV+7zQ7+SbNEOZ04YzVhYcwkGrzlMoVIFkl06B/5toRUwwb3fUoWXmJxJApvwUJjugQoE
	 +7eSal5N03BptTDsddH882G29m8KSaqU9ikT9pcx3JIkeQCZp/0/5Az4B/OewWt5lxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpCySeWr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0F606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E0F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpCySeWr
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso2578602a12.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:13:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794597215; cv=none;
        d=google.com; s=arc-20260327;
        b=lJZvVXUua/SIX0kozXkAUTAUG3L9nmv2kluUaTXHdJWjCi5+oIF4VhXPsikBPqKI01
         Uj9zIZa+BuTgr9WUr8sgZF8EU17PBIVRk/oOmVGmUIWd2eQAK2Q471uIvWY8rTiqaaoC
         QLOfq9WSDO9fw8aqsYh7mjxuF6Z5I0a50oiYoXixykuvy3BLlkSlgbtPcPZmWxuWTkoX
         AcVx6w1iUkiTKKc2lNM6OCZpPtxfkFKByAH/cLtPxWtynlext7lH/Jcpl8hVnG+qC6Oo
         suHMlY1V67lisff51wTGqM+Okrm7tKu488Hl2YTSOCEmIDi++9qwQtIy+hctBU7RYwY4
         SEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CkJal16JVZy7MsnLo3ZvBIu4QJ0lwiHNnQnVMRLg5ug=;
        fh=tm6lMiJzq7Nfx64wJiqyDNkU+priRu6awlx8q2obiwI=;
        b=PXRmTJ86uEbtVvvBVrZEmI9VmCYbtmDlWnAp/9pYjEdkGGo9Qas8lXvsZbvnz23bZY
         toLpK57XMtaGdsEO9ZrTsTrBDDnh/aPzjROMDNJtAmrhJ0Toc8WWxfOKzJvUJB9AIWX+
         6oQh6RQvZZdnlCq5KpVSrfsHviQcJSKJElqf01sqxvGlxg+862ln68lMPfKLXJQA6IZT
         yQ0NVM9LeNh+oqa3PUVEJHgi9R59mFk4bxZLhME8WGgDiNUJmk7bwLrcyb41XymgJunW
         OP5UvLD0cOSJqJupnD0m/ehm787nBOQJdwfGn0qGymXlf6NmSm+zHS3gbktiPHVHV1SC
         FtUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794597215; x=1795202015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CkJal16JVZy7MsnLo3ZvBIu4QJ0lwiHNnQnVMRLg5ug=;
        b=vpCySeWrO5uZktLZMccJKsMjwjJqSnj/HXaaxpwsFcZgp51iKSyPZhFyUtjwOg/9eM
         P9/zvcpqfdHQMhyb2fjOWlle9dbMUAnACmcAJcX44NUebpHhDibL9ESCzkQoOSxsx32h
         zw/4kRk0GOyF+BHrMsM3YQ4kCh1q+1Ce2sv7DWA73M20O3JC71EgAiHcn3NHp8EOc3GZ
         6j6RNKcR4VHdF8K435mw4RT1w9HzM8ej5rnwWNE4N4pWHVS30VdUDi/E5YhYw2P0UT9Z
         k6FgqJ44R3114L+FguU4SNcLrT3uBzG3MJY5ekUo5RUX28KPEtvHRn5LnKPvXHPr7ze0
         x4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597215; x=1795202015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkJal16JVZy7MsnLo3ZvBIu4QJ0lwiHNnQnVMRLg5ug=;
        b=IJp+7vNb0/MDkuZH+bTH7YoPHhHY17ENdkv4hPQigO/rHRR/KgVB/Y9tgPRy7P3Mxs
         TcgEjezc37R5VEcP2MZyWvW8rX7VOUb2NKwkwVGlRaw3sUSWdZEFj1VVd6Yxlivc3P8b
         ysJ4dqDHoYrlfR16qn4TW1VhoZT+h4I5/1nPDFz74v+Ti5eXQfh7VXR/AHWlPjKp/Hxz
         5BL2fu7YA6uKtxRSWOOXyW1TkVnu3kkdhw0UE+4NigOo+r1dFVpgpecDlgnhA+8n+p7x
         eJkiajD1vFxuWa15WXgRiA6JspiNomRtkxncZh600fvhqc7Pc99ptSQwC61ND6UcaBxV
         oq9w==
X-Forwarded-Encrypted: i=1; AL+hErFXcLV0CdhXVqRXCixtaQx7uFYDhTccQckjeXHfVDTfbLIfQ2KkaxCCO60zM7pj4/prFrkOTvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SkZYxTInP3TOYyTZpGwJfP0O33G7pQ35xgrpR7K+BISgx9Hy6
	zAQi2VF8xetkPjD+wet6WHLyPp3SlNSYtx7lOUnxTQBC5ucQCwtbJB52T8s4zRqjkpYmzfm5qaT
	4muJNccsyQKzDx0LHFUlrxcpkSOsf4MNYjR5F
X-Gm-Gg: AYBFou3C/47eZXSKIchnuPzIJAewtaFLxYt3RSuFFVJU44xP1nE8J0D9LRO+Fi/RJZ3
	eA/K7CFxqYw0aF2WG2uUAskssuPX6nEd4Kwr3HQO8e2006vzzxLb5hQtvGpL2p6xEoFUkzTGpjI
	97q5ZPa06mpp555+RdgIkxbBZRL1M61u/Y4xCBMQ14xpxWYBEUK2IEctxT3Px3JwCuJodsb9Y5W
	QYx2yR+YYqMiownZy1s5VUJRykA3Lhc3Ib2/qafer+bVDiohwcHwB7D029N+HLDaMmEMipMfbMK
	HsBJhoOfJk0JJ6QmjZ7l1QI8TVs+gj+U3Y9zRgt89Opzfo4imkW++Uugt60ihcPFZUXyRVTs44E
	op0xCK8oWQnC83kRSAuK896fvHKvhk/tIwwHpvaknGPqJBo5rDcXip91yvDRXIfOUafJYKmYY0T
	kdT5DP6UJBIFjDaLA=
X-Received: by 2002:aa7:d1d0:0:b0:6b6:face:56ff with SMTP id
 4fb4d7f45d1cf-6b7c0c1cecdmr2522373a12.33.1794597214449; Fri, 13 Nov 2026
 11:13:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109200525-failed-6.18-c782fc8ada81@kernel.org>
 <20261112084347.6208-1-dennylin0707@gmail.com> <CAOQ4uxirbtnBbeyHbq=gm+ttA=0nusQjsCoK0FsajZfqL1ZEMA@mail.gmail.com>
 <draft-0013-regoldsteinovlcasefo@kernel.org>
In-Reply-To: <draft-0013-regoldsteinovlcasefo@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Nov 2026 20:13:23 +0100
X-Gm-Features: AclHuK_T8n-LNx6a94DiIvvRK-71i6BQHDugyg8h-sUbg3yT_75nInFBk5iriqs
Message-ID: <CAOQ4uxg6d2zbh0C0eoKCJkHVMNiy+qPKk1WHDK2Q96swN7L0ow@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] ovl: fail the mount if the casefold flag has changed
To: Sasha Levin <sashal@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:10=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Thu, Nov 12, 2026 at 9:43 AM Hungyu Lin <dennylin0707@gmail.com> wrote=
:
> > From: Chris Mason <mason@kernel.org>
> >
> > [ Upstream commit c782fc8ada811569811c0fdea5c3412511be95d0 ]
> >
> > The casefold flag of the overlay root must match the flag recorded when
> > validating the layer roots.
>
> On Thu, Nov 12, 2026, Amir Goldstein wrote:
> > What happened to the original commit message?
>
> Agreed. A stable backport keeps the upstream commit message as is. What c=
hanged
> for this tree goes in a bracketed note just above the backporter's
> Signed-off-by, e.g. "[ Hungyu: ... ]".
>
> Hungyu, please resend with the original message restored and the 6.18
> explanation moved into such a note.

This v2 was already sent and already queued to 6.18

Thanks,
Amir.
