Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2A3B2FC6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715571; cv=none; b=PjTLruxQ91wWLwS5j6Ju2WcsG4ahxUJyVAYlK5WKY2PhyZvE3sAX6/oeIt9vrVu7T1aLJyISrlqe28YwkUAgt/mTlO7Qbz26rn/opHO1fc39MuwCrNxP4ONkyp7eWdgCSF2GDDEDK/CwsH0enYaWuXizIKYPlqnEQpKplSPutg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715571; c=relaxed/simple;
	bh=M9xxP6XHlfNMV7GWnWZNCeEtckS3szign5mxnLwwcIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch+K8BaHjwR2v2rdukV0GKgeujRqenx/l34E9h6EXjUkerpKoAibhan5B61dFRTSOP9kKDgKRzS3TQnjxQlKTiP0bRLkIlwE2zgk7NkYkxpey+6D476XocnVkPAEld9f4Ukn2R3AqreTDFeCObOZ6uu4qElgbHaXMR4LwK5u4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqHWKVcq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqHWKVcq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so36270115e9.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790715567; x=1791320367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6zBsYuvkhCSldzaWUb/rJ1yx0lBA5YccYiihjP9u78=;
        b=MqHWKVcqTAd/lgzgSnDnRSJMe0MOojiTxaZu79gll0d6Vw3aLWBERIj5aPOmzDeCea
         y/DbhQufOgDOf1mz1z9Kpuahhd6ndsnVudDVldGwtF8iF8gEMUk+QBrhKYQ6AaHphS1O
         4Gmk3f4KtMUNsmLRsMaM1beSQs7g87Ft7WWBLUEieRUXMeDCXM9ieuk5RNodPIDMaHRU
         ST74JNm4Gx5qBEYWCHq4rOTXiT+hHEvRG7jszFhCLa05RslRAmTvJ6bNNzyU0AVVhSQa
         8G3imAAvmoGGomB0G+DVKi/hvQXkvn32085FaMILJui5q2Nt7ARoaGeEFRuxq0ajontd
         XTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715567; x=1791320367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T6zBsYuvkhCSldzaWUb/rJ1yx0lBA5YccYiihjP9u78=;
        b=qjhYWZTmOQDaaAEKor20ypbhrRglcDxxpPWjmrz7TfZ2IBIbtELJ+cJD9WH5SI6A+T
         SIKxEGd7hWfYNuzUtYoDsrbpXqHImmSKLBsWE9OINzD26+2IOk78uqQ0Q/LGmTVcv1rk
         YSjNkEQZ42+wzn2jxrbJkmitcjm4PxgHhWq/6fzvVaLibqpM7Jjpbq1FoPctsCPdxhOa
         ayu9fIqCv3bEMEUULJkPPrsfYuRZUjS/kK8BmklO/ncJX+NweryjYafHzMFAsaPPXUNa
         YfUHF60+uZd3kgcjQLlXoX7JEj2TSPGPoNJZc5+TzRd7+KywNtW7tOfPEWoA9Vv/aqEi
         sHeg==
X-Forwarded-Encrypted: i=1; AKwUvBwnhGLP9DJjFN6YFu1sWffojhOc34yuPdA5CfYtmGIVug5Ajqd00S7sgLRUg6nbxmTSjLqIXjc=@vger.kernel.org
X-Gm-Message-State: AFuF++nrelLZ9YgVd8wFhNWS6rUAWFl8CHomn55cL/+hJdHbPfjS+1GS
	Ft29D7cXN7OY5HZG8BiHFVpuyHpRQri7XcfW/FiN64YzKVpFxVsh5Pw=
X-Gm-Gg: AYBFou0aIYLMh78PFvwuUF8maqErfmMMD7OKtPVS3x1o7XgWBlr8ft1DZ8tjz22NTLl
	64IqF4U3sQwSAKwGXsQ/Hh6zKi1FtI0Pdqgx9EQ4b0MCM1jjJ5LZsKLRuEvIBjktRNOYn05UdOf
	ucUqj3bblJ1156XTRd8FtXayis0HtvD+S9kCUwyaR09/iFn3+SWdLrdr1ZZnV3h5gVyg6n9sv8Q
	BbF1zqIsg0JjaOYWi3GqhBiT8gRVOYxZep2UByRCVaamTJB8StcJldJuikTLQhzPPzeonKNzcQI
	weJ7oWFO4yhSR+nHiuXvCPWk1teLWHbRdmHTKroC9Awbohb4BQ0l3nTgckuwh2f9ojgoqjZ25l8
	/X3+8C65Bxlr/04KssH+TMMZw3farckv/2l8iBJaD8GBC8fZACAUnoEoXZNkfaVf8QySabUplJH
	IhFosdwmgwNV3VuY+eiQzyEgQWZOwf+TigPkQ3V9+rVcRh9aTW0bYubUfqeDEEgrMCzHK829RYv
	C69vVVzlSZcNzbB+FkmgPySIzMqQZ1qvhOyWarlzKjFA7JT4Y82ozketDgII18ydBDZBkz5xXXo
	mmoeh/4=
X-Received: by 2002:a05:600c:c48f:b0:4a0:dca:b78 with SMTP id 5b1f17b1804b1-4a0151397e3mr4412245e9.27.1790715566870;
        Tue, 29 Sep 2026 13:59:26 -0700 (PDT)
Received: from Ubuntu-2604-resolute-amd64-base ([2a01:4f8:13b:86d::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a014217216sm26857035e9.14.2026.09.29.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:59:26 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: gabriel@krisman.be
Cc: krisman@suse.de,
	hnkz.64@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	andrealmeid@igalia.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] shmem: fix unicode_map leak with repeated casefold= option
Date: Tue, 29 Sep 2026 22:59:14 +0200
Message-ID: <20260929205914.229355-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <878q4jyf1z.fsf@mailhost.krisman.be>
References: <878q4jyf1z.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026, Gabriel Krisman Bertazi wrote:
> IMO, nack, this is not the right fix.  There is no point in accepting
> multiple casefold parameters and we shouldn't allow it.  If
> ctx->encoding is already set, we should -EINVAL and fail the mount.

Makes sense.  This one is dropped, since Kazuki's patch in
mm-nonmm-unstable already covers the leak with the same unload
approach [1].  Adding Kazuki so he can adjust it if needed.  I'm happy
to test a new version.

[1] https://lore.kernel.org/20260827152516.805622-1-hnkz.64@gmail.com

Thanks,
Mohammed
