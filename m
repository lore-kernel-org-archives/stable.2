Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679363;
	b=cDKYgVKwSf7iNps8RKCOJRW7PW9ed/Q9an4D7+P8k/VJwuLMuBAeKjXEW8Fv1ly98pIC
	 I5JroI5iOP5TuNzn4RVUH869K6SW34S3iNyU39u+EwRpE+SoWTaRHdkUF5WhKobpp5zwz
	 mGnLXwwXly7eCRLJfpdhpnsYbT/xBbKbOvD+VinHXa09LUoJUb+szHHN7eoLBIxFXwdkS
	 MLbRdFUdI19vm8e6p55WpReOrKk2c7OuOCypU0Drsja10pRClZLu3lAygWy/Qh3Emhw6l
	 1wUOHUtebrwhXIfqvuhLRq0r0pW1zYTOU7mT7NwN4w5wwZ4HThElgfShogohu7ym3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ip3LDVkz43JVMLeEy65y5DnSL95eKEKIg6rsimQU6Ow=;
	b=3VxZj+EAJxNHOpKpVlnpxB3faeQDvWTR1TqnTjBaWhyjdUeEUwcxOXeO6hRmSPkbT+30
	 HEV3rtk43VjmfT3yksQql2albo587jVTUQGDGxxpntcaDFzBr8Kpe0snSVZ03CoqXd55b
	 +kX+K2L4w/Rfyt39/lj0asoixlCc34wXGuT0HuBKVt+R9lWIHPhu11NSMDjnGNxqY8nte
	 XQhT3xwrP+9lhV4HyGvccMghuZnpHzHMaVqTLZ4whxisdqRgpiso4epN2wuhGq0sH3C9m
	 A6cK4wppNf/fpUY6clNa8UyfQO0C9bSO3/MRwOSE1Y6pSPeLjwNxudOEizsDMSygykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Sh3VG5SY;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86D606A329
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA86D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Sh3VG5SY
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0e21048f8so18566287b3.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792679362; x=1793284162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ip3LDVkz43JVMLeEy65y5DnSL95eKEKIg6rsimQU6Ow=;
        b=Sh3VG5SYS86Y/cUu48NcOpZrlstcwtzOP6oDtt0f1lj8SLeLI5pZWs7o+SIp4ix3oT
         5SggpjHjZ7iWCohx4alswx4ieJz3fvs2sb977apngl3IBzprzk4ulKjhiMFuN6ydLzPY
         u+OpLY/nMxUyMt/PFrFzJImPdTz/mxUyUWVNKGrEISFLs6U1C1IZZV7uuawmXExSMTo/
         fLl4ztuQw5RQXnLf6jlBAC9GycJ38e4qI3pKMz8GHe7RDB8g6Qib28eKU+J32wqwYyK5
         90VRC7sN7POAsHt2h6PjNVLCGTBMGFJ/5KOAClc+KKEbaLuUeqK6opKhBmbEwfSp6jMU
         PbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679362; x=1793284162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ip3LDVkz43JVMLeEy65y5DnSL95eKEKIg6rsimQU6Ow=;
        b=2jY2OzFkMHZSlmcVEZ5aOuOMYuKGQbb4ipMPzA/py46zTGos506gahRdcDMy+l50Vm
         qdgRS8MpjGcEmXb9L3k/siO9+yIiiWSsQJCF8OXXPOA3sldXCy2Uid0reGqzIoOPE3H0
         9QDlLrzFJtMKtNMqmCy/+OOR9lGK6DmkCzqh5GiqHy+43094HPxBsKaI2u44OsaEJLhj
         AO0ZbDRUsKk7/oKPUTo+AFFAIgQVKsPkwzxhkaLMEpWzktsUNFvUjPu6yGsbEA2CwJHa
         pRPyLJTOk2+5j8609cKyjZ60UTjt5Bou5bEY+57C15StQMq7nqU+jLF7WelO4u8OfceE
         vqFw==
X-Forwarded-Encrypted: i=1; AKwUvBy+q7FbgM5iCLM4Z37yAr+M8jfqs8KLA1PDUnRoVfhjpiRMMyYqI2kxMKMiDHNcModp/VngupM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQcs5lclXUDhRSOLL3yMqFAKH032fMvLP2r0P6USOGss6r0VbK
	+NJAfRuzu7LXZVhGYyM5cMotLg/R/cW4Df6mJLTlBR1TWDl9dGaCaY9pIrjgatn4Sw==
X-Gm-Gg: AYBFou0asfByRFBvISqGU34oYc5WNWr0+0p196BcIeOOFPFAEU00olDthM1/RDwYVDZ
	/mkcM5UuJxlWkOoZbwq/WuEklt7lzy8xiE/urV+lVWBzbs70BnZ/0iezE8tbK0GpbPAqHh/6gzQ
	uIVJLJXxBJ7u1mzo13jGrMd7KVewu7O7XR5RGvu+hv7YFIVJ7otK5chnMoStWXGI7bhPox2Fst/
	CgZj4uV83lY3ZnuCgfsTbdsR0Xa0Sw7Lj7QAejMCLig3z+SJDwCMgb98OLFI7v+NoqM0CStbQwA
	yON0yzOyPzj86Rl19wDDZzlphpPJHOddy8TsSOYhjW8GvAfGm7bSdKP7HPbvRHRt9WLJ10OSHVF
	VeNz+BzFrBOIgb2HPgAXCByUW3QTgb6aSHznRcTr3jrb4YlWloZG91ESca1Jf5XTSUxfn+sbCWP
	UV6QRGRvJQcDwMV/oaBODQurojLk2wCa+KAsuZ4voCi1P8k5gjfBR8iMm8CrbsDnm74GNF78SSu
	TjnbI3eaUZpyUH5fSYUzVsndS1pOByGq2QGLbHYbs4/WmKS+V+7wyJCVquNsvVKnqh3wsjH2vVX
	POESe0WinUmMRX+DTS5LlUhw
X-Received: by 2002:a05:690c:6603:b0:8b0:a171:65e4 with SMTP id 00721157ae682-8b133f979ebmr36772897b3.15.1792679361535;
        Thu, 22 Oct 2026 07:29:21 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300f3cfesm27329767b3.27.2026.10.22.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:29:21 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: do not advance i_size on a buffered write that copied nothing
Date: Thu, 22 Oct 2026 10:29:11 -0400
Message-ID: <20261022142911.1490979-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <34dtkdstf5yxg2ulinnh4hocc53gz35ij6k62egi2ykgpyc3a5@zuxt6doiajwq>
References: <20261009044656.1993196-1-hengyul@cs.unc.edu> <34dtkdstf5yxg2ulinnh4hocc53gz35ij6k62egi2ykgpyc3a5@zuxt6doiajwq>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jan,

On Thu 22-10-26 11:48:35, Jan Kara wrote:
> I agree with the problem but first, Ted has merged rewrite of ext4
> buffered IO path to iomap your fix would very likely need rebasing, and
> second:

Thanks for the review.

In the ext4 dev branch, the iomap buffered path is only used with the
new buffered_iomap mount option, and it faults the source in before
->write_begin(), so it does not have this problem. The default
buffer_head path still does: on 8c4f6e337634, a 100-byte file still
has a size of 1048586 after a failed pwrite() at 1 MiB + 10, sync and
remount. The patch applies to the dev branch without changes, and I
will base v2 on it.

> this is wrong and would leak delayed allocation reservations AFAICT. You
> should just use ext4_truncate_failed_write() like e.g.
> ext4_da_write_begin() does on failure.

I don't think it leaks. ext4_es_remove_extent() gives back the
reservation of the delayed blocks it removes through
ext4_da_release_space(), which ext4_iomap_punch_delalloc() also relies
on in the iomap path.

To check this, I ran my earlier tests on the dev branch with the patch
as sent and with the helper replaced by ext4_truncate_failed_write(),
plus a test on an image with the quota feature that reads the user's
quota usage (which includes reserved space) and the free block count.
After a failed write past EOF, both versions bring both numbers back
to their values before the write, and nothing is logged at umount.
Without the patch, the same case keeps 64 KiB reserved until the inode
is evicted.

I did not use ext4_truncate_failed_write() because since 665575cff098
this path is also taken by ordinary writes. When the source page is
not faulted in yet, the first copy fails, ->write_end() sees
copied == 0, and generic_perform_write() faults the page in and tries
again. ext4_truncate_failed_write() would then run ext4_truncate() for
each such write that starts past EOF, and that frees blocks
preallocated past EOF with FALLOC_FL_KEEP_SIZE, even though the write
succeeds right after. In my test, a 64 KiB write from untouched
anonymous memory into a file with 1 MiB preallocated past EOF leaves
st_blocks at 2056 with the helper, but drops it to 136 with
ext4_truncate_failed_write().

So I would prefer to keep the helper. Is that OK with you, or would
you still rather use ext4_truncate_failed_write()?

Thanks,
Hengyu
