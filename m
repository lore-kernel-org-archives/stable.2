Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A0468C2D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005164; cv=none; b=C3X3yQazPg1aUnR1TinYo5/0vBaw0sbWQpXTXZIvSTmjHpCIX0veXAoENlJen9X24a6TOkTbEZX9DHaWNUIcBegotYGhvrYkg1T9tCdubojrEct2iA2M4BOz3ut60gHM0r3wmDb4yuowt/+vCC4+HwNi7rkaF4qToesdG96r5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005164; c=relaxed/simple;
	bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhkmkp8K6V16gFve0YZSiFDO8RYFMC2E1bsaluA3OoZDIcoyHY94Qc1CL1LDIMc0ElfYNXgd92SY7Eg7esZWBiLDwT8stfVnXZuXnTu6MsjhONRNeZqbzpw4sux+sLTUfk1wwYSHj66+s4UVhM+iIEi0VKwFXG/t/2V86wyDclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=faJxll+V; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="faJxll+V"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3550c917fd3so1857476eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005161; x=1792609961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=;
        b=faJxll+VuILK77EN3dLjSVc/kLOpn+vXNlgBT9DMQgMJQ3GJe5pw6V9j4fwMnL6Kpd
         0uBC0pMI/pCzrZJMTUf31Zn/hX9vcejhP/vK6kwscIoWP62XvnG2NEmvQjMhvxSt360D
         MKxdsOVTJnn4oxkuOy74WxlZItXYgAvaXZ4FkC36DjvgOM2gA/+X+HS4XuzVm8gn+gpr
         FXDdv0OGAV/7B6S7UhSch0g78FdkTFoNrEyGt6vGt4EeKajpz2cTNr+1gvljQ7Axy8Tn
         ibXqlQTvJ3zuhZqUxVv8MKd8fVHNeuNaHpxNEdpcxK+atcI4HHbtbmSIMeNXiggzYkGA
         wsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005161; x=1792609961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRta59JtulZeIsykJD35tM5ia0Lq/sCYG19PMeRfN3w=;
        b=fiAdZ+A8pK4rJMx1k9Rwqa1GrGf8FrPREMeC2WIjADs2nyyhyYBqu/o1DqeKX8U0+A
         Ek6RcWDaloC2P58o7928p85BpurfgpQcDmixA92bEu4cmB5icVyEow3yNl+g29YwIOu9
         +idCqJ8V0gEawaC2g3WR2iaaIpNnJy44o2AxCjSbgbep7DRMZX7D9i7Ydwu3Q9j7hOGN
         zb9E38YvV1QxC26aF8hxJMDP3h2Yb+Yym1s98oJ2Avc5Wx56O2wxU0Glt2XI3hDwY0Zv
         kYKfVAS/zERYoWksCaKMdX5hNVszcL25yNyNRHcWzsMlMyWcuRPCQlEFFMu9wmO3qWcW
         6WMQ==
X-Gm-Message-State: AFq9FYIuO/qRG5GqcJM/CdCJkEbu9Xl0yt2CyDljSTenJlEkO+OKcrKC
	gvZEeJCUUw5fHLh1IRO6nUsS5XnVv4IzWZlDSnLQnP7weUUovcynA3QBNIpEVB94e4pjhl/9w33
	BIdCPyHIPCQ==
X-Gm-Gg: AYBFou0DFgeG5tjynEd6IIX5omHJrRzrulCCvAZM33Me59GZTlSLitp93Dp42HA6cFL
	fjh9n7uQLKU+4J2M9JwesavcVR9PMyrhImJbtzC6ixFYE1ncAsa3D13g0NJNOWfm6jjXaR0rSHL
	CBDPNCxJD9eFXJ8nHpXlLjUmsWSXHc7VUP2aJlL2XbAq1AiE8Bj4GRQKoRoQi2Q+xjdUpgDJHAE
	3N+iTbMLOY20d1q735QASa3MDOS37L0Jrv5liMNEZQQLxt5lPhDnPNqRldBJwN02xguqK+Nx+fP
	y47OTkraLisB5wfM935DYbgd56BtHGxwcTJo3gYjb9vtOvYCEboY2/KBTLtwStIFdMQOffYFQvP
	n5PLYd8+rRlAADPQ7Khw7QfNR+FLhgOQIH8BxJ2oA5YIZuLWTvRs0ELl1KucJi+qfgebBH10i1f
	sr0uWmoJWBLp8gcmolaonpJX6rVkIfXmaInoW/ASD0odzCHfg6bOmm9tm0D7y7tdoQKgz3hcq/6
	KAjF6cesy28oascXqW08Yy0nkvW7CR8jzZ1lRi/s979qM96mAc9xfkV3Fq2s/LWcZDYZnY=
X-Received: by 2002:a05:7300:caa:b0:35c:ceb0:8bf9 with SMTP id 5a478bee46e88-35cceb09059mr9595489eec.38.1792005161316;
        Wed, 14 Oct 2026 12:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm54329888eec.28.2026.10.14.12.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:12:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	cel@kernel.org,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	neil@brown.name,
	sagi@grimberg.me
Subject: [PATCH 6.6.y 0/2] CVE-2025-38264: backport fix series
Date: Wed, 14 Oct 2026 15:12:34 -0400
Message-ID: <20261014191236.23696-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2025-38264 to 6.6.y.

Apply the patches in this order:
1. llist: add interface to check if a node is on a list. (prerequisite)
2. nvme-tcp: sanitize request list handling (fix)

Patch 1 adds llist helpers to mark an unused node, test its membership,
and restore the unused state after dequeue.

Patch 2 initializes and resets NVMe/TCP request-list membership and
rejects R2T processing while the request remains queued. The code changes
in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
