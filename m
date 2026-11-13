Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567926;
	b=zGbXHlpPY5zTni5LOn48eSvUTV05cXW6anQtakMUn9+7PwYLxOX+rvbso0TRfb2yY3Lp
	 y3PUEWZT4i3CR5RH4EDcMHd7UiNJOh1dd6c4dCC8q4i8eeXs72YwTenacybae6muOs+nO
	 a8S5NcGM3AF8NnaTZzBdwe0GuE0tG1Pjsh4FKbIN4deCeIPeR1jINF990ftWS4CPOyQUr
	 nR2hWt+makNOCFoYJbO9kmT8txlnpk3FmCLX/zmXQ5I2JIqhxoayBQpTCsGvX5Rlj8Qvr
	 fCGa3Uisum0tB/1Q1UZu3BeEb9SVc0dC939n9/ekymczWzbuL7ZqIQRVjqMWRhu1PGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xRGKkjeOSqGcAp5GlRiWRSP+3SQ9eykn8zcI3aD1Tfs=;
	b=s3FtiCC0ZJgoJamFQ4wEg3c4tC3qj8J/eL+crlEg+q+Uou/oRtl+4H6apW09fyoPID3t
	 oLtU/6/XprXCsMmAkmhiABZI/tG0UaZlmod6YNYsaL9fJked9J7qu20b+3y7qE0fXrU03
	 v3MsmtX+OATvcRWAmUnxzgfNtbKqXqboUVnjPsGMr0FswA8DehuQe8hbxa4cH3ZJ77yQB
	 G6I6LS0n/vip8afLVrHIdZA3VKNV2eXCoU4JObiuNkOCrWiuzCt6pAw9kc4aX2jDeVHtM
	 mR9SJs7ncI+vWoaSHtxpkJIEnWyZsFdqM5Ntjp3pRqsmbns5MYWiMjEINlUTzUmujKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kLPWmVAw;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C5606A333
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6C5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kLPWmVAw
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37628596783so1460697eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794567925; x=1795172725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRGKkjeOSqGcAp5GlRiWRSP+3SQ9eykn8zcI3aD1Tfs=;
        b=kLPWmVAwBLnXC4fO18rxl2C1rfM+F9LVv0lB8MIzPOD3yECFfO6qPjIJLMysl1OPKY
         mYWEA9bBLKPPPfUkxOOJhm2+V2YofnCtu6qh1M08XN248lenH/sbNmSBG1SWGMkrd4Af
         Q+mOQfagGr/OLQM1lJ1yGeGtGGwlc1lIZ4mWder3EYbKmwWpPK4Sv/kofKZP9llFGrLu
         VOXf+e4UW+wcsR6lBWKkXwiPfEJcNA5maL+6wJjkhfdE5Mrz8WqkA/OTYgJ2sA/2aXza
         lCh7lGfE98GrAV0SfMjlbL6zhAkV23iv59bkGUAFKPi2JoHGBUNL9hyXkY/e6lIghd+p
         qrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567925; x=1795172725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xRGKkjeOSqGcAp5GlRiWRSP+3SQ9eykn8zcI3aD1Tfs=;
        b=WUYmWbi6UacaFCqYjYzacKl8VtJO0O0FuqUKzcI/1Cbx7ldZLeb62aIQ+XfNWC3k1O
         Cif8JxatlMHEy5rZjDCC8172qIMc+gZA8gqPWZFKHTqczj6hJRqpc6iIv0p4/Ka+aIT1
         n8KLv0J4l/LnZ868300ljgGvIhzJpIz/rIBwxsoxOdwO+fCkVLI8Hy3lMYXXdPYkK4qw
         8dCFD4UsObWx7bYHhhODjaU+D7q432Npys2H/Wh5QbtjU0FBVbJ7unvvTfOYPp4EN4qv
         oj1IJqd15/py1K4PDUVEWDjta3tktb4xPD/PHZ/wBGAacQkw1MmxaKDIbv0YfV6KTVt0
         TbTw==
X-Forwarded-Encrypted: i=1; AL+hErHLVgRdaKjKM/JXsMoTOkpYFRZkBnj3wxUrvm8l9U42pcI/6rOQIJxmDnUl20VKv/1MuD8LxE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rKpE1JleT5QgDtBfahWLY4lnZsSz0qf/qsi1MfNKUVpWU155i
	QuVk+BQ9AVQo3rtnOX646OZgUYonjidVJa0DdgJzmtuQ5zrlyHADrP28dFPPJHZsUlw=
X-Gm-Gg: AYBFou1IFwdVYwPHX9N2v0P70hYR5D7kcNAZDZPNqUlMW6x0lVIMsAKSHbuWm9+66Sw
	/B8e9i8ThGHrBMQGCSWIP6oE8nVHUaVr6/aJIK1LjI96wSeGnTSY+CrL8W+Ehl7K6zIP+/Olgk2
	0D4Y9ckJ9KAfjK3D0p9pk2FuUIsjCH4KJf4tu6dnN6+Ge4s55UMDY29ceTbwAJdt/VvHhYsIxFA
	u8LQbn6fgkOQkExHP7vcM2JVORqoTrVQviaLIU7W6eEi8qFCkCwjtRwPeEIQy5B5zcL8p39oChd
	sWyvKinqWEJHzIsakPzYnas0HF714LGmCAnw8EhiFMBH0alkX4tleSPtbUjQ4/OV4cq1z4o7UKZ
	WBUkrEDO1HIcnHQDfcQ8hfPOeSIJSuTYQPb/DUPiZonn5cifrSOmh5DEh7ZgjF4r6HRM19KWpfu
	zcgfHoPL/zOaG5aqkt9KdJgNdP2tjLgoQALcaoJac9bTqPBEpakpbX3zBFSHSArT/E8obypuDMa
	MXQQLLNHHvC3PuT7JM91g/hDSwc039+zydy5MAyz91V2D1/o3KJpimrw2QqRlEcA62LMncd2TMs
	LrfGz9qot2QU5/Jzo2iPIkt/1nJuKxF9SSyKBYUAibYTI5DCn6LNgrpa+Ihp9PezdVA90p4Cy1f
	Hp1RH8Y/zUlJQJIC6ABe23cbYFQEzAT+BjotzBw==
X-Received: by 2002:a05:693c:2808:b0:36d:f004:ae6e with SMTP id 5a478bee46e88-3796721cff0mr1863856eec.34.1794567925307;
        Fri, 13 Nov 2026 03:05:25 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:7e8c:590a:782b:a57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d3e37sm7110033eec.24.2026.11.13.03.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:24 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com
Cc: sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] xen/scsiback: unbind the IRQ before draining in-flight requests
Date: Fri, 13 Nov 2026 20:05:15 +0900
Message-ID: <20261113110515.147043-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <353a0b62-0396-48c4-9e5d-fae5351d6abd@suse.com>
References: <20261109122654.30859-1-yhlee@isslab.korea.ac.kr> <353a0b62-0396-48c4-9e5d-fae5351d6abd@suse.com>
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

On Wed, Nov 11, 2026 at 08:58:51AM +0100, Juergen Gross wrote:
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks, Juergen.  v2 changes the code after the Sashiko report: it now
disables the IRQ before the drain and unbinds it only after the drain,
so I did not carry your Reviewed-by over:

https://lore.kernel.org/all/20261113110036.146860-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
