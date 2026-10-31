Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437124;
	b=j5dz8ymV83P8rYcugjRXzUe2iRAyxieQhEy9Mp6/GnTugNwsBY8DDq+BoQIqqy7DvkX2
	 WjG5K+k2z1YATVSXxPUOJbvl1b4Juq9IXD2EwDI98vyv3L7cWo2O+jhwsRVIIe9A9DBgb
	 rbr7Se6pChrZCUXPRSpkkchuokN7XIN/gyqR05CcSo/lTGJq6su4ghpVGb9z79Fn+QW6/
	 SuLwBTpcTl3DtlJ9GK5B7NYESueVL6qV0mefRxt6Ghg3RCoZLtURM9fdEWzKAJGqWCEJH
	 9QFMwWNsHjTe5w7mWrLq0RBVnI9/1qreQ8ekD9szB0Xl9s9jpv9HpHX4C8Q/0SQq71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tz/unDvmUIAP361qcoBIRc2mzL7WeB7bGyJhoQbUhsQ=;
	b=CUNxvWfCHFy2ETkT4l7DHK4/HvxMk3mpEXYT/pV+nWV0xN1Pkhcwjv8VAeJZI4bBQ3xc
	 8iNXWbAXWgy8hqi+OkUx/0EqgKyN7y4CggaAwQlUESXF+fZx+GmIUmDFAm3st8NcffAQb
	 kjXV2caKAd2JudF0POv74jKmI9HYSIoES9ihpWyyqNJrN16ReQCNY4yOIKRRbxdw9w0DM
	 8iT1sC7zt8qK0raZ8Qx5/U1qtD4NuRy+az+ome6QhJTXlRRYWLN8DO7Ge3mMK6kBm+uaY
	 fNxTM80IDRT4ZmU1e1R5vkks7+xy8P2dJlNkRAn0AFLx/FylgKR0+JnNcogIWj+9dfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hw404mTc;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C371606A31F
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 08:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C371606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hw404mTc
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso946463a12.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793437124; x=1794041924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tz/unDvmUIAP361qcoBIRc2mzL7WeB7bGyJhoQbUhsQ=;
        b=Hw404mTc2MmmCOgLt/LfvHS23csGEPGuUGOCRsxPSp31bTOk7WeC4cudoS3MhaT1kR
         nsXDgxdfbZzL2vC+owWkx8HgcQqHitwbxVA1/EhOGWYTH5JNDo8/WqcqNFrY04IrQXqG
         +wa7eAwZXSOlt+N4cs4aNsnlUna0ouSvrcWUbW2njhnrQH4dyp/IRM13nKHZva21vR0H
         zYYgpsSEBwsSKF2q3df7JiZ3b3T7oBMtQNgpXTElLpIR6TGZYtfhRdtDAYw7bNQLic2C
         PyiAsXMypruVLFCum+pZA8rg3gJJbDsGqoSR0d0s0h4ExrLktaxdTtq3dyC4OALI4ZRt
         kvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793437124; x=1794041924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tz/unDvmUIAP361qcoBIRc2mzL7WeB7bGyJhoQbUhsQ=;
        b=AtlVxQSQCDdbbi/s11h7FONsrumfOfTDSBNPNgDusXu6t3UHXe7yrmtCPyYDnbaCoH
         mhPVxOsmVJXrK63Zrnr2z69npJlJZJyiY0RnPhoMEnN0s/EfRH2abgEE3BovcVK+tMZe
         hRwdOJ+zCTW6N19Pb/sqozu7O7LLx2WYfSyIfNLcCho03JAVfHPp5aADjYSq/UxlrLS1
         tprW292v7JednTn6Ma6Vw7xe5S0JURAruFyJ+ACoV/9KcMjXepSTd1zLyFULU94tiggy
         iBkVvYzl9+y+4FZJ1TUdacrPBPSc8EJtSSCxR52AMC7FIkthp1g+YTB9RlP4OKbckXfp
         iugg==
X-Forwarded-Encrypted: i=1; AKwUvBwyN2yTgXX0LuylIPJL5OEUl5t0fAJP3eEQHProDjOnE5aUelg4b/JnZIwxt6elEH4pHQCX5SM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9lgdwtlFntR7HYi+WpNYtGhyvHkjPCNo4F+bTs4/etJflGdTo
	lxE26Nj/cpwkX+TebRjRBGAc+X5akqMs41G4zvfqvgtRnb6Ef0OeGECK
X-Gm-Gg: AYBFou1BQodroiu7JDX5jziE9ygPdcjgNm6qfa422MtF16qe4ZsF2B7vEfqUg+41Z3v
	N/DNTCRaQ4Hhvml+aCMj2UJpgcFewWHxLf9+nbf+YjYRLnd4jDb1wwi0Vs2cfQT4rW9HFnfgzOh
	expSPL4Xy3rlk3oKrkcJt5X+xFhukahHO31blPM575+eydax9+yuQPMC8khC3pbasxRN4v0zmwh
	/KbOL33i14CswU29Xtau1xpTeSmQQPWavg71y0NsfNXmLXvNwq6N+91QMUYQ5jRH97EvsJBdOwJ
	uiHIyp8ntKV/qdo/6HvMc/LI9t4B+sMl2/0tbqCzsVIlrIXkmN61pAQC/SauFszcxi+J8BqfY+o
	YpPiNs95xOGG5oYywuhrB6ZUqiAI/w9rFxensT9O93hqpm12RKyGnoYrjti99NHTEGfQ6A1gtUL
	E77ESWlPV5VoALd04qSNYmU4SnP+GcO/dYToQpIdCWLIgAonr44zaT8QDJFXpOQlC6HBAWPMVIO
	FDazrTjUom8c1Z9HtXvIQ6wlhGMkMx9xlm/dNRp5QiXvHioW34VA0ETCgDMTUmzZSXXCcIQC2VU
	Ok/s+rwZn9bjgeZm0qnWQkaIBKmwPPYA6Ehzszl8MdEjqNVdElod50E1dBCQTBPXcdAKw2o3127
	TmSCfCmenQd/Tb3y0TIWV/wO6png+cd0lx7HZaB12BnMGoXx2cIWbMYjGNKgWNeugFudtTDys+k
	SPA1LoDn7Kyrjkzn/7Q917iChy
X-Received: by 2002:a17:90b:4c85:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3ae89574db4mr3528996a91.1.1793437123597;
        Sat, 31 Oct 2026 01:58:43 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84580a0esm6880513a91.8.2026.10.31.01.58.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 01:58:42 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Koichiro Den <koichiro.den@canonical.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: sim: fix the configfs lockup racing with mkdir/rmdir
Date: Sat, 31 Oct 2026 18:49:43 +1000
Message-ID: <20261031084943.23107-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMRc=MfuDQ9=bPYsxeEiRaLzC0Q+hVxjTov_JEGv_hsARM3U7g@mail.gmail.com>
References: <20261026060049.60599-1-yuz08559@gmail.com> <20261027085653.90471-1-yuz08559@gmail.com> <CAMRc=MfuDQ9=bPYsxeEiRaLzC0Q+hVxjTov_JEGv_hsARM3U7g@mail.gmail.com>
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

On Wed, Oct 28, 2026 at 03:07:55AM -0700, Bartosz Golaszewski wrote:
> Is this in any way linked to your other patch[1] for gpio-sim? If so, and if
> this one is in response to sashiko reviews, please indicate it by keeping the
> series versioning, even if you changed the approach, otherwise, I can't know
> if the other one should be dropped or not?

Yes, v2 replaces [1], please drop it. Sashiko was right that v1 still
raced with mkdir/rmdir (it depended on the entries after dropping
dev->lock), so I redid the fix and changed the subject, but forgot to
put a changelog under the ---. Sorry about that.

> Maybe:
> 		num += list_count_nodes(&bank->line_list)

Done in v3, with the full history under the ---.

Thanks,
Yu
