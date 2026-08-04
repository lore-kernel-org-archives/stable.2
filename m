Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D442BC2A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877662; cv=none; b=UYhL85sd6Nuv1g9nNarY6QfJnH/Kq6Nd0A8CoVNGH2OK4x5Ki2bMwBgW4DDQov+M+oJ4ZK0aTxkZKWL7kaNKGNSkDqNy9UHCvil4pxvmXRKlD3x3a+LGgTpGzaRfGHfJmpzm8/Ue37eCh0nKfPHhNP+fTTDvcYNn+A2irtzoFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877662; c=relaxed/simple;
	bh=M94F1PqXP2R4azTv5VsBrw3fcVY3YhyrZvCDUpvojig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McVppQqnG1A2ghzFSpL/oxWLelnZhzbAZ4Jri5QuMSZnfJU84f10WPhVL0EBLVm9tWKSl7oSs0acOi40IPyzFmQgr6e2aM1vC7+iXWU2RT2v0lCF8io/Rohkf3PPRK38kC+H5f6tzMQ5uBV8PayPQ1vuic2jkF4ZKiH5m7QIAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/JyTPzm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/JyTPzm"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1156519b3a.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877660; x=1786482460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5VUaS6lIR89fzUXE8jE1kCkmVqVFSCHPmmwJhW/Xieo=;
        b=s/JyTPzmzEy4CYMFx0MDLuGE+Hz9l9t0GpvdDSsuX6ku14z12aoaDR2OJu60H7O8VP
         1fl5KymTjLMPLGt4YuDWeSSUZdNkRrIWHhaB2fwnW6LxD33/8HSOxRMuxD36+cIAeSFs
         oAWrzA2+GfzsqWbs2n5swGClIIwf+vZo48iZgoxXV6+Um2UP1QeHj69XQ68xUcm6E7Zr
         Dz+nSSlWrsUXfnFYtukGJgoQ4RDl/bNZNIt2MbviTqPz/56gAHTX4OaF62Ipi1qUlPkN
         rJc//7Le8rHgmUaIxWbz3FO9JAeIRxzpT5Nj4qO5sD//y0RXvFTgzxLJyNXJAhhpoYG+
         PRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877660; x=1786482460;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VUaS6lIR89fzUXE8jE1kCkmVqVFSCHPmmwJhW/Xieo=;
        b=GIO6iK6Z/Petl9rzJ44qqPFEDA1tv7gsq/kq7HBzOZtl/7gyCMNgKVwrGpIYQdTu1Z
         oC4FzCd83CqkNc39NnYXpto3OYPSWs5rdX/X5ZkeBfkj7zlgGs33xST5Ye16Vx66oH2j
         svctEL7T2I6q8+l7y37Kmd6MvVNcLzGWqmNzXY+EWP36YrAApNTwrMYHyfhvq5axdBSb
         sWAtiO1CQ4O/DlTVWsLhngnGUK4Dp3DKBiE4qKyv9pTmgVhIGHEW+fFk/EzLEv+tEjGb
         nB1KC4WUs/PzwGdnMJJojzI1BuGqCkIvzm/HEpxPQSEMsX8UXPdIlwUxwIZ6jA2wfasz
         UVtg==
X-Forwarded-Encrypted: i=1; AHgh+RqXbaJJim0z+L/gY7LMfJuhYrlLFrC1sf/LZphaO14fjObVerMrsFeiNDyxoUkvUhSpV4FjxVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkGtbT4nzA15+AHAzDPbWtBIsG4T7m8TBcE8HqWYxY33u3CXs
	+orZWszy62HRkFHY/w1IjmDoy3NMb77JTYEFXrhEBgnz6mrZLW7R8Dwy
X-Gm-Gg: AR+sD119Kd2F9nu7855s4kv9vcu8za/8YFeQyM18IKH9sABKMG3l3eJ1kEs+IPdXvuE
	RPZOdFwIo8twngtafgCFiZUYOAvOVznLX5IBM3WtQJO33w1mMnOHFEVVC62EsiSNAhNadARzRno
	oBOs3jYYjDfBQpuHqho5kOcJjaDKoH42k+x4VFVhnAv2x5+pgRBEsSGGS7UBO/alnek3Yv22r7A
	PrnQcKNOuRxH5VID+kmolM3qFRarRdrU9CuqZrbGjaI/ibuKtOLus/zfNHo1CKomIQWzIGVYMBc
	7At6zd0MfNEe2dZnALlFm9/YY11cx9jxN5LsHzs/EUG5e2CQnIt0+BZsOKFZE46QLbpX51WQrLC
	R5Dn95OH4xODuPBbS9TJ+vB7UQp3zXyo2Rorzq+13Zw8dhkx9OwZSbTdy1PbywV9meO5leea6HV
	OcT4hfHHMuc7b+SSXoO7I7+TZTbxOk+HrapTjXe8n7JvGkuHg5Z4e6z7cTq3S6ewGB/AktbZLxm
	IOT6lTs3nlNDA==
X-Received: by 2002:a05:6a20:4320:b0:3c4:3750:2c03 with SMTP id adf61e73a8af0-3cb6c7b71b0mr5878476637.9.1785877660120;
        Tue, 04 Aug 2026 14:07:40 -0700 (PDT)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6576b7sm6062339c88.7.2026.08.04.14.07.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 14:07:39 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC net-next v2 4/6] ptp: ocp: Validate EEPROM board IDs
Date: Tue,  4 Aug 2026 14:07:35 -0700
Message-ID: <20260804210735.48116-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <4ef01fa0-969f-4ec0-997b-5f5f3f67e11a@linux.dev>
References: <20260803205011.1249-1-ahmadexp@gmail.com> <20260803205011.1249-5-ahmadexp@gmail.com> <4ef01fa0-969f-4ec0-997b-5f5f3f67e11a@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review.

Agreed, I will use the 12-character Fixes hash and split this safety fix
from the feature series so it can target net.

One detail about the suggested snprintf(): the size argument limits writes
to buf, but a plain %s still scans bp->board_id for a NUL beyond its fixed
13-byte storage. I reused buf with a precision-bounded conversion instead:

snprintf(buf, sizeof(buf), "%.*s", OCP_BOARD_ID_LEN,
	 (const char *)bp->board_id);

I have reduced this to a standalone net patch containing only the over-read
fix. I will rebase the remaining R4006 and V9 feature series onto net-next
after the fix reaches it.

Thanks,
Ahmad
