Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966946;
	b=FN6UA0qLMed7plxVbwqGq2vzOkO6M86HJqVHHuBdKt/7a+W2i/pBU4ehksJWl7WYVdHD
	 2V67qJLBD58FdTKqRgY1khX3sJ6ZcZVoChMzkjGCzjoDuLuOqx7kB31FIXIZJVBuyjaqn
	 DvGiRHB58+eh0Clh6nwDHkYgrtya42RTrFxvlOCfolLIYDfSkFl28BW8u0xdUlVEF9QqQ
	 D4Ufhzmx7RURbpa2oXvidn1o7CyG6xTMhdtbPKM5uRpS79/dQ6v3YsR+NALCeSJfBTKD3
	 HGz+7gIKv6no3+fwBghbf8wj5AR+HcwEyHPtPP196tivkXeRL47gnKtHTyQkhfw4BnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
	b=bx4zP2SxgGSubTaV1BMHPCB5hhf+oWBUWn3u19ggPCvZG3bhh9NEwHn/DBwLFjm//df8
	 eQE5pNPtrGRnT7JmmsUF2ZiXJptFqSa+dccjKYCZBT+RblYGrwMzLqqQjdNee73xFDuSM
	 EYIGeLOXa4eR5hZv65P8Tth/EDE9XXv8uqqbdIcOV4p2hdCYBGVh6hCYRIHSdV3vo/Vfi
	 EZdvdTFWqGRnKBBRdIOtU3hmIOjJnZmocxCUwaeXQnHIphkSxZ7aWUbhORYhhhRQswIMI
	 k9iTBV+tF77HfV9IwstINB0dqswYNrMwfED2puYEowE6KVB2Fczoh2cbdgWOKXkakTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaS8sTxH;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018C606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0018C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaS8sTxH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso22360665e9.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792966944; x=1793571744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
        b=XaS8sTxHo2+xHpwCMV1K0GQnO6/WX4opGfkaK7URg32qnlsMedOETS1m/jGTCniFZm
         Z4r/jlNUV3FVT38K+somkS0q80z5VRVbH0TV3tUkRo/gSjspQuOOrZ6JQO5jdYNANgev
         0EmfP8A9arvxFjvD9pRn4ijJDRyuMZYxSC501Qz7D5F6tGvyB77kQXOhn7qNf1Gw5CoS
         o5T2GNO9wbYKXh5yLDxTnqApxkDPj0gIqgdoE0RPmz0N7LV+uV2ZpxCz/nVQ3NYpq2CK
         vaYzr9rBeC16R8SL0/RAHGyGD3twD0dJosB+bfSJsIb53VQWoch+AZznGlZjodIg+hyG
         ocYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792966944; x=1793571744;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
        b=BpNQ0oKAY8J9Gxf2loQOT0mhF3PyeSBg/+K+pDhNpCjMKQLGhc2s0TwoYlXrwiHfga
         mrSgyvo3cq9u5iddeDsDDOjMcX7m3c6clnFHZ+dbl1lRHO2NnYQItVzQwyCgWddRaE+v
         /a4xmtJxtVGH2jtMiThNo/tE3LaIh/aXeTNXEzhD25Vg1ycfLCGp8vE2j6vXNx5OXrmj
         GbNr/bHIj3u9VIsXrynLHPZQlty0DTVuYTe6LZyxC5yAOkHI/LaN7y4uNnq/0qKAug6K
         5D4KV4d4nY51r1VSZZMa+TGMphXuMZglI7gD/JrnuE10E5Tfg9hvp6m+e3h0UQIXzjIr
         dPmQ==
X-Forwarded-Encrypted: i=1; AKwUvByGACLVVwF+xZfX2S+wL2J3feojKGQyVee7VQx0N/MrYyhEB3vNEjdildGA+1yyb5Tt6em9ElA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXBGnoERvuZPGIrrUQ03nvvwgOtxVC98UDb40bATYW+WYUZ/kB
	3vgHi8lMQYWqKwywEv+D4rmqaTmy9dAan4hH7VQM7u5xy11yvIhZaHOYwnwC
X-Gm-Gg: AYBFou2wNLFlvPYT61LDv40yhityeR7WfC88J7waKSD/QwyIAC3Z7E2tItAWecIiQHW
	2tDILVPKDH+V1HvhLXVcoWSevJTEFXu59BhmK1vsgwQIwuwh4LujSMsFsLay/QvQDXX84+db+Se
	KfvMpoxr73roIidLDH0JoL2f4U+2x1kx6xzN/VaNxuTfDIDw5OD26eRifttCecGtMHoPI0XSP3m
	rEmqCa4m6/TvEgGD8KZHt5Ha98Us7rvofaR8yp6bj1qVlBw8PQOaqSCQqbbp88o8Ww4EHip2MHW
	SLCSqjPJVm5eJXoYZHvgZiGUVtm+6RLZDpHfuUvOu2AGYw7vuZeCD0tfGZ0oJMUeB60u8MJRHgN
	6D6HYwOT7KA+LLO3IAG2vKICvy4u8EjdE+DnNx6aR1XPsG+KIZXn02vUKF0DT3jnYEtBMsP1RZs
	ZIzaVYs7e9cQFih+56BQf/ocBw6FE8pqQzco+HdUPUyS1DOZ/J+B2rX5SEZ7+L/dqZhKo4Aiktn
	G7KkX2r6aPld9xaaa0TF/7nX3BoN7OqzgvVYA==
X-Received: by 2002:a05:600c:8518:b0:4a1:a49e:a925 with SMTP id 5b1f17b1804b1-4a35acebf0bmr87766305e9.35.1792966944266;
        Sun, 25 Oct 2026 15:22:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3da7sm13306612f8f.20.2026.10.25.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:22:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
Date: Sun, 25 Oct 2026 22:22:22 +0000
Message-ID: <20261025222222.1064464-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278529389.3327.1530536500905686255@kernel.org>
References: <179278529389.3327.1530536500905686255@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing RCU lifetime
patterns in the seg6 subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
