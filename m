Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041B4779BF
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060009; cv=none; b=Mkd4OL0JZtvmMBmJmgJ6rmB9Vr/ThiGBiq/o0Hx3T1cbLYbYKCnv+QZlgjPXxW+UyHOf2ZKIbes5q36WZ4GyECbfzUgQvJC6B7l08ajBonAaB3ADK4gfXYUGOfo/sn15dnXAsQ2TSH+OK2gNDH5TU8fFl0amQFVnw9xK5P6PpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060009; c=relaxed/simple;
	bh=liqrWoRZXDO5Uv8+tQs2nWCqYJrmIsACuGolxcgsLfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbFIsaxeSeMKtul22FO8xGzJuI4fLX7JKfITkthvnpOQpiqaG9YoLCTQfjfkAmCBc0UVcKDqNDNYz5C/JoS4rVGxJ8Zs3jhVtgQ0il08EvVbSHzGy3gr1AUxsYaRVuMSwyGoaQUidF/a+4fWBVLQXRguipDtpC7cEzoeKziFKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjLe7e6K; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLe7e6K"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-481412f1828so1579694f8f.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787060006; x=1787664806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=liqrWoRZXDO5Uv8+tQs2nWCqYJrmIsACuGolxcgsLfI=;
        b=WjLe7e6KZLTzKMhbS4PWWhgUeGMQst3BwMVi8iRzQ+6RtiQUbeG7TtGMspmEqpvPWt
         LearYMYntKxNGLoixsDdZjC1VVyJ8tuWIbwXkTk+AuUJFDhRfJ7Etxv5unUdOr0/+TsT
         JkmXrVZUZPKoX5DrTCt/XipIjAD1fyDUgO3vx3UwHyEhyrLQ0fWWs/ndLiZScRsY+7ph
         l6nrXs74ZgP/OwcYJNGQfSTNi3r6wLZo0Vu+lWixBqHzSLmPPBhdJy0b5IkiSs5UK1r9
         iccmF028anlFH8jDz3oFzfiinyuOANBQZB9c1wrifZbgg/Ji9yaJVoFoGOk3EEgBJ99e
         f0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060006; x=1787664806;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liqrWoRZXDO5Uv8+tQs2nWCqYJrmIsACuGolxcgsLfI=;
        b=LIZRMiig53BETUa5jhQ/4E0We6AO4WBAdL3k3FwPUdJ/YRcUlWBbnaKPphdLJh/K9U
         N1ZOfFXlMXXKydbKNFSYzliOAUydxaLU8VXCEjgI2CMlYriV4AOzI37OWb78qk3/Dccu
         vVNuBfKACiId+U0WE5oeRTTl6TUK2GN6ve76M1GqT+41CrYw53dqtvs7H8OsOoY5Ejqu
         tcowm/ggpQfweBlcSq5a1lmfSVzAZPmkXXdcaOVDQXEAKJsf7PtxEwDp4jCxmQ2OBdV/
         1cn78Ahnk0yJxYhxFNeRPF2Fsm2Mxh+5Ci5CyDlGGJ6hjL9od5Ey3p2pZEgS35R3rXv8
         QgJw==
X-Forwarded-Encrypted: i=1; AHgh+RobLBlNvgitlJkaLO6rSH/L/rUFYqwxjiiiCYZENEitXXlcTP8zTkeGblApR7XFtM3uJnTdmN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGaosxv7+HZSYtvglSpufHzaIdiAzmBqMZO1hWnlffSkD5+kv
	Iqx0QBT5pCTl0JvlqateRiU/Fw3IN9Shr1mCYdhHVLG5MwUMaZwX7d4Vto4J
X-Gm-Gg: AR+sD12Vd7i4AKBU/IUcvWN6sbn0WQhUitm0g/xSkXHjbTJlpGVtBfJXQ6vIU/h4rk/
	hh+rexyuyXNakG4WZJLu9o7mIBBfKqo3aLtGjiIJJK1Iw9fRwGcCBUWjRbLsgWPGittlQop/JIb
	FaEmpn9ANncS4NJ9paUaPmpROG4tmP3QO6Rmz3ptcjxrcd+cKUHbDTqK24eN39Pw6Ym6RE+fKpf
	fh3GTDgkdauEWnFj1tcu9RJlHfyJ+mLLkMXIN5aOWeXCqQT6SxIKazNXxK5VCAwBFuMjwJG5zEH
	34ajmfr/q3W3RPO31ldHIjCdb0/Ta8P2kSJSVRCib7C6E0AnA5gG3USrJKw+cLh9vm89btxyzIu
	DFWnZHM+apUPxbOILm3vLJdPjWcpMOzOu48N+edff3pSg2U1VXeBPPxAHC0eSHgHsDtAZVN39GC
	v7F4rNVHwKddIh3zFzafJqzo3xQ8A1aQ==
X-Received: by 2002:a05:6000:240c:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-4816074889bmr45465760f8f.14.1787060001326;
        Tue, 18 Aug 2026 06:33:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a6c449dbsm11513519f8f.8.2026.08.18.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:33:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Moni Shoua <monis@mellanox.com>,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Tue, 18 Aug 2026 13:33:19 +0000
Message-ID: <20260818133319.4128416-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2063d67f-27c5-4329-aaf5-39823f9de6ff@linux.dev>
References: <20260816104432.849996-1-tristmd@gmail.com> <2063d67f-27c5-4329-aaf5-39823f9de6ff@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yanjun,

Thank you for the review.

Regarding concern 2: unless I am mistaken, rxe_sender() calls
rxe_requester() then rxe_completer() sequentially in the same
work item (rxe_req.c:836), and do_task() prevents re-entry, so
the requester and completer should not run concurrently on the
same QP. But please correct me if there is a scheduling path
I missed.

Either way, using WRITE_ONCE() for the state and status fields
instead of a bulk memcpy() is cleaner and eliminates any concern
about tearing from concurrent userspace writes (concern 1). I
will send v2 with targeted WRITE_ONCE() writebacks for just the
fields that need to be visible, dropping the bulk memcpy.

Best regards,
Tristan Madani
