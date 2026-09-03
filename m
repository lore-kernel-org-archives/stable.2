Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0B3E51CC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466774; cv=pass; b=A7K3Q7Bdpj7iSvm920eirZGfeAuay50MBrO5rQnLhLRuiexZDONWU7am5iAfANGkDfYESo2ItRlDN1eO52FHs8OjgIMhf75mXQEZNzRfBjWzQbdZ+aRE7pL13O71ltFEqet6nyWruicHgYx46kQVVZJ4+/hvPbh19G5oJludpv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466774; c=relaxed/simple;
	bh=61uMKuI3tXO8Qfl6r6fbs0W9TlQX4bskjeLyIhYPqIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3BdXKi2J3FgT2g2DKdd1vrM1TDnVyPo/Mrs3HAfVfEKoYE2ilVduRCaXZo8jENYv+GAs4V/I3mDsQvzjcDOYgwvWnCCEGYcVFeK0TcpOCjtatdmJn6HHjgTo9MNlwHMiry6EkSzVQ3L3iDSnhdEfl8XBQqDtoQWbO3jlhXhj4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj84xjK9; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj84xjK9"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e3de6309cso399091cf.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 13:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788466760; cv=none;
        d=google.com; s=arc-20260327;
        b=g2wbemilpt2WrZbLOSkC9xGr3URQ+CO+nMHHXGrLFusTS2H8WacGdBKtvsa+HLUb7Z
         /J+Qa37fv+Z9O6CbdZtVnCPHlcfkiHT1g4VF9mzC0YMUkIHv4LRSiMjYV0Ua02k8U+ce
         luRk0Zrtkoec7h93sIFGs3IGxvxGvS6yL9Qm+hJRK+JxtrBoyRIlMwGJBiNub0gvcKWt
         5mWXJOE5qy6P3/JEttQ2dFPajAyLxE1JHYsHtoHl7zynNAqTYlBTHpniOn0CWHOCU38S
         AfuVAGfZ63O1s8AbitA52hmaVj8lv01+E8KUzcLjfyoUTpGSQyCGXtIK3Chtej4LBQpQ
         y4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        fh=FnkytF4jCMzuAbDO6tyqHyA1A5ZHYodfOFFjzh1fRKE=;
        b=DrzDpaQ4amodHPoMBuzFPkTYERHCgYw9xtKtGf9IOpUg8EGr4/+QYoJmhm+7Ep8JrK
         VgKHTbq1tuALQ+Y5I9/WxSX8wXp3+8tvh++fOtsZoY7fkgQNzTSVTIG92LCxsxNREOaX
         NhgZ4IV+wQOlVz1ZpKoevnHewR4yhB0Wx7M+RCXtprfhGVW5fdS7hqiyWc8qgPpxOraQ
         BxUKT3zouGYR9cV+2b/jOpWRbQZpK6WXBm19R5WUrnwM46xMq83yErcTliE2qNdZsumP
         RJH3ulbPbXFRaoOD1xKL/7u/GpObvJc1uO8GwqQOKPujNEutisAUuxcI4AN+mT688cob
         07SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788466760; x=1789071560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        b=mj84xjK9zlACYEaL8oaVI2GK3Wt+uUKCj0Y5gnoM4Pd0YwHLNjmw9jZf4hdaZHVDmZ
         JmfxQWo9qqxRgUawSaKgJTID4sy+KMctKuGspRXG6mIjcUI0BaSjXNpdsCluXgHsZHFh
         BSmuLcPzi3DF2sUI6RBIsLKjNQlvLbvGNW+gafYMhcfT+j6Wg2V5K0jjnHMydSfJFvdN
         QgQQg2lNW3UvWoq/Nk8n2M/8ztInp0O4a1fkL7zy8KVR0e8qJ+Ycmaen3Nwdm28O35px
         5oLvfqbz2rRx8pEH9UivmM1hg0Ew/sXp+6uvht2moJiPDJVDkMSCMTiEmo/av5QLoaV3
         mn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466760; x=1789071560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        b=EWyLwR/m14x8U4/fyK0bV22aDTs0YIYa2SkTpqQCzpm33owhJl1N/MX08OuXqZ6DVu
         OKFcdkWqWjSTkPagsCTcpA1hmlCqdw14+pQcfAYYj/YFqK6tcxyPdeXw49Y9dbyrhVsE
         G4+BJPDYLehpv/n5+A5cuZhittz4ma8fTqxSCDAyuyLfNsSy6LAO/dUEUdONtGTxeVqT
         YBovQjwsYltaOwIdosQfUSGj32pUwXbKcRBZCIYvThgD03eIT1S+sQjHQaGal87bmZ0L
         sct8QhB5RKeuA+QGnfFtMKmAFH2G9LHqzD1dHt3YVXxNzbro2cN8Ey2P2Ri+tCLEXTpB
         fn/Q==
X-Forwarded-Encrypted: i=1; AKwUvByeid8A4WPrRduEPUkZ3bsQxeychPKvyk41Vq20qKnJtjpo22NF8VM469dpOy9tP3GLsk76T+0=@vger.kernel.org
X-Gm-Message-State: AFuF++ntzlzEQgHOfROGpVfQTZaNiraAtn1L02lrvvfAbhGTa9fkp0eQ
	4wI1argqca4gNpwe/JG6HukASog1QJmbA62VZHvzEmrr2aZo6KzXgNPeJfy5whf3tFVAFRp/Yiu
	moXYKPA00Qdg91lK/EwlDXEmUFxtQhsYjhZRz9jh/
X-Gm-Gg: AYBFou26iCdV7hFiEj7gocbldABhXVyJ9Jrs0hxd7UP2v5y+1YCgIawOrgb9q4G60O0
	i3wwY+nMRWhkNG/1pCbTaTST/e+6he6vksXRHNfvPwo1UOvI6CUrM8DA4O69QFbluwRhR6wPW8f
	5n5QsaQeiy4WnomML1SrNsSgOIMwaL9JKCsi/h/7tDYXGBJjyifoIl57Gzz6AHI2MNjLzbB4eRS
	gZTYG1EdX9vbStj8ftio6qBjIwciPJ+zLmZ5RtlEfKZ/jdDxmmJZ/MSGEUsTLv04vunPyI/PEmU
	ZLiwcMi7Bdmbh9jfNwL5kUuFK/K1u5P5KtyccveCXE3XuN9JczqGxy57XsZxRVxsLY1RvbO+QQ=
	=
X-Received: by 2002:a05:622a:903:b0:52d:9d62:6163 with SMTP id
 d75a77b69052e-53055c4f251mr1561611cf.9.1788466759468; Thu, 03 Sep 2026
 13:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 13:19:07 -0700
X-Gm-Features: AcwNN1XK-N7twBaAZhkaw9Vegqsfjdmj6p3WSSQYw1RpFRIiubtAAmV8NKIVXjE
Message-ID: <CAP-5=fW5uHsW0wgffWgc8f5ibDf8ArF8qJW6sWzrorL44CqnNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf evsel: Validate cross-endian samples before
 byte swapping
To: markdamirkan@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:05=E2=80=AFAM Mark Amirkan via B4 Relay
<devnull+markdamirkan.gmail.com@kernel.org> wrote:
>
> Two paths in __evsel__parse_sample() use values from an
> opposite-endian perf.data record to modify the record before checking tha=
t
> the data fits within event->header.size.
>
> Patch 1 checks the complete branch stack before swapping entry flags.
> Patch 2 checks the RAW payload and the complete 64-bit words touched by
> mem_bswap_64() before swapping the data.
>
> The malformed branch-stack and RAW records reproduce as out-of-bounds
> reads and writes. Each patch adds a Sample parsing regression test that
> checks rejected records do not modify data past the declared event.
>
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
> - Add the adjacent PERF_SAMPLE_RAW fix found during v1 review.
> - Keep the branch-stack fix unchanged.
> - Link to v1: https://patch.msgid.link/20260903-sympwn-linux-002-final-v2=
-v1-1-7c6e4166b814@gmail.com
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Mark Amirkan (2):
>       perf evsel: Validate branch stack before byte swapping
>       perf evsel: Validate RAW sample before byte swapping
>
>  tools/perf/tests/sample-parsing.c | 109 ++++++++++++++++++++++++++++++++=
++++++
>  tools/perf/util/evsel.c           |  20 +++----
>  2 files changed, 120 insertions(+), 9 deletions(-)
> ---
> base-commit: aadea57f532882d8bab444646863c7ef8a778ff1
> change-id: 20260903-sympwn-linux-002-final-v2-e30a8df210c1
>
> Best regards,
> --
> Mark Amirkan <markdamirkan@gmail.com>
>
>
