Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CC480DC0
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162414; cv=none; b=Ukm1oM8aMOcLtioHjDcKlbnu/M2SiHoYgPgr2udYNrpqyfzVSM+FHwA0brvmHTZmPJXApLRYhN5SYHAyxhKoS/PKgz9We97O1YbKspI8j3ILVHjRIzposXvbvFGcZamyrLq3fJO9+hriN/easy2xkyAoFVtoUDZC6yIxCTD4WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162414; c=relaxed/simple;
	bh=ENtvYKYEhz5FjfsHNNre0679dXILkBcT7wr5GO5Ucec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ny5/2RBu9CFlFaoSj5553oEJsZdz8XIH6BMVe/a0djCcg6X9xauy+SO+6/w2lpzAIrFUJYCKt02s7XaaaL0xr6N/qgGXlDb2Z295ut9hHTkzzoVd9PGrvRb8Bj7Mhv9OdP2oKPgQ+TAxfp/XksJuM563fBJzrnsUGRXJE3dUMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IlFQ7QCl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IlFQ7QCl"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso145809a12.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787162412; x=1787767212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENtvYKYEhz5FjfsHNNre0679dXILkBcT7wr5GO5Ucec=;
        b=IlFQ7QClHKR0jRNTezLWoQBtfEiDuPqnSDzVqOikla5NlqBmLRN0wYiGiM11WADPmH
         Aaj1+kDJDts9wexrs5qenbyfWjK+/5C6ztxAWZo0PHRo0PUbNaMrYG7P77Nz1b12NFHB
         6luN8xqm7768So0f8lUHKsfoaXaO7n3hZebbu7+fswCVW/msxkea4BlQ7Fd4EoJiC8RI
         Uug7OPGnd5BbaItxA8dFQnp1r+yNhhgpfgvvGFoSh2RvfYtdGXQyGzwgtJsTfY44okNU
         yjrGrsxthSBKkZwwefjN0w3zyq9/Sp9/Ll5OWlNSaoUDR+tOQmzZx2FzrHepJJaiKrJA
         XWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787162412; x=1787767212;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENtvYKYEhz5FjfsHNNre0679dXILkBcT7wr5GO5Ucec=;
        b=IbYv60JgPBjtP2NlL6/UJj4pOpJ26Pr6SCqI8CjdtLQCE09cPCnEsUxnCSi+0TTrnP
         Hhdb5YimE9yBxj5FTBWnuILqwU1L40SBcLwN/NkgzG3TB8itp6MdCCBqan5Gbeo5mcFu
         24bkk4wWcEZGFJT1ifJOaMvtxe5V/azZ5iWTNG+w0EWT28fZWfY5MOWM980vcGZOn/aY
         1o41e2Las6/pTfdEYZkUlr0wv9gIlKNSQxpQeChSvzWI3KcZ9ys0+j46i1ubhxqprts1
         QVE4jHGIvGiQbwbH6NT6Ld1kKo4ZPepQBXFum5KJIhMUKLB0VrwBMLe0V9yRUDOAjk2E
         tjeA==
X-Forwarded-Encrypted: i=1; AHgh+RodCilynqq1OF6qkKfhXGXqpI0HrgGkQCG46qJgfo31X4gDquyYoC15gZaOEeb/W1lSodqaIkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNSe/UnntCwiJkEZ/a6mIjGhJHM0GVf1GuMX6Dnitxzt8Bxq6
	XfRlX+ZaajYbqCjdMWqsxh7E5YZ4ZfMhZ5hHZf8qMFt1o7mO2uhxS41M5V82theR/7A=
X-Gm-Gg: AR+sD12QDtmLpFzClDduEHMjk3O20wEcphvoyMDrCVwqvomfAyURblIaERXpmsXDosk
	bKxYattHzkLJNnPLSbyzmhrVlu1FuH8XFtWSZZDgegABN69ZBxvlNH9mNjgkzR9PvRGlZSwrrI7
	wQoLHxVorilAMHUZnBK+sPKtWWOUD+zDlMDUEfUjrSPsXC3GiZt9w19PAWuJ+rokSvBztG48Sez
	Qbs+Y2YFOW40bvWDFGrkq1p9o+oa3vM8ZhC8MN6wSMVrrJS+nHSZkwud/DmRbrc7gfdAo72TA0N
	sL+A8kkrSUE0wHiJC4d+zzk4HfuUW95jy3YgKf5hMrnHyQFYWwQOlmUfAQ4SAQChW4sr23aCKkI
	9740282N+MufMLGqbTfJvZG4eHPho9kse2Mytv99zIhpVWZUbexrmnZZB/e+Vu30xIX4XJLBIo2
	67UVhz4xSExwmOhqRsfXJXyFbS9XWlZQ7YLYNGDYFRCQRPEqFagUQGv3tKEmpOmqj1uNiY9WOlu
	FzZT1yt4SFj/fM=
X-Received: by 2002:a05:6a21:60c3:b0:3cc:dce8:1109 with SMTP id adf61e73a8af0-3cd14c6b137mr1001854637.3.1787162412361;
        Wed, 19 Aug 2026 11:00:12 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm15843476eec.16.2026.08.19.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:00:11 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: yazen.ghannam@amd.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dgiani@purestorage.com,
	hpa@zytor.com,
	jrangi@purestorage.com,
	linux-edac@vger.kernel.org,
	mingo@redhat.com,
	msaggi@purestorage.com,
	rhan@purestorage.com,
	rjethwani@purestorage.com,
	stable@vger.kernel.org,
	tglx@kernel.org,
	tony.luck@intel.com,
	x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Wed, 19 Aug 2026 10:59:38 -0700
Message-ID: <20260819175939.2068993-1-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260819140647.GA2416@yaz-khff2.amd.com>
References: <20260819140647.GA2416@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Aug 19, 2026 at 7:07 AM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>
> IMO, disabling the interrupt is the best way to manage the storm. The
> reason for Intel to set a high limit is to keep the interrupt enabled.
> The reason to keep the interrupt enabled is because the same interrupt
> line is used for reporting "uncorrectable,no action" errors. This isn't
> necessary on AMD because there's a separate interrupt line for those
> errors: Deferred error interrupt.

Agreed. Also that was the original intent of the patch that this
thread/patch is fixing. From the commit message for 5c4663ed1eac
("x86/mce: Handle AMD threshold interrupt storms"):
```
But, unlike CMCI, do not set thresholds and reduce interrupt rate on
a storm. Rather, disable the interrupt on the corresponding CPU and bank.
Re-enable back the interrupts if enough consecutive polls of the bank show no
corrected errors (30, as programmed by Intel).
```

> It's fair to set a low threshold limit. Some users want to see corrected
> errors without needing to poll. And they'd like to see them ASAP.
>
> The threshold limit isn't much of a contributor to interrupt storms. A
> stuck bit/failing device will likely trigger a storm whether the limit
> is '1' or '4095'.
Agreed. Thanks for clarifying.

Thanks,
Jasjeet
