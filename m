Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371390;
	b=vU4WWtL6o3q5s449zWlkmriDxcO+3Tbme8vrK8h62luzAwJr0YrLe+Jr1JqV4uSDlsVH
	 Kro0Ys0bm2c21GTGnhZ+Z4tICi4/p59JjQME7AxVUqPtnMg/343PQtMssKUhcYQrO8XDF
	 jxDIu8BFkypA6PpmqA1Wfn3VObsw9kiQmoe7IwGWYkRUVcb4hZzzqFXnKsk2G5dAeeglp
	 V6lYAp8kZIR9Fb2TKnOIoTND3W3EG8NyprIJDheDq6i2sEqlnfSLEG75pSesXvvYwPkxS
	 RYz3t92cbq3MxpHJkGcuinWpG5ypp14KFcrYRBR0ITjxiQ2yAXapBrUgGzQjoFcyNUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371390;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
	b=GTouBtTtplgjZBBnj5+LF/bzxQwG2gMatIDP8fw2IrPbmFVb0Uz0xlmM6uAfaswqsYwe
	 LrAMBtGo+jNY8eb8WxoyhKyTYWN3dj1GQD1n+zu+Q9dAcYSzJ5/djmzFCmkzT+X0y0zMZ
	 aG4XO43nyLZs+k22x44wS5NWZ8gZIKjK049N+nRn074FKs7TdoOt+EUhEuF1EGpqZg1Cg
	 qHVQYW/QpzQDYMscm1sPnKW4K11u8NZNfJqinLN95dJHHrTbpaX58vJ56yAY+cgKYs5LV
	 7gSJ7Lbe0DNjUnuQF2cTFpCeNUMyLxKnQ3bPco0El04NoSFB0LN1clniy/a97adOQ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="i/kCXSSn";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rCxngTgI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C2606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA8C2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i/kCXSSn;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rCxngTgI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795371388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
	b=i/kCXSSnhy4AVySUQ8LxGhowx96vsJjlYXKs7alDhWVqfcKXL3+cdmBSAH1sAU/WTF8T6j
	XVJH9ZfifMkBhulLIBC4nY1bE1KOqBCfWWNRRu3cAFfamT+FHYsTBFVYTvdOqDdrvJNq6L
	Jq8Cw3sWDKtZPBMKDzxXOPSoFxOdH3I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-9GI3nE9aMQKuRoQDxzCVpg-1; Sun, 22 Nov 2026 18:16:26 +0000
X-MC-Unique: 9GI3nE9aMQKuRoQDxzCVpg-1
X-Mimecast-MFC-AGG-ID: 9GI3nE9aMQKuRoQDxzCVpg_1795371386
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a5d57a8d51so2833783a12.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795371385; x=1795976185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
        b=rCxngTgIyvjrvdeIyP27cmqJSxpMzxGriNTQdQ3Y+VnfGCo1B+/zfE4gLaY/xoIfqq
         qsYoWhNo3BRI2LGN6nvXJkh6y0iTy88u4zv7rHNQvmCxRQN2GXgNZKVgG0W/Qd/0u45B
         4sNWSjGdkw553JMqylmkeNevkGpyNjkc8aZS6OVoA44JIjf5xWk/lgilvWAmlj6CNfV0
         w5VPwe1R5RenIPKC/2xriQo0Jdz5q6tivUWD8gSaUykZDrzXV3frCYQX3jPZJoW29nWL
         0bVJ0hmoHusBqzfPwNB/VGtTOuRn8hGLNBnzsHeGWa/cs05P3JMrN7s8z/XcLiSB1duG
         xaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795371385; x=1795976185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GC86Rl5d7G64rmKwKqSKNiErJx76bLmpSfAVjHTh11g=;
        b=x0oJeYF5m/Fy1gZXz8FV7wikYlJi4dlFFEJ5H+/G/3XkELNL6pCGjbz58W95gzGiof
         G5/LNil0yAjbPvxqVxyrJJETqURTWv6HDNd0ruIcDJ/NeZJBiD+k/AvojlTGXLmqXQpM
         rN4EP6alqWlPr2QjgLluvvXkqpQRmaJfE6kmTy0AKtjrm7fegzy/cfhdimBAB4NohcU0
         8bz6VC3OUSr2+TOrZI72LP9GgiVDFebtcbfGv5jtQFjUhQc28D25Ycc7Dp1wGM+uHHC1
         Yo1kobHOxYV8BPfnp6Qf76mfVWU2RIadZkamOOHdnoWGBFGpEnT+r2kjKKKVLPegtxWK
         wDgQ==
X-Forwarded-Encrypted: i=1; AL+hErFJcmb6shuOwRtPn6OdlRZA5rfS4EWvVfYOk3mwoe0lpV2Wpy/Bh4S7kXFwjoA9IwieT+9G1+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1IxP+YBpE+bhga315+5z2NovudLUJV7OeN76SFaqNmg0R9y/1
	A0FXL+LKozPznruDi3MIouVamRWGhOHyLEIsNKaKNdtJzcQKuW48ryS03Qx+D6+9CJ1QNY/Gkqb
	omqZjfXsAsz8r0b/THpMMxKJOO/d2wxpKgXWI+PjXvREPDLxODCTsIDmOKw==
X-Gm-Gg: AZFdTZc4gpE+amlpg3LLA132E5ZjxkQ/QTmJ5z1c+VkArOMHVJSc1GVAqV5pmu5b3Sn
	lHDjBZrNu6cmKQmyLUTFmDME6sK0FXKGneBIkHqdOHls56qSIWpJY9BSGViLIqegrVubWxkMfoc
	J7X1vVM8Tfm4H7anIh4ANYPUOD3HjCP1M+u3CqogyIcvg8c3HH5zJDedBtaPcN4sw4oauZRkk9R
	nimKBPCMp8n5Jw5kE/pMrg3ZlHmzH/0up+BhQzKRvkTBQO0KvGPdy15y6lUNreeCO124mZTKY2C
	QfHzxEIbCdrh4P7huwz0drua9mKzDNbHbOVASFbn+GqsNuOuoMhrvOPKHQmIwzBrkqaX00BWWAv
	zFNXIY+w1BkeCjESxBnCQx/14xi1BkIi9tNOkXwKhPIii9/EyBQN1DnI3Qq69aavy24LM/FBFNq
	o1Ci+heTI5jPZ8RvEAfTIkNjyHM7IV1ydy4kylcBDS3XarcyaucskipBe1UB+TxJtF6ebWi3IL8
	beDKbgx4SY1imAhVAfccs7i1+X0hqjiw9Wnp1i+3Cl0RIfAN0jj
X-Received: by 2002:a05:6402:1e8e:b0:6ba:5993:cec5 with SMTP id 4fb4d7f45d1cf-6ba5993f458mr4312653a12.35.1795371385695;
        Sun, 22 Nov 2026 10:16:25 -0800 (PST)
X-Received: by 2002:a05:6402:1e8e:b0:6ba:5993:cec5 with SMTP id 4fb4d7f45d1cf-6ba5993f458mr4312645a12.35.1795371385314;
        Sun, 22 Nov 2026 10:16:25 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370faeeasm4410449a12.22.2026.11.22.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:16:24 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubli@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+408fcc361565713f@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: Use unsigned types for snapshot split counts
Date: Sun, 22 Nov 2026 18:16:22 +0000
Message-Id: <20261122181622.1294305-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113030257.1061200-2-kj2864@nyu.edu>
References: <20261113030257.1061200-2-kj2864@nyu.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaho,

The new array-length checks return through ceph_handle_snap()'s bad
label, which drops the message without fencing I/O. If the MDS sends a
malformed snapshot update, the client can miss it and continue writing
with an out-of-date snapshot context, risking snapshot contents.

Please fence I/O on these failures and use the same blocklisting and
session-close handling as for a corrupt snap trace.

Thanks,
Alex

