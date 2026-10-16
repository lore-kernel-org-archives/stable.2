Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546348488D
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157401; cv=pass; b=os5goclVHXDa2U9q9rPdYJB29/ZNuzqGrG6XejYrOL+aeESDtIspQ182UNndyvuAiwmtkpgGDULZwrDB0f4N/BiQyW4q10hatIRDLbcTknfer8dDFBvH1cZOWJuBgCfCYcGhDd+1a89iBan6okn8Od7RYKs93eQuLVSMX4DT0ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157401; c=relaxed/simple;
	bh=ghSQBNQLHFKFmZCfz5WoBGUzvoX8ZbfSdQ88iO2t5e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzRwDVPWk/k3SDExCoMcgpCI4PgX1rx1l4HBYtsTY4g+xbnOWknrjs/rdCp9OvFfBRF1iM8WFVbmfNTkkNo//4Y+Jz4wpt6S64YYBPUEpRQN0thpL9lOLL2FN6Vrf02RI6s4/sVMBQe8AeDTyTbUI917m7jEDsjgSBn6iGFqgHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aCWMum+C; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aCWMum+C"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-534e6545939so21710601cf.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792157399; cv=none;
        d=google.com; s=arc-20260327;
        b=olslBRndh67ag+Z4Lgl1BB+O0GDTwNzu+rlOyZirOGuSRyyFO1hqjuhThSiNuNt9UT
         nkmf/DZ0RZEfC3SuqtKakyCJjUPO9DUPk0p851teY99rOawXrWXg60zZd0njrodfSQYa
         y9pXOzptbB3o7jTaGRKZIrROhIQryydqOh2cQrcBWXOQ5jQVkIrnoYHIoseq9CQRpVkA
         t5c5Yg8lcixxsH2KS/FufGdO8OJyOw7AZ1Aa9EjyeSLDxC3VytKEHotlUfjoGOUM4yCW
         nPpT4vxH8XaIzkxuHAE/Rr1qVSSHHcWd+dFK37/QbfKazeX3bl4KL12AAX03p1Phr4Ym
         nFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ghSQBNQLHFKFmZCfz5WoBGUzvoX8ZbfSdQ88iO2t5e4=;
        fh=UYtfz4xs+y7ayWo3LNB4XlDHcKod5iSSEnps054xfvw=;
        b=sQO5vKoqN/j9DtWvEPWESBW4rft0rpEO889YFHKlwvEx0YP9oNllZtbWEYI4cPC1UZ
         fvtX3kpv/2xFPqACLqGEhh+EYXlcbMihP5IsrJOMp+MBI3Ji8EhDNVBUKy/2z6XQldZb
         3HyhS96CJAAjCyJHnoOSv1sciEv6VbCcikRf4jB3uQUbyiOCl7068AmfcMsQBfD3+S3q
         Y/P3Vf9Sxz0f63ULNfl4+uQapDQZqovtehfwfWzuMSKxryLp8TUyUg6ZkleWG8EUAeZ0
         knsnGg39G9zqHEX7yEy/9O2ew8laV/AjrNp+BxK5CYUGgkM5r2+KB52ptcrgjE42pvun
         i++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792157399; x=1792762199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghSQBNQLHFKFmZCfz5WoBGUzvoX8ZbfSdQ88iO2t5e4=;
        b=aCWMum+Cdo2XuvTLAhUKiMVrIO2b1nqDzL7pZFYRR74ssQyLwwQvaBxZtGH5vyB1eg
         ycZICwSeSFsa4qdDVJ449YvodCCxU0IfujjZpvaZNJI1Rep1HsXnqjFwCvrPvCn2SV37
         JDiM8S61RG/TG1s48exO0jKkY8cbtHSRN86RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157399; x=1792762199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ghSQBNQLHFKFmZCfz5WoBGUzvoX8ZbfSdQ88iO2t5e4=;
        b=Ex34fTz3XGCh6oD81wGXDWufOEdqs8Z0pWii8IzlRyTJYDQsy6se+tnBOwryIX33uL
         60+3aMqb8TjDloE1gplFz4jOYUAuJK2VBkJzi+AV51nU0rs6P6nzqs8SF2MDbuGW7bOm
         aI5Y/ML2ui5ZqlcgGp+vtJW2/TzTZLlSF3cJQX+SbkIHU+ioE8VzHB8pyC7HqrEAYLBH
         6uglZ2BNDTn9EOpjojjL0+laOSjymkfwtN4tFMLJL8s2ps3bHu6ACI4QaIxUkVFHDGhW
         vhaJhUVs2H31MzbeKU0Q2lH43SrvRRuACoC7h4/Xm4U6U7GaFy2SdoV22xP7lXyHgdL7
         Z9KQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlQmoLDbUvpkKOdcvW4YNktkBReUVW1jKb9RCbR6BMF7tFwmdBn2zXFt0uwgcIbZtx1TFRgFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYj+7NTWvzOfNS0VwaVAl3yM6X4DszO+l6gDh8mzeiZ6n378K/
	0aYqDDwHrj/sh4TwtH0aadPA90AV2vzNIzsY/FmMav0j4Z9Ti3MKMzMspPHkLseEEIGxn0yDa2D
	jJe3LKpKKxJG8Yaxr1ozIdKpJdPhhNgOi/MqOFtM2B6CAZxPYWQOo
X-Gm-Gg: AYBFou2t11RnwCsczF1fJbtxHlgGE+Z/WTt8woS6KH88BvJPWpl+sNHK55KUYRMc4i4
	UgTdvu1w6F2FleaOW7gFsWVxCcsN1wOmhef4WyoleW+6yA2iNEzBAs46PyBCyXiWXyDm/RCZbIF
	KIdeK8eCLC1tNPIsmMLyQkLMuUwSAEz59NGoBf1NA785VkMA0+/DshnhDjQQvqQ0Tpa3eMVMovf
	kv/CwkgAS1r2vYNS+xPPT7QNjLsRaBqul8sIoiRE5j4NKQGzkxnf07SrZcgC7/DOVE+diBY4oae
	P5W733sZu1dgm8iFtR6px9qVeCv7WOnO/Ej/d9GZneHy0QvOiZmOn5npvBzrO+7jDhr1O/dL0wI
	uBkiKIqy1
X-Received: by 2002:a05:620a:84c8:b0:93e:48fc:aa88 with SMTP id
 af79cd13be357-93ebd24d0b6mr3718433185a.44.1792157399220; Fri, 16 Oct 2026
 06:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013090447.1180121-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261013090447.1180121-1-nicoyip.dev@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 15:29:47 +0200
X-Gm-Features: AclHuK-Q2nn0oOoNYqpQrR-8kWZpjdvKCpaqHxulvcgHMV-HyAEfr1ZNOIxPAaI
Message-ID: <CAJfpegupo+nAz_ELWYPezK5QsSEQ4-iuiXWrsme+yHvXrj0t0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix copy_file_range reply handling race
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 11:04, Chengfeng Ye <nicoyip.dev@gmail.com> wrote:

> Use args.opcode for both -ENOSYS handling and output buffer selection.
> It records the opcode actually sent and is updated on fallback, keeping
> each reply tied to its request regardless of concurrent flag updates.

Applied, thanks.

Miklos
