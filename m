Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DF409298
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291554; cv=pass; b=A5WJyKwWN2RYvn4IMX+S1LCZsepou6PISrDEK54+xq9VxJOCJ6yaT7WAqUrndAF1xYcKaxDzpuTbo3DH49tTyM0ikUOMMIYmKfoI0DYtlF91ks7LlPppNryxNva6bDsB2LAWEFYa0QXO4diyBBbXr6slHCcmfpgIXtcGP1X6iuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291554; c=relaxed/simple;
	bh=i5gtPL45/HsWqgNnaIaxvWIYAE5RMDtissUXKYWjbRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWibdXNDez6TxgNnWGBDPWOyh+y6Mv9SVN3YWAS+KVeyRxySpUAI3di62cp8uW74yjuDf/k6+w5Uvlawi4IPK5SwqFLfmYi3k7hBWPl6JOWEnxACLOxh/j7+nNHyf83Bl+OlraOnM3ptg9mmlOQfdzhD6LjM/AKiNMU2SpfQRjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNhn+6bQ; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNhn+6bQ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso40365966b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790291551; cv=none;
        d=google.com; s=arc-20260327;
        b=LGrnlbZNblYS98aaH33PEVYU3qvq5DUQE6kpLsJ4fTXZcnqh83xM7HxWWHQMB6Ctxu
         oID4U1fCPUxsBNFjs//BVKw/aT8bCwbDOiLK1MpgBw4jepU3NC7FiB0fJfiihwMB+62+
         Q0TKeOyJyo228Tltv0V89HeQ8WHgfjv7XtjVo+Jq7QZhnyLAsEdOEVCZEaPaMw5daosD
         NquU6Io38YSUZhlpU2rS1xMBT00ledVtOSKch59TZ0xB7bAFzQVlq+dAUmeXS1AWqqR7
         AfPqUMJf/6f5TOjD0FsOUc3CxvxNcr2OZMPrI9qWbqryj2idxTrYp8da9WPk1CKNLJKF
         780A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1/GtmCck+btFeib66fipBTabB87VzP8LLtE6Qx5AZ/Y=;
        fh=hfYHmujyHHOD6TnouOZfWIR/N+ZQwznLBTsh7hckEmU=;
        b=USZKTuVeZaZXHFyEnP61eOiNfwGD1tPPmZJB+SGkLUr9aGetCPSJbRLmfWUSLE1VAa
         gk/82A9RHWmIAnNHF0SeUOSbTybNYFLthSfq6O7TISQ6U55EVnhoZuEmU6xg3d8r6c50
         ud1FIeA3MbJzvF5Or9j7DKGTJhrXBFoJssXFuP7K4DZNHFJqiYtyBo5u32YGCQMQC8H+
         DD7iXQYZHewP4jWe2k8UzWeuCuq1F/bO4C3waIZCEZkunoTpr6sINhiv8qL0RAMqkd4+
         L2A2KffBA6Z1HeZDbKzNuqwk+fQ4ld/nrd7OfDZ0l3ZkCPKhmmbZ5otfyT2EJVoiNQXZ
         SBAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790291551; x=1790896351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/GtmCck+btFeib66fipBTabB87VzP8LLtE6Qx5AZ/Y=;
        b=MNhn+6bQ0yOwUi7nD6sQIuImLP3dhxaCTGS8dOraKPpILKFlSAkUGE3t4ALNV+KO9Q
         /YU+LtmbbQkpU4iiaBwJgqyWJQh4Xc5wZqldJV6GaIQvRo7eCbQxqIfb7PVDjkXIa7Bp
         7LI1OBOZEb5rgbfLu0eOtxGDw/wihzA4pcYUPoba1k91jZiLyqKwGbcNkHiguyiDuuf3
         h6bxvZ2rvSaeRHTBpuP3msEQqCYBau1I5OWIfkx9/xmqYRzwJ/03CjSzFDJnS8AEBcVH
         s4LMyEZVErV1aRicdWUXf6Y3wEPkcOeDky8CLY0bO7rryhOpKdhL0Hscv50Oitv9sLOG
         s88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291551; x=1790896351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1/GtmCck+btFeib66fipBTabB87VzP8LLtE6Qx5AZ/Y=;
        b=n1QJfFV+A5AUJWwHX5Z7s6YcmYEonIpegXxHaGvMyeO9tSei2VpySkBSmVO578hkOB
         GSwD3HJWlvWpELWJUve8uRD2Y9E4zomuVnw3rZYVSEHLmTY/QT5j0RFDtu5spRMdJBDV
         BDdg0d4DOSy7DrJf5O0G/L0ljFUfO7jypRKsm7+pP744IfuuPajTFvM3R4oF8MWC/9w9
         Kbn0NHT6cceETSZkZlfPgSZ3uJJEaiKNcyj9vnWkOj2QfzuVkABsuh9vuqNSg84mvvMA
         CRF6Ns1JYG+ENqCytdZ0TqAWfoHUDSfShX/vkYw51MIVRj22Q0qNfUNL/49wy2vcRkrh
         Q9mw==
X-Forwarded-Encrypted: i=1; AKwUvBzC5AenSk9kgu+e18eA280XCJBCKeVCqAjoUk2aVPfHloFLRs5wubVcfgmhG7L9yLQSu162cv8=@vger.kernel.org
X-Gm-Message-State: AFuF++mRlhB4lPejzpR2nan671EcTwx7RDF5nsy+VB2pNxbqnkwdtC2p
	OivD0sqRbimL+b2XMDMDwqCf5izUWOdUjqMq7JHmUibwfx79Azj6NfpsTHLsGyhCUspOuqi4NK/
	4s6kqm6d4jKTMsGiXayFd/DT7sGR4Ibp00+/zOlSE
X-Gm-Gg: AYBFou3jpsM955f5AcGyv5IHSLYgV5ffsIQ3dWeHEZGpzVZWgAh/oa+7N19ZZEe7Jmk
	r3MT5vZMa4waMw56alka93KA551qMTIMylxcc4Oqk3S77qj3gKutuz2WehlRgkvBhso7q9/p/aL
	cU5A1stOBx24xv4n7YRjhLDbCJbVQ8Z0H+KNBHnXkcKcPLTQBxYKUd3iqYr839GO7QIsKuMyV4A
	H+gjnV/QgeNrfsfiPBMwpnszwiOK2oI26YN2t3swpts4lQmX9YqD06JkJXEO15XsU6cNxVKkLDB
	FO9Z6Hyld3MXLg7aueGAvxyVPOPyzPwxMS5roC1i7dmuUcynT0a9cWPD29GlbXhuApvBABiEstR
	oZxmGNDG0Qy15Ile2m5yQ
X-Received: by 2002:a17:907:7a8b:b0:c29:3b7e:3a94 with SMTP id
 a640c23a62f3a-c2ac53d2785mr321958666b.38.1790291550387; Thu, 24 Sep 2026
 16:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918025416.604297-1-dhavale@google.com> <2ednz67kpd2ikrnerrmnvol2mdfntgqhakuoiu7x4cnrlpiugm@ojqolvlfmpnj>
In-Reply-To: <2ednz67kpd2ikrnerrmnvol2mdfntgqhakuoiu7x4cnrlpiugm@ojqolvlfmpnj>
From: Sandeep Dhavale <dhavale@google.com>
Date: Thu, 24 Sep 2026 16:12:19 -0700
X-Gm-Features: AclHuK_JnRXmc4okmBH7-69dBKIYOYrVopgPbSH1OLPpNlpiiv03zV98rUrU7KA
Message-ID: <CAB=BE-Svy3yoG+nJ7Z6Us5GG2Rj-7dyCY+EMpR9Y+PtyXUKnCQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix race between inline dir conversion and folio read
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel-team@android.com, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Good catch! At least the first paragraph below would be also useful in the
> commit changelog - the realworld impact is important information. But I
> guess Ted can modify the changelog on commit if he wants. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
Hi Jan,
Thanks for the review!

Hi Ted,
Is that something you can add while applying or shall I send v2 with
just updated commit message?

Thanks,
Sandeep.
> > ---
> > Note:
> > This issue was reported by an Android partner encountering kernel panics
> > in ext4_dirblock_csum_verify() ("No space for directory leaf checksum")
> > on 16KB page size kernels mounting a 4KB block size ext4 filesystem.
> >
> > We verified with a standalone reproducer that the race reproduces
> > deterministically on Iteration 0 (< 1s) on both ARM64 (16KB page size,
> > 4KB ext4 blocks) and upstream ext4-tree/dev on x86_64 (4KB page size,
> > 1KB ext4 blocks), and confirmed that this patch resolves the issue.
> >
> >  fs/ext4/inline.c | 1 +
> >  fs/ext4/namei.c  | 2 ++
> >  2 files changed, 3 insertions(+)
