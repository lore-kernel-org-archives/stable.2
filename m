Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283756;
	b=RWeAEorwdbvd21m+R4iTeCWRR5XPytRfkPTKKK/Xvwfuz9JJvGWqtUIPCdbS8yOZGoVN
	 4+58DfQWcQYjUDxx/DzS6d8PMOd8f11IAuJMGTajPX6s32A2dQ4uRXlAwzdTXwOKtm+T5
	 EH2GtfngGgOjuihj50IgopDT2ky+G62ygxIKEpg7iM2UdV6EATI8IFhcNqXM6FHCvXEuh
	 sAQuJbwpCk/Y3NNuV8Rn+dkKiw9qIG8TxHSCcdm/srE31e6O0QO1JcPsodAaaH7QIfd1U
	 yVkW1onhbgemySeQ0DlIKIt1bHhDDfZMpCywOk7lAxY2iEihyyp+pHIv7I3NvaVPBMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u0K9x4xKKo7OLyxedAFnX+Mg691NejjhQmXoNihJhik=;
	b=XxqTGPE0SIE1g6+oSImEPgudexXnG1x1IZXRDWDqYtCiEpLZjfe6F8ac6XfH0q5wnEN5
	 bt+0R1oxN9NIv8/ynsR+idT7o5ZgsY5p331umWwrh8QJNMwedp36E+RKwaoFGKye4ZINf
	 O/C/7PQt9mbBaU3U6V1xSROPF7kAGQb9FHmjZVwYUCAtQDRxLsVzA8SYj+P0MJf48fUZj
	 vSSxApTkbbWnRVCWBA5sFPr96T5OA6ktWAR/pv7zlKKLzQH4o0dt1LgaUui20As38xsR6
	 oDW5TH2/UdFa+d58VQxjvQ5Rfjs3MwdbO4q7yRy6yRpllVUAxETJCHHyYhKAZCjwjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuzFi0jk;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D35606A904
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D35606A904
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuzFi0jk
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab1a37faaeso2864961fa.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283754; x=1793888554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0K9x4xKKo7OLyxedAFnX+Mg691NejjhQmXoNihJhik=;
        b=EuzFi0jkbVYVr0LrRKUy+uWMKqPgS/L43tKbb/HTqUE08NVOQKvgCLZVE+6VGbL+qe
         QMLLPN2s1qoJASVPGTRSKG0+dCEIEmCUD4sQkmtym92VIo2M+mPSysBM+CdTtrYeKU1B
         iRKlKe6HQ7YpcAkRENH5YDUDUU0y3xShk/87x2JM3DjfNpBrfUkmc8B/WyBBpARyMDQP
         VFFifcKZwHOKpXh+6FHRIE2Ze1CcWsYmU3RSHxqrouRc1Os7zrcZypTU7b9JtuO8JB7K
         lrOytrwR29V+g4jhWH+gq0eJB7yo0PLp56uTQvvwwTaPqmdMEaA0X6tKoanAdGlP4pyl
         VSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283754; x=1793888554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u0K9x4xKKo7OLyxedAFnX+Mg691NejjhQmXoNihJhik=;
        b=J82MZ6iWFDBKSsYBRnwHUR5CTuy7zDGI6GZiMQBb2B1OvAxHwNDjAqH8DD6HLetSxb
         EtanKQrIyRHAj3j3Dst1/uu0FcESpGz89vbvmnu3zjSgvPN8HWsiicCHbhyNd0yDSe69
         DcKagb52CFMqnww+vDYt7rrOHEv9Sl7lw29Cy9kK4kBA9NGYhddoUUS9I3eg/Haoqp4g
         O6yi+yf22Wm4jhnHu4YM5zBVrSLe5wytNTkGVQCKYh+ofYx4vVxWp24OVO/J+1tUh8YW
         ENETzxzrdTbz5qwJhb8iUzLrvl+l1GG0KzJw20OCAYbb1ZPe7NWT0M/J8UIe/cmk1cYX
         u4Vg==
X-Forwarded-Encrypted: i=1; AKwUvBx1bdEsY0mTq6iFcP6zy7DvU2Xu1IecI4JJfIzzIaqdMwWGeRimgC0nke717GH6h6uwKvmMY0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW8xfoaOJJU2e16JbHwY2n/LYemyxs0A5Whz4mPJzWuig8tSey
	YeTOHuS6ZulTUkcVf0nfRf6/jHGqlFIzCD6lHtHYbXnBT01rFop8pRNi
X-Gm-Gg: AYBFou2DyN5Ykntmhxx6ujE60EoaEPBijyLfl/EOTU73sWilf+1nkZo/FUxKBUpp51S
	zc37F3K/5MKQoKn7ue/LTXqvg+0g71bYwotsxtZt9lSr/R/hmw2UetlXTavfGTp+Gq4otKHxEKz
	COa89fZn0kNzcAjsyH/p+SUDxKQPpB2fT3haNB61vTIccJS6+ZYaJcXhh/rCgxvP0mhiDnGcQ4W
	tfAQIrc5ywEJEglqCCuDVSErbO/HBOrnXZvv+Gks9oc5KWPfSrLa3NjH+vzUV/d9KwpdoRKDEvp
	BP841ErtWl9aqGQnthpZ7rNxnxLOxz16jzB0YH7Qu1Vb1Pv21ihFKAm2rLJE0C1y1GplmPqkEmV
	LiHJ3ULcSHQ1N9bV1rLyxe/BjyjEk/Gtz4vIvTFnpNIEkCsScoWI8vssIpfBlDzpVaTu9bFBrU7
	rGXYlb+6YkHc3kp4FvDD2Tjy0rj2EkWQdHrBiWBxOlx8Dm9Qqg3p02A3pUsCAQOmuIGUEdh0j2/
	e8QsXurlIR4EpwhHEIPcbJMCRqrADMKnaaFribensNOQK6cPo+3B7818vuj/Ysa5gvPclwQeeCx
	FGC3DyHiqOZSaUZvA8VljqaxEoGREH7SGdU6XA8PGM5UiwfxnA==
X-Received: by 2002:a2e:888f:0:b0:3a7:812b:d11 with SMTP id 38308e7fff4ca-3ac9cedf30cmr10647271fa.1.1793283754176;
        Thu, 29 Oct 2026 07:22:34 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm37558751f8f.32.2026.10.29.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:22:33 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	takahiro.kuwano@infineon.com,
	tudor.ambarus@linaro.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: take the flash lock in spi_nor_restore()
Date: Thu, 29 Oct 2026 16:22:14 +0200
Message-Id: <20261029142214.3701995-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004104311.2196527-1-itai.handler@gmail.com>
References: <20261004104311.2196527-1-itai.handler@gmail.com>
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

On Sun, Oct 4, 2026 at 1:43 PM Itai Handler <itai.handler@gmail.com> wrote:
> Take the lock in spi_nor_restore(); both callers are teardown paths
> that can sleep and neither already holds it. Waiting is deliberate: a
> partially erased sector cannot be undone from here, and the wait is
> bounded by the one operation already in flight. If the lock cannot be
> taken the restore is skipped with a warning.

There are two mistakes here.

The wait is not bounded the way this suggests. spi_nor_erase() holds
the lock for the whole request, so shutdown or unbind can end up
waiting for a full chip erase.

And v4 still skips the restore when the lock cannot be taken, as v3
did. In my reply to Michael on v3 [1] I offered to do a best-effort
restore with a warning instead, but v4 only adds the warning:

> +	ret = spi_nor_prep_and_lock(nor);
> +	if (ret) {
> +		dev_warn(nor->dev,
> +			 "Failed to lock flash, skipping restore, err = %d\n",
> +			 ret);
> +		return;
> +	}

In practice that only fails on an RWW flash when the waiting task gets
a fatal signal, e.g. someone killing an unbind stuck behind a long
erase. The chip can then be left in 4-byte mode for whatever runs
next, which is exactly what this patch is meant to prevent.

Sashiko's review of v4 flagged both.

Please don't apply v4. I'll send v5 soon. It will still wait for the
request in flight, with a commit message that says how long that can
take. If the lock can't be taken it will warn and do the restore
anyway, as the code does today. That can race with the operation in
flight, but only after the waiting task has been killed.

[1] https://lore.kernel.org/r/CAFpOueRGN2TSNo+m3319qn00p-BYn8w7OQ6OPt4XTcVG63-uUA@mail.gmail.com

Thanks,
Itai
