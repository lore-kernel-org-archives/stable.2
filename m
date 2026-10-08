Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16038F950
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494917; cv=pass; b=IMDeRstUisOWvCswaNCYL54k4G3+jz6U5FVH4JkWPIRfcn78W4mOlwAFSJK8mv7+bWXRF1Sm+9koedBhcx47g7/Wpl3cVK2uWRClppIXIvNJp7TVhbUHqn2yEaYlDgAI7cg2/tWTj5QXVJ/jRDz0F6PUBvjD38G5sy7xS3slxhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494917; c=relaxed/simple;
	bh=hw71EnNIbbz++xqDviTBnAlWqT5921Me/DS4ajh3QtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlH44OfYGGUaX2roPNecBVdlljJi498uOgCdC/rWvkq4/261Rlg9PjJywq7fRYvaScEWfdH4+ZYYVjNFFmNwTpMesRQrAj7A3+YBB10tCSW3zseseud+23UV5Y2pTc9Jih9R7Q//dDi5qA7cDCviBTp91akAGSAZf3XF/yXqfdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd5kijtB; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd5kijtB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535179e995bso37382401cf.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494915; cv=none;
        d=google.com; s=arc-20260327;
        b=Q/m8ECedA1lGgkPhbt8TlYFlzncGi2htg9HPKPSY08ng74/aM1gxLEnPv7hkBv96SK
         dcx+kR/7k6Vk2DEe5NZWai0T7/6HulOV8MjE8zflhdN1LEaF7qpqzxCuGyYcE56ez0Cv
         iUpBl/9W0RTVABjX2R3Kgf2V9E4iaGG+nd/vY+UUB9DTK8AnZ+z1BKZOutKHwXNHN8HK
         as5YYKpbhSTbev+L1e6yyRfXNaCt+M6LMfRlFzG1ZYmXTeH0LqtRlwoqc/3ZTfgqg88F
         IAzGpphYlyu6U/Ahdq/3SgvyiIKgXmUoTB+t2ErZbPuV5tIhm2IRnQVe309tdfKOzYfG
         VM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hw71EnNIbbz++xqDviTBnAlWqT5921Me/DS4ajh3QtM=;
        fh=ZdZcRz2BJOzNbW1+TnQLIQg75BOyZOLUYzeFlzpsywM=;
        b=QhDH4MueobcB5ypz3qWsG9x0AboZmoEI/9GQ9osT8UewHMwxU/9iC4eLlvhaa0f4D8
         iSamTEHMjqJ/TbI+SxCx43SEnAwp4bVbZRHjJXve2/Q4aTd11DET2Tq5WptkhtaUmJDP
         03xjaqGYVqceNIAtsVPC9i+JEBkzTOjdxdYvnzd/rvZ5Uzv+sP27jnx9PoElSjftz/4h
         S0NHLcColOxEaVeZS6VxHkbwtdjeQ7ymy0vR/sBEf+Qzs08klH6Pp3fNiXXoNALNTC9Q
         m+4n9f2BRU2tULyk72pQq+ZznyLJ0Ze2cQOZqniCAzwN1ioFFautE1QCd7aWbIHNvBVC
         JVzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494915; x=1792099715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hw71EnNIbbz++xqDviTBnAlWqT5921Me/DS4ajh3QtM=;
        b=Bd5kijtBRJHLwxAG6RdRDj2aCF/qwobpb7etpgOExy87iOCEFJN6XgJGNAi+N4S6qI
         6ATQFsnpbCCiWCtR8eM+kVxkdlk9t2TJvDEw76pehYfVHCXZDxxf/TvRJCzUF4c4Ssd5
         dPsAqG+pEssVhnRjWnad6ZKfyy+46GUHT+ULnFi5YZML07S+KukpdCTKFJNKsQ4NlZNj
         pUQKcJY6H1AqyZ2vXVdZDQL+kbqiT9LsIA2juNyLWYk9YDlyuxTy52e1aVTkJ+33eovD
         htM4vEjJR11FwMa6lN5vCNnCO1tcjEv6KZV/vkuCZYiI/M+5TuETWZM8SnVrX8zsco/v
         7/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494915; x=1792099715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hw71EnNIbbz++xqDviTBnAlWqT5921Me/DS4ajh3QtM=;
        b=nz/qKOrkWK6lXuXlZR658WEqe/9TOgPzHDR6SB793eBLi13pHSNw1Kkhj6w7dsN6qy
         nuhWv8AWa7W6XySGbXw7S5Jz2rGY6xfWGIqDBRpk4Q1qnYIJYUA8F48jD8bk+1qiSc6J
         LgS2N1QFpm/N4JtUi5ntN6l/qbn4LjJ21ELjm8oLHWCykcwqxziN5dHe00DsP7SihVHZ
         Udk9+cvACUyZJ6MfFuV3wI+x2UpLemWpeiE3XzUFMo0bw/iiYZhXUJyDEWwee+7diFs2
         2ugu8msYSyzsU6EyFVfpwm0Vmzv1T3TWObdozW5MLRgh16qNL16Lh0Fy6Y2ZnVc1O2kc
         S5PQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZajYLw+ajCWo7A5MRNrfC/Oz8YvA7AzyVz3nc8TzCpmHgwlIcwN/pr/jRFXonxAqKitVAdiA=@vger.kernel.org
X-Gm-Message-State: AFuF++mdF6pV+t2Tp6jRFu+U+DXntMhryCCP71PlE+J+HPv26TEhubG8
	SnpoboilT8fjGtEc08DRgfWoXKa3eqGXjk+9vE67qswIKi55fxU12hPC0JSTA5MDTYGOazphE5L
	9ghk1cCLIwcrbfIAwjaz4L3cXr6XqmXY=
X-Gm-Gg: AYBFou24sOhsta4mG2Kfmw1cI1DiDJ70KuTBj4grC2fcCoWD6mz3LHoMbxxII5cDLZi
	6ufK9OiB3yqZd9/xackvgwkuGyBIdMjh837pwYA2kfDwtKtwbhecIsXa8VBfx73lOp1QfDEu85A
	1WHsRNSsk8MbFmc3evgua80c6k0GkDeiaSCVHZKPWn0cbJZ7gKB0Yvd3Md6fDAv6ikPDDBS1g+Z
	irqpDl7VLry1Vvxd1SqFYdT8FPH51S51Kt+8nZB1Uc+b7N4f/2gktU9aGv7YXEEQeSg4TZh+p9f
	Y7IwUB/6DVXXYb1tPwGu721XUOJPUwupq3b2pSaV/nJ4kGg7A49a6xVc5skyI9qZJLgSJpqIYTE
	onoZEYixA4ebYpQpM2mjKN1nm
X-Received: by 2002:a05:620a:2844:b0:93c:612e:9b57 with SMTP id
 af79cd13be357-93e9b84f3a4mr1267578585a.56.1791494915507; Thu, 08 Oct 2026
 14:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923074903.862898-1-linmag7@gmail.com> <20260923074903.862898-4-linmag7@gmail.com>
In-Reply-To: <20260923074903.862898-4-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:28:11 -0400
X-Gm-Features: AclHuK9egL7OGGTcAjait5dUGNk7qK_dDOKjCh1w7fS59DRwMwvQhD3rT6J8mjc
Message-ID: <CAEdQ38G4G6QyYScfDGuAFvzjyzOXrd=2K-gQM+ob8EMsWUkD=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] alpha: fix the local TLB invalidate in flush_tlb_page()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 23, 2026 at 09:47:46AM +0200, Magnus Lindholm wrote:
> Test current->mm instead. The calling CPU then has no local invalidate
> at all when the mm is only lazily borrowed; the next patch adds it.

Please swap this with 4/7. The else branch is correct on its own, since
it only covers mm != active_mm until this patch widens it. In the
current order a bisect that lands here has a lazy caller doing nothing
locally, which is worse than before on a machine where the tbi()
against the wrong ASN happens to work, as it appears to on EV7.
