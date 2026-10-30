Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793361291;
	b=Ip3nhvovFYQB9WmYiaT3hPTc9XA96D4PIs0yKjcj/DKNCkn9ktb0BtUU1aQsWdDTaXjA
	 qkHwrbBlL7fgW7K8G3yexcVy+kIZLE1ss21gYP+UV1LlF5QDA9LrxWqBTqjqG9V39yUPd
	 /nH/JWpsY7phUp89p8OeoSkGQLBCABirbstndFPDPzEiMhn3K+QNaj+qtyEir/1HOwXGJ
	 L3fkbdNfzIR9TFUdW/VC1QlKDufgvXonmDtTwWWY6ASl+lQYKHjoMWpWfbrcJAy+OMMVn
	 K0tTVxKIU42wGPsyN6fw+YZqj3KuiomYamjmQVd9EP6evsVZfoZNMv/JQxdW4gSK8xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
	b=nr3cwodWFRtN5Q51k/t+HSKteycolb7Lfa1dyc+9MIqApNR08Gs+s5+CWTs6iZJthDda
	 YSOhlpJK2gywqMgWYrgR6DN1hh6B2ohqEi60heYWxXBdfTtgprRz+VRqANiqm0E+zyn/c
	 AQzGvXBcNgE9P5tKgGlSwbpLqE/Z3xceqKLKnmDAqs5vuCy8F4zwSLbXTSQeqFRmbfFA2
	 jwpUGlOe2T5sZNSm7WiW4+WBchkj4w1cucAkQmV70x4TErvYJFHYR6WYGYESo2ecxtyn+
	 89K6h7yjaZ4pg6JosyMqgobexVlOoPCOmPJRlcJcNO6eQhK0VJ8ENHkjpMm/bw7/lKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgGFeFit;
	arc=fail smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4020606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4020606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgGFeFit
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so750828a12.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361289; cv=none;
        d=google.com; s=arc-20260327;
        b=XCAWfHfmWVbG5O5Qs19bLHKWc3qxqF1XzS/J9J/QeQWvwR/KR9bZKamD/slUVPRqdV
         R1lYAQNrjKfrBMejxAiecNN7cxaXHLIAosnyAkNNlDHbjvYqD15ZLh6yHNg3QXNaiFWP
         02Iezp88PjcKa6qwMO/1NzX3V7gYtnbzVE0M4GIp6BGSO6agiQh7LNbQu/U2xKFNpz0V
         EtKCZv2gRnqjfqX0IZhDewVUgb+DwWmty7slqkaosS4Jhk+eieHT+7r1R5gmuFXU5Gi+
         AXhZw8Yb9pem6szKs701EpvWX9vf5wTn5QSLs7PE65Jb7uHXtrNvJ/yQbmjDi1i/kxwV
         h9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        fh=DPPGyfgTiAr/fpl7WR5Nb/Ck4+rGnPdsQENYDcxKjuA=;
        b=OYfYg6XleuQ3+fzSCiO6ha4D1BdzdhfDzNDfTfhjp43IFPrMFLxZ6cXAN2R6DhQVEq
         YCjEgo16VwpYLmI0rfYZgDjRYHY+n+lz73eOGfsjDv5He84P0Mj8CGfLsB7IwxR9I/Lh
         +jZ/OaoXsrmK5Lj0YKmQg5eHs8gYU13Ng+RcVXbFJp2g7fiPLLs4kOLEQubkNri+XxfW
         QQSk4HV6G+H5cKC/6GYHv8ORPnfZmIQ5U0siTVXZAs09HReQGvk2elBHKAWjBwQEcPrh
         eRTrspUwoFt9EbIm2ObhNraEsn7/8yECxlc0t2BQ9TjXw+LHK8zip0vAjzFwdhpiq42l
         F51w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361289; x=1793966089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        b=zgGFeFitjhi7kxcPB6FMZKpTVSC9dvTTT0WJh4vIqa7n8Tf4cbObbLBmGb10JuGBKw
         7g/oxsMH9G4Yr1y/d5skhpqjy7b+xJjMr3I2rvEnaGOdOKalZJE8MNVY5jqUpL6aF6li
         y98TRUDk75NrI/mkrQh/8jihmyVZCdeevpBcZKR5TcQJp2K+xfmHmhsCACpp40/8HCg/
         enOOeVGRANF2+jZSyKYJShpCPRXMb2VByF+N4tnBziKBONSIrkX82P+NyZAiqHPx5FOs
         EfEc0ZALBq5DW3HVORMPVjJKRdUdk4fILIYmvHYUH3Fh3G+SRhIbh1+LB1UdQuTAMwNl
         /dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361289; x=1793966089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        b=mM2KMtO8y1PBGEMBZYwHqVzAXA34lRdh1HpJ0EO8fF1B/gN3TaK+WBBWiJ8BRHnA1f
         J1hXCrqVW+N/EXksQAQ6HWADkvSSQcdPC71LnLWYFozmNH/bv1lETZjMvZ1rLK0pXCxN
         +/l5eFYzoxYswJgP4iDzluFrEp0Ai8K1mf/MVkGLr68roLajCGOfekkZ2xjnd/QEI3tz
         J53hYcaI7bZhcEgEv3Nduy0Lc6bYhCfO75BBjHlIemzU5pce0Ub6MMRnfck5wXUazazZ
         jl6hcfvxA8r9PDEq1vvmqWHi7tnaSgiuo7ThKvNeMgh46eraXgO86Dn9pJPKWvBm19Wn
         5L/A==
X-Forwarded-Encrypted: i=1; AKwUvBz4h5fh+Sj65d0GXizHzGqoq48CR3bU1t62zt0h1MDIlqce4Qou6azqpsCsolZwhMDuBnppEFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZOY18QpY+y2y5NbY0jdDK1qNzho2DvUo0bpH3ED+gXTj9CQM4
	9rlSsamE8v6jSjY9lBRYqhQ+qHKLXUGuSF3Tnms8LzUgyx/2T4NJNvX3Sh8AJr2fm4XTuQNYn4e
	YRZqsLeYy8zCeRhzNKeQ+sSKhzZQRlAg=
X-Gm-Gg: AYBFou15nsYKMVHHyLkrqJsTi0K4vW7kis9GBKLIrQLxma0PlWIh4X0GQDMevvCfler
	FjIBXOlDCh4Zt/eopkxCWTb+jqcBMhc9khp6Qbnn+bCxhEIyzOKp5eQ4fdSfP88z4r4JwaW/Y6d
	7rRrPfwEgIz/UNvYfa1BNE8Fe/xCBeUESyKkC9uED3P/X3KT2X/uAk6hqsaJL816L5GnCDpK88N
	EWFtn2Si6YrSqEzy8zWbJ8RQgCpId/Hva4oYVcLGjDPtqg3HohvihniQx5H+DWAy8z7SmxjozxJ
	LJD+qJ3XMCcqExxWdeebkVG+FN4ink79ApfdcbQRpfP83KH7sCNuWRTJPL/dSFgg0I1UyZFfThL
	qj8Q0Rs1BMbDbVgGHEaU/zIhDX8q8E4iZZrbZHZUHhtcZ639bQ1GvR0Boi23rlaiHwSXMUg==
X-Received: by 2002:a05:6402:c4e2:20b0:6b4:2b70:4a7d with SMTP id
 4fb4d7f45d1cf-6b4d5ede191mr1079780a12.40.1793361288879; Fri, 30 Oct 2026
 04:54:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com>
 <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com> <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
In-Reply-To: <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 12:54:37 +0100
X-Gm-Features: AclHuK-sTd0BhCfu01BaFX8UFonq1_wSWaurS4GV6csh_oR6EIVobO4gUcofd5o
Message-ID: <CAOQ4uxihz0G5jAijCOqzipLZ3=-iPd=8AUgxnwZYvFm+Dpkapg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:44=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> > I am asking because I got some patches for overlayfs casefold which I d=
o not
> > prioritize because I do not know how widely the feature is really in us=
e.
> >
> > If you are interested in reviewing or testing said patches, let me know
> > and I will send them to you.
>
> Hi Amir,
>
> Thanks for applying the fix. Please send the casefold patches over;
> I'd be happy to help test them.

Excellent. Sent you 3 patches.

Thanks,
Amir.
