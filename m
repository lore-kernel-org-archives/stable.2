Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF438838A
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299299; cv=none; b=QMTsS0g8C8QpAnP30FHUOXhHGtmqfSrDr7iJnW+z73AlkQhOr1BlqNH/ux7PSsTddipspUpiZiJyz+kHFtx7occr9Mgi2wdMzIv/Oqgr80XWPoaBtqnIwlAEMT4QR1iQ+r+kbE2nyjc967abPw1W1w1ji3dgI9i5TuQNNSBYVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299299; c=relaxed/simple;
	bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XWQXjvw5YTPeSFLh9nSxbK43g2fwfREz4Ca0RyPkZKsYCb+M2UkDdnQQDStpJC/Fv4mueG6Cj9BCGWzNksFMdV1lzCpXQYrNACmSe/lN+5yFtaIB9+3GSLZ17fGDMTsohxUMascXJca7faPhupKoy522QSEBlKfwtCTYtDYs5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=hti7boRv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="hti7boRv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9155183b42cso184962485a.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1781299296; x=1781904096; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
        b=hti7boRvfTuf8L/5tYvz25AJVZ7MorYx8fbkeloHiyd6tARjS3OaH7ATljcUwRJJsT
         U3Sjr73ajXpcKSvs9aknjK+mYa7QWMxgZznSRKeJGpB0ZPmFsGxbxuwWJYVL1+VAbQph
         9j4KHRbfsmifBEPz2s7fErUsXhSG/yFMwy+GDnLyaFT+jtQWmyqwi1kf560YnqeWmLiq
         srl+W6gdbxAG/3WyPbKJQ19BgCTGl9iqkT+Vi6s8Ft/a/nJ6IL/VcJSxs4wXuLSVR10d
         YfCqlLwHA9igMHfpTTNeeYDEJuF1qwF2LL5R+ZR4aix+1YPGexJ7aQZBlQhWiMh4Ry1f
         bXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299296; x=1781904096;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NLBDUT/2YbYk1htpDpXiMSPd9MW9FLUFef7KJHn3ZI=;
        b=lopszq6WCIllVCTOfy4DQkZBQq3JK/EifBVBeGkK11LEbAHECMVyraRv5Q0TmRzvDG
         iapPsCqn00B+nYMohirrqiIkfL1hhMQwZNdQpAcqjLBnFBfxpHplxpZE/4zB6E+lFfIP
         9/igKENB3MrkVhpRe3rUaLKjlazSQS1VB6qDEmR3JdtaUbpRaLsFNXGk2Xt+LlUODQ7b
         +VPEJlQ5fisr3cZXj5EXuh2SLOrlOi1BfjzYkXRhheg3b/1kT8sdb6QL9CJuxbgXI76P
         3M8eYinL/1BQ8Wy6keIFH6EnH1/AgRyuFYgDasvM+QbVFXSqDX2H9iMr8xYHhPHj6Uep
         nIfQ==
X-Gm-Message-State: AOJu0Yxd/3HkNuwAZyfZ71qaKBFmpP4HKgIDDWFfVBL9Ae0hjFrDEM1S
	jRCyvhteKTfa8YG99HYSv1CXwhgEub+EUNCw80sNjYbVmv7QzFAN6kPMY0WyctC3noozFfrG/Uj
	4AyYe
X-Gm-Gg: Acq92OGzShx/W89OIrFLuVG6vAtTuL+8+uAa1DbVBu2/+E5r4qfUmoeScixqfrGUYgR
	9Uj0yH41TYbAjm5ZfIjXjSzyHPSVfsdIu7XCrdpof0dGlpiJbCkV6r3xuPw/GFUIsnTgT2+rL38
	B2zRJd/3OMIoYfSUVrLSIQfCp30FKMRtFB5ODYe8RsVHMW90Jvp+XPTSuU6kYfpY4z1xU60tdEn
	upGyvFdo2OUL20XX/OQO92wcZ97e3GlSqt3uh/dYEu+h/TjeCTuAPan3ArCD6KvxpsBDCx4RtGg
	2QsZXyHisTNuYSdpScny5dzXNL3h2iLXODY1n3FWtlHV/iruBzt0jXkEiN6R/6PLnIF5JBJFoME
	NDs2w+OGmlNZh9eaeU4udfU7yUni+DKkVxqMZCt+qj2RG+KQGNN0TMcW70MG8sBreJ1LHYxUbr3
	ogpk3WIldp0tIsQpzGbj4+JcM9tp6QcFzxmUqZ
X-Received: by 2002:a05:620a:a0cb:20b0:915:4c9b:4120 with SMTP id af79cd13be357-91619f3f226mr496968085a.37.1781299296466;
        Fri, 12 Jun 2026 14:21:36 -0700 (PDT)
Received: from localhost ([2603:6080:7702:ce00:dabb:c1ff:fe4f:43a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a073548sm328378885a.46.2026.06.12.14.21.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:21:35 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:21:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: stable@vger.kernel.org
Subject: Please apply e1b849cfa6b61f1c866a908c9e8dd9b5aaab820b to 6.12.y
Message-ID: <20260612212134.GA3841315@perftesting>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

AUTOSEL already grabbed the other two patches in this series, but this one is
equally important and we're currently hitting problems in production without
this patch. It applies cleanly to 6.12.y. Thanks,

Josef
