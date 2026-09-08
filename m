Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6B01D54FA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843810; cv=pass; b=bugDbbsU2Orzd2usAqjwXTMeas4BP6ulY7KYrW6PY8h58cyFK6ko6fiTvYhXjMadVQwKbO9VLHFgSdrJsg891v3TBYed/GiKTyg24XT1DxTUT68ifn41hJMxq1OxO7dx05JyOFfjIBvv0vpVO45RJbXVlNV3WbV9Wh08XGQxMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843810; c=relaxed/simple;
	bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOxZLhSfxyI0t8Ay9fAILOFkbXQfWjCuQUHSZTBRKAXaX6Xs6K1WqP+/5mmim8FY02oDmDJjx3u0AstQGBKVdqQD1crfE3Q59LKF+gt6sVmEJB4FcRr0ngN+Qe58YxMhkVo/ddU1D1BKFfLLSsYZ2xGicfmTLq9KUelPTZ7soIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MafPXygO; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MafPXygO"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309140a299so1157831cf.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 22:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843808; cv=none;
        d=google.com; s=arc-20260327;
        b=i2GAr32nBE9TmdCXAVRQShRgQ5gkyPFa6LZpXLfm/0rZqikxBDY5hYGSkfWIEAmUxr
         FISU/iJbgBCBQF6HGCvfaFXlM9fqcXJXtCum4dnLhi9gc8aRcejPXMgQVs8NrY7tzfJn
         dIFPlPn9XMaao+A2SdXkWZrUc7c/5X8saacqHOAnCOo2+L+26+6grEat3fviQhlsMmv3
         51Y6OctyED5glodTsXW+WpzBXQp2ZVzO3BDG8+H35z5TYRWbq7DYDd7HyBuARj13qW7P
         PfWU9uDSBH9GMak+xx02HxCcFdqtKzASVaYXEYc1JtaFaR12Muf1QX+g5ArasTru39bs
         RxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        fh=2pO/eoQQLTSHj8m8uqT2wxsLJfrQzEk8/eHKGKvEvGo=;
        b=LKs7feQcPL6UMBcPQ+47XF8jCX3kayFEkmw+G73BX1eSMfp3mGZ11jwNM+stCZ0+lx
         qOs08unuQuUtPZr3q0FdJ6/bvPqlshacLTpSuz3qvpsP1jSmUJU7YDHfwBFn/END9Tl0
         qzyNFZ3W3jEYSh9hbnfJdKLRb2+woyKWWv2VXlLX0EmIFWn7OLzie8H6AtmfNrXXvjo/
         lQEns+20nUbZ51OChB//zngjLRYxRoBHr9b3J3+c3ETM3iz8LP4bMhc+tSetE+K3m2+p
         0YVImLKtZwuUD3CbKD8py/PkOtA50DYY7CwRbsPbcV1NNUJyunAEETEl7q8Ug3nQsw7x
         udKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788843808; x=1789448608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        b=MafPXygOggzgL6Cp43d4LlI8CyduSVRo85xvv3o/BBGszS5248f1ZyV7+1jHEtDDJb
         Cel3WGCgfQ1RDe+ue2IY6udd+HDA8k+w21ESK1go8dBRhC84HfOFTWyBXJlnEtwgjfyh
         YMmshhgoYgL5tjHwZDyj175121014PZgA0p1I/G3XcNOAB8G0HblmtfNWCMFchc2kIVf
         CENpPl4irCEIzZbXYsoy/QML4PPzY2wmoZutCjQifjxxOpY/V7zRhCw8DgcqwDaYevfI
         UaGyanNSXJSnMF/wIWDVfL0XeE0MVOXZZ4Le+comD97PEKwtwJ+OrGmjqHAgD0Z7c7SY
         Tt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843808; x=1789448608;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        b=pi0J+T1/R7IdiF6NNpo1YOCAklRUAeAeSKlLQ4wQycBVtjMi7Q5Eeo4gACLd4IhSIi
         PgiLtd3/8K1awv0Nyuom5+SPjl3Z3pCUduxuCBJrIVEbL6a3MN0+53M9lWqjeEXzW0bM
         aasFiXwmpYf3aTCZbxQz/lIL44s+a4Pv3EXdMqg5XNrURO9SysbyXwvcqnvefWeER27z
         7TbLdRMCBgD4Jx2O+hhOlBRyhdL90ZzOvn0w7KzcnnORKmwYYfzbXb6ABULr2Zh8QToH
         F8o+l7xLCkE0eeOnWTe7enDXzYGqaKEFpiwbGx35xLM5e1cS6alj36zO4Q7Bije7nw9q
         JOdw==
X-Gm-Message-State: AFuF++lK55OlNzVlh5lTm1JYKBJrpUEKkRaNQmUr0UlgaZn2g7K7gPh9
	mPogm8Qc8dihjbULjfDeMbNaqRY0+VOz1PC9r+wYzgVo0S2xq3DR59alz456LhFDiy/bPWMQ7QD
	OY/CCQAZOa7l9zjrY9zBB0xjkTomtQR4=
X-Gm-Gg: AYBFou2omabvmYO8kpRexdDq//pnQ2qbhDtqQw3jOUs2GzcMgztfj5ARZCX48UgUk2J
	6XfBwNjbdp7u/jkbTS0mgG5ghE3VLmosH/rZNxeYqWG5YBJqPFGc8TOrVDlpOtrUH6AWlqIKGh7
	/zYs9IS/OaxvEMraVAHcfQGkDjo/AtVUPUCN7DrUeGtNNCK/lyJa4OzUnr3jmLbwzw07GyLB6ty
	nepWFTWabklw3VWZNiUWcXUSoejO6ngF0b0u1UydX9v+2ELqdHhNRVPSTQOQgboTw65JhQYK6k2
	8q+3CRKDcfPOqCliTjdNw/nM6ifNaV9PM/J8UVjphS0jV0F1ZQlIp+XcSnsau1kzUHC95VVnqJD
	v5EvKBVBBLD+sCeBTUMl4gCmSM3FKPg==
X-Received: by 2002:a05:622a:148c:b0:50f:a53b:9d5 with SMTP id
 d75a77b69052e-53064575926mr179500891cf.2.1788843807729; Mon, 07 Sep 2026
 22:03:27 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 00:03:25 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 00:03:25 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: miguelgarciaroman8@gmail.com
In-Reply-To: <2026-09-07-daily-reply-0019-aiptek-6-1@kernel.org>
References: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com> <2026-09-07-daily-reply-0019-aiptek-6-1@kernel.org>
Date: Tue, 8 Sep 2026 00:03:25 -0500
X-Gm-Features: AcwNN1UHSRkRqX6Cchn0eyhtuQvh9SJQvknSWUvMUSQpGO_lX_JnVov7isf2EqQ
Message-ID: <CABKbRoJKpLe+mhv3VdTxdce+HDfVBggvJgAeCkJ+Us2Hi3QVXA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before
 updating state
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, dmitry.torokhov@gmail.com, 
	gregkh@linuxfoundation.org, pengpeng@iscas.ac.cn, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Signed-off-by, can you confirm your relationship to this submission (sending on
> Pengpeng's/Dmitry's behalf, or an independent resubmission)?

This is an independent submission for stable, not on their behalf.
Pengpeng is the author, with Dmitry's adjustment. I forwarded the upstream
patch unchanged and added my Signed-off-by as the stable submitter.

Thanks,
Miguel
