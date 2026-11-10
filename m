Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279752;
	b=LTPtG2t//A3AE/TzJ5fquP18l74yzim883pfJDOMqUf6P6sJE9XYGZLJM2akuOKFp/ZP
	 KF3xIoyTP4fs1QeUSocTIaJToEgfpi68t5Zch23hUje8rY5Av+YBp069VpmwHxQD0WnQ5
	 13hh+mRjjItLkwdZbsm4zgCBshXcqmh52wRgIDYSTQGy98s0CAWPpeRs3OFmSmwJT0Ejd
	 s3tbGwN45o+bS2fEuzSeVeSFZ663848jVMSy5sRy5+OagAwSWo8U7/Ej2HJYg100k3hCE
	 +vNlolj8hDE99JLedbwGTli23xLyMK8eBv+1M1ltruBRz5reKnjH3HCapHTLCydEDMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
	b=PQh4sz9zhc3xSdPmZbMBSXBl6vYorwn3yyhbKFMAGdfqAzdtoOfDZTiSq0pYDxANQe3p
	 6tWT5ykS/rq7YEpwNhaApABwZtAORMu2PptCrvn7h1A3g56JXk8n/Ff77Upr+CvLZXRr1
	 YO8CsSLu/sGl0My2UAoSYz2A01uCwSyOCzomqxRQXt7MSWDT/NykgBZ87AM0pIG8TsBrI
	 +91vgFZN13CMnQ2GwtJtnyn6WpxTTx/fQKuXg3KAh1/YgOa9ftahi4qwHJR3an+nNRBKF
	 /AVmTLN/bFzCNhy8V6Jhsol/KAlYpIed4FBwwf3g+6MGYTeJydPsZvrVQQcs/LxovvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74369606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74369606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a60f90a924so585740b3a.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279752; x=1794884552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=m6AHZfywnNj4tR4b0GSl9VsmXD/S9+IKtsaMttHTfmvLEyuNPBVaeyrC6lZybk4qL8
         AqMx4gh9QY3A2GXi3T3Sl1KNT/PYRt4E28B4bMgBHPvpE7qHNa9zjSUQsa8agsfCwv70
         rg3VXJLclS4/RPoqCvxawkhdJhW4+YtVb8a3tCocYcSgyb58EDQwb/CRyXhtZ7YHu50U
         ILsbhkOeFxUCYUnyY50nyNPkbmiub34akV5jNBJl99EPlJFmrpITtmnkiFhkoYI4kYmZ
         2yxpPHcz4RDp1ojO4rhUmZwwxUiuDbnGIAjqY3xeCnND7EsZ6c0yZI8Lm8NN6TZEN35O
         Ihyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279752; x=1794884552;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=omW9enik16Mg8ZItSSqrOaAiMpRQbLZRh8UAgNfDi1gTfkXyDlvS1nBV5ydmwG0OQs
         vvFKKjOVQBu3PMWozX+Og3Qm9TaQJ+E2H3N6wBE/kzGYy9El2H2ztqmrEfOLajGdU33T
         VCbxDZUdKFyBVi/Fp9a8+MsstgTJ3NrIRZ1QkeFHzhykZ7xwWEjrVtTuKrevIAH0xfap
         I8Nef7cCNC3T+gK4BO6cI2XCREvOODgzYtdYZYQw2pZg9U8WwMHURXVU+FPyflZiZRJQ
         UbogeM0DVsf1/Kl2ZsT4zlYvJHT055v4+j5mqEaXoaNBXGVY5tge3bJNuWxhpJe8cVAc
         a9Qw==
X-Forwarded-Encrypted: i=1; AL+hErGVc8+Bksgr7KSp0hGzPaB07Jx7whPxM+nzpmgXB75wOUwS0PpQcjzCpapUmMdmG5CDUoc4q+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J4Gi2wOVE7/+Y5r+so7R2jYKU51IT5eVO+TTXKPLXxnqNuxrx
	2+tAsxNHBlWtdKGkGoA7DySm1b3SZbUGg5d6tQVtDOgn12HrcD5URx4w
X-Gm-Gg: AYBFou1yciDC9Br0oOhirywKLcQ0Rw+2/EZfNfb6S6eOwR/x8poYFI+5IQOrDAtAEAi
	pVx/2YrNw2q5TLwT1YU4Gzle/WS2LJGNAPlfHiv3OXKVQ9NKyYtQYbT8Kz8xfuWZPEqC3buy/s7
	HhCmto52zvD+TZIRgCdDBhAdM/5h7eU5S1AP8oaU9Avyeg993oFuQpZrPB7hp5aOlo/zji0tz9J
	LG9nA0gZJeM2SR4air4CkXl4GsVrJddSdEZSHmJ41MguRWH+JvYMv0iPxq0LGHvXkm3d6xyqNtD
	0BsexQE01obCHbD/6zaKdHwEqwOvSQhQPXTHZqaWxMtmQ4JvyHwHwQvBk8QFptCFSAvAup0Fm9j
	Pe/oBMHFXmObgH87NKJSsKQDbxMOytHKQelJYoeg1PkMTkaVyYUXc+lfm68HNYz4HfAjSm8odH+
	J5VVd2lBuEmNJb/49TOBwEupVLv2GA6jLFIZBMqo/9NeJ9MQzvxPxMwfwoSE2zbjGo/a0BuEjxH
	P1DSRhw8sz4erAevI9iXnnon+nGEQ6lz89P8hIkHh0FXqz8U0+Wmy0d3raKqxqcTX0VOHK/Vbtd
	m3jzjvHwYAiSgmAOpqHXQRW8m3lAK/Amx6yc
X-Received: by 2002:a05:6a00:1887:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-8ba876454bfmr1402875b3a.52.1794279751668;
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab9d572fsm317021b3a.56.2026.11.09.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Date: Tue, 10 Nov 2026 11:02:26 +0800
Message-ID: <20261110030226.9898-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avJ4KM-Erci0FkgZ@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org> <20261109055204.31673-1-0xbeac@gmail.com> <avJ4KM-Erci0FkgZ@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 03:49:28AM +0200, Jarkko Sakkinen wrote:
> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I think I asked to remove this. I need to revoke my reviewed-by from
> this version.
>
> It's not relevant for the bug fix.

You did, in the v4 review, and v6 dropped the check again by mistake.
v7 restores it: keyctl_pkey_params_get() is identical to 7.4-rc1 again,
and the diff does not touch it at all.

The two early checks in keyctl_pkey_e_d_s() and keyctl_pkey_verify()
stay where v6 moved them, in the key->sem section of
keyctl_pkey_params_get_2() and after the buffer size validation, so the
error precedence is unchanged.  Only the check you named is restored.

Sashiko's remaining point on v5 was that this check reads key->type
without key->sem.  That is how 7.4-rc1 has it and you asked to keep the
hunk out of the patch, so v7 leaves it alone; the call sites recheck
the method under key->sem before they use it.

> Also if possible try to make a bit more compact description of the
> fix. I did not ask this for reviewed patch because did not see it
> relevant enough but now that this needs a new round, you could
> address this part too.

Done: the race diagram and the paragraph describing the early-check
move are gone; the problem, the action, why it is safe and the coverage
list stay.

v7 follows right after this mail.

Thanks,
Yuansheng Yang
