Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907213E410E
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426538; cv=none; b=G70LrieiRVMc8aeoW8Mu6jGVYKH24/lrVIDkRVsUCqbBMl49cDbjR20In9ThNz3QC+NKn1IfeonB4fZIeatL9a9HYDxDvdv2ApRmhnqVwstVxn6QiJpnqj6SMItH7lehVvj6I4X0nQ11W8pSI1TSSMj4BoSjw8PbmLPD4BeJPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426538; c=relaxed/simple;
	bh=sKSpzcAytLHXA4fudNRbsNoo9eCHbGh/g0Cikzg2xko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arljSeUKqAdcSqOoFKnIpLyCkFUS2rQdM/0/WaJsJnbZ7BPfRrgsQuSKJmqFn+2JmP/+EXme2q5i8YjL5io9IiewaC7+Ejz9msAgi9X/lWOBP1VSY7DvjD1jav/n4bJCfX2oRLxSPZryKQpxHVLFsFiRFTYcFHlzDwFvuKpyLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd8J9sg+; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd8J9sg+"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so775704a91.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790426537; x=1791031337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3nGMV9CTrwS9xcsel/dvLA5UKRn0rUB5yA3qbzghtk=;
        b=kd8J9sg+hluqCmn30umpq2e80BaHGjSnXl4nd6kPa8CUqaMtGZpm5TbdsIoaKJQfUp
         KxpLJnt/vYzskNQPy8Y5sJDxXfEUv15r2YcTPZlLJbMyYe6tyikGamGrXgQyV25Yd2O2
         OGMlEhqoee+tSTTet/uNWE5iTXVnAeNmf+dtSk/AlwMBzPYlvR7R5WXqpIrjMP34YilW
         mp4+llubzXqs51opDDTt4aFH3g54cl3MgrJXCGMNAj9HSRVJP6NM0tVPq5MqCkEJbnzO
         wirSDO/TPyMuSF8PyD2gWjFJsXkmzzUGDFshRAigdufcb4MCEy5spZpMSlBWyoJWSmQM
         iagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790426537; x=1791031337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3nGMV9CTrwS9xcsel/dvLA5UKRn0rUB5yA3qbzghtk=;
        b=iiq48gb6yRGXHyKuFh9VXbIMO622xVm/LKndOFjwrqdf29Li6CBCCk4Mx4ZhQ7JX3F
         NrPPzzzBE1+96BzJOhvWdGzjfvsCbYOSLDjgtzyBQ0b+FyTcYP78AG3dUqY1H60ExxuE
         7C7D8f2IbKCyzhtFVG5+p3ALx1S8MKOAQjD9WHieqKSyGwqz6YI49IGvRbJhGsKe/Don
         Ai0sfvhGFlsc1WHl4hbHn6HrF4Bad5xvGPBwPe/YaUpAo364ymbqf2zyARyUO5+OLjK3
         p/H6c1/yBW6VCImTM3Gk8ofzawGMycSZsseTpvnKqHB4zC1N0PMqWK/dHxN9SziE0ip5
         sHIw==
X-Forwarded-Encrypted: i=1; AKwUvBzlTvyjx+oLDr/n44dODOOpHtZWPQcaOEa+9hHq5Is/lMRhWIg8wYH0XP8slXh21gb8JhNglFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkUpSaq31G8lQjqmm55LKx+I62NI1mOfs1JbCvgVVCMNmMM9fZ
	ygA+8hOqHFF0WzNc57PGywomfHEeHHweAxjWAPfDOJGYOeAm/u/IeZQ=
X-Gm-Gg: AYBFou3gZlZ5p2WXZCS9IfolqEQVUKN8Ho9YkRXDSEBNr1uuWs1ttfVXhn1D0aIzxk7
	3cFZs3ZtDy+hFD4MiygcyrXJDeUVvafSDryZ5VP4xWPSjPa1gafRTQjnNMbCYmDVH46OM6a28i8
	R8yWL+f4KJIpMfMB8SpKtnZAkVlIZcWr65Ixiyj06AF0CyU6qUddUY9pC5AFJKTLFVdOzypVxfg
	LR4lHvH+4aqpuMdHW/BqY934lMgWQrr1ZRut7L8WVyPfOcL///u0oClgU+GHZ50OqiS0nGCtP3A
	iwJYdDqAfk4McLg91pGceBJMQYibMH6q0+sdoZ2x9zsxtShs7WER3a6xLAH5uQCqbxYDxr1xM4U
	Xolkh3RCVrHcWiW+aoaMOXHOXkutyPEbR+hmT6UYqa1dDK3izKygcqgYiap7cINrFInlwcskUG6
	3sMGwITgypIwwBER9iTSnXtWfsebrMCn9hb6QvtRZdriIF0dkCpuoajBsLqlxT+aEQaG02AhoLc
	CA3OcruYjSW7uHiwG8Zn7NJ
X-Received: by 2002:a17:90b:254e:b0:39e:6a81:f351 with SMTP id 98e67ed59e1d1-3a098bb66b0mr6996915a91.43.1790426536797;
        Sat, 26 Sep 2026 05:42:16 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm16337350a91.12.2026.09.26.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:42:16 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	rppt@kernel.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	shuah@kernel.org,
	kirill@shutemov.name,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Sat, 26 Sep 2026 21:42:10 +0900
Message-ID: <20260926124210.2878601-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924214811.19ef8af417d37071ed8338c4@linux-foundation.org>
References: <20260925042907.2330519-1-donggeunyoo.kernel@gmail.com> <20260925042907.2330519-2-donggeunyoo.kernel@gmail.com> <20260924214811.19ef8af417d37071ed8338c4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 21:48:11 -0700, Andrew Morton wrote:
> When fixing a bug, please always fully describe the userspace-visible
> effects of that bug.

Done in v3:
https://lore.kernel.org/all/20260926124145.2878520-1-donggeunyoo.kernel@gmail.com/

> Great!  Please add a prompt to LLM's .md ensuring that future
> changelogs always provide this information.

Added.

Thanks,
Donggeun
