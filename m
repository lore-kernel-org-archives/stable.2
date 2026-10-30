Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324231;
	b=HVkkV3fdXa0OZF8NJXALenFT823IsVcsm9DTErMekk8AoORGzwUkfvIISFPaV2aJ/J9b
	 wt9pLKuBCc1r6lp0zF4dE0RIY4iZ4rELWn0SnNQ4R6wFvfXETaRQ1mlAAVwSQGYCDZlqO
	 OayNld6Dqu1IWLBkUDmC+rc78Ln9paQCpROcgw43z1cxbZ6Zaz6dpnIe9m1BanHofvHop
	 8VVbgl9xijA4vPG3W30TTfEU2epmtDtVNkvWuq7JpWoRn6wGoK7/63rMppiX/kyVirhup
	 kZICCGHD/GW3xji4+pL7/uK0BV8bQtdJBa7p6mUEUbLba5S+OtaCr95nI9rJzApaplg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=Zcy8/R0qg4/tLGENoHwYrpvlh1ufL01JT/JeD2hu+48=;
	b=eStsP+LIbk2K9117dzPBWXJ0PZNWOeqjjzIUbFcd8dMG8kEy8XQMbNiG2d9+a3lIYLM4
	 tMvl0snVrug43mMp6a8jnrxuAz07FXSBT37PZOM5ePpNfTkNcGYqNhNgBflhXYSPN9M4R
	 fBJiqmw6kWv7RvHcflPsuKFLQggnZhyEfuEtwwdBTx5B1drnZKN4xP7bOvzBzkk1FCr8O
	 1ZpbludE+GO3x+ZAkQFgA3W4H+6Jie48nV+g+TWUTQYw4zFtQhestOnChGC4KJWSSshQ6
	 BTG9uyMqIdyYIcm9W9hnTv0eeFndfdLSXGJrVnVpM5XSAtT0cbUJwNUMGnQbfz4u3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=HxEU9kgz;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F3606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=HxEU9kgz
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f560af6aeso19698785a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793324229; x=1793929029; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zcy8/R0qg4/tLGENoHwYrpvlh1ufL01JT/JeD2hu+48=;
        b=HxEU9kgzclioL8FU7fxb6+tNSW8e1VmpFOYUvyNCpEzIkeazTh8LQxy9XgtmweR8LY
         lR/zan6g5bKT8xd787YPTNv7KFLq3ltBlZVZXMABLRLeKIxaM7atqkPguDTs+suZ0Txy
         RLH9nOiFJk0qLagIyLOicT6Re+KKqfATM5bhTIo6x6wA33o1BgHGaTTawOkknVQszU2B
         f3ldl8gzxipFvxc6NoGKV7zLq7l5KCvMS7uXDZeh7Titg1daBD4XbAJMkvlHnCO0mEHN
         qnjI6IXSRMWYcmgSX7LxW+8iMRqaSH6wENidPmlIpHiVYH3WABaw57QYix+pnm9EHEQX
         etGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324229; x=1793929029;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zcy8/R0qg4/tLGENoHwYrpvlh1ufL01JT/JeD2hu+48=;
        b=Izlge93qjkeDsRyFEoLutIaVlG/E7WXIAqG4SI8C8Y4arQFgXQK4km90I3PewqTBjK
         QMY4KknoD6QVJvIkzIvkTkecAQLZ4oT/SPIc+ge7AZxMd5Ek6DCgdpnlNaNFO958Bbe+
         D/VCRw4DqBTLTu5VldUD7czt+TYDGQYX+5+G/EriXyhL462R6sp489hFRpthQnI2ifE1
         Y6qzs8izRKWaMUGEcfLKlSnW/yXW1oW7TYSUN3h03K+s9PpptUpDZgJjaBLhzBPc8QN2
         /Phrq529KA3tr8Gn5XMctOA3JFUc/tW7uonEQzDO5729GRtUJ9VN68FeRumEFHasVFo3
         FNYA==
X-Forwarded-Encrypted: i=1; AKwUvByGcHwkg4+LNqYW3ISWhN1cS1qlq7JXhrl9gDW1mo0mF9scQOQrQtmVJBUAfWsgkZ6zh2kP7L0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl2u9X7dIMIM0LfwolPBi/E/9C/RMe1zp8lGLz5hLu/CBj9+kY
	ilmpozas2N4y7V4DKCRhi2p/v3C+W6f76a2wbW6C4WOHk2OOUw6sDOzgS4qhoLG104es/Jak27m
	2n5Ekmts=
X-Gm-Gg: AYBFou3h7SwDIAAwJL/ZDwzNKBeGxP2NgbB7/pTlOBPp+sKwi/9WRzmPt/w22l4lIB8
	Ep/Ms8J5fhXCiwSo4fEcTRsstrHADKo+vKU4BkvJWDAqDayD0yEFuQ1YVa+gulK7y6CBxfl5D0D
	ZQZKAlewguHFSdaHvrzN4emdeuT4TD9vkNAj2y/9AW2qW7BNgzFTNPDZhkg5Jhy27q0aarU6cm1
	7QfJcW+3cc3NolvBdvmYC1DESL/F8B9LuEkkxTmpVjUPQuCRAEs8W3rFAeZ3y+muoMkteXN/Uw+
	ddMBHVDor5pV2B/mvo+V4dIMRoGLGY02s9YasCWoO4ANkb9PnGWwd8i8JvwaX/aYq8QAb9WGHRx
	fLnjhZK5dEBodF1q4JHfmZFWWXgelAjmWOTj8n4aURtOG9MxrmFd0emfzXzubFinW7ypSNpJdNp
	HqR9ydmVz/p0Ubw+2kHpYJgEFgMyNXMJzicK+dqfpvAOXUhdaH0gD8T1Vcvu/hH4gKzmzoDLZdR
	h2Cr7ouTXDFWgPlyk4sVCSW3JDzK58he3NIqdItXFAQcQZBmmQsatsBzL6EU9dAYB6bvIBVV77i
	otS1O45ygerX+DwDfaVmZnMhydpIhMnoK/vtKIjqWRsTI2uXXeOu7EzlgIbYOQbLIQfU4jsFz9y
	r
X-Received: by 2002:a05:620a:800a:b0:93f:43a4:a47e with SMTP id af79cd13be357-94421759f60mr164999285a.43.1793324229423;
        Thu, 29 Oct 2026 18:37:09 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca806aeeasm1672456d6.35.2026.10.29.18.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:37:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 6/8] mm/hugetlb: retry the pool walk when the
 zonelist is rebuilt
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, muchun.song@linux.dev, 
 osalvador@suse.de, david@kernel.org, akpm@linux-foundation.org, 
 ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
 ying.huang@linux.alibaba.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
 brendan.jackman@linux.dev, hannes@cmpxchg.org, mgorman@techsingularity.net, 
 anshuman.khandual@arm.com, stable@vger.kernel.org
In-Reply-To: <fe658b1b-4011-4197-b228-fd4bb6c412bc@kernel.org>
References: <20261028211930.3504634-1-gourry@gourry.net>
 <20261028211930.3504634-7-gourry@gourry.net>
 <fe658b1b-4011-4197-b228-fd4bb6c412bc@kernel.org>
Date: Thu, 29 Oct 2026 21:37:07 -0400
Message-Id: <179332422799.1311000.12794841959006150077.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 19:08 +0100, Vlastimil Babka (SUSE) wrote:
> >  
> > +unsigned int zonelist_iter_begin(void);
> > +unsigned int check_retry_zonelist(unsigned int seq);
> 
> ... is it possible to inline these here instead?
> 

Reasonable, let me take a look.

-- 
~Gregory

