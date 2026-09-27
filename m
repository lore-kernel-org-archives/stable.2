Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E93939A4
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539027; cv=pass; b=hqYze1w6uR9P+vVoqCe2EqF4d1L2/WNgmzhIk79mldJoj6Z5j2OHkqS6+0RAhk1J7PdFwTFHgRtgVWHUaieVU/ItHR9vJB3Q9dTnWhTy7HbKj6orR8s0x41n6gz1/ETcmLQaWufvsh/98OEDbz7qcK+lS/SZ05Zaee5V9l6csdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539027; c=relaxed/simple;
	bh=Rl82HRH9QhRQ15slVr5/LOduMsQeFMyqd3DMVvT5fYQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W9yipOGKSUe9ZoGCXAsosATidnRUxKezEil5cNa4GQ5S8j7vgz4f9wwKDgWnE5mNAda+ymqz0jHVwsunhFIhjJYBAKFNFwckE42ChWAGJhyDSGWeUm89wKDCEJDFtCdv+H+KRFX9iK3hHtFfU1xvYp3Xnfx+rSc6BpFAN2KLD44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxzZ9EmL; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxzZ9EmL"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0299c787so151681885a.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 12:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790539025; cv=none;
        d=google.com; s=arc-20260327;
        b=R/fYsqDpy9GFmkw0enpcTI8MJX9Y40EtuCS/xAkYyFDt5h6NWSE2/JdAf7MhiQW5+W
         qDd6CkInhoa9xxBgFkdA+Oljc/3k7olJSBFIGLf8XT4Qi26vFiJ3qto6auwXi0MlwUS1
         A7LSkE9K7Grdc6TdnvgT9Bmyg+jRTS3tDua3xRLC3kZLm9Cu+xTJAjy4VVEFWGxVguLr
         BB4489N9swfb4wkwihdP4Ofqd/S/EFTA6vArYpEMHpWZTI9dgKmsofoYLGsF7eoGf+mL
         TORpK014Jon/xWxU8gw7Ec5EeH3W8d/ShdbLlBjWTCoTvxNQtPoHc4GALd93fIAbhScr
         hJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Rl82HRH9QhRQ15slVr5/LOduMsQeFMyqd3DMVvT5fYQ=;
        fh=P7khHHMXgrsGuRSJAo6un8IrGadXFp+JJkxY8oXnt2o=;
        b=G0/Iq5oYjS+yU+LQB8A+/D1P6c9gAjHhRT7SZwUDY0zsNP8aTVfSz4PTc6auTL0LNz
         Q7eVD0fiRzsuo3p/caNZ2o8pTQHEueGZjzQHYsQvnEYoW+QFrb1XStmN0ee03LzcEJPA
         5UJ6vmkdi+1F7bnqiUaOg4nG2+5Zi3Fnx0T5tceByvsQvrZEcGSc6WDFrf4L9/PMuX8A
         3ST8LLR7kpS5dQP5DyQXtb9UkC5oB6e9mAhLrX7oWA20EO+9UuIz4AP9R9OtFnbPNoFx
         f3A3kKZHa643R+E13pppsdesx5pq7++bpemGhARrreQm507or4JpRyHqKnuoSoxVaYw3
         9Xkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790539025; x=1791143825; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rl82HRH9QhRQ15slVr5/LOduMsQeFMyqd3DMVvT5fYQ=;
        b=LxzZ9EmLuscV+GwSshg62otchKngE4e/OvPOsIx8QUvfYMK598XzJThGjVNvfHkVph
         Juz0c9aVfur4rZhfV/PuUKPH/I+//hlpc2DR1pvQy5OXi7doogbSF8etnm2AnUpGDeM5
         X9cVZ7yaVDjfd8KQwQzpCocaa1KbE3Q6IlMlfe3RT7H40fuc0sypHAHi1vgWpr93mJJN
         BVP7qAMWKK3fsTykmcsr/eMxakpFDVukZPiNEsFfClUkjrpznKRN/xn3rZpFgybz37QL
         Y+NABlYJPwqjQ+LDPiJ/0j0c17CPbCuMH8jjzL0lWc0ILvhflJzpOynw3uO/vZ2e6cub
         97wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790539025; x=1791143825;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rl82HRH9QhRQ15slVr5/LOduMsQeFMyqd3DMVvT5fYQ=;
        b=Y4JaynXC6mMg+xZtx4ChmFuYlRUGySt7K8h7bJWTpSwKyQCYOJiHe/sNxO9YjKM+fv
         YebYiyAW65jAnInZeib/C9xaZRziEUvxmvn4cFIk4ZTi8Hnxc0yua7GJqTMYOQm2fU60
         C+FX7tnMuDQG7hnPnfoM3RnyJEdY04SAxMV7VaCJZM+SBvTFVbi021u0m2yNCeHTW1Qy
         zrmpIRUgS3soxi9A1k4cc2L7Q15hZ1NRahSoiTKbpO9LhK9NfG3H+m4545o6wN5XVPlP
         kmnc/GB5yjnVq+ezZtAnucKVSCtIbTn+JpSPyeft01bUemBwx/ihnQZySAEQ2vD2j+QC
         sWYw==
X-Gm-Message-State: AFuF++mwp75pjFBUCrjrkYOwhJddY1ouhFNdM8xTlIvRySR2wnbgUuDo
	H4TMmFem6xJrx3u1+HAT9TWsFGepb5Wn7qlTZ8RDSgKznbCxX7HTJUEobnnxdv1Xs7PS1vlt60N
	qTDErG0oAZccVqVedszE/ZzZRY4S2DUm4tVGeF6Q=
X-Gm-Gg: AYBFou0Z1UEqeD3i5ysutm3E6Uc0KlIgZAbsG4gRk0HO8Y6rrAdKUITUb6caw18Twpi
	GxyvStav6UhP0Ypvg4wL4vY/YTEP2tt7H9YpnjXdVcIUqpLPkkm1AJRe8UPBjbfjyE5Efhwv92V
	37NSSbeLecbyRdDZABjqxoKSwN3SyiVHi9L1D3YdXgPq5lpf+szhpb7GEw8d2lVlGFTJ5qgY+U/
	3+FFK9439ZoGRFTBWepe9OzvLgj43kBnkAAlKgv91xknw43fzoAFG5OlY6TwOYoEbkGJz+YLHfc
	eIKCMnTNtGDv6uTDQYvPD1JP0aG/jCAW7nQSUZ6wTg57//dsPSCXhju4WI62Jbyd3pn5ImyDJM6
	+ToyS8kQwv9tGBVQ4nxvXwZsNIouAU6cBWPr77uPa3iQUTN4rCV48/RqjDUdKuzyh2EmFONhTq1
	k=
X-Received: by 2002:a05:620a:170e:b0:93b:e578:583d with SMTP id
 af79cd13be357-93c43bc5366mr1762871985a.21.1790539025038; Sun, 27 Sep 2026
 12:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo Greco <psgreco@gmail.com>
Date: Sun, 27 Sep 2026 16:56:54 -0300
X-Gm-Features: AclHuK-RSbH5IQFKBYuPOy7LX-qB6rGHWKnLPO3SAj5XL3E-rYdkr5GS8AcMnes
Message-ID: <CAK9Zeh8NgWCdXy6dUiakqy+L+fieU8NJxJNxPadbF0UPHWUqyQ@mail.gmail.com>
Subject: [BUILD BUG] tools/bpf broken in v5.15.221 stable due to backport [7140c9e5e460ee11172ea6c1a6e368b29923003d]
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

7140c9e5e460ee11172ea6c1a6e368b29923003d broke v5.15.221 in two different ways

It uses LIBBPF_OPTS, which could be an easy fix by adding
be80e9cdbca8ac66d09e0e24e0bd41d992362a0b, but then it breaks by the
lack of "sz" in the struct. Also fails due to extra args in the call
to perf_buffer__new_raw.

IIUC, both issues could be fixed by porting also
4178893465774f91dcd49465ae6f4e3cc036b7b2,
22dd7a58b2e9965c1a612b6a09c4a6146cbb5873 (along with their
predecessors)

or by reverting 7140c9e5e460ee11172ea6c1a6e368b29923003d and its successors.

Please advise on how to proceed.

Thanks, Pablo
