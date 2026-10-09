Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5A230BDB
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515018; cv=none; b=uJaxOWP/MviTDUqiUDcevH51zlhhTF/tPiYgsPUbFInzli9600ZtinxYn2CO9j4hDBGK+kRI6GQWBjdlveB+efXVSRyk0+n9h/kL56rOng0p4mRQau3V3jNYW9KXs8DoHq7E7aTIKcq2GudxMrZ2JETEHYaxEKkoKloDbEWmrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515018; c=relaxed/simple;
	bh=Mh9Up+eDFeYNNPyDKALW1vuZ9LFpAwST49OKvcWX4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMuSfoKL+tbFeUXduOrYjL/ZPzuBP796MbOyn0AlhwoiwNBP6twrLEnrPUB0CQ4sBg4o1gaN4CweZjlgTazs7teKug/HwxA6DhPag9fhjXcg+JJnPTt6rAVzep23onRymWc/Wp2qypPt5Lu/F0i4uI+1UeVPgVR6XguP/fzobZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtBaXKi/; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtBaXKi/"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98c78660542so1816675241.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791515016; x=1792119816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
        b=AtBaXKi/WGJr2N+TjmOWUvurZ6NQqPho0+CtUs9VMX4g4XpfjnrBxrQJGjmkVUaxJc
         hkwNJGinQc7NZDHcZk+liiAFOlzDkpX/57boz47A+YCwKK7AL01g2TlvcvMy0NC2Qj9T
         vFxh5VVhtXX+JamZ8Iqp+JrXedQQVJAbGQP/NwNkcMRvwqPmH/pj+vWQNDSl44MgGjee
         7BaIuojUpraR2t+vLlqp2N//IYhOEvtvVPt5JUunLqj1a/3KPmjRniSohVQII4MAJMwK
         XEllgNyVBd2tqvDS98PlvuEsYJvtExRupMDjfmmPeYlKfvlTEwj/vALd7udjHc4Xy6NG
         AUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791515016; x=1792119816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
        b=S2th01We7vvjl7YzEHgfPtC3gdEtukLI6w4q25wKR5GlkkDS1yVXJ6rjbQQ7S2AmOy
         kyhALbYGdw5BjL6JA0nnCkyquHXUmT3V5YDSWeHtjsaPX0ZkcG68gMSas15ZM4fhqNKK
         7SLM43f2a2aVNUndGdGIJX6zdwySgC5kvwDoXhf5Of7TaP6WF5leRDK3oW/Smzfp5mkv
         ZbRygFFcU0BVd1qmr4dqPzeI0RCx4CYk0iVB7Dpr3UVPFlDg/xLzUEGm1I5zsNBOsDdD
         MBvUwpiuywyKVyslYBFD69ydS3pPNDTKWqnfeok6ffHSkhj4OnE3bNoKRkmqYvOtkfYt
         R+zg==
X-Forwarded-Encrypted: i=1; AKwUvBwSzpTJUNmKdRy0RA+u2XcgJLjyYethCmRwAkO04itjrm5O/BCpZ17I3lQ82CJ48ioMfDpbyDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8WWJFVIoVne7NrSvWy2dzoN/xb/6Wme/o5DCCHa2/b4kgnczB
	2Fzc6C+DCB60r5GCxWTkZAFM+r8Fc6yBtkQJJCqEIQAj3Z4oSM04W3Di8E80b0Dz28MDiQ==
X-Gm-Gg: AYBFou16sOO5UZbEPQ8ywDHPcUEYF9cNR/Ho6LYrDEJLHRyq+Nfy+T4yPn9hhSANvXy
	B0T2QCukWjBqFzuatDjYNAOjT7QsaBYBcdFJ/wQ711W7nvbSxtb9pksqv8RO65iroLSj5eAGGxe
	g/VxzVIRHgDr+BFLosBfNc6FwSRqj9Kuuap4dF8qZOgcFqZIRlIXvQ6Ti3sXLvLxHzuggmqnZdq
	CGSicajXVLQet3oyyohS8erLAF+jIc87QnNNIk3jjm9QUeK9CtUl5rIr2bh/+TEb4UIdl9UXc+S
	WdIJxpwhLAxuvGWiukQSsQq9VNe+T1GpGWtmfhqUStuRNPD4Euxjw0Qgb1RA4/lJx4WbB49C791
	/QZZ0QK6dtY/iSKO2Cbb2yMYWF1Ah8GCn/bs0l1tjNAlIGPkEenmn+AtOd01N5mtN2x2xxUX42T
	26Zy8dc1d/O283UVc7Lm4siufVztIyRyKjyPrism9V6IUuykiZiHCyCYMAD4SOGRs=
X-Received: by 2002:a05:6102:548f:b0:7c3:83a9:edcd with SMTP id ada2fe7eead31-7cb397160f4mr227448137.3.1791515016575;
        Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003ae1577sm814626241.0.2026.10.08.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Fri,  9 Oct 2026 00:03:27 -0300
Message-ID: <20261009030328.3062630-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923162839.1368073-1-qwe.aldo@gmail.com>
References: <20260923162839.1368073-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

Friendly ping on this v2, sent September 23.  It fixes the dword/byte
mismatch in the ATOM PS index bounds check in atom_get_src_int() and
atom_put_dst() -- the sibling of the calltable underflow fix you
already applied.

v2 also corrects the pr_info() messages to print ps_size/4 (dwords)
instead of ps_size (bytes), per Sashiko review on v1.

Thanks,
Aldo
