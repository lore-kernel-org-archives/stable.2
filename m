Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC33C98B3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618525; cv=none; b=h3eo0GQABabSq52zaq556NkoI0scBeTWLft99Ob8uurZhVDqIvYeMA5uK64h4b77f9UKkbd5jbNP+z3QfCoDwj07nBqkl9uYcR7Cs6f8vr1yhzjc9h/IK8FcaSjEnYCTJc2PU6KmLE1sxgLupxCJEJg9zqFIod9YdNwCY34rs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618525; c=relaxed/simple;
	bh=jMh5EiQSVVj594l45L/6B20epYKRiM/o/m72wmjBcTM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LkgJO904zB6nUpBTgKSizK7U9BoB3xGjtgyX6B1aj1E7cOXaGXyaRGNbfR94I9gdzyKp3tXZxwR2A946/WjdRqRa9Dy6x/wVwX7sSNj7xQkRAb9ZZ2zaEfUVREfvKNiU/QmOC1SfZHdcq5iQ8t4eO31fR3ueuRvsZ45dX43XOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SvWZ2NVN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SvWZ2NVN"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so812728066b.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784618522; x=1785223322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g77UsBHw6Ia3GLFrQkV2WFlqkjhMYCc0L+bE3sl7QY0=;
        b=SvWZ2NVNerIbYUjeyBUVNZEh7Nd8CyVFQXrX5tijMSAc3fxXmWn+E5aReoWwlAyu/F
         gz1zgJf45HkvnMq+yB7no0X8qO1RdqdHLp1VwEw6V2/u9KkzcNtOA23odi0/1lIH+GrV
         VVQP+bwIcuByedao5j0Mr36y5yqLI4QpIqhLXAyfJ21zBuXMNU/hCjQWcngLTYuKclgt
         aZNc7jFm+RekNQGX7xYfy/LpsGL1tLgzNaEcD3Qy+dC7HaJiTnleB4ws7eSoftDa3Vyw
         1lAIuWb2wyvV1l/u38GnLNKIrazx+n5LL/yqUoRe2mANH5SGw9GzmCSFOWF1o+WFSxjJ
         rL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784618522; x=1785223322;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g77UsBHw6Ia3GLFrQkV2WFlqkjhMYCc0L+bE3sl7QY0=;
        b=s+X09lGTJpSouNrYzzYimuyHUgvcP1lCdqZFe0BSfxZoAcpj/bjIdw5uPCMKM7m0QA
         BrUEphyfRhvfkpU/RB+HXrkHiaH7sSG3pOKhRrT+R+kdy9qoWDNh7JYZe1DR81KX42lg
         4TBmmSSxv7TM4gRgovBImaG5KhT6p+OyCGECVNV2ja4dg4eVkxDwqu/AXG/PgPDoDMOR
         z1Fh8y41nXWqL95wOAMLL+T55XZVWEhvnvqRUvRL2W6o29z4XxFsHAo4VX+FQQa9emh7
         8VXs3x5OCTMk16qFqS/VDrTsvcsBPC6JQRQuEdLxFlpfaa0LG7rSdpu2m1JB3S3r23Wh
         03aw==
X-Forwarded-Encrypted: i=1; AHgh+RqZy7Gm0VkxVk5MGl56zjz5w5d+EV5EIwwNdXpQHKX9hq5vZz1YHNutXO00SsZfXxesBhqTI34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw878L2SlWSKjd7XqqvhC7fRnFZ7QYGnoIPxBW1YRWuvwzbXh9w
	HWHIxhwBdKJfwP4YDoc+AfDxbsM+jvQ+QduObt0p2A7wrSQFVrzx170j5WYaYf8OrncdooSZabm
	HTDeiEA7XUg==
X-Gm-Gg: AfdE7ckh11a+3QL2sKZEy117kXvtPuB1C6BqB6ZzX/REpeM4wu/ElKJ/TO86DQFw7Ro
	SeG7U0ea1i2aNX+13v7FitCR9Ba1HIK7uhKwjelZnVkOde7qoO9d8ErWKyvw+Q7ULmWBmo8cPwT
	LaTShCgaaQu52Ve+eTGOaaxotV8+rRfnJZJs7USHB50zrOeUZZ5c1DtMg1IBHhWrdBCPDgnJ7y6
	WQmLqG4d5KDkn0ZKHYNp7tBNXZD9snF7sJQgDzt3Ngz1iKh0V5lVcu/l9lOnLSxSHTeMtknh5yW
	PhBTet++xtdKum4XBFE30+9CWUTedOyafgSkZHWtzJbGZCchd+JeXjfPlmzgFGGC8ruQUP1IEjW
	xVhTF94Jc2owJVwCBoMBu8+J98CStcLONEFBHrkJgEbvfiqGNR4Gfde8htA45sPSHIvGVw2p9/U
	HcvFj/Hb1tJaZN3wkH1GTRnS1vcdi8atRPo2U=
X-Received: by 2002:a17:907:9625:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1692413dd8mr940884766b.25.1784618522602;
        Tue, 21 Jul 2026 00:22:02 -0700 (PDT)
Received: from u94a (27-53-137-220.adsl.fetnet.net. [27.53.137.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm69973685ad.61.2026.07.21.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:22:01 -0700 (PDT)
Date: Tue, 21 Jul 2026 15:21:55 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: BPF selftests compilation failure due to
 selftests-bpf-initialize-operation-name-before-use.patch
Message-ID: <al8dSv_OvhwxFCar@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Sasha,

I am running into BPF selftests compilation error on 6.18 (but it
possibly affect other branches as well, haven't check) due to
selftests-bpf-initialize-operation-name-before-use.patch currently
sitting in stable-queue:

/tmp/work/linux-stable/linux-stable/tools/testing/selftests/bpf/prog_tests/verifier_log.c: In function ‘verif_btf_log_subtest’:
/tmp/work/linux-stable/linux-stable/tools/testing/selftests/bpf/prog_tests/verifier_log.c:320:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  320 |         strscpy(op_name, "log_fixed", sizeof(op_name));
      |         ^~~~~~~
      |         strlcpy

Can you pick up commit 63c49efc987a ("selftests/bpf: Add simple
strscpy() implementation") along? I think that should be enough to fix
the build failure.
