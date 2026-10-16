Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF13546E9
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162137; cv=none; b=dRQf2HxBPalloGV2lzA5iTuOjwa6/M6BfS6kuIBgnBsM06bWzdDzqJCk8+4aNhoEaK24SjKe37w55TM/xEqA8TJGw3ZxVp9bNbg3JPPFN2lXgM0vGkSuY5pOoh14X8NDpOuboOUW7EZAj3e2FerFNfuLf5ofJ2315kU9txndupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162137; c=relaxed/simple;
	bh=gj3wE3tKC5/eIlP+bFvEKPBktyUQp6ShnPK82oCwDFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG34+rM3o7tH7YX3sJK38Cyv1CrXALLDwZLmvl7L+KE5l+1s34mn0avORf8HU6qlZWhtxxxv3ArM4HXH+gSj9WzgXu0tusas0lPotxNp/nq7V7vDFUj9XN5jM3L6ZTfOdmQrTnMDz7gLiYq4s9fAYNOdF2A1ZBScLE19ZeaNuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lT/kzjbN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lT/kzjbN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f639ba307so342168b3a.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792162136; x=1792766936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=euwyB0Hu9EKnWTfQGDAfCyg2u8gsMszPEB2wlSrIzaU=;
        b=lT/kzjbN2ELM3ANZrQKeajMvfT9aGBEfMwbyQ0KfK3TwX156iwB6Ju0/PJcb8li3ux
         SRUwzrxIXjdL62WGQlxCFwsqFajXoXjZyiW70AD53UOStiJ08paqZYSDYn8G+7yyTNpY
         4UKb3XorvPxp0KiBw1nsFLDgs279/e5GYi5MwYFK/Yzen7rBET98cRWmj/kew7SnyMI+
         kgmeucauOodhoxPuKAcSoac5ekyrqHwOF6YIbdhfeJ3MROpE3Ez/PPAAsszNC6hBrLKa
         OO+YgiGaZVO5IS3232m2f+h3XbHhK7K8zeuYVUFlM4qwGZ90VfrqjCkEtuggW5faqLPy
         mAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162136; x=1792766936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euwyB0Hu9EKnWTfQGDAfCyg2u8gsMszPEB2wlSrIzaU=;
        b=WSjgzfWMaNUnKioUQrGCrDswQptWkeynzk4FtD/7DvcLRpE1W6+knixMyWHCoThKi2
         uLdB6piyesBpHImZlF+0cLNriWubJPKyyZfwKuKDkjHlhwTgmfKjJrD3aMekgyGXKLfV
         eYEWcGn56crpv1eiMRpIJUYIkCan526dlX1Bx5WyNCprKwozGaglGxtQxihr98EgypIy
         QSpf4RDD4ysyMEkpuDq9hsdQzkG4lEX6m5LrEQbXtQ9WjiV5SJdU8dAWI8pyf8K0q/06
         dYUz/PxALD/3O5ZMTHxuWfHIr7JoYikHSDWZosSpCZ6O/CYuzCJLZz7BrKAO9+1/UVPv
         kkPA==
X-Forwarded-Encrypted: i=1; AKwUvBw6eCvLbwDNA8ETJLGjB7gMAg8H5gjqFIkhch26calLloFehyAKQbx4PTjNZYeDLxMkd1Gzhfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe+XEc7qTbWumeRHK2F8dYNrrEq079bifDY/NlMBGxR5LQM/ZP
	5BAl2hJuT5D8fPJGsYtLVo3OR7gFbDcopQ1rdvVfRAPJDb7HX8+7CXj3ANgq1tuuML4=
X-Gm-Gg: AYBFou2nU7/Iq0xfYydLbCPZvrQGwEPoe6ZUVpyzLZJFq0B2jQtKmH3ElVKzTo6EsdW
	W5Wkpy2ujbplk0lGrr3H8PNntDEU0tGEgfoe01agXU0Xh9fZuzB41/wSkZLYhyOC3h+Sz2qUjmC
	5+FwoC7NEdABiHvqonkjQ2y9kq4HSdLHbQNnQuw600ffpolt+mRbZfasHnPLzT5RrqO8VRBDfJ+
	zBVTz0te0URstwZq7L404sThERQs2lN3Y3PfM2PJlFBLBFEMts/zuCtitY1coBxBVQxd4WQc1lC
	P63ypJsE+3IAFiHmhCGIKC4mSjA8hwZF30UlW7puQSbrk3JaOosYa+rcCyy4snO1R5H5ZBToI9Z
	BZsOPMlvP3O16xqutMbjpE2xHEHVVSqsO0lMqOMMl1eTlvIDTyq8GHPUFPIAJdhPAmpQ9p9Xynw
	5j9zxPZeG7L2OBGcToFrnaCY6D3W3QKjF0uELiYq11lgKJqzrKR0hrWdn4oX/NtlzRkxJqsMasT
	g==
X-Received: by 2002:a05:6a20:eec4:20b0:3e1:bb25:126b with SMTP id adf61e73a8af0-3e1bb2515f5mr8280336637.36.1792162135553;
        Fri, 16 Oct 2026 07:48:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm1273911a12.1.2026.10.16.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:48:55 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:48:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Atul Akella <atul.akella@gmail.com>
Cc: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] remoteproc: mtk_scp: fix da_to_va() bounds checks
Message-ID: <atI5VLH_CiIBu0tq@p14s>
References: <cover.1791198233.git.atul.akella@gmail.com>
 <20261015151938.1331-1-atul.akella@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015151938.1331-1-atul.akella@gmail.com>

On Thu, Oct 15, 2026 at 08:49:38PM +0530, Atul Akella wrote:
> Hi,
> 
> Just following up on this series. Both patches are compile-tested only (arm64 defconfig, W=1).
> I haven't tested them on actual mt8183/mt8192 hardware, but I'd be happy to help with hardware testing if someone has access to a suitable board. I'm also open to addressing any review feedback.
>

That patchset did not show up on my radar because it did not include the people
listed by "get_maintainer.pl".  Please resend with the correct recipient list.
 
> Thanks,
> Atul
