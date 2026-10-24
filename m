Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792858716;
	b=eGMZOAOUG9l742LNvR1GEA84ylGbTPRlC1z0Nh0vRinxp9iGjV8I3DCX2KixHjxKTzGw
	 ZiHMocRRKIiCv+/aQBogTth7ut3ULrWOJaTE4ofrQgud7UWzo1KDEC6Gn5zCdy3HKmV1e
	 zF4ncFfC3vITJKDH6eN09IeZbGd1IRUZxmvB8ktFHzotBszxY1S+8EYgE7v5+WVKjm11B
	 lCs6b1j3UsFRK9LQd4Z1V0u6JVyl9GT3VgC6EJVRytUJy8Yhsf0KcHXVBkB7ERoc/S2w7
	 yCl2a6n2BtQq7cBwHUoClc4UzX2+3R758LdxS0O3Jm7X4ZwDGUmJDTUpWJOi9xcnIuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wJl7a+8EQ6zIyPMzXI0QdmBaUpy3gczzvc67bhOuxfw=;
	b=MPe7hPN21kmoBamhy9fZv/hmeoCTf3uP1DZ5E0fTIXjs5/ybqSaGLR6H2O1XkfJgt01w
	 JuJk+hypDw5+e2CYk36aZTZfAPAZSpnDEm+KGUqAhtmMKkWuWaZ8hBOoqwzbwDOLIPnZN
	 xO4fRBajLYAV2koY8dGUO36vtThNu4AhPbPie5gU5SHp6ZTfsWQ4w9Tqvn2B9wccC0rc4
	 R1DEIXxp9UXuYaIukGMjSwLtPB33Dgn4lW3CpK/aLiQMhpWkW87Dg3Z8GZC3cuXvEYRWo
	 vrblZjNjyanenSgyIbcTsUZzjlI9N0DZXxSp1R0ekEmtO1UbaKRK7cjKLCB85yh5eIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="OlXmPG5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2A606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C2A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OlXmPG5/
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ad98c3fb15so14612537b3.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792858715; cv=none;
        d=google.com; s=arc-20260327;
        b=aUMq7V1KnnHvA71Cpv79CF1VfQ3PwJg3WSuJl8x06JDKBs/QIA29vp4068g8KVUNFn
         En29nHtJ9mtc9/qWxGmE0jrlf1BKWBAXJWZUxubxPV/eAaVMlH3yyUQEfCYekcR8srub
         OD4p5L7PqR/MVyMn2GZstIYKNm+IdZXdqXxS2ymG219to2E7xuV0N1ifXDNOvArqKxTy
         dn+NarNcS/6WbV6uxIJsws1pC1UCg9sLum2iRJI0xlnLYL2T9raWyvtBSOlBJUanonMF
         MAkGsso7Nn2zlZyyW08AFpied3jfy0xfbv8UwB13hBbEICNNzgsbukNwFzG3q2ONr9di
         eLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJl7a+8EQ6zIyPMzXI0QdmBaUpy3gczzvc67bhOuxfw=;
        fh=uL7kQe0Ej20I3JKhjIDqzLy0eOpiOV1RQmbQ5YX9Asc=;
        b=nH+Jn9hkth7oJV+NUWiFCLImNJyEtFrOkSYGaFMyd/3LOIErOaQLUxihpMKm41i5Xy
         OF7QZaXJc72yKT4+wPeNn+hNgJWsaIU7vEe8aWZGlbyLLS7Q8ZnQuRnm7p8VI49Pwguw
         t+S7lMv3ghGrDL/6bf3caQPcx3HkC78WmOvn6R6/gdtLQLjtbCGi4zWGXE6jjCiOPF1S
         et5HxV/ppkhcqhpob4McUhHqlsZoS/IGQfOK+bXqO9r7gkErX3JAeloLCbPKPy9PceCC
         e8MEt2SexoWk7r/LolC17LhBtYsRqQkPhv2TgPWLd3FKKtSO9MM+EJ83SjNYb9ALzISQ
         F5xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858715; x=1793463515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJl7a+8EQ6zIyPMzXI0QdmBaUpy3gczzvc67bhOuxfw=;
        b=OlXmPG5/sAKCL9I7yq00rAKjJUqs3lDGX6LAWPM12qMwvE2TwWLZuI969q24e+XN1k
         okGi8kuf7C7X1w1YRSajRzcFwtGWzOX9xA1fFTRPkhgYsldF6gr3b6gvx6a3cIxQ/B59
         lp1n0/CGsCt/bH5jPOj8/0TUUwS8ZBdoxdHSxBLFdu7foJ+9oIObAIxnEJKwMBtQcrQa
         wpkjXGXs6G3EdtIgwBH6QoTi4BUgaqfAfwTSU9JUU7arFcVL4yIGlwlA7gU+DUNbP3PL
         Jpqr9c4DkhdW9sOEsWXVxIe39Dzcs6d/K6m6dS0DlnzrqTVjLbISPmBlpUO+QWTw0kNP
         YjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858715; x=1793463515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJl7a+8EQ6zIyPMzXI0QdmBaUpy3gczzvc67bhOuxfw=;
        b=gA3yu210zPhJz8rr+KLMOXvaXsW7l+aumro+VoMIKL4GRsnXM4lKG5ri/RTG1b98OD
         lQTX8mHemIet7h5qxzS/xL9BsoTpps4GVSd1chGTaejgh4nq1eSc8dd1KahMFYTG03R1
         VqHN3XNZJbBFGc0v9fs5dengGeSqMFIMahEJ/vllzYApNOlvEw0+APXi4ZemFSyD85xH
         TdDZu2Ww3diLLBUdMRYfQfYOhE9RxAN9UzZgTOIgH41vQ5Qw6uAIU4BwA5d0+3jvT5FM
         4fzMs7NL2y2fkR2QYe0gumkbEAxmUEqw7L3NrV77SfUVSXirQvzFx9amwmQP0Fbrzou4
         n9TQ==
X-Forwarded-Encrypted: i=1; AKwUvByOBpi5QGMrIaHuZ5PbuLF68lEkTlhiJXPPqXGvvqAeeXekOSCpXRQTGai+RbRw8pF3tW+6nCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxW+FQMVdgcHAcO3J6A++kYFYVfe9yybxt0N5Qhg+eyRibOpuX
	C53+LJeCU6+Ug28ZnXoUt9V8Mq9OInSnb06RnVirTp2AZ1LKdPEmy4cXcucI1OmkYQaJleqmtgr
	/ZTNzA4un8ucPEWxwuxVLfZExT2qzPJU=
X-Gm-Gg: AYBFou2o5ZjqFnHFpcO4/kUIbi1OvjZ0CfLhqMi0dYvV4MOpObAOPnbEfNRPX0Ac5wJ
	+3xArSKc95qEKnQ3tEuqCtgyjcjpdxOeixwxIH9/4vxq3MleP1Dr9ojaGC+JmIZv+65oXWbd+Dl
	Y2Gibtc8V9x/jw8+8wLMHbf7/TKmFNA0jYD90ww4EeY67vIgdscCXikONdJmlDrtYrBiy4x3Kkk
	Xg+zNQ7t3gYad5VsH1HBXqc1ZEARHvTmUypFtY4qVU2PiuUDzjF3P2oYCDhfRzpXAIwP18OBQby
	vo/ZGhPZYYPVvqP8dLQr88NITYXl3hhvdeol7yfSu5yx0XEN5zXFQ4/PlSbrDyNchnpbpzHH3fF
	Wu4DT4MLw4uNJPPeeAEodOlpQXuh9qwlpZzyqR6q+
X-Received: by 2002:a05:690c:89:b0:8b0:e13c:2854 with SMTP id
 00721157ae682-8b1669e55a4mr18271807b3.5.1792858714927; Sat, 24 Oct 2026
 09:18:34 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0087-v5-4888399e71ae6d93613f@gmail.com>
 <1868bdad-cad5-4cec-8d76-af6f3cd92479@linux.alibaba.com>
In-Reply-To: <1868bdad-cad5-4cec-8d76-af6f3cd92479@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sun, 25 Oct 2026 00:18:22 +0800
X-Gm-Features: AclHuK_VfC0_HAFy2LMxdYARoi52mIFRU4CCMwSsyLqo5xk4mZaw1sLNyRN_7E8
Message-ID: <CAFRLqsUXK3rX6-uM3+2cMmSCPYMz9WxNGRXh7zG1+1YhNxTjgg@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: wait for filecheck kobject release after a failed add
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Joseph

Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8824=
=E6=97=A5=E5=91=A8=E5=85=AD 23:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Why not name the owner directly to ocfs2_super?

Thanks. I've updated the comment in v2.

> And "delayed release" is only accurate under CONFIG_DEBUG_KOBJECT_RELEASE=
.
>

The delayed-cleanup scenario in the commit message is also
explicitly scoped to CONFIG_DEBUG_KOBJECT_RELEASE.

> Thanks,
> Joseph
>
Best regards,
Cen Zhang
