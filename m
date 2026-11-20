Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133587;
	b=jsBTkdnuTvs9RnfkfL+S6Fb83iyweMY6UL805+Bl56HoYlojHU6JOxCpBeAQkilC5dpR
	 4ZNrVSfVHXviGs8sQEuC6BBWy4/fKklH5ADf/oTy10cULyY68JLaT/1+Crm+zrhHMn3sQ
	 GCQ2rXm4oRP+dK2+oNhioTez9RV8yRy5yxZf2erbtYtbe+fMPpCa5L73q+QrcT3yxOp4P
	 ylttWbQmsf0Tl/BnD9a7J97paNsL1pGNkP8TLVjfNHtoj3LwztiGLW4r9SK+2TiHX2WiS
	 Ge0GVqes9AA3sFMq6QsRUZXl9zZhbrfEH6+Lezkd7Q9eP6qQbuI7SNC+skXLoA0Qvcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
	b=S01rUM94ciOXsm9Vxf5kZ8b80IHFF3aL1b5xyFGd+A226etbW8o63sxbZTHnPeW6jf0w
	 2tZe/htCpDEgNsLUOKy7jaGFhbk7ebK+o3qU/gE560kKml3ZWxu//mhQp1byEb3+T4R2x
	 87fM4vIGtd0aApL9Fw3YSAV7wPElgaALe9rDLVwVX4IXjnMspQ/9pSn7dz+C12FggOexw
	 Cb5uArTFH7BoxCNXZqQMO+00KUpajJtVPDXt/ae6WObbRKfpBmizVKmHw1fNr0O+IZZc+
	 iaGmhB60I0Zm5zBZQ5iyOtuKyWfTe5I6yk1/zqybal1X+XNcrO1B/679HK+h2Ffg4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPB9X4X9;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607D606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0607D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPB9X4X9
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364648ae07so4013521cf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133586; x=1795738386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
        b=SPB9X4X99PCJkOzgmPj4UGRhE7afdmtnkVry4+D03EDd4zGfx1I4hoDHolxW5E5B3T
         vR/Wexx3zKvzmcxvEc1/Wpw2iVtWCQzTHwu41knk1r29HnGyGqU4SHejC7o2mu/dfNXe
         9SEkKVXtYe0/12eFNX4Om6B5NkYRqtACFsrOW9wD2TcnbWnVm3rF8xTVw4GU5drzKmTQ
         EWpKc87m3or3G0etAhvHov56qU1MqCx0pRO7H5g7igyw8ZxulNqVnpNEyxdU2xp5t9h7
         ttKpkoMGMeAOlA1cOLtkvTJsQmNYBibWKQl2m5mQBwlLeYDTDmy9pj3ZmxD7y4VFusWQ
         a0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133586; x=1795738386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
        b=ObtPZozLbgVHk6ZS7HfGlW/170Sd/t7DKlfB48phXrK1O/tGoL6xbIoeUdkllUSxq3
         wZTqwDQMz1nrbGKao3CbvJ4KCrsXbW/zxmL41xxsHcekGcsMn6hOd3qA1y5Q1dIEmPna
         k7oNI2dVh9henAfGVsoi0rWKSX4io75XKPa99fEeU0qLEX/O10MdLws2+YbXjj3Mp+7m
         2aJx6cKRtAkIXu/sK4cMIvp64h8J5C1wL25G9QhZNfY4ywSSUJ3XG1cStTJFHgLEybHv
         UQ0TVO2SlAnME5iejsByUszUls/SZUQBVTKhV6GtzHnFkXIoWrejz1pfOnAQ/Y2rIk6+
         LzCw==
X-Forwarded-Encrypted: i=1; AL+hErEv+h2EXBWv4Y1gEfZlxfJqXhmlcjhj0Z7MTPhWwWmj+L5KdOObxdPUFw8tyG2EPS4PFzOChpk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cOEsqbWoGowDMWy82RM/8fD4Bz202htpVbTRwQwpfQA0kyjUX
	cI830Q4uPDVuLGmHNHDDk/udgjn00DRKqsXU1SBpjs7+1ey8oddURWn7
X-Gm-Gg: AZFdTZfNWa7meDWsaLK5J7eBTm6lvmoyQKZPy3clY5K0hWQkDWag+NcltmrOIIY3u5x
	V9ru61QACRr2EQcPi+uXcsWliPAFDSVrUx5zOmI+MxRHnKlYvR54bu8s2wLog/q6OpORxp+OKne
	CuS4H1Pn7q1QcJDj9k3//9gleHgRdwUH9ZXbVMnB0zxtdzPJph5scf4jxoDfkU5V0wJ7PryTLQ9
	GsWEZdSg8AFh5h/ohCGF0b/Q7Fp2HgjObHRJCP4/pII7zhe3ONUEUnVtlRqPKoFhh6F2KCXGgmZ
	3+3w07Sh1RI1HCACEfaOv/t+IDSaGN/gzK2Hu/UANxMrMYVpSC75VvzVFgZ+rk2/O6s7o/OvYWe
	JlS9IrXJRh3nAy2+3HUWC0bR5gOq/Lcd77FK8tlsi8gtOY88YcsNqrFUmT/Z8pzVyWW7OQMK0c+
	kTbdiH/8ZmxlPJXx5N8UbRftb4XhUvGhgTz26GrbwgHxbIkDH8ul9CuHsGEUeoHH1peEUZnhg+I
	v6H71g0Awcd2pRH57M5h+j+7eQBXuYCQ9tAE6kGu4sjZk+ryGn51aJozVP//vLncn1Nqp3dSMcg
	muwPbO29ozgiKRrinJFjJpvpu2EJlyZMV/Cno5CWLlKfZhDxAjK7ImFw/GxtKb91GwXKBp7Dsm6
	jhLP2/BhwvGYjyHrVU3ZiqlYRjmIkdPEu65Qu+kj4G4KqGuL11tHeeilLfK4=
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id 6a1803df08f44-92134b48c88mr23359986d6.54.1795133585733;
        Thu, 19 Nov 2026 16:13:05 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm8311096d6.41.2026.11.19.16.13.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 16:13:05 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Thu, 19 Nov 2026 16:13:00 -0800
Message-Id: <20261120001300.11809-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119014247.119946-1-sj@kernel.org>
References: <20261119014247.119946-1-sj@kernel.org>
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

On Wed, 18 Nov 2026 17:42:46 -0800 SJ Park <sj@kernel.org> wrote:

[...]
> But, this could make has_schemes_to_apply has false positive.  How about
> calling damos_Walk_cancel() when has_schemes_to_apply is false, like below?

Thanks for the review.  You are right about the false positive.

I tried your change.  It fixes the hang, but has_schemes_to_apply is also
false whenever no scheme has reached its next_apply_sis yet, so it cancels
the walks of activated schemes too.  In my test (one stat scheme, default
intervals) 18 of 20 update_schemes_tried_regions writes got -ECANCELED,
and two selftests fail: sysfs_update_schemes_tried_regions_wss_estimation.py
and sysfs_update_schemes_tried_regions_hang.py.

What do you think about cancelling only when no scheme is activated?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	bool has_activated_schemes = false;
 	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
+		if (s->wmarks.activated)
+			has_activated_schemes = true;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!has_schemes_to_apply) {
+		/* The walk cannot be completed while no scheme is activated */
+		if (!has_activated_schemes)
+			damos_walk_cancel(c);
 		return;
+	}
 
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
'''

With this the hang is gone, 20 of 20 writes succeed while the scheme is
activated, and kunit and selftests results are the same as on the base
kernel.

I will send v2 with this if you are ok with it.

Thanks,
Yifan
