Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849214883F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970037; cv=none; b=jFhwDmc7emJnkViwsWjIDS/QEkYyTDKlh+DzMGbOUL6FCDFSgRT12ZylebhiXtgugVCs7ZE42Qbo9nKzoS9sWCbPHNT7FGURpWQV/y7mAEQBvPeiRcCcucii7LkjbcAg/JF510SjJo8WlGvAW5wQ76lS6vFn2J6fq97P5pFf3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970037; c=relaxed/simple;
	bh=dnYOdd2LgNEuCY0PVz9TKZhSPl1zRmV4f+pAImvNcyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ets1MZBXoE3fiPs5hZ4mbZ7jfCNUIlBJAoxozqKdSlUujKpeo/XmtcnayFepi5VTSd9Sh0BwPJZCxALGhWHpBgd27f2hPwINZjWt7uIdnTk2ky3Il86AHhXCfCLY0gda0G95x39BCkpoW+e6meKCZgX+0mpJ9OhnRNhIOUCIPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XA3dzJwU; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XA3dzJwU"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so7822095c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970035; x=1791574835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6OS7kHnRAUFDH89g48qhMuuszS5BgPSQDnnJTJS0d4=;
        b=XA3dzJwUHqfs4H0XvJc9EejFouOCQsj0kNK2u1rTn12i+vLIpYN1bLA1JPBcmibBAs
         oAUm6s/VmBSaRCUl1cLlJzRE2l2s5hh7JTt2Rmd9FuBKx1A7Lz53WhP0ivOMB6fgnmj3
         xOUwMb9dWkum3KZREx6kTep714OMWgQZtzKCA8SzHr/PwLhUDKX1c//YtAS+Uc/gNrls
         Vwve1QBw4DG6fS6+IvmOgxaDbgc1mt1hBDTRD00HJ/tl/9CRo0XVpdjJLjzsq1ZFQ+LM
         dCJopnHNwedGg/LxFY1xpPJAguo1QnbUM5P7oPofhGWZeeWcxM4VUIL14figIu2Nbvwu
         Y+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970035; x=1791574835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6OS7kHnRAUFDH89g48qhMuuszS5BgPSQDnnJTJS0d4=;
        b=pNYqChYd2fBuj7UaobsXl28ca8dXD2Uc2UmKS1/GfHsac8L3Cgs25whxqE/WTxQgSn
         jtzdkV+DBKfw3TD6BRXKE4SdBdg8xJAkvMkxDKHiDPjEKcs9clJqFPd5u0Se+WSsNTAu
         b+k1X1DhOSmbNXLhRvY09GyxtQbFKFF4y6Gqd60pl4jfG9B55Bo8E3dfpsmrN+7RVpfR
         jKhTngl1kuJ0FobctYX05p7DFY2d9HCS2QwxTqWRoTXAOQaZNcZ3zuzIaeK2zZqmB1OE
         2w+vHYA4r8PAXZ7LEOKIWVQkzgTHjeOWG0T3Q9inr+IFIqP1sQbH+DokOAnMq+ty5qe+
         WBbg==
X-Gm-Message-State: AFuF++mi6WJJTxdEL/hCYPV1AXkvRjixXvLrzxEF5WAbKzYQX8LUXmwg
	htOPFYjRzkHP1HzQKspq40j7wrBYskufkST5n3V+hr9Y00FCRiHbjwYypvjRmeEQPpRjDlsMLGd
	3SGPqP7Pclw==
X-Gm-Gg: AYBFou0rqvynQd03LE1gNO3areL33RLIn2kKQDcmLmfX/QScJxw3C59fStWBSQoaacH
	gEQjHeG2kXXLEAg4zNKLR67d7qd0+lUkOfI1F+iSEpRl0Avey/ECTRTthSv1CLCFJDRlPjWLUu/
	f5HJPb+dOUQoYurf4K+OV3ehwba/jaHlrR+sJ6TZcvLmcOp82wuFuNtc1ZrKQYbxbXs1HyrsWTk
	v9Kw+RCgCfSIhM+sUkxFRJcKpb39MRsQBuoA+5RUmVJcB+7jrq6P7V1Zon33zztsGR1CQKf/dGf
	zGEY3MGd8HUdt8HHSFaOKwCx8LAkMXR5T3vSmsBMBKLtshTOyVMx6kBkQHcVronUa38Fs6WLmMt
	X5KKUlLGYDzCVw5sfTS4EZajZBG4dxq180OveTVjDpSrGwF08D4dn0KInWZQsgfZjbIcCNfB0qO
	qA7ybSX/nI3LQbjkFjZSpsdr0URD/wFzypTCtZuIMWCqkNi87C39GVx9HjLj65v4C0f25KWNMvA
	i5unQGbCrRhQloZV9kYoxDAWD2jVeWQ+4SaBS80+w1HMHSgCOzZSzLMGwltNCe/xVrOpgfEMNT3
	Hk5fhA==
X-Received: by 2002:a05:701b:2610:b0:147:a685:9125 with SMTP id a92af1059eb24-14f58fd2a97mr3391373c88.2.1790970035055;
        Fri, 02 Oct 2026 12:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f47a57592sm7450113c88.17.2026.10.02.12.40.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:40:34 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 6.1.y 0/2] drm/i915/hdcp: guard both capability checks
Date: Fri,  2 Oct 2026 15:40:25 -0400
Message-ID: <20261002194030.20489-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and i915 maintainers,

Patch 1 alone is not enough on 6.1.y: intel_hdcp_info() calls
intel_hdcp_capable() and then intel_hdcp2_capable(), so the debugfs NULL
dereference moves to the second call. Patch 2 is the companion fix that
path needs, a backport of upstream commit d34f4f058edf ("drm/i915/hdcp:
Add encoder check in hdcp2_get_capability") with the guard in the common
intel_hdcp2_capable() helper, where 6.1.y still does the lookup. This
mirrors the 2-patch series picked up for 6.6.y, and both fixes are
already present in 6.12.y, 6.18.y, and 7.2.y. Could you please queue both
patches for 6.1.y?

AI assistance: An LLM helped adapt and validate both patches; I reviewed
the resulting code and validation evidence.

Thanks,
Artem Dinaburg

Series:
  1. drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
  2. drm/i915/hdcp: Add encoder check in hdcp2_get_capability
