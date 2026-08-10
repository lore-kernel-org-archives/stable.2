Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D525A321
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367780; cv=none; b=mFhAI5Mt4dYg7z1+I+NdOudJVIduFgQWEhljanrSm3n4tu3t25EYOC1Z/ynRl8+PGebTiSIqjcWEY3em2bOJvtfodu/GXZ9intnp3CrIh33oGm7tyC4n6urACeJnVFrzkDFCxopwpeflHZcOEfa49QchKlCAjAF/ONhpN+MkNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367780; c=relaxed/simple;
	bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1Nf2Ks94BBiCb9kULybKSH7crRskMeBhRWFZSvkzVhhkbrM3t6ZOByno99LVg9lZe8YeGuNriWAiBYdTioUEPXdZKpAKiaYo0HPHo+XPP1enU1jaWu/FjvIzHO58PQ12L08RVDhTahejR3cC+6OLAlCu27piokMFaxbP7ojZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJWci2xF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJWci2xF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1154620f8f.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367777; x=1786972577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
        b=ZJWci2xFfkkumgx+8cG3Dq2PaOQYVIshRUqB/PM7ut95v2WhX+By4UsYpgszwIZ14w
         Cwt9aW2EmjXJL7QkpdshxYE/TcIOBHQ0xBbI4oUDsava3TrbifqsGfoGVXJFDJDrydA5
         sUPkt62OnG5W/u0bUbTZeCKPn9dSa41bnXwVSMW5AM5+uWdTVK2YULYpB6ZRWYuAnmiL
         irkNFlu7KDQjAVdFtOfWJd8BEsvy8+PNMUQevfamxiNmdOLNuBD988a3HkGTec8LXQEz
         hj82hFzXlO+dVKpmz52meg4BzuPLVF260UJS1W1KAAe0gvTU0dpIEytFTw+y3w1d87tE
         8M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367777; x=1786972577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
        b=CRBPuPnMjhGb+NBpghaDpwVjKgAfpZfxsfhqnbQJmvWi1l+9uwFmjfPfpdIYUpfU1l
         pOtZXoNAJLguQBHIudvyU6f/DoxfzG7FAnGIwyU/XjNxLahmp0h8wFNsForsRAu9B58s
         sl8Gn4rmLcEvRs9nSPmgVzu1GGQf9k6u9Ms6VWYO+XdqUYM4cvgHcyZ6+rJPwxSbRfqC
         je/P7hv4UbtzA/R5eBE4fr+n859EEhQk9YUvEPaVpB5keixmIXv1qJrSO18w4NQdc3B8
         CWk3pfx/HKqsHqYPHr3AhwaYGc8C2IPkDHE3zQNBuDzapJrEOj5skjHudymec39CE+3e
         CBIw==
X-Gm-Message-State: AOJu0YxI2IAbWL3+9pf1sifyyHbW3agoRcF0MX9V0h7z47RNTl2xfEii
	qVr5G/w+abJZ1jt5MTnlbiEYgfPbVp6Og6tIxKFVDSskWSdmHsodEICgEAE6H8HS
X-Gm-Gg: AR+sD13vIjfFhjOQviIYcIHt8FS+RJsNPeyJD5d7c0mIfgZufGmOgrpQnbA+eEKMecU
	dvv6heoYbDdx4X/U0BrqPitsP0BaCqgfYX2yTQYxpoaVrkV820AUjycKlz9FzSoaPYYdBjb6rJs
	beowb+ItPxePwhRGQkgpPA2cg0pk0krJA9onuOZq42CkiDcrdJTfbvNUtFd6ObO1CFi5SZ/C0+d
	6zysqS598mOiWQQZ152P+7Ns8T/6Sfw6Pb8i5lJ3pOJvAZ6xqMfnCpqHUQ1XUZtDRlGq2afh2IW
	gSxMagqZgiRR+43Ea4fn7gEj46GzPZcSMFi89eKibmasJWL3CzqpvdnIstkj/1/Y0X+/AMzT9vh
	sAzvjLeGENIbl8C35DG9YegaJxvNQE3KocovkshZxX2zdm54kACAsgXem8oqlXKL+Oin9UUdN0i
	G+yHTeEnsB2+vmzBazfFckRu2KgsBjENEu5AJR1j5dG7ZnwA2Py6w950zHRz3hscUFeiW5IceOt
	36S41s=
X-Received: by 2002:a05:6000:608:b0:47f:9662:85fe with SMTP id ffacd0b85a97d-480026c8757mr32089392f8f.16.1786367773907;
        Mon, 10 Aug 2026 06:16:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm32740180f8f.2.2026.08.10.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:16:13 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Mon, 10 Aug 2026 15:16:12 +0200
Message-ID: <20260810131612.2637858-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810123902.2611897-1-mehmet.fide@gmail.com>
References: <20260810123902.2611897-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A note on the trees this applies to, since the subject names only 6.18.y.

The loop this patch fixes has been unchanged since 95698ff6177b ("net: fec:
using page pool to manage RX buffers") in v6.1, so every stable tree from
6.1.y onwards carries it. I checked 6.12.y in particular: the code there is
byte identical to 6.18.y, so the patch applies without any change, and the
crash is reachable on the same terms.

Please take it into whichever of those trees you consider appropriate, not
6.18.y alone. I only tagged 6.18.y because that is the tree I reproduced and
tested it on.

Thanks,
Mehmet
