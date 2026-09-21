Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835334CFC2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964975; cv=none; b=nb9p8sZWC6N/hyetbWgaSDIPc6qwUjCjp6g/pZWdAlRRaSGOsJrND8JpAz573dkrQJdLEonWMoKDm1n5Q+qr9mwAyEohGja9V8/MutGnaZjmVEy7mInLKeuPh2woNvjwczeRtjnpsHTJv/mFnfMkEg+lZXT7O/guWuOn7cUhaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964975; c=relaxed/simple;
	bh=EZLcDrNg0p7u3xoE2NaBQYfiA5P6zOjGWIsa0ShloL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw29X2MbYM+nbwh6IiC2+nOxWzauWiDWXArkxHIRknj0xdDx7NIo0qTZZ3SXZy990taTFqjxQ39ygXBew1TgTohCh468Iq2X7pLmLZF+yIfGKyEXfCQjUOuVwldfSJ6bdCfRvbWn2SzF1CUTLredNGM8F5odYA5/mP/3fzvhnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=ag0UyYwu; arc=none smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="ag0UyYwu"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so1536081a12.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789964972; x=1790569772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+ARZ05U0Ry/4bPhSuYtgrWnaz/OcQpWLrFkKl/prSk=;
        b=ag0UyYwuzMXRWRrydL2p3etfZ4L4o86Mg19du3tKsa8Ujp7FceO7CVxALCsEJanTM5
         p2jXA93qJmD+qmCxeX+7vEtAFlobm2qGoXkAAT+nTXVoZyHzPXArbDFWYIYWqCfciRpn
         nkJWZ1PzCW3RZ+BER5B6Ql55pUXyDAwLKSJv4c4IPIJv8Exy9KiRERDvftn9a7uwrZx+
         HzddLks6gLFo1xFm0BsJ1I3lSITrHDnKbCAhpr0KJSnhC8W1eubWcEg9Z5XlnrWFxOR6
         jakSn3ab3yD5MPRfTf17eFHVnJGSiFKSo5Xrsy6YgtWAqwymV5/xl6dkgdugIEmSPOEh
         LUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964972; x=1790569772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+ARZ05U0Ry/4bPhSuYtgrWnaz/OcQpWLrFkKl/prSk=;
        b=OZ2tWDZgb+LdIo7xOsxagMY99U00NyXhguiFVRJOOVX4lflUuvl54V2ZZ2q6FjV95N
         Li8QqPvodO0kwCqVxp3IGdzNXsy49eMoONGqDYmOaSRffRAyOAts6FJdm7jYJSHPl5f7
         ZvOOUUDikkCV8bsZNFp5aMAYrmRsW9bW+R2zdfiiMKJJeLA5Le6oJtCv8Ov/tG12MsIB
         8x2TYFcZunw/ybxTAVnY53XkLYuSUzSsMRwFL8HeSyq3dUTGcRxuAWPq+a0PNBUtKSGh
         NZVl6Y4wNBq+K//xe6usQmDjR4ZlFCg+wiybmsFMWRahPdKaw3p0cxWNht8jvf1XtBaE
         /Lpw==
X-Forwarded-Encrypted: i=1; AKwUvBxYmFBRIiXO03rZ/haIlngEs6EMhofhdt+DlQFa01u0oKAQLaZcuphQwlX7VEPIvwnZ4PM+PoM=@vger.kernel.org
X-Gm-Message-State: AFuF++mlS4Z77lpaimoSB3lKXpMBOPI78R7St1HXEfS+uhC74TbbIGpX
	K/DhS6SGVVLqVWLcL3cHtYkWOkKtUm/CdB2V1EoGCR6OYxFiRKGCVhEHC3LLVZRQUgIvWgpEovn
	ExSdDyNuVYXg8hhu9qHJ5g54oNrcqFyqdUon8MzKicLdEX37pLNQ=
X-Gm-Gg: AYBFou2gs3zcGINWDHYkCWaKj51Zc4SP5XyOMtnO/JDHbDVq9jxT2L5f8ZCtTwWhyoQ
	jdoOarOkM7A/BPc+G6iJ2wK7BQVuPouWPlq1YZTTNmlQE7LSUUbBCzHA8S/wz0zaDiEeJhRD0zH
	3mZu83X1sHpEc3TkKqGBdPobeDLvT3pBwjQGTkjSRm6cjj6gYc0J2dPZhK6b8odNn/92RBscjVb
	0wGX4h6r/GSz/oeN3Znh2NPiXoBkDsk7DzFiDMHRQnrxbfrQTKUTRuKvmtPGicoyXR+JeVFiesb
	9ODJLZsMNaoAHqlyQKioEAmn5S2WWtaLxeYj8Vk2FvqWmvLu0iXTqWAWIRAK3LzqZ3LmXN0/AGW
	4CgiimpJx5yl6aYftZdLG97nTHnsAKKYQTiNINLPIBzMezRti1gHSzEjiT3LiKo1Uoa27d06/UF
	rs0l/lfOFj+Tx3A+QM0/Qv1OzfVqe4qv4+fqmbK3tlJF1Kd641sflmbdKnknb2wKDSmNc+NoRtk
	f2AbdxFjd4=
X-Received: by 2002:a17:90b:4d0d:b0:39e:6c6a:208c with SMTP id 98e67ed59e1d1-39e6c6a31edmr8745588a91.45.1789964971912;
        Sun, 20 Sep 2026 21:29:31 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144da432647sm25579483c88.5.2026.09.20.21.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:29:31 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	idosch@nvidia.com,
	willemb@google.com,
	kuniyu@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	alice.kernel@fastmail.im,
	gal@nvidia.com,
	jibin.zhang@mediatek.com,
	luoxuanqiang@kylinos.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH net v3 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Mon, 21 Sep 2026 12:29:07 +0800
Message-ID: <20260921042907.3658794-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
References: <cover.1789802623.git.zihanx@nebusec.ai> <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 11:14:40 +0000 Zihan Xi wrote:
> @@ -19,10 +19,39 @@  struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	/* Bytes charged to the current GSO callback chain. */
> +	u16	gso_header_len;
>  };

Hi, I think skb_gso_cb->mac_offset already has enough information to tell
whether the budget is exceeded, so adding a field for it is unnecessary.
